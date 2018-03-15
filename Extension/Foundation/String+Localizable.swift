import Foundation

extension String {
    var localized: String {
        guard !isEmpty else { return self }

        // localized strings (localizable.strings)
        var localizedResult = Bundle.main.localizedString(forKey: self, value: nil, table: nil)

        // localized images (images.strings)
        if localizedResult == self {
            localizedResult = Bundle.main.localizedString(forKey: self, value: nil, table: "Images")
        }

        return localizedResult

    }

}
