# Extended Tic-Tac-Toe GAME

In this version of the famous tic-tac-toe game more than two players is allowed. In addition to this, different board size choices are provided for. Currently, there are four configured game types that varies the number of players and board sizes.

| Game Type | Number of Players | Board Dimension | Consecutive Markers to Win |
|-----------|-------------------|-----------------|----------------------------|
| Regular   | 2                 | 3 x 3           | 3                          |
| Advance   | 4                 | 5 x 5           | 3                          |
| Expert    | 5                 | 7 x 7           | 5                          |
| Impossible| 6                 | 9 x 9           | 5                          |

If you choose to do so, you can add more game types by editing the [configuration file](https://github.com/preyes323/launchschool/blob/master/102/lesson_05/ttt_config.yml). Just follow the setup of the current setup of the other game types or email me at <mailto:vpaoloreyes@gmail.com> for details.


### Game AI -- Neighborhood Algorithm

In this version of the Tic-Tac-Toe game, I developed an algorithm wherein the boxes/squares in a board considers the markers in its neighbors. A square looks at itself and its neighbors to determine the best possible move. This can either be a defensive, offsenive, or simply the highest possible valued move. Each square looks to four types of neighbors for the tic-tac-toe game:

* Vertical Neighbors: The square[s] above and below itself
* Horizonal Neighbors: The squares[s] to the left and to the right of itself
* RightDiag Neighbors: The squares[s] to the upper_left and lower_right of itself
* LeftDiag Neighbors: The squares[s] to the upper_right and lower_left of itself

In determining the moves, it considers value of the current position of the square then moves to the direction of its neighbors. It then consolidates and/or compares the value from all of the neighbor types.

For example a square at [1, 1] would have Vertical Neighbors at [0, 1] and [2, 1]. If the mark at square [1, 1] and [0, 1] are both 'x' then the score for this Neighborhood is 2.

In looking for defensive moves, it looks for squares whose neighborhood score is one (1) less than the number of consecutive markers to win. Once it finds this, the algorithm locates the square that is not yet `marked` in the neighborhood. The reverse of this is true for offsensive moves.


**Strengths of the Algorithm**

* Its robust. It scales well with the number of players and board size.
* It does well in locating defensive moves.


**Weakness of the Algorithm**

* It is poor in detecting high value moves. It does not select a square that will lead to a next move that will win but rather it selects a square that has a high score. This leads to a clustering effect of moves.
