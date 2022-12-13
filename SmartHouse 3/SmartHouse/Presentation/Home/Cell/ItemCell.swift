//
//  ItemCell.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import UIKit
enum productTypee {
    case Light, RollerShutter, Heater
}

class ItemCell: UITableViewCell {

    lazy var deviceLabel: UILabel = {
       let label = UILabel()
       label.text = "@itsdanielkioko"
       label.textAlignment = .center
       label.font = UIFont.systemFont(ofSize: 15)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    lazy var deviceStatus: UILabel = {
       let label = UILabel()
       label.text = "status"
       label.textAlignment = .center
       label.font = UIFont.systemFont(ofSize: 13)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    lazy var deviceValue: UILabel = {
       let label = UILabel()
       label.text = "value"
       label.textAlignment = .center
       label.font = UIFont.systemFont(ofSize: 13)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    lazy var statusView: UIView = {
       let circle = UIView()
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 10
        circle.backgroundColor = .red
       return circle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: "cell")
        setupUI()
      
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setupUI() {
        self.addSubview(deviceLabel)
        self.addSubview(deviceStatus)
        self.addSubview(statusView)
        self.addSubview(deviceValue)

        NSLayoutConstraint.activate([
            deviceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            deviceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
           ])
        
        NSLayoutConstraint.activate([
            deviceStatus.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            statusView.heightAnchor
                   .constraint(equalToConstant: 20),
            deviceStatus.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: 0)
           ])
        NSLayoutConstraint.activate([
            deviceValue.leadingAnchor.constraint(equalTo: deviceStatus.trailingAnchor, constant: 5),
            deviceValue.heightAnchor
                   .constraint(equalToConstant: 20),
            deviceValue.centerYAnchor.constraint(equalTo: deviceStatus.centerYAnchor),
            deviceValue.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: 0)
           ])
        
        NSLayoutConstraint.activate([
            statusView.widthAnchor
                 .constraint(equalToConstant: 20),
            statusView.heightAnchor
                   .constraint(equalToConstant: 20),
            statusView.leadingAnchor.constraint(greaterThanOrEqualTo: deviceLabel.trailingAnchor, constant: 20),
            statusView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            statusView.centerYAnchor.constraint(equalTo: deviceLabel.centerYAnchor)
           ])
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(with item: CellViewModel) {
        self.deviceLabel.text = item.deviceName
        if let itemStatus = item.mode, itemStatus == "ON" {
            self.statusView.backgroundColor = .green
        } else {
            self.statusView.backgroundColor = .red
        }
        self.deviceStatus.text = getdeviceStatus(type: item.productType ?? "")
        
        if let temp = item.temperature {
            self.deviceValue.text = String(temp) + "°C"
        } else if let position = item.position {
            self.deviceValue.text = String(position)  + "%"
        } else if let intens = item.intensity {
            self.deviceValue.text = String(intens) 
        }
       
    }
    
    func getdeviceStatus(type: String) -> String? {
        if type == "Light" {
            return "intensity: "
        } else if type == "Heater"{
            return "temperature: "
        } else {
            return "position: "
        }
    }

}
