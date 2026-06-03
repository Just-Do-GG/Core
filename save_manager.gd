extends Node

## SaveManager - збереження ігрового прогресу

signal save_completed()
signal load_completed(data: Dictionary)

var _cache: Dictionary = {}

## Локальний сейв
func save_local(key: String, data: Dictionary) -> void:
	var file = FileAccess.open("user://saves/" + key + ".save", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	_cache[key] = data
	save_completed.emit()

## Локальний лоад
func load_local(key: String) -> Dictionary:
	if _cache.has(key):
		return _cache[key]
	
	var path = "user://saves/" + key + ".save"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		_cache[key] = data
		load_completed.emit(data)
		return data
	
	return {}

## Хмарний сейв (через сервер)
func save_cloud(key: String, data: Dictionary) -> void:
	var api = get_node("/root/Core/APIClient")
	api.post("/saves", {
		"key": key,
		"data": data
	})
	api.request_completed.connect(_on_cloud_save.bind(key, data), CONNECT_ONE_SHOT)

func _on_cloud_save(_data: Dictionary, key: String, data: Dictionary) -> void:
	save_local(key, data)

func has_save(key: String) -> bool:
	return FileAccess.file_exists("user://saves/" + key + ".save")
