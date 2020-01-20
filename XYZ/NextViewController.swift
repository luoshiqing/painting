//
//  NextViewController.swift
//  XYZ
//
//  Created by 罗石清 on 2019/11/15.
//  Copyright © 2019 HunanChangxingTrafficWisdom. All rights reserved.
//

enum LsqLayerMode {
    case left(space: CGFloat?)
//    case top(space: CGFloat?)
//    case bottom(space: CGFloat?)
    case right(space: CGFloat?)
}
struct LsqLayerLayoutModel {
    var lineWidth: CGFloat = 1 //线条宽度
    var radius: CGFloat = 6 //圆角半径
    var strokeColor: CGColor = UIColor.blue.cgColor //线条颜色
    var triangleSize: CGSize = CGSize(width: 15, height: 40)//箭头大小
    //箭头显示位置，space，表示对应方向的x,y 的间距，如果为nil则居中
    var locationType: LsqLayerMode = .left(space: nil)
}

protocol LsqLayer {
    var showInView: UIView? { get }
    @discardableResult
    func getLsqLayer(model: LsqLayerLayoutModel) -> CAShapeLayer?
}

extension LsqLayer {
    @discardableResult
    func getLsqLayer(model: LsqLayerLayoutModel) -> CAShapeLayer? {
        guard let showView = showInView else {return nil}
        let rect = CGRect(x: 0, y: 0, width: showView.frame.width, height: showView.frame.height)
        
        let radius = model.radius
        let triangleSize = model.triangleSize
        
        switch model.locationType {
        case .left(let space):
            let minX = rect.minX + triangleSize.width + model.lineWidth / 2
            let minY = rect.minY + model.lineWidth / 2
            let maxX = rect.maxX - model.lineWidth / 2
            let maxY = rect.maxY - model.lineWidth / 2
            let midY = rect.midY
            let path = UIBezierPath()
            path.move(to: CGPoint(x: minX + radius, y: minY))
            path.addLine(to: CGPoint(x: maxX - radius, y: minY))
            let rtCenter = CGPoint(x: maxX - radius, y: minY + radius)
            path.addArc(withCenter: rtCenter, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
            path.addLine(to: CGPoint(x: maxX, y: maxY - radius))
            let rbCenter = CGPoint(x: maxX - radius, y: maxY - radius)
            path.addArc(withCenter: rbCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
            path.addLine(to: CGPoint(x: minX + radius, y: maxY))
            let lbCenter = CGPoint(x: minX + radius, y: maxY - radius)
            path.addArc(withCenter: lbCenter, radius: radius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
            if let sp = space {
                path.addLine(to: CGPoint(x: minX, y: triangleSize.height + sp))
                path.addLine(to: CGPoint(x: minX - triangleSize.width, y: triangleSize.height / 2 + sp))
                path.addLine(to: CGPoint(x: minX, y: sp))
                path.addLine(to: CGPoint(x: minX, y: minY + radius))
                
                let ltCenter = CGPoint(x: minX + radius, y: minY + radius)
                path.addArc(withCenter: ltCenter, radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2 * 3, clockwise: true)
            }else{
                path.addLine(to: CGPoint(x: minX, y: midY + triangleSize.height / 2))
                path.addLine(to: CGPoint(x: minX - triangleSize.width, y: midY))
                path.addLine(to: CGPoint(x: minX, y: midY - triangleSize.height / 2))
                path.addLine(to: CGPoint(x: minX, y: minY + radius))
                
                let ltCenter = CGPoint(x: minX + radius, y: minY + radius)
                path.addArc(withCenter: ltCenter, radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2 * 3, clockwise: true)
            }
            let layer = CAShapeLayer()
            layer.strokeColor = model.strokeColor
            layer.lineWidth = model.lineWidth
            layer.path = path.cgPath
            return layer
//        case .top(let space):
//            break
//        case .bottom(let space):
//            break
        case .right(let space):
            let minX = rect.minX + model.lineWidth / 2
            let minY = rect.minY + model.lineWidth / 2
            let maxX = rect.maxX - model.lineWidth / 2 - model.triangleSize.width
            let maxY = rect.maxY - model.lineWidth / 2
            let midY = rect.midY
            let path = UIBezierPath()
            path.move(to: CGPoint(x: minX + radius, y: minY))
            path.addLine(to: CGPoint(x: maxX - radius, y: minY))
            let rtCenter = CGPoint(x: maxX - radius, y: minY + radius)
            path.addArc(withCenter: rtCenter, radius: radius, startAngle: -CGFloat.pi / 2, endAngle: 0, clockwise: true)
            if let sp = space {
                path.addLine(to: CGPoint(x: maxX, y: sp))
                path.addLine(to: CGPoint(x: maxX + triangleSize.width, y: sp + triangleSize.height / 2))
                path.addLine(to: CGPoint(x: maxX, y: sp + triangleSize.height))
                path.addLine(to: CGPoint(x: maxX, y: maxY - radius))
                
                let ltCenter = CGPoint(x: maxX - radius, y: maxY - radius)
                path.addArc(withCenter: ltCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
            }else{
                path.addLine(to: CGPoint(x: maxX, y: midY - triangleSize.height / 2))
                path.addLine(to: CGPoint(x: maxX + triangleSize.width, y: midY))
                path.addLine(to: CGPoint(x: maxX, y: midY + triangleSize.height / 2))
                path.addLine(to: CGPoint(x: maxX, y: maxY - radius))
                let ltCenter = CGPoint(x: maxX - radius, y: maxY - radius)
                path.addArc(withCenter: ltCenter, radius: radius, startAngle: 0, endAngle: CGFloat.pi / 2, clockwise: true)
            }
            path.addLine(to: CGPoint(x: minX + radius, y: maxY))
            let lbCenter = CGPoint(x: minX + radius, y: maxY - radius)
            path.addArc(withCenter: lbCenter, radius: radius, startAngle: CGFloat.pi / 2, endAngle: CGFloat.pi, clockwise: true)
            path.addLine(to: CGPoint(x: minX, y: minY + radius))
            let ltCenter = CGPoint(x: minX + radius, y: minY + radius)
            path.addArc(withCenter: ltCenter, radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2 * 3, clockwise: true)
            let layer = CAShapeLayer()
            layer.strokeColor = model.strokeColor
            layer.lineWidth = model.lineWidth
            layer.path = path.cgPath
            return layer
        }
//        return nil
    }
}



import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "劳动竞赛"
        self.view.backgroundColor = UIColor.white
        
        let v = TestView(frame: CGRect(x: 0, y: 0, width: 350, height: 150))
        v.center = self.view.center
        v.backgroundColor = UIColor.red
        self.view.addSubview(v)
        
        let v1 = TestView(frame: CGRect(x: 0, y: 0, width: 350, height: 150))
        v1.center = self.view.center
        v1.frame.origin.y = v.frame.origin.y + v.frame.height + 10
        v1.backgroundColor = UIColor.red
        
        self.view.addSubview(v1)
        
        var model = v1.layerModel
        model.locationType = .right(space: 35)
        v1.layerModel = model
    }
    
}


class TestView: UIView, LsqLayer {
    
    var showInView: UIView? {
        return self
    }
    
    public var layerModel = LsqLayerLayoutModel() {
        didSet {
            self.myLayer?.removeFromSuperlayer()
            self.myLayer = nil
            self.myLayer = self.getLsqLayer(model: self.layerModel)
            self.layer.mask = self.myLayer
        }
    }
    
    private var myLayer: CAShapeLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
                
//        self.loadSomeView()
        
        self.myLayer = self.getLsqLayer(model: self.layerModel)
        self.layer.mask = self.myLayer
        
        self.loadSomeView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadSomeView() {
        let left = self.layerModel.triangleSize.width
        let lineWidth = self.layerModel.lineWidth
        let all = self.frame.width - left - lineWidth * 2
        let sp: CGFloat = 4
        let count = 4
        let one = (all - CGFloat(count + 1) * sp) / CGFloat(count)
        for i in 0..<count {
            
            let x = CGFloat(i) * (one + sp) + sp + left + lineWidth
            let btn = UIButton(frame: CGRect(x: x, y: 0, width: one, height: one))
            btn.center.y = self.frame.height / 2
            btn.setTitle("\(i)", for: .normal)
            btn.setTitleColor(UIColor.blue, for: .normal)
            btn.backgroundColor = UIColor.purple
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.addTarget(self, action: #selector(self.btnAct(_:)), for: .touchUpInside)
            btn.tag = i
            self.addSubview(btn)
        }
        
        
    }
    @objc private func btnAct(_ send: UIButton) {
        let tag = send.tag
        print(tag)
    }
}
