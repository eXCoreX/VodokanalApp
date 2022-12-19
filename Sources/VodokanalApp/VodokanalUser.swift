//
//  VodokanalUser.swift
//  
//
//  Created by Litvinov Rostyslav on 18.12.2022.
//

struct VodokanalUser: Codable {
    let accountNumber: Int
    let lastReadings: Int
    let fullName: String
}

extension VodokanalUser: Identifiable {
    var id: Int {
        accountNumber
    }
}
