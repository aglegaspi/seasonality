//
//  ProduceCell.swift
//  Seasonality
//
//  Created by Alex 6.1 on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class ProduceCell: UITableViewCell {

    //weak var delegate: FavoriteCellDelegate?
       
       var isFavorited = false {
           didSet {
               if self.isFavorited == false {
                   self.favoriteButton.setImage(UIImage(named: "notfavorited"), for: .normal)
               } else {
                   self.favoriteButton.setImage(UIImage(named: "favorited"), for: .normal)
               }
           }
       }
       
   //MARK: VIEWS
       lazy var produceImage: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleToFill
           return imageView
       }()
       
       lazy var produceName: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
           label.adjustsFontSizeToFitWidth = true
           return label
       }()
       
       lazy var produceDescription: UITextField = {
           let label = UITextField()
            label.textColor = .black
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14, weight: .light)
            label.adjustsFontSizeToFitWidth = true
           return label
       }()
    
       
       lazy var favoriteButton: UIButton = {
           var button = UIButton()
           button.setImage(UIImage(named: "notfavorited"), for: . normal)
           return button
       }()
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: "EventCell")
           constraintsForViews()
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
      
       
   //MARK: CONSTRAINTS
       private func constraintsForViews() {
           constrainEventImage()
           constrainEventName()
           constrainEventTime()
           constrainFavoriteImage()
       }
       
       private func constrainEventImage() {
           addSubview(produceImage)
           produceImage.translatesAutoresizingMaskIntoConstraints =  false
           NSLayoutConstraint.activate(
               [produceImage.heightAnchor.constraint(equalTo: self.heightAnchor),
                produceImage.widthAnchor.constraint(equalToConstant: 100),
                produceImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
       }
       
       private func constrainEventName() {
           let padding: CGFloat = 16
           addSubview(produceName)
           produceName.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
            [produceName.leadingAnchor.constraint(equalTo: produceImage.trailingAnchor, constant: padding),
            produceName.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            produceName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
       }
       
       private func constrainEventTime() {
           let padding: CGFloat = 16
           addSubview(produceDescription)
           produceDescription.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
            [produceDescription.leadingAnchor.constraint(equalTo: produceName.leadingAnchor),
            produceDescription.topAnchor.constraint(equalTo: produceName.bottomAnchor),
            produceDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)])
       }
       
       private func constrainFavoriteImage() {
           let padding: CGFloat = 16
           addSubview(favoriteButton)
           favoriteButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [favoriteButton.leadingAnchor.constraint(equalTo: produceImage.trailingAnchor, constant: 275),
                favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
                favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                favoriteButton.heightAnchor.constraint(equalToConstant: 25)
           ])
       }
       
   }
