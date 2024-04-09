import UIKit

class MainViewController: UITableViewController {
  //MARK: - Variables(API Demo names)
  var APIDemoNames: [String]!

  // Segue identifiers.
  var identifiers: [String]!

  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    APIDemoNames = ["AdMob - Ad Delegate", "AdMob - Ad Targeting", "AdMob - Banner Sizes",
      "AdMob - Native Custom Mute This Ad",
      "AdManager - PPID", "AdManager - Custom Targeting", "AdManager - Category Exclusions",
      "AdManager - Multiple Ad Sizes", "AdManager - App Events", "AdManager - Fluid Ad Size",
      "AdManager - Custom Video Controls"]
    identifiers = ["adDelegateSegue", "adTargetingSegue", "bannerSizesSegue", "customMuteSegue",
      "PPIDSegue", "customTargetingSegue", "categoryExclusionsSegue",
      "multipleAdSizesSegue", "appEventsSegue", "fluidAdSizeSegue",
      "customControlsSegue"]
      APIDemoNames
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let indexPathSelected = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPathSelected, animated: animated)
    }
  }

  //MARK: - Table View delegate and datasource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return APIDemoNames.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell")!
    cell.textLabel!.text = APIDemoNames[indexPath.row]

    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = indexPath.row
    if row < identifiers.count {
      performSegue(withIdentifier: identifiers[row], sender: self)
    }
  }

}
