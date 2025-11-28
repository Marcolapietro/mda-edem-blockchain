// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Votacion {
    address public owner;
    mapping(string => bytes32) private ID_Candidato;
    mapping(string => uint) private votos_candidato;
    mapping(address => bool) public yaHaVotado;
    mapping(address => bool) private yaSeHaPresentado;
    mapping(string => bool) private esCandidato;

    string[] private candidatos;

    modifier soloOwner() {
        require(msg.sender == owner, "No tienes permisos para ejecutar esta funcion.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function representar(string memory _nombrePersona, uint _edadPersona, string memory _idPersona) public {
        require(!yaSeHaPresentado[msg.sender], "Ya te has presentado como candidato.");
        require(!esCandidato[_nombrePersona], "Este candidato ya se ha presentado.");

        bytes32 hash_Candidato = keccak256(abi.encodePacked(_nombrePersona, _edadPersona, _idPersona));
        ID_Candidato[_nombrePersona] = hash_Candidato;
        esCandidato[_nombrePersona] = true;
        yaSeHaPresentado[msg.sender] = true;
        candidatos.push(_nombrePersona);
    }

    
    function verCandidatos() public view returns(string[] memory) {
        return candidatos;
    }

    function votar(string memory _candidato) public {
        require(!yaHaVotado[msg.sender], "Ya has votado previamente");
        yaHaVotado[msg.sender] = true;
        votos_candidato[_candidato]++;
    }

    function verVotos(string memory _candidato) public view returns(uint) {
        return votos_candidato[_candidato];
    }

    function verResultados() public view soloOwner returns(string[] memory, uint[] memory) {
        uint[] memory votos = new uint[](candidatos.length);
        for(uint i = 0; i < candidatos.length; i++){
            votos[i] = votos_candidato[candidatos[i]];
        }
        return (candidatos, votos);
    }

    function ganador() public view returns(string memory) {
        string memory nombreGanador = candidatos[0];
        bool flag = false;

        for(uint i = 1; i < candidatos.length; i++){
            if(votos_candidato[nombreGanador] < votos_candidato[candidatos[i]]){
                nombreGanador = candidatos[i];
                flag = false;
            } else if(votos_candidato[nombreGanador] == votos_candidato[candidatos[i]]){
                flag = true;
            }
        }

        if(flag){
            return "Hay empate entre los candidatos";
        }
        return nombreGanador;
    }
}
