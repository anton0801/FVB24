import SwiftUI
import SpriteKit

struct GameCoalaView: View {
    
    @Environment(\.presentationMode) var presMode
    var level: Int
    
    @State var coalaGame: GameCoalaScene!
    @EnvironmentObject var userData: UserData
    
    @State var exitDialogVisible = false
    @State var openRules = false
    @State var gameOver = false
    @State var gameWin = false
    
    var body: some View {
        ZStack {
            if let coalaGame = coalaGame {
                SpriteView(scene: coalaGame)
                    .ignoresSafeArea()
            }
            
            if exitDialogVisible {
                ExitDialog()
            }
            
            if gameWin {
                VictoryDialogView()
            }
            
            if gameOver {
                LoseDialogView()
            }
            
            if openRules {
                RulesDialogView {
                    withAnimation(.linear) {
                        openRules = false
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("open_rules")), perform: { _ in
            withAnimation(.linear) {
                openRules = true
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("close_game")), perform: { _ in
            withAnimation(.linear) {
                exitDialogVisible = true
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("yes_exit_game")), perform: { _ in
            presMode.wrappedValue.dismiss()
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("no_exit_game")), perform: { _ in
            withAnimation(.linear) {
                exitDialogVisible = false
                coalaGame.isPaused = false
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("game_over")), perform: { _ in
            withAnimation(.linear) {
                gameOver = true
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("gamewin")), perform: { _ in
            userData.balanceUser = UserDefaults.standard.integer(forKey: "balance_user")
            withAnimation(.linear) {
                gameWin = true
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("restart_game")), perform: { _ in
            coalaGame = coalaGame.restartGame()
            withAnimation(.linear) {
                gameOver = false
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("next_level")), perform: { _ in
            if level == 8 {
                coalaGame = coalaGame.restartGame(level: 1)
                UserDefaults.standard.set(1, forKey: "current_level")
            } else {
                coalaGame = coalaGame.restartGame(level: level + 1)
                UserDefaults.standard.set(level + 1, forKey: "current_level")
            }
            withAnimation(.linear) {
                gameWin = false
            }
        })
        .onAppear {
            coalaGame = GameCoalaScene(level: level)
        }
    }
    
}

#Preview {
    GameCoalaView(level: 1)
        .environmentObject(UserData())
}
