//
//  FileDataProvider.swift
//  MovieProject
//
//  Created by Gouranga Sasmal on 06/08/21.
//

import Foundation

/// Fetch data from serice
protocol Fetchable {
    func fetchData(completion: @escaping(Data?, Error?)->Void)
}

/// Fetch data from file
struct FileDataProvider: Fetchable {
    
    let fileName: String
    
    func fetchData(completion: @escaping (Data?, Error?) -> Void) {
        
        let strings = fileName.split(separator: ".").map { String($0)}
        guard let name = strings.first, let ext = strings.last else {
            let error = NSError.init(domain: "error.domain.FileManager", code: 1001, userInfo: ["userInfo":"File name is not proper"])
            completion(nil,error)
            return
        }
        
        guard let path = Bundle.main.path(forResource: name, ofType: ext) else {
            let error = NSError.init(domain: "error.domain.FileManager", code: 1001, userInfo: ["userInfo":"File path not found"])
            completion(nil,error)
            return
        }
        // form the fileURL
        let fileURL = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: fileURL)
            completion(data, nil)
        } catch let error {
            completion(nil, error)
        }
    }
}

/*
/// OUT OF Scope for now
/// Fetch data from Network
struct NetworkDataProvider: Fetchable {
    func fetchData(completion: @escaping (Data?, Error?) -> Void) {
        
    }
}*/
