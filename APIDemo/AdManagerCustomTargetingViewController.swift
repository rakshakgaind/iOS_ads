

import GoogleMobileAds
import UIKit


class AdManagerCustomTargetingViewController: UIViewController, UIPickerViewDataSource,
  UIPickerViewDelegate
{

  /// The constant for the customTargeting dictionary sport preference key.
  let sportPreferenceKey = "sportpref"

  /// The AdManager banner view.
  @IBOutlet weak var bannerView: GAMBannerView!

  /// The favorite sports view picker.
  @IBOutlet weak var favoriteSportsPicker: UIPickerView!

  /// The favorite sports options.
  var favoriteSportsOptions: [String]!

  override func viewDidLoad() {
    super.viewDidLoad()
    bannerView.adUnitID = Constants.AdManagerCustomTargetingAdUnitID
    bannerView.rootViewController = self
    favoriteSportsPicker.delegate = self
    favoriteSportsPicker.dataSource = self
    favoriteSportsOptions = [
      "Baseball", "Basketball", "Bobsled", "Football", "Ice Hockey",
      "Running", "Skiing", "Snowboarding", "Softball",
    ]
    let favoriteSportsPickerMiddleRow = favoriteSportsOptions.count / 2
    favoriteSportsPicker.selectRow(
      favoriteSportsPickerMiddleRow, inComponent: 0,
      animated: false)
  }

  // MARK: - UIPickerViewDelegate

  func pickerView(
    _ pickerView: UIPickerView, titleForRow row: Int,
    forComponent component: Int
  ) -> String? {
    return favoriteSportsOptions[row]
  }

  // MARK: - UIPickerViewDataSource

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return favoriteSportsOptions.count
  }

  // MARK: - Actions

  @IBAction func loadAd(_ sender: AnyObject) {
    let row = favoriteSportsPicker.selectedRow(inComponent: 0)
    let request = GAMRequest()
    request.customTargeting = [sportPreferenceKey: favoriteSportsOptions[row]]
    bannerView.load(request)
  }

}
