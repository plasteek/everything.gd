class_name PriorityQueue
extends RefCounted

var _items := []
var _compare_func := PriorityQueue.MAX_HEAP
var _weight_func := _identity

func _init(initial := [], compare_func := PriorityQueue.MAX_HEAP, weight_func := _identity):
    _items = initial
    _compare_func = compare_func
    _weight_func = weight_func
    build()

func build() -> void:
    var last_non_leaf: int = floor(_items.size() / 2.0) - 1
    for i in range(last_non_leaf, -1, -1):
        _heapify_down(i)

func insert(item) -> void:
    _items.append(item)
    _heapify_up(_items.size() - 1)

func pop():
    _swap(0, _items.size() - 1)
    var result = _items.pop_back()
    _heapify_down(0)
    return result

func peek():
    return _items[0]

func size() -> int:
    return _items.size()

# If -1 we consider as left larger than right
static func MAX_HEAP(a: int, b: int):
    return b - a # Descending
static func MIN_HEAP(a: int, b: int):
    return a - b # Ascending

func _heapify_up(i) -> void:
    var current = i
    while _within_bound(_parent(current)):
        var p = _parent(current)
        if _compare(_items[current], _items[p]) < 0:
            _swap(current, p)
            current = p
            continue
        break

func _heapify_down(i) -> void:
    var largest = i
    while _within_bound(largest):
        var current = largest
        var l = _left(largest)
        var r = _right(largest)

        if _within_bound(l) and _compare(_items[l], _items[largest]) < 0:
            largest = l
        if _within_bound(r) and _compare(_items[r], _items[largest]) < 0:
            largest = r
        
        if largest != current:
            _swap(largest, current)
        else:
            # Item is in position already
            break

func _compare(a, b) -> int:
    # Transforms the items to something comparable
    return _compare_func.call(_weight_func.call(a), _weight_func.call(b))
    
# Helper functions
func _parent(i) -> int:
    return floor((i - 1) / 2)
func _left(i) -> int:
    return 2 * i + 1
func _right(i) -> int:
    return 2 * i + 2

func _swap(index_a, index_b) -> void:
    var tmp = _items[index_a]
    _items[index_a] = _items[index_b]
    _items[index_b] = tmp
func _within_bound(i) -> bool:
    if i < 0 or i >= _items.size():
        return false
    return true
func _identity(item):
    return item