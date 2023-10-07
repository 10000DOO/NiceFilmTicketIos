//
//  issueNft.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 2023/10/05.
//

import Foundation
import Moya

enum issueNftAPI {
    case issueNft(issueNFTReq: IssueNFTReq, countNFTReq: CountNFTReq, poster: [String: Foundation.Data], normal: [String: Foundation.Data], rare: [String: Foundation.Data], legend: [String: Foundation.Data])
}

extension issueNftAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .issueNft:
            return "/nft/save"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .issueNft:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .issueNft(let issueNFTReq, let countNFTReq, let poster, let normal, let rare, let legend):
            var multipartFormData = [MultipartFormData]()
            
            let jsonData = try! JSONEncoder().encode(issueNFTReq)
            multipartFormData.append(MultipartFormData(provider: .data(jsonData), name: "issueNFTReq", mimeType: "application/json"))
            
            let countNFTReqData = try! JSONEncoder().encode(countNFTReq)
            multipartFormData.append(MultipartFormData(provider: .data(countNFTReqData), name: "countNFTReq", mimeType: "application/json"))

            if poster.keys.contains("png") {
                multipartFormData.append(MultipartFormData(provider: .data(poster["png"]!), name: "poster", fileName: "poster.png", mimeType: "image/png"))
            } else if poster.keys.contains("jpeg") {
                multipartFormData.append(MultipartFormData(provider: .data(poster["jpeg"]!), name: "poster", fileName: "poster.jpeg", mimeType: "image/jpeg"))
            } else if poster.keys.contains("JPG") {
                multipartFormData.append(MultipartFormData(provider: .data(poster["JPG"]!), name: "poster", fileName: "poster.JPG", mimeType: "image/jpeg"))
            }
            
            if normal.keys.contains("png") {
                multipartFormData.append(MultipartFormData(provider: .data(normal["png"]!), name: "normal", fileName: "normal.png", mimeType: "image/png"))
            } else if normal.keys.contains("jpeg") {
                multipartFormData.append(MultipartFormData(provider: .data(normal["jpeg"]!), name: "normal", fileName: "normal.jpeg", mimeType: "image/jpeg"))
            } else if normal.keys.contains("JPG") {
                multipartFormData.append(MultipartFormData(provider: .data(normal["JPG"]!), name: "normal", fileName: "normal.JPG", mimeType: "image/jpeg"))
            }
            
            if rare.keys.contains("png") {
                multipartFormData.append(MultipartFormData(provider: .data(rare["png"]!), name: "rare", fileName: "rare.png", mimeType: "image/png"))
            } else if rare.keys.contains("jpeg") {
                multipartFormData.append(MultipartFormData(provider: .data(rare["jpeg"]!), name: "rare", fileName: "rare.jpeg", mimeType: "image/jpeg"))
            } else if rare.keys.contains("JPG") {
                multipartFormData.append(MultipartFormData(provider: .data(rare["JPG"]!), name: "rare", fileName: "rare.JPG", mimeType: "image/jpeg"))
            }
            
            if legend.keys.contains("png") {
                multipartFormData.append(MultipartFormData(provider: .data(legend["png"]!), name: "legend", fileName: "legend.png", mimeType: "image/png"))
            } else if legend.keys.contains("jpeg") {
                multipartFormData.append(MultipartFormData(provider: .data(legend["jpeg"]!), name: "legend", fileName: "legend.jpeg", mimeType: "image/jpeg"))
            } else if legend.keys.contains("JPG") {
                multipartFormData.append(MultipartFormData(provider: .data(legend["JPG"]!), name: "legend", fileName: "legend.JPG", mimeType: "image/jpeg"))
            }
            return .uploadMultipart(multipartFormData)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "multipart/form-data", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
