class_name player extends CharacterBody2D

#direction varibles
#_____________________________
var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT,Vector2.UP ]
var direction : Vector2 = Vector2.ZERO

## health & status varibles
var invulnerable : bool = false
var HP : int = 6
var max_HP : int = 6

#on ready varibles
#_______________________________
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var effect_animation_player : AnimationPlayer = $EffectAnimationPlayer
@onready var hitbox : Hitbox = $Hitbox




##signals
signal DirectionChanged( new_direction : Vector2)
signal player_damaged( hurtbox : Hurtbox)

func _ready() -> void:
	PlayerManager.player = self
	state_machine.Initialise(self)
	hitbox.Damaged.connect( _take_damage )
	updateHP( 99 )
	pass

func _process(delta: float) -> void:
	
	##v1
	#direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	#direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	direction = Vector2(
		Input.get_axis("Left" , "Right"),
		Input.get_axis("Up","Down") 
	).normalized()
	
	pass


func _physics_process( delta ):
	move_and_slide()

func SetDirection() -> bool:
	if direction == Vector2.ZERO:
		return false
		## take angle and converts to array / cached direction from constant
	var direction_id : int = int( round( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_dir = DIR_4[ direction_id ]
	
	
	if new_dir == cardinal_direction:
		return false
	
	cardinal_direction = new_dir
	DirectionChanged.emit( new_dir )
	sprite_2d.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func UpdateAnimation( state : String) -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass


func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif  cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"

func _take_damage( hurtbox : Hurtbox ) -> void:
	if invulnerable == true:
		return
	updateHP( -hurtbox.damage )
	if HP > 0:
		player_damaged.emit( hurtbox )
	else:
		player_damaged.emit( hurtbox )
		updateHP( 99 )
	pass

func updateHP( delta : int ) -> void:
	HP = clampi( HP + delta , 0, max_HP)
	pass

func make_invulnerable( _duration : float = 1.0 ) -> void:
	invulnerable = true
	hitbox.monitoring = false
	
	await get_tree().create_timer( _duration ).timeout
	
	invulnerable = false
	hitbox.monitoring = true
	pass
