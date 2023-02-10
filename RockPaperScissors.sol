pragma solidity ^0.8.0;

contract RockPaperScissors {

    // Enum for the three possible moves
    enum Move { Rock, Paper, Scissors }

    // Event to announce the result of the game
    event Result(address player1, address player2, uint8 player1Move, uint8 player2Move, uint8 winner);

    // Mapping to store each player's move
    mapping (address => uint8) public moves;

    // Function to play the game
    function play(bytes32 hash) public {
        // Extract the player's address and move
        address player = msg.sender;
        uint8 move = uint8(bytes32(sha3(hash)) & 2);

        // Check if the player has already made a move
        require(moves[player] == 0, "You have already played a move");

        // Store the player's move
        moves[player] = move;

        // Check if both players have made their moves
        address player2;
        uint8 player2Move;
        for (address addr in moves) {
            if (addr != player) {
                player2 = addr;
                player2Move = moves[addr];
                break;
            }
        }
        require(player2 != address(0), "Waiting for another player to make their move");

        // Determine the winner
        uint8 winner;
        if (player2Move == move) {
            winner = 0;
        } else if ((player2Move + 1) % 3 == move) {
            winner = player;
        } else {
            winner = player2;
        }

        // Emit the result event
        emit Result(player, player2, move, player2Move, winner);
    }

}
