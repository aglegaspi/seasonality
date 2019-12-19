//
//  FarmersMarketMapView.swift
//  Seasonality
//
//  Created by Phoenix McKnight on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit
import GoogleMaps

class FarmersMarketMapView: UIView {

   lazy var searchBarOne:UISearchBar = {
        let sbo = UISearchBar()
        sbo.tag = 0
        sbo.placeholder = "1 Infinite Loop, Cupertino, CA"
        sbo.searchBarStyle = .minimal
        sbo.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .search, state: .normal)
        sbo.searchTextField.textColor = .red
    sbo.translatesAutoresizingMaskIntoConstraints = false
    sbo.alpha = 0.0
        return sbo
    }()
    
    lazy var map:GMSMapView = {
        let camera = GMSCameraPosition(latitude: 40.730610, longitude: -73.935242, zoom: 10)
        let map = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        map.translatesAutoresizingMaskIntoConstraints = false
        
          return map
      }()
    
    override init(frame: CGRect) {
          super.init(frame: UIScreen.main.bounds)
          commonInit()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
         
      }
    
    private func commonInit() {
        self.addSubview(searchBarOne)
        self.addSubview(map)
        configureSearchBarConstriants()
        configureMapConstraints()
    }
    
    private func configureMapConstraints() {
          
        NSLayoutConstraint.activate([
               map.topAnchor.constraint(equalTo: searchBarOne.bottomAnchor),
               map.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               map.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               map.bottomAnchor.constraint(equalTo: self.bottomAnchor)
           ])
       }

    private func configureSearchBarConstriants() {
           NSLayoutConstraint.activate([
               searchBarOne.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 10),
               searchBarOne.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 20),
               searchBarOne.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -20)])
    }
    
}
