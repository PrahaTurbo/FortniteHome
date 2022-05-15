//
//  Shop.swift
//  FortniteHome
//
//  Created by Артем Ластович on 14.04.2022.
//

import Foundation

struct ShopCollection: Codable {
    var featuredSection: [Shop.ShopData.ShopSection.Entry]
    var dailySection: [Shop.ShopData.ShopSection.Entry]
    var specialFeaturedSection: [Shop.ShopData.ShopSection.Entry]
    var specialDailySection: [Shop.ShopData.ShopSection.Entry]
    var votesSection: [Shop.ShopData.ShopSection.Entry]
    var voteWinnersSection: [Shop.ShopData.ShopSection.Entry]
    var date: Date

    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let collection = try container.decode(Shop.self)
        featuredSection = collection.data.featured.entries
        dailySection = collection.data.daily.entries
        specialFeaturedSection = collection.data.specialFeatured?.entries ?? []
        specialDailySection = collection.data.specialDaily?.entries ?? []
        votesSection = collection.data.votes?.entries ?? []
        voteWinnersSection = collection.data.voteWinners?.entries ?? []
        date = collection.data.date
    }
}

struct Shop: Codable {
    let status: Int
    let data: ShopData
    
    struct ShopData: Codable {
        let hash: String
        let date: Date
        let vbuckIcon: String
        let featured: ShopSection
        let daily: ShopSection
        let specialFeatured: ShopSection?
        let specialDaily: ShopSection?
        let votes: ShopSection?
        let voteWinners: ShopSection?
        
        struct ShopSection: Codable {
            let name: String?
            let entries: [Entry]
            
            struct Entry: Codable {
                let regularPrice: Int
                let finalPrice: Int
                let bundle: Bundle?
                let banner: Banner?
                let devName: String
                let offerId: String
                let newDisplayAsset: NewDisplayAsset?
                let items: [Cosmetics.Item]
                
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
                            let image: URL
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
                        let smallIcon: URL?
                        let icon: URL?
                        let featured: URL?
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
                        let image: URL?
                        let backendValue: String
                    }
                    
                    struct TypeRarity: Codable {
                        let value: String
                        let displayValue: String
                        let backendValue: String
                    }
                }
                
                struct NewDisplayAsset: Codable {
                    let id: String
                    let cosmeticId: String?
                    let materialInstances: [MaterialInstance]
                    
                    struct MaterialInstance: Codable {
                        let id: String
                        let images: [String: URL]
                        let colors: [String: String]
                        let scalings: [String: Double]
                        let flags: [String: Bool]?
                    }
                }
                
                struct Bundle: Codable {
                    let name: String
                    let info: String
                    let image: String
                }
                
                struct Banner: Codable {
                    let value: String
                    let intensity: String
                    let backendValue: String
                }
                
                struct Section: Codable {
                    let id: String
                    let name: String
                    let index: Int
                    let landingPriority: Int
                    let sortOffersByOwnership: Bool
                    let showIneligibleOffers: Bool
                    let showIneligibleOffersIfGiftable: Bool
                    let showTimer: Bool
                    let enableToastNotification: Bool
                    let hidden: Bool
                }
            }
        }
    }
}

