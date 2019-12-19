//
//  DetailFarmerViewController.swift
//  Seasonality
//
//  Created by Phoenix McKnight on 12/19/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit

class DetailFarmerViewController: UIViewController {

    //MARK: Views
    
    var detailFarmerView = DetailFarmerView()
    
    var market:Market!
   
    var produce = [Produce]() {
        didSet {
            detailFarmerView.produceCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailFarmerView)
        setUpDelegates()
        setUpObjectsWithData()
        view.setGradientBackground(colorTop: .green, colorBottom: .white)
       
        // Do any additional setup after loading the view.
    }
    private func setUpDelegates() {
        detailFarmerView.produceCollectionView.delegate = self
        detailFarmerView.produceCollectionView.dataSource = self
    }
    private func setUpObjectsWithData() {
        detailFarmerView.marketName.text = market.marketName
        detailFarmerView.hoursOpenAndSeason.text = """

Hours Open : \(market.operationHours ?? "Hours Open Unavailable")
Available : \(market.operationSeason ?? "Seasons Open Unavailable")

"""
        
        detailFarmerView.marketAddress.text = "Address : \(market.addressLine1 ?? "Address Unavailable")"
        detailFarmerView.marketURL.setTitle("Market URL : \(market.marketLink?.url ?? "URL Unavailable")",for: .normal)
        detailFarmerView.phoneNumber.text = "Phone Number : \(market.phone ?? "Phone Number Unavailable")"

         detailFarmerView.marketURL.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    @objc private func buttonTapped() {
        self.showAlert(title: "This Action Will Take You to an Unaffliated Third-Party Website", message: "Are You Sure?") { [weak self](result) in
            self?.handleLeavingSite(with: result)
    }
    }
    private func handleLeavingSite(with result: Result<Void, AppError>) {
        switch result {
                     
                 case .success():
                    guard let url = self.market.marketLink?.url else {
                        self.showAlert(title: "Invalid URL", message: "")
                     
                     return}
                 
                 guard let urlstr = URL(string: url) else {return}
                 
                 UIApplication.shared.open(urlstr, options: [:], completionHandler: nil)
                     
                 case .failure(.badURL):
                     print("canceled")
        default:
            print("-")
             }
    }
    private func getAllProduce() {
        FirestoreService.manager.getAllProduce { [weak self](result) in
            switch result {
            case .success(let produceData):
                self?.produce = produceData
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension DetailFarmerViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let produceInCell = produce[indexPath.item]
        guard let cell = detailFarmerView.produceCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCells.produceCollectionCell.rawValue, for: indexPath) as? ProduceCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.photoImage.getImage(with: produceInCell.image) { (result) in
            switch result {
            case .success(let image):
                cell.photoImage.image = image
            case .failure(let error):
                print(error)
            
            }
        }

        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
       
    }
}
