//
//  LoginManager.swift
//  TaxiShare_MVP
//
//  Created by Barak Ben Hur on 01/09/2024.
//

import Foundation

struct LoginHendeler {
    private let vm = OnboardringViewModel()
    let router: Router
    let manager: PersistenceController
    let profile: Profile?
    
    func preform(id: String?, name: String, email: String, brithdate: String, gender: String) {
        guard let id, !id.isEmpty else {
            return router.navigateTo(.login,
                                     animate: false)
        }
        
        vm.getUser(id: id) { result in
            if let profile, !result.exist {
                manager.delete(profile: profile)
                return router.navigateTo(.login,
                                         animate: false)
            }
            
            vm.login(id: id) { user in
                guard !user.isNew || (user.isNew && profile == nil) else {
                    return router.navigateTo(.login,
                                             animate: false)
                }
                
                let newProfile = {
                    if let profile {
                        return manager.replace(profile: profile,
                                               with: user.id)
                    }
                    else {
                        return manager.new(id: user.id)
                    }
                }()
                
                var screens: [OnboardingProgressbale] = []
                
                if user.name.isEmpty {
                    screens.append(.name(value: name))
                }
                else {
                    manager.set(profile: newProfile,
                                name: user.name)
                }
                if user.birthdate.isEmpty {
                    screens.append(.birthdate(value: brithdate))
                }
                else {
                    manager.set(profile: newProfile,
                                date: user.birthdate)
                }
                if user.gender.isEmpty {
                    let gender = !gender.isEmpty ? Int(gender) ?? nil : nil
                    screens.append(.gender(value: gender))
                }
                else {
                    manager.set(profile: newProfile,
                                gender: Int(user.gender)!)
                }
                if !user.rules {
                    screens.append(.rules)
                }
                else {
                    manager.set(profile: newProfile,
                                rules: user.rules)
                }
                
                if !user.phone.isEmpty {
                    manager.set(profile: newProfile,
                                phone: user.phone)
                }
                
                if user.email.isEmpty, !email.isEmpty {
                    vm.upload(id: user.id,
                              email: email) { _ in
                        manager.set(profile: newProfile,
                                    email: email)
                    } error: { error in print(error) }
                }
                
                if screens.isEmpty {
                    return router.navigateTo(.map,
                                             animate: profile == nil)
                }
                else {
                    return router.navigateTo(.onboarding(screens: screens),
                                             animate: profile == nil)
                }
            } error: { error in print(error) }
        } error: { error in print(error) }
    }
}
