function tradingDemo

    % Display the GUI window
    GUI = [];
    initGUI();

    % Display the initial GUI window
    function initGUI()

        % Initialize some data
        GUI.cycle = 0;
        GUI.lastPortfolio = [];
        GUI.selectedRow = 1;
        GUI.trading = false;
        GUI.accountName = 'DU32943';

        % Stop all existing timers
        try stop(timerfindall);    catch; end
        try delete(timerfindall);  catch; end

        % Create a new figure
        GUI.hFig = findall(0, '-depth',1, 'type','figure', 'Name','Trading demo');
        if isempty(GUI.hFig)
            GUI.hFig = figure('Name','Trading demo', 'NumberTitle','off', 'Visible','off', 'Color','w', 'Position',[100,100,900,600], 'Toolbar','none', 'MenuBar','none');
        else
            clf(GUI.hFig);
            hc=findall(gcf); delete(hc(2:end));  % bypass javacomponent-clf bug on R2012b-R2013a
        end
        drawnow; pause(0.05);
        oldWarn = warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
        javaFrame = get(handle(GUI.hFig),'JavaFrame');
        warning(oldWarn);
        folder = fileparts(mfilename('fullpath'));
        newIcon = javax.swing.ImageIcon([folder '/dollar.png']);
        javaFrame.setFigureIcon(newIcon);
        set(GUI.hFig,'Visible','on');
        drawnow; pause(0.05);

        % Prepare the clock (time) label
        timeStr = strrep(datestr(now, 'mmm dd-HH:MM:SS'),'-',char(10));
        GUI.hTimeLabel = uicontrol('Style','text', 'Units','norm', 'Position',[0,.8,.2,.17], 'FontSize',20, 'Background','w', 'String',timeStr);

        % Start the periodic clock update timer
        start(timer('Tag','periodicClock', 'Period',0.5, 'ExecutionMode','FixedDelay', 'StartDelay',0.0, 'ErrorFcn','', 'TimerFcn',@periodicClockFcn));

        % Display the main title
        GUI.hTitle = uicontrol('Style','text', 'Units','norm', 'Position',[.2,.8,.6,.17], 'FontSize',20, 'Background','w', 'Foreground','b', 'String',['Demo trading' 10 'application']);

        % Display the logo (animated GIF)
        displayLogo(GUI.hFig, [folder '/dollar_animated_64x64.gif']);

        % Prepare the resizable panels
        oldWarn = warning('off','MATLAB:hg:PossibleDeprecatedJavaSetHGProperty');
        hMainPanel = uipanel('Units','norm', 'Position',[0,0,1,.78], 'BorderType','none', 'Background','w');
        [hLeftPanel, hRightPanel, hDivider] = uisplitpane(hMainPanel, 'DividerColor',.95*[1,1,1]); %#ok<NASGU>
        [hLeftBottomPanel,  hLeftTopPanel,  hLeftDivider]  = uisplitpane(hLeftPanel,  'Orientation','Vertical'); %#ok<NASGU>
        [hRightBottomPanel, hRightTopPanel, hRightDivider] = uisplitpane(hRightPanel, 'Orientation','Vertical'); %#ok<NASGU>
        warning(oldWarn);

        % Prepare the log editbox
        GUI.hLogPanel = uicontrol('style','edit', 'max',5, 'Parent',hLeftBottomPanel, 'Units','norm', 'Position',[0,0.2,1,0.8], 'Background','w');
        jScroll = findjobj(GUI.hLogPanel);
        try jScroll = jScroll(1); catch; end
        try
            jScroll.setVerticalScrollBarPolicy(jScroll.java.VERTICAL_SCROLLBAR_AS_NEEDED);
            %jScroll.setBorder([]);
            jScroll = jScroll.getViewport;
        catch
            % may possibly already be the viewport
        end
        GUI.jLogPanel = handle(jScroll.getView,'CallbackProperties');
        GUI.jLogPanel.setEditable(false);
        set(GUI.jLogPanel,'HyperlinkUpdateCallback',@linkCallbackFcn);
        logMessage(GUI.jLogPanel, 'Initializing GUI...');

        % Add the action buttons: <Clear log>, <Close positions>, <Pause/Resume trading>
        initButton(hLeftBottomPanel, [.00,.01,.3,.18], 'Clear log',       @(varargin) GUI.jLogPanel.setText(''));
        initButton(hLeftBottomPanel, [.35,.01,.3,.18], 'Close positions', @closePositions);
        initButton(hLeftBottomPanel, [.70,.01,.3,.18], 'Start trading',   @toggleTrading);

        % Prepare the axes
        GUI.axTop    = axes('Parent',hRightTopPanel,    'XColor',[.4,.4,.4], 'YColor',[.4,.4,.4]);
        GUI.axBottom = axes('Parent',hRightBottomPanel, 'XColor',[.4,.4,.4], 'YColor',[.4,.4,.4]);
        GUI.hTopLine    = line('Visible','off', 'Parent',GUI.axTop);
        GUI.hBottomLine = line('Visible','off', 'Parent',GUI.axBottom);
        title(GUI.axBottom, 'P & L');

        % Link all subplots
        %linkaxes([GUI.axTop, GUI.axBottom],'x')
        %linkprop([GUI.axTop, GUI.axBottom],{'XLim','XTickLabel','Xtick'});
        %axes(GUI.axTop);
        %dynamicDateTicks([GUI.axTop, GUI.axBottom]);
        datetick(GUI.axTop,    'x', 'HH:MM:SS')
        datetick(GUI.axBottom, 'x', 'HH:MM:SS')

        % Prepare the data table
        initDataTable(hLeftTopPanel);

        % Add the ticks-display checkbox
        GUI.cbTicks = uicontrol('Parent',hLeftTopPanel, 'Style','checkbox', 'Value',0, 'String','Log live ticks', 'Units','pixel', 'Position',[5,5,100,20], 'Background','w');

        % Check for the existence of IB-Matlab
        if isempty(which('IBMatlab'))
            logMessage(GUI.jLogPanel, 'IB-Matlab application not found - ', 'error')
            logMessage(GUI.jLogPanel, 'contact Yair Altman:</font> <font color="blue"><a href="mailto:altmany@gmail.com?subject=IB-Matlab+for+demo&body=Hi Yair,">altmany@gmail.com</a>', 'error')
        end

        % Update the historical data for all portfolio securities (1st cycle only)
        getHistoricalData();

        % Start the periodic GUI update timer
        logMessage(GUI.jLogPanel, 'Starting update timer...');
        GUI.inDataCallback = false;
        start(timer('Tag','periodicUpdate', 'Period',0.5, 'ExecutionMode','FixedDelay', 'StartDelay',0.0, 'ErrorFcn','', 'TimerFcn',@periodicUpdateFcn));

    end  % initGUI

    % Initialize a specific GUI button
    function initButton(hParent, position, label, callback)
        name = genvarname(label);
        label = strrep(label, ' ', char(10));
        hAxes = axes('Parent',hParent, 'Units','norm', 'Position',position, 'Color',[.3,.3,1], ...
                     'Box','off', 'Xtick',[], 'YTick',[], 'YColor','w', 'XColor','w');
        hText = text(0.5, 0.5, label, 'Parent',hAxes, 'tag',['tx' name], 'Color','k', ...
                     'Horizontal','center', 'FontName','Helvetica', 'FontSize',12, 'Fontweight','bold');
        set([hAxes,hText], 'ButtonDownFcn',{callback,hAxes,hText});
        GUI.(['ax' name]) = hAxes;
        GUI.(['tx' name]) = hText;

        % Create rounded button corners
        N=200; a=2*pi*(0:N)/N;  % number of vertix points
        sa=sin(a);
        ca=cos(a);  ca=0.2*ca+0.7*sign(ca);
        vert = [ca,1.2,1.2,-1.2,-1.2,1.2,1.2; sa,0,-1.2,-1.2,1.2,1.2,0]';
        vert = 0.5 + 0.5*vert;
        p = patch('Parent',hAxes, 'Vertices',vert, 'Faces',1:size(vert,1), 'FaceColor','w', 'EdgeColor','none');
        try set(p, 'LineSmooth','on'); catch, end  % HG1 only
        set(hAxes,'XLim',[0,1],'YLim',[0,1]);
        set(GUI.hFig,'Renderer','painters');  % patch changes to OpenGL which hides the axData labels
    end  % initButton

    % Prepare the data table
    function initDataTable(hParent)
        % Display an empty data table
        GUI.tableData = {'Symbol','Local','Exchange','Type','Position','Cost','Latest','Value','Quotes'};
        GUI.hTable = uitable('Data',GUI.tableData, 'ColumnName','', 'RowName','', ...
                             'Parent',hParent, ... 'Enable','inactive', 
                             ... 'ColumnEditable',false(1,numCols), ...
                             'CellSelectionCallback',@tbCellSelection_Callback, ...
                             ... 'ColumnWidth',num2cell(80*ones(1,10)), ...  % this needs to be done below since it gets reset by the new table model
                             'FontSize',8, 'FontName','Helvetica', ...
                             'Units','norm', 'Pos',[0,0,1,1]);
        drawnow;
        pause(0.05);

        % Add special Java-based formatting to the data table
        formatDataTable();
    end  % initDataTable

    % Add special Java-based formatting to the data table
    function formatDataTable()
        % Some basic stuff
        jScroll = findjobj(GUI.hTable);
        try jScroll = jScroll(1); jScroll = jScroll.getViewport;  catch, end  % may possibly already be the viewport
        try jScroll = jScroll.getComponent(0).getViewport;  catch, end  % HG2
        jTable = jScroll.getView;
        %jTable.setEditable(false)  % 'Enable'='inactive' above is better
        jTable.setColumnResizable(true);

        % Cell selection callback - entire row
        jTable.setNonContiguousCellSelection(false);
        jTable.setRowSelectionAllowed(true);
        jTable.setColumnSelectionAllowed(false);
        set(jTable.getSelectionModel,'ValueChangedCallback',@tbCellSelection_Callback);

        % Note: we don't use uitable's CellSelectionCallback because it requires Enable=on which allows editing
        %set(handle(jTable,'CallbackProperties'), 'MouseClickedCallback',@tbCellSelection_Callback);  % no good - doesn't work...

        % Disable editing
        ce = javax.swing.DefaultCellEditor(javax.swing.JTextField);
        ce.setClickCountToStart(intmax);  % =never...
        for colIdx = 0 : jTable.getColumnCount-1
            jTable.getColumnModel.getColumn(colIdx).setCellEditor(ce);
        end

        % Set the table to span the entire available width
        jTable.setAutoResizeMode(jTable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);

        % Some formatting magic...
        jTable.getTableHeader.setVisible(false);
        jTable.getTableHeader.getParent.setBackground(java.awt.Color.white);
        jTable.getParent.getParent.setBackground(java.awt.Color.white);
        jTable.getParent.setBackground(java.awt.Color.white);
        jTable.setBackground(java.awt.Color.white);
        jTable.getParent.getParent.setBorder([]);

        % All done - repaint
        jTable.repaint
        GUI.jTable = jTable;
        return;  % debug point
    end  % initDataTable

    % Update the data table with updated portfolio data
    function updateDataTable(portfolioData)
        %if GUI.jTable.getRowCount ~= length(portfolio)+1
            %logMessage(GUI.jLogPanel, 'Updating portfolio data table...');
            data = get(GUI.hTable,'Data');
            data(2:end,:) = [];  % delete data rows (keep header row)
            for idx = 1 : length(portfolioData)
                rowData = portfolioData(idx);
                cost = rowData.averageCost;
                if ~isempty(rowData.contract.m_multiplier)
                    cost = cost / str2double(rowData.contract.m_multiplier);
                end
                fieldname = genvarname(rowData.localSymbol);
                try numQuotes = GUI.marketData.(fieldname).idx; catch, numQuotes = 0; end
                data(idx+1,:) = {rowData.symbol, rowData.localSymbol, rowData.exchange, ...
                                 rowData.secType, rowData.position, ...
                                 round(1e4*cost)/1e4, ...
                                 round(1e4*rowData.marketPrice)/1e4, ...
                                 round(rowData.marketValue), ...
                                 numQuotes};
            end
            GUI.tableData = data;
            set(GUI.hTable,'Data',data);
            GUI.jTable.changeSelection(GUI.selectedRow, 0, false, false);
            drawnow; pause(0.02);
            formatDataTable();
        %end
    end  % updateDataTable

    % Refresh data table & issue trade order
    function refreshData()
        try
            % Issue a new trade order
            if GUI.trading && ~isempty(GUI.lastPortfolio)
                numContracts = length(GUI.lastPortfolio);
                contractIdx = randi(numContracts);
                quantity = randi(3) - 2;  % -1, 0 or +1
                tradeContract(contractIdx, quantity);
            end

            % Get the latest portfolio data
            GUI.inDataCallback = true;
            portfolioData = IBMatlab('action','portfolio', 'MsgDisplayLevel',1, 'CallbackMessage',@apiMessage, 'AccountName',GUI.accountName);

            % Update the data table
            %if ~isequal(GUI.lastPortfolio, portfolioData)
                %GUI.lastPortfolio, portfolioData      % debug
                %disp(datestr(now,'<= HH:MM:SS.FFF'))  % debug
                GUI.lastPortfolio = portfolioData;

                % Update the uitable
                updateDataTable(portfolioData);
            %end
            drawnow;
        catch
            % Maybe IB-Matlab is not available...
            err = lasterror;   %#ok<LERR,NASGU>
        end
    end  % refreshData

    % Periodically update the GUI
    function periodicUpdateFcn(hTimer,eventData) %#ok<INUSD>
        % Update the log box's scrollbars (gets reset by Matlab...)
        jScroll = GUI.jLogPanel.getParent.getParent;
        jScroll.setVerticalScrollBarPolicy(jScroll.VERTICAL_SCROLLBAR_AS_NEEDED);

        % Refresh the data table every 5 secs
        %disp([datestr(now) ' - ' num2str(GUI.cycle)])
        if ~GUI.inDataCallback && mod(GUI.cycle,10)==9
            refreshData();
        end
        GUI.inDataCallback = false;
        GUI.cycle = GUI.cycle + 1;

        % Update the axes
        updateAxes();
    end  % periodicUpdateFcn

    % Periodically update the display timer
    function periodicClockFcn(hTimer,eventData) %#ok<INUSD>
        % Update the timestamp label
        try
            newLabel = strrep(datestr(now, 'mmm dd-HH:MM:SS'),'-',char(10));
            set(GUI.hTimeLabel, 'String',newLabel);
        catch
            stop(hTimer);
            delete(hTimer);
        end
    end  % periodicClockFcn

    % Update the data axes
    function updateAxes()
        try
            if ~ishandle(GUI.axTop),  return;  end  % sanity check

            % Get the latest selected row's data
            rowData = GUI.tableData(GUI.selectedRow+1,:);
            fieldname = genvarname(rowData{2});  % localSymbol
            data = GUI.marketData.(fieldname);

            % Update the top axes
            title(GUI.axTop, [rowData{2} ' @ ' rowData{3}]);
            firstIdx = max(1, data.idx - 899);  % Last 15 mins only
            xdata = data.dateNum(firstIdx:data.idx) - floor(data.dateNum(firstIdx));
            ydata = data.price(firstIdx:data.idx);
            set(GUI.hTopLine, 'XData',xdata, 'YData',ydata, 'Visible','on');
            xdataLim = [xdata(1),xdata(end)];
            set(GUI.axTop, 'XLim',xdataLim);

            % Updating the X labels takes time and is unnecessary, so do it only once every few secs
            if mod(GUI.cycle,10)==1
                datetick(GUI.axTop,'x', 'HH:MM', 'keeplimits');
            end
        catch
            % never mind...
            err = lasterror;   %#ok<LERR,NASGU>
            %GUI
        end

        try
            % Update the bottom axes
            currency = GUI.lastPortfolio(GUI.selectedRow).currency;
            title(GUI.axBottom, ['P&L [1000 ' currency ']']);
            pnl = rowData{8} * (ydata-rowData{6}) / 1000;
            set(GUI.hBottomLine, 'XData',xdata, 'YData',pnl, 'Visible','on');
            set(GUI.axBottom, 'XLim',xdataLim);

            % Updating the X labels takes time and is unnecessary, so do it only once every few secs
            if mod(GUI.cycle,10)==1
                datetick(GUI.axBottom,'x', 'HH:MM', 'keeplimits');
            end
        catch
            % never mind...
            err = lasterror;   %#ok<LERR,NASGU>
        end
        drawnow;
    end  % updateAxes

    % Select a different table row
    function tbCellSelection_Callback(hTable, eventData) %#ok<INUSL>
        try
            selectedRow = eventData.Indices(1) - 1;
        catch
            selectedRow = eventData.getSource.getMinSelectionIndex;
        end
        if selectedRow <= 0  % =header row (unselectable)
            GUI.jTable.changeSelection(GUI.selectedRow, 0, false, false);
        else
            GUI.selectedRow = selectedRow;
        end
    end  % tbCellSelection_Callback

    % Get the historical data for all portfolio securities
    function getHistoricalData()
        try
            % Get the account's portfolio
            refreshData();

            % Get the historical data for all the portfolio securities
            N = 10000;  % max space for data
            GUI.marketData = [];
            GUI.marketData.IDs = containers.Map('KeyType','double','ValueType','char');
            for idx = 1 : length(GUI.lastPortfolio)
                % Get the latest historical data for this security
                rowData = GUI.lastPortfolio(idx);
                fieldname = genvarname(rowData.localSymbol);
                logMessage(GUI.jLogPanel, ['Retrieving historical data for ' rowData.localSymbol ' @ ' rowData.exchange '...'], 'info');
                contractParams = {'symbol',rowData.symbol, 'localSymbol',rowData.localSymbol, ...
                                  'secType',rowData.secType, 'currency',rowData.currency, ...
                                  'expiry',rowData.expiry, 'exchange',strrep(rowData.exchange,'NASDAQ','SMART')};
                data = IBMatlab('action','history', contractParams{:}, 'WhatToShow','MidPoint', ...
                                'barSize','1 secs', 'durationValue',900, 'DurationUnits','S');

                % Pre-allocate space for the streaming data
                [dateNums, sortedIdx] = sort(data.dateNum);
                dataStruct = struct('security',rowData, 'dateNum',dateNums, 'price',data.close(sortedIdx), 'idx',length(data.close));
                dataStruct.dateNum(end+1:N) = NaN;
                dataStruct.price  (end+1:N) = NaN;
                GUI.marketData.(fieldname) = dataStruct;

                % Start collecting streaming quotes data
                reqId = IBMatlab('action','query', contractParams{:}, 'QuotesNumber',inf, 'ReconnectEvery',inf, 'CallbackTickPrice',@tickPriceCallback);
                if isstruct(reqId)
                    dummy = IBMatlab('action','query', contractParams{:}, 'QuotesNumber',0,   'CallbackTickPrice',@tickPriceCallback);  %#ok<NASGU> % close streaming
                    pause(1);
                    reqId = IBMatlab('action','query', contractParams{:}, 'QuotesNumber',inf, 'CallbackTickPrice',@tickPriceCallback);              % restart streaming
                end  % might happen from a previous streaming session
                GUI.marketData.IDs(reqId) = fieldname;
                GUI.marketData.(fieldname).reqId = reqId;

                % Update the axes
                updateAxes();

                % Update the data table with the number of quotes
                updateDataTable(GUI.lastPortfolio);

                % Pause a bit before continuing to the next portfolio security, to prevent possible IB pacing violation
                pause(1);
                continue;  % debug breakpoint
            end
        catch
            err = lasterror;   %#ok<LERR,NASGU>
        end
    end  % getHistoricalData

    % TickPrice event callback (for streaming quotes)
    function tickPriceCallback(ibConnectionObject, eventData)
        global gGUI  % used for debugging only, not used by the application
        try
            % If GUI has existed, stop collecting data
            reqId = eventData.tickerId;
            if ~ishandle(GUI.hFig)
                ibConnectionObject.cancelMktData(reqId);
            else
                % Append the streaming quotes to the contract data
                fieldType = eventData.field;
                if fieldType == com.ib.client.TickType.BID  % ASK=1, BID==2, LAST==4, CLOSE==9
                    fieldname = GUI.marketData.IDs(reqId);
                    newIdx = GUI.marketData.(fieldname).idx + 1;
                    GUI.marketData.(fieldname).price(newIdx) = eventData.price;
                    GUI.marketData.(fieldname).dateNum(newIdx) = now;
                    GUI.marketData.(fieldname).idx = newIdx;
                    fieldname = strrep(fieldname, '0x2E','.');
                    msg = sprintf('%s %s (#%d) = %g', datestr(now,'HH:MM:SS.FFF'), fieldname, newIdx, eventData.price);
                    if get(GUI.cbTicks, 'Value')
                        % Display the live ticks in the log panel
                        logMessage(GUI.jLogPanel, msg);
                    else
                        % Display the live ticks in the Command Window
                        %fprintf('%s\n',msg);
                    end
                    gGUI = GUI;  % used for debugging only, not used by the application
                end
            end
        catch
            % ignore...
        end
    end  % tickPriceCallback

    % Handle API log messages
    function apiMessage(ibConnection,eventData,varargin) %#ok<INUSL>
        try
            msg = strrep(char(eventData.message), ':', ': ');
            if ~strcmpi(eventData.type,'msg2') || (eventData.data2 < 2000 && eventData.data2 ~= 300)
                logMessage(GUI.jLogPanel, msg, 'error');
            elseif ~ismember(eventData.data2,[2100,2107,300])  % ignore: API has been unsubscribed from client data; Market data farm connection is OK;  Can't find EId with tickerId
                %msg = [eventData.message ' (' num2str(eventData.data2) ')'];
                logMessage(GUI.jLogPanel, msg, 'info');
            end
        catch
            % never mind...
        end
    end  % apiMessage

    % Trade a specific contract
    function tradeContract(contractIdx, quantity)
        rowData = GUI.lastPortfolio(contractIdx);
        contractParams = {'symbol',rowData.symbol, 'localSymbol',rowData.localSymbol, ...
                          'secType',rowData.secType, 'currency',rowData.currency, ...
                          'expiry',rowData.expiry, 'exchange',strrep(rowData.exchange,'NASDAQ','SMART')};
        if quantity == 0
            msg = 'Decided not to trade in this cycle';
        elseif quantity > 0
            orderId = IBMatlab('action','buy', contractParams{:}, 'quantity',quantity, 'type','mkt');
            msg = sprintf('Buying %d %s (%s) on %s => order ID=%d', quantity, rowData.localSymbol, rowData.secType, rowData.exchange, orderId);
        else  % quantity < 0
            orderId = IBMatlab('action','sell', contractParams{:}, 'quantity',-quantity, 'type','mkt');
            msg = sprintf('Selling %d %s (%s) on %s => order ID=%d', -quantity, rowData.localSymbol, rowData.secType, rowData.exchange, orderId);
        end
        logMessage(GUI.jLogPanel, msg, 'warning');
    end  % tradeContract

    % Button callback - close all open positions
    function closePositions(varargin)
        for contractIdx = 1 : length(GUI.lastPortfolio)
            quantity = -GUI.lastPortfolio(contractIdx).position;
            if quantity ~= 0
                tradeContract(contractIdx, quantity);
            end
        end
    end  % closePositions

    % Button callback - pause/resume trading
    function toggleTrading(hObject,eventData,hAxes,hText) %#ok<INUSL>
        GUI.trading = ~GUI.trading;
        if GUI.trading
            set(hText,'String',['Pause' 10 'trading']);
            set(hAxes,'Color','r');
        else
            set(hText,'String',['Resume' 10 'trading']);
            set(hAxes,'Color','g');
        end
    end  % toggleTrading

