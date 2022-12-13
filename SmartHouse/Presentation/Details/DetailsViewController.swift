//
//  DetailsViewController.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import UIKit
import Combine
class DetailsViewController: UIViewController {
    
    var viewModel: DetailViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = viewModel.switchOn
        switchControl.isEnabled = true
        switchControl.onTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction(_:)), for: .valueChanged)
        
        return switchControl
    }()
    lazy var sliderControl: UISlider = {
        return self.getCurrentUI()
    }() {
        didSet {
            self.updateView()
        }
    }
    
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageNames.lightOn)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.text = "value"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    init(
        viewModel: DetailViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        viewModel.$sliderValue
            .receive(on: DispatchQueue.main)
            .sink {  [weak self] _ in
                self?.updateView()
            }
            .store(in: &subscriptions)
        
        viewModel.$switchOn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isOn in
                self?.updateImage(from: isOn)
            }
            .store(in: &subscriptions)
    }
    
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        let step = viewModel.getStepValue()
        viewModel.sliderValue = roundf(sender.value / Float(step)) * Float(step)
    }
    
    @objc func handleSwitchAction(_ sender: UISwitch!)
    {
        viewModel.switchOn = sender.isOn
    }
}


extension DetailsViewController {
    private func setupUI() {
        
        self.view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor
                .constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor,
                                              multiplier: 1),
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        self.view.addSubview(containerView)
        containerView.addSubview(valueLabel)
        containerView.addSubview(switchControl)
        containerView.addSubview(sliderControl)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor
                .constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 40),
            containerView.widthAnchor
                .constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                   constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                    constant: -20),
            containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            switchControl.topAnchor
                .constraint(equalTo: containerView.topAnchor, constant: 20),
            switchControl.widthAnchor
                .constraint(equalToConstant: UIScreen.main.bounds.width * 0.3),
            switchControl.heightAnchor.constraint(equalToConstant: 40),
            switchControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor
                .constraint(equalTo: switchControl.bottomAnchor, constant: 20),
            valueLabel.widthAnchor
                .constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            valueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                constant: 20),
            valueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                 constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            sliderControl.topAnchor
                .constraint(equalTo: valueLabel.bottomAnchor, constant: -10),
            sliderControl.widthAnchor
                .constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            sliderControl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                   constant: 20),
            sliderControl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                    constant: -20),
            sliderControl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        
    }
    
    
    private func updateView() {
        self.valueLabel.text = "\(viewModel.sliderValue)  \(viewModel.getValueSuffix())"
    }
    
    private func updateImage(from isOn: Bool) {
        imageView.image =  UIImage(named: isOn ? viewModel.getImageOn() : viewModel.getImageOff())
    }
    
    private func setupLayoutForSlider(
        step: Float,
        max: Float,
        min: Float,
        currentValue: Float
    ) -> UISlider{
        var slider = UISlider()
        slider.minimumTrackTintColor = .green
        slider.maximumTrackTintColor = .red
        slider.thumbTintColor = .black
        slider.isContinuous = true
        slider.tintColor = UIColor.green
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        slider = UISlider(frame:CGRect(x: 10, y: 100, width: UIScreen.main.bounds.width * 0.8, height: 20))
        slider.maximumValue = max
        slider.minimumValue = min
        slider.value = currentValue
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        return slider
    }
    
    
    
    func getCurrentUI() -> UISlider {
        switch viewModel.getDeviceType() {
        case let .heater(heater):
            return setupLayoutForSlider(step: 0.5, max: 28, min: 7, currentValue: Float(heater.temperature ?? 0))
        case let .lighter(lighter):
            return setupLayoutForSlider(step: 1, max: 100, min: 0, currentValue: Float(lighter.intensity ?? 0))
        case let .roller(roller):
            return setupLayoutForSlider(step: 1, max: 100, min: 0, currentValue: Float(roller.position ?? 0))
        case .none:
            return UISlider()
        }
    }
}
