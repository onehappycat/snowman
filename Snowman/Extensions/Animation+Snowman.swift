import SwiftUI

extension Animation {

    static func ripple() -> Animation {
        Animation
            .spring(dampingFraction: 0.5)
            .speed(1.5)
    }

}
