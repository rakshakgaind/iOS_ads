
import Foundation
import GoogleMobileAds
import UIKit


class CustomControlsView: UIView {

  weak var mediaContent: GADMediaContent? {
    didSet {
      if let mediaContent = mediaContent {
        controlsView.isHidden = !mediaContent.videoController.customControlsEnabled()
        mediaContent.videoController.delegate = self
        videoStatusLabel.text =
          mediaContent.hasVideoContent
          ? "Ad contains video content." : "Ad does not contain video content."
      } else {
        controlsView.isHidden = true
        videoStatusLabel.text = ""
      }
    }
  }

  /// The container view for the actual video controls
  @IBOutlet weak var controlsView: UIView!
  /// The play button.
  @IBOutlet weak var playButton: UIButton!
  /// The mute button.
  @IBOutlet weak var muteButton: UIButton!
  /// The label showing the video status for the current video controller.
  @IBOutlet weak var videoStatusLabel: UILabel!

  /// Boolean reflecting current playback state for UI.
  private var _isPlaying = false
  var isPlaying: Bool {
    get {
      return _isPlaying
    }
    set(playing) {
      _isPlaying = playing
      let title: String = _isPlaying ? "Pause" : "Play"
      playButton.setTitle(title, for: .normal)
    }
  }

  /// Boolean reflecting current mute state for UI.
  private var _isMuted = false
  var isMuted: Bool {
    get {
      return _isMuted
    }
    set(muted) {
      if muted != isMuted {
        let title: String = muted ? "Unmute" : "Mute"
        muteButton.setTitle(title, for: .normal)
      }
      _isMuted = muted
    }
  }

  func reset(withStartMuted startMuted: Bool) {
    isMuted = startMuted
    isPlaying = false
    controlsView.isHidden = true
    videoStatusLabel.text = ""
  }

  @IBAction func playPause(_ sender: Any) {
    guard let mediaContent = mediaContent else {
      return
    }
    if isPlaying {
      mediaContent.videoController.pause()
    } else {
      mediaContent.videoController.play()
    }
  }
  @IBAction func muteUnmute(_ sender: Any) {
    isMuted = !isMuted
    if let mediaContent = mediaContent {
      mediaContent.videoController.setMute(isMuted)
    }
  }
}
//MARK: - GoogleAds Method
extension CustomControlsView: GADVideoControllerDelegate {
  func videoControllerDidPlayVideo(_ videoController: GADVideoController) {
    videoStatusLabel.text = "Video did play."
    print("\(#function)")
    isPlaying = true
  }
  func videoControllerDidPauseVideo(_ videoController: GADVideoController) {
    videoStatusLabel.text = "Video did pause."
    print("\(#function)")
    isPlaying = false
  }
  func videoControllerDidMuteVideo(_ videoController: GADVideoController) {
    videoStatusLabel.text = "Video has muted."
    print("\(#function)")
    isMuted = true
  }
  func videoControllerDidUnmuteVideo(_ videoController: GADVideoController) {
    videoStatusLabel.text = "Video has unmuted."
    print("\(#function)")
    isMuted = false
  }
  func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
    videoStatusLabel.text = "Video playback has ended."
    print("\(#function)")
    isPlaying = false
  }
}
