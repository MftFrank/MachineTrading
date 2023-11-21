function [amountOut] = amountOut(tokenIn,tokenOut,amountIn)
%This function is for getting the corresponding output amount when swapping
%amountIn of tokenIn for tokenOut. 

%Syntax example: 
%tokenIn = '0x.....' (erc20 address in correct hex form)
%tokenOut = '0x.....' (erc20 address in correct hex form)
%amountIn = 100000 (amount of tokenIn * 10^decimals, check the tokenIn smart contract for number of decimals)

%Use the following line of code to set the path to your python environment
%pyenv("Version","C:\Users\[Emil]\miniconda3\python.exe") %<- Set python environment to miniconda

if count(py.sys.path,'') == 0
    insert(py.sys.path,int32(0),'');
end

mod = py.importlib.import_module('UniswapV2');
py.importlib.reload(mod);
    infura_url = 'https://mainnet.infura.io/v3/60xx82859xx54x608x7x83x0x70xx387'; %infura url complete with infura private key
amountOut = py.UniswapV2.amountOut(tokenIn,tokenOut,amountIn,infura_url);
end