//
//  IndexTableView.swift
//  AlipayDemo
//
//  Created by See on 10/10/16.
//  Copyright © 2016 See. All rights reserved.
//

import UIKit
import MJRefresh

class IndexTableView: UITableView,UITableViewDelegate,UITableViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var numberRows:Int = 50
    
    var changeContentSize:((_ contentSize:CGSize)->())?

    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.rowHeight = (1000 - 140) / 20;
        self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.mj_header = MJRefreshNormalHeader { [weak self] in
            guard let weak = self else {return}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                // Put your code which should be executed with a delay here
                weak.mj_header.endRefreshing()
                weak.reloadData()

            })
        }
        
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadeMoreData() {
        
        self.numberRows += 10
        self.reloadData()
        self.changeContentSize?(self.contentSize)

    }
    
    func setScrollViewContentOffSet(point:CGPoint) {
        if !self.mj_header.isRefreshing() {
            self.contentOffset = point
        }
    }
    
    //UITableViewDataSource
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            
            cell.textLabel?.text = "\(indexPath.row) - reusablecell"
            return cell
        } else {
            
            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
            cell.textLabel?.text = "\(indexPath.row)"
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberRows
    }
}
