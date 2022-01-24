//
//  NetworkManager.swift
//  Random User Generator
//
//  Created by Macbook Air on 24.01.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    private init() {}
    
    static let shared = NetworkManager()
    
    private func createGetUserURL(page: Int, count: Int) -> URL? {
        return URL(string: "https://randomuser.me/api/?page=\(page)&results=\(count)")
    }
    
    func getUsers(page: Int, count: Int, completionBlock: @escaping(([Results]) -> ())) {
        guard let url = createGetUserURL(page: page, count: count) else { return }
        
        AF.request(url).response { response in
            
            guard let responseData = response.data else { return }
            
            do {
                let responseModel = try JSONDecoder().decode(Json4Swift_Base.self, from: responseData)
                completionBlock(responseModel.results ?? [])
            } catch {
                debugPrint(error)
            }
        }
    }
}

