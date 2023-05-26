//SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity >=0.7.0 <0.9.0;

contract Vote{
    struct Pauta{
        string pauta_text;
        bool voted;
    }

    address admin;

    mapping (address => Pauta) pauta;

    enum Option { Yes, No, Null, Abstention }

    mapping (Option => address[]) array_vote;

    constructor (string memory _pauta){
        admin = msg.sender;
        pauta[msg.sender].pauta_text = _pauta;
    }

    function vote(Option _option) public{
        require(!pauta[msg.sender].voted, "Usuario ja votou");

        array_vote[_option].push(msg.sender);

        pauta[msg.sender].voted = true;

    }

    function result(Option _option) public view returns(address[] memory){
        return(array_vote[_option]);
    }

    function get_pauta() public view returns (string memory){
        return(pauta[admin].pauta_text);
    }

    function get_total_votes() public view returns(uint256) {
        uint256 totalVotes = 0;

        for (uint256 i = 0; i < uint256(Option.Abstention) + 1; i++) {
            totalVotes += array_vote[Option(i)].length;
        }

        return totalVotes;
    }


}