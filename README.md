# public_test
Descrizione del Progetto Vulnerable Species Explorer è un'applicazione cross-platform sviluppata con Flutter, che offre un'interfaccia interattiva per esplorare e apprendere informazioni dettagliate sulle specie vulnerabili elencate nella IUCN Red List. L'app è progettata per funzionare sia su dispositivi Android che su piattaforme web.


# Overview:
La configurazione del router in questa applicazione utilizza GoRouter per gestire la navigazione tra le varie schermate basate su URL path. GoRouter è una soluzione di routing per Flutter che supporta il passaggio di parametri e stato, oltre alla gestione dello stack di navigazione, il che la rende ideale per app più complesse.

Configurazione di Base:
GoRouter è stato configurato con una serie di route che definiscono il percorso dell'applicazione. Ogni route è definita con un path, un builder che costruisce il widget quando la route è attiva, e un'opzionale lista di sotto-route (routes).

# Dettagli delle Route:

Home Screen ('/'):
Path: '/'
Widget: HomeScreen
Descrizione: La schermata principale dell'app. Mostra una lista delle lettere dell'alfabeto che l'utente può selezionare per vedere le specie corrispondenti.
Species List Screen ('species/:letter'):
Path: 'species/:letter'
Widget: SpeciesListScreen
Parametri: letter
Descrizione: Questa route riceve un parametro letter che indica la lettera selezionata nella Home Screen. Utilizza questo parametro per filtrare e mostrare le specie che iniziano con quella lettera.
Specie Detail Screen ('detail/:specieId'):
Path: 'detail/:specieId'
Widget: SpecieDetailScreen
Parametri: specieId, specieName
Descrizione: Mostra dettagli su una specifica specie. Il specieId viene passato come parametro nell'URL, mentre il specieName può essere passato tramite lo stato (extra). Questa route gestisce anche situazioni in cui l'ID della specie non è valido, impostando un valore predefinito.
Gestione del Parametro e dell'Extra State:
Nella route 'detail/:specieId', viene fatto un tentativo di recuperare e convertire l'ID della specie da String a int. Se questo tentativo fallisce (ad esempio, se l'ID non è un numero valido), viene impostato un valore di fallback (-1). Inoltre, si controlla se sono stati passati degli extra state (come specieName), utilizzando questi valori per migliorare l'esperienza utente.

Conclusione:
La configurazione di GoRouter in questa applicazione dimostra un uso efficace del routing basato su URL per gestire la navigazione tra schermate in una applicazione Flutter. La capacità di passare parametri e gestire lo stato tra le route rende GoRouter uno strumento potente per lo sviluppo di applicazioni Flutter complesse.




# Architettura MVC:
L'architettura MVC separa la logica dell'applicazione in tre componenti interconnessi, ciascuno con responsabilità specifiche:

Modello (Model): Gestisce i dati e le regole di business dell'applicazione.
Vista (View): Presenta i dati (il modello) all'utente e invia le interazioni dell'utente (ad esempio, input) al controller.
Controllore (Controller): Riceve input e iniziative azioni nei dati/modello e successivamente aggiorna la vista.
Utilizzo del Singleton:
Per le chiamate al server, hai implementato il pattern Singleton nel controller. Questo garantisce che una singola istanza del controller sia condivisa nell'applicazione, promuovendo un accesso efficiente e centralizzato alle operazioni di rete. Le principali vantaggi del Singleton in questo contesto includono:

Gestione Centralizzata delle Risorse: Il Singleton permette di gestire connessioni e risorse relative alle chiamate HTTP da un unico punto, semplificando la manutenzione e il debugging.
Riduzione dell'Overhead: Creare multiple istanze di classi che gestiscono le chiamate HTTP può essere dispendioso in termini di risorse e tempo di esecuzione. Un Singleton aiuta a minimizzare questo overhead.
Implementazione del Singleton:
Il controller delle specie, ad esempio, potrebbe essere strutturato come segue:
 
class SpeciesController {
  static final SpeciesController _instance = SpeciesController._internal();

  factory SpeciesController() {
    return _instance;
  }

  SpeciesController._internal();

  Future<List<SpeciesModel>> fetchSpeciesByCategory() async {
    var url = Uri.parse('https://api.example.com/species');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> speciesJson = json.decode(response.body);
      return speciesJson.map((json) => SpeciesModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load species');
    }
  }
}

Vantaggi del MVC con Singleton:

Semplicità: L'approccio è diretto e facile da comprendere, rendendolo ideale per team piccoli o progetti con meno requisiti tecnici complessi.
Manutenibilità: La separazione delle responsabilità facilita la manutenzione e l'aggiornamento del codice.
Performance: Utilizzando un Singleton per le chiamate di rete, l'applicazione riduce il consumo di risorse di sistema, migliorando le performance.