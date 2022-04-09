//
//  ViewController.swift
//  Note app
//
//  Created by APPLE on 23.03.2022.
//

import UIKit

protocol NoteDelegate {
    func deleteNote(id: UUID)
    func updateNote(text: String, id: UUID)
}

final class MainViewController: UIViewController {
    
    var notesArray: [NoteApp] = []
    
    fileprivate var mainView: MainView {return self.view as! MainView}
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        self.view = MainView(frame: UIScreen.main.bounds)
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.setRightBarButton(item, animated: false)
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Заметки"
        navigationController?.navigationBar.prefersLargeTitles = true
        mainView.notesTableView.delegate = self
        mainView.notesTableView.dataSource = self
        mainView.notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifire)
        mainView.notesTableView.rowHeight = UITableView.automaticDimension
        mainView.notesTableView.estimatedRowHeight = 60
        fetchNoteFromStorage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        mainView.configure(count: notesArray.count)
    }
    
    //MARK: - Private
    private func indexForNote(id: UUID, in list: [NoteApp]) -> IndexPath {
        let row = Int (list.firstIndex(where: { $0.id == id }) ?? 0 )
        return IndexPath(row: row, section: 0)
    }
    
    private func fetchNoteFromStorage() {
        notesArray = CoreDataManager.shared.receiveNotes()
    }
    
    //MARK: - Actions
    @objc
    private func addNote() {
        let notesVC = NotesViewController()
        notesVC.onFinish = {[weak self] text in
            guard let self = self else {return}
            self.navigationController?.popToRootViewController(animated: true)
            self.notesArray.insert(text, at: 0)
            self.mainView.notesTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)

            self.mainView.notesTableView.reloadData()
        }
        navigationController?.pushViewController(notesVC, animated: true)
    }
    
    private func editNote (note: NoteApp) {
        let notesVC = NotesViewController()
        notesVC.note = note
        notesVC.delegate = self
        navigationController?.pushViewController(notesVC, animated: true)
    }
    
    private func deleteNote(index: Int) {
        CoreDataManager.shared.deleteNote(note: notesArray[index])
        notesArray.remove(at: index)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesTableViewCell.identifire, for: indexPath) as! NotesTableViewCell
        
        let note = notesArray[indexPath.row]
        cell.configureCell(data: note)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editNote(note: notesArray[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            deleteNote(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            mainView.configure(count: notesArray.count)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension MainViewController: NoteDelegate {
    
    func deleteNote(id: UUID) {
        let index = indexForNote(id: id, in: notesArray)
        notesArray.remove(at: index.row)
        mainView.notesTableView.deleteRows(at: [index], with: .automatic)
    }

    func updateNote(text: String, id: UUID) {
        let index = indexForNote(id: id, in: notesArray)
        notesArray[index.row].text = text
        mainView.notesTableView.reloadData()
    }
}
