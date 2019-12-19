//
//  ListTableViewCell.swift
//  CTA-Phoenix
//
//  Created by Phoenix McKnight on 12/2/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import UIKit

//protocol ListTableViewCellDelegate:AnyObject {
//    func favoriteSymbolPressed(tag:Int)
//}

enum RegisterCells:String {
    case produceCollectionCell
    case commentCollectionCell
}

class CommentCollectionViewCell: UICollectionViewCell {
    //MARK: View Objects
  
    
//    lazy var favoriteSymbol:UIButton = {
//        let fs = UIButton()
//        fs.setImage(UIImage(systemName: "suit.heart"), for: .normal)
//        fs.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
//
//        fs.contentMode = .scaleAspectFit
//        return fs
//    }()
    
    lazy var userName:UILabel = {
        let dl = UILabel(font: UIFont(name: "Verdana-Bold", size: 16)!)
        return dl
    }()
    
    lazy var post:UITextView = {
        let ail = UITextView()
    
        ail.backgroundColor = .clear
           ail.contentMode = .center
        ail.textColor = .black
         ail.font = UIFont(name: "Verdana", size: 15)
        return ail
        
    }()
    lazy var viewArray = [self.userName,self.post]
    
    //MARK:Variables
//    var isFavorited = false  {
//
//        didSet {
//            self.isFavorited ? favoriteSymbol.setImage(UIImage(systemName: "heart.fill"), for: .normal) : favoriteSymbol.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
//    }
//    var cellID:String?
//
//    var imageURL:String?
//
//    var changeColorOfBorderCellFunction: (()->()) = {}
    
 //   weak var delegate:ListTableViewCellDelegate?
    
   
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        addViewsToContentView()
        configureuserNameConstraints()
        configureAdditionalDetailsConstraints()
        contentView.backgroundColor = .clear
    }
    
    //MARK: @Ojbc Functions
//    @objc private func favoriteButtonPressed(_ sender:UIButton) {
//        delegate?.favoriteSymbolPressed(tag: sender.tag)
//    }
    
    
    //MARK: Constraints
    private func addViewsToContentView() {
        for newView in viewArray {
            contentView.addSubview(newView)
            newView.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
   
    private func configureuserNameConstraints() {
        NSLayoutConstraint.activate([
            
            userName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            userName.topAnchor.constraint(equalTo: contentView.topAnchor)
            
        ])
    }
    private func configureAdditionalDetailsConstraints() {
        NSLayoutConstraint.activate([
            
            post.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            post.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            post.topAnchor.constraint(equalTo: userName.bottomAnchor,constant: 10),
            
            post.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
        
    }
    
//    private func configureFavoriteSymbolConstraints() {
//        NSLayoutConstraint.activate([
//            favoriteSymbol.leadingAnchor.constraint(equalTo: userName.trailingAnchor),
//
//            favoriteSymbol.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            favoriteSymbol.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.4),
//
//            favoriteSymbol.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//
//            favoriteSymbol.heightAnchor.constraint(equalToConstant: contentView.frame.height * 0.4)
//        ])
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
