//
//  DetailViewController.swift
//  CryptoApp
//
//  Created by Justin Grosvenor on 5/15/18.
//  Copyright © 2018 Justin Grosvenor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let getDetail = GetDetail()
    var newData: Welcome? = nil
    var dataSuccess: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetail.searchDetails()
        if setData(){
            setLabels()
        }
        
    }

    func setData() -> Bool {
        sleep(1)
        if let thisData = getDetail.results {
            newData = thisData
            print("data success")
            dataSuccess = true
        }
        else {
            usleep(1500000)
            if let thisData = getDetail.results {
                newData = thisData
                print("data success second try")
                dataSuccess = true
                return dataSuccess
            }
            else {
                print("inner fail")
                sleep(1)
                if let thisData = getDetail.results {
                    newData = thisData
                    print("data success third try")
                    dataSuccess = true
                    return dataSuccess
                }
                else {
                    print("Data Failure")
                    return false
                }
            }
        }
        return false
    }
    
    func setLabels(){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
