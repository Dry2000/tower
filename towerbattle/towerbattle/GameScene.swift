//
//  GameScene.swift
//  towerbattle
//
//  Created by 洞井僚太 on 2018/12/28.
//  Copyright © 2018 洞井僚太. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate{
    var bowl:SKShapeNode!
    var addtimer:Timer!
    var label:SKLabelNode!
    var go:SKLabelNode!
    var texture:SKSpriteNode!
    var count = 1.0
    override func didMove(to view: SKView) {
        physicsWorld.gravity=CGVector(dx:0,dy:-2.0)
        physicsWorld.contactDelegate=self
        addBack()
        label = SKLabelNode(text:"回転させる")
        label.position = CGPoint(x:-frame.width/3,y:frame.height/3)
        go = SKLabelNode(text:"落とす")
        go.position = CGPoint(x:frame.width/3,y:frame.height/3)
        self.addChild(label)
        self.addChild(go)
        bowl=SKShapeNode.init(rectOf: CGSize.init(width:frame.width/2,height:20))
        //let texb=SKTexture(imageNamed:"bowl")
        bowl.physicsBody=SKPhysicsBody(rectangleOf:bowl.frame.size)
        bowl.physicsBody?.isDynamic=false
        bowl.position=CGPoint(x:0,y:-frame.height/3)
        addChild(bowl)
        bowl.zPosition=0
        addNode()
       /* addtimer=Timer.scheduledTimer(withTimeInterval:1, repeats: true, block:{_ in self.addNode()})*/
        
    }
    func addBack(){
        
        let back=SKSpriteNode(imageNamed:"background")
        back.position=CGPoint(x:0,y:0)
        back.xScale=1.2
        back.yScale=1.2
        back.zPosition = -100
        self.addChild(back)
    }
    func addNode(){
        let index=Int(arc4random_uniform(7))
        texture=SKSpriteNode(imageNamed:"\(index)")
        let tex=SKTexture(imageNamed:"\(index)")
        texture.physicsBody=SKPhysicsBody(texture:tex,size:texture.size)
        texture.zPosition=1
        texture.xScale=0.5
        texture.yScale=0.5
        texture.position=CGPoint(x:0,y:frame.width/3)
        texture.physicsBody?.isDynamic = false
        addChild(texture)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let locate=touch.location(in: self)
            if self.atPoint(locate) == label{
                
                texture.zRotation = CGFloat(45.0*count/180.0*M_PI)
                count = count + 1.0
            }else if self.atPoint(locate) == go{
                texture.physicsBody?.isDynamic = true
                let timer = Timer.scheduledTimer(withTimeInterval:1.0,repeats:false,block:{ _ in self.addNode()})
            }
            /*let action=SKAction.moveTo(x:locate.x,duration:0.2)
            self.bowl.run(SKAction.sequence([action]))*/
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
          /*  let locate=touch.location(in: self)
            let action=SKAction.moveTo(x:locate.x,duration:0.2)
            self.bowl.run(SKAction.sequence([action]))*/
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
