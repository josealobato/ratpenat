import Foundation
import struct Entities.Category
import struct RData.CategoryDataEntity

extension Category {

    func toDataCategory() -> CategoryDataEntity? {

        guard let uuid = UUID(uuidString: id) else { return nil }

        return CategoryDataEntity(id: uuid,
                                  title: title,
                                  imageURL: imageURL,
                                  defaultImage: defaultImage)
    }
}
