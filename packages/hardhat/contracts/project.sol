// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MiToken {
    string public nombre = "MiToken";
    string public símbolo = "MTK";
    uint256 public decimal = 18;
    uint256 public suministroTotal;

    mapping(address => uint256) public saldos;

    event Transfer(address indexed remitente, address indexed destinatario, uint256 cantidad);

    constructor(uint256 _suministroInicial) {
        suministroTotal = _suministroInicial * (10**decimal);
        saldos[msg.sender] = suministroTotal;
    }

    function enviar(address destinatario, uint256 cantidad) external {
        require(destinatario != address(0), "La dirección del destinatario no puede ser 0x0");
        require(cantidad <= saldos[msg.sender], "Fondos insuficientes");

        saldos[msg.sender] -= cantidad;
        saldos[destinatario] += cantidad;

        emit Transfer(msg.sender, destinatario, cantidad);
    }

    function consultarSaldo(address cuenta) external view returns (uint256) {
        return saldos[cuenta];
    }
}
