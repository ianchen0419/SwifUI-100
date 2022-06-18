//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Yi An Chen on 2022/3/13.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
