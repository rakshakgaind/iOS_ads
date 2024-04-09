

import GoogleMobileAds
import UIKit

/// The constants for AdMobAdTargeting table cell identifiers.
struct AdMobAdTargetingTableCellIdentifiers {
  static let ChildDirectedCell = "childDirectedCell"
  static let ChildDirectedPickerCell = "childDirectedPickerCell"
}

/// AdMob - Ad Targeting
/// Demonstrates AdMob ad targeting.
class AdMobAdTargetingTableViewController: UITableViewController, UIPickerViewDataSource,
  UIPickerViewDelegate
{

  /// The child-directed label.
  @IBOutlet weak var childDirectedLabel: UILabel!

  /// The child-directed picker.
  @IBOutlet weak var childDirectedPicker: UIPickerView!

  /// The banner view.
  @IBOutlet weak var bannerView: GADBannerView!

  /// The child-directed options.
  var childDirectedOptions: [String]!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView(frame: CGRect.zero)

    // GADBannerView setup.
    bannerView.adUnitID = Constants.AdMobAdUnitID
    bannerView.rootViewController = self
    bannerView.delegate = self

    // Child-directed setup.
    childDirectedOptions = ["Yes", "No", "Unspecified"]
    childDirectedPicker.delegate = self
    childDirectedPicker.dataSource = self
    let childDirectedPickerMiddleRow = childDirectedOptions.count / 2
    childDirectedPicker.selectRow(
      childDirectedPickerMiddleRow, inComponent: 0,
      animated: false)
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    var currentPicker: UIView?
    if let cellIdentifier = cell?.reuseIdentifier {
      switch cellIdentifier {
      case AdMobAdTargetingTableCellIdentifiers.ChildDirectedCell:
        currentPicker = childDirectedPicker
      default:
        break
      }
    }
    if let isPickerHidden = currentPicker?.isHidden {
      hideAllPickers()
      currentPicker?.isHidden = !isPickerHidden
      tableView.reloadData()
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }

  override func tableView(
    _ tableView: UITableView, willDisplayHeaderView view: UIView,
    forSection section: Int
  ) {
    view.tintColor = UIColor.clear
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
    -> CGFloat
  {
    let cell = self.tableView(tableView, cellForRowAt: indexPath)
    if let cellIdentifier = cell.reuseIdentifier {
      if cellIdentifier == AdMobAdTargetingTableCellIdentifiers.ChildDirectedPickerCell
        && childDirectedPicker.isHidden
      {
        return 0
      }
    }
    return super.tableView(tableView, heightForRowAt: indexPath)
  }

  // MARK: - UIPickerViewDelegate

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
    -> String?
  {
    var rowTitle = ""
    switch pickerView {
    case childDirectedPicker:
      rowTitle = childDirectedOptions[row]
    default:
      rowTitle = ""
    }
    return rowTitle
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch pickerView {
    case childDirectedPicker:
      childDirectedLabel.text = childDirectedOptions[row]
    default:
      break
    }
  }

  // MARK: - UIPickerViewDataSource

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    var numOfRows = 0
    switch pickerView {
    case childDirectedPicker:
      numOfRows = childDirectedOptions.count
    default:
      numOfRows = 0
    }
    return numOfRows
  }

  // MARK: - Actions

  /// Loads an ad based on user's birthdate, gender, and child-directed status.
  @IBAction func loadTargetedAd(_ sender: AnyObject) {
    let request = GADRequest()
    if childDirectedLabel.text == "Yes" {
      GADMobileAds.sharedInstance().requestConfiguration.tag(forChildDirectedTreatment: true)
    } else if childDirectedLabel.text == "No" {
      GADMobileAds.sharedInstance().requestConfiguration.tag(forChildDirectedTreatment: false)
    }
    bannerView.load(request)
  }

  fileprivate func hideAllPickers() {
    childDirectedPicker.isHidden = true
  }

}

extension AdMobAdTargetingTableViewController: GADBannerViewDelegate {

  func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
    print("\(#function)")
  }

  func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
    print("\(#function): \(error.localizedDescription)")
  }
}