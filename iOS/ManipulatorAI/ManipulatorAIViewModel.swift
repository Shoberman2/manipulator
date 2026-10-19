import Foundation
import SwiftUI
import Auth

class ManipulatorAIViewModel: ObservableObject {
    @Published var detectedTactics: [ManipulationTactic] = []
    @Published var usageCount: Int = 0
    @Published var conversations: [ConversationSummary] = []
    @Published var currentUser: User?
    @Published var subscriptionStatus: SubscriptionStatus = .free
    @Published var authError: String?
    @Published var isAuthLoading = false

    private let maxFreeUsage = 5

    init() {
        loadUserData()
        listenToAuthStateChanges()
    }

    func analyzeMessage(_ message: String) {
        let tactics = detectManipulationTactics(in: message)
        detectedTactics = tactics

        // Save conversation
        let conversation = ConversationSummary(
            id: UUID(),
            date: Date(),
            preview: String(message.prefix(100)),
            tacticsDetected: tactics.count,
            tacticNames: tactics.map { $0.name }
        )

        conversations.insert(conversation, at: 0)
        usageCount += 1

        saveUserData()
    }

    private func detectManipulationTactics(in message: String) -> [ManipulationTactic] {
        var detectedTactics: [ManipulationTactic] = []
        let lowercaseMessage = message.lowercased()

        for tactic in ManipulationTactic.allTactics {
            if tactic.patterns.contains(where: { pattern in
                lowercaseMessage.range(of: pattern, options: .regularExpression) != nil
            }) {
                detectedTactics.append(tactic)
            }
        }

        return detectedTactics
    }

    func canAnalyze() -> Bool {
        return subscriptionStatus != .free || usageCount < maxFreeUsage
    }

    func remainingFreeUsage() -> Int {
        return max(0, maxFreeUsage - usageCount)
    }

    // MARK: - Auth

    private func listenToAuthStateChanges() {
        Task { [weak self] in
            for await (event, session) in supabase.auth.authStateChanges {
                guard let self = self else { return }
                await MainActor.run {
                    if let supabaseUser = session?.user {
                        let name = supabaseUser.userMetadata["full_name"]?.stringValue
                            ?? supabaseUser.email?.components(separatedBy: "@").first
                            ?? "User"
                        self.currentUser = User(
                            id: supabaseUser.id.uuidString,
                            name: name,
                            email: supabaseUser.email ?? ""
                        )
                    } else {
                        self.currentUser = nil
                    }
                }
            }
        }
    }

    func signUp(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            authError = "Please enter both email and password."
            return
        }
        isAuthLoading = true
        authError = nil
        Task { [weak self] in
            do {
                let response = try await supabase.auth.signUp(email: email, password: password)
                await MainActor.run {
                    self?.isAuthLoading = false
                    // If email confirmation is required, the session will be nil
                    if response.session == nil {
                        self?.authError = "Check your email to confirm your account."
                    }
                }
            } catch {
                await MainActor.run {
                    self?.isAuthLoading = false
                    self?.authError = error.localizedDescription
                }
            }
        }
    }

    func signIn(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            authError = "Please enter both email and password."
            return
        }
        isAuthLoading = true
        authError = nil
        Task { [weak self] in
            do {
                try await supabase.auth.signIn(email: email, password: password)
                await MainActor.run {
                    self?.isAuthLoading = false
                }
            } catch {
                await MainActor.run {
                    self?.isAuthLoading = false
                    self?.authError = error.localizedDescription
                }
            }
        }
    }

    func signInWithApple(idToken: String, nonce: String) {
        isAuthLoading = true
        authError = nil
        Task { [weak self] in
            do {
                try await supabase.auth.signInWithIdToken(
                    credentials: .init(provider: .apple, idToken: idToken, nonce: nonce)
                )
                await MainActor.run {
                    self?.isAuthLoading = false
                }
            } catch {
                await MainActor.run {
                    self?.isAuthLoading = false
                    self?.authError = error.localizedDescription
                }
            }
        }
    }

    func signOut() {
        Task { [weak self] in
            do {
                try await supabase.auth.signOut()
            } catch {
                await MainActor.run {
                    self?.authError = error.localizedDescription
                }
            }
        }
    }

    // MARK: - Persistence

    private func loadUserData() {
        usageCount = UserDefaults.standard.integer(forKey: "usageCount")

        if let conversationsData = UserDefaults.standard.data(forKey: "conversations"),
           let decodedConversations = try? JSONDecoder().decode([ConversationSummary].self, from: conversationsData) {
            conversations = decodedConversations
        }
    }

    private func saveUserData() {
        UserDefaults.standard.set(usageCount, forKey: "usageCount")

        if let encoded = try? JSONEncoder().encode(conversations) {
            UserDefaults.standard.set(encoded, forKey: "conversations")
        }
    }
}

