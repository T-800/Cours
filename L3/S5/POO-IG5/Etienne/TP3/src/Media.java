
public class Media {
	static private int inc = 0;
	private final String titre;
	private final int numero;
	private boolean emprunter = false;
	
	public Media(String titre){
		this.titre = titre;
		this.numero = inc++;
	}
	
	public int getNumero() {
		return numero;
	}
	
	public String toString(){
		return numero+" : "+titre;
	}
	
	public boolean plusPetit(Media doc){
		if(doc instanceof Livre){
			return (!((Livre)doc).plusPetit(this));
		}
		return numero<doc.getNumero();
	}
	
	public boolean plusPetit(Livre doc){
		if(this instanceof Livre){
			((Livre)this).plusPetit(doc);
		}
		return numero<doc.getNumero();
	}
	
	
	public boolean emprunter(){
		if (emprunter) {
			System.out.println(this.toString()+ " est deja emprunter");
			return false;
		}
		else{
			this.emprunter = true;
			System.out.println("Merci de rendre "+ this.toString()+ " bientot");
			return true;
		}
	}
	
	public boolean rendre(){
		if (!emprunter) {
			System.out.println(this.toString()+ " n'est pas emprunter");
			return false;
		}
		else{
			this.emprunter = false;
			System.out.println("Merci d'avoir rendu "+ this.toString());
			return true;
		}
	}
}
