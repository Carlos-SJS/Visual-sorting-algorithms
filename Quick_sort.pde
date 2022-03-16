int[] arr;
int sz = 300;
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

void swapd(int a, int b){
    int tmp = arr[a];
    arr[a] = arr[b];
    arr[b] = tmp;

    int f = frameCount;
    while(frameCount == f) delay(1);
}

void validate(){
    int lst = -1;
    for(int n: arr){
        if(n<lst){
            println("SORT FAILED");
            return;
        }
        lst = n;
    }
    println("SORT SUCCESFULL");
}

void quickSort(int st, int end){
    if(st < end){
        int izq = st+1, der = end, pivote = arr[st];

        while(izq<=der){
            while(izq!=end && arr[izq]<=pivote) izq++;
            while(der!=st && arr[der]>pivote) der--;
            if(izq<der && (arr[izq]>pivote || arr[der]<=pivote)) swapd(izq,der);
            if(izq==end || der==st) break;
        }
        if(der!=st) swapd(st,der);

        quickSort(st, der-1);
        quickSort(der+1,end);
    }
}


void do_the_sort(){
    println("Ready to do the sort");
    quickSort(0,sz-1);
    validate();
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
