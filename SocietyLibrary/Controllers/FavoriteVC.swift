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
               favoritePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//               favoritePicker.heightAnchor.constraint(equalToConstant: 250),
//               favoritePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
           ])
       }

    private func setNavBarLabel(){
        self.navigationItem.title = "Pick Default Category"
        
    }
}
