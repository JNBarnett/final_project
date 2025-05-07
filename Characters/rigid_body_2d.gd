extends RigidBody2D

@export var acceleration:float = 30.0
@export var jump_accel:float = -100.0
@onready var _animated_sprite = $AnimatedSprite2D

@onready var max_hp: int = 50
@onready var damage_taken: int = 0
@onready var hp
	
@onready var max_stamina: int = 10
@onready var stamina_used: int = 0
@onready var stamina:int

func _on_ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var rtl = $"../Camera2D/Health, Stamina, Magic"
	
	if Input.is_action_pressed("Right"):
		_animated_sprite.play("Walk_Right_Neutral")
		apply_central_impulse(Vector2(acceleration,0.5))
	if Input.is_action_pressed("Left"):
		_animated_sprite.play("Walk_Left_Neutral")
		apply_central_impulse((Vector2(-acceleration,0.5)))
	if Input.is_action_pressed("Up") and stamina >= 0:
		#_animated_sprite.play("Jump")
		apply_central_impulse(Vector2(0, jump_accel))
		stamina_used += 1;
	#elif Input.is_action_pressed("Down"):
		#_animated_sprite.play("Down")
	elif not Input.is_action_pressed("Up"):
		if stamina_used != 0:
			stamina_regen()
	else:
		apply_central_impulse(Vector2.ZERO)
		_animated_sprite.play("Idle")
		

	stamina = max_stamina - stamina_used
	hp = max_hp - damage_taken
	
	if stamina_used > max_stamina:
		acceleration = 10
		jump_accel = -25
	elif stamina_used < max_stamina:
			acceleration = 30
			jump_accel = -100

	if damage_taken >= max_hp:
		get_tree().change_scene_to_file("res://Maps/You Died.tscn")

	var output = ""
	output += "HP: " + str(hp) + "/" + str(max_hp) + "\n"
	output += "Stamina: " + str(stamina) + "/" + str(max_stamina)
	
	rtl.text = output;

func stamina_regen():
	stamina_used -= 1

func _hit_by_enemy():
	damage_taken += 5

#func inventory():
	#var items_found = {};
	#var armor_equiped = {};
	#var weapons_equiped = {};
	#var rings = {}
