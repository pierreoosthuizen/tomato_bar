import AudioToolbox
import SwiftUI

class TBPlayer: ObservableObject {
    private var startSoundID: SystemSoundID = 0
    private var endSoundID: SystemSoundID = 0

    @AppStorage("startSoundEnabled") var startSoundEnabled = true
    @AppStorage("endSoundEnabled") var endSoundEnabled = true

    init() {
        startSoundID = Self.loadSystemSound("Purr")
        endSoundID = Self.loadSystemSound("Glass")
    }

    deinit {
        if startSoundID != 0 { AudioServicesDisposeSystemSoundID(startSoundID) }
        if endSoundID != 0 { AudioServicesDisposeSystemSoundID(endSoundID) }
    }

    func playStart() {
        guard startSoundEnabled else { return }
        AudioServicesPlaySystemSound(startSoundID)
    }

    func playEnd() {
        guard endSoundEnabled else { return }
        AudioServicesPlaySystemSound(endSoundID)
    }

    /// Loads a system sound file into an AudioToolbox SystemSoundID.
    /// AudioToolbox is sandbox-safe and does not require entitlements.
    private static func loadSystemSound(_ name: String) -> SystemSoundID {
        let url = URL(fileURLWithPath: "/System/Library/Sounds/\(name).aiff") as CFURL
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url, &soundID)
        return soundID
    }
}
