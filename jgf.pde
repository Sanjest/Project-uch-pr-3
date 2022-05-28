color colorB = #555eaf;  //цвет базы
color colorF = #FFBA39;  // цвет ресурса
int currentFood = 0;     // текущий ресурс, который можно переместить
int fileN = 0;           // имя файла скриншота
int count = 1200;        // количество агентов
boolean sf = false;      // запись

Antbot[] ants = new Antbot[count] ; // агенты
int dst = 80;            // дистанция крика
int fr = 6;              // за 6 шагов агент по 1 разу озвучит значение каждого своего счётчика
int fr2 = fr/2;

float F1X = 100; float F1Y = 100;  // координаты ресурсов
float F2X = 100; float F2Y = 600;
float F3X = 220; float F3Y = 280;

//----------------------------------------------------------------------------------------
void setup(){
   size(1280, 720); 
   background(0);
   ellipseMode(CENTER);

   for (int i=0; i<count; i++){  // инициализируем агентов
     int ff = 0;
     if (random(0,10)>5){ff=255;}  //половина ищут базу, половина ищет ресурс
     ants[i] = new Antbot( random(400,800) , random(30,640) , random(TAU) , ff);
   }  
}

//----------------------------------------------------------------------------------------
void draw(){
  ShowMap();
  for (int i=0; i<count; i++){  
     ants[i].step(); // каждый агент делает ход
  }
  for (int i=0; i<count; i++){  
     ants[i].render(); // рисуем агентов
  }
// если включена запись, то сохраняем каждый 2 кадр
  if(sf){ if( frameCount % 2 == 0 ) { saveFrame(fileN+".png");  fileN++; }}
}

//-------------------------------------------------------------------------------------------
void keyPressed(){
  if( key == ENTER ){ 
    currentFood++;       // смена текущего ресурса (его можно переместить)
    if(currentFood==3) currentFood=0; 
  }
  if( key == TAB )  { sf=true; } // включить запись
}

//-------------------------------------------------------------------------------------------
void mouseClicked()
{    // перемещаем текущий ресурс
  if(currentFood==0){
    F1X=mouseX; F1Y=mouseY;}
  else{   if(currentFood==1){
    F2X=mouseX; F2Y=mouseY;}
    else{F3X=mouseX; F3Y=mouseY; }
  }  
}
