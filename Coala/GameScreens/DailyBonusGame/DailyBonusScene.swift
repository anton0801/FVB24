import SwiftUI
import SpriteKit

class DailyBonusScene: SKScene {
    
    private var miamiCityBack: SKSpriteNode!
    
    private var paymentData = [
        "daily1": 100,
        "daily2": 800,
        "daily3": 300,
        "daily4": 500
    ]
    
    private var spinBtn: SKSpriteNode!
    private var spinRouletteBtn: SKSpriteNode!
    private var closeBtn: SKSpriteNode!
    private var rulesBtn: SKSpriteNode!
    private var takeButton: SKSpriteNode?
    
    private var coala1: SKSpriteNode!
    private var coala2: SKSpriteNode!
    private var coala3: SKSpriteNode!
    
    var balance = UserDefaults.standard.integer(forKey: "balance_user") {
        didSet {
            balanceLabel.text = "\(balance)"
            UserDefaults.standard.set(balance, forKey: "balance_user")
        }
    }
    private var balanceLabel: SKLabelNode!
    
    private var barabanDailyBonusNode: BarabansDailyBonusNode!
    private var barabanWin = 0
    private var totalWin = 0 {
        didSet {
            showTotalWin()
        }
    }
    
    private var rouletteNode: RouletteNode!
    
