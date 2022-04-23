import Foundation

struct ViewModel: Equatable {
    
    struct Item: Equatable, Identifiable {
        let id: Int
        let title: String
    }
    
    let items: [Item]
}
