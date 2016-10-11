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
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.rowHeight = (1000 - 140) / 20;
        self.mj_header = MJRefreshNormalHeader { [weak self] in
            guard let weak = self else {return}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                // Put your code which should be executed with a delay here
                weak.mj_header.endRefreshing()
            })
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setScrollViewContentOffSet(point:CGPoint) {
        if !self.mj_header.isRefreshing() {
            self.contentOffset = point
        }
    }
    
    //UITableViewDataSource
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}
