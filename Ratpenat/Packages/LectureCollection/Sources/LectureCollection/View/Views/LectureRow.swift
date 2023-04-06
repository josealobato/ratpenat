import SwiftUI

struct LectureRow: View {

    @Binding var model: LectureViewModel

    var body: some View {
        HStack {
            Image(systemName: "pin")
            Text(model.title)
        }
    }
}

struct LectureRow_Previews: PreviewProvider {
    static var previews: some View {
        let basicRow1 = LectureRow(
            model: .constant(LectureViewModel(id: "1",
                                              title: "Title of One")))
        let basicRow2 = LectureRow(
            model: .constant(LectureViewModel(id: "2",
                                              title: "Title of Two")))
        Group {
            basicRow1
                .previewDisplayName("Basic Row")
            basicRow2
                .previewDisplayName("Basic Row")
        }
    }
}
