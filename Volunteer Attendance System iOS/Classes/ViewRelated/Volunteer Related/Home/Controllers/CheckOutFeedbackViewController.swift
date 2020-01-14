//
//  CheckOutFeedbackViewController.swift
//  Volunteer Attendance System iOS
//
//  Created by Cassandra Zuria on 11/17/19.
//  Copyright © 2019 Cassandra Zuria. All rights reserved.
//

import UIKit
import TinyConstraints

class CheckOutFeedbackViewController: UIViewController {
    // MARK: - Properties
    lazy var feedbackTextView: UITextView = {
        let feedbackTextView = UITextView()
        feedbackTextView.translatesAutoresizingMaskIntoConstraints = false
        feedbackTextView.becomeFirstResponder()
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        feedbackTextView.font = .preferredFont(forTextStyle: .body)
        feedbackTextView.delegate = self
        return feedbackTextView
    }()
    
    lazy var doneBarButtonItem: UIBarButtonItem = {
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDismiss(_:)))
        return doneBarButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: - View Configurations
extension CheckOutFeedbackViewController {
    private func setupView() {
        view.addSubview(feedbackTextView)
        configureConstraints()
        configureNavBar()
    }
    
    private func configureConstraints() {
        feedbackTextView.edgesToSuperview()
    }
    
    private func configureNavBar() {
        title = "How did your session go?"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.setRightBarButton(doneBarButtonItem, animated: true)
    }
}

// MARK: - View Dismissmal Configurations
extension CheckOutFeedbackViewController {
    @objc private func handleDismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Text View Delegate
extension CheckOutFeedbackViewController: UITextViewDelegate {
    private func handleValidEntry() -> Int {
        let words = feedbackTextView.text.components(separatedBy: .whitespacesAndNewlines)
        let filteredWords = words.filter({ (word) -> Bool in
            word != ""
        })
        return filteredWords.count
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write what you accomplished today in your session"
            textView.textColor = UIColor.lightGray
        }
    }
}
