import SwiftUI

struct VictoryDialogView: View {
    var body: some View {
        ZStack {
            HStack {
                Image("coala2")
                    .resizable()
                    .frame(width: 150, height: 250)
                Spacer()
            }
            
            VStack {
                Image("victory_dialog_content")
                    .resizable()
                    .frame(width: 400, height: 280)
                    .padding(.top, 62)
                
                HStack {
                    Button {
                        NotificationCenter.default.post(name: Notification.Name("yes_exit_game"), object: nil)
                    } label: {
                        Image("menu_btn")
                            .resizable()
                            .frame(width: 150, height: 60)
                    }
                    .padding(.leading)
                    Spacer()
                    Button {
                        NotificationCenter.default.post(name: Notification.Name("next_level"), object: nil)
                    } label: {
                        Image("next_btn")
                            .resizable()
                            .frame(width: 150, height: 60)
                    }
                }
                .frame(width: 400)
                .offset(y: -25)
                
            }
            
            VStack {
                Image("victory_title")
                    .resizable()
                    .frame(width: 350, height: 120)
                
                Spacer()
            }
        }
        .background(
            Rectangle()
                .fill(.black.opacity(0.7))
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    VictoryDialogView()
}
