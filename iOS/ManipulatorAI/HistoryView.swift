import SwiftUI
import AuthenticationServices
import CryptoKit

struct HistoryView: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @State private var showAuthSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.currentUser == nil {
                    // Auth Required
                    AuthRequiredView {
                        showAuthSheet = true
                    }
                } else {
                    // History Content
                    ScrollView {
                        VStack(spacing: 24) {
                            // Usage Stats
                            UsageStatsView()
                                .environmentObject(viewModel)
                            
                            // Conversations List
                            ConversationsListView()
                                .environmentObject(viewModel)
                        }
                        .padding(.bottom, 100) // Bottom tab bar spacing
                    }
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showAuthSheet) {
            AuthenticationSheet()
                .environmentObject(viewModel)
        }
    }
}

struct AuthRequiredView: View {
    let onSignInTap: () -> Void
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color("PrimaryBlue"))
                
                VStack(spacing: 12) {
                    Text("Sign In Required")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("Please sign in to view your conversation history and track your analyses.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                Button(action: onSignInTap) {
                    HStack(spacing: 12) {
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 18, weight: .semibold))

                        Text("Sign In")
                            .font(.system(size: 16, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        LinearGradient(
                            colors: [Color("PrimaryBlue"), Color("AccentViolet")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: Color("PrimaryBlue").opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 40)
                .padding(.top, 8)
            }
            
            Spacer()
            
            // Benefits
            VStack(alignment: .leading, spacing: 12) {
                Text("Benefits of signing in:")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 8) {
                    BenefitItem(icon: "clock.arrow.circlepath", text: "Track conversation history")
                    BenefitItem(icon: "icloud.and.arrow.up", text: "Sync across devices")
                    BenefitItem(icon: "creditcard.circle", text: "Manage subscription")
                    BenefitItem(icon: "chart.line.uptrend.xyaxis", text: "Personalized insights")
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
}

struct BenefitItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("SuccessGreen"))
                .frame(width: 20)
            
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
    }
}

struct UsageStatsView: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Stats Cards
            HStack(spacing: 12) {
                StatCard(
                    title: "Total Analyses",
                    value: "\(viewModel.usageCount)",
                    color: Color("PrimaryBlue")
                )
                
                StatCard(
                    title: "Free Uses Left",
                    value: "\(viewModel.remainingFreeUsage())",
                    color: Color("SuccessGreen")
                )
                
                StatCard(
                    title: "Tactics Found",
                    value: "\(viewModel.conversations.reduce(0) { $0 + $1.tacticsDetected })",
                    color: Color("DangerRed")
                )
            }
            
            // Upgrade Prompt (if needed)
            if !viewModel.canAnalyze() {
                UpgradePromptCard()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(color)
            
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        )
    }
}

struct UpgradePromptCard: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Image(systemName: "crown.fill")
                    .font(.system(size: 20))
                    .foregroundColor(Color("AccentYellow"))
                
                Text("Unlock Unlimited Access")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                
                Spacer()
            }
            
            Text("You've used all your free analyses. Choose a plan to continue:")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 12) {
                UpgradeButton(
                    title: "Monthly",
                    price: "$2.00/month",
                    color: Color("PrimaryBlue")
                )
                
                UpgradeButton(
                    title: "Lifetime",
                    price: "$30.00",
                    subtitle: "Best Value!",
                    color: Color("AccentOrange")
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color("AccentYellow").opacity(0.1), Color("AccentOrange").opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("AccentOrange").opacity(0.3), lineWidth: 1)
                )
        )
    }
}

struct UpgradeButton: View {
    let title: String
    let price: String
    let subtitle: String?
    let color: Color
    
    init(title: String, price: String, subtitle: String? = nil, color: Color) {
        self.title = title
        self.price = price
        self.subtitle = subtitle
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: 4) {
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(Color("AccentOrange"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(Color("AccentOrange").opacity(0.2))
                    )
            }
            
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
            
            Text(price)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white.opacity(0.9))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct ConversationsListView: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Past Conversations")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
            
            if viewModel.conversations.isEmpty {
                EmptyConversationsView()
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.conversations, id: \.id) { conversation in
                        ConversationCard(conversation: conversation)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct EmptyConversationsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bubble.left.and.bubble.right")
                .font(.system(size: 48))
                .foregroundColor(.secondary.opacity(0.6))
            
            Text("No conversations yet")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
            
            Text("Start by analyzing a message!")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
    }
}

