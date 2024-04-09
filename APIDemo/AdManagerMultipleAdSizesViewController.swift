

import GoogleMobileAds
import UIKit


class AdManagerMultipleAdSizesViewController: UIViewController, GADAdSizeDelegate {

  /// The custom banner size (120x20) switch.
  @IBOutlet weak var GADAdSizeCustomBannerSwitch: UISwitch!

  /// The banner size (320x50) switch.
  @IBOutlet weak var GADAdSizeBannerSwitch: UISwitch!

  /// The medium rectangle size (300x250) switch.
  @IBOutlet weak var GADAdSizeMediumRectangleSwitch: UISwitch!

  /// The banner view.
  var bannerView: GAMBannerView!

  override func viewDidLoad() {
    super.viewDidLoad()
    bannerView = GAMBannerView(adSize: GADAdSizeBanner)
    bannerView.adUnitID = Constants.AdManagerAdSizesAdUnitID
    bannerView.rootViewController = self
    bannerView.adSizeDelegate = self

    view.addSubview(bannerView)
    bannerView.translatesAutoresizingMaskIntoConstraints = false

    // Layout constraints that align the banner view to the bottom center of the screen.
    view.addConstraint(
      NSLayoutConstraint(
        item: bannerView!, attribute: .bottom, relatedBy: .equal,
        toItem: bottomLayoutGuide, attribute: .top, multiplier: 1, constant: 0))
    view.addConstraint(
      NSLayoutConstraint(
        item: bannerView!, attribute: .centerX, relatedBy: .equal,
        toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
  }

  // MARK: - Actions

  /// Loads an ad.
  @IBAction func loadAd(_ sender: AnyObject) {
    guard
      GADAdSizeCustomBannerSwitch.isOn || GADAdSizeBannerSwitch.isOn
        || GADAdSizeMediumRectangleSwitch.isOn
    else {
      let alert = UIAlertController(
        title: "Load Ad Error",
        message: "Failed to load ad. Please select at least one ad size.",
        preferredStyle: .alert)
      let alertAction = UIAlertAction(
        title: "OK",
        style: .cancel,
        handler: nil)
      alert.addAction(alertAction)
      self.present(alert, animated: true, completion: nil)
      return
    }

    var adSizes = [NSValue]()
    if GADAdSizeCustomBannerSwitch.isOn {
      let customGADAdSize = GADAdSizeFromCGSize(CGSize(width: 120, height: 20))
      adSizes.append(NSValueFromGADAdSize(customGADAdSize))
    }
    if GADAdSizeBannerSwitch.isOn {
      adSizes.append(NSValueFromGADAdSize(GADAdSizeBanner))
    }
    if GADAdSizeMediumRectangleSwitch.isOn {
      adSizes.append(NSValueFromGADAdSize(GADAdSizeMediumRectangle))
    }

    bannerView.validAdSizes = adSizes
    bannerView.load(GAMRequest())
  }

  // MARK: - GADAdSizeDelegate

  /// Called before the ad view changes to the new size.
  func adView(_ bannerView: GADBannerView, willChangeAdSizeTo size: GADAdSize) {
    // The bannerView calls this method on its adSizeDelegate object before the banner updates its
    // size, allowing the application to adjust any views that may be affected by the new ad size.
    print("Make your app layout changes here, if necessary. New banner ad size will be \(size).")
  }

}
