//
//  File 2.swift
//  
//
//  Created by Rutveek on 17/02/23.
//

import UIKit


protocol DirectionalSizeRectOfView {
    var sizeOfInset: CGFloat { get set }
    var viewOfBound: CGSize { get set }
    var setValueFloat: CGFloat { get set }
    mutating func setValueOfViewSilder(form point: CGPoint)
    func Silder_PointValue() -> CGPoint
    func SilderFirst_Pointorigion() -> CGPoint
    func silder_Size() -> CGSize
    func silder_RectFrame() -> CGRect
}

extension DirectionalSizeRectOfView {
    func silder_RectFrame() -> CGRect {
        return CGRect(origin: SilderFirst_Pointorigion(), size: silder_Size())
    }
}

struct LeftToRightRect: DirectionalSizeRectOfView {
    var sizeOfInset: CGFloat
    var viewOfBound: CGSize
    var setValueFloat: CGFloat
    func SilderFirst_Pointorigion() -> CGPoint {
        return CGPoint(x: sizeOfInset, y: sizeOfInset)
    }
    func silder_Size() -> CGSize {
        return CGSize(width: setValueFloat * (viewOfBound.width - 2.0 * sizeOfInset), height: viewOfBound.height - 2.0 * sizeOfInset)
    }
    mutating func setValueOfViewSilder(form point: CGPoint) {
        let width = viewOfBound.width - 2.0 * sizeOfInset
        let len = min(max((point.x - sizeOfInset), 0.0), width)
        setValueFloat = width > 0.0 ? (len / width) : 0.0
    }
    func Silder_PointValue() ->CGPoint {
        return CGPoint(x: sizeOfInset + silder_Size().width, y: 0)
    }
}

struct TopDownRect: DirectionalSizeRectOfView {
    var sizeOfInset: CGFloat
    var viewOfBound: CGSize
    var setValueFloat: CGFloat
    func SilderFirst_Pointorigion() -> CGPoint {
        return CGPoint(x: sizeOfInset, y: sizeOfInset)
    }
    func silder_Size() -> CGSize {
        return CGSize(width: viewOfBound.width - 2.0 * sizeOfInset , height: setValueFloat * (viewOfBound.height - 2.0 * sizeOfInset))
    }
    mutating func setValueOfViewSilder(form point: CGPoint) {
        let height = viewOfBound.height - 2.0 * sizeOfInset
        let len = min(max((point.y - sizeOfInset), 0.0), height)
        setValueFloat = height > 0.0 ? (len / height) : 0.0
    }
    func Silder_PointValue() ->CGPoint {
        return CGPoint(x: 0, y: sizeOfInset + silder_Size().height)
    }
}

struct BottomUpRect: DirectionalSizeRectOfView {
    var sizeOfInset: CGFloat
    var viewOfBound: CGSize
    var setValueFloat: CGFloat
    func SilderFirst_Pointorigion() -> CGPoint {
        return CGPoint(x: sizeOfInset, y:  viewOfBound.height - silder_Size().height - sizeOfInset)
    }
    func silder_Size() -> CGSize {
        return CGSize(width: viewOfBound.width - 2.0 * sizeOfInset, height: setValueFloat * (viewOfBound.height - 2.0 * sizeOfInset))
    }
    mutating func setValueOfViewSilder(form point: CGPoint) {
        let height = viewOfBound.height - 2.0 * sizeOfInset
        let len = min(max((height - point.y + sizeOfInset), 0.0), height)
        setValueFloat = height > 0.0 ? (len / height) : 0.0
    }
    func Silder_PointValue() ->CGPoint {
        return CGPoint(x: 0, y: viewOfBound.height - silder_Size().height - sizeOfInset)
    }
}

struct RightToLeftRect: DirectionalSizeRectOfView {
    var sizeOfInset: CGFloat
    var viewOfBound: CGSize
    var setValueFloat: CGFloat
    func SilderFirst_Pointorigion() -> CGPoint {
        return CGPoint(x: viewOfBound.width - silder_Size().width - sizeOfInset, y: sizeOfInset)
    }
    func silder_Size() -> CGSize {
        return CGSize(width: setValueFloat * (viewOfBound.width - 2.0 * sizeOfInset), height: viewOfBound.height - 2.0 * sizeOfInset)
    }
    mutating func setValueOfViewSilder(form point: CGPoint) {
        let width = viewOfBound.width - 2.0 * sizeOfInset
        let len = min(max((width - point.x + sizeOfInset), 0.0), width)
        setValueFloat = width > 0.0 ? (len / width) : 0.0
    }
    func Silder_PointValue() ->CGPoint {
        return CGPoint(x: viewOfBound.width - sizeOfInset - silder_Size().width, y: 0)
    }
}

