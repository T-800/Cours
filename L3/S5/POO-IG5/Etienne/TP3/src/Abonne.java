import java.util.HashSet;


public class Abonne {
	private final String nom;
	private final String prenom;
	private static final int empruntsMax = 1;
	private int emprunts = 0;
	private final HashSet<Media> mediaList;
	
	public Abonne(String nom,String prenom){
		this.nom = nom;
		this.prenom = prenom;
		this.mediaList = new HashSet<Media>();
	}
	
	public int getEmpruntsMax(){
		return empruntsMax;
	}
	
	public boolean emprunter(Media media,Mediatheque mediatheque){
		//System.out.println(empruntsMax);
		if (emprunts<getEmpruntsMax()){
			boolean result = mediatheque.emprunter(media);
			if (result) {
				mediaList.add(media);
				emprunts ++;
			}
			return result;
		}
		else{
			System.out.println(nom+" "+prenom+" a déja emprunter trop de media");
			return false;
		}
	}
	
	public boolean rendre(int numero,Mediatheque mediatheque){
		Media media = possede(numero);
		if(media == null){
			System.out.println("Vous n'avez pas emprunter ce media ") ;
			return false;
		}
		else{
			boolean result = mediatheque.rendre(media);
			if (result){
				mediaList.remove(media);
				emprunts --;
			}
			return result;
		}
	}
	
	public boolean rendre(Media media,Mediatheque mediatheque){
		return rendre(media.getNumero(),mediatheque);
	}
	
	private Media possede(int numero){
		for (Media med : mediaList){
			if (med.getNumero() == numero)return med;
		}
		return null;
	}
	
}