struct ManipulationTactic: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let patterns: [String]
    let neutralResponses: [String]

    static let allTactics: [ManipulationTactic] = [
        ManipulationTactic(
            name: "Gaslighting",
            description: "Making you question your own memory, perception, or sanity through systematic doubt.",
            patterns: [
                "you're (crazy|insane|imagining things|being dramatic|overreacting)",
                "that never happened",
                "you're remembering it wrong",
                "you're too sensitive",
                "stop being so emotional",
                "you're making things up",
                "you have a bad memory",
                "you're delusional",
                "i never said that",
                "you're losing your mind"
            ],
            neutralResponses: [
                "I understand we have different perspectives on this situation.",
                "I'd like to take some time to think about what you've said.",
                "I appreciate you sharing your viewpoint with me."
            ]
        ),

        ManipulationTactic(
            name: "Guilt Tripping",
            description: "Emotional leverage through obligation and sacrifice narratives.",
            patterns: [
                "after everything i've done for you",
                "you're being selfish",
                "if you really cared about me",
                "you're hurting me by",
                "i sacrificed so much for you",
                "you owe me",
                "how could you do this to me",
                "i gave up everything for you",
                "this is how you repay me",
                "you're so ungrateful",
                "think about what i've done"
            ],
            neutralResponses: [
                "I understand this is important to you. Let me consider what you've said.",
                "I value our relationship and want to find a solution that works for both of us.",
                "I appreciate everything you've done. I need some time to think about this."
            ]
        ),

        ManipulationTactic(
            name: "Isolation Tactics",
            description: "Strategic separation from support networks through relationship undermining.",
            patterns: [
                "your friends don't really care about you",
                "your family is toxic",
                "i'm the only one who truly understands you",
                "they're just trying to turn you against me",
                "you don't need anyone else",
                "why do you need to see them"
            ],
            neutralResponses: [
                "I value the relationships in my life and want to maintain them.",
                "I appreciate your concern, but I'd like to make my own decisions about my relationships.",
                "Different people bring different perspectives to my life, which I find valuable."
            ]
        ),

        ManipulationTactic(
            name: "Love Bombing",
            description: "Overwhelming positive attention to create rapid emotional attachment.",
            patterns: [
                "you're the only one for me",
                "i've never felt this way before",
                "we're soulmates",
                "you complete me",
                "i can't live without you",
                "you're perfect"
            ],
            neutralResponses: [
                "Thank you for sharing your feelings. I'd like to take things at a comfortable pace.",
                "I appreciate your kind words. I believe healthy relationships develop gradually.",
                "I'm glad you care about me. Let's continue getting to know each other better."
            ]
        ),

        ManipulationTactic(
            name: "Threats & Intimidation",
            description: "Fear-based compliance through consequence escalation.",
            patterns: [
                "you'll regret this",
                "i'll ruin you",
                "no one will believe you",
                "i'll make your life hell",
                "you'll be sorry",
                "i know where you live",
                "i'll hurt myself if you"
            ],
            neutralResponses: [
                "I don't feel comfortable continuing this conversation right now.",
                "I think we both need some space to cool down.",
                "I'd prefer to discuss this when we can both communicate respectfully."
            ]
        ),

        ManipulationTactic(
            name: "Emotional Blackmail",
            description: "Extreme consequence threats to manipulate decisions.",
            patterns: [
                "if you leave me i'll",
                "you'll destroy me if",
                "i can't live without you",
                "i'll hurt myself if you",
                "you're killing me",
                "my life will be over",
                "i'll die if you",
                "you're all i have",
                "without you i'm nothing"
            ],
            neutralResponses: [
                "I care about you, but I need to make decisions that are right for me too.",
                "I think it would be helpful if you spoke to a counselor about these feelings.",
                "I want what's best for both of us, which means making healthy choices."
            ]
        ),

        ManipulationTactic(
            name: "Control & Monitoring",
            description: "Autonomy restriction through monitoring and permission-seeking.",
            patterns: [
                "who were you talking to",
                "show me your phone",
                "you can't go there",
                "i need to know where you are at all times",
                "you're not allowed to",
                "you need my permission"
            ],
            neutralResponses: [
                "I value my privacy and independence in our relationship.",
                "I'm comfortable sharing information when I choose to.",
                "I'd like to maintain some autonomy in my daily decisions."
            ]
        ),

        ManipulationTactic(
            name: "Blame Shifting",
            description: "Responsibility deflection through victim attribution.",
            patterns: [
                "you made me do it",
                "it's your fault",
                "you drove me to this",
                "look what you made me do",
                "i wouldn't have to if you didn't",
                "you started it",
                "this is all because of you",
                "you're responsible for this"
            ],
            neutralResponses: [
                "I think we each need to take responsibility for our own actions.",
                "I'd like to focus on finding solutions rather than assigning blame.",
                "Let's work together to address this issue constructively."
            ]
        ),

        ManipulationTactic(
            name: "Minimizing & Dismissing",
            description: "Downplaying your feelings, experiences, or concerns to make them seem unimportant.",
            patterns: [
                "you're (blowing this out of proportion|making a big deal out of nothing)",
                "it's not that (serious|bad|big of a deal)",
                "you're overreacting",
                "stop making a mountain out of a molehill",
                "it was just a joke",
                "you can't take a joke",
                "why are you so dramatic",
                "it's not like i",
                "you're being ridiculous",
                "calm down it's nothing"
            ],
            neutralResponses: [
                "My feelings about this are valid, and I'd like them to be acknowledged.",
                "I'd appreciate it if we could discuss this without dismissing how I feel.",
                "I understand you see it differently, but this matters to me."
            ]
        ),

        ManipulationTactic(
            name: "Triangulation",
            description: "Bringing a third party into the dynamic to undermine, validate, or create jealousy.",
            patterns: [
                "everyone agrees with me",
                "everyone thinks you're",
                "nobody else has a problem with",
                "my (ex|friend|mom|dad|coworker) would never",
                "other people think you're",
                "i told .* about this and they said",
                "even your (friend|mom|dad|sister|brother) thinks",
                "ask anyone.* they'll tell you",
                "you're the only one who"
            ],
            neutralResponses: [
                "I'd prefer to keep this between us rather than involving others.",
                "I'd like to focus on how we each feel rather than what others think.",
                "Our relationship is between us, and I'd like to resolve this together."
            ]
        ),

        ManipulationTactic(
            name: "Silent Treatment",
            description: "Withholding communication as punishment or to exert control.",
            patterns: [
                "i'm not talking to you",
                "i have nothing to say to you",
                "don't talk to me",
                "i'm done talking",
                "you don't deserve a response",
                "figure it out yourself",
                "i'm ignoring you",
                "talk to the hand",
                "you know what you did",
                "when you figure out what you did wrong"
            ],
            neutralResponses: [
                "I understand you may need space, but I'd like to set a time to talk.",
                "Withdrawing from conversation makes it hard to resolve things together.",
                "I'm here when you're ready to talk. I hope we can work through this."
            ]
        ),

        ManipulationTactic(
            name: "Financial Control",
            description: "Using money or financial resources as a tool for power and control.",
            patterns: [
                "i pay for everything",
                "you can't afford to leave",
                "you'd be nothing without my money",
                "i control the money",
                "you don't need your own",
                "you're wasting my money",
                "i'll cut you off",
                "you'd have nothing without me",
                "who pays the bills around here",
                "you need to ask me before you spend"
            ],
            neutralResponses: [
                "I believe financial decisions should be made together as equals.",
                "I'd like to have a fair and transparent conversation about finances.",
                "Financial independence is important to me, and I'd like to work toward that."
            ]
        ),

        ManipulationTactic(
            name: "Public Humiliation",
            description: "Deliberately embarrassing or demeaning someone in front of others.",
            patterns: [
                "you're embarrassing yourself",
                "everyone is laughing at you",
                "do you know how stupid you (look|sound)",
                "i can't believe you just said that in front of",
                "you're making a fool of yourself",
                "don't embarrass me",
                "everyone saw what you did",
                "you should be ashamed",
                "i'll tell everyone about"
            ],
            neutralResponses: [
                "I'd prefer to discuss personal matters in private.",
                "I don't think it's appropriate to bring this up in front of others.",
                "I'd appreciate being treated with respect, especially around other people."
            ]
        ),

        ManipulationTactic(
            name: "Future Faking",
            description: "Making promises about the future with no intention of following through.",
            patterns: [
                "i promise i'll change",
                "things will be different this time",
                "just give me one more chance",
                "i'll never do it again",
                "next time i'll",
                "i swear it won't happen again",
                "once .* things will be better",
                "just wait until",
                "trust me.* it's going to",
                "i'm going to make it up to you"
            ],
            neutralResponses: [
                "I appreciate the intention. I'd like to see consistent actions over time.",
                "I'd prefer to focus on what's happening now rather than future promises.",
                "Actions speak louder than words. Let's focus on what we can do today."
            ]
        ),

        ManipulationTactic(
            name: "Projection",
            description: "Attributing one's own negative behaviors or feelings onto someone else.",
            patterns: [
                "you're the one who",
                "you always .* not me",
                "you're the (liar|cheater|manipulator|abuser)",
                "you're projecting",
                "that's what you do.* not me",
                "you're describing yourself",
                "look in the mirror",
                "you're the problem.* not me",
                "you're the manipulative one",
                "stop accusing me of what you do"
            ],
            neutralResponses: [
                "I'd like to focus on the specific issue at hand rather than deflecting.",
                "Let's each take responsibility for our own behavior.",
                "I'd prefer to discuss what happened without turning things around."
            ]
        ),

        ManipulationTactic(
            name: "Word Salad / Circular Arguments",
            description: "Using confusing, contradictory, or circular language to disorient and exhaust.",
            patterns: [
                "that's not what i meant.* what i meant was.* but you",
                "you're twisting my words",
                "i never said.* what i said was",
                "you're putting words in my mouth",
                "that's not the point.* the point is",
                "you're not listening.* what i'm saying is",
                "you don't understand.* let me explain.* no that's not",
                "but what about when you",
                "we already talked about this",
                "you're going in circles"
            ],
            neutralResponses: [
                "I'd like to pause and focus on one specific topic at a time.",
                "I'm feeling confused by this conversation. Can we slow down?",
                "Let's try to address one point clearly before moving to the next."
            ]
        )
    ]
}

struct ConversationSummary: Identifiable, Codable {
    let id: UUID
    let date: Date
    let preview: String
    let tacticsDetected: Int
    let tacticNames: [String]
}

struct User: Codable, Equatable {
    let id: String
    let name: String
    let email: String
}

enum SubscriptionStatus: String, Codable, CaseIterable {
    case free = "free"
    case monthly = "monthly"
    case lifetime = "lifetime"

    var displayName: String {
        switch self {
        case .free: return "Free Plan"
        case .monthly: return "Monthly Subscription"
        case .lifetime: return "Lifetime Access"
        }
    }
}
