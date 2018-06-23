import UIKit
import SpriteKit

class ViewController: UIViewController {
    @IBOutlet var ballRadiusSlider:UISlider!
    @IBOutlet var skView:SKView!
    var scene:DropScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scene = DropScene.init(size: self.view.bounds.size)
        self.skView.presentScene(scene)
        self.ballRadiusSlider.maximumValue = DropScene.maxBallSize
        self.ballRadiusSlider.minimumValue = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ballRadiusSlider.isHidden = !UserDefaults.standard.bool(forKey: DropScene.showBallRadiusBarKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func configViewDidEnd(segue: UIStoryboardSegue) {
        self.scene.configChanged()
        self.ballRadiusSlider.isHidden = !UserDefaults.standard.bool(forKey: DropScene.showBallRadiusBarKey)
    }
    
    @IBAction func adjustBallRadiusSetting(sender: UISlider) {
        UserDefaults.standard.set(sender.value, forKey:DropScene.ballRadiusKey)
        self.scene.configChanged()
    }
}

