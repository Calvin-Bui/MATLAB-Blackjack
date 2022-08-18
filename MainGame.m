close all;
clear all;
clc;

Win = 1;
Lose = 0;
Draw = 2;
NatWin = 3;
player1 = 0;
gameover = 1;
gend = 0;

samount = 500.00; %starting balance
fprintf('Current balance: $%.2f \n',samount)

% User Defined functions to call audio files to play
winningg = load('handel');
losingg = load('splat');
drawwws = load('laughter');

while gameover == 1 && samount > 0
    gend = 0;
    bamount = input('Enter your bet: '); %bet amount
    
    while bamount < 2 || bamount > samount
        if bamount > samount
            fprintf('Not enough funds \n')
        elseif bamount < 2
            fprintf('Invalid amount \n')
        end
        bamount = input('Enter your bet: ');
    end
    
    samount = samount - bamount;
    fprintf('Current balance: $%.2f \n',samount)
    
    %%%%% SHUFFLE %%%%
    deck = 1:52;
    shuffled = zeros(size(deck));
    
    for q=1:52
        k=ceil(52*rand);
        shuffled(q) = deck(k);
        while sum(shuffled(1,(1:q-1)) == k) > 0
            k=ceil(52*rand);
            shuffled(q) = deck(k);
        end
    end
    
    %%%% Assigning Card Value %%%%
    suits = 1:52; %suits
    cvalue = 1:52; %card value
    for hhhhhh = 1:52
        for h1=1:13
            if shuffled(hhhhhh)== h1
                suits(hhhhhh) = 1;
            end
        end
        for h2=14:26
            if shuffled(hhhhhh)== h2
                suits(hhhhhh) = 2;
            end
        end
        for h3=27:39
            if shuffled(hhhhhh)== h3
                suits(hhhhhh) = 3;
            end
        end
        for h4=40:52
            if shuffled(hhhhhh)== h4
                suits(hhhhhh) = 4;
            end
        end
        if mod (shuffled(hhhhhh),13) == 1
            cvalue(hhhhhh) = 11;
        elseif mod (shuffled(hhhhhh),13) == 2
            cvalue(hhhhhh) = 2;
        elseif mod (shuffled(hhhhhh),13) == 3
            cvalue(hhhhhh) = 3;
        elseif mod (shuffled(hhhhhh),13) == 4
            cvalue(hhhhhh) = 4;
        elseif mod (shuffled(hhhhhh),13) == 5
            cvalue(hhhhhh) = 5;
        elseif mod (shuffled(hhhhhh),13) == 6
            cvalue(hhhhhh) = 6;
        elseif mod (shuffled(hhhhhh),13) == 7
            cvalue(hhhhhh) = 7;
        elseif mod (shuffled(hhhhhh),13) == 8
            cvalue(hhhhhh) = 8;
        elseif mod (shuffled(hhhhhh),13) == 9
            cvalue(hhhhhh) = 9;
        elseif mod (shuffled(hhhhhh),13) == 10
            cvalue(hhhhhh) = 10;
        elseif mod (shuffled(hhhhhh),13) == 11
            cvalue(hhhhhh) = 10;
        elseif mod (shuffled(hhhhhh),13) == 12
            cvalue(hhhhhh) = 10;
        elseif mod (shuffled(hhhhhh),13) == 0
            cvalue(hhhhhh) = 10;
        end
    end
    
    %%%%%% DEAL CARDS/NATURALS/ACE VALUE %%%%%%
    phand = 0;
    dealer = 0;
    acevalue = 0;
    
    fprintf ('You drew a %s\n', cardvalue(shuffled,suits,1))
    tic
    while toc<1
    end
    fprintf ('The dealer drew a %s\n',cardvalue(shuffled,suits,2))
    tic
    while toc<1
    end
    fprintf ('You drew a %s\n', cardvalue(shuffled,suits,3))
    tic
    while toc<1
    end
    fprintf ('The dealer drew face down card\n') %zz(4)
    %%% ACE VALUE %%%
    
    if cvalue(1) == 11 && cvalue(3) == 11
        cvalue(1) = 1;
    end
    
    %%NATURALS%%
    
    phand = cvalue(1) + cvalue(3);
    dealer = cvalue(2) + cvalue(4);
    if phand == 21 && dealer ~=21
        fprintf ('You got a natural, you win \n')
        sound(winningg.y,winningg.Fs)
        player1 = Win;
        gend = 1;
    elseif phand ~= 21 && dealer == 21
        fprintf ('The dealer got a natural, you lose \n')
        sound(losingg.y,losingg.Fs)
        player1 = Lose;
        gend = 1;
    elseif phand == 21 && dealer == 21
        fprintf ('You and the dealer got naturals, Draw!, you get your money back \n')
        player1 = Draw;
        sound(drawwws.y,drawwws.Fs)
        gend = 1;
    end
    %%%%%% Stand/Hit & Dealers Play%%%%%%
    temp = 0;
    temp1 = 4;
    if phand < 21 && gend ~= 1
        fprintf('1: Hit\n2: Stand\n')
        temp = input('Hit or Stand?: ');
    end
    while temp ~= 1 && temp ~= 2 && gend ~=1
        fprintf('Invalid Input\n')
        temp = input('Hit or Stand?: \n');
    end
    while temp == 1 %HIT
        temp1 = temp1 +1;
        phand = phand + cvalue(temp1); %Hits
        %Ace Value
        if cvalue(temp1 + 1) == 11 && phand > 21
            cvalue(temp1 + 1) = 1;
        end
        fprintf('You drew a %s\n',cardvalue(shuffled,suits,temp1))
        if phand < 21
            temp = input('Hit or Stand?: \n');
        elseif phand > 21
            tic
            while toc<1
            end
            fprintf('You Bust!\n')
            player1 = Lose;
            fprintf('Dealer flips card: %s\n',cardvalue(shuffled,suits,4))
            temp = 0;
        elseif phand == 21
            % Show dealer hand
            fprintf('Dealer flips card: %s\n',cardvalue(shuffled,suits,4))
            % Dealers Play
            while dealer <= 16
                temp2 = temp1;
                dealer = dealer + cvalue(temp2 + 1);
                %Ace Value
                if cvalue(temp2 + 1) == 11 && dealer > 21
                    cvalue(temp2 + 1) = 1;
                end
                if dealer > 21
                    fprintf('Dealer bust!\n')
                    player1 = Win;
                elseif dealer >= 17
                    fprintf('Dealer stands.\n')
                end
            end
            if phand == dealer
                fprintf('Draw!\n')
                player1 = Draw;
            elseif phand > dealer
                fprintf('Win!\n')
                player1 = Win;
            end
        end
    end
    if temp == 2 %STAND
        % SHOW DEALER HAND
        tic
        while toc<1
        end
        fprintf('Dealer flips card: %s\n',cardvalue(shuffled,suits,4))
        % Dealers Play
        while dealer <= 16
            temp2 = temp1;
            dealer = dealer + cvalue(temp2 + 1);
            %Ace Value
            if cvalue(temp2 + 1) == 11 && dealer > 21
                cvalue(temp2 + 1) = 1;
            end
            temp2 = temp2 + 1;
            tic
            while toc<1
            end
            fprintf('Dealer draws a card: %s\n',cardvalue(shuffled,suits,temp2))
            if dealer > 21
                tic
                while toc<1
                end
                fprintf('Dealer has %d\n',dealer)
                tic
                while toc<1
                end
                fprintf('Dealer bust!\n')
                player1 = Win;
            elseif dealer == 21
                tic
                while toc<1
                end
                fprintf('Dealer has %d\n',dealer)
                tic
                while toc<1
                end
                fprintf('Dealer wins!\n')
                player1 = Lose;
            elseif dealer >= 17
                tic
                while toc<1
                end
                fprintf('Dealer has %d\n',dealer)
                tic
                while toc<1
                end
                fprintf('Dealer stands.\n')
            end
        end
        tic
        while toc<1
        end
        if phand < dealer && dealer < 21
            fprintf('Dealer has higher hand, you lose!\n')
            player1 = Lose;
        elseif phand > dealer && phand < 21
            fprintf('You have a higher hand, you win!\n')
            player1 = Win;
        elseif phand == dealer
            fprintf('Draw!\n')
            player1 = Draw;
        end
    end
    %%%%%%% PAY OUT %%%%%%
    % User Defined functions to call audio files to play
    if player1 == Win %Win
        samount = samount + 2*bamount;
        sound(winningg.y,winningg.Fs)
        % Returns bet + payout
    elseif player1 == Lose %Lose
        sound(losingg.y,losingg.Fs)
    elseif player1 == Draw
        sound(drawwws.y,drawwws.Fs)
        samount = samount + bamount;
    end
    tic
    while toc<1
    end
    fprintf('Current balance: $%.2f \n',samount)
    tic
    while toc<1
    end
    if samount > 0
        fprintf ('Would you like to play another round or cash out? \n')
        tic
        while toc<1
        end
        gameover = input('1: Stay at table\n2: Leave table\n');
        while gameover ~= 1 && gameover ~= 2
            fprintf('Invalid Input\n')
            tic
            while toc<1
            end
            gameover = input('1: Stay at table\n2: Leave table\n');
        end
    elseif samount == 0
        fprintf('You have no more money, Consider withdrawing from life-savings.\n')
        sound(losingg.y,losingg.Fs)
    end
    if gameover==2
        if samount>500
            tempwinnings=samount-500;
            fprintf ('You won $%.2f\n',tempwinnings)
        end
        if samount<500
            templosses = 500 - samount;
            fprintf ('You lost $%.2f\n',templosses)
        end
        if samount == 500
            fprint ('You broke even!\n')
        end
    end
