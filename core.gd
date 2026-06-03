extends Node

## Core - головний клас модуля
## Додається як Autoload (Singleton) в Godot

var auth: AuthManager
var api: APIClient
var save: SaveManager
var liveops: LiveOpsManager

func _ready():
	auth = AuthManager.new()
	api = APIClient.new()
	save = SaveManager.new()
	liveops = LiveOpsManager.new()
	
	add_child(auth)
	add_child(api)
	add_child(save)
	add_child(liveops)
