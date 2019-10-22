//
//  SettingsVC.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    
    lazy var settingsPicker : UIPickerView = {
        let settingsPicker = UIPickerView()
        return settingsPicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainSettingsPicker()
        setNavBarLabel()
        
    }
    
    
    private func constrainSettingsPicker(){
        view.addSubview(settingsPicker)
        settingsPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //               favoritePicker.heightAnchor.constraint(equalToConstant: 250),
            //               favoritePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setNavBarLabel(){
        self.navigationItem.title = "Pick Default Category"
        
    }
}


