% This is the main display for the stock we choose.
% We also need to pass in the four indicators.

function mainwindow(onestock,ind1,ind2,ind3,ind4,startdate,enddate)

% close all;
figure;

% We configure the separate windows here.

panel1 = uipanel('Parent',gcf);
panel2 = uipanel('Parent',panel1);
set(panel1,'Position',[0 0 0.99 1]);
set(panel2,'Position',[0 -0.5 1 1.5]);
set(gca,'Parent',panel2);
s = uicontrol('Style','Slider','Parent',gcf,...
'Units','normalized','Position',[0.98 0 0.02 1],...
'Value',1,'Callback',{@slider_callback1,panel2});
set(panel2,'Position',[0 -1 1 2]);

function slider_callback1(src,eventdata,arg1)
    val = get(src,'Value');
    set(arg1,'Position',[0 -val 1 2]);
end


s1 = onestock; s2 = onestock;

% Reverse s2 if we need it to be reversed.
for (i = 1:length(s2))
    temp(length(s2)-i+1,:) = s2(i,:); 
end
s2 = temp;
whatname = inputname(1);

stockname = 'Sample'

switch whatname
    case {'one'}
        stockname = 'CREATIVE';
    case {'two'}
        stockname = 'DBS';
    case {'three'}
        stockname = 'F&N';    
    case {'four'}
        stockname = 'KEPCORP';
    case {'five'}
        stockname = 'KIMENG';
    case {'six'}
        stockname = 'OSIM';
    case {'seven'}
        stockname = 'SIA';
    case {'eight'}
        stockname = 'SPH';
    case {'nine'}
        stockname = 'STARHUB';
    case {'ten'}
        stockname = 'UOB';
    case {'eleven'}
        stockname = 'UOL';
    case {'twelve'}
        stockname = 'WILMAR';
    case {'NewData'}
        stockname = 'Sample';

end

% Look all the default parameters.
ma_x = 9; ma_y = 9;
stoc_look = 14; stoc_x = 3; stoc_y = 3;
macd_x = 12; macd_y = 26; macd_w = 9;
rsi_x = 14;
rsi_ent = 20; rsi_ext = 80;
ent = 20; ext1 = 80; ext2 = 60;
short_ma = 20; long_ma = 50;

bol_per = 20; bol_mul = 1;
curwin = 0;     % Tell us what our current window is.
set(gcf,'Position',[20 500 1400 800]);

% Display the start and end date.
temps = [num2str( ( startdate - rem(startdate,10000) ) / 10000 ) '/' num2str( ( rem(startdate,10000) - rem(startdate,100) ) / 100 ) ...
    '/' num2str(rem(startdate,100))];
    
tempe = [num2str( ( enddate - rem(enddate,10000) ) / 10000 ) '/' num2str( ( rem(enddate,10000) - rem(enddate,100) ) / 100 ) ...
    '/' num2str(rem(enddate,100))];

dalabel = uicontrol(gcf,'style','text','String',[temps ' to ' tempe],'Position',[0.83 0.86 0.15 0.05],'Units','normalized',...
    'FontName','Monaco','FontSize',12)

% set(gcf,'Position',[0.1 0.1 0.5 0.5],'Units','normalized');

sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
% We have to draw the stock.
drawcand(s1);
title(strcat('Stock:',stockname),'FontSize',10);

% We plot the moving averages indicator.
hold on;

%% 


% We import the WHOLE simple moving average function.

int = 4;

% Form a new matrix.
for (i = ma_x:length(s2))
    tot = 0;
    for (j = i-ma_x+1:i)
        tot = tot + s2(j,int);
    end
        
    MAVG(i) = ( tot / ma_x );
        
end

xaxis = [ma_x:length(MAVG)];
MAVG(1:ma_x-1) = [];
smaplot = plot(xaxis,MAVG,'LineWidth',1,'Color',[0.8 0.1 0.1]);
grid on;



% We import the WHOLE exponential moving average function.

    tot = 0;
    for (i = 1:ma_y)
        tot = tot + s2(i);
        EAVG(ma_y) = (tot / ma_y );
    end
    
    % Calculate the multiplier.
    mul = (2 / (ma_y + 1) );
   
    % Form the Exponential moving average matrix.
    for (i = ma_y+1:length(s2))
       EAVG(i) = ( s2(i,4) - EAVG(i-1) ) * mul + EAVG(i-1);         
    end

    xaxis = [ma_y:length(EAVG)];
    EAVGorig = EAVG;
    EAVG(1:ma_y - 1) = [];
    emaplot = plot(xaxis,EAVG,'LineWidth',1,'Color',[0.3 0.1 0.8]);
    grid on;


% We import the WHOLE Bollinger band function here.

