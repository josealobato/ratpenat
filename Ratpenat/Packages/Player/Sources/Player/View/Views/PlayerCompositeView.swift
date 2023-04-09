//

import SwiftUI

struct PlayerCompositeView: View {

    @Binding var lecture: LectureViewModel?

    @State var possition: Int = 0

    var body: some View {
        VStack {
            title
            PlayControls()
            PositionSlider(possition: $possition, length: 100)
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }

    private var title: some View {

        Text(lecture?.title ?? "")
            .font(.headline)
    }
}

struct PlayerCompositeView_Previews: PreviewProvider {

    @State static var model = LectureViewModel(id: "01",
                                               title: "One")
    static var previews: some View {
        PlayerCompositeView(lecture: .constant(model))
            .previewDisplayName("PlayerComposite")
    }
}
