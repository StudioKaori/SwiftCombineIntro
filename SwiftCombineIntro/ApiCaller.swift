//
//  ApiCaller.swift
//  SwiftCombineIntro
//
//  Created by Kaori Persson on 2022-06-09.
//

import Combine
import Foundation


class APICaller {
    
    static let shared = APICaller()
    
    func fetchCompanies() -> Future<[String], Error> {
        
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promise(.success(["Apple", "Google", "Facebook"]))
            }
        }

    }
}
