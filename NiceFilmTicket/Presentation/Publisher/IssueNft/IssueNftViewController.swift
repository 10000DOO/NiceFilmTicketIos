//
//  IssueNftViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/09/27.
//

import UIKit

class IssueNftViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollProgressView: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var ageLimitTextField: UITextField!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var directorTextField: UITextField!
    @IBOutlet weak var actorsTextField: UITextField!
    @IBOutlet weak var runningTimeTextField: UITextField!
    @IBOutlet weak var normalPriceTextField: UITextField!
    @IBOutlet weak var saleStartTextField: UITextField!
    @IBOutlet weak var saleEndDateTextField: UITextField!
    @IBOutlet weak var storyLineTextView: UITextView!
    
    let storyLineTextViewPlaceHolder = " 줄거리를 입력해주세요."
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        hideKeyboardWhenTappedAround()
        scrollView.delegate = self
        scrollProgressView.progress = 0.0
    }
}

extension IssueNftViewController {
    func setView() {
        setTitleLabel()
        setMovieTitleTextField()
        setGenreTextField()
        setAgeLimitTextField()
        setReleaseDateTextField()
        setDirectorTextField()
        setActorsTextField()
        setRunningTimeTextField()
        setNormalPriceTextField()
        setSaleStartTextField()
        setSaleEndTextField()
        setStoryLineTextView()
    }
    
    func setTitleLabel() {
        titleLabel.textColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40)
    }
    
    func setMovieTitleTextField() {
        movieTitleTextField.layer.cornerRadius = 10
        movieTitleTextField.layer.borderWidth = 2
        movieTitleTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setGenreTextField() {
        genreTextField.layer.cornerRadius = 10
        genreTextField.layer.borderWidth = 2
        genreTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setAgeLimitTextField() {
        ageLimitTextField.layer.cornerRadius = 10
        ageLimitTextField.layer.borderWidth = 2
        ageLimitTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setReleaseDateTextField() {
        releaseDateTextField.layer.cornerRadius = 10
        releaseDateTextField.layer.borderWidth = 2
        releaseDateTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setDirectorTextField() {
        directorTextField.layer.cornerRadius = 10
        directorTextField.layer.borderWidth = 2
        directorTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setActorsTextField() {
        actorsTextField.layer.cornerRadius = 10
        actorsTextField.layer.borderWidth = 2
        actorsTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setRunningTimeTextField() {
        runningTimeTextField.layer.cornerRadius = 10
        runningTimeTextField.layer.borderWidth = 2
        runningTimeTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        
        runningTimeTextField.keyboardType = .numberPad
    }
    
    func setNormalPriceTextField() {
        normalPriceTextField.layer.cornerRadius = 10
        normalPriceTextField.layer.borderWidth = 2
        normalPriceTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        
        runningTimeTextField.keyboardType = .numberPad
    }
    
    func setSaleStartTextField() {
        saleStartTextField.layer.cornerRadius = 10
        saleStartTextField.layer.borderWidth = 2
        saleStartTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setSaleEndTextField() {
        saleEndDateTextField.layer.cornerRadius = 10
        saleEndDateTextField.layer.borderWidth = 2
        saleEndDateTextField.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setStoryLineTextView() {
        storyLineTextView.layer.cornerRadius = 10
        storyLineTextView.layer.borderWidth = 2
        storyLineTextView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
        storyLineTextView.text = storyLineTextViewPlaceHolder
        storyLineTextView.textColor = .lightGray
        storyLineTextView.font = UIFont.systemFont(ofSize: 20)
        storyLineTextView.delegate = self
    }
}

extension IssueNftViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        releaseDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func doneButtonTapped() {
        // 완료 버튼을 눌렀을 때 수행할 작업 추가
        releaseDateTextField.resignFirstResponder() // DatePicker 닫기
    }
}

extension IssueNftViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 위치를 감지하고 프로그레스 바를 업데이트합니다.
        let yOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let progressBarHeight = scrollView.frame.size.height
        
        // 스크롤 위치를 0.0에서 1.0 사이의 값으로 변환하여 프로그레스 바에 설정합니다.
        let progress = min(max(yOffset / (contentHeight - progressBarHeight), 0.0), 1.0)
        scrollProgressView.progress = Float(progress)
    }
}

extension IssueNftViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if storyLineTextView.text == storyLineTextViewPlaceHolder {
            storyLineTextView.text = nil
            storyLineTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if storyLineTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            storyLineTextView.text = storyLineTextViewPlaceHolder
            storyLineTextView.textColor = .lightGray
        }
    }
}
