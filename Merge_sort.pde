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

void merge(int l1, int r1, int l2, int r2){
    int arr1[] = new int[r1-l1+1];
    int arr2[] = new int[r2-l2+1];
    int i = l1;
    arrayCopy(arr, l1, arr1, 0, r1-l1+1);
    arrayCopy(arr, l2, arr2, 0, r2-l2+1);
    r1 = r1-l1;
    l1 = 0;
    r2 = r2-l2;
    l2 = 0;
    while(l1<=r1 || l2<=r2){
        if(l1<=r1 && l2<=r2){
            if(arr1[l1]<arr2[l2]){
                arr[i] = arr1[l1];
                l1++;
            }else{
                arr[i] = arr2[l2];
                l2++;
            }
        }else if(l1<=r1){
            arr[i] = arr1[l1];
            l1++;
        }else{
            arr[i] = arr2[l2];
            l2++;
        }
        i++;
        
        int f = frameCount;
        while(frameCount == f) delay(1);
    }
}

void merge_sort(int l, int r){
    int r_size = (r-l+1);
    if(r_size > 1){
        merge_sort(l, l + r_size/2-1);
        merge_sort(l+r_size/2, r);

        merge(l, l+r_size/2-1, l+r_size/2,r);
    }else{
        return;
    }
}

void do_the_sort(){
    merge_sort(0,sz-1);
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
