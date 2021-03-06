import UIKit
import AVKit

class WelcomeViewController: UIViewController {
    
    //    @IBOutlet weak var loginButton: UIButton!
    //    @IBOutlet weak var signUpButton: UIButton!
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view is supposed to load")
        view.backgroundColor = .black
        // Do any additional setup after loading the view.
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide the navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Set up video in the background
        setUpVideo()
    }
    
    func setUpUI() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpVideo() {
        
        // Get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "background", ofType: "mp4")
        
        guard bundlePath != nil else {
            print("it is nil")
            return
        }
        
        // Create a URL from it
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //Muted the video for now
        videoPlayer?.isMuted = true
        
        // Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust the size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it to the view and play it
        videoPlayer?.playImmediately(atRate: 1.0)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //Make the navigation bar appear again
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        //Stop the video from playing
        videoPlayer?.pause()
        videoPlayerLayer?.player = nil
        videoPlayerLayer?.removeFromSuperlayer()
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        
        let loginVC = LoginViewController()
        self.present(loginVC, animated: true)
        //navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    @IBAction func singUpTapped(_ sender: UIButton) {
        
        let signUpVC = SignUpViewController()
            self.present(signUpVC, animated: true)
            //navigationController?.pushViewController(signUpVC, animated: true)
        
    }
}




