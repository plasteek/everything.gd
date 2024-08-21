class_name DijkstraPathfinding
extends RefCounted

static func find_shortest_paths(origin_id, get_connections: Callable):
    var distances = {} # [distance, previous]

    # PQ Structure: [source: id, distance_till_now (for pq only)]
    var pq = PriorityQueue.new([[origin_id, 0]], PriorityQueue.MIN_HEAP, func(item): return item[1])
    var visited = Set.new()

    while pq.size() > 0:
        var current = pq.pop()

        var curr_node_id = current[0]
        var distance_to_current = current[1]

        if visited.has(curr_node_id):
            continue
        visited.add(curr_node_id)

        var connections = get_connections.call(curr_node_id) # Array[Connection]
        for conn in connections:
            # Update distance
            var closest_distance = distances[conn.target_id][0] if conn.target_id in distances else INF
            var conn_distance = distance_to_current + conn.distance

            if closest_distance > conn_distance:
                closest_distance = conn_distance
                distances[conn.target_id] = [closest_distance, curr_node_id]

            # Queue connected nodes
            pq.insert([conn.target_id, closest_distance])
            
    return distances
    
static func connection(target_id, distance: float):
    var new_conn = Connection.new()
    new_conn.target_id = target_id
    new_conn.distance = distance
    return new_conn

class Connection:
    var target_id
    var distance: float