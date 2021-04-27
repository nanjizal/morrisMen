# morrisMen
work in progress.

9 men morris implementation, so far only created some node structures, currently the compass setting is not working as expected from the geom bearing calculated.

Using Matrix1x2 to calculate the angle and then convert to compass rose barring.

Concept is that addFriend is used to connect nodes. Each node keeps a list of connected nodes along with the rose compass.

So to check if 3 players are in a row you can ask a MorrisNode, and it will give you a list of 'mils' ( 3 in a row ) and twos ( 2 in a row ). Likely needs tweeking as I do not deal with the case of a node either side. Currently the 'rose' compass barings are wrong so I can't be sure of accurate 'mils' value.
