//
//  PersonClientModel.swift
//  PipedriveTask
//
//  Created by Maryam Alimohammadi on 8/18/18.
//  Copyright © 2018 Maryam Alimohammadi. All rights reserved.
//

import Foundation
import  Alamofire

protocol PersonServiceProtocol {
    func loadPersonsList(userArray:[PersonModel]?,hasError:Bool?)
}

class PersonClientModel: NSObject {
    
    var personDelegate: PersonServiceProtocol!
    let url = ""
    
    func getPerosns(){
        
        Alamofire.request(url).responseJSON { (response) in
            switch response.result {
            case .success:
                let jsonData = response.data
                do{
                    let serverResponse = try JSONDecoder().decode(ServerResponse.self, from: jsonData!)
                    self.personDelegate.loadPersonsList(userArray: serverResponse.data, hasError: nil)
                }catch {
                    print(error)
                    self.personDelegate.loadPersonsList(userArray: nil, hasError: true)
                }
            case .failure(let error):
                print(error)
                self.personDelegate.loadPersonsList(userArray: nil, hasError: true)
            }
            
            
        }
    }
        
        

}

