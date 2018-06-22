import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = self.view as! SKView
        let scene = DropScene.init(size: self.view.bounds.size)
        skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

