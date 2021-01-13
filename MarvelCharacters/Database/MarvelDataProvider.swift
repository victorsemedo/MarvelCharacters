//
//  MarvelDataProvider.swift
//  MarvelCharacters
//
//  Created by Victor Tavares on 13/01/21.
//

import CoreData

extension FavoriteCharacter {
    
    func toCharacter() -> Character {
        return Character(id: Int(id), name: name, description: desc, thumbnail: nil)
    }
}

final class MarvelDataProvider {
    
    static func fetchCharacter(withId id: Int) -> FavoriteCharacter? {
        guard let entityName = FavoriteCharacter.entity().name else {
            return nil
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "id == %@", id)
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
    
    static func saveCharacter(_ character: Character) {
        guard let entityName = FavoriteCharacter.entity().name else {
            return
        }
        var favoriteCharacter = MarvelDataProvider.fetchCharacter(withId: character.id)
        
        if favoriteCharacter == nil {
            favoriteCharacter = NSEntityDescription.insertNewObject(forEntityName: entityName, into: DataProvider.shareInstance.context) as? FavoriteCharacter
        }
        favoriteCharacter?.id = Int32(character.id)
        favoriteCharacter?.name = character.name
        favoriteCharacter?.desc = character.description
        favoriteCharacter?.imgUrl = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.fileExtension ?? "")"
        
        do {
            try DataProvider.shareInstance.context.save()
        } catch {
            print("Failed")
        }
    }
    
    static func deleteHero(withId id: Int) -> Bool {
        if let favoriteCharacter = MarvelDataProvider.fetchCharacter(withId: id) {
            DataProvider.shareInstance.context.delete(favoriteCharacter)
            return true
        }
        return false
    }
    
    func fetchFavoriteCharacters() -> [FavoriteCharacter] {
        guard let entityName = FavoriteCharacter.entity().name else {
            return [FavoriteCharacter]()
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
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
