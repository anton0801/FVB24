import SwiftUI

struct ExitDialog: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Image("coala2")
                    .resizable()
                    .frame(width: 150, height: 250)
            }
            
            VStack {
                Image("exit_dialog_content")
                    .resizable()
                    .frame(width: 400, height: 280)
                    .padding(.top)
                
                HStack {
                    Button {
                        NotificationCenter.default.post(name: Notification.Name("no_exit_game"), object: nil)
                    } label: {
                        Image("no_btn")
                            .resizable()
                            .frame(width: 150, height: 60)
                    }
                    .padding(.leading)
                    Spacer()
                    Button {
                        NotificationCenter.default.post(name: Notification.Name("yes_exit_game"), object: nil)
                    } label: {
                        Image("yes_btn")
                            .resizable()
                            .frame(width: 150, height: 60)
                    }
                }
                .frame(width: 400)
                .offset(y: -25)
                
            }
            
            VStack {
                Image("exit_title")
                    .resizable()
                    .frame(width: 350, height: 90)
                    .padding(.top)
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
    ExitDialog()
}
