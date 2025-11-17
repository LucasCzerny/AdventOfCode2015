package aoc

Tree_Node :: struct {
	left, right: ^Tree_Node,
	value:       [2]int,
}

is_smaller :: proc(value, compare_to: [2]int) -> bool {
	if value.x == compare_to.x {
		return value.y < compare_to.y
	} else {
		return value.x < compare_to.x
	}
}

is_equal :: proc(value, compare_to: [2]int) -> bool {
	return value.x == compare_to.x && value.y == compare_to.y
}

insert_into_tree :: proc(root: ^Tree_Node, value: [2]int) -> (is_duplicate: bool) {
	if is_equal(value, root.value) {
		return true
	}

	insert_node := &root.left if is_smaller(value, root.value) else &root.right

	if insert_node^ == nil {
		insert_node^ = new(Tree_Node)
		insert_node^.value = value
		return false
	} else {
		return insert_into_tree(insert_node^, value)
	}
}

free_tree :: proc(root: ^Tree_Node) {
	if root.left != nil {
		free_tree(root.left)
	}

	if root.right != nil {
		free_tree(root.right)
	}

	free(root)
}

