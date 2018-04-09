pragma solidity ^0.4.10;

contract LVToken {
    string public constant name = "Lives One Token";
    string public constant symbol = "LVT";
    uint public constant decimals = 18;
    string public constant version = "1.0";

    mapping (address => uint) balances;
    mapping (address => mapping (address => uint)) allowed;
    uint public totalSupply = 28 * (10**9) * 10**decimals;

    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);

    function LVToken() public {
      balances[0xd5a375Dd13abEF145B8183E6C2380BC777614395] = 28 * (10**8) * 10**decimals;              //team, 10%
      balances[0x22164b69c71DcF12E1dc037BB43933449f342a69] = 140 * (10**8) * 10**decimals;             //miner, 50%
      balances[0xBDC44A4EA8A9640ee5DcF2E0425d7A262C830c62] = 56 * (10**8) * 10**decimals;              //pre-ico, 20%
      balances[0x32A3A725895F1BdcFC1FEf8340f9f26d49Af60ab] = 56 * (10**8) * 10**decimals;              //organization, 20%
    }

    function transfer(address _to, uint _value) public returns (bool success) {
      if (balances[msg.sender] >= _value && _value > 0) {
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
      } else {
        return false;
      }
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool success) {
      if (balances[_from] >= _value && allowed[_from][msg.sender] >= _value && _value > 0) {
        balances[_to] += _value;
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
      } else {
        return false;
      }
    }

    function balanceOf(address _owner) view public returns (uint balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) view public returns (uint remaining) {
      return allowed[_owner][_spender];
    }
}
