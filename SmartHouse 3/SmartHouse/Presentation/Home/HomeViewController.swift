//
//  ViewController.swift
//  SmartHouse
//
//   Created by Devinsley on 12/12/2022.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    var callback: ((_ item: Device) -> Void)?
    private var subscriptions = Set<AnyCancellable>()
    var devices: [Device] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    init(
        viewModel: HomeViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.$state.sink { [weak self] state in
            self?.render(state)
        }
        .store(in: &subscriptions)
        
        viewModel.fetchData()
    }
    

    // MARK: - Properties
    
    lazy var tableView: UITableView = {
       let table = UITableView()
       table.translatesAutoresizingMaskIntoConstraints = false
       table.register(ItemCell.self, forCellReuseIdentifier: "cell")
       table.rowHeight = 60
       table.layer.backgroundColor = UIColor.white.cgColor
       table.tableFooterView = UIView(frame: .zero)
       return table
    }()
    
}

// MARK: - UI Setup
extension HomeViewController {
    private func setupUI() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.widthAnchor
                .constraint(equalToConstant: UIScreen.main.bounds.width),
            tableView.heightAnchor
                .constraint(equalTo: self.view.heightAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
    
    private func render(_ state: HomeViewModel.State) {
        switch state {
        case .loading, .initial:
            debugPrint("loading")
        case .fail:
            debugPrint("error")
        case .success(let dataResponse):
            devices = dataResponse
        }
    }
    
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ItemCell else { return UITableViewCell()}
        let cellItem = devices[indexPath.row]
        cell.configureCell(with: CellViewModel(deviceName: cellItem.deviceName, mode: cellItem.mode, productType: cellItem.productType, temperature: cellItem.temperature, intensity: cellItem.intensity, position: cellItem.position))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.callback?(devices[indexPath.row])
    }
    
}
