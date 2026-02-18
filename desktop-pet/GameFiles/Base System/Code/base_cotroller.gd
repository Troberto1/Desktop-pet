extends Node

var metafile : ConfigFile = ConfigFile.new()
func _ready() -> void:
	get_window().position = Vector2(0,0)
	var temp = load("res://GameFiles/Menu/Scenes/mainmenu.tscn") 
	add_child(temp.instantiate())
	get_window().mouse_passthrough = true

func Spawn(pet : String) -> void:
	#pet is to 2 spawn different selected pet/pets
	metafile.load("res://Pets/test01/meta.cfg")
	if !metafile.has_section("metadata"):
		assert(false, "metadata does not exist!")# Temp, it crashes the game, but i only want 
	var pet_Packed = load("res://Pets/test01/test01.tscn") 
	var temp_pet = pet_Packed.instantiate()
	temp_pet.set_script(load("res://Brains/test01Brain.gd"))
	
	$Pet_Collector.add_child(temp_pet)
	
