import SwiftUI

struct RulesDialogView: View {
    
    var closeCallback: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Image("coala2")
                    .resizable()
                    .frame(width: 150, height: 250)
                Spacer()
            }
            
            ZStack {
                Image("rules_back")
                    .resizable()
                    .frame(width: 500, height: 300)
                
                Text("Welcome to Neon Koala: Miami Nights! Your goal is to memorize the sequence of neon panels that light up and then repeat it by tapping the panels in the same order. Each level adds more panels and increases the speed. If you make a mistake, you lose a 5 seconds. Complete the sequence before time runs out to progress!")
                    .font(.custom("Miami", size: 22))
                    .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                    .shadow(color: .white, radius: 2, x: -1)
                    .shadow(color: .white, radius: 2, x: 1)
                    .multilineTextAlignment(.center)
                    .frame(width: 400)
            }
            .frame(width: 500, height: 350)
            
            VStack {
                HStack {
                    Button {
                        closeCallback()
                    } label: {
                        Image("close")
                            .resizable()
                            .frame(width: 52, height: 72)
                    }
                    Spacer()
                    Image("rules_title")
                        .resizable()
                        .frame(width: 350, height: 90)
                        .padding(.top)
                    Spacer()
                    Image("close")
                        .resizable()
                        .frame(width: 52, height: 72)
                        .opacity(0)
                }
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
    RulesDialogView {
        
    }
}
