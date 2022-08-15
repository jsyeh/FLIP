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
  size(500,500);
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
void draw(){
  
}
