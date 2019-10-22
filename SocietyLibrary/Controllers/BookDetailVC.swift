//
//  BookDetailVC.swift
//  SocietyLibrary
//
//  Created by Tia Lendor on 10/18/19.
//  Copyright © 2019 Tia Lendor. All rights reserved.
//

import UIKit


class BookDetailVC: UIViewController {
    
    var book: BookElement!
    
//    var image: UIImage!
    
    lazy var detailImageView : UIImageView = {
        let detailImageView = UIImageView()
        return detailImageView
    }()
    
    lazy var detailTextView : UITextView = {
        let detailTextView = UITextView()
        detailTextView.textColor = .black
        detailTextView.textAlignment = .left
        detailTextView.font = .systemFont(ofSize: 18)
        detailTextView.text = book.description
        return detailTextView
    }()
    
    lazy var imageLabel : UILabel = {
        let imageLabel = UILabel()
        imageLabel.textColor = .black
        imageLabel.textAlignment = .center
        imageLabel.font = UIFont.boldSystemFont(ofSize: 20)
        imageLabel.textAlignment = .left
        imageLabel.text = self.book.author
        return imageLabel
    }()
    
    lazy var amazonButton : UIButton = {
        let amazonButton = UIButton()
        amazonButton.setImage(UIImage (named: "logo"), for: .normal)
        amazonButton.setTitleColor(.black, for: .normal)
        amazonButton.backgroundColor = .green
        amazonButton.addTarget(self, action: #selector(amazonButtonPressed), for: .touchUpInside)
        return amazonButton
    }()

    lazy var faveButton: UIBarButtonItem = {
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.bookmarks, target: self, action: #selector(addFavorite(sender:)))

        return saveButton
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white 
        addSubviews()
        constrainSubviews()
        setNavBarLabel()
        getImage()

        
    }
    
    @objc private func amazonButtonPressed(){
        print("hi")
    }
    
    func getDataFromImage() -> Data? {
        
        guard let image = detailImageView.image else { return nil }
        let bookImageAsData = image.jpegData(compressionQuality: 1.0)

        return bookImageAsData
    }
    
    
    var imageName = ""
    
    @objc private func addFavorite(sender:UIBarButtonItem!){
        print("Favorite")
        if imageName == "" {
            let savedData = FavoriteBooks(imageName: imageName, imageData: getDataFromImage()!, summary: book.description, amazonURL: book.buy_links[0].url, weeksOn: book.weeks_on_list)
            DispatchQueue.global(qos: .utility).async {
                try? BookPersistenceManager.manager.saveFavorites(bookData: savedData)
                print("stuff happened")
            }
        }
        print("ello poppet!")
    }
    
    private func setNavBarLabel(){
        self.navigationItem.title = "Book Title"
        
    }
    
    private func getImage() {
        ImageManager.manager.getImage(urlStr: book.book_image) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                self.detailImageView.image = image
                }
            }
        }
    }
    
    private func addSubviews(){
        view.addSubview(detailImageView)
        view.addSubview(detailTextView)
        view.addSubview(imageLabel)
        view.addSubview(amazonButton)
        navigationItem.rightBarButtonItem = faveButton
            
    }
    private func constrainSubviews(){
        constrainImageView()
        constrainImageLabel()
        constrainDetailTextView()
        constrainAmazonButton()
        
    }
    
    private func constrainImageView(){
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        [detailImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
         detailImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
         detailImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40),
         detailImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60)
            ].forEach{$0.isActive = true}
        
    }
    private func constrainImageLabel(){
        imageLabel.translatesAutoresizingMaskIntoConstraints = false
        [imageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         imageLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 10),
         imageLabel.heightAnchor.constraint(equalToConstant: 30),
         imageLabel.widthAnchor.constraint(equalTo: detailImageView.widthAnchor)].forEach{$0.isActive = true}
    }
    
    private func constrainDetailTextView(){
        detailTextView.translatesAutoresizingMaskIntoConstraints = false
        detailTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailTextView.topAnchor.constraint(equalTo: imageLabel.bottomAnchor, constant: 50).isActive = true
        detailTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300).isActive = true
        detailTextView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
    }
    private func constrainAmazonButton(){
        amazonButton.translatesAutoresizingMaskIntoConstraints = false
        [amazonButton.leadingAnchor.constraint(equalTo: detailImageView.trailingAnchor, constant: 10),
         amazonButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 410),
         amazonButton.heightAnchor.constraint(equalToConstant: 50),
         amazonButton.widthAnchor.constraint(equalToConstant: 80)
            ].forEach{$0.isActive = true}
    }
    
}
