class SpaceshipScene < SKScene
  attr_accessor :contentCreated, :musicPlayer

  def skRand(low, high)
    random = Random.new
    random.rand(low..high)
  end

  def didMoveToView(view)
    unless contentCreated
      createSceneContents
      @contentCreated = true
    end
  end

  def touchesBegan(touches, withEvent: event)
    spaceship = self.childNodeWithName('hull')

    unless spaceship.nil?
      location = touches.anyObject.locationInNode(self)
      spaceship.runAction(SKAction.moveTo(location, duration: 1.0))
    end
  end

  def didSimulatePhysics
    self.enumerateChildNodesWithName 'rock',
      usingBlock: lambda { |node, stop| node.removeFromParent if node.position.y < 0 }
  end

  def createSceneContents
    self.backgroundColor = UIColor.blackColor
    self.scaleMode = SKSceneScaleModeAspectFit
    spaceship = newSpaceship
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame) - 150)
    self.addChild spaceship
    makeRocks = SKAction.sequence([SKAction.performSelector('addRock', onTarget: self),
                                   SKAction.waitForDuration(0.10, withRange: 0.15)])
    self.runAction(SKAction.repeatActionForever(makeRocks))
    playBackgroundMusic
  end

  def playBackgroundMusic
    musicURL = NSBundle.mainBundle.URLForResource('music', withExtension: 'mp3')
    @musicPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(musicURL, error: nil)

    @musicPlayer.numberOfLoops = -1
    @musicPlayer.volume = 1.0
    @musicPlayer.prepareToPlay
    @musicPlayer.play
  end

  def newSpaceship
    hull = SKSpriteNode.alloc.initWithImageNamed('Ship')
    hull.name = 'hull'
    hull.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(hull.size)
    hull.physicsBody.dynamic = false
    light1 = newLight
    light2 = newLight
    light1.position = CGPointMake(-28.0, 6.0)
    light2.position = CGPointMake(28.0, 6.0)
    hull.addChild light1
    hull.addChild light2
    hull
  end

  def newLight
    light = SKSpriteNode.alloc.initWithColor(UIColor.yellowColor,
                                             size: CGSizeMake(8,8))
    blink = SKAction.sequence([SKAction.fadeOutWithDuration(0.05),
                               SKAction.fadeInWithDuration(0.25)])
    blinkForever = SKAction.repeatActionForever(blink)
    light.runAction(blinkForever)
    light
  end

  def addRock
    rock = SKSpriteNode.alloc.initWithColor(randomColor, size: randomSize)
    rock.position = CGPointMake(skRand(0, self.size.width), self.size.height-50)
    rock.name = "rock"
    rock.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(rock.size)
    rock.physicsBody.usesPreciseCollisionDetection = true
    self.addChild rock
  end

private

  def randomColor
    [UIColor.brownColor, UIColor.grayColor,
     UIColor.lightGrayColor, UIColor.darkGrayColor].sample
  end

  def randomSize
    sizes = [4, 8, 16, 24]
    size= sizes.sample
    CGSizeMake(size, size)
  end

end
