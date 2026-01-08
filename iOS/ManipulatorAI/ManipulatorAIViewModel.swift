import Foundation
import SwiftUI

class ManipulatorAIViewModel: ObservableObject {
    @Published var detectedTactics: [ManipulationTactic] = []
    @Published var usageCount: Int = 0
    @Published var conversations: [ConversationSummary] = []
    @Published var currentUser: User?
    @Published var subscriptionStatus: SubscriptionStatus = .free
    
    private let maxFreeUsage = 5
    
    init() {
        loadUserData()
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

struct User: Codable {
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