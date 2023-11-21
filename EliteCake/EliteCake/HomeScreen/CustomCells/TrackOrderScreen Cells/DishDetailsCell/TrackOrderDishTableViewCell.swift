//
//  TrackOrderDishTableViewCell.swift
//  EliteCake
//
//  Created by TechnoTackle on 28/08/23.
//

import UIKit

class TrackOrderDishTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TrackOrderDishTableView: UITableView! {
        didSet {
            TrackOrderDishTableView.register(TrackOrderDishDetailsTableViewCell.nib, forCellReuseIdentifier: TrackOrderDishDetailsTableViewCell.identifier)
            TrackOrderDishTableView.separatorStyle = .none
            TrackOrderDishTableView.dataSource = self
            TrackOrderDishTableView.delegate = self
            TrackOrderDishTableView.backgroundColor = .clear
            TrackOrderDishTableView.showsVerticalScrollIndicator = false
            TrackOrderDishTableView.showsHorizontalScrollIndicator = false
            TrackOrderDishTableView.tableFooterView = UIView()
        }
    }

    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension TrackOrderDishTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TrackOrderDishTableView.dequeueReusableCell(withIdentifier: "TrackOrderDishDetailsTableViewCell", for: indexPath) as! TrackOrderDishDetailsTableViewCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
