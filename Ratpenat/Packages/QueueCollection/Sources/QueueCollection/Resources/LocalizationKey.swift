import Foundation

enum LocalizationKey: String {

    case lectures

    // Actions
    case play
    case enqueue
    case dequeue
    case delete

    func localize() -> String {

        NSLocalizedString(rawValue, tableName: nil, bundle: Bundle.module, value: "missing translation", comment: "")
    }
}
