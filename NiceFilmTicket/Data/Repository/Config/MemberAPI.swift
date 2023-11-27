//
//  MemberAPI.swift
//  NiceFilmTicket
//
//  Created by 이건준 on 11/27/23.
//

import Foundation
import Foundation
import Moya

enum MemberAPI{
    case signIn(signInReq: SignInReq, memberType: String)
    case loginIdDuplicateTest(loginId: String)
    case emailDuplicateTest(email: String)
    case nickNameDuplicateTest(nickName: String)
    case signUpReq(signUpReq: SignUpReq, emailCode: String, memberType: String)
    case findId(emailCode: String)
    case findPw(newPwDto: NewPwDto)
}

extension MemberAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerInfo.serverURL)!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/signin"
        case .loginIdDuplicateTest:
            return "/member/check/loginid"
        case .emailDuplicateTest:
            return "/member/check/email"
        case .nickNameDuplicateTest:
            return "/member/check/username"
        case .signUpReq:
            return "/signup"
        case .findId:
            return "/find/id"
        case .findPw:
            return "/find/pw"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn:
            return .post
        case .loginIdDuplicateTest:
            return .get
        case .emailDuplicateTest:
            return .get
        case .nickNameDuplicateTest:
            return .get
        case .signUpReq:
            return .post
        case .findId:
            return .get
        case .findPw:
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let signInReq, let memberType):
            let encoded = try! JSONEncoder().encode(signInReq)
            return .requestCompositeData(bodyData: encoded, urlParameters: ["role": memberType])
        case .loginIdDuplicateTest(let loginId):
            return .requestParameters(parameters: ["loginid": loginId], encoding: URLEncoding.queryString)
        case .emailDuplicateTest(let email):
            return .requestParameters(parameters: ["email": email], encoding: URLEncoding.queryString)
        case .nickNameDuplicateTest(let nickName):
            return .requestParameters(parameters: ["username": nickName], encoding: URLEncoding.queryString)
        case .signUpReq(let signUpReq, let emailCode, let memberType):
            let encoded = try! JSONEncoder().encode(signUpReq)
            return .requestCompositeData(bodyData: encoded, urlParameters: ["code": emailCode, "role": memberType])
        case .findId(let emailCode):
            return .requestParameters(parameters: ["code": emailCode], encoding: URLEncoding.queryString)
        case .findPw(let newPwDto):
            return .requestJSONEncodable(newPwDto)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signIn, .emailDuplicateTest, .loginIdDuplicateTest, .nickNameDuplicateTest, .signUpReq, .findId, .findPw:
            return ["Content-Type": "application/json"]
        }
    }
}
