//
//  MoviesTableViewFooter.swift
//  Movies
//
//  Created by Duje Medak on 07/06/2018.
//  Copyright © 2018 Duje Medak. All rights reserved.
//

import UIKit
import PureLayout
/*
protocol TableViewFooterViewDelegate: class {
    func movieCreated(withText title: String, year: String, poster: String)
}

class MoviesTableViewFooter: UIView {
    
    var titleTextField: UITextField!
    var timeTextField: UITextField!
    var summaryTextField: UITextField!
    var createButton: UIButton!
    
    weak var delegate: TableViewFooterViewDelegate?
    
    @objc func createButtonTapped(_ sender: UIButton) {
        delegate?.movieCreated(withText: titleTextField.text ?? "" ,year: "2012", poster : summaryTextField.text ?? "")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.lightText
        
        titleTextField = UITextField()
        titleTextField.backgroundColor = UIColor.white
        self.addSubview(titleTextField)
        timeTextField = UITextField()
        timeTextField.backgroundColor = UIColor.white
        self.addSubview(timeTextField)
        summaryTextField = UITextField()
        summaryTextField.backgroundColor = UIColor.white
        self.addSubview(summaryTextField)
        
        titleTextField.autoPinEdge(.leading, to: .leading, of: self, withOffset: 16.0)
        titleTextField.autoPinEdge(.top, to: .top, of: self, withOffset: 16.0)
        titleTextField.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -16.0)
        titleTextField.autoSetDimension(.height, toSize: 30.0)
        
        timeTextField.autoPinEdge(.leading, to: .leading, of: self, withOffset: 16.0)
        timeTextField.autoPinEdge(.top, to: .bottom, of: titleTextField, withOffset: 16.0)
        timeTextField.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -16.0)
        timeTextField.autoSetDimension(.height, toSize: 30.0)
        
        summaryTextField.autoPinEdge(.leading, to: .leading, of: self, withOffset: 16.0)
        summaryTextField.autoPinEdge(.top, to: .bottom, of: timeTextField, withOffset: 16.0)
        summaryTextField.autoPinEdge(.trailing, to: .trailing, of: self, withOffset: -16.0)
        summaryTextField.autoSetDimension(.height, toSize: 30.0)
        
        createButton = UIButton()
        createButton.setTitle("Create", for: UIControlState.normal)
        addSubview(createButton)
        createButton.autoAlignAxis(.vertical, toSameAxisOf: self)
        createButton.autoPinEdge(.top, to: .bottom, of: summaryTextField, withOffset: 16.0)
        createButton.autoSetDimension(.height, toSize: 30)
        createButton.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -16.0)
        createButton.addTarget(self, action: #selector(MoviesTableViewFooter.createButtonTapped(_:)), for: UIControlEvents.touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/
