import SwiftUI

struct ResultsView: View {
    let tactics: [ManipulationTactic]
    
    var body: some View {
        VStack(spacing: 20) {
            // Results Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Analysis Complete")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.primary)
                    
                    if tactics.isEmpty {
                        Text("No manipulation patterns detected")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("SuccessGreen"))
                    } else {
                        Text("\(tactics.count) manipulation pattern\(tactics.count == 1 ? "" : "s") detected")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("DangerRed"))
                    }
                }
                
                Spacer()
                
                // Warning Icon
                if !tactics.isEmpty {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(Color("DangerRed"))
                }
            }
            
            if tactics.isEmpty {
                // No tactics detected
                VStack(spacing: 16) {
                    Image(systemName: "checkmark.shield.fill")
                        .font(.system(size: 48))
                        .foregroundColor(Color("SuccessGreen"))
                    
                    Text("Clean Communication")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Text("No obvious manipulative tactics detected in this message. This doesn't necessarily mean the communication is completely harmless - always trust your instincts.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding(.vertical, 30)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color("SuccessGreen").opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("SuccessGreen").opacity(0.3), lineWidth: 1)
                        )
                )
            } else {
                // Warning banner
                VStack(spacing: 12) {
                    HStack(spacing: 8) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color("WarningOrange"))
                        
                        Text("**Warning:** Potential manipulation detected")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color("WarningBrown"))
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("WarningYellow").opacity(0.2))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("WarningOrange").opacity(0.4), lineWidth: 1)
                        )
                )
                
                // Tactics List
                VStack(spacing: 12) {
                    ForEach(tactics, id: \.id) { tactic in
                        TacticCardView(tactic: tactic)
                    }
                }
                
                // Trust your instincts reminder
                VStack(spacing: 8) {
                    Text("**Remember:** Trust your instincts")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color("InfoBlue"))
                    
                    Text("If you're feeling confused, guilty, or afraid, consider reaching out to a trusted friend, family member, or professional counselor.")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("InfoBlue").opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("InfoBlue").opacity(0.3), lineWidth: 1)
                        )
                )
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 16, x: 0, y: 4)
        )
        .padding(.horizontal, 16)
    }
}

struct TacticCardView: View {
    let tactic: ManipulationTactic
    @State private var showNeutralResponse = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Tactic Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(tactic.name)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("DangerRed"))
                    
                    Text(tactic.description)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        showNeutralResponse.toggle()
                    }
                }) {
                    HStack(spacing: 4) {
                        Text("Response")
                            .font(.system(size: 12, weight: .semibold))
                        Image(systemName: showNeutralResponse ? "chevron.up" : "chevron.down")
                            .font(.system(size: 10, weight: .semibold))
                    }
                    .foregroundColor(Color("PrimaryBlue"))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("PrimaryBlue").opacity(0.1))
                    )
                }
            }
            
            // Neutral Response (Expandable)
            if showNeutralResponse {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Suggested Neutral Response:")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                    
                    Text("\"\(tactic.neutralResponses.randomElement() ?? "I understand your perspective.")\"")
                        .font(.system(size: 14, weight: .medium))
                        .italic()
                        .foregroundColor(.primary)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.gray.opacity(0.1))
                        )
                    
                    Text("This neutral response can help maintain boundaries while de-escalating the situation.")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.secondary)
                }
                .transition(.opacity.combined(with: .slide))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("DangerRed").opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("DangerRed").opacity(0.2), lineWidth: 1)
                        .overlay(
                            // Left accent border
                            HStack {
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(Color("DangerRed"))
                                    .frame(width: 4)
                                Spacer()
                            }
                        )
                )
        )
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                // With tactics
                ResultsView(tactics: [
                    ManipulationTactic.allTactics[0],
                    ManipulationTactic.allTactics[1]
                ])
                
                // Without tactics
                ResultsView(tactics: [])
            }
        }
        .background(Color(.systemGroupedBackground))
    }
}