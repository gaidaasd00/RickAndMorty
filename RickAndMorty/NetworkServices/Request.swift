//
//  Request.swift
//  RickAndMorty
//
//  Created by Alexey Gaidykov on 24.12.2022.
//

import Foundation

/// Object that represent a single API call
final class Request {
    /// API Constants
    private struct Constants  {
        static let baseUrl = "https://rickandmortyapi.com/api"
        
    }
    /// Desired endpoint
    private let endpoint: Endpoint
    
    /// Path components for API, if any
    private let pathComponents: Set<String>
    
    /// Quere argument for API, if any
    private let quereParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({
                string += "/\($0)"
            })
        }
        
        if !quereParameters.isEmpty {
            string += "?"
            let argumentString = quereParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        return string
    }
    //MARK: - Public
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    /// Desired http method
    public let httpMethod = "GET"
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents:  Collection of Path components
    ///   - quereParameters: Collection of query parameters
    public init(
        endpoint: Endpoint,
        pathComponents: Set<String> = [],
        quereParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.quereParameters = quereParameters
    }
}
