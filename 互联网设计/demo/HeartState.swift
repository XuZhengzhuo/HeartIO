
import UIKit

class HeartState: UIView {

    let shapeLayer = CAShapeLayer()
    let RateLabel = UILabel()
    
    //折线图测试数据
    //var dayData:[CGPoint] = [CGPoint(x: 50, y: 30),CGPoint(x: 70, y: 40),CGPoint(x: 90, y: 35),CGPoint(x: 110, y: 55),CGPoint(x: 130, y: 20),CGPoint(x: 150, y: 40),CGPoint(x: 170, y: 60),CGPoint(x: 190, y: 90),CGPoint(x: 210, y: 85),CGPoint(x: 230, y: 75),CGPoint(x: 250, y: 72),CGPoint(x: 270, y: 82),CGPoint(x: 290, y: 84),CGPoint(x: 310, y: 100)]
    
    var dayData:[CGPoint] = []
    //柱形图数据 这里先用假的吧
    var weekData:[CGFloat] = [90, 100, 60, 70, 50, 60, 80]
    
    var isDay = true{
        //当前是显示实时数据（day）还是每周数据（week）
        didSet{
            //当此变量的值改变时自动调用此方法
            self.shapeLayer.removeFromSuperlayer()
            setNeedsDisplay()//自动调用 self.draw()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        RateLabel.frame.size = CGSize(width: 80, height: 30)
        self.drawGrid()
        if isDay{
            self.addSubview(RateLabel)
            self.drawDayHeartBeat()
        }else{
            RateLabel.removeFromSuperview()
            self.drawWeekHeartBeat()
        }
    }
    
    func drawGrid(){
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let splitLag = 20 as CGFloat
        var startXPoints: [CGFloat] = []
        var startYPoints: [CGFloat] = []
        
        //画竖线
        var x = 2.5 as CGFloat
        while x<self.frame.width{
            startXPoints.append(x)
            x = x + splitLag
        }
        for item in startXPoints{
            context.move(to: CGPoint(x: item, y: 0))
            context.addLine(to: CGPoint(x: item, y: self.frame.height))
        }
        //画横线
        var y = self.frame.height-2.5 as CGFloat
        while y>0 {
            startYPoints.append(y)
            y = y - splitLag
        }
        for item in startYPoints{
            context.move(to: CGPoint(x: 0, y: item))
            context.addLine(to: CGPoint(x: self.frame.width, y: item))
        }
        context.setLineWidth(1)
        context.setStrokeColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.5))
        context.strokePath()
    }

    func drawDayHeartBeat(){
        let linePath = UIBezierPath()
        if dayData.count < 1{
            return
        }
        if dayData.count == 1{
            linePath.move(to: dayData.first!)
            linePath.addLine(to: dayData.first!)
        }
        else{
            let lastPoint = dayData[dayData.count-2]
            linePath.move(to: lastPoint)
            linePath.addLine(to: dayData.last!)
            UIView.animate(withDuration: 1, animations: {
                self.RateLabel.frame = CGRect(x: self.dayData.last!.x - 50, y: self.dayData.last!.y, width: self.RateLabel.frame.width, height: self.RateLabel.frame.height)
            })
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            var oldP = dayData
            oldP.remove(at: oldP.count-1)
            if oldP.count >= 2{
                for i in 1 ... oldP.count-1{
                    context.move(to: oldP[i-1])
                    context.addLine(to: oldP[i])
                }
            }
            context.setLineWidth(3)
            context.setStrokeColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
            context.strokePath()
        }

        shapeLayer.path = linePath.cgPath
        shapeLayer.lineWidth = 3
        shapeLayer.strokeColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
        growAnimation.toValue = 1
        growAnimation.duration = 1
        growAnimation.fillMode = .forwards
        growAnimation.isRemovedOnCompletion = false
        shapeLayer.add(growAnimation, forKey: "ur")
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawWeekHeartBeat(){
        
        var startX: [CGFloat] = []
        let lagX = self.frame.width/8 as CGFloat
        for i in 1...7{
            startX.append(lagX*CGFloat(i))
        }
        let startY = 7/8 * self.frame.height
        var endY:[CGFloat] = []
        let lagY = self.frame.height * (6/8) / 200
        for i in 0...6{
            let tmp = lagY * weekData[i]
            endY.append(tmp)
        }
        
        let weekLinePath = UIBezierPath()
        for i in 0 ... 6{
            weekLinePath.move(to: CGPoint(x: startX[i], y: startY))
            weekLinePath.addLine(to: CGPoint(x: startX[i], y: endY[i]))
        }
        shapeLayer.path = weekLinePath.cgPath
        shapeLayer.lineWidth = 10
        shapeLayer.strokeColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
        growAnimation.toValue = 1
        growAnimation.duration = 1
        growAnimation.fillMode = .forwards
        growAnimation.isRemovedOnCompletion = false
        shapeLayer.add(growAnimation, forKey: "ur")
        self.layer.addSublayer(shapeLayer)
    }
    
    func addPoint(rate: Int){
        
        let lagX = 20 as CGFloat
        let lagY = self.frame.height/200
        
        let point = CGPoint(x: lagX*(CGFloat(dayData.count+1)), y: CGFloat(200-rate)*lagY)
        dayData.append(point)
        if dayData.count == 1{
            self.RateLabel.frame = CGRect(x: self.dayData.last!.x, y: self.dayData.last!.y, width: self.RateLabel.frame.width, height: self.RateLabel.frame.height)
        }
        // print(dayData)
        if dayData.last!.x > self.frame.width - lagX{
            for (idx, item) in dayData.enumerated(){
                dayData[idx] = CGPoint(x: item.x-lagX, y: item.y)
            }
        }
        //保持内存为一定规模 屏幕之外的数据丢掉
        if dayData.count > (Int(self.frame.width/lagX)){
            dayData.remove(at: 0)
        }
        
        if isDay{
            self.RateLabel.text = "\(rate)" + " bpm"
            setNeedsDisplay()
        }
    }
}
