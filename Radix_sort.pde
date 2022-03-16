import java.util.LinkedList;
import java.util.Queue;

int[] arr;
int sz = 300;  //Ammount of elements (Max 1000)
boolean sorted;
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

void start_array_rand(int mx){
    for(int i=1; i<=sz; i++) arr[i-1] = int(random(1,mx));
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


int maxV(){
    int maxn = arr[0];
    for(int i=0; i<arr.length; i++) maxn = max(maxn, arr[i]);
    return maxn;
}

int maxDG(){
    int n = maxV()/10;
    int dg = 1;
    while(n>0){
        dg++;
        n/=10;
    }
    return dg;
}

int getDigitAt(int n, int ix){
    for(int i=0; i<ix-1; i++) n/=10;
    return n%10;
}

void radix_sort(){
    int its = maxDG();
    Queue<Integer>[] qs = new Queue[10];
    for(int i=0; i<10;i++) qs[i] = new LinkedList<Integer>();
    for(int i=0; i<its; i++){
        for(int j=0; j<arr.length; j++) qs[getDigitAt(arr[j],i+1)].add(arr[j]);
        int p = 0;
        for(int j=0; j<10; j++){
            while(qs[j].size()>0){
                arr[p] = qs[j].remove();
                p++;
                delay(20);
            }
        }
    }
    
}

void do_the_sort(){
    println("Ready to do the sort");
    radix_sort();
    println("The sort has been completed");
    sorted = true;
}

void setup() {
    frameRate(60); //Change frame rate to change the swaps per second
    shuffle();
    sorted = false;
    thread("do_the_sort");
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
    background(0);
    draw_array();
    if(sorted)noLoop();
}
