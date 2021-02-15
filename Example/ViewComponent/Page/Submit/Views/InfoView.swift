//
//  InfoView.swift
//  ViewComponent
//
//  Created by tuu on 2021/2/14.
//

import UIKit
import PageEventBus

/** input status view
 */
class InfoView: BlockView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let viewSize = self.frame.size
        titleLabel.frame = CGRect(x: 0, y: (viewSize.height-16)/2, width: viewSize.width, height: 16)
    }
}
