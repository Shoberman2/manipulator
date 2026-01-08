import SwiftUI

struct LearnView: View {
    @State private var selectedTactic: ManipulationTactic?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 16) {
                        Text("Understanding Communication Patterns")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color("PrimaryBlue"), Color("AccentViolet")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .multilineTextAlignment(.center)
                        
                        Text("Learn to recognize manipulation patterns through advanced linguistic analysis. Our system identifies 15+ distinct manipulation tactics by analyzing word patterns, emotional pressure points, and communication structures.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    
                    // Analysis Features
                    AnalysisFeaturesView()
                    
                    // Tactics Grid
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Manipulation Patterns We Detect")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 20)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 1), spacing: 12) {
                            ForEach(ManipulationTactic.allTactics, id: \.id) { tactic in
                                LearnTacticCard(
                                    tactic: tactic,
                                    isSelected: selectedTactic?.id == tactic.id
                                ) {
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        selectedTactic = selectedTactic?.id == tactic.id ? nil : tactic
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Help Resources
                    HelpResourcesView()
                }
                .padding(.bottom, 100) // Bottom tab bar spacing
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
    }
}

struct AnalysisFeaturesView: View {
    let features = [
        (icon: "🧠", title: "Psychological Pattern Recognition", description: "Advanced algorithms detect emotional manipulation techniques and psychological pressure tactics"),
        (icon: "📝", title: "Linguistic Structure Analysis", description: "Examines sentence construction, word choice, and communication flow for manipulation indicators"),
        (icon: "⚖️", title: "Power Dynamic Detection", description: "Identifies language patterns that create imbalanced power dynamics in relationships")
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach(Array(features.enumerated()), id: \.offset) { index, feature in
                HStack(spacing: 16) {
                    Text(feature.icon)
                        .font(.system(size: 32))
                        .frame(width: 60, height: 60)
                        .background(
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color("PrimaryBlue"), Color("AccentViolet")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .shadow(color: Color("PrimaryBlue").opacity(0.3), radius: 8, x: 0, y: 4)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(feature.title)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text(feature.description)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer()
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                )
            }
        }
        .padding(.horizontal, 20)
    }
}

struct LearnTacticCard: View {
    let tactic: ManipulationTactic
    let isSelected: Bool
    let onTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header (always visible)
            Button(action: onTap) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(tactic.name + " Patterns")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                        
                        Text(tactic.description)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isSelected ? "chevron.up.circle.fill" : "chevron.down.circle")
                        .font(.system(size: 24))
                        .foregroundColor(Color("PrimaryBlue"))
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.white)
                        .overlay(
                            HStack {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(
                                        LinearGradient(
                                            colors: [Color("PrimaryBlue"), Color("AccentViolet")],
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(width: 4)
                                Spacer()
                            }
                        )
                        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            // Expanded content
            if isSelected {
                VStack(alignment: .leading, spacing: 16) {
                    // Key indicators
                    VStack(alignment: .leading, spacing: 8) {
                        Text("**Pattern Analysis:** \(tactic.description)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                        
                        Text("**Key Indicators:**")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(Array(tactic.patterns.prefix(3)), id: \.self) { pattern in
                                HStack(alignment: .top, spacing: 8) {
                                    Text("•")
                                        .foregroundColor(Color("DangerRed"))
                                        .font(.system(size: 14, weight: .bold))
                                    Text("\"\(pattern.replacingOccurrences(of: "\\", with: "").replacingOccurrences(of: "(.*?)", with: "..."))\"")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundColor(.secondary)
                                        .italic()
                                }
                            }
                        }
                    }
                    
                    // Neutral response examples
                    VStack(alignment: .leading, spacing: 8) {
                        Text("**Neutral Response Examples:**")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        VStack(spacing: 8) {
                            ForEach(Array(tactic.neutralResponses.prefix(2)), id: \.self) { response in
                                Text("\"\(response)\"")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(.primary)
                                    .italic()
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color("SuccessGreen").opacity(0.1))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(Color("SuccessGreen").opacity(0.2), lineWidth: 1)
                                            )
                                    )
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                .padding(.horizontal, 20)
                .transition(.opacity.combined(with: .slide))
            }
        }
    }
}

struct HelpResourcesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Getting Help")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.primary)
            
            Text("If you recognize these patterns in your relationships, remember:")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
            
            VStack(alignment: .leading, spacing: 12) {
                HelpResourceItem(
                    icon: "💭",
                    text: "Trust your instincts - if something feels wrong, it probably is"
                )
                
                HelpResourceItem(
                    icon: "📝",
                    text: "Document incidents to help validate your experiences"
                )
                
                HelpResourceItem(
                    icon: "🤝",
                    text: "Reach out to trusted friends, family, or professional counselors"
                )
                
                HelpResourceItem(
                    icon: "🆘",
                    text: "Consider contacting domestic violence resources if you feel unsafe"
                )
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color("InfoBlue").opacity(0.1), Color("PrimaryBlue").opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("InfoBlue").opacity(0.2), lineWidth: 1)
                )
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

struct HelpResourceItem: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text(icon)
                .font(.system(size: 20))
            
            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct LearnView_Previews: PreviewProvider {
    static var previews: some View {
        LearnView()
    }
}