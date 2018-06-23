//
//  ConfigViewController.swift
//  Drops
//
//  Created by Tetsuya Kaneuchi on 2018/06/23.
//  Copyright © 2018年 Tetsuya Kaneuchi. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet var gravitySwitch:UISwitch!
    @IBOutlet var colorSwitch:UISwitch!
    @IBOutlet var gravitySlider:UISlider!
    @IBOutlet var deviceGravitySlider:UISlider!
    @IBOutlet var ballRadiusSlider:UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.gravitySlider.maximumValue = 9.8
        self.gravitySlider.minimumValue = 1.0
        self.deviceGravitySlider.maximumValue = 4.0
        self.deviceGravitySlider.minimumValue = 0.5
        self.ballRadiusSlider.maximumValue = 10.0
        self.ballRadiusSlider.minimumValue = 3
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gravitySwitch.isOn = UserDefaults.standard.bool(forKey: DropScene.useDeviceTiltForGravityKey)
        self.colorSwitch.isOn = UserDefaults.standard.bool(forKey: DropScene.useRandomColorKey)
        self.gravitySlider.value = UserDefaults.standard.float(forKey: DropScene.gravityValueKey)
        self.deviceGravitySlider.value = UserDefaults.standard.float(forKey: DropScene.deviceGravityValueKey)
        self.ballRadiusSlider.value = UserDefaults.standard.float(forKey: DropScene.ballRadiusKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleGravitySetting(sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey:DropScene.useDeviceTiltForGravityKey)
    }


    @IBAction func toggleColorSetting(sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey:DropScene.useRandomColorKey)
    }

    @IBAction func adjustGravitySetting(sender: UISlider) {
        UserDefaults.standard.set(sender.value, forKey:DropScene.gravityValueKey)
    }

    @IBAction func adjustDeviceGravitySetting(sender: UISlider) {
        UserDefaults.standard.set(sender.value, forKey:DropScene.deviceGravityValueKey)
    }

    @IBAction func adjustBallRadiusSetting(sender: UISlider) {
        UserDefaults.standard.set(sender.value, forKey:DropScene.ballRadiusKey)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
