import Foundation
import struct Entities.Category
import struct RData.CategoryDataEntity

extension CategoryDataEntity {

    func toCategory() -> Category {

        Category(id: id,
                 title: title,
                 imageURL: imageURL,
                 defaultImage: defaultImage)

    }
}
