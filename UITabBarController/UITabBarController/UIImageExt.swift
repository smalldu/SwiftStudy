//
//  UIImageExt.swift
//  UITabBarController
//
//  Created by duzhe on 15/9/3.
//  Copyright © 2015年 duzhe. All rights reserved.
//

import UIKit

extension UIImage{

    //图像比例缩放
    func scaleImage(img:UIImage,scaleSize:CGFloat)->UIImage{
        UIGraphicsBeginImageContext(CGSizeMake(img.size.width * scaleSize, img.size.height * scaleSize))
        img.drawInRect(CGRectMake(0, 0, img.size.width * scaleSize, img.size.height * scaleSize))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    
    //自定长宽
    func reSizeImage(image:UIImage , toSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext(CGSizeMake(toSize.width, toSize.height));
        image.drawInRect(CGRectMake(0, 0, toSize.width, toSize.height))
        let reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    
}
