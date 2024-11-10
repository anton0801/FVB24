import SpriteKit
import SwiftUI

class GameCoalaScene: SKScene {
    
    private var miamiCityBack: SKSpriteNode!
    
    var level: Int
    
    var gameFieldSizes = [
        1: 4,
        2: 4,
        3: 4,
        4: 5,
        5: 5,
        6: 6,
        7: 6,
        8: 8
    ]
    
    var gameFieldColumnItems = [
        1: 3,
        2: 3,
        3: 3,
        4: 3,
        5: 4,
        6: 5,
        7: 5,
        8: 5
    ]
    
    private var closeButton: SKSpriteNode!
    private var rulesButton: SKSpriteNode!
    
    var rounds = 5
    var roundsCompletedInTime = 0 {
        didSet {
            roundsLabel.text = "\(roundsCompletedInTime)/\(rounds)"
        }
    }
    private var roundsLabel: SKLabelNode!
    
    var balance = UserDefaults.standard.integer(forKey: "balance_user") {
        didSet {
            balanceLabel.text = "\(balance)"
            UserDefaults.standard.set(balance, forKey: "balance_user")
        }
    }
    private var balanceLabel: SKLabelNode!
    
    var timeLeft = 40 {
        didSet {
            timeLabel.text = "\(timeLeft)"
            if timeLeft <= 0 {
                gameOver()
            }
        }
    }
    private var timeLabel: SKLabelNode!
    private var gameTimer: Timer!
    
    private var prepareLabel: SKLabelNode!
    
