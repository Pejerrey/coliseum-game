# Coliseum Game

## Main Flow Chart
A Game Window has one or more scenes. Each one of them is updated and drawn in every iteration of the loop.  
Each Scene has a Director and an Object Pool. The objects defines the content of a scene, they interact with the user and other objects. The Director is the mechanism to control how a scene plays, it holds which phase it's currently going through.

## Objects
* Static Image -what is says on the tin-
* Timer -timytimer-
* Button -defines a clickable active area-
* Simple Controller -defines an interface that records keys-