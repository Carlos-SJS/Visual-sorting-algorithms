int[] arr;
int sz = 300;  //Ammount of elements (Max 1000)
int hg;
int target = 1;
int actual = 0;

void start_array(){
    for(int i=1; i<=sz; i++) arr[i-1] = i;
}

void settings(){
    hg = displayHeight - 100;
    if(sz>displayWidth-100) sz = displayWidth-100;
    arr =  new int[sz];

    start_array();
    target = int(random(1,sz));  

    //use start_array_rand(sz) to start the array with random numbers
    int sc_sz=300;
    while(sz*sc_sz>displayWidth-100) sc_sz--;
    size(sz*sc_sz,hg);
}

void setup() {
    frameRate(10); //Change frame rate to change the comparassons per second
}

void draw_array(){
    background(0);
    translate(0,height);
    int x = 0;
    noStroke();
    color c1 = color(51,51,255);
    color c2 = color(255,255,0);
    color c3 = color(60,199,8);
    for(int i=0; i<sz; i++){
        fill(color(244, 244, 235));
        if(i+1 == target) fill(c1);
        else if(i+1 == actual) fill(c2);
        if(i+1==target && target == actual) fill(c3);
        rect(x, 0, width/sz, -map(arr[i], 1,sz, 1,height));
        x+=float(width)/sz;
    }
}

void draw(){
    if(actual!=target){
        actual++;
        draw_array();
    }else{
        draw_array();
        noLoop();
    }
    
    
}