    init(level: Int) {
        self.level = level
        super.init(size: CGSize(width: 1350, height: 850))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 1350, height: 850)
        createMiamiBackgroundCity()
    }
    
    private func createMiamiBackgroundCity() {
        miamiCityBack = SKSpriteNode(imageNamed: "miami_city_back")
        miamiCityBack.position = CGPoint(x: size.width / 2, y: size.height / 2)
        miamiCityBack.size = size
        miamiCityBack.zPosition = -1
        addChild(miamiCityBack)
        
        let coalaImage = SKSpriteNode(imageNamed: "coala2")
        coalaImage.position = CGPoint(x: size.width - 150, y: 270)
        coalaImage.size = CGSize(width: 300, height: 550)
        addChild(coalaImage)
        
        closeButton = createButtonFrom(src: "close", size: CGSize(width: 100, height: 180), position: CGPoint(x: size.width - 70, y: size.height - 100))
        addChild(closeButton)
        
        rulesButton = createButtonFrom(src: "rules", size: CGSize(width: 100, height: 180), position: CGPoint(x: 70, y: 100))
        addChild(rulesButton)
        
        let levelLabel = createLabel(text: "Level \(level)", position: CGPoint(x: size.width / 2, y: size.height - 100), textSize: 82)
        addChild(levelLabel)
        
        let balanceBackground = SKSpriteNode(imageNamed: "balance")
        balanceBackground.position = CGPoint(x: 175, y: size.height - 90)
        balanceBackground.size = CGSize(width: 350, height: 180)
        addChild(balanceBackground)
        
        balanceLabel = createLabel(text: "\(balance)", position: CGPoint(x: 140, y: size.height - 110), textSize: 62, fontColor: .white)
        addChild(balanceLabel)
        
        let timeBackground = SKSpriteNode(imageNamed: "time_background")
        timeBackground.position = CGPoint(x: size.width - 320, y: size.height - 90)
        timeBackground.size = CGSize(width: 300, height: 180)
        addChild(timeBackground)
        
        timeLabel = createLabel(text: "\(timeLeft)", position: CGPoint(x: size.width - 280, y: size.height - 110), textSize: 62, fontColor: .white)
        addChild(timeLabel)
        
        rounds = gameFieldSizes[level]!
        
        let roundsValuesBackground = SKSpriteNode(imageNamed: "value_back")
        roundsValuesBackground.position = CGPoint(x: size.width / 2, y: size.height - 180)
        roundsValuesBackground.size = CGSize(width: 150, height: 90)
        addChild(roundsValuesBackground)
        
        roundsLabel = createLabel(text: "0/\(rounds)", position: CGPoint(x: size.width / 2, y: size.height - 190), textSize: 32, fontColor: .white)
        addChild(roundsLabel)
        
        timeLeft = 42 - (level * 2)
        
        gameTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            if !self.isPaused {
                self.timeLeft -= 1
            }
        })
        
        createGameField()
        prepareLabel = createLabel(text: "Prepare!", position: CGPoint(x: size.width / 2, y: size.height / 2), textSize: 72, fontColor: .white)
        addChild(prepareLabel)
    }
    
    private var fruits = [
        "fruit1", "granat", "listva", "malina", "orange", "pineapple"
    ]
    
    private var fruitNodes: [SKSpriteNode] = []
    private var selectedOrderForRound: [String] = []
    private var clickedOrderForRound: [String] = []
    
    private func createGameField() {
        let gameFieldSize = gameFieldSizes[level]!
        let gameFieldColumnItems = gameFieldColumnItems[level]!
        let gameFieldWidth = 500
        let columnHeight = 500
        let itemHeight = columnHeight / gameFieldColumnItems
        let itemWidth = gameFieldWidth / gameFieldSize
        for column in 0..<gameFieldSize {
            for item in 0..<gameFieldColumnItems {
                let randomFruit = fruits.randomElement() ?? fruits[0]
                let fruitNode = SKSpriteNode(imageNamed: randomFruit)
                fruitNode.position = CGPoint(x: (size.width / 2 - CGFloat(gameFieldWidth / 2)) + CGFloat(column * (itemWidth + 15)), y: (size.height / 2 + 100) - CGFloat(item * (itemHeight + 15)))
                fruitNode.size = CGSize(width: itemWidth, height: itemHeight)
                fruitNode.name = "objective_\(randomFruit)_\(column)_\(item)"
                fruitNode.alpha = 0.6
                fruitNodes.append(fruitNode)
                addChild(fruitNode)
            }
        }
        
        if roundsCompletedInTime == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.prepareLabel.run(SKAction.sequence([SKAction.fadeAlpha(to: 0, duration: 0.4), SKAction.removeFromParent()])) {
                    self.createRoundItems()
                }
            }
        }
    }
    
    private func createRoundItems() {
        selectedOrderForRound = []
        clickedOrderForRound = []
        let gameFieldSize = gameFieldSizes[level]!
        let gameFieldColumnItems = gameFieldColumnItems[level]!
        for _ in 0..<(roundsCompletedInTime + 1) {
            selectedOrderForRound.append(generateRandomPosition(a: gameFieldSize, b: gameFieldColumnItems))
        }
        
        for node in fruitNodes {
            node.run(SKAction.fadeAlpha(to: 0.6, duration: 0.4))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for orderItem in self.selectedOrderForRound {
                for node in self.fruitNodes {
                    if node.name?.contains(orderItem) == true {
                        node.run(SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0.4), SKAction.wait(forDuration: 0.8), SKAction.fadeAlpha(to: 0.6, duration: 0.4)]))
                    }
                }
            }
        }
    }
    
    private func generateRandomPosition(a: Int, b: Int) -> String {
        return "\(Int.random(in: 0..<a))_\(Int.random(in: 0..<b))"
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
            let atPointByname = atPoint(location)
            
            if atPointByname.name?.contains("objective") == true {
                let fruitNameComponents = atPointByname.name!.components(separatedBy: "_")
                let fruitColumn = Int(fruitNameComponents[2]) ?? 0
                let fruitRow = Int(fruitNameComponents[3]) ?? 0
                let splited = "\(fruitColumn)_\(fruitRow)"
                atPointByname.run(SKAction.fadeAlpha(to: 1, duration: 0.4))
                clickedOrderForRound.append(splited)
                checkItems()
            } else {
                let nodes = nodes(at: location)
                for node in nodes {
                    if node == rulesButton {
                        isPaused = true
                        NotificationCenter.default.post(name: Notification.Name("open_rules"), object: nil)
                        return
                    } else if node == closeButton {
                        isPaused = true
                        NotificationCenter.default.post(name: Notification.Name("close_game"), object: nil)
                        return
                    }
                }
            }
        }
    }
    
    private func checkItems() {
        var isAllCorrect = false
        
        for (_, item) in clickedOrderForRound.enumerated() {
            if selectedOrderForRound.contains(item) {
                isAllCorrect = true
            } else {
                isAllCorrect = false
                timeLeft -= 5
                let node = fruitNodes.filter { $0.name?.contains(item) == true }
                if let node = node.first {
                    node.run(SKAction.sequence([SKAction.repeat(SKAction.sequence([SKAction.fadeAlpha(to: 0.4, duration: 0.3), SKAction.fadeAlpha(to: 1, duration: 0.3)]), count: 5), SKAction.fadeAlpha(to: 0.6, duration: 0.4)]))
                }
                break
            }
        }
        
        if clickedOrderForRound.count != selectedOrderForRound.count {
            return
        }
    
        if isAllCorrect {
            roundsCompletedInTime += 1
            
            if rounds == roundsCompletedInTime {
                gameWin()
            } else {
                createRoundItems()
            }
        } else {
            clickedOrderForRound = clickedOrderForRound.dropLast()
        }
    }
    
    private func gameOver() {
        isPaused = true
        NotificationCenter.default.post(name: Notification.Name("game_over"), object: nil)
    }
    
    private func gameWin() {
        isPaused = true
        NotificationCenter.default.post(name: Notification.Name("gamewin"), object: nil)
    }
    
    func restartGame(level: Int? = nil) -> GameCoalaScene {
        let newScene = GameCoalaScene(level: level == nil ? self.level : level!)
        view?.presentScene(newScene)
        return newScene
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: GameCoalaScene(level: 2))
            .ignoresSafeArea()
    }
}
