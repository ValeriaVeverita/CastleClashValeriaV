local composer = require( "composer" )

--give the name to the scene
sceneName = "main_menu"

--creating scene object 
local scene = composer.newScene(sceneName)

local widget = require ("widget")
  
--------------------------------------------------------------------------------------
--LOCAL VARIABLES
--------------------------------------------------------------------------------------
local menuBkg
local focusRect
local playButton
local creditsButton
local soundButtonOn
local soundButtonOff
local title
local titleOutline
local brightness = 0

-------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
------------------------------------------------------------------------------------
local function glowTitle()
    brightness = brightness + 0.03

    titleOutline.fill.effect = "filter.brightness"
    titleOutline.fill.effect.intensity = brightness
end

local function moveTitle( )
    transition.to(title, { y = 200, xScale = 1.5, yScale = 1.4, time = 1000})
    transition.to(titleOutline, {  y = 200, xScale = 1.5, yScale = 1.6, time = 1000})
    transition.to(playButton, {alpha = 1, time = 1000})
     transition.to(creditsButton, {alpha = 1, time = 1000})
end

-- Creating Transition Function to Credits Page
local function CreditsTransition( )       
    composer.gotoScene( "CreditsScreen", {effect = "fade", time = 300})
end 

-----------------------------------------------------------------------------------------

-- Creating Transition to Level1 Screen
local function Level1ScreenTransition( )
    composer.gotoScene( "level1_screen", {effect = "fade", time = 300})
end    
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
   
   ----------------------------------------------------------------------------------------
   --CREATE OBJECTS
   -----------------------------------------------------------------------------------------
    
    --create the background image
    menuBkg = display.newImageRect ("MenuImages/MainMenuValeriaV.png", 0, 0, 0, 0)
    menuBkg.x = 500 
    menuBkg.y = 400
    menuBkg.width = display.contentWidth + 100
    menuBkg.height = display.contentHeight+50
    -- Associating display objects with this scene 
    sceneGroup:insert(menuBkg)

    --create the title outline
    titleOutline = display.newImage("MenuImages/TitleValeriaV.png")
    titleOutline.x = display.contentWidth/2+50
    titleOutline. y = display.contentHeight/2+50
    titleOutline:scale(1.9, 1.9)
    -- Associating display objects with this scene
    sceneGroup:insert(titleOutline)

    --create the title
    title = display.newImage("MenuImages/TitleValeriaV.png")
    title.x = display.contentWidth/2+50
    title. y = display.contentHeight/2+50
    title:scale(1.8, 1.7)
    -- Associating display objects with this scene
    sceneGroup:insert(title)
    
    --Creating Play Button
    playButton = widget.newButton(
      {
          --set its possition on the screen 
          x = display.contentWidth/2,
          y = display.contentHeight/2 + 50,

          --Insert the images here
          defaultFile = "ButtonImages/PlayButtonUnpressed.png",
          overFile = "ButtonImages/PlayButtonPressed.png",

          --set the size of the image
            width = 250,
            height = 150,

            -- When the button is released, call the Level1 screen transition function
            onRelease = Level1ScreenTransition   

       })
    playButton.alpha = 0
    -- Associating display objects with this scene
    sceneGroup:insert(playButton)

    --Creating Credits Button
    creditsButton = widget.newButton(
      {
         --set its possition on the screen 
          x = display.contentWidth/2,
          y = display.contentHeight/2 + 230,

          --Insert the images here
          defaultFile = "ButtonImages/CreditsButtonUnpressed.png",
          overFile = "ButtonImages/CreditsButtonPressed.png",

          --set the size of the image
            width = 250,
            height = 150,

            -- When the button is released, call the Level1 screen transition function
            onRelease = CreditsTransition 


      })
    creditsButton.alpha = 0
    --Associating display objects with this scene
    sceneGroup:insert(creditsButton)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
         timer.performWithDelay(1000,  moveTitle)
        Runtime:addEventListener("enterFrame", glowTitle)
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene