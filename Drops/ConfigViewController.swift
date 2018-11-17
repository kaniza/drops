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
    @IBOutlet var showBallRaiusSwitch:UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.gravitySlider.maximumValue = 9.8
        self.gravitySlider.minimumValue = 1.0
        self.deviceGravitySlider.maximumValue = 8.0
        self.deviceGravitySlider.minimumValue = 0.5
        self.ballRadiusSlider.maximumValue = DropScene.maxBallSize
        self.ballRadiusSlider.minimumValue = 3
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.gravitySwitch.isOn = UserDefaults.standard.bool(forKey: DropScene.useDeviceTiltForGravityKey)
        self.colorSwitch.isOn = UserDefaults.standard.bool(forKey: DropScene.useRandomColorKey)
        self.gravitySlider.value = UserDefaults.standard.float(forKey: DropScene.gravityValueKey)
        self.deviceGravitySlider.value = UserDefaults.standard.float(forKey: DropScene.deviceGravityValueKey)
        self.ballRadiusSlider.value = UserDefaults.standard.float(forKey: DropScene.ballRadiusKey)
        self.showBallRaiusSwitch.isOn = UserDefaults.standard.bool(forKey: DropScene.showBallRadiusBarKey)
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

    @IBAction func toggleShowBallRadiusBar(sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey:DropScene.showBallRadiusBarKey)
    }
}
