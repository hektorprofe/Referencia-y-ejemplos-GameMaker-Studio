// ROTATING FORMS
if (f_type == 0)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;
            
        case 1: // 90º

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;            
            
        case 3: // 270

            /// FIGURE 1  [][]
            ///           [][]
            f_grid = ds_grid_create(2,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 1;
            f_grid[#1,0] = 1;
            f_grid[#0,1] = 1;
            f_grid[#1,1] = 1;
            figure_offset_i = 0;
            break;
    }
            
}    
if (f_type == 1)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 2  []
            ///           [][][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 7;
            f_grid[#0,1] = 7;
            f_grid[#1,1] = 7;
            f_grid[#2,1] = 7;
            figure_offset_i = 1;
            break;
            
        case 1: // 90º

            /// FIGURE 2    []
            ///             []
            ///           [][]
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 7;
            f_grid[#1,1] = 7;
            f_grid[#1,2] = 7;
            f_grid[#0,2] = 7;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 2  [][][]
            ///               []
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 7;
            f_grid[#1,0] = 7;
            f_grid[#2,0] = 7;
            f_grid[#2,1] = 7;
            figure_offset_i = 1;
            break;
            
        case 3: // 270

            /// FIGURE 2  [][]
            ///           []
            ///           []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 7;
            f_grid[#1,0] = 7;
            f_grid[#0,1] = 7;
            f_grid[#0,2] = 7;
            figure_offset_i = 0;
            break;
    }
}    
if (f_type == 2)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 3      []
            ///           [][][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#2,0] = 6;
            f_grid[#0,1] = 6;
            f_grid[#1,1] = 6;
            f_grid[#2,1] = 6;
            figure_offset_i = 1;
            break
            
        case 1: // 90º

            /// FIGURE 3  [][]
            ///             []
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 6;
            f_grid[#1,0] = 6;
            f_grid[#1,1] = 6;
            f_grid[#1,2] = 6;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 3  [][][]
            ///           []
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 6;
            f_grid[#1,0] = 6;
            f_grid[#2,0] = 6;
            f_grid[#0,1] = 6;
            figure_offset_i = 1;
            break;
            
        case 3: // 270

            /// FIGURE 3  []   
            ///           []
            ///           [][]
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 6;
            f_grid[#0,1] = 6;
            f_grid[#0,2] = 6;
            f_grid[#1,2] = 6;
            figure_offset_i = 0;
            break;
    }
        
}    
 
if (f_type == 3)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 4    []  
            ///           [][][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 5;
            f_grid[#0,1] = 5;
            f_grid[#1,1] = 5;
            f_grid[#2,1] = 5;
            figure_offset_i = 1;
            break;
            
        case 1: // 90º

            /// FIGURE 4    []  
            ///           [][]
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 5;
            f_grid[#0,1] = 5;
            f_grid[#1,1] = 5;
            f_grid[#1,2] = 5;
            figure_offset_i = 0;
            break;
            
        case 2: // 180º

            /// FIGURE 4  [][][]
            ///             []
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 5;
            f_grid[#1,0] = 5;
            f_grid[#2,0] = 5;
            f_grid[#1,1] = 5;
            figure_offset_i = 1;
            break;
            
        case 3: // 270

            /// FIGURE 4    []  
            ///             [][]
            ///             []  
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 5;
            f_grid[#0,1] = 5;
            f_grid[#1,1] = 5;
            f_grid[#0,2] = 5;
            figure_offset_i = 0;
            break;
    }
}

if (f_type == 4)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 5      
            ///           [][][][]
            f_grid = ds_grid_create(4,1);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#1,0] = 2;
            f_grid[#2,0] = 2;
            f_grid[#3,0] = 2;
            figure_offset_i = 2;
            break;
            
        case 1: // 90º

            /// FIGURE 5      
            ///           []
            ///           []
            ///           []
            ///           []
            f_grid = ds_grid_create(1,4);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#0,1] = 2;
            f_grid[#0,2] = 2;
            f_grid[#0,3] = 2;
            figure_offset_i = -4;
            break;
            
        case 2: // 180º

            /// FIGURE 5      
            ///           [][][][]
            f_grid = ds_grid_create(4,1);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#1,0] = 2;
            f_grid[#2,0] = 2;
            f_grid[#3,0] = 2;
            figure_offset_i = 2;
            break;
            
        case 3: // 270

            /// FIGURE 5      
            ///           []
            ///           []
            ///           []
            ///           []
            f_grid = ds_grid_create(1,4);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 2;
            f_grid[#0,1] = 2;
            f_grid[#0,2] = 2;
            f_grid[#0,3] = 2;
            figure_offset_i = -4;
            break;
    }
}

if (f_type == 5)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 6    []  
            ///           [][]
            ///           []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 4;
            f_grid[#0,1] = 4;
            f_grid[#1,1] = 4;
            f_grid[#0,2] = 4;
            figure_offset_i = 0;
            break;
            
        case 1: // 90º

            /// FIGURE 6  [][]  
            ///             [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 4;
            f_grid[#1,0] = 4;
            f_grid[#1,1] = 4;
            f_grid[#2,1] = 4;
            figure_offset_i = 1;
            break;
            
        case 2: // 180º

            /// FIGURE 6    []  
            ///           [][]
            ///           []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 4;
            f_grid[#0,1] = 4;
            f_grid[#1,1] = 4;
            f_grid[#0,2] = 4;
            figure_offset_i = 0;
            break;
            
        case 3: // 270

            /// FIGURE 6  [][]  
            ///             [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 4;
            f_grid[#1,0] = 4;
            f_grid[#1,1] = 4;
            f_grid[#2,1] = 4;
            figure_offset_i = 1;
            break;
    }
}    

if (f_type == 6)
{
    switch f_angle
    {
        case 0: // 0º

            /// FIGURE 7  []  
            ///           [][]
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            f_grid[#1,2] = 3;
            figure_offset_i = 0;
            break;
            
        case 1: // 90º

            /// FIGURE 7    [][]  
            ///           [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 3;
            f_grid[#2,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            figure_offset_i = 1;
            break;
            
        case 2: // 180º

            /// FIGURE 7  []  
            ///           [][]
            ///             []
            f_grid = ds_grid_create(2,3);
            ds_grid_clear(f_grid, -1);
            f_grid[#0,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            f_grid[#1,2] = 3;
            figure_offset_i = 0;
            break;
            
        case 3: // 270

            /// FIGURE 7    [][]  
            ///           [][]
            f_grid = ds_grid_create(3,2);
            ds_grid_clear(f_grid, -1);
            f_grid[#1,0] = 3;
            f_grid[#2,0] = 3;
            f_grid[#0,1] = 3;
            f_grid[#1,1] = 3;
            figure_offset_i = 1;
            break;
    }  
} 
