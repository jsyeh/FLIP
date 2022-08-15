import java.util.Collections;
import java.util.Comparator;
class Card {
  int id, id_flip;
  String zh;
  String en;
  Card(String _id, String _zh, String _en, String _id_flip) {
    id = int(_id);
    zh = new String(_zh);
    en = new String(_en);
    id_flip = int(_id_flip);
  }
}
class CardSort implements Comparator<Card> {
  public int compare(Card a, Card b){
    return a.id - b.id;
  }
}
ArrayList<Card> cards;
void setup(){
  size(900,600);
  cards = new ArrayList<Card>();
  String [] lines = loadStrings("card.txt");
  for( String line : lines ){
    String [] fields = split(line, " | ");
    cards.add( new Card(fields[1], fields[2], fields[3], fields[4]) );
    cards.add( new Card(fields[4], fields[5], fields[6], fields[1]) );
  }
  Collections.sort( cards, new CardSort() );
  for( Card c : cards ){
    print(c.id, c.zh, c.en, "--- ");
    Card c2 = cards.get(c.id_flip-1);
    println(c2.id, c2.zh, c2.en);
  }
}
int now = 1 - 1;
void draw(){
  background(#FFFFF2);
  Card c = cards.get(now);
  drawCard(cards.get(48), 50,50);
  drawCard(cards.get(31), 280,80);
  drawCard(cards.get(39), 580,80);
  drawCard(c, mouseX, mouseY);
}
PFont fontZH=null, fontEN=null, fontNum=null;
color [] color_table = {#FF7E7E, #FFF27E, #7EA8FF, #F67EFF, #7EFF7F};
void drawCard(Card c, float x, float y){
  fill(255);
  rect(x,y, 4*54,4*90, 2*10);
  if(c.id>50) fill( color_table[ int((c.id-50-1)/10) ] );
  else fill( color_table[ int((c.id-1)/10) ] );
  rect( x+10,y+10, 4*54-20, 4*90-20, 2*10);
  
  textAlign(CENTER,BOTTOM);
  fill(0);
  textSize(28);
  if(fontZH==null) fontZH=createFont("微軟正黑體", 28);
  textFont(fontZH);
  textLeading(36); //textLeading will be reset after textSize() or textFont()
  text(c.zh, x+10+10, y+10, 4*54-20-25, (4*90-20)/2);

  textAlign(CENTER,TOP);
  textSize(12);
  if(fontEN==null) fontEN=createFont("Times New Roman", 12);
  textFont(fontEN);
  text(c.en, x+10+15, y+10+15+(4*90-20)/2, 4*54-20-30, 4*90-20);
  
  fill(255,0,0);
  noStroke();
  rect(x+4*54/2-24, y+4*90-30, 48,28, 14,14,14,14);
  fill(255);
  if(fontNum==null) fontNum=createFont("SansSerif.bold", 14);
  textFont(fontNum);
  textSize(20);
  textAlign(CENTER,TOP);
  text(""+c.id, x+4*54/2-24, y+4*90-30, 48,28);
  stroke(0);
}
void keyPressed(){
  if(keyCode==RIGHT) now = (now+1)%100;
  if(keyCode==LEFT) now = (now-1+100)%100;
}
