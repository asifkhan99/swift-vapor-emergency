import Vapor
import Foundation
import FluentMySQL
import Fluent

/**struct Product {
    let name: String
    let code: String
    let image: String
}

extension Product: JSONRepresentable {

    func makeJSON() throws -> JSON {
        return try JSON(node:["name": name,
            "code": code,
            "image": image])
    }
}*/

class DataSourceProduct: JSONRepresentable {

    let APIVersion = 0.3

    let source = [Product(name: "Schwinn Kids Bikes", code: "SCHBK", image: "https://images.duckduckgo.com/iu/?u=http%3A%2F%2Fmedia.performancebike.com%2Fimages%2Fperformance%2Fproducts%2F1500%2F31-3204-RSF-SIDE.JPG&f=1").self]


    func makeJSON() throws -> JSON {

    //    let content = DataSource().source.map {$0.makeJSON()}
        driver = MySQLDriver.makeTestConnection()
        database = Database(driver)

        var product = Product(id: nil, name: "Vapor", email: "vapor@qutheory.io")
        Product.database = database

       do {
            try product.save()
       } catch {
          print("Error while saving")
       }

       do {
       let found = try Product.find(1)
       return try found;
       }catch {
          print("Error while fetching")
       }

    /**    return try JSON(node: [
                "version" : APIVersion,
                "products": JSON(DataSourceProduct().source.map { try $0.makeJSON()})
            ])

          } */

}
