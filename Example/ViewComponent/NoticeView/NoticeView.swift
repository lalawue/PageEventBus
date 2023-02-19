//
//  NoticeView.swift
//  ViewComponent
//
//  Created by lii on 2023/2/19.
//

import UIKit
import PinStackView
import PageEventBus

class NoticeView: PinStackView, BlockViewModelHolder {
    var viewModel: BlockViewModelAgent?
}

fileprivate class NoticeEntryView: PinStackView {
    
    fileprivate var data: NoticeData? {
        didSet {
            if let data = data {
                updateData(data)
            }
        }
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 14)
        $0.textColor = UIColor.black
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.style = .auto
        self.axis = .vertical
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateData(_ data: NoticeData) {
        for v in subviews {
            if v != titleLabel {
                removeItem(v)
            }
        }
        titleLabel.text = data.title
        addItem(titleLabel).height(16)
        for (index, content) in data.contents.enumerated() {
            addItem(UILabel().then {
                $0.font = UIFont.systemFont(ofSize: 12)
                $0.textColor = UIColor.black
                $0.text = "lesson \(index + 1): \(content)"
            }).left(16).height(14)
        }
        self.isHidden = true
        self.isHidden = false
        self.setNeedsLayout()
    }
}

class NoticeViewModel: BlockViewModel<PinStackView, NoticeRequest, NoticeResonse> {
    
    fileprivate var notices = [String:NoticeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectBus()
    }
    
    override func didReceiveEvent(event: NoticeRequest) -> NoticeResonse? {
        switch event {
        case .updateNotice(let data):
            notices[data.context] = data
            for v in view.subviews {
                if let v = v as? NoticeEntryView, let d = v.data, d.context == data.context {
                    v.data = data
                    return nil
                }
            }
            let v = NoticeEntryView()
            view.addItem(v)
            view.triggerNeedsLayout(subview: v, active: true)
            v.data = data
        case .fetchNotice(let context):
            if let data = notices[context] {
                return .fetchNotice(data)
            }
        }
        return nil
    }
}
