import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @State private var showAuthSheet = false
    @State private var showPaymentSheet = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.currentUser == nil {
                    // Not signed in
                    ProfileSignInView {
                        showAuthSheet = true
                    }
                } else {
                    // Signed in profile
                    ScrollView {
                        VStack(spacing: 24) {
                            // User Info Section
                            UserInfoSection()
                                .environmentObject(viewModel)
                            
                            // Subscription Section
                            SubscriptionSection(showPaymentSheet: $showPaymentSheet)
                                .environmentObject(viewModel)
                            
                            // Settings Section
                            SettingsSection()
                            
                            // Privacy & Security Section
                            PrivacySection()
                                .environmentObject(viewModel)
                            
                            // About Section
                            AboutSection()
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
        .sheet(isPresented: $showPaymentSheet) {
            PaymentSheet()
                .environmentObject(viewModel)
        }
    }
}

struct ProfileSignInView: View {
    let onSignInTap: () -> Void
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: "person.crop.circle")
                    .font(.system(size: 80))
                    .foregroundColor(.secondary.opacity(0.6))
                
                VStack(spacing: 12) {
                    Text("Sign In to Access Your Profile")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    Text("Sign in to view your account details, subscription status, and personalized settings.")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
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
                    .background(Color("PrimaryBlue"))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: Color("PrimaryBlue").opacity(0.3), radius: 8, x: 0, y: 4)
                }
                .padding(.horizontal, 40)
            }
            
            Spacer()
            
            // Feature highlights
            VStack(spacing: 16) {
                Text("With your account, you can:")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 12) {
                    ProfileFeatureItem(icon: "chart.line.uptrend.xyaxis", text: "Track your analysis history")
                    ProfileFeatureItem(icon: "icloud.and.arrow.up", text: "Sync across all devices")
                    ProfileFeatureItem(icon: "gear", text: "Customize app settings")
                    ProfileFeatureItem(icon: "creditcard.circle", text: "Manage subscriptions")
                }
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
    }
}

struct ProfileFeatureItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(Color("PrimaryBlue"))
                .frame(width: 20)
            
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
    }
}

struct UserInfoSection: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Avatar and basic info
            HStack(spacing: 16) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color("PrimaryBlue"), Color("AccentViolet")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(viewModel.currentUser?.name.prefix(1).uppercased() ?? "U")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.currentUser?.name ?? "User")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text(viewModel.currentUser?.email ?? "user@example.com")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.subscriptionStatus.displayName)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color("PrimaryBlue"))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            Capsule()
                                .fill(Color("PrimaryBlue").opacity(0.1))
                        )
                }
                
                Spacer()
                
                Button(action: signOut) {
                    Text("Sign Out")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.secondary.opacity(0.1))
                        )
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    private func signOut() {
        viewModel.signOut()
        viewModel.subscriptionStatus = .free
    }
}

struct SubscriptionSection: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @Binding var showPaymentSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Subscription")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(spacing: 12) {
                HStack {
                    Text("Current Plan:")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(subscriptionDisplayText)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Text("Status:")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text("Active")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color("SuccessGreen"))
                }
            }
            
            HStack(spacing: 12) {
                if viewModel.subscriptionStatus != .free {
                    Button("Manage Subscription") {
                        // Open subscription management
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("PrimaryBlue"), lineWidth: 1)
                    )
                } else {
                    Button("Upgrade Plan") {
                        showPaymentSheet = true
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color("PrimaryBlue"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
    }
    
    private var subscriptionDisplayText: String {
        switch viewModel.subscriptionStatus {
        case .free:
            return "Free (5 analyses)"
        case .monthly:
            return "Monthly ($2.00/month)"
        case .lifetime:
            return "Lifetime Access"
        }
    }
}

struct SettingsSection: View {
    @State private var autoSuggestResponses = true
    @State private var detailedAnalysis = false
    @State private var saveHistory = true
    @State private var notifications = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Settings")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(spacing: 16) {
                SettingToggleRow(
                    title: "Auto-suggest neutral responses",
                    description: "Show suggested responses after analysis",
                    isOn: $autoSuggestResponses
                )
                
                SettingToggleRow(
                    title: "Show detailed analysis",
                    description: "Display additional pattern insights",
                    isOn: $detailedAnalysis
                )
                
                SettingToggleRow(
                    title: "Save conversation history",
                    description: "Store analysis summaries for tracking",
                    isOn: $saveHistory
                )
                
                SettingToggleRow(
                    title: "Push notifications",
                    description: "Get notified about app updates",
                    isOn: $notifications
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
    }
}

struct SettingToggleRow: View {
    let title: String
    let description: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(Color("PrimaryBlue"))
        }
    }
}

