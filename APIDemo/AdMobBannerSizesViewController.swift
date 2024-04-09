

import GoogleMobileAds
import UIKit


class AdMobBannerSizesViewController: UIViewController, UIPickerViewDataSource,
  UIPickerViewDelegate
{

  /// The banner sizes picker.
  @IBOutlet weak var bannerSizesPicker: UIPickerView!

  /// The banner sizes.
  var bannerSizes: [String] = []

  /// The banner sizes mapped to GADAdSize constants.
  var ads = [
    "Banner": GADAdSizeBanner,
    "Large Banner": GADAdSizeLargeBanner,
    "Full Banner": GADAdSizeFullBanner,
    "Medium Rectangle": GADAdSizeMediumRectangle,
    "Leaderboard": GADAdSizeLeaderboard,
  ]

  /// The banner view.
  var bannerView: GADBannerView!

  override func viewDidLoad() {
    super.viewDidLoad()

    bannerSizesPicker.delegate = self
    bannerSizesPicker.dataSource = self

    switch UIDevice.current.userInterfaceIdiom {
    case .phone, .unspecified:
      bannerSizes = ["Large Banner", "Banner"]
      bannerSizesPicker.selectRow(1, inComponent: 0, animated: false)
    case .pad:
      bannerSizes = [
        "Large Banner",
        "Banner",
        "Full Banner",
        "Medium Rectangle",
        "Leaderboard",
      ]
      bannerSizesPicker.selectRow(2, inComponent: 0, animated: false)
    default:
      break
    }
  }

  // MARK: - UIPickerViewDataSource

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return bannerSizes.count
  }

  // MARK: - UIPickerViewDelegate

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
    -> String?
  {
    return bannerSizes[row]
  }

  // MARK: - Actions

  @IBAction func loadAd(_ sender: AnyObject) {
    if bannerView == nil {
      bannerView = GADBannerView()
      bannerView.adUnitID = Constants.AdMobAdUnitID
      bannerView.rootViewController = self

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

    let bannerSizeString = bannerSizes[bannerSizesPicker.selectedRow(inComponent: 0)]

    bannerView.adSize = ads[bannerSizeString]!
    bannerView.load(GADRequest())
  }

}
