//
//  NftAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Moya

enum NftAPI {
    case getMyNft(username: String, page: Int, size: Int)
    case drawNft(drawNftReq: DrawNftReq)
    case getNfts(username: String, page: Int, size: Int)
    case issueNft(issueNFTReq: IssueNFTReq, countNFTReq: CountNFTReq, poster: [String: Foundation.Data], normal: [String: Foundation.Data], rare: [String: Foundation.Data], legend: [String: Foundation.Data])
}

extension NftAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .getMyNft:
            return "/nft/pick/list"
        case .drawNft:
            return "/nft/pick"
        case .getNfts:
            return "/nft"
        case .issueNft:
            return "/nft/save"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMyNft:
            return .get
        case .drawNft:
            return .post
        case .getNfts:
            return .get
        case .issueNft:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getMyNft(let username, let page, let size):
            return .requestParameters(parameters: ["username": username, "page": page, "size": size], encoding: URLEncoding.queryString)
        case .drawNft(let drawNftReq):
            return .requestJSONEncodable(drawNftReq)
        case .getNfts(let username, let page, let size):
            return .requestParameters(parameters: ["sortType": "최신순", "username": username, "page": page, "size": size], encoding: URLEncoding.queryString)
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
        return ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!]
    }
}