end


function [card1] = cardvalue(shuffled,suits,t)
if suits(t) == 1
    if mod (shuffled(t),13) == 1
        card1 = 'ace of spades';
    elseif mod (shuffled(t),13) == 2
        card1 = 'two of spades';
    elseif mod (shuffled(t),13) == 3
        card1 = 'three of spades';
    elseif mod (shuffled(t),13) == 4
        card1 = 'four of spades';
    elseif mod (shuffled(t),13) == 5
        card1 = 'five of spades';
    elseif mod (shuffled(t),13) == 6
        card1 = 'six of spades';
    elseif mod (shuffled(t),13) == 7
        card1 = 'seven of spades';
    elseif mod (shuffled(t),13) == 8
        card1 = 'eight of spades';
    elseif mod (shuffled(t),13) == 9
        card1 = 'nine of spades';
    elseif mod (shuffled(t),13) == 10
        card1 = 'ten of spades';
    elseif mod (shuffled(t),13) == 11
        card1 = 'jack of spades';
    elseif mod (shuffled(t),13) == 12
        card1 = 'queen of spades';
    elseif mod (shuffled(t),13) == 0
        card1 = 'king of spades';
    end
elseif suits(t) == 2
    if mod (shuffled(t),13) == 1
        card1 = 'ace of clubs';
    elseif mod (shuffled(t),13) == 2
        card1 = 'two of clubs';
    elseif mod (shuffled(t),13) == 3
        card1 = 'three of clubs';
    elseif mod (shuffled(t),13) == 4
        card1 = 'four of clubs';
    elseif mod (shuffled(t),13) == 5
        card1 = 'five of clubs';
    elseif mod (shuffled(t),13) == 6
        card1 = 'six of clubs';
    elseif mod (shuffled(t),13) == 7
        card1 = 'seven of clubs';
    elseif mod (shuffled(t),13) == 8
        card1 = 'eight of clubs';
    elseif mod (shuffled(t),13) == 9
        card1 = 'nine of clubs';
    elseif mod (shuffled(t),13) == 10
        card1 = 'ten of clubs';
    elseif mod (shuffled(t),13) == 11
        card1 = 'jack of clubs';
    elseif mod (shuffled(t),13) == 12
        card1 = 'queen of clubs';
    elseif mod (shuffled(t),13) == 0
        card1 = 'king of clubs';
    end
