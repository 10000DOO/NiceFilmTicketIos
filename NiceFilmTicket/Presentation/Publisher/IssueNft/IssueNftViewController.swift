//
//  IssueNftViewController.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/09/27.
//

import UIKit
import SnapKit

class IssueNftViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
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
    @IBOutlet weak var posterImageLabel: UILabel!
    @IBOutlet weak var nftImageLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var normalNftImageView: UIImageView!
    @IBOutlet weak var posterDefaultImageView: UIImageView!
    @IBOutlet weak var normalNftDefaultImageView: UIImageView!
    @IBOutlet weak var normalLabel: UILabel!
    @IBOutlet weak var normalNftCountTextField: UITextField!
    @IBOutlet weak var rareNftImageView: UIImageView!
    @IBOutlet weak var rareNftDefaultImageView: UIImageView!
    @IBOutlet weak var legendNftImageView: UIImageView!
    @IBOutlet weak var legendNftDefaultImageView: UIImageView!
    @IBOutlet weak var rareLabel: UILabel!
    @IBOutlet weak var rareNftCountTextField: UITextField!
    @IBOutlet weak var legendLabel: UILabel!
    @IBOutlet weak var legendNftCountTextField: UITextField!
    @IBOutlet weak var previewButton: UIButton!
    @IBOutlet weak var nftIssueButton: UIButton!
    let storyLineTextViewPlaceHolder = " 줄거리를 입력해주세요."
    let picker = UIImagePickerController()
    
    private let issueNftViewModel = IssueNftViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        hideKeyboardWhenTappedAround()
        scrollView.delegate = self
        scrollProgressView.progress = 0.0
        
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        
        posterImageView.isUserInteractionEnabled = true
        posterDefaultImageView.isUserInteractionEnabled = true

        normalNftImageView.isUserInteractionEnabled = true
        normalNftDefaultImageView.isUserInteractionEnabled = true

        rareNftImageView.isUserInteractionEnabled = true
        rareNftDefaultImageView.isUserInteractionEnabled = true

        legendNftImageView.isUserInteractionEnabled = true
        legendNftDefaultImageView.isUserInteractionEnabled = true
        
        let selectPosterImage = UITapGestureRecognizer(target: self, action: #selector(selectPosterImage))
        posterImageView.addGestureRecognizer(selectPosterImage)
        posterDefaultImageView.addGestureRecognizer(selectPosterImage)
        
        let selectNormalImage = UITapGestureRecognizer(target: self, action: #selector(selectNormalImage))
        normalNftImageView.addGestureRecognizer(selectNormalImage)
        normalNftDefaultImageView.addGestureRecognizer(selectNormalImage)
        
        let selectRareImage = UITapGestureRecognizer(target: self, action: #selector(selectRareImage))
        rareNftImageView.addGestureRecognizer(selectRareImage)
        rareNftDefaultImageView.addGestureRecognizer(selectRareImage)
        
        let selectLegendImage = UITapGestureRecognizer(target: self, action: #selector(selectLegendImage))
        legendNftImageView.addGestureRecognizer(selectLegendImage)
        legendNftDefaultImageView.addGestureRecognizer(selectLegendImage)
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
        setPosterImageView()
        setNormalNftImageView()
        setNormalNftCountTextField()
        setRareNftImageView()
        setLegendNftImageView()
        setRareNftCountTextField()
        setLegendNftCountTextField()
        setPreviewButton()
        setNftIssueButton()
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
    
    func setPosterImageView() {
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setNormalNftImageView() {
        normalNftImageView.layer.borderWidth = 2
        normalNftImageView.layer.cornerRadius = 10
        normalNftImageView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setNormalNftCountTextField() {
        normalNftCountTextField.keyboardType = .numberPad
    }
    
    func setRareNftImageView() {
        rareNftImageView.layer.borderWidth = 2
        rareNftImageView.layer.cornerRadius = 10
        rareNftImageView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setLegendNftImageView() {
        legendNftImageView.layer.borderWidth = 2
        legendNftImageView.layer.cornerRadius = 10
        legendNftImageView.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setRareNftCountTextField() {
        rareNftCountTextField.keyboardType = .numberPad
    }
    
    func setLegendNftCountTextField() {
        legendNftCountTextField.keyboardType = .numberPad
    }
    
    func setPreviewButton() {
        previewButton.layer.borderWidth = 2
        previewButton.layer.cornerRadius = 10
        previewButton.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    func setNftIssueButton() {
        nftIssueButton.layer.borderWidth = 2
        nftIssueButton.layer.cornerRadius = 10
        nftIssueButton.layer.borderColor = UIColor(red: 8/255, green: 30/255, blue: 92/255, alpha: 1).cgColor
    }
    
    @objc func selectPosterImage() {
        issueNftViewModel.reversePosterImageIsSelected()
        self.present(picker, animated: true, completion: nil)
    }
    @objc func selectNormalImage() {
        issueNftViewModel.reverseNormalImageIsSelected()
        self.present(picker, animated: true, completion: nil)
    }
    @objc func selectRareImage() {
        issueNftViewModel.reverseRareImageIsSelected()
        self.present(picker, animated: true, completion: nil)
    }
    @objc func selectLegendImage() {
        issueNftViewModel.reverseLegendImageIsSelected()
        self.present(picker, animated: true, completion: nil)
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

extension IssueNftViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var targetImageView = 0
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.dismiss(animated: false, completion: { [weak self] in
                if (self?.issueNftViewModel.posterImageIsSelected == true) {
                    targetImageView = 0
                    self?.issueNftViewModel.reversePosterImageIsSelected()
                }
                if (self?.issueNftViewModel.normalImageIsSelected == true) {
                    targetImageView = 1
                    self?.issueNftViewModel.reverseNormalImageIsSelected()
                }
                if (self?.issueNftViewModel.rareImageIsSelected == true) {
                    targetImageView = 2
                    self?.issueNftViewModel.reverseRareImageIsSelected()
                }
                if (self?.issueNftViewModel.legendImageIsSelected == true) {
                    targetImageView = 3
                    self?.issueNftViewModel.reverseLegendImageIsSelected()
                }
                DispatchQueue.main.async {
                    switch targetImageView {
                    case 0: self?.posterImageView.image = image
                        self?.posterDefaultImageView.isHidden = true
                    case 1: self?.normalNftImageView.image = image
                        self?.normalNftDefaultImageView.isHidden = true
                    case 2: self?.rareNftImageView.image = image
                        self?.rareNftDefaultImageView.isHidden = true
                    case 3: self?.legendNftImageView.image = image
                        self?.legendNftDefaultImageView.isHidden = true
                    default:
                        return
                    }
                }
            })
        }
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
