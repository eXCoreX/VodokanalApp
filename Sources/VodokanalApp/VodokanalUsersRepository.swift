//
//  VodokanalUsersRepository.swift
//  
//
//  Created by Litvinov Rostyslav on 18.12.2022.
//

import Foundation

class VodokanalUsersRepository {
    static let shared = VodokanalUsersRepository()

    var users: [VodokanalUser] {
        get async throws {
            try await Fetcher.shared.get(url: "https://vodokanalapi.azurewebsites.net/users")
        }
    }

    private init() { }

    func addNewObject() async throws -> VodokanalUser {
        try await Fetcher.shared.get(url: "https://vodokanalapi.azurewebsites.net/addTestObject")
    }

    func fillTestData() async throws {
        let _: [VodokanalUser] = try await Fetcher.shared.get(url: "https://vodokanalapi.azurewebsites.net/fillTestData")
    }

    func updateUser(_ user: VodokanalUser) async throws  {
        let response = try await Fetcher.shared.post(url: "https://vodokanalapi.azurewebsites.net/user", user)
        guard response == "200" else {
            throw Error.failed
        }
    }

    enum Error: Swift.Error {
        case failed
    }
}
