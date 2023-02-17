//
//  CustomVideoView.swift
//  
//
//  Created by Rutveek on 17/02/23.
//


import UIKit

public enum SilderDirection: Int {
    case bottomToUp = 0
    case topToDown = 1
    case leftToRight = 2
    case rightToLeft = 3
}

public protocol videoViewSliderDelegate {
    func SilderVideoView(_ sender: videoViewSlider, didChanged value: Double)
}

@IBDesignable
open class videoViewSlider: UIView {

    public var delegate: videoViewSliderDelegate?
    
    @IBInspectable
    public var VideoViewColor: UIColor = .blue {
        didSet {
            piston_SilderLayer.backgroundColor = VideoViewColor.cgColor
        }
    }
    @IBInspectable
    public var textSilderColor: UIColor = .white {
        didSet {
            lbl_ValueText.textColor = textSilderColor
        }
    }
    @IBInspectable
    public var insetOfBackSilder: CGFloat = 4.0 {
        didSet {
            silderFrame!.sizeOfInset = insetOfBackSilder
            piston_SilderLayer.frame = silderFrame!.silder_RectFrame()
        }
    }
    
    var DirectionSilderOfValue: SilderDirection = .bottomToUp {
        didSet {
            silderFrame = getFrameGenerator(DirectionSilderOfValue)
        }
    }
    
    public func silderSetValue(_ value: Double) {
        silderValueUpdate(with: value)
        self.value = value
    }
    
    public var value: Double = 50.0 {
        didSet {
            lbl_ValueText.text = String(format: "%02.1f", value)
            delegate?.SilderVideoView(self, didChanged: value)
        }
    }
    
    @IBInspectable
    public var maximum: Double = 100.0
    @IBInspectable
    public var minimum: Double = -100.0
    
    var silderFrame: DirectionalSizeRectOfView!
    var piston_SilderLayer: CALayer = CALayer()
    var lbl_ValueText: UILabel = UILabel()
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let location = touches.first?.location(in: self) else { return }
        silderFrame.setValueOfViewSilder(form: location)
        piston_SilderLayer.frame = silderFrame.silder_RectFrame()
        value = calulateValue()
    }

    @objc func onPan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            let translation = sender.translation(in: self)
            let location = silderFrame.Silder_PointValue() + translation
            sender.setTranslation(.zero, in: self)
            silderFrame.setValueOfViewSilder(form: location)
            piston_SilderLayer.frame = silderFrame.silder_RectFrame()
            value = calulateValue()
        }
    }
    
    override public func layoutSubviews() {
        
        super.layoutSubviews()
        silderFrame.viewOfBound = self.bounds.size
        piston_SilderLayer.frame = silderFrame.silder_RectFrame()
        setCornerRadius(for: piston_SilderLayer)
        setCornerRadius(for: self.layer)
        lbl_ValueText.frame = centerRect(of: lbl_ValueText.font.lineHeight)
    }
    
    private func configurePistonLayer() {

        piston_SilderLayer.frame = silderFrame.silder_RectFrame()
        piston_SilderLayer.backgroundColor = VideoViewColor.cgColor
        self.layer.addSublayer(piston_SilderLayer)
    }
    
    private func configureTextLayer() {
        let font = UIFont.systemFont(ofSize: min(bounds.width, bounds.height, 48.0) / 4.0, weight: .bold)
        lbl_ValueText.frame = centerRect(of: font.lineHeight)
        lbl_ValueText.text = String(format: "%02.1f", value)
        lbl_ValueText.textColor = textSilderColor
        lbl_ValueText.font = font
        lbl_ValueText.textAlignment = .center
        lbl_ValueText.numberOfLines = 0
        self.addSubview(lbl_ValueText)
    }

    private func setup() {
        silderFrame = getFrameGenerator(DirectionSilderOfValue)
        configurePistonLayer()
        configureTextLayer()
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self,
        action: #selector(onPan)))
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    fileprivate func getFrameGenerator(_ direction: SilderDirection) -> DirectionalSizeRectOfView {
        switch direction {
        case .bottomToUp :
            return BottomUpRect(sizeOfInset: insetOfBackSilder,
                                          viewOfBound: bounds.size,
                                          setValueFloat: CGFloat(value01(value)))
        case .leftToRight:
            return LeftToRightRect(sizeOfInset: insetOfBackSilder,
                                             viewOfBound: bounds.size,
                                             setValueFloat: CGFloat(value01(value)))
            
        case .rightToLeft:
            return RightToLeftRect(sizeOfInset: insetOfBackSilder,
                                             viewOfBound: bounds.size,
                                             setValueFloat: CGFloat(value01(value)))
            
        case .topToDown:
            return TopDownRect(sizeOfInset: insetOfBackSilder,
                                         viewOfBound: bounds.size,
                                         setValueFloat: CGFloat(value01(value)))
            
        }
    }
    
    private func setCornerRadius( for layer: CALayer) {
        switch DirectionSilderOfValue {
            case .bottomToUp, .topToDown :
                layer.cornerRadius = layer.bounds.width <= 40.0 ? layer.bounds.width / 2.0 : layer.bounds.width / 10.0
            default:
                layer.cornerRadius = layer.bounds.height <= 40.0 ? layer.bounds.height / 2.0 : layer.bounds.height / 10.0
        }
        layer.masksToBounds = true
    }
    
    private func centerRect(of height: CGFloat) -> CGRect {
        return CGRect(x:0 , y: (bounds.height - height) / 2.0, width: bounds.width, height: height)
    }
    
    private func value01(_ value: Double) -> Double {
        let maxLen = (maximum - minimum)
        let len = value - minimum
        if len >= 0 && maxLen > 0 {
            return (len / maxLen)
        }
        return 0
    }
    
    private func silderValueUpdate( with value: Double) {
        silderFrame.setValueFloat = CGFloat(value01(value))
        piston_SilderLayer.frame = silderFrame.silder_RectFrame()
    }
    
    func calulateValue() -> Double {
        return minimum + Double(silderFrame.setValueFloat) * (maximum - minimum)
    }
}

