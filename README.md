# Vulnerable Species Explorer

  Descrizione del Progetto
  Vulnerable Species Explorer è un'applicazione cross-platform sviluppata con Flutter, progettata per esplorare e apprendere informazioni dettagliate sulle specie vulnerabili 
  elencate nella IUCN Red List. L'app funziona sia su dispositivi Android che su piattaforme web, offrendo un'interfaccia interattiva e ricca di funzionalità.

# Overview

  Questo progetto utilizza GoRouter per gestire la navigazione basata su URL path tra diverse schermate. GoRouter supporta il passaggio di parametri, la gestione dello stato e dello stack di navigazione, rendendolo adatto per applicazioni Flutter complesse.

  Configurazione di Base del Router
  GoRouter è configurato con una serie di route che mappano i percorsi dell'applicazione. Ogni route è definita con un path, un builder che costruisce il widget corrispondente, e opzionali sotto-route.

  Dettagli delle Route

Home Screen
Path: /
Widget: HomeScreen
Descrizione: Schermata principale che mostra un elenco alfabetico per la selezione delle specie.
Species List Screen
Path: species/:letter
Widget: SpeciesListScreen
Parametri: letter
Descrizione: Filtra e mostra le specie che iniziano con la lettera selezionata.
Specie Detail Screen
Path: detail/:specieId
Widget: SpecieDetailScreen
Parametri: specieId, specieName
Descrizione: Dettaglia informazioni su una specie specifica. Gestisce ID specie non validi con un fallback.
Gestione del Parametro e dell'Extra State
Il recupero e la conversione dell'ID della specie da stringa a intero sono gestiti con cautela, impostando un fallback se il parsing fallisce. Gli extra state (come specieName) sono utilizzati per arricchire l'esperienza utente.

# Architettura MVC e Utilizzo del Singleton

  L'applicazione segue l'architettura MVC (Model-View-Controller), che organizza il codice in tre componenti interconnessi:

  Modello: Gestisce dati e regole di business.
  Vista: Presenta i dati agli utenti e raccoglie le loro interazioni.
  Controllore: Processa le interazioni, aggiorna i dati e la vista tramite futureBuilder.
  Implementazione del Singleton
  Il controller delle specie utilizza il pattern Singleton per garantire una gestione centralizzata e efficiente delle risorse di rete:

class SpeciesController {
  static final SpeciesController _instance = SpeciesController._internal();

  factory SpeciesController() {
    return _instance;
  }

  SpeciesController._internal();

}


# Vantaggi
  Semplicità: Facile da comprendere, ideale per team piccoli o progetti meno complessi.
  Manutenibilità: Facilita la manutenzione grazie alla chiara separazione delle responsabilità.
  Performance: Minimizza l'uso delle risorse grazie alla condivisione dell'istanza del controller.
  Conclusione
  La configurazione di GoRouter in questa applicazione dimostra un efficace utilizzo del routing basato su URL per gestire la navigazione tra le schermate in una applicazione Flutter. 
  È fondamentale testare direttamente come il cambio di dettaglio nel path dell'URL influenzi il comportamento dell'app, poiché questa logica è centralmente gestita dal GoRouter.