int = 4;
    

    
    % Now calculate the 20-day mean.
    
    
    for (i = bol_per:length(s2))
    % The loop to start the standard deviation matrix starts here.    
            
        % First get the mean.
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,4);
        end
        mean = tot / bol_per;
    
        clear dev;
        % Now we get the deviation.
        for (j = i-bol_per+1:i)
            dev(j) = s2(j,4) - mean;
        end
        
        % Square the deviation.
        dev2 = dev.^2;
        sdmat(i) = sqrt(sum(dev2) / bol_per);
    
    end

    % For our Bollinger band, we want to calculate the matrix for SMA.
    
    for (i = bol_per:length(s2))
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,int);
        end
        SMA(i) = ( tot / bol_per );
        
    end
    
    UPPER1 = SMA + (sdmat * bol_mul);
    UPPER2 = SMA + (sdmat * (bol_mul+1));
    LOWER1 = SMA - (sdmat * bol_mul);
    LOWER2 = SMA - (sdmat * (bol_mul+1));
    xaxis = [1:length(SMA)];
    hold on;
    bolband(1) = plot(xaxis,SMA,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');  
    bolband(2) = plot(xaxis,UPPER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(3) = plot(xaxis,LOWER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(4) = plot(xaxis,UPPER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(5) = plot(xaxis,LOWER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    hold off;

    grid on;






hold off;





sdisplay(2) = subplot(5,5,[11:14],'position',[0.05 0.41 0.6 0.19],'xticklabel',[],'Box','on');
%%
% We draw the stochastic indicator.
STR = stoc(s2,stoc_look,stoc_x,stoc_y,ent,ext1,ext2);

%title(strcat(stockname,' with Stochastic Indicator(',...
%        num2str(stoc_look),',',num2str(stoc_x),',',num2str(stoc_y),')'),'FontSize',10);
    
% Buttons for stochastic indicator.

stoc_para = uibuttongroup('Parent',gcf,'Title','Parameters of Stochastic Indicator',...
        'BackgroundColor',[0.8 0.8 0.8],'FontName','Monaco','FontSize',8,... 
        'Position',[.65 .42 .15 .15]);
    
stoc_lookback = uicontrol(stoc_para,'style','text','Position',[0.06 0.7 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['Stoc period:' num2str(stoc_look)],'FontName','Monaco','FontSize',8);

stoc_lookslide = uicontrol(stoc_para,'Style', 'slider','Min',1,'Max',30,'Value',stoc_look,'SliderStep',[(1/29) (1/29)],...
    'Callback',@stoc_slid,'FontName','Monaco','Position',[0.55,0.8,0.4,0.1],'Units','normalized');

function stoc_slid(src,evt)
    
    slidvalue = get(stoc_lookslide,'value');
    set(stoc_lookback,'String',['Stoc period:' num2str(slidvalue)]);
    stoc_look = slidvalue;
    

    if (curwin ~= 2)
       sdisplay(2) = subplot(5,5,[11:14],'position',[0.05 0.41 0.6 0.19],'xticklabel',[],'Box','on'); 
    end
    
    % subplot(9,10,[51:56 61:66 71:76 81:86]);
    cla(sdisplay(2));
    STR = stoc(s2,stoc_look,stoc_x,stoc_y,ent,ext1,ext2);
    %title(strcat(stockname,' with Stochastic Indicator(',...
    %    num2str(stoc_look),',',num2str(stoc_x),',',num2str(stoc_y),')'),'FontSize',10);
    current = 0; pnl = 0;
    for (i = 1:length(STR(:,1)))
        if ( STR(i,2) > 0 )
        current = s2(STR(i,2),4) - s2(STR(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxstoc,'String',sprintf('%0.2f',pnl));
    curwin = 2;
    
end

stoc_SMAFast = uicontrol(stoc_para,'style','text','Position',[0.03 0.5 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['x-T Fast %K:' num2str(stoc_x)],'FontName','Monaco','FontSize',8);

stoc_Fastslide = uicontrol(stoc_para,'Style', 'slider','Min',1,'Max',10,'Value',stoc_x,'SliderStep',[(1/9) (1/9)],...
    'Callback',@stoc_fastslid,'FontName','Monaco','Position',[0.55,0.6,0.4,0.1],'Units','normalized');

function stoc_fastslid(src,evt)
    slidvalue = get(stoc_Fastslide,'value');
    set(stoc_SMAFast,'String',['x-T Fast %K:' num2str(slidvalue)]);
    stoc_x = slidvalue;
    
    if (curwin ~= 2)
       sdisplay(2) = subplot(5,5,[11:14],'position',[0.05 0.41 0.6 0.19],'xticklabel',[],'Box','on'); 
    end

    % We now redraw the graphs.
    % subplot(9,10,[51:56 61:66 71:76 81:86]);
    cla(sdisplay(2));
    STR = stoc(s2,stoc_look,stoc_x,stoc_y,ent,ext1,ext2);
    %title(strcat(stockname,' with Stochastic Indicator(',...
    %    num2str(stoc_look),',',num2str(stoc_x),',',num2str(stoc_y),')'),'FontSize',10);
    current = 0; pnl = 0;
    for (i = 1:length(STR(:,1)))
        if ( STR(i,2) > 0 )
        current = s2(STR(i,2),4) - s2(STR(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxstoc,'String',sprintf('%0.2f',pnl));
    curwin = 2;
    
end

stoc_SMAFull = uicontrol(stoc_para,'style','text','Position',[0.03 0.3 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['x-T Full %K:' num2str(stoc_y)],'FontName','Monaco','FontSize',8);

stoc_Fullslide = uicontrol(stoc_para,'Style', 'slider','Min',1,'Max',10,'Value',stoc_y,'SliderStep',[(1/9) (1/9)],...
    'Callback',@stoc_fullslid,'FontName','Monaco','Position',[0.55,0.4,0.4,0.1],'Units','normalized');

function stoc_fullslid(src,evt)

    slidvalue = get(stoc_Fullslide,'value');
    set(stoc_SMAFull,'String',['x-T Full %K:' num2str(slidvalue)]);
    stoc_y = slidvalue;
    
    if (curwin ~= 2)
       sdisplay(2) = subplot(5,5,[11:14],'position',[0.05 0.41 0.6 0.19],'xticklabel',[],'Box','on');
    end
    
    % We now redraw the graphs.
    cla(sdisplay(2));
    STR = stoc(s2,stoc_look,stoc_x,stoc_y,ent,ext1,ext2);
    %title(strcat(stockname,' with Stochastic Indicator(',...
    %    num2str(stoc_look),',',num2str(stoc_x),',',num2str(stoc_y),')'),'FontSize',10);
    current = 0; pnl = 0;
    for (i = 1:length(STR(:,1)))
        if ( STR(i,2) > 0 )
        current = s2(STR(i,2),4) - s2(STR(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxstoc,'String',sprintf('%0.2f',pnl));
    curwin = 2;
    
end

% For the stochastic indicator STRATEGY.
% We initialize the variables here.

stocstra_para = uibuttongroup('Parent',gcf,'Title','Parameters of Stoc Strategy',...
        'BackgroundColor',[0.8 0.8 0.8],'FontName','Monaco','FontSize',8,... 
        'Position',[.82 .42 .16 .15]);
    
enter = uicontrol(stocstra_para,'style','text','Position',[0.04 0.7 0.35 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String','Enter');

enterval = uicontrol(stocstra_para,'style','text','Position',[0.40 0.7 0.1 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String',[num2str(ent) '%']);

entslide = uicontrol(stocstra_para,'Style', 'slider','Min',1,'Max',100,'Value',ent,'SliderStep',[(1/99) (1/99)],...
    'Callback',@entfunc,'FontName','Monaco','Position',[0.55,0.8,0.4,0.1],'Units','normalized');

check = uicontrol(stocstra_para,'style','text','Position',[0.04 0.5 0.35 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String','Check');

checkval = uicontrol(stocstra_para,'style','text','Position',[0.40 0.5 0.1 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String',[num2str(ext1) '%']);

chkslide = uicontrol(stocstra_para,'Style', 'slider','Min',1,'Max',100,'Value',ext1,'SliderStep',[(1/99) (1/99)],...
    'Callback',@chkfunc,'FontName','Monaco','Position',[0.55,0.6,0.4,0.1],'Units','normalized');

exit = uicontrol(stocstra_para,'style','text','Position',[0.04 0.3 0.35 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String','Exit');

exitval = uicontrol(stocstra_para,'style','text','Position',[0.40 0.3 0.1 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String',[num2str(ext2) '%']);

extslide = uicontrol(stocstra_para,'Style', 'slider','Min',1,'Max',100,'Value',ext2,'SliderStep',[(1/99) (1/99)],...
    'Callback',@extfunc,'FontName','Monaco','Position',[0.55,0.4,0.4,0.1],'Units','normalized');    

% Our Call back functions for the stochastic strategy.
% All our callback functions.
function entfunc(src,evt)
    
    if (curwin ~= 2)
       sdisplay(2) = subplot(5,5,[11:14],'position',[0.05 0.41 0.6 0.19],'xticklabel',[],'Box','on');
    end
    
    slidvalue = get(entslide,'value');
    set(enterval,'String',[num2str(slidvalue) '%']);
    ent = slidvalue;
    
    % We now redraw the graphs.
    % subplot(9,10,[51:56 61:66 71:76 81:86]);
    cla(sdisplay(2));
    STR = stoc(s2,stoc_look,stoc_x,stoc_y,ent,ext1,ext2);

    %{
    subplot(9,10,[1:6 11:16 21:26 31:36]);
    cla(sdisplay2);
    drawcandstoc(s2,STR);
    title(strcat('Stock Chart:',stockname),'FontSize',10);
    %}
    current = 0; pnl = 0;
    for (i = 1:length(STR(:,1)))
        if ( STR(i,2) > 0 )
        current = s2(STR(i,2),4) - s2(STR(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxstoc,'String',sprintf('%0.2f',pnl));
    curwin = 2;
end

function chkfunc(src,evt)
    
    if (curwin ~= 2)
       sdisplay(2) = subplot(5,5,[11:14],'position',[0.05 0.41 0.6 0.19],'xticklabel',[],'Box','on');
    end
    
    slidvalue = get(chkslide,'value');
    set(checkval,'String',[num2str(slidvalue) '%']);
    ext1 = slidvalue;
    
    % We now redraw the graphs.
    % subplot(9,10,[51:56 61:66 71:76 81:86]);
    cla(sdisplay(2));
    STR = stoc(s2,stoc_look,stoc_x,stoc_y,ent,ext1,ext2);

    
    %{
    subplot(9,10,[1:6 11:16 21:26 31:36]);
    cla(sdisplay2);
    drawcandstoc(s2,STR);
    title(strcat('Stock Chart:',stockname),'FontSize',10);
    %}

    current = 0; pnl = 0;
    for (i = 1:length(STR(:,1)))
        if ( STR(i,2) > 0 )
        current = s2(STR(i,2),4) - s2(STR(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxstoc,'String',sprintf('%0.2f',pnl));
    curwin = 2;
end

function extfunc(src,evt)
    
    if (curwin ~= 2)
       sdisplay(2) = subplot(5,5,[11:14],'position',[0.05 0.41 0.6 0.19],'xticklabel',[],'Box','on');
    end
    
    slidvalue = get(extslide,'value');
    set(exitval,'String',[num2str(slidvalue) '%']);
    ext2 = slidvalue;
    
    % We now redraw the graphs.
    % subplot(9,10,[51:56 61:66 71:76 81:86]);
    cla(sdisplay(2));
    STR = stoc(s2,stoc_look,stoc_x,stoc_y,ent,ext1,ext2);

    %{
    subplot(9,10,[1:6 11:16 21:26 31:36]);
    cla(sdisplay2);
    drawcandstoc(s2,STR);
    title(strcat('Stock Chart:',stockname),'FontSize',10);
    %}
    current = 0; pnl = 0;
    for (i = 1:length(STR(:,1)))
        if ( STR(i,2) > 0 )
        current = s2(STR(i,2),4) - s2(STR(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxstoc,'String',sprintf('%0.2f',pnl));
    
    curwin = 2;
end

% The pnl calculations for the stochastic indicator here.

pnlbutstoc = uibuttongroup('Parent',gcf,'Title','Stoc PnL',...
        'BackgroundColor',[1 1 1],'FontName','Monaco','FontSize',8,... 
        'Position',[.82 .15 .07 .07]);
pnlboxstoc = uicontrol('Parent',pnlbutstoc,'style','text','Position',[0.05 0.05 1 1],'Units','normalized','BackgroundColor',[1 1 1]);
    set(pnlboxstoc,'String','Nil');
    set(pnlboxstoc,'Units','characters','FontName','Monaco','FontSize',16);
    
stoc_opt = uicontrol('Parent',gcf,'style','pushbutton','Position',[.82 .07 .07 .07],...
    'String','Stoc Optimize','Units','normalized','BackgroundColor',[1 1 1],'FontName','Monaco');
    
% Calculate Stoc profit.
current = 0; pnl = 0;
    for (i = 1:length(STR(:,1)))
        if ( STR(i,2) > 0 )
        current = s2(STR(i,2),4) - s2(STR(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxstoc,'String',sprintf('%0.2f',pnl));




% We draw the MACD indicator.


sdisplay(3) = subplot(5,5,[16:19],'position',[0.05 0.24 0.6 0.17],'xticklabel',[],'Box','on');

STR_M = MACDfunc(s2,macd_x,macd_y,macd_w);
%title(strcat(stockname,' with MACD Indicator(',...
%        num2str(macd_x),',',num2str(macd_y),',',num2str(macd_w),')'),'Font
%        Size',10);

% Buttons for our MACD indicator.

macd_para = uibuttongroup('Parent',gcf,'Title','Parameters of MACD Indicator',...
        'BackgroundColor',[0.8 0.8 0.8],'FontName','Monaco','FontSize',8,... 
        'Position',[.65 .24 .15 .15]);
    
macd_lookback = uicontrol(macd_para,'style','text','Position',[0.06 0.7 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['x-day Short:' num2str(stoc_look)],'FontName','Monaco','FontSize',8);

macd_lookslide = uicontrol(macd_para,'Style', 'slider','Min',1,'Max',30,'Value',stoc_look,'SliderStep',[(1/29) (1/29)],...
    'Callback',@macd_slid,'FontName','Monaco','Position',[0.55,0.8,0.4,0.1],'Units','normalized');
    
function macd_slid(src,evt)
    slidvalue = get(macd_lookslide,'value');
    set(macd_lookback,'String',['x-day Short:' num2str(slidvalue)]);
    macd_x = ceil(slidvalue);
    
    if (curwin ~= 3)
       sdisplay(3) = subplot(5,5,[16:19],'position',[0.05 0.24 0.6 0.17],'xticklabel',[],'Box','on');
    end
    
    cla(sdisplay(3));
    STR_M = MACDfunc(s2,macd_x,macd_y,macd_w);
    
    current = 0;
    pnl = 0;
    for (i = 1:length(STR_M(:,1)))
        if ( STR_M(i,2) > 0 )
        current = s2(STR_M(i,2),4) - s2(STR_M(i,1),4);
        pnl = pnl + current;
        pnl;
    end
    end
    set(pnlboxmacd,'String',sprintf('%0.2f',pnl));
    
    %title(strcat(stockname,' with MACD Indicator(',...
    %    num2str(macd_x),',',num2str(macd_y),',',num2str(macd_w),')'),'FontSize',10)
    curwin = 3;
end    
    
macd_SMAFast = uicontrol(macd_para,'style','text','Position',[0.06 0.5 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['x-day Long:' num2str(macd_y)],'FontName','Monaco','FontSize',8);

macd_Fastslide = uicontrol(macd_para,'Style', 'slider','Min',1,'Max',40,'Value',macd_y,'SliderStep',[(1/39) (1/39)],...
    'Callback',@macd_fastslid,'FontName','Monaco','Position',[0.55,0.6,0.4,0.1],'Units','normalized');

function macd_fastslid(src,evt)
    slidvalue = get(macd_Fastslide,'value');
    set(macd_SMAFast,'String',['x-day Long:' num2str(slidvalue)]);
    macd_y = slidvalue;

    if (curwin ~= 3)
       sdisplay(3) = subplot(5,5,[16:19],'position',[0.05 0.24 0.6 0.17],'xticklabel',[],'Box','on');
    end
    
    cla(sdisplay(3));
    STR_M = MACDfunc(s2,macd_x,macd_y,macd_w);
    
    current = 0;
    pnl = 0;
    for (i = 1:length(STR_M(:,1)))
        if ( STR_M(i,2) > 0 )
        current = s2(STR_M(i,2),4) - s2(STR_M(i,1),4);
        pnl = pnl + current;
        pnl;
    end
    end
    set(pnlboxmacd,'String',sprintf('%0.2f',pnl));
    
    %title(strcat(stockname,' with MACD Indicator(',...
    %    num2str(macd_x),',',num2str(macd_y),',',num2str(macd_w),')'),'FontSize',10)
    curwin = 3;
end    
   
macd_Sig = uicontrol(macd_para,'style','text','Position',[0.06 0.3 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['x-day Sig:' num2str(macd_w)],'FontName','Monaco','FontSize',8);

macd_Sigslide = uicontrol(macd_para,'Style', 'slider','Min',1,'Max',20,'Value',macd_w,'SliderStep',[(1/19) (1/19)],...
    'Callback',@macd_sig,'FontName','Monaco','Position',[0.55,0.4,0.4,0.1],'Units','normalized');

function macd_sig(src,evt)
    slidvalue = get(macd_Sigslide,'value');
    set(macd_Sig,'String',['x-day Sig:' num2str(slidvalue)]);
    macd_w = slidvalue;

    if (curwin ~= 3)
       sdisplay(3) = subplot(5,5,[16:19],'position',[0.05 0.24 0.6 0.17],'xticklabel',[],'Box','on');
    end
    
    cla(sdisplay(3));
    STR_M = MACDfunc(s2,macd_x,macd_y,macd_w);

    current = 0;
    pnl = 0;
    for (i = 1:length(STR_M(:,1)))
        if ( STR_M(i,2) > 0 )
        current = s2(STR_M(i,2),4) - s2(STR_M(i,1),4);
        pnl = pnl + current;
        pnl;
    end
    end
    set(pnlboxmacd,'String',sprintf('%0.2f',pnl));
    
    %title(strcat(stockname,' with MACD Indicator(',...
    %    num2str(macd_x),',',num2str(macd_y),',',num2str(macd_w),')'),'FontSize',10)
    curwin = 3;
end   

% The pnl calculations for the MACD indicator here.

pnlbutmacd = uibuttongroup('Parent',gcf,'Title','MACD PnL',...
        'BackgroundColor',[1 1 1],'FontName','Monaco','FontSize',8,... 
        'Position',[.9 .15 .07 .07]);
pnlboxmacd = uicontrol('Parent',pnlbutmacd,'style','text','Position',[0.05 0.05 0.9 0.9],'Units','normalized','BackgroundColor',[1 1 1]);
    set(pnlboxmacd,'String','Nil');
    set(pnlboxmacd,'Units','characters','FontName','Monaco','FontSize',16);
    
macd_opt = uicontrol('Parent',gcf,'style','pushbutton','Position',[.9 .07 .07 .07],...
    'String','MACD Optimize','Units','normalized','BackgroundColor',[1 1 1],'FontName','Monaco');
    
% Calculate MACD profit.
current = 0; pnl = 0;
    for (i = 1:length(STR_M(:,1)))
        if ( STR_M(i,2) > 0 )
        current = s2(STR_M(i,2),4) - s2(STR_M(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxmacd,'String',sprintf('%0.2f',pnl));  


% We draw the RSI indicator.
sdisplay(4) = subplot(5,5,[21:24],'position',[0.05 0.04 0.6 0.2],'Box','on');
STR_R = RSIfunc(s2,rsi_x,rsi_ent,rsi_ext);

rsi_para = uibuttongroup('Parent',gcf,'Title','Parameters of RSI Ind / Strat',...
        'BackgroundColor',[0.8 0.8 0.8],'FontName','Monaco','FontSize',8,... 
        'Position',[.82 .24 .15 .15]);
    
rsi_lookback = uicontrol(rsi_para,'style','text','Position',[0.06 0.7 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['Lookback:' num2str(stoc_look)],'FontName','Monaco','FontSize',8);

rsi_lookslide = uicontrol(rsi_para,'Style', 'slider','Min',1,'Max',30,'Value',stoc_look,'SliderStep',[(1/29) (1/29)],...
    'Callback',@rsi_slid,'FontName','Monaco','Position',[0.55,0.8,0.4,0.1],'Units','normalized');





rsi_enter = uicontrol(rsi_para,'style','text','Position',[0.04 0.5 0.35 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String','Enter');

rsi_enterval = uicontrol(rsi_para,'style','text','Position',[0.40 0.5 0.1 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String',[num2str(rsi_ent) '%']);

rsi_entslide = uicontrol(rsi_para,'Style', 'slider','Min',1,'Max',100,'Value',rsi_ent,'SliderStep',[(1/99) (1/99)],...
    'Callback',@rsi_entfunc,'FontName','Monaco','Position',[0.55,0.6,0.4,0.1],'Units','normalized');

rsi_exit = uicontrol(rsi_para,'style','text','Position',[0.04 0.3 0.35 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String','Exit');

rsi_exitval = uicontrol(rsi_para,'style','text','Position',[0.40 0.3 0.1 0.2],'Units','normalized',...
    'FontName','Monaco','BackgroundColor',[0.85 0.85 0.85],'FontSize',8,...
    'String',[num2str(rsi_ext) '%']);

rsi_extslide = uicontrol(rsi_para,'Style', 'slider','Min',1,'Max',100,'Value',rsi_ext,'SliderStep',[(1/99) (1/99)],...
    'Callback',@rsi_extfunc,'FontName','Monaco','Position',[0.55,0.4,0.4,0.1],'Units','normalized');


function rsi_entfunc(src,evt)
    
    slidvalue = get(rsi_entslide,'value');
    set(rsi_enterval,'String',[num2str(slidvalue) '%']);
    rsi_ent = ceil(slidvalue);
    
    if (curwin ~= 4)
       sdisplay(4) = subplot(5,5,[21:24],'position',[0.05 0.04 0.6 0.2],'Box','on');
    end
    
    cla(sdisplay(4));
    STR_R = RSIfunc(s2,rsi_x,rsi_ent,rsi_ext);
   
    % Calculate RSI profit.
    current = 0; pnl = 0;
    for (i = 1:length(STR_R(:,1)))
        if ( STR_R(i,2) > 0 )
        current = s2(STR_R(i,2),4) - s2(STR_R(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxrsi,'String',sprintf('%0.2f',pnl));
    
    curwin = 4;
    
end

function rsi_extfunc(src,evt)
    
    slidvalue = get(rsi_extslide,'value');
    set(rsi_exitval,'String',[num2str(slidvalue) '%']);
    rsi_ext = ceil(slidvalue);
    
    if (curwin ~= 4)
       sdisplay(4) = subplot(5,5,[21:24],'position',[0.05 0.04 0.6 0.2],'Box','on');
    end
    
    cla(sdisplay(4));
    STR_R = RSIfunc(s2,rsi_x,rsi_ent,rsi_ext);
    
    
    % Calculate RSI profit.
    current = 0; pnl = 0;
    for (i = 1:length(STR_R(:,1)))
        if ( STR_R(i,2) > 0 )
        current = s2(STR_R(i,2),4) - s2(STR_R(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxrsi,'String',sprintf('%0.2f',pnl)); 
    
    curwin = 4;
end

function rsi_slid(src,evt)
    slidvalue = get(rsi_lookslide,'value');
    set(rsi_lookback,'String',['Lookback:' num2str(slidvalue)]);
    rsi_x = ceil(slidvalue);
    
    if (curwin ~= 4)
       sdisplay(4) = subplot(5,5,[21:24],'position',[0.05 0.04 0.6 0.2],'Box','on');
    end
    
    cla(sdisplay(4));
    STR_R = RSIfunc(s2,rsi_x,rsi_ent,rsi_ext);
    
    
    % Calculate RSI profit.
    current = 0; pnl = 0;
    for (i = 1:length(STR_R(:,1)))
        if ( STR_R(i,2) > 0 )
        current = s2(STR_R(i,2),4) - s2(STR_R(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxrsi,'String',sprintf('%0.2f',pnl)); 
    
    curwin = 4;
end   

% The profit and loss for the RSI indicator.
pnlbutrsi = uibuttongroup('Parent',gcf,'Title','RSI PnL',...
        'BackgroundColor',[1 1 1],'FontName','Monaco','FontSize',8,... 
        'Position',[.74 .15 .07 .07]);
pnlboxrsi = uicontrol('Parent',pnlbutrsi,'style','text','Position',[0.05 0.05 0.9 0.9],'Units','normalized','BackgroundColor',[1 1 1]);
    set(pnlboxrsi,'String','Nil');
    set(pnlboxrsi,'Units','characters','FontName','Monaco','FontSize',16);
    
rsi_opt = uicontrol('Parent',gcf,'style','pushbutton','Position',[.74 .07 .07 .07],...
    'String','RSI Optimize','Units','normalized','BackgroundColor',[1 1 1],'FontName','Monaco');

% Calculate RSI profit.
current = 0; pnl = 0;
    for (i = 1:length(STR_R(:,1)))
        if ( STR_R(i,2) > 0 )
        current = s2(STR_R(i,2),4) - s2(STR_R(i,1),4);
        pnl = pnl + current;
        pnl;
        end
    end
    set(pnlboxrsi,'String',sprintf('%0.2f',pnl));  



%%    
% Buttons for moving average.


sma_para = uibuttongroup('Parent',gcf,'Title','Parameters of Moving averages',...
        'BackgroundColor',[0.8 0.8 0.8],'FontName','Monaco','FontSize',8,... 
        'Position',[.65 .78 .15 .15]);

sma_simple = uicontrol(sma_para,'style','text','Position',[0.06 0.7 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['SMA Period:' num2str(ma_x)],'FontName','Monaco','FontSize',8);

sma_simpleslide = uicontrol(sma_para,'Style', 'slider','Min',1,'Max',50,'Value',ma_x,'SliderStep',[(1/49) (1/49)],...
    'Callback',@sma_sslid,'FontName','Monaco','Position',[0.55,0.8,0.4,0.1],'Units','normalized');
    
% The callback function.
function sma_sslid(src,evt)
    
    slidvalue = get(sma_simpleslide,'value');
    set(sma_simple,'String',['SMA Period:' num2str(slidvalue)]);
    ma_x = ceil(slidvalue);
    

    % If not at current subplot, we make this the current subplot.
    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end

    cla(sdisplay(1));
    drawcand2(s1);
    
    for (i = ma_x:length(s2))
        tot = 0;
    for (j = i-ma_x+1:i)
        tot = tot + s2(j,int);
    end
        
    MAVG(i) = ( tot / ma_x );
        
    end

    xaxis = [ma_x:length(MAVG)];
    MAVG(1:ma_x-1) = [];
    hold on;
    smaplot = plot(xaxis,MAVG,'LineWidth',1,'Color',[0.8 0.1 0.1]);
    hold off;
    grid on;
    %set(gca,'position',[0.05 0.5 0.6 0.45],'xticklabel',[],'Box','on');
    linkaxes(sdisplay,'x');
    curwin = 1;
    
    % We then HAVE to plot all the others.
    hold on;
    
    EAVG = EAVGorig;
    xaxis2 = [ma_y:length(EAVG)];
    EAVG(1:ma_y - 1) = [];
    emaplot = plot(xaxis2,EAVG,'LineWidth',1,'Color',[0.3 0.1 0.8]);
    xaxis = [1:length(SMA)];
    bolband(1) = plot(xaxis,SMA,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');  
    bolband(2) = plot(xaxis,UPPER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(3) = plot(xaxis,LOWER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(4) = plot(xaxis,UPPER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(5) = plot(xaxis,LOWER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    
    hold off;
    
    
    
end     
    

ema_simple = uicontrol(sma_para,'style','text','Position',[0.06 0.5 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['EMA Period:' num2str(ma_y)],'FontName','Monaco','FontSize',8);

ema_eslide = uicontrol(sma_para,'Style', 'slider','Min',1,'Max',50,'Value',ma_y,'SliderStep',[(1/49) (1/49)],...
    'Callback',@ema_eslid,'FontName','Monaco','Position',[0.55,0.6,0.4,0.1],'Units','normalized');
    
function ema_eslid(src,evt)
    
    slidvalue = get(ema_eslide,'value');
    set(ema_simple,'String',['EMA Period:' num2str(slidvalue)]);
    ma_y = ceil(slidvalue);

    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    cla(sdisplay(1));
    drawcand2(s1);
    
    tot = 0;
    for (i = 1:ma_y)
        tot = tot + s2(i);
        EAVG(ma_y) = (tot / ma_y );
    end
    
    % Calculate the multiplier.
    mul = (2 / (ma_y + 1) );
   
    % Form the Exponential moving average matrix.
    for (i = ma_y+1:length(s2))
       EAVG(i) = ( s2(i,4) - EAVG(i-1) ) * mul + EAVG(i-1);         
    end

    xaxis = [ma_y:length(EAVG)];
    EAVGorig = EAVG;
    EAVG(1:ma_y - 1) = [];
    hold on;
    emaplot = plot(xaxis,EAVG,'LineWidth',1,'Color',[0.3 0.1 0.8]);
    hold off;
    grid on;
    %set(gca,'position',[0.05 0.5 0.6 0.45],'xticklabel',[],'Box','on');
    linkaxes(sdisplay,'x');
    curwin = 1;
    
    % We then HAVE to plot all the others.
    hold on;
    
    xaxis2 = [1:length(MAVG)]+ma_x-1;
    smaplot = plot(xaxis2,MAVG,'LineWidth',1,'Color',[0.8 0.1 0.1]);
    xaxis = [1:length(SMA)];
    bolband(1) = plot(xaxis,SMA,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');  
    bolband(2) = plot(xaxis,UPPER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(3) = plot(xaxis,LOWER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(4) = plot(xaxis,UPPER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband(5) = plot(xaxis,LOWER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    
    hold off;

end
    
% Buttons for Bollinger band.


bol_para = uibuttongroup('Parent',gcf,'Title','Parameters of Bollinger band',...
        'BackgroundColor',[0.8 0.8 0.8],'FontName','Monaco','FontSize',8,... 
        'Position',[.65 .6 .15 .15]);

bol_pertxt = uicontrol(bol_para,'style','text','Position',[0.06 0.5 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['Lookback:' num2str(bol_per)],'FontName','Monaco','FontSize',8);

bol_perslide = uicontrol(bol_para,'Style', 'slider','Min',1,'Max',50,'Value',bol_per,'SliderStep',[(1/49) (1/49)],...
    'Callback',@bol_pslid,'FontName','Monaco','Position',[0.55,0.6,0.4,0.1],'Units','normalized');
    
function bol_pslid(src,evt)
    
    slidvalue = get(bol_perslide,'value');
    set(bol_pertxt,'String',['Lookback:' num2str(slidvalue)]);
    bol_per = ceil(slidvalue);

    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    cla(sdisplay(1));
    drawcand2(s1);
    
    int = 4;
    

    
    % Now calculate the 20-day mean.
    
    
    for (i = bol_per:length(s2))
    % The loop to start the standard deviation matrix starts here.    
            
        % First get the mean.
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,4);
        end
        mean = tot / bol_per;
    
        clear dev;
        % Now we get the deviation.
        for (j = i-bol_per+1:i)
            dev(j) = s2(j,4) - mean;
        end
        
        % Square the deviation.
        dev2 = dev.^2;
        sdmat(i) = sqrt(sum(dev2) / bol_per);
    
    end

    % For our Bollinger band, we want to calculate the matrix for SMA.
    
    for (i = bol_per:length(s2))
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,int);
        end
        SMA(i) = ( tot / bol_per );
        
    end
    
    UPPER1 = SMA + (sdmat * bol_mul);
    UPPER2 = SMA + (sdmat * (bol_mul+1));
    LOWER1 = SMA - (sdmat * bol_mul);
    LOWER2 = SMA - (sdmat * (bol_mul+1));
    xaxis = [1:length(SMA)];
    hold on;
    bolband1 = plot(xaxis,SMA,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');  
    bolband2 = plot(xaxis,UPPER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband3 = plot(xaxis,LOWER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband4 = plot(xaxis,UPPER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband5 = plot(xaxis,LOWER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    hold off;

    grid on;
    %set(gca,'position',[0.05 0.5 0.6 0.45],'xticklabel',[],'Box','on');
    linkaxes(sdisplay,'x');
    curwin = 1;
    
    % We then HAVE to plot all the others.
    hold on;
    EAVG = EAVGorig;
    xaxis2 = [ma_y:length(EAVG)];
    EAVG(1:ma_y - 1) = [];
    emaplot = plot(xaxis2,EAVG,'LineWidth',1,'Color',[0.3 0.1 0.8]);
    xaxis2 = [1:length(MAVG)]+ma_x-1;
    smaplot = plot(xaxis2,MAVG,'LineWidth',1,'Color',[0.8 0.1 0.1]);
    hold off;
    
end   
    
bol_multxt = uicontrol(bol_para,'style','text','Position',[0.06 0.3 0.5 0.2],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String',['Multiplier:' num2str(bol_mul)],'FontName','Monaco','FontSize',8);

bol_mulslide = uicontrol(bol_para,'Style', 'slider','Min',1,'Max',5,'Value',bol_mul,'SliderStep',[(1/80) (1/80)],...
    'Callback',@bol_mslid,'FontName','Monaco','Position',[0.55,0.4,0.4,0.1],'Units','normalized');
    
function bol_mslid(src,evt)
    
    slidvalue = get(bol_mulslide,'value');
    set(bol_multxt,'String',['Multiplier:' num2str(slidvalue)]);
    bol_mul = slidvalue;

    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    cla(sdisplay(1));
    drawcand2(s1);
    
    int = 4;
    

    
    % Now calculate the 20-day mean.
    
    
    for (i = bol_per:length(s2))
    % The loop to start the standard deviation matrix starts here.    
            
        % First get the mean.
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,4);
        end
        mean = tot / bol_per;
    
        clear dev;
        % Now we get the deviation.
        for (j = i-bol_per+1:i)
            dev(j) = s2(j,4) - mean;
        end
        
        % Square the deviation.
        dev2 = dev.^2;
        sdmat(i) = sqrt(sum(dev2) / bol_per);
    
    end

    % For our Bollinger band, we want to calculate the matrix for SMA.
    
    for (i = bol_per:length(s2))
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,int);
        end
        SMA(i) = ( tot / bol_per );
        
    end
    
    UPPER1 = SMA + (sdmat * bol_mul);
    UPPER2 = SMA + (sdmat * (bol_mul+1));
    LOWER1 = SMA - (sdmat * bol_mul);
    LOWER2 = SMA - (sdmat * (bol_mul+1));
    xaxis = [1:length(SMA)];
    hold on;
    bolband1 = plot(xaxis,SMA,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');  
    bolband2 = plot(xaxis,UPPER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband3 = plot(xaxis,LOWER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband4 = plot(xaxis,UPPER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband5 = plot(xaxis,LOWER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    hold off;

    grid on;
    %set(gca,'position',[0.05 0.5 0.6 0.45],'xticklabel',[],'Box','on');
    linkaxes(sdisplay,'x');
    curwin = 1;
    
    % We then HAVE to plot all the others.
    hold on;
    EAVG = EAVGorig;
    xaxis2 = [ma_y:length(EAVG)];
    EAVG(1:ma_y - 1) = [];
    emaplot = plot(xaxis2,EAVG,'LineWidth',1,'Color',[0.3 0.1 0.8]);
    xaxis2 = [1:length(MAVG)]+ma_x-1;
    smaplot = plot(xaxis2,MAVG,'LineWidth',1,'Color',[0.8 0.1 0.1]);
    hold off;
end       
    



% BOXSET of buttons for our moving average analysis.

avg_para = uibuttongroup('Parent',gcf,...
        'BackgroundColor',[0 0 0],'FontName','Monaco','FontSize',8,... 
        'Position',[.88 .65 .05 .08]);

exp_check = uicontrol('Parent',avg_para,'style','checkbox','Position',[0.2 0.4 0.3 0.3],'units','normalized','Callback',@exp_func);

txt_update = uicontrol(gcf,'style','text','String','PLOT GOOD!','Position',[0.85 0.81 0.1 0.03],'units','normalized',...
    'FontName','Monaco','ForegroundColor',[0.8 0.2 0.2],'FontSize',16);

function exp_func(src,evt)
    
    set(sim_check,'Value',0);
    set(bol_check,'Value',0);
    
    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    if (get(exp_check,'Value') == 1)
        % Get the matrix for both the short term and the long term.
        set(txt_update,'String','PLOT GOOD!');
        clear STR_MA;
        cla(sdisplay(1));
        drawcand2(s1);
        % Remember that we output the orig matrix with same length.       
        expmat_short = expavg1(s2,short_ma);
        expmat_long = expavg1(s2,long_ma);
        STRtemp = expmat_long - expmat_short;   % Now we can do testing on just this one matrix.
        
        start = length(STRtemp); mark = 1; count = 1;
        for (i = long_ma:length(STRtemp))
            if (STRtemp(i) < 0)
                start = i;
                STR_MA(count,1) = i;            % This is the buy signal.
                break;
            end
        end

        for (i = start:length(STRtemp))
            if (mark == 1)
                if (STRtemp(i) > 0)
                   STR_MA(count,2) = i;
                   count = count + 1;
                   mark = 2;
                end
            end
            if (mark == 2)
                if (STRtemp(i) < 0)
                   STR_MA(count,1) = i;
                   mark = 1;
                end
            end
        end

        if (start == length(STRtemp))
           STR_MA(1,1) = length(STRtemp);
           STR_MA(1,2) = 0;
        end
        
        if (length(STR_MA) == 1)
           STR_MA(1,2) = 0; 
        end
        % We have our STR_MA. Now we plot our signals.
        
        xaxis_s = [short_ma:length(expmat_short)];
        expmat_short(1:short_ma - 1) = [];
        xaxis_l = [long_ma:length(expmat_long)];
        expmat_long(1:long_ma - 1) = [];
        col = [0.7 0.2 0.65];
        hold on;
        plot(xaxis_s,expmat_short,'LineWidth',2,'Color',col);
        plot(xaxis_l,expmat_long,'LineWidth',2,'Color',col);
        
        % Plot the buy / sell signals.
        
        for (i = 1:length(STR_MA(:,1)))
            plot(STR_MA(i,1),expmat_long(STR_MA(i,1)-long_ma+1),'r^','MarkerSize',12,'MarkerFaceColor','r');     % Mark intersection with red arrow.
            text(STR_MA(i,1),expmat_long(STR_MA(i,1)-long_ma+1),[' Buy at ',num2Str(STR_MA(i,1))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
            text(STR_MA(i,1),expmat_long(STR_MA(i,1)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,1),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          if (STR_MA(i,2) > 0)
          plot(STR_MA(i,2),expmat_long(STR_MA(i,2)-long_ma+1),'bv','MarkerSize',12,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
          text(STR_MA(i,2),expmat_long(STR_MA(i,2)-long_ma+1),[' Sell at ',num2str(STR_MA(i,2))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
          text(STR_MA(i,2),expmat_long(STR_MA(i,2)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,2),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          end
        end

        hold off;
        
        % Calculate Moving Average profit.
        current = 0; pnl = 0;
        for (i = 1:length(STR_MA(:,1)))
            if ( STR_MA(i,2) > 0 )
            current = s2(STR_MA(i,2),4) - s2(STR_MA(i,1),4);
            pnl = pnl + current;
            pnl;
            end
        end
        set(pnlboxma,'String',sprintf('%0.2f',pnl));
        linkaxes(sdisplay,'x');
    
    end
   
    if (get(exp_check,'Value') == 0)
        set(txt_update,'String','PLOT GOOD!');
        cla(sdisplay(1));
        drawcand2(s1);
        set(pnlboxma,'String','Nil');
        linkaxes(sdisplay,'x');
    end
    
    curwin = 1;
    
end

sim_check = uicontrol('Parent',avg_para,'style','checkbox','Position',[0.2 0.1 0.3 0.3],'units','normalized','Callback',@sim_func);

function sim_func(src,evt)
    
    set(exp_check,'Value',0);
    set(bol_check,'Value',0);
    
    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    if (get(sim_check,'Value') == 1)
        
        set(txt_update,'String','PLOT GOOD!');
        clear STR_MA;
        cla(sdisplay(1));
        drawcand2(s1);
        % Remember that we output the orig matrix with same length.       
        simmat_short = movavg1(s2,short_ma);
        simmat_long = movavg1(s2,long_ma);
        STRtemp = simmat_long - simmat_short;   % Now we can do testing on just this one matrix.

        start = length(STRtemp); mark = 1; count = 1;
        for (i = long_ma:length(STRtemp))
            if (STRtemp(i) < 0)
                start = i;
                STR_MA(count,1) = i;
                break;
            end
        end
        
        for (i = start:length(STRtemp))
            if (mark == 1)
                if (STRtemp(i) > 0)
                   STR_MA(count,2) = i;
                   count = count + 1;
                   mark = 2;
                end
            end
            if (mark == 2)
                if (STRtemp(i) < 0)
                   STR_MA(count,1) = i;
                   mark = 1;
                end
            end
        end
        if (start == length(STRtemp))
           STR_MA(1,1) = length(STRtemp);
           STR_MA(1,2) = 0;
        end
        if (length(STR_MA) == 1)
           STR_MA(1,2) = 0; 
        end
        % We have our STR_MA. Now we plot our signals.
        
        xaxis_s = [short_ma:length(simmat_short)];
        simmat_short(1:short_ma - 1) = [];
        xaxis_l = [long_ma:length(simmat_long)];
        simmat_long(1:long_ma - 1) = [];
        col = [0.2 0.7 0.3];
        hold on;
        plot(xaxis_s,simmat_short,'LineWidth',2,'Color',col);
        plot(xaxis_l,simmat_long,'LineWidth',2,'Color',col);
        
        % Plot the buy / sell signals.
        
        for (i = 1:length(STR_MA(:,1)))
            plot(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),'r^','MarkerSize',12,'MarkerFaceColor','r');     % Mark intersection with red arrow.
            text(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),[' Buy at ',num2Str(STR_MA(i,1))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
            text(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,1),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          if (STR_MA(i,2) > 0)
          plot(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),'bv','MarkerSize',12,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
          text(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),[' Sell at ',num2str(STR_MA(i,2))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
          text(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,2),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          end
        end

        hold off;
        % Calculate Moving Average profit.
        current = 0; pnl = 0;
        for (i = 1:length(STR_MA(:,1)))
            if ( STR_MA(i,2) > 0 )
            current = s2(STR_MA(i,2),4) - s2(STR_MA(i,1),4);
            pnl = pnl + current;
            pnl;
            end
        end
        set(pnlboxma,'String',sprintf('%0.2f',pnl)); 
        linkaxes(sdisplay,'x');
    end

    if (get(sim_check,'Value') == 0)
        set(txt_update,'String','PLOT GOOD!');
        cla(sdisplay(1));
        drawcand2(s1);
        set(pnlboxma,'String','Nil');
        linkaxes(sdisplay,'x');
    end    
    curwin = 1;
end

label_ex = uicontrol(gcf,'style','text','String','EXPON','Position',[0.82 0.67 0.06 0.05],...
    'FontName','Monaco','FontSize',16,'units','normalized');

label_sm = uicontrol(gcf,'style','text','String','SIMPLE','Position',[0.82 0.63 0.06 0.05],...
    'FontName','Monaco','FontSize',16,'units','normalized');

shortma_slide = uicontrol(gcf,'Style', 'slider','Min',1,'Max',100,'Value',short_ma,'SliderStep',[(1/99) (1/99)],...
    'Callback',@shortma_func,'FontName','Monaco','Position',[0.88 0.67 0.07 0.1],'Units','normalized');

function shortma_func(src,evt)
    
    slidvalue = get(shortma_slide,'value');
    short_ma = ceil(slidvalue);
    set(shortma_lab,'String',num2str(short_ma));
    set(txt_update,'String','NEED UPDATE');
    
    % Add the feature of DYNAMIC changing.
    
    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    if (get(sim_check,'Value') == 1)
        
        set(txt_update,'String','PLOT GOOD!');
        clear STR_MA;
        cla(sdisplay(1));
        drawcand2(s1);
        % Remember that we output the orig matrix with same length.       
        simmat_short = movavg1(s2,short_ma);
        simmat_long = movavg1(s2,long_ma);
        STRtemp = simmat_long - simmat_short;   % Now we can do testing on just this one matrix.

        start = length(STRtemp); mark = 1; count = 1;
        for (i = long_ma:length(STRtemp))
            if (STRtemp(i) < 0)
                start = i;
                STR_MA(count,1) = i;
                break;
            end
        end
        
        for (i = start:length(STRtemp))
            if (mark == 1)
                if (STRtemp(i) > 0)
                   STR_MA(count,2) = i;
                   count = count + 1;
                   mark = 2;
                end
            end
            if (mark == 2)
                if (STRtemp(i) < 0)
                   STR_MA(count,1) = i;
                   mark = 1;
                end
            end
        end
        if (start == length(STRtemp))
           STR_MA(1,1) = length(STRtemp);
           STR_MA(1,2) = 0;
        end
        if (length(STR_MA) == 1)
           STR_MA(1,2) = 0; 
        end
        % We have our STR_MA. Now we plot our signals.
        
        xaxis_s = [short_ma:length(simmat_short)];
        simmat_short(1:short_ma - 1) = [];
        xaxis_l = [long_ma:length(simmat_long)];
        simmat_long(1:long_ma - 1) = [];
        col = [0.2 0.7 0.3];
        hold on;
        plot(xaxis_s,simmat_short,'LineWidth',2,'Color',col);
        plot(xaxis_l,simmat_long,'LineWidth',2,'Color',col);
        
        % Plot the buy / sell signals.
        
        for (i = 1:length(STR_MA(:,1)))
            plot(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),'r^','MarkerSize',12,'MarkerFaceColor','r');     % Mark intersection with red arrow.
            text(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),[' Buy at ',num2Str(STR_MA(i,1))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
            text(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,1),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          if (STR_MA(i,2) > 0)
          plot(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),'bv','MarkerSize',12,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
          text(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),[' Sell at ',num2str(STR_MA(i,2))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
          text(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,2),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          end
        end

        hold off;
        % Calculate Moving Average profit.
        current = 0; pnl = 0;
        for (i = 1:length(STR_MA(:,1)))
            if ( STR_MA(i,2) > 0 )
            current = s2(STR_MA(i,2),4) - s2(STR_MA(i,1),4);
            pnl = pnl + current;
            pnl;
            end
        end
        set(pnlboxma,'String',sprintf('%0.2f',pnl)); 
        linkaxes(sdisplay,'x');
    end

    if (get(sim_check,'Value') == 0)
        set(txt_update,'String','PLOT GOOD!');
        cla(sdisplay(1));
        drawcand2(s1);
        set(pnlboxma,'String','Nil');
        linkaxes(sdisplay,'x');
    end    
    curwin = 1;
    
    if (get(exp_check,'Value') == 1)
        % Get the matrix for both the short term and the long term.
        set(txt_update,'String','PLOT GOOD!');
        clear STR_MA;
        cla(sdisplay(1));
        drawcand2(s1);
        % Remember that we output the orig matrix with same length.       
        expmat_short = expavg1(s2,short_ma);
        expmat_long = expavg1(s2,long_ma);
        STRtemp = expmat_long - expmat_short;   % Now we can do testing on just this one matrix.
        
        start = length(STRtemp); mark = 1; count = 1;
        for (i = long_ma:length(STRtemp))
            if (STRtemp(i) < 0)
                start = i;
                STR_MA(count,1) = i;            % This is the buy signal.
                break;
            end
        end

        for (i = start:length(STRtemp))
            if (mark == 1)
                if (STRtemp(i) > 0)
                   STR_MA(count,2) = i;
                   count = count + 1;
                   mark = 2;
                end
            end
            if (mark == 2)
                if (STRtemp(i) < 0)
                   STR_MA(count,1) = i;
                   mark = 1;
                end
            end
        end

        if (start == length(STRtemp))
           STR_MA(1,1) = length(STRtemp);
           STR_MA(1,2) = 0;
        end
        
        if (length(STR_MA) == 1)
           STR_MA(1,2) = 0; 
        end
        % We have our STR_MA. Now we plot our signals.
        
        xaxis_s = [short_ma:length(expmat_short)];
        expmat_short(1:short_ma - 1) = [];
        xaxis_l = [long_ma:length(expmat_long)];
        expmat_long(1:long_ma - 1) = [];
        col = [0.7 0.2 0.65];
        hold on;
        plot(xaxis_s,expmat_short,'LineWidth',2,'Color',col);
        plot(xaxis_l,expmat_long,'LineWidth',2,'Color',col);
        
        % Plot the buy / sell signals.
        
        for (i = 1:length(STR_MA(:,1)))
            plot(STR_MA(i,1),expmat_long(STR_MA(i,1)-long_ma+1),'r^','MarkerSize',12,'MarkerFaceColor','r');     % Mark intersection with red arrow.
            text(STR_MA(i,1),expmat_long(STR_MA(i,1)-long_ma+1),[' Buy at ',num2Str(STR_MA(i,1))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
            text(STR_MA(i,1),expmat_long(STR_MA(i,1)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,1),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          if (STR_MA(i,2) > 0)
          plot(STR_MA(i,2),expmat_long(STR_MA(i,2)-long_ma+1),'bv','MarkerSize',12,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
          text(STR_MA(i,2),expmat_long(STR_MA(i,2)-long_ma+1),[' Sell at ',num2str(STR_MA(i,2))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
          text(STR_MA(i,2),expmat_long(STR_MA(i,2)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,2),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          end
        end

        hold off;
        
        % Calculate Moving Average profit.
        current = 0; pnl = 0;
        for (i = 1:length(STR_MA(:,1)))
            if ( STR_MA(i,2) > 0 )
            current = s2(STR_MA(i,2),4) - s2(STR_MA(i,1),4);
            pnl = pnl + current;
            pnl;
            end
        end
        set(pnlboxma,'String',sprintf('%0.2f',pnl));
        linkaxes(sdisplay,'x');
    
    end
   
    if (get(exp_check,'Value') == 0)
        set(txt_update,'String','PLOT GOOD!');
        cla(sdisplay(1));
        drawcand2(s1);
        set(pnlboxma,'String','Nil');
        linkaxes(sdisplay,'x');
    end
    
    
    % End of feature.
end

shortma_tag = uicontrol(gcf,'style','text','String','Short Lookback','Position',[0.80 0.745 0.08 0.03],...
    'FontName','Monaco','FontSize',11,'units','normalized');

shortma_lab = uicontrol(gcf,'style','text','String',num2str(short_ma),'Position',[0.96 0.74 0.02 0.03],...
    'FontName','Monaco','FontSize',16,'units','normalized');

longma_slide = uicontrol(gcf,'Style', 'slider','Min',1,'Max',100,'Value',long_ma,'SliderStep',[(1/99) (1/99)],...
    'Callback',@longma_func,'FontName','Monaco','Position',[0.88 0.7 0.07 0.1],'Units','normalized');

function longma_func(src,evt)
    
    slidvalue = get(longma_slide,'value');
    long_ma = ceil(slidvalue);
    set(longma_lab,'String',num2str(long_ma));
    set(txt_update,'String','NEED UPDATE');
    
    % Add the feature of DYNAMIC changing.
    
    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    if (get(sim_check,'Value') == 1)
        
        set(txt_update,'String','PLOT GOOD!');
        clear STR_MA;
        cla(sdisplay(1));
        drawcand2(s1);
        % Remember that we output the orig matrix with same length.       
        simmat_short = movavg1(s2,short_ma);
        simmat_long = movavg1(s2,long_ma);
        STRtemp = simmat_long - simmat_short;   % Now we can do testing on just this one matrix.

        start = length(STRtemp); mark = 1; count = 1;
        for (i = long_ma:length(STRtemp))
            if (STRtemp(i) < 0)
                start = i;
                STR_MA(count,1) = i;
                break;
            end
        end
        
        for (i = start:length(STRtemp))
            if (mark == 1)
                if (STRtemp(i) > 0)
                   STR_MA(count,2) = i;
                   count = count + 1;
                   mark = 2;
                end
            end
            if (mark == 2)
                if (STRtemp(i) < 0)
                   STR_MA(count,1) = i;
                   mark = 1;
                end
            end
        end
        if (start == length(STRtemp))
           STR_MA(1,1) = length(STRtemp);
           STR_MA(1,2) = 0;
        end
        if (length(STR_MA) == 1)
           STR_MA(1,2) = 0; 
        end
        % We have our STR_MA. Now we plot our signals.
        
        xaxis_s = [short_ma:length(simmat_short)];
        simmat_short(1:short_ma - 1) = [];
        xaxis_l = [long_ma:length(simmat_long)];
        simmat_long(1:long_ma - 1) = [];
        col = [0.2 0.7 0.3];
        hold on;
        plot(xaxis_s,simmat_short,'LineWidth',2,'Color',col);
        plot(xaxis_l,simmat_long,'LineWidth',2,'Color',col);
        
        % Plot the buy / sell signals.
        
        for (i = 1:length(STR_MA(:,1)))
            plot(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),'r^','MarkerSize',12,'MarkerFaceColor','r');     % Mark intersection with red arrow.
            text(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),[' Buy at ',num2Str(STR_MA(i,1))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
            text(STR_MA(i,1),simmat_long(STR_MA(i,1)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,1),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          if (STR_MA(i,2) > 0)
          plot(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),'bv','MarkerSize',12,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
          text(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),[' Sell at ',num2str(STR_MA(i,2))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
          text(STR_MA(i,2),simmat_long(STR_MA(i,2)-long_ma+1),[' Pr: ',num2str(s2(STR_MA(i,2),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          end
        end

        hold off;
        % Calculate Moving Average profit.
        current = 0; pnl = 0;
        for (i = 1:length(STR_MA(:,1)))
            if ( STR_MA(i,2) > 0 )
            current = s2(STR_MA(i,2),4) - s2(STR_MA(i,1),4);
            pnl = pnl + current;
            pnl;
            end
        end
        set(pnlboxma,'String',sprintf('%0.2f',pnl)); 
        linkaxes(sdisplay,'x');
    end

    if (get(sim_check,'Value') == 0)
        set(txt_update,'String','PLOT GOOD!');
        cla(sdisplay(1));
        drawcand2(s1);
        set(pnlboxma,'String','Nil');
        linkaxes(sdisplay,'x');
    end    
    curwin = 1;
    
    % End of feature.
    
end

longma_tag = uicontrol(gcf,'style','text','String','Long Lookback','Position',[0.80 0.775 0.08 0.03],...
    'FontName','Monaco','FontSize',11,'units','normalized');

longma_lab = uicontrol(gcf,'style','text','String',num2str(long_ma),'Position',[0.96 0.78 0.02 0.03],...
    'FontName','Monaco','FontSize',16,'units','normalized');

bol_check = uicontrol('Parent',avg_para,'style','checkbox','Position',[0.5 0.1 0.3 0.3],'units','normalized','Callback',@bol_func);

    % Plot the Bollinger band strategy.
    function bol_func(src,evt)
        
    set(sim_check,'Value',0);    
    set(exp_check,'Value',0);
    
    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    if (get(bol_check,'Value') == 1)
    
        set(txt_update,'String','PLOT GOOD!');
        clear STR_BOL;
        cla(sdisplay(1));
        drawcand2(s1);
        xaxisbol = [1:length(UPPER2)];

        start = 1; count = 1; mark = 1;
        % First find when first closing prices goes below lower band.
        for (i = 1:length(xaxisbol))
            if (s2(i,4) < LOWER2(i))
                start = i;
                STR_BOL(count,1) = i;
                break;
            end
        end
        
        for (i = start:length(xaxisbol))
           if (mark == 1)
               if (s2(i,4) > UPPER2(i))
                  STR_BOL(count,2) = i;
                  mark = 2;
                  count = count + 1;
               end
           end
           if (mark == 2)
               if (s2(i,4) < LOWER2(i))
                   STR_BOL(count,1) = i;
                   mark = 1;
               end
           end
        end
        
        if (start == length(xaxisbol))
           STR_BOL(1,1) = length(xaxisbol);
           STR_BOL(1,2) = 0;
        end
        if (length(STR_BOL) == 1)
           STR_BOL(1,2) = 0; 
        end
        
        % Plot the buy / sell signals.
        hold on;
        bolbandtop = plot(xaxisbol,UPPER2,'LineWidth',1,'Color',[0.25 0.2 0.65],'LineWidth',2);
        bolbandbottom = plot(xaxisbol,LOWER2,'LineWidth',1,'Color',[0.25 0.2 0.65],'LineWidth',2);
        for (i = 1:length(STR_BOL(:,1)))
            plot(STR_BOL(i,1),s2(STR_BOL(i,1),4),'r^','MarkerSize',12,'MarkerFaceColor','r');     % Mark intersection with red arrow.
            text(STR_BOL(i,1),s2(STR_BOL(i,1),4),[' Buy at ',num2Str(STR_BOL(i,1))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
            text(STR_BOL(i,1),s2(STR_BOL(i,1),4),[' Pr: ',num2str(s2(STR_BOL(i,1),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          if (STR_BOL(i,2) > 0)
          plot(STR_BOL(i,2),s2(STR_BOL(i,2),4),'bv','MarkerSize',12,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
          text(STR_BOL(i,2),s2(STR_BOL(i,2),4),[' Sell at ',num2str(STR_BOL(i,2))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
          text(STR_BOL(i,2),s2(STR_BOL(i,2),4),[' Pr: ',num2str(s2(STR_BOL(i,2),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          end
        end
        hold off;
        
        % Calculate Moving Average profit.
        current = 0; pnl = 0;
        for (i = 1:length(STR_BOL(:,1)))
            if ( STR_BOL(i,2) > 0 )
            current = s2(STR_BOL(i,2),4) - s2(STR_BOL(i,1),4);
            pnl = pnl + current;
            pnl;
            end
        end
        set(pnlboxma,'String',sprintf('%0.2f',pnl)); 
        linkaxes(sdisplay,'x');
    end
    
    if (get(bol_check,'Value') == 0)
        set(txt_update,'String','PLOT GOOD!');
        cla(sdisplay(1));
        drawcand2(s1);
        set(pnlboxma,'String','Nil');
        linkaxes(sdisplay,'x');
    end    
    curwin = 1;    
    end

bol_lab = uicontrol(gcf,'style','text','String','BOLLING','Position',[0.9 0.6 0.06 0.04],...
    'FontName','Monaco','FontSize',16,'units','normalized');


resetbox = uicontrol('Parent',avg_para,'style','pushbutton','Position',[0.55 0.4 0.3 0.3],...
    'String','00','FontName','Monaco','units','normalized','Callback',@resetfunc);

function resetfunc(src,evt)
    
    set(exp_check,'Value',0);
    set(sim_check,'Value',0);
    set(bol_check,'Value',0);
    set(pnlboxma,'String','Nil');
    % We then need to replot the candlestick and other indicators.
    
    if (curwin ~= 1)
       sdisplay(1) = subplot(5,5,[1:4 6:9],'position',[0.05 0.6 0.6 0.38],'xticklabel',[],'Box','on');
    end
    
    cla(sdisplay(1));
    drawcand2(s1);
    int = 4;
   
    % Now calculate the 20-day mean.
  
    for (i = bol_per:length(s2))
    % The loop to start the standard deviation matrix starts here.    
            
        % First get the mean.
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,4);
        end
        mean = tot / bol_per;
    
        clear dev;
        % Now we get the deviation.
        for (j = i-bol_per+1:i)
            dev(j) = s2(j,4) - mean;
        end
        
        % Square the deviation.
        dev2 = dev.^2;
        sdmat(i) = sqrt(sum(dev2) / bol_per);
    
    end

    % For our Bollinger band, we want to calculate the matrix for SMA.
    
    for (i = bol_per:length(s2))
        tot = 0;
        for (j = i-bol_per+1:i)
            tot = tot + s2(j,int);
        end
        SMA(i) = ( tot / bol_per );
        
    end
    
    UPPER1 = SMA + (sdmat * bol_mul);
    UPPER2 = SMA + (sdmat * (bol_mul+1));
    LOWER1 = SMA - (sdmat * bol_mul);
    LOWER2 = SMA - (sdmat * (bol_mul+1));
    xaxis = [1:length(SMA)];
    hold on;
    bolband1 = plot(xaxis,SMA,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');  
    bolband2 = plot(xaxis,UPPER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband3 = plot(xaxis,LOWER1,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband4 = plot(xaxis,UPPER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    bolband5 = plot(xaxis,LOWER2,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);
    hold off;

    grid on;
    %set(gca,'position',[0.05 0.5 0.6 0.45],'xticklabel',[],'Box','on');
    linkaxes(sdisplay,'x');
    curwin = 1;
    
    % We then HAVE to plot all the others.
    hold on;
    EAVG = EAVGorig;
    xaxis2 = [ma_y:length(EAVG)];
    EAVG(1:ma_y - 1) = [];
    emaplot = plot(xaxis2,EAVG,'LineWidth',1,'Color',[0.3 0.1 0.8]);
    MAVG = movavg1(s2,ma_x);
    xaxis2 = [1:length(MAVG)];
    smaplot = plot(xaxis2,MAVG,'LineWidth',1,'Color',[0.8 0.1 0.1]);
    hold off;
    
    % Done plotting the charts.

end

% PnL box.

pnlbutma = uibuttongroup('Parent',gcf,'Title','MA/Bol PnL',...
        'BackgroundColor',[1 1 1],'FontName','Monaco','FontSize',8,... 
        'Position',[.66 .15 .07 .07]);
pnlboxma = uicontrol('Parent',pnlbutma,'style','text','Position',[0.05 0.05 0.9 0.9],'Units','normalized','BackgroundColor',[1 1 1]);
    set(pnlboxma,'String','Nil');
    set(pnlboxma,'Units','characters','FontName','Monaco','FontSize',16);
    
ma_opt = uicontrol('Parent',gcf,'style','pushbutton','Position',[.66 .07 .07 .07],...
    'String','MA Optimize','Units','normalized','BackgroundColor',[1 1 1],'FontName','Monaco');


% End of boxsetend.

    
exec = uicontrol(gcf,'style','pushbutton','Position',[0.9 0.01 0.06 0.05],'Units','normalized','BackgroundColor',[0.8 0.8 0.8],...
    'String','Close','FontName','Monaco','FontSize',10,'Callback',@back);    
    
function back(src,evt)
    close;
end    

curwin = 0;
linkaxes(sdisplay,'x');    
set(gcf,'units','normalized','Position',[0 0 1 1]);
%set(gcf,'Position',[0 500 1440 900]);

% Our private Stochastic function.
function STR = stoc(s,look,x,y,ent,ext1,ext2)

    % close;
    upbound = ext1; 
    lowbound = ent;
    topmid = ext2;
    boundcol = [0.3 0.3 0.3];
    midcol = [0.4 0 0.4];
    % Form a new matrix.
    for (i = look:length(s))
        
        low = min(s(i-look+1:i,3));
        high = max(s(i-look+1:i,2));
        % First get the Fast %K.
        FastK(i) = ( ( s(i,4) - low ) / ( high - low) ) * 100;
        
    end
    
    % Now get the Full %K.
    
    for (i = look : length(s))
        tot = 0;
        for (j = i-x+1:i)
            tot = tot + FastK(j);
        end
        FullK(i) = ( tot / x );
        
    end
    
    % Now get the Full %D.
    
    for (i = look : length(s))
        tot = 0;
        for (j = i-y+1:i)
            tot = tot + FullK(j);
        end
        FullD(i) = ( tot / y );
        
    end
    
    xaxis = [1:length(FullK)];    
    len = length(xaxis);

    %figure;
    hold on;
    plot(xaxis(look:len),FullK(look:len),'Color',[0.87 0 0.3]);
    plot(xaxis(look:len),FullD(look:len),'Color',[0.2 0 0.4]);
    
    % Draw the high low lines for our trading strategy.
    line([1 length(s)],[upbound upbound],'LineWidth',1,'Color',boundcol);
    line([1 length(s)],[lowbound lowbound],'LineWidth',1,'Color',boundcol);
    line([1 length(s)],[topmid topmid],'LineWidth',1,'Color',midcol);
    
    
    
    hold off;
    set(gca,'FontName','Monaco');
    set(gca,'xticklabel',[]);  % turn off the x axis tick.
    %set(gca,'position',[0.05 0.35 0.6 0.15],'Box','on');
    linkaxes(sdisplay,'x');
    ylabel('Stochastic Indicator (%)');
    axis([0 length(s) 0 100])
    grid on;
    
    % Now we implement our enter and exit strategy.
    text(0,ent,[' ENTER time:',num2str(ent)],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',10,'FontName','Monaco')
    text(0,ext1,[' CHECK time:',num2str(ext1)],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',10,'FontName','Monaco')        
    text(0,ext2,[' EXIT time:',num2str(ext2)],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',10,'FontName','Monaco') 

    % We hope to have output a x by two vector of enter and exit points.  
    % We are using the Full%D as our indicator.
    
    % Set our mark as 0 first.
    start = look;
    marktime = look;
    mark = 1;
    count = 0;
    if (FullD(look) > ent)
        mark = 2;
            for (i = look:len)
                if (FullD(look) < ent)
                    mark = 1;
                    start = i;
                end
            end
    end
    % We start with mark = 1.
    for (i = start:len)
        if (mark == 1)
            if (FullD(i) > ent)
                mark = 2;
                count = count + 1;
                STR(count,1) = i;
                STR(count,2) = 0;
            end
        end
        if (mark == 2)
            if (FullD(i) > ext1)
                mark = 3;
            end
        end
        if (mark == 3)
            if (FullD(i) < ext2)
                mark = 4;
                STR(count,2) = i;
            end
        end
        if (mark == 4)
            if (FullD(i) < ent)
                mark = 1;
            end
        end
    end
    
	% Now with the data in the STR matrix, we can plot the enter and exit
	% points.
    hold on;
    for (i = 1:length(STR(:,1)))
        plot(STR(i,1),FullD(STR(i,1)),'r^','MarkerSize',8,'MarkerFaceColor','r');     % Mark intersection with red arrow.
        text(STR(i,1),FullD(STR(i,1)),[' Buy at ',num2str(STR(i,1))],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',12,'FontName','Monaco')
        text(STR(i,1),FullD(STR(i,1)),[' Pr: ',num2str(s(STR(i,1),4))],...
                'VerticalAlignment','bottom',...
                'HorizontalAlignment','left',...
                'FontSize',14,'FontName','Monaco')
        if (STR(i,2) > 0)
        plot(STR(i,2),FullD(STR(i,2)),'bv','MarkerSize',8,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
        text(STR(i,2),FullD(STR(i,2)),[' Sell at ',num2str(STR(i,2))],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',12,'FontName','Monaco')
        text(STR(i,2),FullD(STR(i,2)),[' Pr: ',num2str(s(STR(i,2),4))],...
                'VerticalAlignment','bottom',...
                'HorizontalAlignment','left',...
                'FontSize',14,'FontName','Monaco')
        end
    end
    hold off;




end

% Our private MACD function.
function STR_M = MACDfunc(s,x,y,w)

    % close all;
    int = 4;
    upcol = [0.4 0 0.3];
    downcol = [0.3 0.55 1];
    
    XEMA = expavg1(s,x);
    YEMA = expavg1(s,y);
    MACDmat = XEMA - YEMA;
    % Create 9-day EMA of MACD.
    
    % Calculate the SMA for the first point.
    tot = 0;
    for (i = 1:w)
        tot = tot + MACDmat(i);
        SIG(w) = (tot / w );
    end
    
    % Calculate the multiplier.
    mul = (2 / (w + 1) );
   
    % Form the Exponential moving average matrix.
    for (i = w+1:length(MACDmat))
       SIG(i) = ( MACDmat(i) - SIG(i-1) ) * mul + SIG(i-1);         
    end
   
    xaxis = [1:length(MACDmat)];
    hold on;
    plot(xaxis,MACDmat,'Color',[0.8 0 0.3],'LineWidth',1.5);
    plot(xaxis,SIG,'Color',[0.3 0.1 0.8],'LineWidth',1.5);
    
    % Plot the Histogram.
    HIST = MACDmat - SIG;
    for (i = x+y+w:length(HIST))
       
        if (HIST(i) > HIST(i-1))
            fill([i-1 i i i-1],[0 0 HIST(i) HIST(i)],upcol)
        else
            fill([i-1 i i i-1],[0 0 HIST(i) HIST(i)],downcol)
        end
        
    end
    
    topbound = max([max(MACDmat(x+y+w:length(MACDmat))) max(SIG(x+y+w:length(MACDmat))) ...
                    max(HIST(x+y+w:length(MACDmat)))]);
    botbound = min([min(MACDmat(x+y+w:length(MACDmat))) min(SIG(x+y+w:length(MACDmat))) ...
                    min(HIST(x+y+w:length(MACDmat)))]);
    
    hold off;
    axis([0 length(s) botbound topbound]);
    set(gca,'FontName','Monaco');
    %set(gca,'position',[0.05 0.2 0.6 0.15]);
    set(gca,'xticklabel',[]);  % turn off the x axis tick.
    linkaxes(sdisplay,'x');
    %title(['MACD with parameter (' num2str(x) ',' num2str(y) ',' num2str(w) ')']);
    ylabel('MACD indicator ($)');
    %xlabel('Time (1 day)');
    grid on;
    alpha(0.8);
    % We write the code here to calculate the Buy and Sell matrix. We label
    % it as STR matrix.
    
    clear STR_M;
    ct = 1;
    start = x+y+w;
    flag = 0; % 0 is currently negative, 1 is currently positive.
    % We first find the time when the HIST gives a negative value.
    for (i = start:length(HIST))
        if (HIST(i) < 0)
            start = i;
            break;
        end
    end
    
    for (i = start+1:length(HIST))
       if (flag == 0)
            if (HIST(i) > 0)
                STR_M(ct,1) = i;
                flag = 1;
            end
       else
            if (HIST(i) < 0)
                STR_M(ct,2) = i;
                ct = ct + 1;
                flag = 0;
            end
       end
    end
    
    if (length(STR_M(1,:)) == 1)
        STR_M(1,2) = 0;
    end
    hold on;  
    
    for (i = 1:length(STR_M(:,1)))
        plot(STR_M(i,1),SIG(STR_M(i,1)),'r^','MarkerSize',8,'MarkerFaceColor','r');     % Mark intersection with red arrow.
        text(STR_M(i,1),SIG(STR_M(i,1)),[' Buy at ',num2Str(STR_M(i,1))],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',12,'FontName','Monaco')
        text(STR_M(i,1),SIG(STR_M(i,1)),[' Pr: ',num2str(s(STR_M(i,1),4))],...
                'VerticalAlignment','bottom',...
                'HorizontalAlignment','left',...
                'FontSize',14,'FontName','Monaco')
        if (STR_M(i,2) > 0)
        plot(STR_M(i,2),SIG(STR_M(i,2)),'bv','MarkerSize',8,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
        text(STR_M(i,2),SIG(STR_M(i,2)),[' Sell at ',num2str(STR_M(i,2))],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',12,'FontName','Monaco')
        text(STR_M(i,2),SIG(STR_M(i,2)),[' Pr: ',num2str(s(STR_M(i,2),4))],...
                'VerticalAlignment','bottom',...
                'HorizontalAlignment','left',...
                'FontSize',14,'FontName','Monaco')
        end
    end
    hold off;
    
end

% Our private RSI function.
function STR_R = RSIfunc(s,lookback,ent,ext)
        
        int = 4;
        clear RSIMat;
        col = [ 0.85 0.4 0.3 ];
        lincol = [0.3 0.3 0.3];
        clear gain; clear loss; clear cgain;
        gain(1) = 0; loss(1) = 0;
        RS = 0;
        
        % We need a gain matrix.
        cgain(1) = 0;
        for (i = 2:length(s))
           cgain(i) = s(i,int) - s(i-1,int);
        end
        
        % First calculate matrices for average gain and loss.
        
        for (i = 1:lookback)
            if (cgain(i) >= 0)
                gain(1) = gain(1) + cgain(i);
            else
                loss(1) = loss(1) + abs(cgain(i));
            end
        end
        
        gain(1) = gain(1) / lookback;
        loss(1) = loss(1) / lookback;
        
        for (i = lookback + 2:length(s))
            gain(i - lookback) = 0;
            loss(i - lookback) = 0;
            
            % We first substract the first current gain.
            if ( cgain(i - lookback - 1 ) >= 0)
                gain(i - lookback) = gain(i - lookback - 1) * lookback - cgain(i - lookback - 1 );
            else
                loss(i - lookback) = loss(i - lookback - 1) * lookback - abs(cgain(i - lookback - 1 ));
            end
            
            
            % We add the current gain now.
            if ( cgain(i) >= 0)
                gain(i - lookback) = gain(i - lookback) + cgain(i);
            else
                loss(i - lookback) = loss(i - lookback) + abs(cgain(i));
            end
            
            
            for (j = i - lookback: i - 1)
                if ( cgain(j) >= 0 )
                    gain(i - lookback) = gain(i - lookback) + cgain(j);
                else
                    loss(i - lookback) = loss(i - lookback) + abs(cgain(j));    
                end
            end
            
            gain(i - lookback) = gain(i - lookback) / lookback;
            loss(i - lookback) = loss(i - lookback) / lookback;
            
        end
        
        for (i = 1:length(gain))
           RSIMat(i) = 100 - ( 100 / ( 1 + gain(i) / loss(i) ) ); 
        end
        
        xaxis = [lookback+1:length(s)];
        plot(xaxis,RSIMat,'LineWidth',2,'Color',col);
        
        % We now implement our trading strategy.
        hold on;
        line([1 length(s)],[ent ent],'LineWidth',1,'Color',lincol);
        line([1 length(s)],[ext ext],'LineWidth',1,'Color',lincol);
    
        text(0,ent,[' ENTER time:',num2str(ent)],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',10,'FontName','Monaco')
        text(0,ext,[' EXIT time:',num2str(ext)],...
                'VerticalAlignment','top',...
                'HorizontalAlignment','left',...
                'FontSize',10,'FontName','Monaco')        
        hold off;
        
        mark = 1;
        start = 1;
        count = 1;
        if ( RSIMat(1) > ent )
            for (i = 1:length(RSIMat))
                if (RSIMat(i) < ent)
                   start = i;
                   break;
                end
                start = length(RSIMat);
            end
        end

        % Start the check from here (count), change the mark accordingly.
        % We start from mark = 1. And we condition on the value of mark.
        clear STR_R;
        for (i = start:length(RSIMat))
            if (mark == 1)
               if ( RSIMat(i) > ent)
                  STR_R(count,1) = i + lookback;
                  mark = 2; 
               end
            end
            if (mark == 2)
               if ( RSIMat(i) > ext)
                  mark = 3; 
               end
            end
            if (mark == 3)
               if ( RSIMat(i) < ext)
                  mark = 4;
                  STR_R(count,2) = i + lookback;
                  count = count + 1;
               end
            end
            if (mark == 4)
                if (RSIMat(i) < ent)
                   mark = 1; 
                end
            end
        end


        % Cover if only one buy signal.
        if (length(STR_R(1,:)) == 1)
            STR_R(1,2) = 0;
        end

        % Plot the buy / sell signals.

        hold on;
        for (i = 1:length(STR_R(:,1)))
            plot(STR_R(i,1),RSIMat(STR_R(i,1)-lookback),'r^','MarkerSize',8,'MarkerFaceColor','r');     % Mark intersection with red arrow.
            text(STR_R(i,1),RSIMat(STR_R(i,1)-lookback),[' Buy at ',num2Str(STR_R(i,1))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
            text(STR_R(i,1),RSIMat(STR_R(i,1)-lookback),[' Pr: ',num2str(s(STR_R(i,1),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          if (STR_R(i,2) > 0)
          plot(STR_R(i,2),RSIMat(STR_R(i,2)-lookback),'bv','MarkerSize',8,'MarkerFaceColor','b');     % Mark intersection with blue arrow.
          text(STR_R(i,2),RSIMat(STR_R(i,2)-lookback),[' Sell at ',num2str(STR_R(i,2))],...
                    'VerticalAlignment','top',...
                    'HorizontalAlignment','left',...
                    'FontSize',12,'FontName','Monaco')
          text(STR_R(i,2),RSIMat(STR_R(i,2)-lookback),[' Pr: ',num2str(s(STR_R(i,2),4))],...
                    'VerticalAlignment','bottom',...
                    'HorizontalAlignment','left',...
                    'FontSize',14,'FontName','Monaco')
          end
        end
        hold off;
        
        set(gca,'FontName','Monaco');
        ylabel('RSI indicator (%)');
        linkaxes(sdisplay,'x');
        axis([0 length(s) 0 100]);
        grid on;
        
end

% Our private SMA and EMA function.
function EAVGorig = expavg1(s,period)

    int = 4;
    
    % Need to reverse the matrix.
    %for (i = 1:length(s))
    %   temp(length(s)-i+1,:) = s(i,:); 
    %end
    %s = temp;
    
    % Calculate the SMA for the first point.
    tot = 0;
    for (i = 1:period)
        tot = tot + s(i);
        EAVG(period) = (tot / period );
    end
    
    % Calculate the multiplier.
    mul = (2 / (period + 1) );
   
    % Form the Exponential moving average matrix.
    for (i = period+1:length(s))
       EAVG(i) = ( s(i,4) - EAVG(i-1) ) * mul + EAVG(i-1);         
    end

    xaxis = [period:length(EAVG)];
    EAVGorig = EAVG;
    EAVG(1:period - 1) = [];
    %plot(xaxis,EAVG,'LineWidth',1,'Color',[0.3 0.1 0.8]);
    set(gca,'FontName','Monaco');    
    %title('Exponential Moving average with parameter -');
    set(gcf, 'Name', 'Exponential Moving average with parameter -');
    grid on;
end

function MAVGorig = movavg1(s,day)

    int = 4;
    % Need to reverse the matrix.
    %for (i = 1:length(s))
    %   temp(length(s)-i+1,:) = s(i,:); 
    %end
    %s = temp;
    
    % Form a new matrix.
    for (i = day:length(s))
        tot = 0;
        for (j = i-day+1:i)
            tot = tot + s(j,int);
        end
        
        MAVG(i) = ( tot / day );
        
    end

    xaxis = [day:length(MAVG)];
    MAVGorig = MAVG;
    MAVG(1:day-1) = [];
    %curplot = plot(xaxis,MAVG,'LineWidth',1,'Color',[0.8 0.1 0.1]);
    set(gca,'FontName','Monaco');    
    title(['Simple Moving average with parameter' inputname(2) ]);
    set(gcf, 'Name', 'Simple Moving average with parameter -');
    grid on;
    
end

% Our private Bollinger function.
function bol(s,per,mul)

    int = 4;
    
    % Need to reverse the matrix.
    for (i = 1:length(s))
       temp(length(s)-i+1,:) = s(i,:); 
    end
    s = temp;
    
    % Now calculate the 20-day mean.
    
    
    for (i = per:length(s))
    % The loop to start the standard deviation matrix starts here.    
            
        % First get the mean.
        tot = 0;
        for (j = i-per+1:i)
            tot = tot + s(j,4);
        end
        mean = tot / per;
    
        clear dev;
        % Now we get the deviation.
        for (j = i-per+1:i)
            dev(j) = s(j,4) - mean;
        end
        
        % Square the deviation.
        dev2 = dev.^2;
        sdmat(i) = sqrt(sum(dev2) / per);
    
    end

    % For our Bollinger band, we want to calculate the matrix for SMA.
    
    for (i = per:length(s))
        tot = 0;
        for (j = i-per+1:i)
            tot = tot + s(j,int);
        end
        SMA(i) = ( tot / per );
        
    end
    
    UPPER = SMA + (sdmat * mul);
    LOWER = SMA - (sdmat * mul);
    xaxis = [1:length(SMA)];
    hold on;
    bolband1 = plot(xaxis,SMA,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1);  
    bolband2 = plot(xaxis,UPPER,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');
    bolband3 = plot(xaxis,LOWER,'LineWidth',1,'Color',[0.5 0.1 0.6],'LineWidth',1,'LineStyle','--');
    hold off;
    set(gca,'FontName','Monaco');    
    title([stockname ' with indicator Bollinger band:' num2str(bol_per) ',' num2str(bol_mul)],'FontSize',10);
    set(gcf, 'Name', [stockname ' with indicator Bollinger band:' num2str(bol_per) ',' num2str(bol_mul)]);
    % set(gcf,'Position',[100 500 1100 700]);
    grid on;
end


end