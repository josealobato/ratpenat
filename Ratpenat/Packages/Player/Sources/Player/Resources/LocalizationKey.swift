import Foundation

enum LocalizationKey: String {

    case noAudioMessage

    func localize() -> String {

        NSLocalizedString(rawValue, tableName: nil, bundle: Bundle.module, value: "missing.translation", comment: "")
    }
}
