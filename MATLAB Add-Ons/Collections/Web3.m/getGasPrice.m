function [gwei] = getGasPrice(type)
%This function fetches the current gas price of the ethereum network for
%different transaction speed types
%Syntax: type = 'safe' / 'proposed' / 'fast' 

call = ['https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=XXCXYT8X76XEZJXXXXXUP8XXX9XXXXQXX'];
options = weboptions('Timeout', 30);
ans = webread(call,options);

SafeGasPrice = ans.result.SafeGasPrice;
ProposeGasPrice = ans.result.ProposeGasPrice;
FastGasPrice = ans.result.FastGasPrice;
suggestBaseFee = ans.result.suggestBaseFee;
gasUsedRatio = ans.result.gasUsedRatio;

switch type
    case 'safe'
        gwei = SafeGasPrice;
    case 'proposed'
        gwei = ProposeGasPrice;
    case 'fast'
        gwei = FastGasPrice;
    otherwise
        disp('error, input variable not specified correct')
end


end