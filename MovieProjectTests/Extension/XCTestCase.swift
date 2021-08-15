//
//  XCTestCase.swift
//  MovieProjectTests
//
//  Created by Gouranga Sasmal on 14/08/21.
//

import XCTest

extension XCTestCase {
    
    // MARK: - Helper Methods
    
    func loadResource(file name: String) -> Data? {
        let strings = name.split(separator: ".").map { String($0)}
        guard let fname = strings.first, let ext = strings.last else { return nil }
        return try? self.loadResource(name: fname, extension: ext)
    }

    private func loadResource(name: String, extension ext: String) throws -> Data {
        // Obtain Reference to Bundle
        let bundle = Bundle(for: type(of: self))
        
        // Ask Bundle for URL of Stub
        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            throw NSError.init(domain: "com.errorDomain", code: 2000, userInfo: ["Error": "URL not found"])
        }
        
        // Use URL to Create Data Object
        return try Data(contentsOf: url)
    }
}
