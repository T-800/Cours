import java.util.LinkedList;

public class Mediatheque {
	private final LinkedList<Media> baseDeDonnees;
	
	public Mediatheque(){
		this.baseDeDonnees = new LinkedList<Media>();
	}
	
	public String toString(){
		String result = new String();
		for( Media med : baseDeDonnees ){
			result += (med.toString() + "\n");
		}
		return result;
	}
	
	public void ajouter(Media doc){
		for (Media med : baseDeDonnees){
			if (doc.plusPetit(med)){
				baseDeDonnees.add(baseDeDonnees.indexOf(med), doc);
				return;
			}
		}
		baseDeDonnees.add(doc);
	}
	
	public boolean emprunter(Media media){
		if (!baseDeDonnees.contains(media)){
			System.out.println("La médiatheque ne possedent  pas " + media.toString());
			return false;
		}
		return media.emprunter();
	}
	
	public boolean rendre(Media media){
		if (!baseDeDonnees.contains(media)){
			System.out.println("La médiatheque ne possedent  pas "+ media.toString()+ " merci de le rendre a la bonne bibliotheque");
			return false;
		}
		return media.rendre();
	}
	
}