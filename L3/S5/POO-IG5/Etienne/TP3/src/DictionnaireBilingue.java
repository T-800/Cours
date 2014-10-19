
public class DictionnaireBilingue extends Dictionnaire {
	private final String langue2;

	public DictionnaireBilingue(String titre, String langue,String langue2 ,int nbrePages) {
		super(titre, langue, nbrePages);
		this.langue2 = langue2;
		// TODO Auto-generated constructor stub
	}
	
	public String toString(){
		return super.toString() + langue2;
	}

}