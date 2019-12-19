//
//  DetailFarmerView.swift
//  Seasonality
//
//  Created by Phoenix McKnight on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class DetailFarmerView: UIView {

   
      lazy var marketName:UILabel = {
          let md = UILabel(font: UIFont(name: "Verdana", size: 14)!)
          return md
      }()
      
      lazy var  marketAddress:UILabel = {
          let gl = UILabel(font: UIFont(name: "Verdana", size: 14)!)
          return gl
      }()
      
      lazy var marketURL:UILabel = {
          let gl = UILabel(font: UIFont(name: "Verdana", size: 14)!)
                   return gl
         
      }()
      
      lazy var tapGestureMarketURL:UITapGestureRecognizer = {
          let tgtm = UITapGestureRecognizer()
          // tgtm.addTarget(self, action: #selector(tapGestureTapped))
          return tgtm
      }()
      
      lazy var phoneNumber:UILabel = {
          let vn = UILabel(font: UIFont(name: "Verdana", size: 14)!)
          return vn
      }()
      
      lazy var marketImage:UIImageView = {
          let ei = UIImageView()
        ei.image = UIImage(systemName: "photo")
          return ei
          
      }()
      
      
      lazy var hoursOpenAndSeason:UILabel = {
          let note = UILabel(font: UIFont(name: "Verdana", size: 14)!)
          return note
      }()
    lazy var produceCollectionView:UICollectionView = {
        var layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout(placeHolder: "placeHolder")
        let colletionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout )
        colletionView.register(ProduceCollectionViewCell.self, forCellWithReuseIdentifier: RegisterCells.produceCollectionCell.rawValue)
        colletionView.backgroundColor = .clear
        return colletionView
    }()
//    lazy var listTableView:UITableView = {
//
//        let ltv = UITableView()
//        ltv.register(ListTableViewCell.self, forCellReuseIdentifier: RegisterCells.listTableViewCell.rawValue)
//        ltv.backgroundColor = .clear
//        return ltv
//    }()
    
      
    lazy var arrangedSubViews = [self.marketName,self.marketAddress,self.phoneNumber,self.hoursOpenAndSeason,self.marketURL]
      
      lazy var farmerStackView:UIStackView = {
          
          let tmsv = UIStackView(arrangedSubviews: arrangedSubViews)
          tmsv.axis = .vertical
          tmsv.distribution = .fillEqually
          tmsv.alignment = .fill
          tmsv.spacing = 10
          tmsv.translatesAutoresizingMaskIntoConstraints = false
          
          return tmsv
          
      }()
      
      
      override init(frame: CGRect) {
          super.init(frame: UIScreen.main.bounds)
          commonInit()
          
      }
      
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          // commonInit()
      }
      private func commonInit() {
          addArrangedSubviewsToView()
          addEventImageConstraints()
          configureStackViewConstraints()
         produceCollectionViewConstraints()
        marketURL.addGestureRecognizer(tapGestureMarketURL)
      }
      
      private func addArrangedSubviewsToView() {
          for newView in arrangedSubViews {
              self.addSubview(newView)
              
          }
          
          marketImage.translatesAutoresizingMaskIntoConstraints = false
          marketURL.translatesAutoresizingMaskIntoConstraints = false
          farmerStackView.translatesAutoresizingMaskIntoConstraints = false
          
        produceCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
          self.addSubview(marketImage)
          self.addSubview(marketURL)
          self.addSubview(farmerStackView)
          self.addSubview(produceCollectionView)
      }
      
      private func addEventImageConstraints() {
          
          NSLayoutConstraint.activate([
              marketImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
              marketImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              marketImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              
              marketImage.heightAnchor.constraint(equalToConstant: self.frame.height * 0.3)
          ])
      }
     
      private func configureStackViewConstraints() {
          NSLayoutConstraint.activate([
              farmerStackView.topAnchor.constraint(equalTo: marketImage.bottomAnchor,constant: 10),
              farmerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              farmerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              
              farmerStackView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.3)
          ])
          
          
      }
    
   
    
        private func produceCollectionViewConstraints() {
            NSLayoutConstraint.activate([
                produceCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                produceCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                produceCollectionView.topAnchor.constraint(equalTo: farmerStackView.bottomAnchor),
                produceCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
           
    
//    private func listTableViewConstraints() {
//        NSLayoutConstraint.activate([
//            listTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            listTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            listTableView.topAnchor.constraint(equalTo: farmerStackView.bottomAnchor),
//            listTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
       
}
