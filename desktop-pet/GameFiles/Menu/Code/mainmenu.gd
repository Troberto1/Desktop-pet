extends Window

var pet : PackedScene = preload("res://Pets/test01/test01.tscn")

func _on_temp_spawn_pressed() -> void:
	print("Nér")
	get_parent().Spawn("asd")

	
	
