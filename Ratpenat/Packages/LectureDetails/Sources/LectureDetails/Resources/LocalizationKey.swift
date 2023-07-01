import Foundation

enum LocalizationKey: String {

    case navigationTitle

    case titleHint
    case titleAdvice

    // Actions
    case save

    func localize() -> String {

        NSLocalizedString(rawValue, tableName: nil, bundle: Bundle.module, value: "missing translation", comment: "")
    }
}
