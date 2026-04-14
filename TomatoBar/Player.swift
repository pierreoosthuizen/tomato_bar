import AppKit
import SwiftUI

class TBPlayer: ObservableObject {
    @AppStorage("windupVolume") var windupVolume: Double = 1.0
    @AppStorage("dingVolume") var dingVolume: Double = 1.0

    func playWindup() {
        play(named: "Purr", volume: Float(windupVolume))
    }

    func playDing() {
        play(named: "Glass", volume: Float(dingVolume))
    }

    private func play(named name: String, volume: Float) {
        guard let sound = NSSound(named: NSSound.Name(name)) else { return }
        sound.volume = volume
        sound.play()
    }
}
