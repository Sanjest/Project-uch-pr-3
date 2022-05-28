class Antbot {
    float X , Y , angle, speed; // координаты, направление движения и скорость
    int food;                   // наличие ресурса у агента
    float angF, angH;           // здесь хранится предполагаемое направление до базы и ресурса
    int disF, disH;             // счётчик предполагаемого расстояния до ресурса и базы
    int counter;                // счетчик, для подсчёта, когда кричать

    //-------------------------------------------------------
  Antbot( float X , float Y , float angle , int food){
    this.X = X;              this.Y = Y;
    this.angle = angle;      this.food = food;
    angF = random(0,TAU);    angH = random(0,TAU);
    speed = random(0.8,1.2);  // разная скорость у агентов
    disF = 100;              disH = 100;
    counter = int(random(0,fr-2));
  }
    //--------------------------------------------------------
  void step() {
     disF += 1;  disH += 1;             // счётчики увеличиваются
     angle += random(-0.05, 0.05);      // идём кривовато
     float Xc = X + speed*sin(angle);   // новые координаты
     float Yc = Y + speed*cos(angle);
     color cl = get(int(Xc),int(Yc));   // берём пробу цвета по новым координатам
     if (cl == #000022){                // если стена, то разворот
       angle = angle + PI;              // и отскакиваем
       X = X + sin(angle);
       Y = Y + cos(angle);
     }
     else{ X = Xc; Y = Yc; }             // если стены нет, то шагаем
     
     if ( cl == colorF ){                // если наткнулись на ресурс
       food = 255;                       // заполняем корзину
       disF = 0;                         // обнуляем счётчик
       angle = angH;                     // поворачиваем по направлению, где, как нам кажется, база
     }
     if ( cl == colorB ){                // если наткнулись на базу
       food = 0;                         // опусташаем корзину
       disH = 0;                         // обнуляем счётчик
       angle = angF;                     // поворачиваем по направлению, где, как нам кажется, ресурс
     } 
     counter += 1;
     if( counter == fr2){ CryF(X,Y,disF+dst); }        // кричим, если пришло время
     if( counter == fr ){ CryH(X,Y,disH+dst);  counter = 0; }
   }

//----------------------------------------------------------------------------------
   void render() {         // рисуем агента
     fill(food);           // если с едой, то закрашен белым, без еды - чёрным
     ellipse(X, Y,3, 3);
   }
   
//--------------------------------------------------------------------------   
   void setAngleF(float x, float y, float d) { // записать направление в переменной angF
     float an = acos((y-Y)/d);                 // предположительно, в этом направлении ресурс ближе
     if (x>X) {angF = an;}                     
     else {angF = TAU-an;}
   }
//-------------------------------------------------------------------------
  void setAngleH(float x, float y, float d) { // записать направление в переменной angH
     float an = acos((y-Y)/d);                 // предположительно, в этом направлении база ближе
     if (x>X) {angH = an;}
     else {angH = TAU-an;}
   }   
}
