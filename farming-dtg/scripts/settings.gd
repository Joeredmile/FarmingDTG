extends Control




func _on_volume_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/volume.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_help_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/help.tscn")
