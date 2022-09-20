//
//  ServiceError.swift
//  FortniteHome
//
//  Created by Артем Ластович on 20.09.2022.
//

import Foundation

enum ServiceError: Error {
    case badUrl, fetchFailed, decodeFailed
}