    private var slotDailyBonusState = true {
        didSet {
            if !slotDailyBonusState {
                barabanDailyBonusNode.run(SKAction.sequence([
                    SKAction.move(to: CGPoint(x: -1000, y: size.height / 2 - 100), duration: 1),
                    SKAction.removeFromParent()
                ]))
                coala1.run(SKAction.sequence([
                    SKAction.move(to: CGPoint(x: -1000, y: size.height / 2 - 150), duration: 1),
                    SKAction.removeFromParent()
                ]))
                coala2.run(SKAction.sequence([
                    SKAction.move(to: CGPoint(x: -1000, y: size.height / 2 - 150), duration: 1),
                    SKAction.removeFromParent()
                ]))
                spinBtn.run(SKAction.sequence([
                    SKAction.move(to: CGPoint(x: -1000, y: 130), duration: 1),
                    SKAction.removeFromParent()
                ]))
                
                coala3.position = CGPoint(x: size.width + 150, y: size.height / 2 - 150)
                addChild(coala3)
                coala3.run(SKAction.move(to: CGPoint(x: 150, y: size.height / 2 - 150), duration: 1))
                spinRouletteBtn.position = CGPoint(x: size.width + 150, y: 75)
                addChild(spinRouletteBtn)
                spinRouletteBtn.run(SKAction.move(to: CGPoint(x: size.width - 150, y: 75), duration: 1))
                
                rouletteNode.position = CGPoint(x: size.width + 500, y: size.height / 2 - 75)
                addChild(rouletteNode)
                rouletteNode.run(SKAction.move(to: CGPoint(x: size.width / 2, y: size.height / 2 - 75), duration: 1))
            }
        }
    }
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 1350, height: 750)
        
        miamiCityBack = SKSpriteNode(imageNamed: "daily_back_game")
        miamiCityBack.position = CGPoint(x: size.width / 2, y: size.height / 2)
        miamiCityBack.size = size
        miamiCityBack.zPosition = -1
        addChild(miamiCityBack)
        
        let balanceBackground = SKSpriteNode(imageNamed: "balance")
        balanceBackground.position = CGPoint(x: size.width - 175, y: size.height - 90)
        balanceBackground.size = CGSize(width: 350, height: 180)
        addChild(balanceBackground)
        
        balanceLabel = createLabel(text: "\(balance)", position: CGPoint(x: size.width - 190, y: size.height - 110), textSize: 62, fontColor: .white)
        addChild(balanceLabel)
        
        let dailyTitle = createButtonFrom(src: "daily_title", size: CGSize(width: 700, height: 250), position: CGPoint(x: size.width / 2, y: size.height - 135))
        addChild(dailyTitle)
        
        closeBtn = createButtonFrom(src: "close", size: CGSize(width: 100, height: 190), position: CGPoint(x: 70, y: size.height - 100))
        addChild(closeBtn)
        
        rulesBtn = createButtonFrom(src: "rules", size: CGSize(width: 100, height: 180), position: CGPoint(x: 180, y: size.height - 100))
        addChild(rulesBtn)
        
        coala1 = createButtonFrom(src: "coala2", size: CGSize(width: 250, height: 450), position: CGPoint(x: 150, y: size.height / 2 - 150))
        addChild(coala1)
        
        coala2 = createButtonFrom(src: "coala2", size: CGSize(width: 250, height: 450), position: CGPoint(x: size.width - 150, y: size.height / 2 - 150))
        addChild(coala2)
        
        coala3 = createButtonFrom(src: "coala2", size: CGSize(width: 250, height: 450), position: CGPoint(x: 150, y: size.height / 2 - 150))
        
        barabanDailyBonusNode = BarabansDailyBonusNode(itemSize: CGSize(width: 130, height: 400), containerSize: CGSize(width: 800, height: 600), endCallback: { items in
            let payment = self.paymentData[items[0]]!
            self.barabanWin = payment
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.slotDailyBonusState = false
            }
        })
        barabanDailyBonusNode.position = CGPoint(x: size.width / 2, y: size.height / 2 - 100)
        addChild(barabanDailyBonusNode)
        
        spinBtn = createButtonFrom(src: "spin_btn", size: CGSize(width: 200, height: 90), position: CGPoint(x: size.width / 2, y: 130))
        addChild(spinBtn)
        
        spinRouletteBtn = createButtonFrom(src: "spin_btn", size: CGSize(width: 300, height: 150), position: CGPoint(x: size.width - 150, y: 75))
        
        rouletteNode = RouletteNode(size: CGSize(width: 500, height: 500)) { winItem in
            let winningX = Int(winItem) ?? 0
            self.totalWin = self.barabanWin * winningX
        }
    }
    
    private func showTotalWin() {
        let totalWinNode = SKSpriteNode()
        totalWinNode.size = size
        totalWinNode.alpha = 0
        totalWinNode.zPosition = 15
        
        let back = SKSpriteNode(color: .black.withAlphaComponent(0.6), size: size)
        back.position = CGPoint(x: size.width / 2, y: size.height / 2)
        totalWinNode.addChild(back)
        
        let bigWin = SKSpriteNode(imageNamed: "big_win")
        bigWin.size = CGSize(width: 700, height: 400)
        bigWin.position = CGPoint(x: size.width / 2, y: size.height - 150)
        totalWinNode.addChild(bigWin)
        
        let totalWinLabel = createLabel(text: "+\(totalWin)", position: CGPoint(x: size.width / 2, y: size.height / 2 - 100), textSize: 142, fontColor: .white)
        totalWinNode.addChild(totalWinLabel)
        
        takeButton = createButtonFrom(src: "take_btn", size: CGSize(width: 250, height: 130), position: CGPoint(x: size.width / 2, y: 100))
        totalWinNode.addChild(takeButton!)
        
        addChild(totalWinNode)
        totalWinNode.run(SKAction.fadeAlpha(to: 1, duration: 0.4))
    }
    
    private func createLabel(text: String, position: CGPoint, textSize: CGFloat, fontColor: UIColor = UIColor.init(red: 234/255, green: 0, blue: 1, alpha: 1)) -> SKLabelNode {
        let labelText = SKLabelNode(text: text)
        labelText.fontSize = textSize
        labelText.fontName = "Miami"
        labelText.fontColor = fontColor
        labelText.position = position
        return labelText
    }
    
    private func createButtonFrom(src: String, size: CGSize, position: CGPoint) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: src)
        node.position = position
        node.size = size
        node.name = src
        return node
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)

            let nodes = nodes(at: location)
            let atPoint = atPoint(location)
            
            if atPoint.name == "take_btn" {
                NotificationCenter.default.post(name: Notification.Name("claim_bonus"), object: nil, userInfo: ["reward": totalWin])
            } else {
                for node in nodes {
                    if node == rulesBtn {
                        NotificationCenter.default.post(name: Notification.Name("open_rules"), object: nil)
                        return
                    } else if node == closeBtn {
                        isPaused = true
                        NotificationCenter.default.post(name: Notification.Name("close_game"), object: nil)
                        return
                    } else if node == spinBtn {
                        barabanDailyBonusNode.spinBarabans()
                    } else if node == spinRouletteBtn {
                        rouletteNode.spinRoulette()
                    }
                }
            }
        }
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: DailyBonusScene())
            .ignoresSafeArea()
    }
}
