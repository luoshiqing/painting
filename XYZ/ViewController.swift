//
//  ViewController.swift
//  XYZ
//
//  Created by 罗石清 on 2019/11/14.
//  Copyright © 2019 HunanChangxingTrafficWisdom. All rights reserved.
//

import UIKit

enum MyEnum {
    case haha(value: String)
    case say(count: Int)
}

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "呵呵"
        
        
        let array: [String] = ["W201", "X26", "A102", "B222", "C222", "A109区间线", "Z222单换线", "222", "333", "444", "5555", "qwe", "asd", "we", "哈哈哈", "反反复复", "3445", "111", "555", "666", "YY", "旅1", "旅2", "1旅1", "2旅1"]
        
        let new = array.sorted { (n1, n2) -> Bool in
            return n1.localizedCompare(n2) == ComparisonResult.orderedAscending
        }

        print(new)
        //["210", "212", "762", "807", "809", "91", "912", "不说了", "哈哈12", "哈哈2", "搜嘎", "卧室", "渣渣2w", "渣渣iot", "a99", "a992", "a992区间1", "a992区间2", "s982", "u982", "w109", "w109区间"]
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = UIColor.systemGroupedBackground
        } else {
            // Fallback on earlier versions
            self.view.backgroundColor = UIColor.groupTableViewBackground
        }
        
        let btn = UIButton(frame: CGRect(x: 0, y: 100, width: 100, height: 40))
        btn.center.x = self.view.frame.width / 2
        btn.setTitle("下一步", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(self.nextAct), for: .touchUpInside)
        self.view.addSubview(btn)

    
        self.loadL()
        
        self.loadWJX()
    }
    
    @objc private func nextAct() {
        let next = NextViewController()
        self.navigationController?.pushViewController(next, animated: true)
    }


    private func loadL() {
        let radius: CGFloat = 6
        let kSJH: CGFloat = 50
        let rect = CGRect(x: 100, y: 200, width: 250, height: 100)
        
        
        let minX = rect.minX
        let minY = rect.minY
        
        let maxX = rect.maxX
        let maxY = rect.maxY
        
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
        
        path.addLine(to: CGPoint(x: minX, y: maxY - radius - kSJH / 2))
        path.addLine(to: CGPoint(x: minX - kSJH * 0.6, y: midY))
        path.addLine(to: CGPoint(x: minX, y: minY + radius + kSJH / 2))
        path.addLine(to: CGPoint(x: minX, y: minY + radius))
        
        let ltCenter = CGPoint(x: minX + radius, y: minY + radius)
        path.addArc(withCenter: ltCenter, radius: radius, startAngle: CGFloat.pi, endAngle: CGFloat.pi / 2 * 3, clockwise: true)
        
        
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.blue.cgColor
        layer.fillColor = UIColor.yellow.cgColor
        layer.lineWidth = 3
        layer.path = path.cgPath
        self.view.layer.addSublayer(layer)
    }
    
    private func loadWJX() {
        let radius: CGFloat = 150
        let ctX = self.view.frame.width / 2
        let ctp = CGPoint(x: ctX, y: 550)
        
        let path = UIBezierPath(arcCenter: ctp, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        
        
        let startCount = 5
        var points = [CGPoint]()
        let oneJ = CGFloat.pi * 2 / CGFloat(startCount)
        for i in 0..<startCount {
            //减去 CGFloat.pi / 2 ，让第一个点 在 顶部中心位置
            let jd = oneJ * CGFloat(i) - CGFloat.pi / 2
            let x = radius * cos(jd) + ctX
            let y = radius * sin(jd) + ctp.y
            let p = CGPoint(x: x, y: y)
            if i == 0 {
                points.append(p)
            }else{
                points.append(p)
            }
        }
        
        let p1 = UIBezierPath()
        var index = 0
        var count = 0
        let allCount = points.count
        while count < allCount {
            if index >= allCount {
                index = 1
            }
            let p = points[index]
            if index == 0 {
                p1.move(to: p)
            }else{
                p1.addLine(to: p)
            }
            if count == points.count - 1 {
                p1.addLine(to: points[0])
            }
            index += 2
            count += 1
        }

        path.append(p1)
        
        
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 0.5
        layer.path = path.cgPath
        self.view.layer.addSublayer(layer)
    }
}



