//
//  FetchResult.swift
//  AnyImageKit
//
//  Created by 刘栋 on 2021/4/12.
//  Copyright © 2021-2022 AnyImageKit.org. All rights reserved.
//

import Photos
import Foundation

/// A wrapper around PHFetchResult
struct FetchResult<Element: AnyObject> {
    
    let phFetchResult: PHFetchResult<Element>
    
    init(_ phFetchResult: PHFetchResult<Element>) {
        self.phFetchResult = phFetchResult
    }
}

// MARK: - Sequence
extension FetchResult: Sequence {
    
    func makeIterator() -> AnyIterator<Element> {
        var count = 0
        return AnyIterator<Element> {
            defer { count += 1 }
            return count < phFetchResult.count ? phFetchResult.object(at: count) : nil
        }
    }
}

// MARK: - Collection
extension FetchResult: Collection, BidirectionalCollection {
    
    var startIndex: Int {
        return 0
    }
    
    var endIndex: Int {
        return phFetchResult.count
    }
    
    func index(before i: Int) -> Int {
        return i - 1
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
    
    subscript(position: Int) -> Element {
        return phFetchResult.object(at: position)
    }
    
    subscript(bounds: IndexSet) -> [Element] {
        return phFetchResult.objects(at: bounds)
    }
}
