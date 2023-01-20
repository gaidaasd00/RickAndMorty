//
//  APICacheManager.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 20.01.2023.
//

import Foundation

/// Managers in memory session scoped api caches
final class APICacheManager {
   //API URL: Data
    private var cacheDictionary: [Endpoint: NSCache<NSString, NSData>] = [:]
    
    
         
    //MARK: - Init
    init() {
        setUpCache()
    }
    
    //MARK: - Public
    func cachedResponse(for endpoint: Endpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    func setCache(for endpoint: Endpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    //MARK: - Private
    private func setUpCache() {
        Endpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}

