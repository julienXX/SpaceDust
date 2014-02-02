# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'SpaceDust'
  app.icons = ['Icon.png']
  app.frameworks += ['SpriteKit']
  app.provisioning_profile = '/Users/julien/Library/MobileDevice/Provisioning\ Profiles/2AE0D68A-3CB6-47E0-99E5-D929F0DFF0DE.mobileprovision'
end
