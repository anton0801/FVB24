import SwiftUI
import SpriteKit

struct DailyBonusView: View {
    
    @Environment(\.presentationMode) var presMode
    @State var dailyBonus: DailyBonusScene!
    @State var openRules = false
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        ZStack {
            if let dailyBonus = dailyBonus {
                SpriteView(scene: dailyBonus)
                    .ignoresSafeArea()
            }
            
            if openRules {
                RulesSlotView {
                    withAnimation(.linear) {
                        openRules = false
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("claim_bonus")), perform: { notif in
            guard let userInfo = notif.userInfo as? [String: Any],
                  let reward = userInfo["reward"] as? Int else { return }
            userData.balanceUser += reward
            presMode.wrappedValue.dismiss()
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("open_rules")), perform: { _ in
            withAnimation(.linear) {
                openRules = true
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("close_game")), perform: { _ in
            presMode.wrappedValue.dismiss()
        })
        .onAppear {
            dailyBonus = DailyBonusScene()
        }
    }
}

#Preview {
    DailyBonusView()
        .environmentObject(UserData())
}
