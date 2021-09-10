//
//  ImageDownload.swift
//  ImageDownload
//
//  Created by kingsic on 2020/10/27.
//  Copyright © 2020 kingsic. All rights reserved.
//

import UIKit

/// Download complete callback block
public typealias DownloadCompleteBlock = ((UIImage) -> ())?

public class ImageDownload: NSObject {
    /// Singleton
    public static let shared = ImageDownload()
    
    /// Memory cache, storing the dictionary of UIImage object
    private var images = [String: UIImage]()
    
    /// A dictionary that stores BlockOperation cache objects
    private var operations = [String: BlockOperation]()
    
    /// To prevent duplicate queue creation
    private var queue = OperationQueue()

    /// Download image
    ///
    /// - parameter urlString: Image address
    /// - parameter complete: Download complete callback block
    public func downloadImage(urlString: String, complete: DownloadCompleteBlock) {
        let image = images[urlString]
        if let tempImage = image {
            if complete != nil {
                complete!(tempImage)
            }
        } else {
            let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last
            let imageName = (urlString as NSString).lastPathComponent
            let fullPath = cachePath! + "/" + imageName
            let imageData = NSData(contentsOfFile: fullPath)
            
            if imageData != nil {
                let image = UIImage(data: imageData! as Data)
                if complete != nil {
                    complete!(image!)
                }
                images[urlString] = image
            } else {
                var blockOperation = operations[urlString]
                if blockOperation == nil {
                    blockOperation = BlockOperation(block: {
                        guard let url = URL.init(string: urlString) else { return }
                        guard let imageData = NSData(contentsOf: url) else { return }
                        let image = UIImage(data: imageData as Data)
                        if image == nil {
                            self.operations.removeValue(forKey: urlString)
                            return
                        }
                        OperationQueue.main.addOperation {
                            if complete != nil {
                                complete!(image!)
                            }
                        }
                        self.images[urlString] = image
                        imageData.write(toFile: fullPath, atomically: true)
                        self.operations.removeValue(forKey: urlString)
                    })
                    
                    operations[urlString] = blockOperation
                    queue.addOperation(blockOperation!)
                }
            }
        }
    }
    
    /// Cancel all current operations
    public func cancelAll() {
        images.removeAll()
        queue.cancelAllOperations()
    }
    

}
