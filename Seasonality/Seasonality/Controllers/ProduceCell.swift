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
       lazy var eventImage: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleToFill
           return imageView
       }()
       
       lazy var eventName: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
           label.adjustsFontSizeToFitWidth = true
           return label
       }()
       
       lazy var eventTime: UILabel = {
           let label = UILabel()
           label.textColor = .lightGray
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
           addSubview(eventImage)
           eventImage.translatesAutoresizingMaskIntoConstraints =  false
           NSLayoutConstraint.activate(
               [eventImage.heightAnchor.constraint(equalTo: self.heightAnchor),
                eventImage.widthAnchor.constraint(equalToConstant: 100),
                eventImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
       }
       
       private func constrainEventName() {
           let padding: CGFloat = 16
           addSubview(eventName)
           eventName.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [eventName.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: padding),
                eventName.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
                eventName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
       }
       
       private func constrainEventTime() {
           let padding: CGFloat = 16
           addSubview(eventTime)
           eventTime.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [eventTime.leadingAnchor.constraint(equalTo: eventName.leadingAnchor),
                eventTime.topAnchor.constraint(equalTo: eventName.bottomAnchor),
                eventTime.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)])
       }
       
       private func constrainFavoriteImage() {
           let padding: CGFloat = 16
           addSubview(favoriteButton)
           favoriteButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate(
               [favoriteButton.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 275),
                favoriteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
                favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
                favoriteButton.heightAnchor.constraint(equalToConstant: 25)
           ])
       }
       
   }
