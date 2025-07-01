extends Node

func get_all_children(node, arr:=[]):
	arr.append(node)
	for child in node.get_children():
		get_all_children(child, arr)
	return arr
