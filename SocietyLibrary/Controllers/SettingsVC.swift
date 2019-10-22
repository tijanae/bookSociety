//
//  SettingsVC.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    var categoryArray = [Category]() {
        didSet{
            DispatchQueue.main.async {
                self.settingsPicker.reloadAllComponents()
            }
        }
    }
    
    lazy var settingsPicker : UIPickerView = {
        let settingsPicker = UIPickerView()
        
        return settingsPicker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainSettingsPicker()
        setNavBarLabel()
        view.backgroundColor = .white
        loadCategories()
        setUpDelegates()
        loadDefaults()
    }
    
    private func loadDefaults(){
        if let row = UserDefaults.standard.object(forKey: "selectedCategory"){
            self.settingsPicker.selectRow(row as! Int, inComponent: 0, animated: true)
        }else{
            self.settingsPicker.selectRow(0, inComponent: 0, animated: true)
        }
        
    }
    
    
    private func loadCategories(){
        BookCategoryAPIClient.manager.getCategory { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let categories):
                self.categoryArray = categories
            }
        }
        
    }
    private func setUpDelegates(){
        settingsPicker.delegate = self
        settingsPicker.dataSource = self
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
extension SettingsVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryArray.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let book =  categoryArray[row].display_name
        return book
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(row, forKey: "selectedCategory")
    }
}

