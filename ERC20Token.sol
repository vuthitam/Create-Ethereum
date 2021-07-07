pragma solidity ^0.8.3;

contract createERC20Token {
    mapping(address => address[]) UserToken;
    function createERC20(uint _totalSupply, string memory _name, string memory _symbol) public {
        ERC20Token token = new ERC20Token(_totalSupply, _name, _symbol);
        UserToken[tx.origin].push(address(token));
    }
    function viewMyToken() public view returns(address[] memory){
        return UserToken[msg.sender];
    }
}

contract ERC20Token {
    uint public totalSupply;
    string public name;
    string public symbol;
    uint public decimals = 18;
    mapping (address => uint) public balances;
    mapping (address => mapping(address => uint)) public allowance;
    
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
    
    constructor(uint _totalSupply, string memory _name, string memory _symbol) {
        totalSupply = _totalSupply *10 ** 18;
        name = _name;
        symbol = _symbol;
        balances[tx.origin] = totalSupply;
    }
    function balanceOf(address owner) public view returns(uint) {
        return balances[owner];
    } 
    function TotalSupply() public view returns(uint) {
        return totalSupply;
    }
    function transfer(address to, uint value) public returns(bool) {
        require(balances[msg.sender] >= value, 'Not Enough Balance' );
        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(msg.sender, to , value);
        return true; 
    }
    function approve(address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balances[from] >= value, 'not enough balance');
        require(allowance[from][msg.sender] >= value, 'not enough allowance balance');
        balances[from] -= value;
        balances[to] += value;
        emit Transfer(from, to , value);
        return true;
    }

    
}
