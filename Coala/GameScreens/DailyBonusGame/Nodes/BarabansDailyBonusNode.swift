import Foundation
import SpriteKit

class BarabansDailyBonusNode: SKSpriteNode {
    
    private var barabanNodeFirst: BarabanNode
    private var barabanNodeSecond: BarabanNode
    private var barabanNodeThird: BarabanNode!
    
    private var endCallback: ([String]) -> Void
    
    private var itemSize: CGSize
    
    init(itemSize: CGSize, containerSize: CGSize, endCallback: @escaping ([String]) -> Void) {
        let symbols = ["daily1", "daily2", "daily3", "daily4"]
        self.endCallback = endCallback
        self.itemSize = itemSize
        barabanNodeFirst = BarabanNode(slotSymbols: symbols, size: itemSize)
        barabanNodeSecond = BarabanNode(slotSymbols: symbols, size: itemSize)
        barabanNodeFirst.position = CGPoint(x: -(itemSize.width + 80), y: 30)
        barabanNodeSecond.position = CGPoint(x: 0, y: 30)
        
        let barabanBackground = SKSpriteNode(imageNamed: "daily_barabans")
        barabanBackground.size = containerSize
        
        let line = SKSpriteNode(imageNamed: "line_indicator")
        line.size = CGSize(width: containerSize.width - 200, height: 15)
        line.position = CGPoint(x: 0, y: 30)
        
        super.init(texture: nil, color: .clear, size: containerSize)
        barabanNodeThird = BarabanNode(slotSymbols: symbols, size: itemSize, stoppedSpinCallback: {
            self.checkAllItems()
        })
        barabanNodeThird.position = CGPoint(x: itemSize.width + 80, y: 30)
        addChild(barabanBackground)
        addChild(barabanNodeFirst)
        addChild(barabanNodeSecond)
        addChild(barabanNodeThird)
        addChild(line)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func checkAllItems() {
        let leftItem = atPoint(CGPoint(x: -(itemSize.width + 80), y: 30))
        let centerItem = atPoint(CGPoint(x: 0, y: 30))
        let rightItem = atPoint(CGPoint(x: itemSize.width + 80, y: 30))
        endCallback([leftItem.name!, centerItem.name!, rightItem.name!])
    }
    
    func spinBarabans() {
        let countSpin = CGFloat.random(in: 1...4)
        barabanNodeFirst.spinBarabanContent(count: countSpin)
        barabanNodeSecond.spinBarabanContent(count: countSpin)
        barabanNodeThird.spinBarabanContent(count: countSpin)
    }
    
}
