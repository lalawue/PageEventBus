//
//  ViewController.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/12.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.setTitle("Example", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.addTarget(self, action: #selector(onTap(button:)), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let viewSize = self.view.frame.size
        button.frame = CGRect(x: viewSize.width/2 - 50, y: viewSize.height/2 - 22, width: 100, height: 44)
    }
    
    @objc func onTap(button: UIButton) {
        let vc = SubmitViewController.init(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}

