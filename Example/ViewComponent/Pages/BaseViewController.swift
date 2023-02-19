//
//  BaseViewController.swift
//  ViewComponent
//
//  Created by lii on 2023/2/19.
//

import UIKit
import PinStackView
import PageEventBus

class BaseViewController: BlockViewContnroller {
    
    fileprivate let context: String
    fileprivate let fieldCount: Int
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.black
    }
    
    fileprivate var textFields = [BaseTextField]()
    
    fileprivate var button = UIButton().then {
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.setTitle("Ok", for: .normal)
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 4
        $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    init(context: String, fieldCount: Int) {
        self.context = context
        self.fieldCount = fieldCount
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        for index in 0..<fieldCount {
            let v = BaseTextField().then {
                $0.placeholder = "lesson \(index + 1) score"
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = UIColor.black
                $0.keyboardType = .numberPad
                $0.layer.borderWidth = 0.5
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.layer.cornerRadius = 4
            }
            view.addSubview(v)
            textFields.append(v)
        }
        view.addSubview(button)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.pin.left(32).top(300).height(20).sizeToFit(.height)
        var y = CGFloat(320)
        for v in textFields {
            v.pin.top(y + 8)
                .left(32)
                .right(32)
                .height(32)
            y += 40
        }
        button.pin.top(y + 10)
            .right(32)
            .height(32)
            .sizeToFit(.height)
    }
}

class BasePageModel: BlockPageModel<BaseViewController, NoticeRequest, NoticeResonse> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectBus()
        controller.button.addTarget(self, action: #selector(onTapOk), for: .touchUpInside)
    }
    
    override func viewAppear() {
        super.viewAppear()
        if case .fetchNotice(let data) = bus?.requestOne(.fetchNotice(controller.context)),
           controller.textFields.count == data.contents.count
        {
            for (index, content) in data.contents.enumerated() {
                controller.textFields[index].text = content
            }
        }
    }
    
    @objc private func onTapOk() {
        var texts = [String]()
        for tf in controller.textFields {
            if let text = tf.text, text.count > 0 {
                texts.append(text)
            } else {
                return
            }
        }
        bus?.sendEvent(.updateNotice(NoticeData(context: controller.context, title: "level \(controller.textFields.count)", contents: texts)))
    }
}

fileprivate class BaseTextField: UITextField {

    var textInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
}
