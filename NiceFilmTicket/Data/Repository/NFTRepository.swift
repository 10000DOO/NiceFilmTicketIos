//
//  NFTRepository.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Alamofire
import Combine

class NFTRepository: NFTRepositoryProtocol {
    func registerNft(issueNFTReq: IssueNFTReq, countNFTReq: CountNFTReq, poster: [String: Foundation.Data], normal: [String: Foundation.Data], rare: [String: Foundation.Data], legend: [String: Foundation.Data]) -> AnyPublisher<CommonSuccessRes, ErrorResponse> {
        return Future<CommonSuccessRes, ErrorResponse> { promise in
            AF.upload(
                multipartFormData: { multipartFormData in
                    do {
                        let issueNFTReq = try JSONEncoder().encode(issueNFTReq)
                        multipartFormData.append(Foundation.Data(issueNFTReq), withName: "issueNFTReq", mimeType: "application/json")
                        
                        let countNFTReqData = try JSONEncoder().encode(issueNFTReq)
                        multipartFormData.append(Foundation.Data(countNFTReqData), withName: "countNFTReq", mimeType: "application/json")
                        
                        if poster.keys.contains("png") {
                            multipartFormData.append(poster["png"]!, withName: "poster", fileName: "poster.png", mimeType: "image/png")
                        } else if poster.keys.contains("jpeg") {
                            multipartFormData.append(poster["jpeg"]!, withName: "poster", fileName: "poster.jpeg", mimeType: "image/jpeg")
                        } else if poster.keys.contains("JPG") {
                            multipartFormData.append(poster["JPG"]!, withName: "poster", fileName: "poster.JPG", mimeType: "image/jpeg")
                        }
                        
                        if normal.keys.contains("png") {
                            multipartFormData.append(normal["png"]!, withName: "normal", fileName: "normal.png", mimeType: "image/png")
                        } else if normal.keys.contains("jpeg") {
                            multipartFormData.append(normal["jpeg"]!, withName: "normal", fileName: "normal.jpeg", mimeType: "image/jpeg")
                        } else if normal.keys.contains("JPG") {
                            multipartFormData.append(normal["JPG"]!, withName: "normal", fileName: "normal.JPG", mimeType: "image/jpeg")
                        }
                        
                        if rare.keys.contains("png") {
                            multipartFormData.append(rare["png"]!, withName: "rare", fileName: "rare.png", mimeType: "image/png")
                        } else if rare.keys.contains("jpeg") {
                            multipartFormData.append(rare["jpeg"]!, withName: "rare", fileName: "rare.jpeg", mimeType: "image/jpeg")
                        } else if rare.keys.contains("JPG") {
                            multipartFormData.append(rare["JPG"]!, withName: "rare", fileName: "rare.JPG", mimeType: "image/jpeg")
                        }
                        
                        if legend.keys.contains("png") {
                            multipartFormData.append(legend["png"]!, withName: "legend", fileName: "legend.png", mimeType: "image/png")
                        } else if legend.keys.contains("jpeg") {
                            multipartFormData.append(legend["jpeg"]!, withName: "legend", fileName: "legend.jpeg", mimeType: "image/jpeg")
                        } else if legend.keys.contains("JPG") {
                            multipartFormData.append(legend["JPG"]!, withName: "legend", fileName: "legend.JPG", mimeType: "image/jpeg")
                        }
                    } catch {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        promise(.failure(defaultError))
                        return
                    }
                },
                to: ServerInfo.serverURL + "/nft/save",
                method: .post,
                headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let addDiarySuccess = try JSONDecoder().decode(CommonSuccessRes.self, from: data)
                        promise(.success(addDiarySuccess))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func drawNft(drawNftReq: DrawNftReq) -> AnyPublisher<DrawNftRes, ErrorResponse> {
        return Future<DrawNftRes, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/nft/pick",
                       method: .post,
                       parameters: drawNftReq,
                       encoder: JSONParameterEncoder.default,
                       headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let drawNftResponse = try JSONDecoder().decode(DrawNftRes.self, from: data)
                        promise(.success(drawNftResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getMyNft(username: String, page: Int, size: Int) -> AnyPublisher<NFTData, ErrorResponse> {
        return Future<NFTData, ErrorResponse> { promise in
            AF.request(ServerInfo.serverURL + "/nft/pick/list",
                       method: .get,
                       parameters: ["username": username, "page": String(page), "size": String(size)],
                       encoder: URLEncodedFormParameterEncoder.default,
                       headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let getMyNftResponse = try JSONDecoder().decode(NFTData.self, from: data)
                        promise(.success(getMyNftResponse))
                    } catch {
                        if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                            promise(.failure(errorResponse))
                        } else {
                            let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                            promise(.failure(defaultError))
                        }
                    }
                case .failure(let error):
                    let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                    promise(.failure(customError))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getNfts(username: String, page: Int, size: Int, completion: @escaping (Result<NFTList, ErrorResponse>) -> Void) {
        AF.request(ServerInfo.serverURL + "/nft",
                   method: .get,
                   parameters: ["sortType": "최신순", "username": username, "page": String(page), "size": String(size)],
                   encoder: URLEncodedFormParameterEncoder.default,
                   headers: ["Content-Type": "application/json", "Authorization" : UserDefaults.standard.string(forKey: "accessToken")!])
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let getNftsResponse = try JSONDecoder().decode(NFTList.self, from: data)
                    completion(.success(getNftsResponse))
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(errorResponse))
                    } else {
                        let defaultError = ErrorResponse(status: 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                        completion(.failure(defaultError))
                    }
                }
            case .failure(let error):
                let customError = ErrorResponse(status: error.responseCode ?? 500, error: [ErrorDetail(error: ErrorMessage.serverError.rawValue)])
                completion(.failure(customError))
            }
        }
    }
}
