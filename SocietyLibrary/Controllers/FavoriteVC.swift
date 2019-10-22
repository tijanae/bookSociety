//
//  FavoriteVC.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {
    
    lazy var favoritePicker : UIPickerView = {
        let favoritePicker = UIPickerView()
        return favoritePicker
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        constrainFavoritePicker()
        
    }
  
    
    private func constrainFavoritePicker(){
           view.addSubview(favoritePicker)
           favoritePicker.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               favoritePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               favoritePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -350),
               favoritePicker.heightAnchor.constraint(equalToConstant: 350),
               favoritePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
           ])
       }

    private func setNavBarLabel(){
        self.navigationItem.title = "Pick Default Category"
        
    }
}
