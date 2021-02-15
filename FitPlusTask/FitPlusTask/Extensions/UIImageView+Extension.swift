//
//  UIImageView+Extension.swift
//  FitPlusTask
//
//  Created by venkata rama kishore arimilli on 15/02/21.
//  Copyright © 2021 venkata rama kishore arimilli. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    typealias imageDownloadCompletion = (_ isSuccess:Bool,_ image:UIImage?) -> Void
    func downloaded(from url: URL,completion:@escaping(imageDownloadCompletion)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { completion(false,nil)
                    return
            }
            completion(true,image)
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
