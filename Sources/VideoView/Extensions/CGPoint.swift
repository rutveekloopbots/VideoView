//
//  File 3.swift
//  
//
//  Created by Rutveek on 17/02/23.
//


import UIKit

extension CGPoint {
    func adding(xValue: CGFloat) -> CGPoint { return CGPoint(x: self.x + xValue, y: self.y) }
    func adding(yValue: CGFloat) -> CGPoint { return CGPoint(x: self.x, y: self.y + yValue) }
    
    static func + (leftSide: CGPoint, rightSide: CGPoint) -> CGPoint {
        return CGPoint(x: leftSide.x + rightSide.x, y: leftSide.y + rightSide.y)
    }
    static func - (leftSide: CGPoint, rightSide: CGPoint) -> CGPoint {
        return CGPoint(x: leftSide.x - rightSide.x, y: leftSide.y - rightSide.y)
    }
    static func / (leftSide: CGPoint, rightSide: CGPoint) -> CGPoint {
        return CGPoint(x: leftSide.x / rightSide.x, y: leftSide.y / rightSide.y)
    }
    static func / (Top: CGPoint, Down: CGFloat) -> CGPoint {
        return CGPoint(x: Top.x / Down, y: Top.y / Down)
    }

    static prefix func - (Top: CGPoint) -> CGPoint {
        return CGPoint(x: -Top.x, y: -Top.y)
    }
    static func * (leftSide: CGPoint, rightSide: CGPoint) -> CGPoint {
        return CGPoint(x: leftSide.x * rightSide.x, y: leftSide.y * rightSide.y)
    }

    static func == (leftSide: CGPoint, rightSide: CGPoint) -> Bool {
        return (leftSide.x == rightSide.x && leftSide.y == rightSide.y)
    }

}

