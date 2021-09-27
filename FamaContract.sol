pragma solidity >=0.7.0 <0.9.0;

contract Fama {
    
    
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
    event Transfer(address indexed from, address indexed to, uint tokens);
 
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    
    uint256 private _totalSupply;
    
    mapping (address => uint256) private balances;
    mapping(address => mapping (address => uint256)) allowed;
    
    constructor() {
        _name = "famous";
        _symbol = "FAMA";
        _decimals = 18;
        
        _totalSupply = 42000;
        
        balances[msg.sender] = _totalSupply;
    }
    
    
    function name() public view returns (string memory){
        return _name;
    }
    
    function symbol() public view returns (string memory){
        return _symbol;
    }
    
    function decimals() public view returns (uint8){
        return _decimals;
    }
    
    function totalSupply() public view returns (uint256){
        return _totalSupply;
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance){
        return balances[_owner];
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balances[msg.sender] >= _value, "Error: insufficient funds");
        
        require(_to != address(0), "Error: To is null address");
        
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        
        return true;
        
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success){
        require(balances[_from] >= _value, "Error: insufficient funds");
        require(allowed[_from][msg.sender] >= _value, "Error: insufficient allocation");
        
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        
        balances[_to] += _value;
        
        return true;
        
    }
    
    
    function approve(address _spender, uint256 _value) public returns (bool success){
        require(_value <= balances[msg.sender],  "Error: insufficient funds");
        allowed[msg.sender][_spender] = _value;
        return true;
        
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return allowed[_owner][_spender];
    }
}
