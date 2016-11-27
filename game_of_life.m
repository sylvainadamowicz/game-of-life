function game_of_life( nx, ny, nstep )

%GAME_OF_LIFE Implements the Conway game of life
%   This function implements the Conway game of life in which beings are
%   generated and destroyed in a manner meant to represent evolution. They
%   are destroyed when they have too few or two many neighbours, and are
%   generated at a location with the right number of neighbours.

%   Input parameters
%   nx    The number of squares along the x-direction
%   ny    The number of squares along the y-direction
%   nstep The number of iterations in the game

%   Output parameters
%   None

%   Defining some constants
% The time between images in seconds
delay = 0.5;
% Displacements from one cell to its 8 neighbouring cells
dx = [-1,  0,  1, -1,  1, -1,  0,  1];
dy = [ 1,  1,  1,  0,  0, -1, -1, -1];

%   Initialising the grid
world = zeros(nx+2, ny+2); % Extra sites around the edge fixed to zero
imagesc(world);
pause(delay);
m=menu('Would you like to add creatures to this world?', 'yes', 'no');
if m==1
    prompt = {'How many creatures would you like to add ?'};
    dlg_title = 'Number of creatures';
    num_lines = 1;
    nb = inputdlg(prompt,dlg_title,num_lines);
    nbcreatures=str2double(nb);
    for c=1:nbcreatures
        prompt2 = {'Enter the row:','Enter the column:'};
        dlg_title2 = 'Creature position';
        num_lines2 = 1;
        answer = inputdlg(prompt2,dlg_title2,num_lines2);
        a=str2double(answer); %output is a vector containing the coordinates of the creature
        world(a(1,1),a(2,1))=1; %get the coordinates of creature and populate the cell
        imagesc(world)
        pause(delay);
    end
else
    imagesc(world);
    pause(delay);
end

%   Display the world
imagesc(world);
pause(delay);

%   Step through all the moves
for s = 1:nstep
neighbours=zeros(nx+2, ny+2);
%counting up the neighbours, into an auxiliary matrix
    for i=2:nx+1
        for j=2:ny+1
            for z=1:8
                neighbours(i,j)= neighbours(i,j)+ world(i+dx(z), j+dy(z));
            end
        end
    end
    
    %   Update the world
%applying rules to the world
    for i=2:nx+1
        for j=2:ny+1
            if world(i,j)==1 %(if cell is populated)
                if neighbours(i,j)<=1 %underpopulated
                    world(i,j)=0;
                elseif neighbours(i,j)>=4 %overpopulated
                    world(i,j)=0;
                else %(--> if 2 or 3 neighbours)
                    world(i,j)=1;
                end
            else %(if cell is unpopulated)
                if neighbours(i,j)==3
                    world(i,j)=1;
                else
                    world(i,j)=0;
                end
            end
        end
    end

    %   Display the world
    imagesc(world);
    pause(delay);
end
end
