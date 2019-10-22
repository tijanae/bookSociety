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
        settingsPicker.backgroundColor = .lightGray
        return settingsPicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainSettingsPicker()
        setNavBarLabel()
        view.backgroundColor = .white
    }
    
    
    private func constrainSettingsPicker(){
        view.addSubview(settingsPicker)
        settingsPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingsPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                           settingsPicker.heightAnchor.constraint(equalToConstant: 250),
                           settingsPicker.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setNavBarLabel(){
        self.navigationItem.title = "Pick Default Category"
        
    }
}


