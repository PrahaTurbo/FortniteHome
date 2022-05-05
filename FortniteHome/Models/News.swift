//
//  News.swift
//  FortniteHome
//
//  Created by Артем Ластович on 14.04.2022.
//

import Foundation



struct NewsCollection: Codable {
    var battleRoyale: [News.Modes.NewsData.Message]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let collection = try container.decode(News.self)
        battleRoyale = collection.data.br?.motds ?? []
    }
}

struct News: Codable {
    let data: Modes

    struct Modes: Codable {
        let br: NewsData?
        
        struct NewsData: Codable {
            let motds: [Message]?
            let messages: [Message]?
            
            struct Message: Codable, Hashable {
                let title: String
                let body: String    
                let image: URL
                let tileImage: URL
            }
        }
    }
}





//
//
//struct News: Codable {
//    let status: Int
//    let data: Modes
//
//    struct Modes: Codable {
//        let br: NewsData?
//        let stw: NewsData?
//        let creative: NewsData?
//
//        struct NewsData: Codable {
//            let hash: String
//            let date: Date
//            let image: String?
//            let motds: [Motd]?
//            let messages: [Message]?
//
//            struct Motd: Codable {
//                let id: String
//                let title: String
//                let tabTitle: String
//                let body: String
//                let image: String
//                let tileImage: String
//                let sortingPriority: Int
//                let hidden: Bool
//            }
//
//            struct Message: Codable {
//                let title: String
//                let body: String
//                let image: String
//                let adspace: String
//            }
//        }
//    }
//}
