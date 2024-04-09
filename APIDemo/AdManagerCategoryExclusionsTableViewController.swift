

import GoogleMobileAds
import UIKit

class AdManagerCategoryExclusionsTableViewController: UITableViewController {

  /// The no exclusions banner view.
  @IBOutlet weak var noExclusionsBannerView: GAMBannerView!

  /// The exclude dogs banner view.
  @IBOutlet weak var excludeDogsBannerView: GAMBannerView!

  /// The exclude cats banner view.
  @IBOutlet weak var excludeCatsBannerView: GAMBannerView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.tableFooterView = UIView(frame: CGRect.zero)

    noExclusionsBannerView.adUnitID = Constants.AdManagerCategoryExclusionsAdUnitID
    noExclusionsBannerView.rootViewController = self
    let noExclusionsRequest = GAMRequest()
    noExclusionsBannerView.load(noExclusionsRequest)

    excludeDogsBannerView.adUnitID = Constants.AdManagerCategoryExclusionsAdUnitID
    excludeDogsBannerView.rootViewController = self
    let excludeDogsRequest = GAMRequest()
    excludeDogsRequest.categoryExclusions = [Constants.CategoryExclusionDogs]
    excludeDogsBannerView.load(excludeDogsRequest)

    excludeCatsBannerView.adUnitID = Constants.AdManagerCategoryExclusionsAdUnitID
    excludeCatsBannerView.rootViewController = self
    let excludeCatsRequest = GAMRequest()
    excludeCatsRequest.categoryExclusions = [Constants.CategoryExclusionCats]
    excludeCatsBannerView.load(excludeCatsRequest)
  }

  // MARK: - Table View

  override func tableView(
    _ tableView: UITableView, willDisplayHeaderView view: UIView,
    forSection section: Int
  ) {
    view.tintColor = UIColor.clear
  }

}
