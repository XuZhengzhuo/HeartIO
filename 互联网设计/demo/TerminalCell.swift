
import Foundation
import UIKit

class TerminalCell: UITableViewCell {
    
    
    var LogoImageView = UIImageView()
    var TitleLabel = UILabel()
    var TimeLabel = UILabel()
    var InfoLabel = UILabel()
    var SplitLineView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        LogoImageView.layer.cornerRadius = 10
//        LogoImageView.layer.masksToBounds = true

        TitleLabel.textAlignment = .left
        TitleLabel.textColor = #colorLiteral(red: 0.2596669197, green: 0.2597167194, blue: 0.2596603632, alpha: 1)
        TitleLabel.font = .systemFont(ofSize: 12)
        
        TimeLabel.textAlignment = .right
        TimeLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7868418236)
        TimeLabel.font = .systemFont(ofSize: 8)
        
        InfoLabel.textAlignment = .left
        InfoLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        InfoLabel.font = .systemFont(ofSize: 8)
        
        SplitLineView.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)

        contentView.addSubview(LogoImageView)
        contentView.addSubview(TitleLabel)
        contentView.addSubview(TimeLabel)
        contentView.addSubview(InfoLabel)
        contentView.addSubview(SplitLineView)
        
    }
    
    func setupConstraint(){
        
        contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        LogoImageView.translatesAutoresizingMaskIntoConstraints = false
        LogoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        LogoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        LogoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        LogoImageView.widthAnchor.constraint(equalTo: LogoImageView.heightAnchor, multiplier: 1).isActive = true
        LogoImageView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        InfoLabel.translatesAutoresizingMaskIntoConstraints = false
        InfoLabel.leadingAnchor.constraint(equalTo: LogoImageView.trailingAnchor, constant: 10).isActive = true
        InfoLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        InfoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        InfoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        //InfoLabel.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        SplitLineView.translatesAutoresizingMaskIntoConstraints = false
        SplitLineView.leadingAnchor.constraint(equalTo: InfoLabel.leadingAnchor, constant: 0).isActive = true
        SplitLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        SplitLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        SplitLineView.trailingAnchor.constraint(equalTo: InfoLabel.trailingAnchor, constant: 0).isActive = true
        
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        TitleLabel.leadingAnchor.constraint(equalTo: LogoImageView.trailingAnchor, constant: 10).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: InfoLabel.centerXAnchor, constant: 0).isActive = true
        TitleLabel.bottomAnchor.constraint(equalTo: InfoLabel.topAnchor).isActive = true
        //TitleLabel.backgroundColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        
        TimeLabel.translatesAutoresizingMaskIntoConstraints = false
        TimeLabel.leadingAnchor.constraint(equalTo: InfoLabel.centerXAnchor, constant: 0).isActive = true
        TimeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        TimeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        TimeLabel.bottomAnchor.constraint(equalTo: InfoLabel.topAnchor).isActive = true
    
    }
    
    func setupData(data: infomation){
        LogoImageView.image = data.img
        TitleLabel.text = data.title
        TimeLabel.text = data.time
        InfoLabel.text = data.info
    }
    
    required init?(coder: NSCoder) {
        //创建失败时的解决方法
        fatalError("init(coder:) has not been implemented")
    }
}


class infomation {
    var title: String = ""
    var info: String = ""
    var time: String = ""
    var img: UIImage!
    
    func setup(title: String, info: String, time: String, img: UIImage){
        self.title = title
        self.info = info
        self.time = time
        self.img = img
    }
}
