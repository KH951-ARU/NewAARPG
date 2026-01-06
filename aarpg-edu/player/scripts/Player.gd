class_name player extends CharacterBody2D

#direction varibles
#_____________________________
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

var move_speed : float = 100.0
#state varibles
#__________________________
var state : String = "idle"
#on ready varibles
#_______________________________
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	velocity = direction * move_speed
	
	UpdateAnimation()
	
	pass


func _physics_process( delta ):
	move_and_slide()

func SetDirection() -> bool:
	
	return true


func SetState() -> bool:
	
	return true

func UpdateAnimation() -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass


func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif  cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
