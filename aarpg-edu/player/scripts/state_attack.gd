class_name State_Attack extends State

@onready var walk: State_Walk = $"../walk"



## what happends when the player enter state
func Enter() -> void:
	player.UpdateAnimation("attack")
	pass

## what happends when the player exit state
func Exit() -> void:
	pass

## what happends when the process update in this state
func Process( _delta : float) -> State:
	player.velocity = Vector2.ZERO
	return null

#what happends when the physic process update in this state
func Physics( _delta : float) -> State:
	return null
	
##what happends when the input events in this state
func  HandleInput( _event : InputEvent) -> State:
	return null
