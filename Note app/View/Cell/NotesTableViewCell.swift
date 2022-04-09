//
//  NotesTableViewCell.swift
//  Note app
//
//  Created by APPLE on 24.03.2022.
//

import UIKit

final class NotesTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifire = "CellNotes"
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let textNoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.italicSystemFont(ofSize: 15)
        return label
    }()
    
    
    //MARK: - Lifestyle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public
    //Уставновка заголовка и текста
    func configureCell(data: NoteApp) {
        headerLabel.text = data.title
        textNoteLabel.text = data.textNote
    }
    
    //MARK: - View hierarchy
    private func setupViews() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(textNoteLabel)
    }
    
    //MARK: - Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 10),
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1),
            headerLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            textNoteLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 10),
            textNoteLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 2),
            textNoteLabel.leftAnchor.constraint(equalTo: headerLabel.leftAnchor),
            textNoteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