struct PrivacySection: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @State private var showClearAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Privacy & Security")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "shield.checkerboard")
                        .font(.system(size: 16))
                        .foregroundColor(Color("SuccessGreen"))
                    
                    Text("**Privacy First:** Message analysis happens locally on your device. Only conversation summaries are saved for usage tracking.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Button("Clear All History") {
                    showClearAlert = true
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color("DangerRed"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.top, 8)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
        .alert("Clear All History", isPresented: $showClearAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                clearHistory()
            }
        } message: {
            Text("Are you sure you want to clear all conversation history? This action cannot be undone.")
        }
    }
    
    private func clearHistory() {
        viewModel.conversations.removeAll()
        viewModel.usageCount = 0
        // Save to UserDefaults
        UserDefaults.standard.set(0, forKey: "usageCount")
        UserDefaults.standard.removeObject(forKey: "conversations")
    }
}

struct AboutSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("About ManipulatorAI")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("ManipulatorAI is designed to help people recognize potential manipulation in messages. While our analysis can identify common patterns, always trust your instincts and seek professional help if you feel unsafe.")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
                
                VStack(spacing: 8) {
                    AboutInfoRow(label: "Version", value: "1.0.0")
                    AboutInfoRow(label: "Pattern Database", value: "15+ Tactics")
                    AboutInfoRow(label: "Privacy", value: "Local Analysis")
                    AboutInfoRow(label: "Support", value: "help@manipulatorai.com")
                }
                .padding(.top, 8)
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
    }
}

struct AboutInfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.primary)
        }
    }
}

struct PaymentSheet: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                VStack(spacing: 16) {
                    Text("Choose Your Plan")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("You've used all your free analyses. Select a plan to continue:")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                VStack(spacing: 16) {
                    // Monthly Plan
                    PaymentPlanCard(
                        title: "Monthly Plan",
                        price: "$2.00/month",
                        features: [
                            "Unlimited analyses",
                            "Conversation history",
                            "Priority support"
                        ],
                        color: Color("PrimaryBlue"),
                        isRecommended: false
                    ) {
                        selectPlan(.monthly)
                    }
                    
                    // Lifetime Plan
                    PaymentPlanCard(
                        title: "Lifetime Access",
                        price: "$30.00",
                        subtitle: "Save $90+ vs monthly",
                        features: [
                            "Unlimited analyses forever",
                            "Conversation history",
                            "Priority support",
                            "Future feature updates"
                        ],
                        color: Color("AccentOrange"),
                        isRecommended: true
                    ) {
                        selectPlan(.lifetime)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, 20)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func selectPlan(_ plan: SubscriptionStatus) {
        // Simulate payment success
        viewModel.subscriptionStatus = plan
        presentationMode.wrappedValue.dismiss()
        
        // Show success feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
}

struct PaymentPlanCard: View {
    let title: String
    let price: String
    let subtitle: String?
    let features: [String]
    let color: Color
    let isRecommended: Bool
    let onSelect: () -> Void
    
    init(title: String, price: String, subtitle: String? = nil, features: [String], color: Color, isRecommended: Bool, onSelect: @escaping () -> Void) {
        self.title = title
        self.price = price
        self.subtitle = subtitle
        self.features = features
        self.color = color
        self.isRecommended = isRecommended
        self.onSelect = onSelect
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if isRecommended {
                Text("Best Value!")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(color)
                    .clipShape(Capsule())
            }
            
            VStack(spacing: 8) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
                Text(price)
                    .font(.system(size: 28, weight: .black))
                    .foregroundColor(color)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(Color("SuccessGreen"))
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                ForEach(features, id: \.self) { feature in
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(Color("SuccessGreen"))
                        
                        Text(feature)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
            }
            
            Button(action: onSelect) {
                Text("Choose \(title)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: color.opacity(0.3), radius: 8, x: 0, y: 4)
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isRecommended ? color : .clear, lineWidth: 2)
                )
                .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
        )
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ManipulatorAIViewModel())
    }
}