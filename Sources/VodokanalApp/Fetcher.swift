//
//  Fetcher.swift
//  
//
//  Created by Litvinov Rostyslav on 17.12.2022.
//

import JavaScriptKit
import Foundation

struct Fetcher {
    static let shared = Fetcher()

    func `get`<T: Decodable>(url: String) async throws -> T {
        let data = try await getData(url).value
        let json = try await JSPromise(data.json().object!)!.value
        return try JSValueDecoder().decode(from: json)
    }

    func post<T: Encodable>(url: String, _ value: T) async throws -> String {
        let jsonData = try JSONEncoder().encode(value)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else { return "can't stringify" }

        let responseData = try await postData(url, json: jsonString).value
        return "\(JSObject.global.JSON.stringify(responseData.status).string!)"
    }

    private let jsFetch = JSObject.global.fetch.function!

    private func getData(_ url: String) -> JSPromise {
        JSPromise(jsFetch(url, FetchOptions(method: "GET", headers: [:])).object!)!
    }

    private func postData(_ url: String, json: String) -> JSPromise {
        JSPromise(jsFetch(url, FetchOptions(method: "POST",
                                            headers: ["Content-Type":"application/json"],
                                            body: json)).object!)!
    }

    private struct FetchOptions: ConvertibleToJSValue {
        let method: String
        let headers: [String: String]
        let body: String?

        var jsValue: JSValue {
            var dict = ["method": method.jsValue]
            if !headers.isEmpty {
                dict["headers"] = headers.jsValue
            }
            if let body = body {
                dict["body"] = body.jsValue
            }

            return dict.jsValue
        }

        internal init(method: String, headers: [String : String], body: String? = nil) {
            self.method = method
            self.headers = headers
            self.body = body
        }
    }
}
