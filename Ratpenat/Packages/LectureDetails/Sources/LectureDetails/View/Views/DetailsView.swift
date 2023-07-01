import SwiftUI

struct DetailsView: View {
    
    @Binding var lecture: ViewModel
    
    private var handlers: ActionHandlers = .init()
    
    init(lecture: Binding<ViewModel>) {
        
        self._lecture = lecture
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            TextField(LocalizationKey.titleHint.localize(), text: $lecture.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text(LocalizationKey.titleAdvice.localize())
                .font(.footnote)
            
            Spacer()
            
            HStack {
                Spacer()
                Button(LocalizationKey.save.localize(),
                       action: { save() })
                .disabled(!lecture.readyToSave)
            }
        }
        .padding()
        .navigationTitle(LocalizationKey.navigationTitle.localize())
    }
    
    // MARK: - Actions
    
    public func onSave(_ action: @escaping ((ViewModel) -> Void)) -> Self {
        handlers.onSave = action
        return self
    }
}

private class ActionHandlers {
    
    var onSave: ((ViewModel) -> Void)?
}

private extension DetailsView {
    
    func save() {
        handlers.onSave?(lecture)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    
    struct BindingTestHolder: View {
        @State var model: ViewModel = ViewModel(originalLecture: nil,
                                                title: "This a normal title")
        var body: some View {
            DetailsView(lecture: $model)
        }
    }
    
    static var previews: some View {
        NavigationView {
            BindingTestHolder()
                .previewDisplayName("Details View")
        }
        
    }
}
