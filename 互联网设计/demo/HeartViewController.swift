
import UIKit
import Alamofire

//主页面
class HeartViewController: UIViewController {

    var errorInfoData: [infomation] = []
    var todayData: [Int] = []
    var timer : Timer?
    
    var SplitLineView = UIView()
    var UserInfoImageView = UIImageView()
    var NavView = UIView()
    var BackButton = UIButton()
    var ModeSwitch = UISegmentedControl(items: ["今日", "本周"])
    var FirstView = UIView()
    var HeartMapView = HeartState()
    var HeartMapTitleLabel = UILabel()
    var HeartMapEndLabel = UILabel()
    var SecondView = UIView()
    var TerminalTitleLabel = UILabel()
    var TerminalTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
        self.SetupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(recieveData), name: NSNotification.Name(rawValue: "Finished"), object: nil)
        self.timer = Timer.scheduledTimer(timeInterval: 1.1, target: self, selector: #selector(RequestAPI), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard let timer = self.timer
            else { return }
        timer.invalidate()
    }
    
    func SetupUI(){
        //导航栏
        self.view.addSubview(NavView)
        NavView.translatesAutoresizingMaskIntoConstraints = false
        NavView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        NavView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        NavView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        NavView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        NavView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //用户头像
        NavView.addSubview(UserInfoImageView)
        UserInfoImageView.translatesAutoresizingMaskIntoConstraints = false
        UserInfoImageView.trailingAnchor.constraint(equalTo: NavView.trailingAnchor, constant: -10).isActive = true
        UserInfoImageView.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: -5).isActive = true
        let Radius_UserInfoImageView = 18 as CGFloat
        UserInfoImageView.widthAnchor.constraint(equalToConstant: 2*Radius_UserInfoImageView).isActive = true
        UserInfoImageView.heightAnchor.constraint(equalToConstant: 2*Radius_UserInfoImageView).isActive = true
        UserInfoImageView.layer.masksToBounds = true
        UserInfoImageView.layer.cornerRadius = Radius_UserInfoImageView
        UserInfoImageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        UserInfoImageView.image = UIImage(named: "user.JPG")
        
        //返回按钮
        NavView.addSubview(BackButton)
        BackButton.translatesAutoresizingMaskIntoConstraints = false
        BackButton.leadingAnchor.constraint(equalTo: NavView.leadingAnchor, constant: 10).isActive = true
        BackButton.bottomAnchor.constraint(equalTo: NavView.bottomAnchor, constant: -5).isActive = true
        BackButton.widthAnchor.constraint(equalTo: UserInfoImageView.widthAnchor).isActive = true
        BackButton.heightAnchor.constraint(equalTo: UserInfoImageView.heightAnchor).isActive = true
        BackButton.setImage(UIImage(named: "back.png"), for: .normal)
        BackButton.addTarget(self, action: #selector(backBtnDidTouch), for: .touchDown)
        
        //分割线
        self.view.addSubview(SplitLineView)
        SplitLineView.translatesAutoresizingMaskIntoConstraints = false
        SplitLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        SplitLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        SplitLineView.topAnchor.constraint(equalTo: NavView.bottomAnchor).isActive = true
        SplitLineView.heightAnchor.constraint(equalToConstant: 1/3).isActive = true
        SplitLineView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        //今日 本周
        self.view.addSubview(ModeSwitch)
        ModeSwitch.translatesAutoresizingMaskIntoConstraints = false
        ModeSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        ModeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        ModeSwitch.topAnchor.constraint(equalTo: SplitLineView.bottomAnchor, constant: 20).isActive = true
        ModeSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ModeSwitch.selectedSegmentIndex = 0
        ModeSwitch.addTarget(self, action: #selector(ModeDidchange), for: .valueChanged)

        //画图区
        self.view.addSubview(FirstView)
        FirstView.translatesAutoresizingMaskIntoConstraints = false
        FirstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        FirstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        FirstView.topAnchor.constraint(equalTo: ModeSwitch.bottomAnchor, constant: 30).isActive = true
        FirstView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        FirstView.layer.masksToBounds = true
        // FirstView.layer.cornerRadius = 10
        // FirstView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        
        //画图区的标题
        FirstView.addSubview(HeartMapTitleLabel)
        HeartMapTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        HeartMapTitleLabel.leadingAnchor.constraint(equalTo: FirstView.leadingAnchor, constant: 10).isActive = true
        HeartMapTitleLabel.trailingAnchor.constraint(equalTo: FirstView.trailingAnchor).isActive = true
        HeartMapTitleLabel.topAnchor.constraint(equalTo: FirstView.topAnchor).isActive = true
        HeartMapTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        HeartMapTitleLabel.text = "心 率 图"
        HeartMapTitleLabel.textColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
        HeartMapTitleLabel.font = .systemFont(ofSize: 10)
        
        //画图区的结尾
        FirstView.addSubview(HeartMapEndLabel)
        HeartMapEndLabel.translatesAutoresizingMaskIntoConstraints = false
        HeartMapEndLabel.leadingAnchor.constraint(equalTo: FirstView.leadingAnchor, constant: 10).isActive = true
        HeartMapEndLabel.trailingAnchor.constraint(equalTo: FirstView.trailingAnchor).isActive = true
        HeartMapEndLabel.bottomAnchor.constraint(equalTo: FirstView.bottomAnchor).isActive = true
        HeartMapEndLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        HeartMapEndLabel.text = "更新于 10:59:59"
        HeartMapEndLabel.textColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
        HeartMapEndLabel.font = .systemFont(ofSize: 10)
        
        //画图区的曲线
        FirstView.addSubview(HeartMapView)
        HeartMapView.translatesAutoresizingMaskIntoConstraints = false
        HeartMapView.leadingAnchor.constraint(equalTo: FirstView.leadingAnchor, constant: 0).isActive = true
        HeartMapView.trailingAnchor.constraint(equalTo: FirstView.trailingAnchor, constant: 0).isActive = true
        HeartMapView.topAnchor.constraint(equalTo: HeartMapTitleLabel.bottomAnchor, constant: 0).isActive = true
        HeartMapView.bottomAnchor.constraint(equalTo: HeartMapEndLabel.topAnchor).isActive = true
        HeartMapView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        HeartMapView.layer.masksToBounds = true
        HeartMapView.layer.cornerRadius = 10
        
       //信息区
        self.view.addSubview(SecondView)
        SecondView.translatesAutoresizingMaskIntoConstraints = false
        SecondView.topAnchor.constraint(equalTo: FirstView.bottomAnchor, constant: 30).isActive = true
        SecondView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        SecondView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        SecondView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //信息区的标题
        SecondView.addSubview(TerminalTitleLabel)
        TerminalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TerminalTitleLabel.topAnchor.constraint(equalTo: SecondView.topAnchor, constant: 0).isActive = true
        TerminalTitleLabel.leadingAnchor.constraint(equalTo: SecondView.leadingAnchor, constant: 10).isActive = true
        TerminalTitleLabel.trailingAnchor.constraint(equalTo: SecondView.trailingAnchor, constant: 0).isActive = true
        TerminalTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        TerminalTitleLabel.text = "注 意 事 项"
        TerminalTitleLabel.textColor = #colorLiteral(red: 0.5882352941, green: 0.5882352941, blue: 0.5882352941, alpha: 1)
        TerminalTitleLabel.font = .systemFont(ofSize: 10)
        
        //信息区的内容
        SecondView.addSubview(TerminalTableView)
        TerminalTableView.translatesAutoresizingMaskIntoConstraints = false
        TerminalTableView.topAnchor.constraint(equalTo: TerminalTitleLabel.bottomAnchor, constant: 0).isActive = true
        TerminalTableView.leadingAnchor.constraint(equalTo: SecondView.leadingAnchor, constant: 0).isActive = true
        TerminalTableView.trailingAnchor.constraint(equalTo: SecondView.trailingAnchor, constant: 0).isActive = true
        TerminalTableView.bottomAnchor.constraint(equalTo: SecondView.bottomAnchor).isActive = true
        TerminalTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        TerminalTableView.register(TerminalCell.self, forCellReuseIdentifier: "TerminalCell")
        TerminalTableView.delegate = self
        TerminalTableView.dataSource = self
        TerminalTableView.separatorStyle = .none
        //TerminalTableView.layer.masksToBounds = true
        //TerminalTableView.layer.cornerRadius = 10
    }
}

