import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    
    func login(mail email: String, matKhau password: String, completion completionBlock: @escaping ((_ success: Bool, _ data: String?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // login failed !!!
                completionBlock(false, "\(error.localizedDescription)")
            } else {
                // login success !!!
                if let user = result?.user {
                    completionBlock(true, "\(user.uid)")
                }
            }
        }
    }
    
    func register(mail email: String, matKhau password: String, completion completionBlock: @escaping ((_ success: Bool, _ data: String?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                // register failed !!!
                completionBlock(false, "\(error.localizedDescription)")
            } else {
                // register success !!!
                if let user = result?.user {
                    completionBlock(true, "\(user.uid)")
                }
            }
        }
    }

    func logout(completion completionBlock: @escaping ((_ success: Bool) -> Void)) {
        do {
            try Auth.auth().signOut()
            completionBlock(true)
        } catch {
            print("Error logout", error.localizedDescription)
            completionBlock(false)
        }
    }

}