end % tradingDemo

% Display the logo (animated GIF)
function displayLogo(hParent, logoFilename)
    htmlStr = ['<html><img src="file:/' logoFilename '">'];
    je = javax.swing.JEditorPane('text/html', htmlStr);
    je.setEditable(false);
    [hje, container] =  javacomponent(je,[],hParent); %#ok<ASGLU>
    set(container, 'Units','norm', 'Pos',[0.8,0.8,0.2,0.18])
end  % displayLogo

% Log message utility
function logMessage(jEditbox,text,severity)
    % Ensure we have an HTML-ready editbox
    HTMLclassname = 'javax.swing.text.html.HTMLEditorKit';
    if ~isa(jEditbox.getEditorKit,HTMLclassname)
        jEditbox.setContentType('text/html');
    end

    % Parse the severity and prepare the HTML message segment
    if nargin<3,  severity='info';  end
    switch lower(severity(1))
        case 'i',  icon = 'greenarrowicon.gif'; color='gray';
        case 'w',  icon = 'demoicon.gif';       color='black';
        otherwise, icon = 'warning.gif';        color='red';
    end
    icon = fullfile(matlabroot,'toolbox/matlab/icons',icon);
    iconTxt =['<img src="file:///',icon,'" height=16 width=16>'];
    msgTxt = ['&nbsp;<font color=',color,'>',datestr(now,'HH:MM:SS'),'&nbsp;',text,'</font>'];
    newText = [iconTxt,msgTxt];
    endPosition = jEditbox.getDocument.getLength;
    if endPosition>0, newText=['<br/>' newText];  end

    % Place the HTML message segment at the bottom of the editbox
    currentHTML = char(jEditbox.getText);
    jEditbox.setText(strrep(currentHTML,'</body>',newText));
    endPosition = jEditbox.getDocument.getLength;
    jEditbox.setCaretPosition(endPosition); % end of content
end  % logMessage

% Hyperlink callback function
function linkCallbackFcn(src,eventData) %#ok<INUSL>
    url = eventData.getURL;      % a java.net.URL object
    switch char(eventData.getEventType)
        case char(eventData.getEventType.ACTIVATED)
            %jEditbox.setPage(url);
            web([char(url.getProtocol) ':' char(url.getFile)]);
    end
end

% TODO - indicate trades on graphs
% TODO - graph line/color/style to differentiate historical data / streaming quotes
% TODO - execution callback (update log, alert via email)
% TODO - Table headers colors
