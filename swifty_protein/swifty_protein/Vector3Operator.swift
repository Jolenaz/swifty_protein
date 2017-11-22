//
//  Vector3Operator.swift
//  swifty_protein
//
//  Created by Jonas BELLESSA on 11/8/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import Foundation
import SceneKit

extension SCNVector3{
    
    static func + (left : SCNVector3, right : SCNVector3) -> SCNVector3{
        return SCNVector3( x : right.x + left.x, y : right.y + left.y, z : right.z + left.z)
    }
    
    
    static func - (left : SCNVector3, right : SCNVector3) -> SCNVector3{
        return SCNVector3( x : right.x - left.x, y : right.y - left.y, z : right.z - left.z)
    }
    
    static func * (left : SCNVector3, right : Float) -> SCNVector3{
        return SCNVector3(x : left.x * right , y : left.y * right, z : left.z * right)
    }

    static func * (left : Float, right : SCNVector3) -> SCNVector3{
        return SCNVector3(x : right.x * left , y : left * right.y, z : left * right.z)
    }
    
    static func / (left : SCNVector3, right : Float) -> SCNVector3{
        return SCNVector3(x : left.x / right , y : left.y / right, z : left.z / right)
    }
    
    static func == (left : SCNVector3, right : SCNVector3) -> Bool{
        if (left.x != right.x || left.y != right.y || left.z != right.z){
            return false
        }
        return true
    }
    
    func sqrMagnitude() -> Float{
        return (self.x * self.x + self.y * self.y + self.z * self.z)
    }

    
    
    func magnitude() -> Float{
        return (sqrtf(self.sqrMagnitude()))
    }
    
    func normalized() -> SCNVector3?{
        let mg = self.magnitude()
        
        if mg == 0 {
            return nil
        }
        
        return (self / mg)
    }
    
    static func dot (_ left : SCNVector3,_ right : SCNVector3) -> Float{
        return (left.x * right.x + left.y * right.y + left.z * right.z)
    }
    
    static func cross (_ left : SCNVector3,_ right : SCNVector3) -> SCNVector3{
        return SCNVector3(  x : left.y * right.z - left.z * right.y,
                            y : left.z * right.x - left.x * right.z,
                            z : left.x * right.y - left.y * right.x)
    }
    
    static func angle (_ left : SCNVector3,_ right : SCNVector3) -> Float?{
        if let lf = left.normalized(), let rg = right.normalized(){
            return acosf(SCNVector3.dot(lf, rg))
        }
        return nil
    }
    init(_ fl : Float) {
        self.x = fl
        self.y = fl
        self.z = fl
    }
    
}


extension SCNVector4{
    init(_ ve : SCNVector3, _ ad : Float){
        self.x = ve.x
        self.y = ve.y
        self.z = ve.z
        self.w = ad
    }
}
