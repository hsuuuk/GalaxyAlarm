//
//  MainController.swift
//  GalaxyAlarm
//
//  Created by 심현석 on 2023/03/04.
//

import UIKit
import SnapKit

class MainController: UIViewController {

    //var data = [Data]()
    var datalist = [Data(midday: "오전", time: "7:40"), Data(midday: "오후", time: "3:42")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        view.backgroundColor = .white
        
        let tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 100
        
        navigationItem.title = "알람"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))

        rightBarButton.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
    }

    @objc func rightBarButtonTapped() {
        let controller = UINavigationController(rootViewController: AddAlarmController())
        navigationController?.present(controller, animated: true)
    }
}

extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.middayLabel.text = datalist[indexPath.row].midday
        cell.timeLabel.text = datalist[indexPath.row].time
        return cell
    }
}

extension MainController: UITableViewDelegate {
}

