import SwiftUI

struct RulesSlotView: View {
    var closeCallback: () -> Void
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Image("coala3")
                    .resizable()
                    .frame(width: 150, height: 250)
            }
            
            ZStack {
                Image("daily_slot_rules")
                    .resizable()
                    .frame(width: 500, height: 300)
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
    RulesSlotView {
        
    }
}
