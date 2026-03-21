class_name State_Stun extends State

@export var knockback_speed : float = 200.0
@export var delecerate_speed : float = 10.0
@export var invulnerable_duration : float = 1.0

var hurtbox : Hurtbox
var direction : Vector2 

var next_state: State = null

@onready var idle: State = $"../idle"

func init() -> void:
	player.player_damaged.connect( _player_damaged )

## what happends when the player enter state
func Enter() -> void:
	player.UpdateAnimation("stun")
	player.animation_player.animation_finished.connect( _animation_finished )
	
	direction = player.global_position.direction_to( hurtbox.global_position )
	player.velocity = direction * -knockback_speed
	player.set_direction()
	
	player.make_invulnerable( invulnerable_duration )
	player.effect_animation_player.play("damaged")
	pass

## what happends when the player exit state
func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect( _animation_finished )
	pass

## what happends when the process update in this state
func Process( _delta : float) -> State:
	return next_state

#what happends when the physic process update in this state
func Physics( _delta : float) -> State:
	return null
	
##what happends when the input events in this state
func  HandleInput( _event : InputEvent) -> State:
	return null

func _player_damaged( _hurt_box  ) -> void:
	hurtbox = _hurt_box
	state_machine.change_state( self )
	pass

func _animation_finished( _a : String ) -> void:
	pass
