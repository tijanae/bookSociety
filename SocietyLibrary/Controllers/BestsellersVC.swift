//
//  ViewController.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit

class BestsellersVC: UIViewController {
    
    var category = String()
    
    var book = [Item]() //Imgage
    
    //Array of categories
    var bestBooks = [Category](){
        didSet{
            DispatchQueue.main.async {
                self.bookPicker.reloadAllComponents()

            }
        }
    }

    //Array of books
    var bestSeller = [BestSeller](){
        
        didSet{
            DispatchQueue.main.async {
                self.booksCollectionView.reloadData()
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpDelegates()
        constrainBooksCollectionView()
        loadData() //Loads categories
        setUpConstraints()
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
    lazy var booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .darkGray
        cv.register(BestsellerBookCell.self, forCellWithReuseIdentifier: "bookCell")
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    func loadData(){
        BookCategoryAPIClient.manager.getCategory{ (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let arr):
                    DispatchQueue.main.async {
                        self.bestBooks = arr

                    }
                }
            }
        }
    }
    private func constrainBooksCollectionView(){
        view.addSubview(booksCollectionView)
        booksCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            booksCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            booksCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            booksCollectionView.heightAnchor.constraint(equalToConstant: 250),
            booksCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    private func constrainBooksPicker(){
        view.addSubview(bookPicker)
        bookPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            bookPicker.heightAnchor.constraint(equalToConstant: 250),
            bookPicker.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
    
    private func setUpConstraints(){
        constrainBooksCollectionView()
        constrainBooksPicker()
    }
    //Loads books
    private func loadBestSellers() {
        BestsellerAPIClient.manager.getBestSellers(category: category) { (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let best):
                    DispatchQueue.main.async {
                        self.bestSeller = best
//                        print(best)
                    }
                    
                }
            }
        }
    }
    //Loads images
    private func loadBookData(url: String){
        BookInfoAPIClient.manager.getBookInfo(url: url){ (result) in
            DispatchQueue.main.async {
                switch result{
                case .failure(let error):
                    print(error)
                case .success(let book):
                    self.book = book
                }
            }
        }
        
    }
    
    
}
extension BestsellersVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bestBooks.count
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let book =  bestBooks[row].display_name
        return book
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //Set categories
        category = bestBooks[row].list_name_encoded
        //Loads books
        loadBestSellers()
    }
}
extension BestsellersVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestSeller.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as? BestsellerBookCell else {return UICollectionViewCell()}
        let data = bestSeller[indexPath.row]

        let image = UIImage(named: "book")
        
//        BookInfoAPIClient.manager.getBookInfo(url: data.isbns[0].isbn10){ (result) in
//            DispatchQueue.main.async {
//                switch result{
//                case .failure(let error):
//                    print(error)
//                case .success(let book):
//                    self.book = book
//
//
//                    ImageManager.manager.getImage(urlStr: book[0].volumeInfo.imageLinks.thumbnail  ) { (result) in
//
//                        DispatchQueue.main.async {
//                            switch result{
//                            case .failure(let error):
//                                print(error)
//                            case .success(let image):
//                                cell.bookImage.image = image
//                            }
//                        }
//
//                    }
//                }
//            }
//        }
        
        cell.bookImage.image = image

        cell.bookName.text = data.book_details[0].title
        cell.bookText.text = data.book_details[0].description
        cell.backgroundColor = .lightGray
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailVC = BookDetailVC()
        let selectedBook = bestSeller[indexPath.row]
        //               detailVC.book = selectedBook
        self.navigationController?.pushViewController(detailVC, animated: true)
        //               let selectedBook = book[indexPath.row]
        //               detailVC.book = selectedBook

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 400, height: 250)
       }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let detailVC = BookDetailVC()
//            let selectedBook = book[indexPath.row]
            //               detailVC.book = selectedBook
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
}
//        BookInfoAPIClient.manager.getBookInfo(url: data.isbns[0].isbn10){ (result) in
//            DispatchQueue.main.async {
//                switch result{
//                case .failure(let error):
//                    print(error)
//                case .success(let book):
//                    self.book = book
                    
            
//                    ImageManager.manager.getImage(urlStr: book[0].volumeInfo.imageLinks.thumbnail  ) { (result) in
//
//                        DispatchQueue.main.async {
//                            switch result{
//                            case .failure(let error):
//                                print(error)
//                            case .success(let image):
//                                cell.bookImage.image = image
//                            }
//                        }
//
//                    }
                    
    
   
   


