//
//  UIImageViewExtension.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 1/16/24.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    private struct AssociatedKeys {
        static var imageURLKey = "imageURLKey"
    }

    private var imageURL: URL? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.imageURLKey) as? URL }
        set { objc_setAssociatedObject(self, &AssociatedKeys.imageURLKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }

    func configureImage(url: URL) {
        imageURL = url

        let request = AF.request(url, method: .get)

        request.responseData { [weak self] response in
            guard let strongSelf = self else { return }
            
            if url == strongSelf.imageURL {
                switch response.result {
                case .success(let imageData):
                    DispatchQueue.main.async {
                        guard let image = UIImage(data: imageData) else { return }
                        strongSelf.image = image
                    }
                case .failure(let error):
                    break
                }
            }
        }
    }
}

