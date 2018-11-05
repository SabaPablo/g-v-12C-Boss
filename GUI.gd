extends Control


func _on_StartGame_pressed():
	get_tree().change_scene("res://World.tscn")

func _on_EndGame_pressed():
	get_tree().quit()
