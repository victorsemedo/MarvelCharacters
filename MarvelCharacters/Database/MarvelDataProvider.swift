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
    
    static func fetchFavoriteCharacter(withId id: Int) -> FavoriteCharacter? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteCharacter")
        let predicate = NSPredicate(format: "id = %ld", id)
        request.predicate = predicate
        
        do {
            if let result = try DataProvider.shareInstance.context.fetch(request) as? [FavoriteCharacter],
               result.count > 0 {
                return result[0]
            }
        } catch {
            print("Failed")
        }
        
        return nil
    }
    
    static func saveFavoriteCharacter(_ character: Character, image: Data?) {
        var favoriteCharacter = MarvelDataProvider.fetchFavoriteCharacter(withId: character.id)
        
        if favoriteCharacter == nil {
            favoriteCharacter = NSEntityDescription.insertNewObject(forEntityName: "FavoriteCharacter", into: DataProvider.shareInstance.context) as? FavoriteCharacter
        }
        favoriteCharacter?.id = Int32(character.id)
        favoriteCharacter?.name = character.name
        favoriteCharacter?.desc = character.description
        favoriteCharacter?.imgUrl = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.fileExtension ?? "")"
        favoriteCharacter?.img = image
        
        do {
            try DataProvider.shareInstance.context.save()
        } catch {
            print("Failed")
        }
    }
    
    static func deleteFavoriteCharacter(withId id: Int) -> Bool {
        if let favoriteCharacter = MarvelDataProvider.fetchFavoriteCharacter(withId: id) {
            DataProvider.shareInstance.context.delete(favoriteCharacter)
            return true
        }
        return false
    }
    
    static func fetchFavoriteCharacters() -> [FavoriteCharacter] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteCharacter")
        
        do {
            if let result = try DataProvider.shareInstance.context.fetch(request) as? [FavoriteCharacter]{
                return result
            } else {
                return [FavoriteCharacter]()
            }
        } catch {
            print("Failed")
        }
        
        return [FavoriteCharacter]()
    }
}
