

import GoogleMobileAds
import UIKit


class AdManagerAppEventsViewController: UIViewController, GADAppEventDelegate {
    
    //MARK: - IBOutlets
    @IBOutlet weak var bannerView: GAMBannerView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = Constants.AdManagerAppEventsAdUnitID
        bannerView.rootViewController = self
        bannerView.appEventDelegate = self
        bannerView.load(GAMRequest())
    }
    
    //MARK: - Function (GADAppEventDelegate)
    func adView(_ banner: GADBannerView, didReceiveAppEvent name: String, withInfo info: String?) {
        if name == "color" {
            guard let infoString = info else { return }
            switch infoString {
            case "blue":
                view.backgroundColor = UIColor.blue
            case "red":
                view.backgroundColor = UIColor.red
            case "green":
                view.backgroundColor = UIColor.green
            default:
                break
            }
        }
    }
    
}
