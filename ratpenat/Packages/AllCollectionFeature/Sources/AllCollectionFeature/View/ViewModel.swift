import Foundation

struct ViewModel: Equatable, Hashable {
    
    struct Item: Equatable, Identifiable, Hashable {
        let id: Int
        let title: String
        let subject: String
        let duration: String
    }
    
    let items: [Item]
}
