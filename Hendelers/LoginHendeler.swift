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
    
    private func syncedLocalProfile(profile: Profile?, id: String) -> Profile {
        if let profile {
            return manager.replace(profile: profile,
                                   with: id)
        }
        else {
            return manager.new(id: id)
        }
    }
    
    private func onboardingScreens(user: ProfileModel, syncedProfile: Profile, email: String, name: String, birthdate: String, gender: String) -> [OnboardingProgressbale] {
        var screens: [OnboardingProgressbale] = []
        
        if user.name.isEmpty {
            screens.append(.name(value: name))
        }
        else {
            manager.set(profile: syncedProfile,
                        name: user.name)
        }
        
        if user.birthdate.isEmpty {
            screens.append(.birthdate(value: birthdate))
        }
        else {
            manager.set(profile: syncedProfile,
                        date: user.birthdate)
        }
        
        if user.gender.isEmpty {
            let gender = !gender.isEmpty ? Int(gender) ?? nil : nil
            screens.append(.gender(value: gender))
        }
        else {
            manager.set(profile: syncedProfile,
                        gender: Int(user.gender)!)
        }
        
        if !user.rules {
            screens.append(.rules)
        }
        else {
            manager.set(profile: syncedProfile,
                        rules: user.rules)
        }
        
        if !user.phone.isEmpty {
            manager.set(profile: syncedProfile,
                        phone: user.phone)
        }
        
        if user.email.isEmpty, !email.isEmpty && email.isValidEmail() {
            vm.upload(id: user.id,
                      email: email) { _ in
                manager.set(profile: syncedProfile,
                            email: email)
            } error: { error in print(error) }
        }
        
        return screens
    }
    
    func preform(id: String?, name: String, email: String, birthdate: String, gender: String, didLogin: @escaping (Bool) -> () = { _ in }) {
        guard let id, !id.isEmpty else {
            if let profile { manager.delete(profile: profile) }
            didLogin(false)
            return router.navigateTo(.login,
                                     animate: false)
        }
        
        vm.getUser(id: id) { result in
            let serverProfileExist = result.exist
            
            if let profile, !serverProfileExist {
                manager.delete(profile: profile)
                didLogin(false)
                return router.navigateTo(.login,
                                         animate: false)
            }
            
            vm.login(id: id) { user in
                let localProfileExist = profile != nil
                let syncLocal = serverProfileExist || (!serverProfileExist && !localProfileExist)
                
                guard syncLocal else {
                    didLogin(false)
                    return router.navigateTo(.login,
                                             animate: false)
                }
                
                let syncedLocalProfile = syncedLocalProfile(profile: profile, id: id)
                
                let onboardingScreens = onboardingScreens(user: user,
                                                          syncedProfile: syncedLocalProfile,
                                                          email: email,
                                                          name: name,
                                                          birthdate: birthdate,
                                                          gender: gender)
                
                didLogin(true)
                
                if onboardingScreens.isEmpty {
                    return router.navigateTo(.map,
                                             animate: !localProfileExist)
                }
                else {
                    return router.navigateTo(.onboarding(screens: onboardingScreens),
                                             animate: !localProfileExist)
                }
            } error: { error in
                print(error)
                didLogin(false)
            }
        } error: { error in
            print(error)
            didLogin(false)
        }
    }
}
