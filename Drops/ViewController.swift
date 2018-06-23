import UIKit
import SpriteKit

class ViewController: UIViewController {

    @IBOutlet var skView:SKView!
    var scene:DropScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scene = DropScene.init(size: self.view.bounds.size)
        self.skView.presentScene(scene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func configViewDidEnd(segue: UIStoryboardSegue) {
        self.scene.configChanged()
    }
}

