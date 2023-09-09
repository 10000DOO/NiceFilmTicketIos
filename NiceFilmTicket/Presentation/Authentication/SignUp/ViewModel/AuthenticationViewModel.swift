//
//  AuthenticationViewModel.swift
//  NiceFilmTicket
//
//  Created by 10000DOO on 2023/09/08.
//

import Foundation
import Combine

class AuthenticationViewModel: ObservableObject {
    
    @Published var loginId = ""
    @Published var password = ""
}
