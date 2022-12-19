//
//  AuthenticationService.swift
//  
//
//  Created by Litvinov Rostyslav on 19.12.2022.
//

import Foundation

class AuthenticationService {
    static let shared = AuthenticationService()

    private init() { }

    func authenticate(password: String) async -> Bool {
        let container = Container(password: password)
        do {
            let code = try await Fetcher.shared.post(url: "https://vodokanalapi.azurewebsites.net/authenticateAdmin", container)
            return code == "200"
        } catch {
            return false
        }
    }

    private struct Container: Codable {
        let password: String
    }
}
