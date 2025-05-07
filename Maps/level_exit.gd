extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Head" and body.name != "StaticBody2D":
		get_tree().change_scene_to_file("res://Maps/Victory.tscn")
