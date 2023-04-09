import Foundation

public extension TimeInterval {

    /**
     ```
     // zero hours, five minutes, zero seconds
     print(TimeInterval(5*60).hoursMinutesSeconds(style: .spellOut))
     ```
     */
    func hoursMinutesSeconds(style: DateComponentsFormatter.UnitsStyle) -> String {

        format(unitsStyle: style, allowedUnits: [.hour, .minute, .second])
    }

    /**
     ```
     // zero hours, five minutes
     print(TimeInterval(5*60).hoursMinutes(style: .spellOut))
     ```
     */
    func hoursMinutes(style: DateComponentsFormatter.UnitsStyle) -> String {

        format(unitsStyle: style, allowedUnits: [.hour, .minute])
    }

    /**
     ```
     // 01:00:00
     print(TimeInterval(3600).hoursMinutesSeconds(style: .positional))
     // 60:00
     print(TimeInterval(3600).minutesSeconds(style: .positional))
     ```
     */
    func minutesSeconds(style: DateComponentsFormatter.UnitsStyle) -> String {

        format(unitsStyle: style, allowedUnits: [.minute, .second])
    }

    private func format(unitsStyle: DateComponentsFormatter.UnitsStyle, allowedUnits: NSCalendar.Unit) -> String {

        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = allowedUnits
        formatter.unitsStyle = unitsStyle
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}
