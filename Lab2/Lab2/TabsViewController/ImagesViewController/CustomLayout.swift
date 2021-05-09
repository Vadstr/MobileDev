//
//  CustomLayout.swift
//  Lab2
//
//  Created by Vadim on 09.05.2021.
//

import UIKit

final class CustomLayout: UICollectionViewLayout {
    
    var contentBounds = CGRect.zero
    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            return
        }
        
        cachedAttributes.removeAll()
        contentBounds = CGRect(origin: .zero, size: collectionView.bounds.size)
        
        let count = collectionView.numberOfItems(inSection: 0)
        
        var currentIndex = 0
        var segment = 0
        var lastFrame: CGRect = .zero
        
        let cvWidth = collectionView.bounds.size.width
        
        while currentIndex < count {
            let segmentFrame = CGRect(x: 0, y: lastFrame.maxY + 1.0, width: cvWidth, height: cvWidth * 3 / 5)
            
            let segmentRect = bigItemCenterSegment(for: segmentFrame, itemN: segment)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: 0))
            attributes.frame = segmentRect
            
            cachedAttributes.append(attributes)
            contentBounds = contentBounds.union(segmentRect)
            
            currentIndex += 1
            
            if segment == 6 {
                lastFrame = segmentRect
            }
            segment = segment < 6 ? segment + 1 : 0
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return contentBounds.size
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        // Find any cell that sits within the query rect.
        guard let lastIndex = cachedAttributes.indices.last,
              let firstMatchIndex = binSearch(rect, start: 0, end: lastIndex) else { return attributesArray }
        
        // Starting from the match, loop up and down through the array until all the attributes
        // have been added within the query rect.
        for attributes in cachedAttributes[..<firstMatchIndex].reversed() {
            guard attributes.frame.maxY >= rect.minY else { break }
            attributesArray.append(attributes)
        }
        
        for attributes in cachedAttributes[firstMatchIndex...] {
            guard attributes.frame.minY <= rect.maxY else { break }
            attributesArray.append(attributes)
        }
        
        return attributesArray
    }
    
    // Perform a binary search on the cached attributes array.
    func binSearch(_ rect: CGRect, start: Int, end: Int) -> Int? {
        if end < start { return nil }
        
        let mid = (start + end) / 2
        let attr = cachedAttributes[mid]
        
        if attr.frame.intersects(rect) {
            return mid
        } else {
            if attr.frame.maxY < rect.minY {
                return binSearch(rect, start: (mid + 1), end: end)
            } else {
                return binSearch(rect, start: start, end: (mid - 1))
            }
        }
    }
    
    private func bigItemCenterSegment(for frame: CGRect, itemN: Int) -> CGRect {
        
        let oneFifthHorizontalSlice = frame.dividedIntegral(fraction: 1.0 / 5.0, from: .minXEdge)
        let threeForthHorizontalSlice = oneFifthHorizontalSlice.second.dividedIntegral(fraction: 3.0 / 4.0, from: .minXEdge)
        let oneThirdVerticalLeftSlice = oneFifthHorizontalSlice.first.dividedIntegral(fraction: 1.0 / 3.0, from: .minYEdge)
        let oneSecondVerticalLeftSlice = oneThirdVerticalLeftSlice.second.dividedIntegral(fraction: 1.0 / 2.0, from: .minYEdge)
        
        let oneThirdVerticalRightSlice = threeForthHorizontalSlice.second.dividedIntegral(fraction: 1.0 / 3.0, from: .minYEdge)
        let oneSecondVerticalRightSlice = oneThirdVerticalRightSlice.second.dividedIntegral(fraction: 1.0 / 2.0, from: .minYEdge)
        
        switch itemN {
        case 0:
            return oneThirdVerticalLeftSlice.first
        case 1:
            return oneSecondVerticalLeftSlice.first
        case 2:
            return oneSecondVerticalLeftSlice.second
        case 3:
            return threeForthHorizontalSlice.first
        case 4:
            return oneThirdVerticalRightSlice.first
        case 5:
            return oneSecondVerticalRightSlice.first
        case 6:
            return oneSecondVerticalRightSlice.second
        default:
            return .zero
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let collectionView = collectionView else { return false }
        return !newBounds.size.equalTo(collectionView.bounds.size)
    }
}

extension CGRect{
    func dividedIntegral(fraction: CGFloat, from fromEdge: CGRectEdge) -> (first: CGRect, second: CGRect) {
        let dimension: CGFloat
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            dimension = self.size.width

        case .minYEdge, .maxYEdge:
            dimension = self.size.height
        }
        
        let distance = (dimension * fraction).rounded(.up)

        var slices = self.divided(atDistance: distance, from: fromEdge)
        switch fromEdge {
        case .minXEdge, .maxXEdge:
            slices.remainder.origin.x += 1
            slices.remainder.size.width -= 1

        case .minYEdge, .maxYEdge:
            slices.remainder.origin.y += 1
            slices.remainder.size.height -= 1
        }
        return (first: slices.slice, second: slices.remainder)
    }
}
