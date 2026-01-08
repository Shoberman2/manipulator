import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @State private var messageText = ""
    @State private var isAnalyzing = false
    @State private var showResults = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Section
                    HeroSectionView()
                    
                    // Input Section
                    InputSectionView(
                        messageText: $messageText,
                        isAnalyzing: $isAnalyzing,
                        showResults: $showResults
                    )
                    .environmentObject(viewModel)
                    
                    // Preview Section
                    PreviewSectionView()
                    
                    // Results Section
                    if showResults {
                        ResultsView(tactics: viewModel.detectedTactics)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
            }
            .navigationBarHidden(true)
            .background(
                LinearGradient(
                    colors: [
                        Color("BackgroundLight"),
                        Color.white,
                        Color("BackgroundLight")
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
}

struct HeroSectionView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Impact Stats
            HStack(spacing: 20) {
                StatHighlightView(number: "15+", label: "Manipulation\nTactics")
                StatHighlightView(number: "AI", label: "Powered\nAnalysis")
                StatHighlightView(number: "3s", label: "Instant\nResults")
            }
            .padding(.horizontal)
            
            // Hero Headline
            VStack(spacing: 12) {
                Text("Uncover Hidden")
                    .font(.system(size: 36, weight: .black, design: .default))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, Color("AccentYellow")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("Manipulation")
                    .font(.system(size: 32, weight: .black, design: .default))
                    .foregroundColor(Color("AccentYellow"))
                
                Text("in Any Message")
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("Advanced AI instantly analyzes communication patterns to reveal psychological manipulation tactics and power imbalances.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.85))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
            }
        }
        .padding(.vertical, 40)
        .padding(.horizontal, 20)
        .background(
            ZStack {
                LinearGradient(
                    colors: [
                        Color("PrimaryBlue"),
                        Color("SecondaryPurple"),
                        Color("AccentViolet")
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                // Animated background effects
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .blur(radius: 20)
                    .frame(width: 200, height: 200)
                    .offset(x: -100, y: -50)
                
                Circle()
                    .fill(Color.purple.opacity(0.2))
                    .blur(radius: 30)
                    .frame(width: 150, height: 150)
                    .offset(x: 120, y: 30)
            }
        )
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 24,
                bottomTrailingRadius: 24,
                topTrailingRadius: 0
            )
        )
    }
}

struct StatHighlightView: View {
    let number: String
    let label: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(number)
                .font(.system(size: 24, weight: .black))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Color("AccentOrange"), Color("AccentYellow")],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white.opacity(0.9))
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white.opacity(0.15))
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white.opacity(0.2), lineWidth: 1)
                )
        )
        .scaleEffect(1.0)
        .animation(.easeInOut(duration: 2.0).repeatForever(), value: UUID())
    }
}

struct InputSectionView: View {
    @EnvironmentObject var viewModel: ManipulatorAIViewModel
    @Binding var messageText: String
    @Binding var isAnalyzing: Bool
    @Binding var showResults: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            // Input Header
            VStack(spacing: 12) {
                HStack {
                    Text("🔥")
                        .font(.system(size: 24))
                    Text("Start Your Analysis Now")
                        .font(.system(size: 24, weight: .black))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [Color("DangerRed"), Color("AccentOrange"), Color("AccentYellow")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                }
                
                Text("Paste any message, email, or conversation below. Our AI will reveal manipulation patterns in seconds.")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            
            // Input Container
            VStack(spacing: 20) {
                // Text Input
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [Color("PrimaryBlue"), Color("AccentViolet"), Color("AccentOrange")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: messageText.isEmpty ? 2 : 3
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.white)
                                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                        )
                    
                    TextEditor(text: $messageText)
                        .font(.system(size: 16, weight: .medium))
                        .padding(20)
                        .background(Color.clear)
                        .frame(minHeight: 140)
                        .overlay(
                            Group {
                                if messageText.isEmpty {
                                    VStack {
                                        HStack {
                                            Text("Paste your message here...\n(ex: texts, emails, social media posts)")
                                                .font(.system(size: 16, weight: .medium))
                                                .foregroundColor(.secondary.opacity(0.8))
                                                .padding(.top, 20)
                                                .padding(.leading, 20)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        )
                }
                .frame(height: 180)
                
                // Analyze Button
                Button(action: analyzeMessage) {
                    HStack(spacing: 12) {
                        if isAnalyzing {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(0.8)
                        } else {
                            Text("⚡")
                                .font(.system(size: 20))
                            
                            Text("ANALYZE FOR MANIPULATION")
                                .font(.system(size: 16, weight: .black))
                                .letterSpacing(0.5)
                            
                            Text("→")
                                .font(.system(size: 20, weight: .bold))
                        }
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        ZStack {
                            LinearGradient(
                                colors: [Color("DangerRed"), Color("AccentOrange"), Color("AccentYellow")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            
                            if isAnalyzing {
                                LinearGradient(
                                    colors: [Color("AccentOrange"), Color("AccentYellow")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .opacity(0.8)
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color("DangerRed").opacity(0.4), radius: 15, x: 0, y: 6)
                    .scaleEffect(isAnalyzing ? 0.98 : 1.0)
                    .animation(.easeInOut(duration: 0.1), value: isAnalyzing)
                }
                .disabled(messageText.isEmpty || isAnalyzing)
                .opacity(messageText.isEmpty ? 0.6 : 1.0)
                
                // Promise Text
                Text("✨ **Free Analysis** • Results in 3 seconds • 100% Private")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color("SuccessGreen"))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("SuccessGreen").opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color("SuccessGreen").opacity(0.3), lineWidth: 1)
                            )
                    )
            }
            
            // Trust Indicators
            TrustIndicatorsView()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 20, x: 0, y: 8)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
    }
    
    private func analyzeMessage() {
        guard !messageText.isEmpty else { return }
        
        isAnalyzing = true
        
        // Simulate analysis delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            viewModel.analyzeMessage(messageText)
            isAnalyzing = false
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                showResults = true
            }
        }
    }
}

struct TrustIndicatorsView: View {
    let indicators = [
        ("🛡️", "Private"),
        ("🧠", "AI-Powered"),
        ("⚡", "Instant"),
        ("📊", "15+ Patterns")
    ]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
            ForEach(indicators, id: \.0) { icon, text in
                HStack(spacing: 8) {
                    Text(icon)
                        .font(.system(size: 16))
                    Text(text)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.gray.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray.opacity(0.2), lineWidth: 1)
                        )
                )
            }
        }
    }
}

struct PreviewSectionView: View {
    let previews = [
        ("🎯", "Guilt Manipulation", "\"After everything I've done...\""),
        ("💭", "Gaslighting", "\"You're being too sensitive...\""),
        ("🔒", "Control Tactics", "\"You can't go there...\""),
        ("⚠️", "Emotional Blackmail", "\"I'll hurt myself if...\"")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("See What Our Analysis Reveals:")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primary)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                ForEach(previews, id: \.0) { icon, title, example in
                    VStack(spacing: 12) {
                        Text(icon)
                            .font(.system(size: 28))
                        
                        Text(title)
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text(example)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.secondary)
                            .italic()
                            .multilineTextAlignment(.center)
                    }
                    .padding(16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray.opacity(0.2), lineWidth: 1)
                            )
                    )
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(.gray.opacity(0.05))
        )
        .padding(.horizontal, 16)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ManipulatorAIViewModel())
    }
}