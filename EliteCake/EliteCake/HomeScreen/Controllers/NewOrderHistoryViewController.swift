//
//  NewOrderHistoryViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 23/08/23.
//

import UIKit

class NewOrderHistoryViewController: UIViewController {
    
    @IBOutlet weak var newOrderHistoryTableView: UITableView! {
        didSet {
            //Register TableView Cells
            newOrderHistoryTableView.register(NewOrderHistoryTableViewCell.nib, forCellReuseIdentifier: NewOrderHistoryTableViewCell.identifier)
            newOrderHistoryTableView.separatorStyle = .none
            newOrderHistoryTableView.dataSource = self
            newOrderHistoryTableView.delegate = self
            newOrderHistoryTableView.backgroundColor = .clear
            newOrderHistoryTableView.showsVerticalScrollIndicator = false
            newOrderHistoryTableView.showsHorizontalScrollIndicator = false
            newOrderHistoryTableView.tableFooterView = UIView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension NewOrderHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newOrderHistoryTableView.dequeueReusableCell(withIdentifier: "NewOrderHistoryTableViewCell") as! NewOrderHistoryTableViewCell
        
        cell.contentLbl.text = "\(indexPath.row + 1 )"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.newOrderHistoryTableView.frame.width, height: 50))
        headerView.backgroundColor = UIColor.yellow
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.newOrderHistoryTableView.frame.width, height: 50))
        label.textAlignment = .center
        label.text = "Numbering 1 to 25"
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.newOrderHistoryTableView.frame.width, height: 50))
        footerView.backgroundColor = UIColor.yellow
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        button.setTitle("Reorder", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        setShadow(view: button)
        footerView.addSubview(button)
        
        return footerView
    }
}