struct ConversationCard: View {
    let conversation: ConversationSummary
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                Text(dateFormatter.string(from: conversation.date))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if conversation.tacticsDetected > 0 {
                    Text("\(conversation.tacticsDetected) tactic\(conversation.tacticsDetected == 1 ? "" : "s")")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color("DangerRed"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(Color("DangerRed").opacity(0.1))
                        )
                }
            }
            
            // Preview
            Text(conversation.preview)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
            
            // Tactic Tags
            if !conversation.tacticNames.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(conversation.tacticNames, id: \.self) { tacticName in
                            Text(tacticName)
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundColor(Color("DangerRed"))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color("DangerRed").opacity(0.1))
                                )
                        }
                    }
                    .padding(.horizontal, 1)
                }
            } else {
                Text("No manipulation detected")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(Color("SuccessGreen"))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("SuccessGreen").opacity(0.1))
                    )
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 2)
        )
    }
}

struct AuthenticationSheet: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var currentNonce: String?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.system(size: 60))
                            .foregroundColor(Color("PrimaryBlue"))

                        Text(isSignUp ? "Create Account" : "Sign In")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)

                        Text("To continue using ManipulatorAI and track your conversation history.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                    }
                    .padding(.top, 24)

                    // Email / Password form
                    VStack(spacing: 16) {
                        TextField("Email", text: $email)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        SecureField("Password", text: $password)
                            .textContentType(isSignUp ? .newPassword : .password)
                            .padding()
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal, 24)

                    // Error display
                    if let error = viewModel.authError {
                        Text(error)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("DangerRed"))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }

                    // Submit button
                    Button(action: submitEmailPassword) {
                        Group {
                            if viewModel.isAuthLoading {
                                ProgressView()
                                    .tint(.white)
                            } else {
                                Text(isSignUp ? "Create Account" : "Sign In")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("PrimaryBlue"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color("PrimaryBlue").opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .disabled(viewModel.isAuthLoading)
                    .padding(.horizontal, 24)

                    // Toggle sign-in / sign-up
                    Button(action: { isSignUp.toggle(); viewModel.authError = nil }) {
                        Text(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(Color("PrimaryBlue"))
                    }

                    // Divider
                    HStack {
                        Rectangle().fill(Color(.systemGray4)).frame(height: 1)
                        Text("or")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                        Rectangle().fill(Color(.systemGray4)).frame(height: 1)
                    }
                    .padding(.horizontal, 24)

                    // Sign in with Apple
                    SignInWithAppleButton(.signIn) { request in
                        let nonce = randomNonceString()
                        currentNonce = nonce
                        request.requestedScopes = [.email, .fullName]
                        request.nonce = sha256(nonce)
                    } onCompletion: { result in
                        handleAppleSignIn(result)
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal, 24)

                    // Benefits
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Benefits of signing in:")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)

                        VStack(alignment: .leading, spacing: 12) {
                            BenefitItem(icon: "clock.arrow.circlepath", text: "Track conversation history")
                            BenefitItem(icon: "icloud.and.arrow.up", text: "Sync across devices")
                            BenefitItem(icon: "creditcard.circle", text: "Manage subscription")
                            BenefitItem(icon: "chart.line.uptrend.xyaxis", text: "Personalized insights")
                        }
                    }
                    .padding(24)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemGray6))
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .onChange(of: viewModel.currentUser) { newValue in
                if newValue != nil {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }

    private func submitEmailPassword() {
        if isSignUp {
            viewModel.signUp(email: email, password: password)
        } else {
            viewModel.signIn(email: email, password: password)
        }
    }

    private func handleAppleSignIn(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            guard let appleCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
                  let identityToken = appleCredential.identityToken,
                  let tokenString = String(data: identityToken, encoding: .utf8),
                  let nonce = currentNonce else {
                viewModel.authError = "Failed to get Apple ID credentials."
                return
            }

            // Capture the user's name (only available on first sign-in)
            if let fullName = appleCredential.fullName {
                let name = [fullName.givenName, fullName.familyName]
                    .compactMap { $0 }
                    .joined(separator: " ")
                if !name.isEmpty {
                    UserDefaults.standard.set(name, forKey: "appleUserFullName")
                }
            }

            viewModel.signInWithApple(idToken: tokenString, nonce: nonce)

        case .failure(let error):
            // ASAuthorizationError.canceled means user dismissed the dialog — not a real error
            if (error as NSError).code != ASAuthorizationError.canceled.rawValue {
                viewModel.authError = error.localizedDescription
            }
        }
    }

    // MARK: - Nonce helpers

    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        return String(randomBytes.map { charset[Int($0) % charset.count] })
    }

    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        return hashedData.compactMap { String(format: "%02x", $0) }.joined()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(ManipulatorAIViewModel())
    }
}