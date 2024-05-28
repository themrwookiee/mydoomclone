extends "res://addons/gut/test.gd"

# Load the main scene of your application
@onready var main_scene = preload("res://levels/world.tscn")

func before_all():
	# This method runs before all tests
	pass

func after_all():
	# This method runs after all tests
	pass

func test_app_runs_without_errors() -> void:
	# Add the main scene to the tree
	var instance = main_scene.instantiate()
	add_child(instance)

	# Add a brief delay to allow the scene to initialize
	await get_tree().process_frame
	await get_tree().process_frame

	# Check if the scene is still valid (no errors occurred)
	assert_true(instance.is_inside_tree(), "The main scene should be running without errors.")

	# Optionally, you can check specific nodes or properties to ensure everything is set up correctly
	# For example:
	# var some_node = instance.get_node("SomeNode")
	# assert_true(some_node != null, "SomeNode should exist in the scene")

	# Clean up
	instance.queue_free()