elseif suits(t) == 3
    if mod (shuffled(t),13) == 1
        card1 = 'ace of diamonds';
    elseif mod (shuffled(t),13) == 2
        card1 = 'two of diamonds';
    elseif mod (shuffled(t),13) == 3
        card1 = 'three of diamonds';
    elseif mod (shuffled(t),13) == 4
        card1 = 'four of diamonds';
    elseif mod (shuffled(t),13) == 5
        card1 = 'five of diamonds';
    elseif mod (shuffled(t),13) == 6
        card1 = 'six of diamonds';
    elseif mod (shuffled(t),13) == 7
        card1 = 'seven of diamonds';
    elseif mod (shuffled(t),13) == 8
        card1 = 'eight of diamonds';
    elseif mod (shuffled(t),13) == 9
        card1 = 'nine of diamonds';
    elseif mod (shuffled(t),13) == 10
        card1 = 'ten of diamonds';
    elseif mod (shuffled(t),13) == 11
        card1 = 'jack of diamonds';
    elseif mod (shuffled(t),13) == 12
        card1 = 'queen of diamonds';
    elseif mod (shuffled(t),13) == 0
        card1 = 'king of diamonds';
    end
elseif suits(t) == 4
    if mod (shuffled(t),13) == 1
        card1 = 'ace of hearts';
    elseif mod (shuffled(t),13) == 2
        card1 = 'two of hearts';
    elseif mod (shuffled(t),13) == 3
        card1 = 'three of hearts';
    elseif mod (shuffled(t),13) == 4
        card1 = 'four of hearts';
    elseif mod (shuffled(t),13) == 5
        card1 = 'five of hearts';
    elseif mod (shuffled(t),13) == 6
        card1 = 'six of hearts';
    elseif mod (shuffled(t),13) == 7
        card1 = 'seven of hearts';
    elseif mod (shuffled(t),13) == 8
        card1 = 'eight of hearts';
    elseif mod (shuffled(t),13) == 9
        card1 = 'nine of hearts';
    elseif mod (shuffled(t),13) == 10
        card1 = 'ten of hearts';
    elseif mod (shuffled(t),13) == 11
        card1 = 'jack of hearts';
    elseif mod (shuffled(t),13) == 12
        card1 = 'queen of hearts';
    elseif mod (shuffled(t),13) == 0
        card1 = 'king of hearts';
    end
end
end
