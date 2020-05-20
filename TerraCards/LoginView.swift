//
//  LoginView.swift
//  TerraCards
//
//  Created by foxy on 14/05/2020.
//  Copyright © 2020 MacBookGP. All rights reserved.
//

import SwiftUI

enum LoginError: String, Error {
    case loginTooShort, passwordTooShort, controlFailed
    var message: String {
        switch self {
        case .loginTooShort: return "Votre login est trop court"
        case .passwordTooShort: return "Votre mot de passe est trop court"
        case .controlFailed: return "Erreur dans la confirmation du mot de passe"
        }
    }
}

struct LoginView: View {
    @State var login = ""
    @State var password = ""
    @State var control = ""
    @State var loginFailed: Bool?
    @State var errorMessage = ""
    
    func handleLoginRequest() {
        loginFailed = false
        do {
            try checkLoginError()
        }
        catch {
            if let errorLog = error as? LoginError {
                print(errorLog.rawValue)
                errorMessage = errorLog.message
            } else {
                print("erreur inconnue")
                errorMessage = "il y a eu une erreur"
            }
            loginFailed = true
        }
    }
    
    func checkLoginError() throws {
        if login.count < 6 {
            throw LoginError.loginTooShort
        } else if password.count < 6 {
            throw LoginError.passwordTooShort
        } else if password != control {
            throw LoginError.controlFailed
        }
    }
    
    var body: some View {
        VStack {
            Text("Inscription").font(.largeTitle)
            TextField("Login", text: $login)
                .padding()
            TextField("Password", text: $password)
                .padding()
            TextField("Password control", text: $control)
            .padding()
            if loginFailed != nil {
                if loginFailed! {
                    Text(errorMessage)
                } else {
                    Text("Entrez s'il vous plait !")
                }
            }
            Button(action: {
                self.handleLoginRequest()
            }, label: {
                Capsule()
                    .frame(width: 100, height: 50)
                    .overlay(Text("Valider").foregroundColor(Color.white))
            })
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
