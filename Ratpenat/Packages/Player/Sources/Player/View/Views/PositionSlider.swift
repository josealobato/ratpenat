import SwiftUI

struct PositionSlider: View {
    @Binding var possition: Int
    var length: Int

    @State var lastCoordinateValue: CGFloat = 0.0

    let radius = 20.0
    let markerSidesOffset = 6.0
    let markerWidth = 4.0
    let totalHeight = 100.0

    var body: some View {

        GeometryReader { geometry in

            let availableWidth = geometry.size.width - 2 * markerSidesOffset
            let scaleFactor = availableWidth / CGFloat(length)
            let relativePosition = CGFloat(possition) * scaleFactor + markerSidesOffset

            let minValue = markerSidesOffset
            let maxValue = geometry.size.width - markerSidesOffset

            let currentPosstiongTimeText = TimeInterval(possition).minutesSeconds(style: .positional)
            let totalTimeText = TimeInterval(length).minutesSeconds(style: .positional)

            VStack(spacing: 2.0) {

                // Text on top of the slider.
                HStack {
                    Text(currentPosstiongTimeText)
                    Spacer()
                    Text(totalTimeText)
                }

                // The Slider.
                ZStack {
                    // On the background the whole view (played and not played)
                    RoundedRectangle(cornerRadius: radius)
                        .foregroundColor(.secondary)

                    // The played section.
                    HStack {
                        Rectangle()
                            .frame(width: relativePosition)
                        Spacer()
                    }
                    .clipShape(RoundedRectangle(cornerRadius: radius))

                    // The marker.
                    HStack {
                        // The marker itself.
                        RoundedRectangle(cornerRadius: radius)
                            .foregroundColor(.black)
                            .frame(width: markerWidth)
                            .offset(x: relativePosition)
                            // The the gesture to change the value
                            .gesture (
                                DragGesture(minimumDistance: 0)
                                    .onChanged { value in
                                        let t = value.translation.width

                                        if (abs(t) < 0.1) {
                                            self.lastCoordinateValue = relativePosition
                                        }
                                        if t > 0 {
                                            let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + t)
                                            self.possition = Int(((nextCoordinateValue - markerSidesOffset) / scaleFactor))
                                        } else {
                                            let nextCoordinateValue = max(minValue, self.lastCoordinateValue + t)
                                            self.possition = Int(((nextCoordinateValue - markerSidesOffset) / scaleFactor))
                                        }
                                    }
                            )

                        // The not played part to see the background.
                        Spacer()
                    }
                }
            }
            .foregroundColor(.secondary)
        }
        .frame(height: totalHeight)
    }
}

struct PositionSlider_Previews: PreviewProvider {

    struct FakeContainer: View {
        @State var currentPossition: Int
        var length: Int

        var body: some View {

            VStack(spacing:0) {
                PositionSlider(possition: $currentPossition,
                               length: length)
            }
        }
    }

    static var previews: some View {

        VStack {
            FakeContainer(currentPossition: 360, length: 3600)
            FakeContainer(currentPossition: 0, length: 3600)
            FakeContainer(currentPossition: 3600, length: 3600)
            Spacer()
        }
    }
}
