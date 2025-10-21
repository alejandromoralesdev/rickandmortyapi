import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    var scaleAmount: CGFloat = 0.97
    var pressedOpacity: Double = 0.85

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaleAmount : 1.0)
            .opacity(configuration.isPressed ? pressedOpacity : 1.0)
            .animation(.interactiveSpring(response: 0.32, dampingFraction: 0.7, blendDuration: 0.0), value: configuration.isPressed)
            .brightness(configuration.isPressed ? -0.02 : 0)
    }
}
