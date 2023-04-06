import SwiftUI

struct LectureList: View {

    @Binding var lectures: [LectureViewModel]

    // With this state we are decoupling from the binding.
    //@State var rows: [LectureRowViewModel]

    var onTap: ((LectureViewModel.ID) -> Void)

    var body: some View {

        List {

            ForEach($lectures) { lecture in
                LectureRow(model: lecture)
            }

        }
        .listStyle(.plain)
//        .onChange(of: lectures) { newValue in
//            rows = newValue.map(LectureToRow)
//        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {

    @State static var models = [
        LectureViewModel(id: "01",
                         title: "One"),
        LectureViewModel(id: "02",
                         title: "Two"),
    ]
    static var previews: some View {
        LectureList(lectures: $models,
                    onTap: { _ in })
        .previewDisplayName("Lecture Collection")
    }
}
