
public class main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Livre hp = new Livre("Harry Potter1","J. K. Rowling",240);
		Livre tdf = new Livre("Le Trône de ferr","George R.R. Martin",789);
		Manga nar = new Manga("Naruto", "Nintendo", "Sony", 12);
		Manga nar2 = new Manga("Naruto2", "Nintendo", "Sony", 12);
		Manga nar3 = new Manga("Naruto3", "Nintendo", "Sony", 12);
		Dictionnaire dic = new Dictionnaire("Larouse", "Francais", 145);
		/*
		Mediatheque med = new Mediatheque();
		med.ajouter(hp);
		med.ajouter(nar);
		med.ajouter(nar3);
		med.ajouter(dic);
		med.ajouter(nar2);
		med.ajouter(tdf);
		System.out.print(med);
		*/
		
		Mediatheque m = new Mediatheque();
		Livre hp2 = new Livre("Harry Potter2", "J. K. Rowling", 240);
        Dictionnaire lar = new Dictionnaire("Larousse", "Allemand", 3);
        DictionnaireBilingue jaIr = new DictionnaireBilingue("Laroche", "Javanais",  "Irlandais",200);
        Manga toko = new Manga("Tokocha", "Yanichou", "Kasoumo", 12);
        BandeDessinee bd = new BandeDessinee("Petit Jean", "Robert",  "Patrick" ,100);
        //Livre tdf = new Livre("Le Trône de fer", "George R.R. Martin", 789);
        EtudiantAbonne etu = new EtudiantAbonne("Petit", "Pablo");
        Abonne ab = new Abonne("Nikolay", "Adequin");
        
        m.ajouter(hp);
        m.ajouter(lar);
        m.ajouter(jaIr);
        m.ajouter(toko);
        m.ajouter(bd);
        m.ajouter(hp2);
        m.ajouter(tdf);
        m.ajouter(nar);
        m.ajouter(nar2);
        m.ajouter(nar3);
        m.ajouter(dic);
        
        System.out.println(m);
        
        etu.emprunter(tdf,m);
        etu.emprunter(toko,m);
        ab.emprunter(tdf,m);
        ab.emprunter(bd,m);
        ab.emprunter(lar,m);
        etu.rendre(nar,m);
        etu.rendre(toko,m);
        ab.rendre(lar,m);
        etu.emprunter(hp2,m);
        ab.rendre(bd,m);
        etu.rendre(hp2,m);
		
		
	}

}
