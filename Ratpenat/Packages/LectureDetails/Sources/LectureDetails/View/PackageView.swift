import SwiftUI

struct PackageView: View {
    
    enum ViewState {
        
        case loading
    }
    
    @StateObject private var presenter: Presenter
    let interactor: InteractorInput
    
    init(presenter: Presenter,
         interactor: InteractorInput) {
        
        self._presenter = StateObject(wrappedValue: presenter)
        self.interactor = interactor
    }
    
    var body: some View {
        DetailsView(lecture: $presenter.lecture)
            .onSave { request(.save($0)) }
            .onAppear { request(.loadInitialData) }
    }
    
    func request(_ event: InteractorEvents.Input) {
        
        Task {
            
            await interactor.request(event)
        }
    }
}

struct LectureCollectionView_Previews: PreviewProvider {
    
    struct TestContainer: View {
        
        @State private var previewLecture = ViewModel(originalLecture: nil,
                                                      title: "One")
        
        var body: some View {
            Text("Use this view to preview the view states when implemented")
        }
    }
    
    static var previews: some View {
        NavigationView {
            TestContainer()
                .previewDisplayName("ContainerView")
        }
    }
}
