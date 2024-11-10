import Foundation
import SpriteKit

class RouletteNode: SKSpriteNode {
    
    private var rouletteNode: SKSpriteNode
    private var rouletteNodes: SKSpriteNode
    
    private var winCallback: (String) -> Void
    
    init(size: CGSize, winCallback: @escaping (String) -> Void) {
        rouletteNode = SKSpriteNode(imageNamed: "roulette")
        rouletteNode.size = size
        rouletteNodes = SKSpriteNode()
        self.winCallback = winCallback
        let rouletteIndicator = SKSpriteNode(imageNamed: "roulette_indicator")
        rouletteIndicator.position = CGPoint(x: 200, y: 0)
        rouletteIndicator.zPosition = 10
        rouletteIndicator.size = CGSize(width: 100, height: 75)
        super.init(texture: nil, color: .clear, size: size)
        addChild(rouletteNode)
        addChild(rouletteIndicator)
        positionRouletteInNode()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func positionRouletteInNode() {
        let radius: CGFloat = 200
        let center = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let numberOfNodes = 24
        
        for i in 0..<numberOfNodes {
            let angle = CGFloat(i) * (2 * .pi / CGFloat(numberOfNodes))
            
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            
            let node = createRouletteItemNode(angle: angle)
            node.anchorPoint = CGPoint(x: 0, y: 0)
            node.zRotation = angle + .pi / 2
            node.position = CGPoint(x: x, y: y)
            
            rouletteNodes.addChild(node)
        }
        self.addChild(rouletteNodes)
    }
    
    private func createRouletteItemNode(angle: CGFloat) -> SKSpriteNode {
        let randomX = [0, 2, 3].randomElement() ?? 0
        let node = SKSpriteNode(color: .clear, size: CGSize(width: 40, height: 150))
        let text = SKLabelNode(text: "X\(randomX)")
        text.fontName = "Miami"
        text.color = .white
        text.fontSize = 32
        text.position = CGPoint(x: -175, y: 250)
        text.zRotation = angle
        text.name = "\(randomX)"
        node.addChild(text)
        node.name = "\(randomX)"
        return node
    }
    
    func spinRoulette() {
        let rotateAction = SKAction.rotate(byAngle: .pi * 2, duration: 2.5)
        rouletteNode.run(rotateAction)
        rouletteNodes.run(rotateAction) {
            self.checkWinings()
        }
    }
    
    private func checkWinings() {
        let pointNode = atPoint(CGPoint(x: 100, y: 0))
        if let name = pointNode.name {
            winCallback(name)
        }
    }
    
}
