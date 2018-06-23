import SpriteKit
import CoreMotion

class DropScene: SKScene {
    var barNodeInCreate: SKShapeNode?
    var initialTouchPoint: CGPoint
    var ballDropper: Timer?
    let motionManager = CMMotionManager()
    let motion = CMDeviceMotion()
    var gravityValue:Double = 0
    var deviceGravityValue:Double = 0
    var ballRadius:Double = 5.0
    var useDeviceTiltForGravity:Bool = true
    var useRandomColor:Bool = true 

    static let useDeviceTiltForGravityKey = "useDeviceTiltForGravity"
    static let gravityValueKey = "gravityValue"
    static let deviceGravityValueKey = "deviceGravityValue"
    static let useRandomColorKey = "useRandomColor"
    static let ballRadiusKey = "ballRadius"

    override init(size: CGSize) {
        self.initialTouchPoint = CGPoint.zero
        super.init(size: size)
    }

    required init?(coder aDecoder: NSCoder) {
        self.initialTouchPoint = CGPoint.zero
        super.init(coder:aDecoder)
    }

    func gravityUpdated(){
        if let data = motionManager.deviceMotion {
            let gravity = data.gravity
            self.physicsWorld.gravity = CGVector(dx:gravity.x * self.deviceGravityValue, dy:gravity.y * self.deviceGravityValue)
        }
    }

    func configureGravity() {
        if (self.useDeviceTiltForGravity) {
            self.motionManager.startDeviceMotionUpdates()
        } else {
            self.motionManager.stopDeviceMotionUpdates()
            self.physicsWorld.gravity = CGVector(dx:0.0, dy:-self.gravityValue)
        }
    }

    func configChanged() {
        self.useDeviceTiltForGravity = UserDefaults.standard.bool(forKey:DropScene.useDeviceTiltForGravityKey)
        self.useRandomColor = UserDefaults.standard.bool(forKey:DropScene.useRandomColorKey)
        self.gravityValue = UserDefaults.standard.double(forKey:DropScene.gravityValueKey)
        self.deviceGravityValue = UserDefaults.standard.double(forKey:DropScene.deviceGravityValueKey)
        self.ballRadius = UserDefaults.standard.double(forKey:DropScene.ballRadiusKey)
        self.configureGravity()
    }

    override func update(_ currentTime: CFTimeInterval) {
        gravityUpdated()
    }

    @objc public func addNewDrop() {
        let radius = CGFloat(self.ballRadius)
        let velocityX = 0.0
        let velocityY = 0.0
        let dropNode = SKShapeNode()
        dropNode.position = CGPoint(x:100, y:600)

        if (self.useRandomColor) {
            let randomRed:CGFloat = CGFloat(drand48())
            let randomGreen:CGFloat = CGFloat(drand48())
            let randomBlue:CGFloat = CGFloat(drand48())
            dropNode.fillColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        } else {
            dropNode.fillColor = UIColor.white
        }
        let path = CGMutablePath()
        path.addArc(center: CGPoint.zero, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        dropNode.path = path

        dropNode.strokeColor = UIColor.clear
        dropNode.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        dropNode.physicsBody?.affectedByGravity = true
        dropNode.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)
        //dropNode.physicsBody?.restitution = 0.9
        dropNode.physicsBody?.restitution = 0.8
        dropNode.physicsBody?.linearDamping = 0
        dropNode.physicsBody?.friction = 0
        dropNode.physicsBody?.usesPreciseCollisionDetection = true
        self.addChild(dropNode)
    }

    override func sceneDidLoad() {
        UserDefaults.standard.register(defaults:[DropScene.useDeviceTiltForGravityKey : false])
        UserDefaults.standard.register(defaults:[DropScene.gravityValueKey : 4.9])
        UserDefaults.standard.register(defaults:[DropScene.deviceGravityValueKey : 2.0])
        UserDefaults.standard.register(defaults:[DropScene.useRandomColorKey : true])
        UserDefaults.standard.register(defaults:[DropScene.ballRadiusKey : 5.0])
        self.configChanged()
        self.ballDropper = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.addNewDrop),userInfo: nil, repeats: true)
    }

    private func applyBarNodeShapeLine(_ p0: CGPoint, _  p1: CGPoint, _ barNode: SKShapeNode) {
        let path = CGMutablePath()
        path.move(to: p0)
        path.addLine(to: p1)
        barNode.path = path
    }

    func updateBarNodeShape(_ barNode:SKShapeNode, fromPoint p0:CGPoint, toPoint p1:CGPoint) {
        applyBarNodeShapeLine(p0, p1, barNode)
        barNode.physicsBody = SKPhysicsBody(edgeFrom: p0, to: p1)
        barNode.physicsBody?.affectedByGravity = false
        barNode.physicsBody?.isDynamic = false
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.barNodeInCreate = nil
        self.initialTouchPoint = CGPoint.zero
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.barNodeInCreate == nil) {
            return
        }
        self.updateBarNodeShape(self.barNodeInCreate!, fromPoint: self.initialTouchPoint, toPoint: (touches.first?.location(in: self))!)
        self.barNodeInCreate = nil
        self.initialTouchPoint = CGPoint.zero
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.barNodeInCreate == nil) {
            return;
        }
        self.updateBarNodeShape(self.barNodeInCreate!, fromPoint: self.initialTouchPoint, toPoint: (touches.first?.location(in: self))!)
    }

    @objc public func doubleTapped(_ sender:UIGestureRecognizer) {
        if (sender.state == UIGestureRecognizerState.ended) {
            var touchLocation = sender.location(in: self.view)
            touchLocation = self.convertPoint(fromView: touchLocation)
            let node = self.atPoint(touchLocation)
            node.removeFromParent()
        }
    }

    override func didMove(to view: SKView) {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.doubleTapped(_:)))
        recognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(recognizer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let barNode = SKShapeNode()
        barNode.strokeColor = UIColor.white
        barNode.lineWidth = 2
        barNode.fillColor = UIColor.white

        let touch = touches.first
        let p0 = (touch?.location(in: self))!
        self.initialTouchPoint = p0
        self.applyBarNodeShapeLine(p0, CGPoint(x:p0.x+1, y:p0.y+1), barNode)
        self.addChild(barNode)
        self.barNodeInCreate = barNode
    }
}
