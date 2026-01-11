class_name State_Attack extends State

@onready var walk: State = $"../walk"
@onready var idle: State = $"../idle"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"
@onready var hurt_box: Hurtbox = $"../../Interactions/HurtBox"


var attacking : bool = false

@export var attack_sound : AudioStream 
@export_range(1,20,0.5) var decelerate_speed : float = 5.0
## what happends when the player enter state
func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_anim.play("attack_" + player.AnimDirection() )
	animation_player.animation_finished.connect( EndAttack )
	
	##audio sound
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()
	
	attacking = true
	hurt_box.monitoring = true
	pass

## what happends when the player exit state
func Exit() -> void:
	animation_player.animation_finished.disconnect( EndAttack )
	attacking = false
	
	
	await get_tree().create_timer( 0.075 ).timeout
	hurt_box.monitoring = false
	pass

## what happends when the process update in this state
func Process( _delta : float) -> State:
	player.velocity -=  player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null

#what happends when the physic process update in this state
func Physics( _delta : float) -> State:
	return null
	
##what happends when the input events in this state
func  HandleInput( _event : InputEvent) -> State:
	return null


func EndAttack( _newAnimName : String ) -> void:
	attacking = false
