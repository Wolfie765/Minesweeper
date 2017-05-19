

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public int NUM_ROWS = 20;
public int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int x = 0; x < NUM_ROWS; x++)
    {
        for(int y = 0; y < NUM_COLS; y++)
        {
           buttons[x][y] = new MSButton(x, y); 
        }
    }
    bombs = new ArrayList <MSButton>();   
    
    setBombs();
}
public void setBombs()
{
    //your code
    for(int i = 0; i < 10; i++)
    {
        int row = (int)(Math.random()*20);
        int col = (int)(Math.random()*20);
        if(bombs.contains(buttons[row][col]) == false)
        {
            bombs.add(buttons[row][col]);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
for(int r = 0; r < NUM_ROWS; r++){
    for(int c = 0; c< NUM_COLS; c++){
        if(!buttons[r][c].isClicked()==true&&!bombs.contains(buttons[r][c]))
            return false;
    }

}


    return true;

}
public void displayLosingMessage()
{
          for(int i = 0;i < NUM_ROWS;i++){
       for(int j = 0;j < NUM_COLS;j++){
           if(!buttons[i][j].isClicked()&&bombs.contains(buttons[i][j]))
           {
               buttons[i][j].marked=false;
               buttons[i][j].clicked=true;
                   buttons[10][0].setLabel(" ");
                   buttons[10][1].setLabel(" ");
                   buttons[10][2].setLabel(" ");
                   buttons[10][3].setLabel(" ");
                   buttons[10][4].setLabel(" ");
                   buttons[10][5].setLabel(" ");
                   buttons[10][6].setLabel("Y");
                   buttons[10][7].setLabel("O");
                   buttons[10][8].setLabel("U");
                   buttons[10][9].setLabel(" ");
                   buttons[10][10].setLabel("L");
                   buttons[10][11].setLabel("O");
                   buttons[10][12].setLabel("S");
                   buttons[10][13].setLabel("E");
                   buttons[10][14].setLabel(" ");
                   buttons[10][15].setLabel(" ");
                   buttons[10][16].setLabel(" ");
                   buttons[10][17].setLabel(" ");
                   buttons[10][18].setLabel(" ");
                   buttons[10][19].setLabel(" ");      
           }
       }
   }
}
public void displayWinningMessage()
{
    //your code here
        buttons[10][0].setLabel(" ");
                   buttons[10][1].setLabel(" ");
                   buttons[10][2].setLabel(" ");
                   buttons[10][3].setLabel(" ");
                   buttons[10][4].setLabel("Y");
                   buttons[10][5].setLabel("O");
                   buttons[10][6].setLabel("U");
                   buttons[10][7].setLabel(" ");
                   buttons[10][8].setLabel(" ");
                   buttons[10][9].setLabel(" ");
                   buttons[10][10].setLabel(" ");
                   buttons[10][11].setLabel(" ");
                   buttons[10][12].setLabel("W");
                   buttons[10][13].setLabel("I");
                   buttons[10][14].setLabel("N");
                   buttons[10][15].setLabel("!");
                   buttons[10][16].setLabel(" ");
                   buttons[10][17].setLabel(" ");
                   buttons[10][18].setLabel(" ");
                   
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;

    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here 
        if(keyPressed == true)
            marked  = !marked;
        //if(this.clicked == true)
        // if(marked == false)
        //     clicked = false;
        else if(bombs.contains(this) == true)
            displayLosingMessage();
        else if(countBombs(r, c) != 0)
            setLabel( "" + countBombs(r, c));
        else
            {
                //left
                if((isValid(r, c - 1) == true) && (buttons[r][c - 1].isClicked() == false) )
                    buttons[r][c - 1].mousePressed();
                //right
                if((isValid(r, c + 1) == true) && (buttons[r][c + 1].isClicked() == false) )
                    buttons[r][c + 1].mousePressed();
                //down
                if((isValid(r + 1, c) == true) && (buttons[r + 1][c].isClicked() == false) )
                    buttons[r + 1][c].mousePressed();
                //up
                if((isValid(r - 1, c) == true) && (buttons[r - 1][c].isClicked() == false) )
                    buttons[r - 1][c].mousePressed();
                
                //top right
                if((isValid(r - 1, c + 1) == true) && (buttons[r - 1][c + 1].isClicked() == false) )
                    buttons[r - 1][c + 1].mousePressed();

                //bottom right
                if(((isValid(r + 1, c + 1) == true) == true)&& (buttons[r + 1][c + 1].isClicked() == false) )
                    buttons[r + 1][c + 1].mousePressed();

                //top left
                if((isValid(r - 1, c - 1) == true) && (buttons[r - 1][c - 1].isClicked() == false) )
                    buttons[r - 1][c - 1].mousePressed();

                //bottom left
                if((isValid(r + 1, c - 1) == true) && (buttons[r + 1][c - 1].isClicked() == false) )
                    buttons[r + 1][c - 1].mousePressed();
            }    
        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if((r < 20 && r > -1) && (c < 20 && c > -1) == true)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if((isValid(row, col + 1) == true) && bombs.contains(buttons[row][col + 1]) == true)
            numBombs = numBombs + 1;
        if((isValid(row, col - 1) == true) && bombs.contains(buttons[row][col - 1])  == true)
            numBombs = numBombs + 1;
        if((isValid(row + 1, col) == true) && bombs.contains(buttons[row + 1][col])  == true)
            numBombs = numBombs + 1;
        if((isValid(row - 1, col) == true) && bombs.contains(buttons[row - 1][col])  == true)
            numBombs = numBombs + 1;

        if((isValid(row - 1, col - 1) == true) && bombs.contains(buttons[row - 1][col - 1])  == true)
            numBombs = numBombs + 1;
        if((isValid(row + 1, col - 1) == true) && bombs.contains(buttons[row + 1][col - 1])  == true)
            numBombs = numBombs + 1;
        if((isValid(row - 1, col + 1) == true) && bombs.contains(buttons[row - 1][col + 1])  == true)
            numBombs = numBombs + 1;
        if((isValid(row + 1, col + 1) == true) && bombs.contains(buttons[row + 1][col + 1])  == true)
            numBombs = numBombs + 1;

        return numBombs;
    }
}




