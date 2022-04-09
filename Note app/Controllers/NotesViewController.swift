//
//  NotesViewController.swift
//  Note app
//
//  Created by APPLE on 23.03.2022.
//

import UIKit

final class NotesViewController: UIViewController {
    
    fileprivate var notesView: NotesView {return self.view as! NotesView}
    var onFinish: ((NoteApp)->())?
    var note: NoteApp!
    var delegate: NoteDelegate?
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = NotesView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesView.textNote.delegate = self
        notesView.textNote.text = note?.text
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        notesView.textNote.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Action
    
    func saveNewButtonAction() {
        guard let text = notesView.textNote.text else { return }
        
        if !text.isEmpty {
            let note = NoteApp(context: CoreDataManager.shared.viewContext)
            note.id = UUID()
            note.text = text
            CoreDataManager.shared.save()
            onFinish?(note)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateNote(text: String) {
        CoreDataManager.shared.save()
        delegate?.updateNote(text: text, id: note.id)
    }
    
    func deleteNote() {
        delegate?.deleteNote(id: note.id)
    }
}

extension NotesViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if  note?.text.isEmpty ?? true{
            saveNewButtonAction()
            deleteNote()
        } else {
            updateNote(text: note.text)
        }
    }
}


    

