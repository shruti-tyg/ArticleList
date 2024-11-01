//
//  ArticleList
//
//  Created by shruti tyagi on 29/10/24.
//


import Foundation
import SwiftyJSON

public final class ArticleListing: NSCoding {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
      static let author = "author"
      static let content = "content"
      static let description = "description"
      static let publishedAt = "publishedAt"
      static let title = "title"
      static let htmlUrl = "url"
      static let urlToImage = "urlToImage"

        
    }
      
      
    // MARK: Properties
      public var author: String?
      public var content: String?
      public var description: String?
      public var publishedAt: String?
      public var title: String?
      public var htmlUrl: String?
      public var urlToImage: String?


    // MARK: SwiftyJSON Initializers
    /// Initiates the instance based on the object.
    ///
    /// - parameter object: The object of either Dictionary or Array kind that was passed.
    /// - returns: An initialized instance of the class.
    public convenience init(object: Any) {
      self.init(json: JSON(object))
    }

    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    public required init(json: JSON) {
        author = json[SerializationKeys.author].string
        content = json[SerializationKeys.content].string
        description = json[SerializationKeys.description].string
        publishedAt = json[SerializationKeys.publishedAt].string
        title = json[SerializationKeys.title].string
        htmlUrl = json[SerializationKeys.htmlUrl].string
        urlToImage = json[SerializationKeys.urlToImage].string

        

    }

    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
      var dictionary: [String: Any] = [:]
      if let value = author { dictionary[SerializationKeys.author] = value }
      if let value = content { dictionary[SerializationKeys.content] = value }
      if let value = description { dictionary[SerializationKeys.description] = value }
      if let value = publishedAt { dictionary[SerializationKeys.publishedAt] = value }
      if let value = title { dictionary[SerializationKeys.title] = value }
      if let value = htmlUrl { dictionary[SerializationKeys.htmlUrl] = value }
      if let value = urlToImage { dictionary[SerializationKeys.urlToImage] = value }

      return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
      self.author = aDecoder.decodeObject(forKey: SerializationKeys.author) as? String
      self.content = aDecoder.decodeObject(forKey: SerializationKeys.content) as? String
      self.description = aDecoder.decodeObject(forKey: SerializationKeys.description) as? String
      self.publishedAt = aDecoder.decodeObject(forKey: SerializationKeys.publishedAt) as? String
      self.title = aDecoder.decodeObject(forKey: SerializationKeys.title) as? String
      self.htmlUrl = aDecoder.decodeObject(forKey: SerializationKeys.htmlUrl) as? String
      self.urlToImage = aDecoder.decodeObject(forKey: SerializationKeys.urlToImage) as? String

    }

    public func encode(with aCoder: NSCoder) {
      aCoder.encode(author, forKey: SerializationKeys.author)
      aCoder.encode(content, forKey: SerializationKeys.content)
      aCoder.encode(description, forKey: SerializationKeys.description)
      aCoder.encode(publishedAt, forKey: SerializationKeys.publishedAt)
      aCoder.encode(title, forKey: SerializationKeys.title)
      aCoder.encode(htmlUrl, forKey: SerializationKeys.htmlUrl)
      aCoder.encode(urlToImage, forKey: SerializationKeys.urlToImage)

    }

  }
