import SwiftUI

struct ContentView: View {
    
    @State var rulesVisible = false
    
    @State var currentLevel = UserDefaults.standard.integer(forKey: "current_level")
    
    @StateObject var userData = UserData()
    @State var goToBonusView = false
    @State var openRules = false
    @State var musicState = UserDefaults.standard.bool(forKey: "music_state")
    
    @State var alertMessage = ""
    @State var alertVisible = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        ZStack(alignment: .bottom) {
                            Image("game_map")
                                .resizable()
                                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                                .aspectRatio(contentMode: .fill)
                                .id("game_map")
                            
                            ZStack {
                                Image("arrow_indicator")
                                    .resizable()
                                    .frame(width: 52, height: 42)
                                    .offset(x: -70, y: (-800) + CGFloat(currentLevel * 100))
                                
                                NavigationLink(destination: GameCoalaView(level: 8)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 8 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("8")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -20)
                                    .id(8)
                                
                                NavigationLink(destination: GameCoalaView(level: 7)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 7 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("7")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -120)
                                    .id(7)
                                
                                NavigationLink(destination: GameCoalaView(level: 6)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 6 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("6")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -220)
                                    .id(6)
                                
                                NavigationLink(destination: GameCoalaView(level: 5)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 5 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("5")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -320)
                                    .id(5)
                                
                                NavigationLink(destination: GameCoalaView(level: 4)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 4 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("4")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -420)
                                    .id(4)
                                
                                NavigationLink(destination: GameCoalaView(level: 3)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 3 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("3")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -520)
                                    .id(3)
                                
                                NavigationLink(destination: GameCoalaView(level: 2)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 2 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("2")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -620)
                                    .id(2)
                                
                                NavigationLink(destination: GameCoalaView(level: 1)
                                    .environmentObject(userData)
                                    .navigationBarBackButtonHidden(true)) {
                                        ZStack {
                                            Image("level_item")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .offset(y: 30)
                                                .zIndex(1)
                                            if currentLevel == 1 {
                                                Image("coala")
                                                    .resizable()
                                                    .frame(width: 52, height: 82)
                                                    .offset(y: -10)
                                                    .zIndex(2)
                                            }
                                            Text("1")
                                                .font(.custom("Mitr-Bold", size: 62))
                                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                                .shadow(color: .white, radius: 2, x: -1)
                                                .shadow(color: .white, radius: 2, x: 1)
                                                .zIndex(3)
                                        }
                                    }
                                    .offset(x: 0, y: -720)
                                    .id(1)
                            }
                        }
                    }
                    .ignoresSafeArea()
                }
                
                VStack {
                    HStack {
//                        NavigationLink(destination: EmptyView()) {
//                            Image("shop")
//                                .resizable()
//                                .frame(width: 52, height: 72)
//                        }
                        Image("shop")
                            .resizable()
                            .frame(width: 52, height: 72)
                            .opacity(0)
                        Button {
                            musicState.toggle()
                        } label: {
                            Image("music")
                                .resizable()
                                .frame(width: 52, height: 72)
                                .opacity(musicState ? 1 : 0.6)
                        }
                        .onChange(of: musicState) { value in
                            UserDefaults.standard.set(value, forKey: "music_state")
                        }
                        Image("music")
                            .resizable()
                            .frame(width: 52, height: 72)
                            .opacity(0)
                        
                        Spacer()
                        
                        Image("levels_title")
                            .resizable()
                            .frame(width: 280, height: 72)
                        
                        Spacer()
                        
                        ZStack {
                            Image("balance")
                                .resizable()
                                .frame(width: 154, height: 72)
                            Text("\(userData.balanceUser)")
                                .font(.custom("Mitr-Bold", size: 24))
                                .foregroundColor(Color.init(red: 234/255, green: 0, blue: 1))
                                .shadow(color: .white, radius: 2, x: -1)
                                .shadow(color: .white, radius: 2, x: 1)
                                .offset(x: -20)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation(.linear) {
                                openRules = true
                            }
                        } label: {
                            Image("rules")
                                .resizable()
                                .frame(width: 52, height: 72)
                        }
                        Spacer()
                        Button {
                            if UserDefaults.standard.bool(forKey: "bonus_available") {
                                goToBonusView = true
                            } else {
                                alertMessage = "Now daily bonus is unavailable, because you have used it today!"
                                alertVisible = true
                            }
                        } label: {
                            Image("daily")
                                .resizable()
                                .frame(width: 52, height: 72)
                        }
                        
                        NavigationLink(destination: DailyBonusView()
                            .environmentObject(userData)
                            .navigationBarBackButtonHidden(), isActive: $goToBonusView) {
                            
                        }
                    }
                }
                
                if openRules {
                    RulesDialogView {
                        withAnimation(.linear) {
                            openRules = false
                        }
                    }
                }
            }
            .onAppear {
                if UserDefaults.standard.integer(forKey: "current_level") == 0 {
                    UserDefaults.standard.set(1, forKey: "current_level")
                    UserDefaults.standard.set(true, forKey: "bonus_available")
                }
                withAnimation(.linear(duration: 0.4)) {
                    currentLevel = UserDefaults.standard.integer(forKey: "current_level")
                }
            }
            .alert(isPresented: $alertVisible) {
                Alert(title: Text("Alert!"), message: Text(alertMessage))
            }
        }
    }
}

#Preview {
    ContentView()
}
