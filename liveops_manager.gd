extends Node

## LiveOpsManager - отримання конфігів та фічів

signal config_updated(config: Dictionary)

var _cache: Dictionary = {}
var _refresh_interval: float = 300.0  # 5 хв

func _ready():
	_refresh_config()

## Отримати конфіг гри
func get_config() -> Dictionary:
	return _cache

## Отримати значення фічі
func get_feature(key: String, default_value = null):
	return _cache.get("features", {}).get(key, default_value)

## Отримати ads ключі для платформи
func get_ads_key(platform: String) -> String:
	var ads = _cache.get("ads_keys", {})
	return ads.get(platform, "")

## Оновити конфіг
func refresh() -> void:
	_refresh_config()

func _refresh_config() -> void:
	var api = get_node("/root/Core/APIClient")
	api.get("/liveops/config")
	api.request_completed.connect(_on_config_loaded, CONNECT_ONE_SHOT)

func _on_config_loaded(data: Dictionary) -> void:
	_cache = data
	config_updated.emit(data)
