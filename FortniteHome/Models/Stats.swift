//
//  Stats.swift
//  FortniteHome
//
//  Created by Артем Ластович on 14.04.2022.
//

import Foundation


struct Stats: Codable {
    let status: Int
    let data: StatsData
    
    struct StatsData: Codable {
        let account: Account
        let battlePass: BattlePass
        let image: String?
        let stats: StatsObject
        
        struct Account: Codable {
            let id: String
            let name: String
        }
        
        struct BattlePass: Codable {
            let level: Int
            let progress: Int
        }
        
        struct StatsObject: Codable {
            let all: StatsMode?
            let keyboardMouse: StatsMode?
            let gamepad: StatsMode?
            let touch: StatsMode?
            
            struct StatsMode: Codable {
                let overall: Overall?
                let solo: Overall?
                let duo: Overall?
                let trio: Overall?
                let squad: Overall?
                let ltm: Overall?
                
                struct Overall: Codable {
                    let score: Int
                    let scorePerMin: Double
                    let scorePerMatch: Double
                    let wins: Int
                    let top3: Int?
                    let top5: Int?
                    let top6: Int?
                    let top10: Int?
                    let top12: Int?
                    let top25: Int?
                    let kills: Int
                    let killsPerMin: Double
                    let killsPerMatch: Double
                    let deaths: Int
                    let kd: Double
                    let matches: Int
                    let winRate: Double
                    let minutesPlayed: Int
                    let playersOutlived: Int
                    let lastModified: Date
                }
            }
        }
    }
}
