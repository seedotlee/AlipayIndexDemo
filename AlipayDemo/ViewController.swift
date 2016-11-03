//
//  ViewController.swift
//  AlipayDemo
//
//  Created by See on 10/9/16.
//  Copyright © 2016 See. All rights reserved.
//

import UIKit
import MJRefresh

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let functionHeaderViewHeight:CGFloat = 95
let singleAppHeaderViewHeight:CGFloat = 60

class ViewController: UIViewController,UIScrollViewDelegate,UIGestureRecognizerDelegate {
    
    let topOffsetY = functionHeaderViewHeight + singleAppHeaderViewHeight
    
    lazy var mainScrollView: UIScrollView = {
    
        let height = SCREEN_HEIGHT - 64
        
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 64, width: SCREEN_WIDTH, height: height))
        scroll.delegate = self
        scroll.contentSize = CGSize(width: SCREEN_WIDTH, height: 100)
        scroll.scrollIndicatorInsets = UIEdgeInsets(top: 155, left: 0, bottom: 0, right: 0)
        return scroll
    }()
    
    lazy var navView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        view.backgroundColor = UIColor(red: 65/255.0, green: 128/255.0, blue: 1, alpha: 1)
        return view
        
    }()
    
    lazy var mainNavView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        view.backgroundColor = UIColor.clear
        
        let payButton = UIButton(type: UIButtonType.custom)
        payButton.setImage(#imageLiteral(resourceName: "home_bill"), for: UIControlState.normal)
        payButton.setTitle("账单", for: UIControlState.normal)
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        payButton.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 0
        )
        payButton.sizeToFit()
        
        var newFrame = payButton.frame
        newFrame.origin.y = 20 + 10
        newFrame.origin.x = 10
        newFrame.size.width = newFrame.size.width + 10
        payButton.frame = newFrame
        
        view.addSubview(payButton)
        
        return view
        
    }()

    
    lazy var coverNavView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 64))
        view.backgroundColor = UIColor.clear
        
        let payButton = UIButton(type: UIButtonType.custom)
        payButton.setImage(#imageLiteral(resourceName: "pay_mini"), for: UIControlState.normal)
        payButton.sizeToFit()
        
        var newFrame = payButton.frame
        newFrame.origin.y = 20 + 10
        newFrame.origin.x = 10
        newFrame.size.width = newFrame.size.width + 10
        
        payButton.frame = newFrame
        
        let scanButton = UIButton(type: UIButtonType.custom)
        scanButton.setImage(#imageLiteral(resourceName: "scan_mini"), for: UIControlState.normal)
        scanButton.sizeToFit()
        newFrame.origin.x = newFrame.origin.x + 40 + newFrame.size.width
        scanButton.frame = newFrame
        
        let searchButton = UIButton(type: UIButtonType.custom)
        searchButton.setImage(#imageLiteral(resourceName: "camera_mini"), for: UIControlState.normal)
        searchButton.sizeToFit()
        newFrame.origin.x = newFrame.origin.x + 40 + newFrame.size.width
        searchButton.frame = newFrame
            
        view.addSubview(payButton)
        view.addSubview(scanButton)
        view.addSubview(searchButton)

        view.alpha = 0
        return view
        
    }()
    
    lazy var mainTableView: IndexTableView = {
        
        let orginY =  singleAppHeaderViewHeight + functionHeaderViewHeight
        let tableviewHeight = 1000 - orginY
        
        let table = IndexTableView(frame: CGRect(x: 0, y: orginY, width: SCREEN_WIDTH, height: tableviewHeight), style: UITableViewStyle.plain)
        table.isScrollEnabled = false
        return table
    }()
    
    lazy var functionHeaderView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: functionHeaderViewHeight))
        view.backgroundColor = UIColor.clear
        
        let padding:CGFloat = 5.0
        
        let buttonWidth = SCREEN_WIDTH/4.0 - padding*2
        
        let scanButton = UIButton(type: UIButtonType.custom)
        scanButton.frame = CGRect(x: padding, y: padding, width: buttonWidth, height: buttonWidth)
        scanButton.setImage(#imageLiteral(resourceName: "home_scan"), for: UIControlState.normal)
        scanButton.setTitle("扫一扫", for: UIControlState.normal)
        scanButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        scanButton.alignImageAndTitleVertically()
        
        let payButton = UIButton(type: UIButtonType.custom)
        payButton.frame = CGRect(x: padding + SCREEN_WIDTH/4.0, y: padding, width: buttonWidth, height: buttonWidth)
        payButton.setImage(#imageLiteral(resourceName: "home_pay"), for: UIControlState.normal)
        payButton.setTitle("付款", for: UIControlState.normal)
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        payButton.alignImageAndTitleVertically()
        
        let cardButton = UIButton(type: UIButtonType.custom)
        cardButton.frame = CGRect(x: padding + SCREEN_WIDTH/4.0*2, y: padding, width: buttonWidth, height: buttonWidth)
        cardButton.setImage(#imageLiteral(resourceName: "home_card"), for: UIControlState.normal)
        cardButton.setTitle("卡券", for: UIControlState.normal)
        cardButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cardButton.alignImageAndTitleVertically()
        
        let xiuButton = UIButton(type: UIButtonType.custom)
        xiuButton.frame = CGRect(x: padding + SCREEN_WIDTH/4.0*3, y: padding, width: buttonWidth, height: buttonWidth)
        xiuButton.setImage(#imageLiteral(resourceName: "home_xiu"), for: UIControlState.normal)
        xiuButton.setTitle("到位", for: UIControlState.normal)
        xiuButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        xiuButton.alignImageAndTitleVertically()
        
        view.addSubview(scanButton)
        view.addSubview(payButton)
        view.addSubview(cardButton)
        view.addSubview(xiuButton)
        
        return view
        
    }()
    
    lazy var appHeaderView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: functionHeaderViewHeight, width: SCREEN_WIDTH, height: singleAppHeaderViewHeight))
        view.backgroundColor = UIColor.cyan
        return view
        
    }()
    
    lazy var headerView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: functionHeaderViewHeight + singleAppHeaderViewHeight))
        view.backgroundColor = UIColor(red: 65/255.0, green: 128/255.0, blue: 1, alpha: 1)
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(mainScrollView)
        self.view.addSubview(navView)
        self.view.addSubview(mainNavView)
        self.view.addSubview(coverNavView)
        
        mainScrollView.addSubview(headerView)
        headerView.addSubview(functionHeaderView)
        headerView.addSubview(appHeaderView)
        mainScrollView.addSubview(mainTableView)
        
        mainTableView.changeContentSize = { [weak self] contentSize in
            
            guard let weak = self else {return}

            weak.updateContentSize(size: contentSize)
            
        }
        
        self.mainScrollView.mj_footer = MJRefreshAutoNormalFooter { [weak self] in
            guard let weak = self else {return}
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {

                weak.mainScrollView.mj_footer.endRefreshing()
                weak.mainTableView.loadeMoreData()
            })
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateContentSize(size: self.mainTableView.contentSize)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateContentSize(size:CGSize) {
        var contentSize = size
        contentSize.height = contentSize.height + topOffsetY
        mainScrollView.contentSize = contentSize
        var newframe = mainTableView.frame
        newframe.size.height = size.height
        mainTableView.frame = newframe
    }
    
    func functionViewAnimation(offsetY y:CGFloat) {
        
        if y > functionHeaderViewHeight/2.0 {
            self.mainScrollView.setContentOffset(CGPoint(x:0,y:95), animated: true)

        } else {
            self.mainScrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)

        }
    }
    
    // UIScrollViewDelegate
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
        // 松手时判断是否刷新
        let y = scrollView.contentOffset.y;


        if y < -65 {
            self.mainTableView.mj_header.beginRefreshing()
        } else if y > 0 && y <= functionHeaderViewHeight {
            functionViewAnimation(offsetY: y)
        }

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        if y <= 0 {
            var newFrame = self.headerView.frame
            newFrame.origin.y = y
            self.headerView.frame = newFrame
            
            newFrame = self.mainTableView.frame
            newFrame.origin.y = y + topOffsetY
            self.mainTableView.frame = newFrame
            
            //偏移量给到tableview，tableview自己来滑动
            self.mainTableView.setScrollViewContentOffSet(point: CGPoint(x: 0, y: y))
            
            //功能区状态回归
            newFrame = self.functionHeaderView.frame
            newFrame.origin.y = 0
            self.functionHeaderView.frame = newFrame
            
        } else if y < functionHeaderViewHeight && y > 0{
            //处理功能区隐藏和视差
            var newFrame = self.functionHeaderView.frame
            newFrame.origin.y = y/2
            self.functionHeaderView.frame = newFrame

            //处理透明度
            let alpha = (1 - y/functionHeaderViewHeight*2.5 ) > 0 ? (1 - y/functionHeaderViewHeight*2.5 ) : 0
            
            functionHeaderView.alpha = alpha
            if alpha > 0.5 {
                let newAlpha =  alpha*2 - 1
                mainNavView.alpha = newAlpha
                coverNavView.alpha = 0
            } else {
                let newAlpha =  alpha*2
                mainNavView.alpha = 0
                coverNavView.alpha = 1 - newAlpha
            }

        }
        
        
    }
    

}

