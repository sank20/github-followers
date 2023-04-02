//
//  GFBodyLabel.swift
//  github-followers
//
//  Created by Sanket Pimple on 3/26/23.
//

import UIKit

class GFBodyLabel: UILabel {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlign: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlign
        configure()
    }
    
    private func configure() {
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        font = UIFont.preferredFont(forTextStyle: .body)
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
