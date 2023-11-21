function [emitted] = approve(token,spender,amount)
%This function is for approving an address to spend amount of token held by the wallet associated with the key you provide. 

%Syntax example: 
%token = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'; %token to approve
%spender = '0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D'; %spender's address
%amount = 10000000000; %amount to approve (amount of tokenIn * 10^decimals, check the tokenIn smart contract for number of decimals)

%Use the following line of code to set the path to your python environment
%pyenv("Version","C:\Users\[Emil]\miniconda3\python.exe") %<- Set python environment to miniconda

if count(py.sys.path,'') == 0
    insert(py.sys.path,int32(0),'');
end

mod = py.importlib.import_module('UniswapV2');
py.importlib.reload(mod);
    gasPrice = getGasPrice('safe');
    account = '0x830BBe006C2Ed0a4c815C9dBd193515e1c4B06cd'; %address of your wallet that holds the tokens to approve and will pay for the transaction
    infura_url = 'https://mainnet.infura.io/v3/60xx82859xx54x608x7x83x0x70xx387'; %infura url complete with infura private key
    key = '0x817065cxxxde3778x72d3705xxxxx603a12363x951cd8346xxx27615f7xxxfxx'; %your wallet's private key
    abi = ... %token contract (json) abi fetched from etherscan
    '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"guy","type":"address"},{"name":"wad","type":"uint256"}],"name":"approve","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"src","type":"address"},{"name":"dst","type":"address"},{"name":"wad","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"wad","type":"uint256"}],"name":"withdraw","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"dst","type":"address"},{"name":"wad","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"deposit","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"},{"name":"","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[{"indexed":true,"name":"src","type":"address"},{"indexed":true,"name":"guy","type":"address"},{"indexed":false,"name":"wad","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"src","type":"address"},{"indexed":true,"name":"dst","type":"address"},{"indexed":false,"name":"wad","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"dst","type":"address"},{"indexed":false,"name":"wad","type":"uint256"}],"name":"Deposit","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"src","type":"address"},{"indexed":false,"name":"wad","type":"uint256"}],"name":"Withdrawal","type":"event"}]';
emitted = py.UniswapV2.approve(token,spender,amount,gasPrice,account,infura_url,key,abi);

end