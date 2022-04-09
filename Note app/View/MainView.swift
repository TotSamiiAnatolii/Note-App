//
//  MainView.swift
//  Note app
//
//  Created by APPLE on 23.03.2022.
//

import UIKit

final class MainView: UIView {

    //MARK: - Properties
    var notesTableView: UITableView!
    
    private let bottomPanelView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let countNotesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Нет заметок"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private var viewHeight: CGFloat {
        return self.bounds.height 
    }
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        notesTableView = UITableView(frame: CGRect.zero)
        notesTableView.translatesAutoresizingMaskIntoConstraints = false
        addView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    //Установка количества заметок
    func configure(count: Int) {

        switch count {
        case 0 :
            countNotesLabel.text = "Нет заметок"
        case 1 :
            countNotesLabel.text = ("\(count) заметка")
        case 2...4:
            countNotesLabel.text = ("\(count) заметки")
        case 5...Int.max :
            countNotesLabel.text = ("\(count) заметок")
        default:
            break
        }
    }
    
    //MARK: - View hierarchy
    private func addView() {
        self.addSubview(notesTableView)
        self.addSubview(bottomPanelView)
        bottomPanelView.addSubview(countNotesLabel)
    }
    
    //MARK: - Constraints
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            bottomPanelView.widthAnchor.constraint(equalTo: self.widthAnchor),
            bottomPanelView.heightAnchor.constraint(equalToConstant: viewHeight/CGFloat(15)),
            bottomPanelView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            notesTableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            notesTableView.topAnchor.constraint(equalTo: self.topAnchor),
            notesTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: bottomPanelView.topAnchor),
            notesTableView.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            countNotesLabel.centerXAnchor.constraint(equalTo: bottomPanelView.centerXAnchor),
            countNotesLabel.centerYAnchor.constraint(equalTo: bottomPanelView.centerYAnchor, constant: -10)
        ])
    }
}
