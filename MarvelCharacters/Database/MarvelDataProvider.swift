//
//  MarvelDataProvider.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import CoreData
import UIKit

extension FavoriteCharacter {
    
    func toCharacter() -> Character {
        var character = Character(id: Int(id), name: name, description: desc)
        character.isFavorite = true
        character.imageUrl = imgUrl
        if let data = img {
            character.image = UIImage(data: data)
        }
        return character
    }
}

final class MarvelDataProvider {
    
    static func fetchFavoriteCharacter(withId id: Int) throws -> FavoriteCharacter? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteCharacter")
        request.predicate = NSPredicate(format: "id = %ld", id)
        
        if let result = try DataProvider.shareInstance.context.fetch(request) as? [FavoriteCharacter],
           result.count > 0 {
            return result[0]
        }
        
        return nil
    }
    
    static func saveFavoriteCharacter(_ character: Character, image: Data?) -> DataProviderError? {
        do {
            var favoriteCharacter = try MarvelDataProvider.fetchFavoriteCharacter(withId: character.id)
            
            if favoriteCharacter == nil {
                favoriteCharacter = NSEntityDescription.insertNewObject(forEntityName: "FavoriteCharacter", into: DataProvider.shareInstance.context) as? FavoriteCharacter
            }
            favoriteCharacter?.id = Int32(character.id)
            favoriteCharacter?.name = character.name
            favoriteCharacter?.desc = character.description
            favoriteCharacter?.imgUrl = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.fileExtension ?? "")"
            favoriteCharacter?.img = image
            
            try DataProvider.shareInstance.context.save()
            
        } catch {
            return DataProviderError.save
        }
        
        return nil
    }
    
    static func deleteFavoriteCharacter(withId id: Int) -> DataProviderError? {
        do {
            if let favoriteCharacter = try MarvelDataProvider.fetchFavoriteCharacter(withId: id) {
                DataProvider.shareInstance.context.delete(favoriteCharacter)
                try DataProvider.shareInstance.context.save()
            }
        } catch {
            return DataProviderError.delete
        }

        return nil
    }
    
    static func fetchFavoriteCharacters(byName name: String?) throws -> [FavoriteCharacter] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteCharacter")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        if let filterName = name, filterName.count > 0 {
            request.predicate = NSPredicate(format: "name LIKE %@", filterName)
        }
        
        if let result = try DataProvider.shareInstance.context.fetch(request) as? [FavoriteCharacter] {
            return result
        }
        
        return [FavoriteCharacter]()
    }
}
