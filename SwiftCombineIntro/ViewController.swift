//
//  ViewController.swift
//  SwiftCombineIntro
//
//  Created by Kaori Persson on 2022-06-09.
//

import Combine
import UIKit

class MyCustomTableCell: UITableViewCell {
    private let button: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 10, y: 3, width: contentView.frame.size.width-20, height: contentView.frame.size.height-20)
    }
}

class ViewController: UIViewController, UITableViewDataSource{

    
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(MyCustomTableCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [String]()
    
    var observer: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        observer = APICaller.shared.fetchCompanies()
            // Where do you want to receive, main thread
            .receive(on: DispatchQueue.main)
            .sink(
            // Finished, or give you error
            receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            },
            // Give you a value of success case
            receiveValue: { [weak self] value in
                self?.models = value
                self?.tableView.reloadData()
            })
    }

    // MARK: - tableview data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyCustomTableCell else {
            fatalError()
        }
        //cell.textLabel?.text = models[indexPath.row]
        
        return cell
    }

}

