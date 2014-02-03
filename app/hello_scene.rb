class HelloScene < SKScene
  attr_accessor :contentCreated

  def didMoveToView(view)
    unless contentCreated
      createSceneContents
      @contentCreated = true
    end
  end

  def createSceneContents
    self.backgroundColor = UIColor.blackColor
    self.scaleMode = SKSceneScaleModeAspectFit
    self.addChild newHelloNode
  end

  def newHelloNode
    helloNode = SKSpriteNode.alloc.initWithImageNamed('SpaceDust')
    helloNode.name = "helloNode"
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
    helloNode
  end

  def touchesBegan(touches, withEvent: event)
    helloNode = self.childNodeWithName("helloNode")

    unless helloNode.nil?
      helloNode.name = nil
      moveUp = SKAction.moveByX(0, y: 100.0, duration: 0.5)
      zoom = SKAction.scaleTo(5.0, duration: 0.5)
      pause = SKAction.waitForDuration(0.05)
      fadeAway = SKAction.fadeOutWithDuration(0.25)
      remove = SKAction.removeFromParent
      moveSequence = SKAction.sequence [moveUp, zoom, pause, fadeAway, remove]
      helloNode.runAction(SKAction.playSoundFileNamed('raygun.mp3', waitForCompletion: false))
      helloNode.runAction(moveSequence, completion: lambda do
                            spaceshipScene = SpaceshipScene.alloc.initWithSize(self.size)
                            transition = SKTransition.revealWithDirection(SKTransitionDirectionDown, duration: 0.2)
                            self.view.presentScene(spaceshipScene, transition: transition)
                          end)
    end
  end
end
