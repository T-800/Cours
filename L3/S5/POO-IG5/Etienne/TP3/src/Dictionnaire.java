
public class Dictionnaire extends Media{
	private final String langue;
	private final int nbreTomes;
	
	public Dictionnaire(String titre,String langue,int nbrePages) {
		super(titre);
		this.langue=langue;
		this.nbreTomes = nbrePages;
		// TODO Auto-generated constructor stub
	}
	
	public String toString(){
		return super.toString()+" "+langue+ "tomes: "+nbreTomes;
	}
}
