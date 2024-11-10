import Foundation

class UserData: ObservableObject {
    
    var balanceUser = UserDefaults.standard.integer(forKey: "balance_user") {
        didSet {
            UserDefaults.standard.set(balanceUser, forKey: "balance_user")
        }
    }
    
}
