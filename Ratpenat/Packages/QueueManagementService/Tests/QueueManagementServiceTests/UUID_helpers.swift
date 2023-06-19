import Foundation

/// Based on a seed generate a string that resembles a UUID
/// like:
/// `11111111-1111-1111-1111-111111111111`
///
/// - Parameter seed: the value that will repeat
/// - Returns: a uuid string
func uuidString(_ seed: String) -> String {

    var hyphen = [7,11,15,19]

    var pattern = ""
    for i in 0..<32 {
        pattern += seed
        if hyphen.contains(i) {
            pattern += "-"
        }
    }
    return pattern
}

/// Based on a seed generate a uuid
/// like:
/// `11111111-1111-1111-1111-111111111111`
///
/// - Parameter seed: the value that will repeat
/// - Returns: the uuid
func uuid(_ seed: String) -> UUID {

    let uuidString = uuidString(seed)
    return UUID(uuidString: uuidString)!
}
