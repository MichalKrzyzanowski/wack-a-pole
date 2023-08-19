# TODO List
***
* [x] core systems [feature, refactor]
	* [x] scene that holds all of the current manager scenes (player, ball managers)
	* [x] encapsulates all of the necessary data in function calls, all of the current manager functionality should only be called from this scene
	* [x] allows for player and ball managers to comunicate with eachother
* [ ] ball manager [feature]
	* [x] should be created as a child of core systems
	* [x] track if a ball is potted. player manager can use this to decide if the current player should get another turn
	- [ ] handle ball spawning. a ball should respawn at it's original spawn location. if its not available, respawn at any free space on the white line of pool table
- [ ] ball [extension]
	- [ ] spawn position data
	- [ ] respawn feature, should respawn after it was potted if it can (special balls are killed on pot)
		- [ ] should be managed by the ball manager
- [ ] HUD [feature]
	- [ ] player score/hp display, two options:
		- [ ] list with score/hp bar with player name placed on the top. list is sorted by highest score/hp and can be placed in any of the four corners of the screen
		- [ ] list with score/hp bar with player name inside bar. placed at the top of the screen, sorted by highest score/hp going horizontally across the screen [optional]
- [ ] UI-General [feature]
- [ ] UI-Options [feature]
* [ ] Poles [feature]
	- [ ] part of core systems
	- [ ] human characters that walk around the pool table using simple AI
	- [ ] player can tap them to kill/damage them [TBD]
		- [ ] if killed, run off the map and despawn perhaps using godot's on screen notifier
	- [ ] perform their action when close to the table. if successfull, run off the map
	- [ ] possible actions
		- [ ] steal: take a random ball off of the table, if only 1 red and 1 yellow balls left, default to white. if white taken, current players turn is lost
		- [ ] swap: swap a random ball on the table with either a red or yellow ball, or a special ball. cannot swap white ball nor if only 1 red and yello ball on table
			- [ ] swap chance table: [TBD]
				- [ ] red [common]
				- [ ] yellow [common]
				- [ ] special [uncommon]
				- [ ] ultra [rare]
		- [ ] place: place a random ball in a random, empty place on the table. based on swap chance table
- [ ] Special balls [feature, content]
	- [ ] balls with special parameters and actions e.g. more score after potting
	- [ ] do not respawn after being potted
- [ ] Aim assist line drawn before updated [bug]
- [ ] Clean up table and core systems modules ordering [refactor]
- [ ] Change folder and file naming convention [refactor]
