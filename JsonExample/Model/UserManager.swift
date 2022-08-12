//
//  UserManager.swift
//  JsonExample
//
//  Created by Manish on 10/08/22.
//

import Foundation

protocol UserManagerDelegate{
    func didUserDetails(userList : [User])
    func didFailWithError(error : Error)
}

struct UserManager{
    let UserDetailsUrl = APIList.BaseUrl
    var delegate : UserManagerDelegate?
    
    func fetchUserDetails(){
        let urlString = UserDetailsUrl
        performRequest(with: urlString)
    }
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data,response,error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }else{
                    do{
                        let result = try JSONDecoder().decode([User].self, from: data!)
                        delegate?.didUserDetails(userList: result)
                    }catch{
                        delegate?.didFailWithError(error: error)
                        return
                    }
                }
            }
            task.resume()
        }
    }
}
