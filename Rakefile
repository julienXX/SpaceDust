# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'

begin
  require 'bundler'
  require 'motion-testflight'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = 'SpaceDust'
  app.icons = ['Icon.png']
  app.frameworks += ['SpriteKit']

  app.testflight.sdk = 'vendor/TestFlight'
  app.testflight.api_token = '478946297e24711412051e5c23fa1187_MzAzNzQ4MjAxMi0wMi0wNCAxMDo1Njo1MC45ODc2NzU'
  app.testflight.team_token = 'fda1be9e2e09e5290b024c5309cfc36c_MjA3MTYzMjAxMy0wNC0wMyAwNToyOToxOS43Nzk5MTE'
  app.testflight.app_token = 'f845301c-993c-4776-9355-a71d6596ac39'
end
