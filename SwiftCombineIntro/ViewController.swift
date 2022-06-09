//
//  ViewController.swift
//  SwiftCombineIntro
//
//  Created by Kaori Persson on 2022-06-09.
//

import UIKit

class MyCustomTableCell: UITableViewCell {
    
}

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MyCustomTableCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

