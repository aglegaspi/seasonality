
import UIKit
//import Firebase

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func showAlert(title: String, message: String) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
           alertController.addAction(okAction)
           present(alertController, animated: true, completion: nil)
       }
       
       func showAlert(title: String, message: String, handler: @escaping (UIAlertController) -> Void) {
           let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           handler(alertController)
       }
    
//    fileprivate func checkLoggedInUserStatus() {
//        if Auth.auth().currentUser == nil {
//            DispatchQueue.main.async {
//
//                let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.welcomeViewController) as! WelcomeViewController
//
//                let navController = UINavigationController(rootViewController: welcomeVC)
//                navController.navigationBar.barStyle = .black
//
//                let welcomeNavigationController = UINavigationController(rootViewController: welcomeVC)
//                welcomeNavigationController.modalPresentationStyle = .fullScreen
//                self.present(welcomeNavigationController, animated: false, completion: nil)
//                return
//            }
//        }
//    }
    
//    @objc func handleSignOutButtonTapped() {
//        let signOutAction = UIAlertAction(title: "Sign Out", style: .destructive) { (action) in
//            do {
//                try Auth.auth().signOut()
//
//                self.dismiss(animated: true, completion: nil)
//
//            } catch let err {
//                print("Failed to sign out with error", err)
//                Utilities.showAlert(on: self, style: .alert, title: "Sign Out Error", message: err.localizedDescription)
//            }
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        Utilities.showAlert(on: self, style: .actionSheet, title: nil, message: nil, actions: [signOutAction, cancelAction], completion: nil)
//    }
}

extension Date {
  // get an ISO timestamp
  static func getISOTimestamp() -> String {
    let isoDateFormatter = ISO8601DateFormatter()
    let timestamp = isoDateFormatter.string(from: Date())
    return timestamp
  }
}

extension String {
  // create a formatted date from ISO
  // e.g "MMM d, yyyy hh:mm a"
  // e.g usage addedAt.formattedDate("MMM d, yyyy")
  public func formatISODateString(dateFormat: String) -> String {
    var formatDate = self
    let isoDateFormatter = ISO8601DateFormatter()
    if let date = isoDateFormatter.date(from: self) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = dateFormat
      formatDate = dateFormatter.string(from: date)
    }
    return formatDate
  }
  
  // e.g usage createdAt.date()
  public func date() -> Date {
    var date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    if let isoDate = isoDateFormatter.date(from: self) {
      date = isoDate
    }
    return date
  }
}
