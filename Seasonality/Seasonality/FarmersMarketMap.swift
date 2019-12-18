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
    var locationManager = CLLocationManager()
    let cameraZoom:Float = 15
    let currentLocation = CLLocationCoordinate2D(latitude: 40.752920, longitude: -73.957230)
    var searchStringQuery = ""
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
          
         
                searchStringQuery = ""
                searchBar.placeholder = ""
            farmerView.searchBarOne.resignFirstResponder()
                
          
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
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
