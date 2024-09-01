//
//  PinCodeView.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 08/08/2024.
//

import SwiftUI

class PinCodeViewManager: ObservableObject {
    @Published var content: (any ActionableView)?
}

struct PinCodeView: ViewWithTransition {
    let transitionAnimation: Bool
    @EnvironmentObject var manager: PersistenceController
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var profiles: FetchedResults<Profile>
    @EnvironmentObject var router: Router
    
    let phone: String
    let verificationID: String
    @State private var buttonConfig: TButtonConfig = .defulat(state: .disabled,
                                                              dimantions: .full)
    
    private let pManager = PinCodeViewManager()
    @State private var loading = false
    
    var body: some View {
        OnboaredingBaseView(buttonConfig: $buttonConfig,
                            loading: $loading,
                            buttonText: "אישור".localized(),
                            contant: smsPinCodeView()) {
            loading = true
            
            pManager.content?.preformAction(manager: manager,
                                            profile: nil) { value in loading = false }
        }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                hideKeyboard()
                            }
        
    }
    
    @ViewBuilder private func smsPinCodeView() -> some View {
        SmsPinCodeView(phone: phone,
                       verificationID: verificationID) { view in
            pManager.content = view
        } didDone: { value in
            setButtonConfig(isDone: value)
        } didApprove: { id, name, email, didLogin in
            didApprove(id, name, email, didLogin)
        }
    }
    
    private func didApprove(_ id: String, _ name: String, _ email: String, _ didLogin:  @escaping (_ profile: Profile,  _ uploadSuccess: @escaping (Bool) -> ()) -> ()) {
        LoginHendeler(router: router,
                      manager: manager,
                      profile:  profiles.last)
        .preform(id: id,
                 name: name,
                 email: email,
                 birthdate: "",
                 gender: "") { value in
            guard let profile = profiles.last else { return loading = false }
            didLogin(profile) { didUploadSucceed in
                guard didUploadSucceed else {
                    manager.delete(profile: profile)
                    return router.popToRoot()
                }
            }
        }
    }
    
    private func setButtonConfig(isDone: Bool) {
        withAnimation(.smooth) {
            buttonConfig = .defulat(state: isDone ? .enabled : .disabled,
                                    dimantions: .full)
        }
    }
}
//
//#Preview {
//    PinCodeView(phone: "",
//                verificationID: "",
//                buttonConfig: .constant(.defulat(state: .disabled, dimantions: .full))) { _ in
//
//    } didApprove: { _, _, _ in
//
//    }
//}
