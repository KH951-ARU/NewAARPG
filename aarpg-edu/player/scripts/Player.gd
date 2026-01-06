class_name player extends CharacterBody2D



var move_speed : float = 100.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	var direction : Vector2 = Vector2.ZERO 
	direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
	
	velocity = direction * move_speed
	
	
	pass


func _physics_process( delta ):
	move_and_slide()
	
	
