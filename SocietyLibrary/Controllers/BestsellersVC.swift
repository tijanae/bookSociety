//
//  ViewController.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class BestsellersVC: UIViewController {

    var bestBooks = [Category]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpDelegates()
    }
    private func setUpDelegates(){
        bookPicker.delegate = self
        bookPicker.dataSource = self
        
    }
    private func setUpView(){
        self.navigationItem.title = "NYT Bestsellers"
        view.backgroundColor = .white
    }
    lazy var bookPicker: UIPickerView = {
      let bookPicker = UIPickerView()
        return bookPicker
    }()

}
extension BestsellersVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bestBooks.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let book =  bestBooks[row]
        return book
    }
    
    
}

