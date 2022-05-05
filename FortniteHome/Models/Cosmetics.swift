//
//  Cosmetics.swift
//  FortniteHome
//
//  Created by Артем Ластович on 14.04.2022.
//

import Foundation

struct Cosmetics: Codable {
    let status: Int
    let data: [Item]
    
    var items: [Item] {
        data.filter { $0.type.value != "banner" && $0.type.value != "emoji" && $0.type.value != "pet" && $0.type.value != "petcarrier" && $0.type.value != "toy"}
    }
    
    enum Types: String {
        case all = "all"
        case wrap = "wrap"
        case backpack = "backpack"
        case spray = "spray"
        case music = "music"
        case outfit = "outfit"
        case contrail = "contrail"
        case emote = "emote"
        case pickaxe = "pickaxe"
        case loadingscreen = "loadingscreen"
        case glider = "glider"
    }
        
    struct Item: Codable {
        let id: String
        let name: String
        let description: String
        let type: TypeRarity
        let rarity: TypeRarity
        let series: Series?
        let set: ItemSet?
        let introduction: Introduction?
        let images: ItemImages
        let variants: [Variant]?
        let searchTags: [String]?
        let gameplayTags: [String]?
        let metaTags: [String]?
        let showcaseVideo: String?
        let dynamicPakId: String?
        let displayAssetPath: String?
        let definitionPath: String?
        let path: String
        let added: Date
        let shopHistory: [Date]?
        let itemPreviewHeroPath: String?
        let customExclusiveCallout: String?
        let exclusiveDescription: String?
        let unlockRequirements: String?
        let builtInEmoteIds: [String]?
        
        struct Variant: Codable {
            let channel: Channel
            let type: String?
            let options: [Option]
            
            struct Option: Codable {
                let tag: String
                let name: String?
                let image: String
                let unlockRequirements: String?
            }
            
            
            enum Channel: String, Codable {
                case clothingColor = "ClothingColor"
                case emissive = "Emissive"
                case hair = "Hair"
                case jerseyColor = "JerseyColor"
                case material = "Material"
                case mesh = "Mesh"
                case numeric = "Numeric"
                case particle = "Particle"
                case parts = "Parts"
                case pattern = "Pattern"
                case petTemperament = "PetTemperament"
                case profileBanner = "ProfileBanner"
                case progressive = "Progressive"
            }
        }
        
        struct ItemImages: Codable {
            let smallIcon: String?
            let icon: String?
            let featured: String?
            let other: [String: String]?
        }
        
        struct Introduction: Codable {
            let chapter: String
            let season: String
            let text: String
            let backendValue: Int
        }
        
        struct ItemSet: Codable {
            let value: String?
            let text: String?
            let backendValue: String?
        }
        
        struct Series: Codable {
            let value: String
            let image: String?
            let backendValue: String
        }
        
        struct TypeRarity: Codable {
            let value: String
            let displayValue: String
            let backendValue: String
        }
    }
}
