

import GoogleMobileAds
import UIKit


class AdManagerFluidAdSizeViewController: UIViewController {

  /// The banner view.
  @IBOutlet weak var bannerView: GAMBannerView!

  /// The banner view's width constraint.
  @IBOutlet weak var bannerViewWidthConstraint: NSLayoutConstraint!

  /// Current banner width.
  @IBOutlet weak var bannerWidthLabel: UILabel!

  /// An array of banner widths.
  let bannerWidths: [CGFloat] = [200, 250, 320]

  /// Current array index.
  var currentIndex = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    bannerView.adUnitID = Constants.AdManagerFluidAdSizeAdUnitID
    bannerView.rootViewController = self
    bannerView.adSize = GADAdSizeFluid
    bannerView.load(GAMRequest())
  }

  /// Handles the user tapping on the "Change Banner Width" button.
  @IBAction func changeBannerWidth(_ sender: Any) {
    let newWidth = bannerWidths[currentIndex % bannerWidths.count]
    currentIndex += 1
    bannerViewWidthConstraint.constant = newWidth
    bannerWidthLabel.text = "\(String(format: "%.0f", newWidth)) points"
  }

}
