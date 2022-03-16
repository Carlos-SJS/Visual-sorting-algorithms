int[] arr;
int sz = 100;
int p=0;
int ac;
int i=0;
int hg;

void swap(int i1, int i2){
    int tmp = arr[i1];
    arr[i1] = arr[i2];
    arr[i2] = tmp;
}

void shuffle(){
    int i1,i2;
    for(int i=0; i<sz*50; i++){
        i1 = int(random(sz));
        i2 = int(random(sz));
        swap(i1,i2);
    }
}

void start_array(){
    for(int i=1; i<=sz; i++) arr[i-1] = i;
}

void settings(){
    hg = displayHeight - 100;
    if(sz>displayWidth-100) sz = displayWidth-100;
    arr =  new int[sz];

    //use start_array_rand(sz) to start the array with random numbers
    start_array();
    shuffle();

    int sc_sz=300;
    while(sz*sc_sz>displayWidth-100) sc_sz--;
    size(sz*sc_sz,hg);
}

void setup() {
    frameRate(60); //Change frame rate to change the swaps per second
}


void bubble_step(){
    while(p<sz){
        while(i<sz-p-1){
            if(arr[i]>arr[i+1]){
                swap(i,i+1);
                return;
            }
            i++;
        }
        p++;
        i=0;
    }
    noLoop();
}

void draw_array(){
    translate(0,height);
    int x = 0;
    noStroke();
    color c1 = color(60,199,8);
    color c2 = color(160,22,10);
    for(int i=0; i<sz; i++){
        color fcolor = lerpColor(c1, c2, float(abs(arr[i]-i-1))/(sz*.65));
        fill(fcolor);
        rect(x, 0, width/sz, -map(arr[i], 1,sz, 1,height));
        x+=float(width)/sz;
    }
}

void draw() {
    bubble_step();
    background(0);

    draw_array();
}
