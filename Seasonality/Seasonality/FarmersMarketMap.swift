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
    let cameraZoom:Float = 13
    let defaultLocation = CLLocationCoordinate2D(latitude: 40.752920, longitude: -73.957230)
   
    var searchedLocation:CLLocation = CLLocation(latitude: 0.0, longitude: 0.0) {
        didSet {
            loadFarmersMarketData(lat: self.searchedLocation.coordinate.latitude, long: self.searchedLocation.coordinate.longitude)
            
            
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
        
        guard let coordinates = locationManager.location?.coordinate else {
            self.showAlert(title: "Error", message: "Could Not Locate User")
            return
        }
        farmerView.map.camera = GMSCameraPosition(latitude: coordinates.latitude, longitude: coordinates.longitude, zoom: cameraZoom)
       
        loadFarmersMarketData(lat: coordinates.latitude, long: coordinates.longitude)
        
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
