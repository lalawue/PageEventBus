//
//  ViewController.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/12.
//

import UIKit
import PinStackView

class ViewController: UIViewController {
    
    fileprivate lazy var noticeView = NoticeView().then {
        $0.style = .auto
        $0.axis = .vertical
        $0.addItem(UILabel().then {
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.text = "Notices"
        }).bottom(10)
        $0.viewModel = NoticeViewModel(view: $0)
    }
    
    fileprivate var buttons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in [1,2] {
            let btn = UIButton().then {
                $0.tag = index
                $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
                $0.layer.borderWidth = 0.5
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.layer.cornerRadius = 4
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                $0.setTitle("Update Notice \(index)", for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
            }
            buttons.append(btn)
            view.addSubview(btn)
        }
        
        navigationController?.view.addSubview(noticeView)
        noticeView.viewModel?.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        noticeView.pin.top(120).left(32).width(120).sizeToFit(.width)
        var y = view.frame.height / 2 - 120
        for btn in buttons {
            btn.pin.top(y).hCenter().height(44).sizeToFit(.height)
            y += 58
        }
    }
    
    @objc func onTap(_ button: UIButton) {
        let vc = BaseViewController(context: "\(button.tag)", fieldCount: button.tag).then {
            $0.titleLabel.text = "collect level \(button.tag) scores"
            $0.viewModel = BasePageModel(controller: $0)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

