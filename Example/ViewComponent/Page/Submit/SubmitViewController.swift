//
//  SubmitViewController.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/14.
//

import UIKit
import PageEventBus

/** enter phone, email before submit
 */
class SubmitViewController: UIViewController {
    
    var pageModel: SubmitPageModel?
    
    var phoneVC: InputViewController?
    var emailVC: InputViewController?
    
    var infoView: InfoView?
    
    lazy var confirmButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("Submit", for: .normal)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.darkGray.cgColor
        btn.layer.cornerRadius = 22
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .disabled)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneVC = InputViewController.init(nibName: nil, bundle: nil)
        emailVC = InputViewController.init(nibName: nil, bundle: nil)
        infoView = InfoView()
        
        /// create page model
        pageModel = SubmitPageModel(controller: self)
        pageModel!.connectBus()
        pageModel!.data = "viewDidLoad"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let viewSize = self.view.frame.size
        infoView?.frame = CGRect(x: 0, y: 250, width: viewSize.width, height: 20)
        var y = CGFloat(300)
        let height = CGFloat(80)
        phoneVC?.view.frame = CGRect(x: 0, y: y, width: viewSize.width, height: height)
        y += height
        emailVC?.view.frame = CGRect(x: 0, y: y, width: viewSize.width, height: height)
        y += 1.5 * height
        confirmButton.frame = CGRect(x: viewSize.width/2 - 90, y: y, width: 180, height: 44)
    }
}
