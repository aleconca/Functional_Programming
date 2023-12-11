%Create a function node_wait that implements nodes in a tree-like topology. Each node, which is a
%separate agent, keeps track of its parent and children (which can be zero or more), and contains a value.
%An integer weight is associated to each edge between parent and child.

%A node waits for two kind of messages:

%• {register_child, ...}, which adds a new child to the node (replace the dots with appropriate values),

%• {get_distance, Value}, which causes the recipient to search for Value among its children, by

%interacting with them through appropriate messages. When the value is found, the recipient
%answers with a message containing the minimum distance between it and the node containing
%"Value", considering the sum of the weights of the edges to be traversed. If the value is not found,
%the recipient answers with an appropriate message. While a node is searching for a value among
%its children, it may not accept any new children registrations. E.g., if we send {get_distance, a} to
%the root process, it answers with the minimum distance between the root and the closest node
%containing the atom a (which is 0 if a is in the root).
