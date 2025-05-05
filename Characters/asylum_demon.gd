extends RigidBody2D

@onready var max_hp: int = 100
@onready var damage_taken: int = 0
@onready var hp

@onready var health_bar = $ProgressBar

func _on_ready():
	health_bar.FILL_BEGIN_TO_END = true
	health_bar.show_percentage = false
	

func _physics_process(delta: float) -> void:
	hp = max_hp - damage_taken
	if hp == 0:
		queue_free()
	health_bar.value = hp

func _on_head_area_area_exited(area: Area2D) -> void:
	print("Head")
	damage_taken += 50


func _on_body_area_area_exited(area: Area2D) -> void:
	print("Body")
	damage_taken += 5


func _on_hammer_area_exited(area: Area2D) -> void:
	print("Hammer")
	area._hit_by_enemy()


func _on_hammer_body_exited(body: Node2D) -> void:
	print("Hammer")
