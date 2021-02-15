//
//  ResultView.swift
//  ViewComponent
//
//  Created by lalawue on 2021/2/15.
//

import UIKit
import PageEventBus

class ResultView: BlockView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(firstLabel)
        addSubview(secondLabel)
        layer.cornerRadius = 2.0
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let viewSize = frame.size
        var y: CGFloat = (viewSize.height - 68)/2
        titleLabel.frame = CGRect(x: 10, y: y, width: viewSize.width - 20, height: 16)
        y += 16 + 10
        firstLabel.frame = CGRect(x: 10, y: y, width: viewSize.width - 20, height: 16)
        y += 16 + 10
        secondLabel.frame = CGRect(x: 10, y: y, width: viewSize.width - 20, height: 16)
    }
}
