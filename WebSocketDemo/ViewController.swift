//
//  ViewController.swift
//  WebSocketDemo
//
//  Created by Manav on 30/12/19.
//  Copyright © 2019 Manav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Int, MessageType>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDatasource()
        // Do any additional setup after loading the view.
    }

    func configureDatasource() {
        dataSource = UITableViewDiffableDataSource<Int,MessageType>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, identifier: MessageType) -> UITableViewCell? in
            var cell: UITableViewCell?
            switch identifier {
            case .incoming:
                cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            case .outgoing:
                cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            }
            return cell
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])
    }
}

