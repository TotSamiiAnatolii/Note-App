//
//  NotesView.swift
//  Note app
//
//  Created by APPLE on 23.03.2022.
//

import UIKit

final class NotesView: UIView {

    //MARK: - Properties
    let textNote: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.allowsEditingTextAttributes = true
        textView.isScrollEnabled = true
        textView.largeContentTitle = textView.text
        return textView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View hierarchy
    func setupViews() {
        self.addSubview(textNote)
    }
    
    //MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textNote.widthAnchor.constraint(equalTo: self.widthAnchor),
            textNote.heightAnchor.constraint(equalTo: self.heightAnchor),
        ])
    }
}