extension HeartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //有多少个注意事项
        return errorInfoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //列表样式和内容
        let cell = tableView.dequeueReusableCell(withIdentifier: "TerminalCell") as! TerminalCell//指定这个 cell 的样式
        cell.setupConstraint()
        cell.setupData(data: errorInfoData[errorInfoData.count - indexPath.row - 1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func addErrorInfo2Table(rate: Int){

        // r = error
        // y = warning
        // g = dead
        
        let data = infomation()
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        data.time = "\(dformatter.string(from: now))"
        
        if rate<30{
            data.title = "危险情况"
            data.info = "你的心率过低！"
            data.img = UIImage(named: "red.png")
            self.errorInfoData.append(data)
        }
        else if rate<55{
            data.title = "需要注意"
            data.info = "你的心率略低！"
            data.img = UIImage(named: "yellow.png")
            self.errorInfoData.append(data)
        }else if rate<100{
            
        }else if rate<120{
            data.title = "需要注意"
            data.info = "你的心率略高！"
            data.img = UIImage(named: "yellow.png")
            self.errorInfoData.append(data)
        }else if rate<160{
            data.title = "危险情况"
            data.info = "你的心率过高！"
            data.img = UIImage(named: "red.png")
            self.errorInfoData.append(data)
        }else{
            data.title = "致命"
            data.info = "请停止剧烈活动并就医！"
            data.img = UIImage(named: "skull.png")
            self.errorInfoData.append(data)
        }
        self.HeartMapEndLabel.text = data.time
        self.TerminalTableView.reloadData()
    }
}



extension HeartViewController{
    
    @objc func ModeDidchange(){
        if ModeSwitch.selectedSegmentIndex == 0{
            HeartMapView.isDay = true
        }
        if ModeSwitch.selectedSegmentIndex == 1{
            HeartMapView.isDay = false
        }
    }
    
    @objc func recieveData(){
        //add point to heart map
        if todayData.isEmpty{
            print("Data empty!")
            return
        }
        HeartMapView.addPoint(rate: todayData.last!)
    }
    
    @objc func backBtnDidTouch(){
        self.dismiss(animated: true)
    }
    
    @objc func RequestAPI(){
        // 网络调用
        AF.request("http://60.205.182.154/api/student/getdata?groupname=group6_1&deviceId=867900046949577",method:.get, parameters:["groupname":"group6_1", "deviceId":"867900046949577"]).responseJSON{
            response in
            if let result = response.value{
                
                let json = result as! NSDictionary
                var my_rate_str = json["msg"] as! String
                my_rate_str = String(my_rate_str.prefix(10))
                var useful_rate_str = ""
                for i in 0...4{
                    let single_char = String(my_rate_str[my_rate_str.index(my_rate_str.startIndex, offsetBy: 1+i*2)])
                    if single_char >= "0" && single_char <= "9"{
                        useful_rate_str = useful_rate_str + single_char
                    }else{
                        print("Not A Int")
                        return
                    }
                }
                
                var rate = Int(useful_rate_str)!
                if rate > 200{
                    rate = Int(arc4random()%100) - 50 + 80
                }
                print("Heart Rate is \(rate)")
                
                self.todayData.append(rate)
                self.addErrorInfo2Table(rate: rate)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Finished"), object: self)
                }
            }
    }
}
