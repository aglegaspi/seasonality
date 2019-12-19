//
//  FarmersMarketMap.swift
//  Seasonality
//
//  Created by Phoenix McKnight on 12/18/19.
//  Copyright © 2019 Jack Wong. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class FarmersMarketMap: UIViewController {

    //MARK: Variables
    var farmersMarket = [Market]() {
        didSet {
            loadAnnotations(farmerData: self.farmersMarket)
        }
    }
    var locationManager = CLLocationManager()
    let cameraZoom:Float = 12
    let defaultLocation = CLLocationCoordinate2D(latitude: 40.752920, longitude: -73.957230)
   
    var searchedLocation:CLLocation = CLLocation(latitude: 0.0, longitude: 0.0) {
        didSet {
            loadFarmersMarketData(lat: self.searchedLocation.coordinate.latitude, long: self.searchedLocation.coordinate.longitude)
             farmerView.map.camera = GMSCameraPosition(latitude: self.searchedLocation.coordinate.latitude, longitude: self.searchedLocation.coordinate.longitude, zoom: cameraZoom)
            
    }
    }
    
   //MARK: Views
    var farmerView = FarmersMarketMapView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(farmerView)
        setDelegates()
        showSearchBar()
        locationAuthorization()
        // Do any additional setup after loading the view.
    }
    
private func locationAuthorization() {
      let status = CLLocationManager.authorizationStatus()
      switch status {
          
      case .authorizedAlways,.authorizedWhenInUse:
        farmerView.map.isMyLocationEnabled = true
          locationManager.requestLocation()
          locationManager.startUpdatingLocation()
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
//        guard let coordinates = locationManager.location?.coordinate else {
//            self.showAlert(title: "Error", message: "Could Not Locate User")
//            return
//        }
        guard let location = locationManager.location else {
            self.showAlert(title: "Error", message: "Could Not Locate User")
            return
        }
       
        searchedLocation = location
        
        
      case .denied:
        self.showAlert(title: "Enter an Address To See Nearby Farmers Markets", message: "")

      default:
          locationManager.requestWhenInUseAuthorization()
      }
  }
    private func showSearchBar() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.transitionCrossDissolve], animations: {
                   self.farmerView.searchBarOne.alpha = 1.0
                     
                 }, completion: nil)
    }
    
    private func setDelegates() {
        locationManager.delegate = self
        farmerView.searchBarOne.delegate = self
        farmerView.map.delegate = self
    }
    
    private func getAddress(address:String) {
        AddressDecoder.shared.addressDecoder(fromAddress: address) { [weak self](result) in
            switch result  {
            case .success(let location):
                self?.searchedLocation = location
                
            case .failure(let error):
                self?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
   
    private func loadFarmersMarketData(lat:Double?,long:Double?) {
        
        guard let lat = lat, let long = long else {
            showAlert(title: "Error", message: "Could Not Recognize Coordinates")
            return
        }
            MarketAPIClient.manager.getMarkets(city: nil, lat: lat, long: long) { [weak self](result) in
                switch result {
                case .success(let market):
                    self?.farmersMarket = market
                case .failure(let error):
                    self?.showAlert(title: "Error Loading Data", message: error.localizedDescription)
                }
            }
        }
    
    private func loadAnnotations(farmerData:[Market]) {
        for venue in farmerData {
            guard let latitude = Double(venue.latitude!) , let longitude = Double(venue.longitude!) else {
                return
            }
            
            let mark = GMSMarker(position: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            
            mark.title = venue.marketName
            mark.snippet = venue.operationHours
            mark.map = farmerView.map
            
        
           
        
            
        }
        }
    @objc private func tapped() {
        print("tapped")
    }
}
extension FarmersMarketMap:UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            
        farmerView.searchBarOne.setImage(UIImage(systemName: "magnifyingglass.circle.fill"), for: .search, state: .normal)

            return true
        }
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
          
            farmerView.searchBarOne.setImage(UIImage(systemName: "magnifyingglass.circle"), for: .search, state: .normal)
            
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          
         
                searchBar.placeholder = "1 Infinite Loop, Cupertino, CA"
            farmerView.searchBarOne.resignFirstResponder()
                
          
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            guard let addressText = searchBar.text else {
                showAlert(title: "Error", message: "Invalid Input")
                return
            }
            guard addressText.isvalidAddress else {
                showAlert(title: "Error", message: "Invalid Address Syntax")
                searchBar.text = ""
                searchBar.placeholder = " Infinite Loop, Cupertino, CA"
                return
            }
            
            getAddress(address: addressText)
//            let annotations = self.map.annotations
            
        
                //self.map.removeAnnotations(annotations)
             //   guard let search = searchBarOne.text else {return}
            //    guard search != "" else {return}
             //   searchStringQuery = search.capitalized
                //searchBarOne.placeholder = searchBarOne.text?.capitalized
                
                //searchBar.resignFirstResponder()
                
           
               // navigationItem.title = search.capitalized
}
}
extension FarmersMarketMap:CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           print("New Location: \(locations)")
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           print("Authorization status changed to \(status.rawValue)")
        locationAuthorization()
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
           print(error)
       }
}
extension FarmersMarketMap:GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
marker.icon = GMSMarker.markerImage(with: UIColor.green)
        
        guard let index =  farmersMarket.firstIndex(where: {$0.marketName == marker.title}) else {
            return
        }
        sleep(UInt32(0.50))
      let detailVC = DetailFarmerViewController()
        detailVC.market = farmersMarket[index]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
