class_name State_Walk extends State

@export var move_speed : float = 100.0

@onready var idle: State = $"../idle"
@onready var attack: State = $"../attack"



## what happends when the player enter state
func Enter() -> void:
	player.UpdateAnimation("walk")
	pass

## what happends when the player exit state
func Exit() -> void:
	pass

## what happends when the process update in this state
func Process( _delta : float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction * move_speed
	
	if player.SetDirection():
		player.UpdateAnimation("walk")
	
	return null

#what happends when the physic process update in this state
func Physics( _delta : float) -> State:
	return null
	
##what happends when the input events in this state
func  HandleInput( _event : InputEvent) -> State:
	return null
