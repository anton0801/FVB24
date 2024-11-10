import Foundation
import SpriteKit

class BarabanNode: SKSpriteNode {
    
    var symbols: [String]
    private let croppedBaraban: SKCropNode
    private let contentBaraban: SKNode
    var stoppedSpinCallback: (() -> Void)?
    
    var reverseScroll = false
    
    init(slotSymbols: [String], size: CGSize, stoppedSpinCallback: (() -> Void)? = nil) {
        self.symbols = slotSymbols
        self.croppedBaraban = SKCropNode()
        self.stoppedSpinCallback = stoppedSpinCallback
        self.contentBaraban = SKNode()
        super.init(texture: nil, color: .clear, size: size)
        setUpNodes()
        setUpSymbols()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpNodes() {
        croppedBaraban.position = CGPoint(x: 0, y: 0)
        let maskNode = SKSpriteNode(color: .black, size: size)
        maskNode.position = CGPoint(x: 0, y: 0)
        croppedBaraban.maskNode = maskNode
        addChild(croppedBaraban)
        croppedBaraban.addChild(contentBaraban)
    }
    
    func setUpSymbols() {
        for i in 0..<symbols.count * 5 {
            let symbolName = symbols[i % symbols.count]
            let symbolNode = createSlotItem(name: symbolName)
            symbolNode.position = CGPoint(x: 0, y: size.height - CGFloat(i) * 130.5)
            contentBaraban.addChild(symbolNode)
        }
        contentBaraban.run(SKAction.moveBy(x: 0, y: 130.5 * CGFloat(symbols.count) * 1.5, duration: 0.0))
    }
    
    private func createSlotItem(name: String) -> SKSpriteNode {
        let symbol = SKSpriteNode(imageNamed: name)
        symbol.size = CGSize(width: 100, height: 100)
        symbol.zPosition = 1
        symbol.name = name
        return symbol
    }
    
    func spinBarabanContent(count: CGFloat) {
        if reverseScroll {
            reverseScroll = false
            let actionMove = SKAction.moveBy(x: 0, y: -(130.5 * count), duration: 0.5)
            contentBaraban.run(actionMove) { self.stoppedSpinCallback?() }
        } else {
            let actionMove = SKAction.moveBy(x: 0, y: 130.5 * count, duration: 0.5)
            contentBaraban.run(actionMove) { self.stoppedSpinCallback?() }
            reverseScroll = true
        }
    }
    
}
