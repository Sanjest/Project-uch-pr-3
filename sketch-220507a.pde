// крик о дистанции до ресурса
void CryF(float xc, float yc,int df){
  for (int i=0; i<count; i++){   // пройдёмся по всем агентам
    if (ants[i].disF > df ){     // если дистанция до ресурса у агента больше, чем df 
      float xz = ants[i].X;      // возьмём его координаты
      float yz = ants[i].Y;
    //грубо проверим, что он по координатам X и Y находится не дальше, чем дистанция слышимости
      if ( xz>xc-dst && xz<xc+dst && yz>yc-dst && yz<yc+dst){   // если это так
        float d = dist( xc,yc,xz,yz );                          // вычислим точное расстояния
        if( d <= dst ){                                         // если агент близко
          ants[i].setAngleF(xc,yc,d);                           // запишем в его переменную (направление к ресурсу)
                                                                // направление в сторону кричащего
          ants[i].disF = df;                                    // обновим его счетчик расстояния до ресурса
          if(ants[i].food == 0){ants[i].angle = ants[i].angF;}  // если агент ищет ресурс, то повернём его
}}}}}

//-----------------------------------------------------------------------------------------------------
// крик о дистанции до базы
void CryH(float xc, float yc,int dh){
  for (int i=0; i<count; i++){
    if (ants[i].disH > dh){
      float xz = ants[i].X;    
      float yz = ants[i].Y;
      if ( xz>xc-dst && xz<xc+dst && yz>yc-dst && yz<yc+dst){
        float d = dist( xc,yc,xz,yz ); 
        if( d <= dst ){
            ants[i].setAngleH(xc,yc,d);
            ants[i].disH = dh;
            if(ants[i].food == 255){ants[i].angle = ants[i].angH;}
}}}}}


void ShowMap(){
  background(0);
  strokeWeight(16);  stroke(#000022);
  line(8,0,8,680); line(1272,0,1272,680);  line(0,8,1280,8); line(0,680,1280,680); // границы
  
  fill(255);  // инструкция
  text("Enter - смена текущего ресурса",50,690);
    text("TAB - начать запись",50,710);
    
  fill(#5555ff); text(int(frameRate),5,10); // пишем в левом верхнем углу fps
  
  noStroke();  fill(colorF); // рисуем рисурсы
  circle(F1X, F1Y, 40);  circle(F2X, F2Y, 40);  circle(F3X, F3Y, 40); 
  
  fill(#ffff00); // отмечаем маленьким жёлтым кружком текущий ресурс

  if(currentFood==0)      { circle(F1X, F1Y, 5); }
  else if(currentFood==1) { circle(F2X, F2Y, 5); }
  else                    { circle(F3X, F3Y, 5); }
  
  
  fill(colorB); // рисуем базы
  circle(1100, 550, 40);  circle(1100, 100, 40);

  stroke(#ffffff);  strokeWeight(1);
}
