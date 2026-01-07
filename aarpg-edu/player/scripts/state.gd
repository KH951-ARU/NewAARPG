class_name State extends Node

##ref to player
static  var player: player

func _ready() -> void:
	pass

## what happends when the player enter state
func Enter() -> void:
	pass

## what happends when the player exit state
func Exit() -> void:
	pass

## what happends when the process update in this state
func Process( _delta : float) -> State:
	return null

#what happends when the physic process update in this state
func Physics( _delta : float) -> State:
	return null
	
##what happends when the input events in this state
func  HandleInput( _event : InputEvent) -> State:
	return null
