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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailFarmerView)
        setUpDelegates()
        setUpObjectsWithData()
        view.backgroundColor = .white
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
Seasons Open : \(market.operationSeason ?? "Seasons Open Unavailable")

"""
        
        detailFarmerView.marketAddress.text = "Address \(market.addressLine1 ?? "Address Unavailable")"
        
        detailFarmerView.marketURL.text = "Market URL : \(market.contact ?? "URL Unavailable")"
        detailFarmerView.phoneNumber.text = "Phone Number : \(market.phone ?? "Phone Number Unavailable")"

        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailFarmerViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = detailFarmerView.produceCollectionView.dequeueReusableCell(withReuseIdentifier: RegisterCells.produceCollectionCell.rawValue, for: indexPath) as? ProduceCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.photoImage.image = UIImage(systemName: "photo")
        cell.mark.image = UIImage(systemName: "xmark.circle")
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        guard let cell = detailFarmerView.produceCollectionView.cellForItem(at: indexPath) as? ProduceCollectionViewCell else {
                   return
               }
        switch cell.mark.image {
        case UIImage(systemName: "checkmark.circle"):
            cell.mark.image = UIImage(systemName: "xmark.circle")
            case UIImage(systemName: "xmark.circle"):
                cell.mark.image = UIImage(systemName: "checkmark.circle")
        default:
            print("no")
        
    }
    }
}
