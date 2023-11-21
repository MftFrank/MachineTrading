function [emitted] = swapTokenForToken(tokenIn,tokenOut,amountIn,slippage)
%This function is for approving an address to spend amount of token held by the wallet associated with the key you provide. 

%Syntax example:
% tokenIn = '0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2'; %token to spend
% tokenOut = '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48'; %token to buy
% amountIn = 10000000000; %amount of tokenIn to spend
% slippage = 0.04; %Percentage in decimal form (0.04 = 4%) - max tolerated price movement. Warning: MEV bots will frontrun your transaction if set too high.

%Use the following line of code to set the path to your python environment
%pyenv("Version","C:\Users\[Emil]\miniconda3\python.exe") %<- Set python environment to miniconda

if count(py.sys.path,'') == 0
    insert(py.sys.path,int32(0),'');
end

mod = py.importlib.import_module('UniswapV2');
py.importlib.reload(mod);
    deadline = 60; %number of seconds that the transaction will be allowed to be pending
    gasPrice = getGasPrice('safe');
    account = '0x830BBe006X2Xd0a4c815X9xBx193515x1c4B06xx'; %address of your wallet that will spend tokenIn and recieve tokenOut pay for transaction
    infura_url = 'https://mainnet.infura.io/v3/60xx82859xx54x608x7x83x0x70xx387'; %infura url complete with infura private key
    key = '0x817065cxxxde3778x72d3705xxxxx603a12363x951cd8346xxx27615f7xxxfxx'; %your wallet's private key
emitted = py.UniswapV2.swapTokenForToken(tokenIn,tokenOut,amountIn,slippage,deadline,gasPrice,account,infura_url,key);


end