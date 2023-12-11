%Define a function which takes two list of PIDs [x1, x2, ...], [y1, y2, ...], having the same length, and a
%function f, and creates a different "broker" process for managing the interaction between each pair of
%processes xi and yi.
%At start, the broker process i must send its PID to xi and yi with a message {broker, PID}. Then, the
%broker i will receive messages {from, PID, data, D} from xi or yi, and it must send to the other one an
%analogous message, but with the broker PID and data D modified by applying f to it.
%A special stop message can be sent to a broker i, that will end its activity sending the same message to xi
%and yi. 
