//
//  LabelCell.swift
//  Compostional-Layout
//
//  Created by Juan Ceballos on 8/26/20.
//  Copyright © 2020 Juan Ceballos. All rights reserved.
//

import UIKit

class LabelCell: UICollectionViewCell {
    
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    // helper initializer method
    private func commonInit()   {
       setupTextLabelConstraints()
    }
    
    private func setupTextLabelConstraints()    {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
}
