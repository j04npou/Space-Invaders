extends Node2D

func _on_TextureButton_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
