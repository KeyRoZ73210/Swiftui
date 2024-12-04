# Réponses

## 1 à 3

### 🔧 Exercice 1

- Il manque l'id car SwiftUI ne peut pas identifier chaque élément sans ambiguïté

```
List(loot, id: \.self) { item in
    Text(item)
}
```
### 🔧 Exercice 2

Expliquez le changement que j’ai effectué par rapport à l’exemple précédent.
- Il y a eu l'ajout du Foreach

Pourquoi utiliser un ForEach ? Quel est son rôle ? Et pourquoi séparer le bouton du ForEach ?
- ForEach permet de créer une collection de sous-vues à partir d'un tableau ou d'une collection.
- isolez son rôle de déclencheur d'action, tandis que le ForEach est uniquement responsable de l'affichage des éléments.

### 🔧 Exercice 3
Testez ce code, fonctionne-t-il ? Pourquoi ?

- Non il ne fonctionne pas car le nom de la fonction du bouton est addItem() alors que l'action dans la liste est addLoot()
Corrigez le code pour que le clique sur bouton “Ajouter” fonctionne, utilisez @State pour cela.
```
@State public var loot = ["Epée", "Bouclier", "Armure"]
```
Expliquez pourquoi maintenant cela fonctionne ?
- Le code fonctionne maintenant parce que l'utilisation de @State rend la variable loot réactive.

## 4

### 🔧 Exercice 1

Cliquez sur le bouton “Ajouter” (de la liste), que se passe-t-il ? Pourquoi cela ne marche pas ?

- Le problème du bouton "Ajouter" dans la vue principale (ContentView). Lorsque l'on clique sur le bouton "Ajouter" dans la vue principale, j'appelle
la méthode addItem(item: "Magie de feu"), qui ajoute directement l'élément "Magie de feu" à la liste loot. Cette action fonctionne 
correctement pour ajouter l'élément et mettre à jour la liste visible. Mais, cela ne déclenche pas l'ouverture de la vue AddItemView, parce que la
logique pour afficher AddItemView est liée à un autre bouton dans la barre d'outils.
Pour afficher AddItemView lors de l'appui sur "Ajouter", il faudrait aussi activer showAddItemView pour déclencher la feuille.

### 🔧 Exercice 2

Pourquoi cela fonctionne de nouveau ?

- Cela fonctionne de nouveau car l’utilisation de @StateObject, avec @Published dans la classe Inventory, permet à SwiftUI de surveiller les
changements dans les propriétés marquées comme @Published. À chaque modification de la liste loot, SwiftUI détecte ces changements et actualise
automatiquement la vue concernée.

Pourquoi utiliser @StateObject plutôt que @ObservedObject ou @State ?

- @StateObject est utilisé pour créer et gérer l’état d’un objet observable dans une vue. il fait en sorte que l’objet persiste tout au long de la
vue.
@ObservedObject est utilisé lorsque l’objet est créé ailleurs et passé à la vue. Cependant, ça ne garantit pas la persistance de l’objet, ce qui peut
poser problème si la vue est recréée.
@State est conçu pour des valeurs simples (comme des String ou des Int) et non pour des objets complexes comme ceux conformant à ObservableObject.

Donc il c'est mieux d'utiliser @StateObject car la vue crée et gère l’instance de l’objet Inventory

## 5

### 🔧 Exercice 2

Pourquoi avez-vous une erreur liée à Identifiable ?

- L’erreur liée à Identifiable se produit parce que la propriété 'id' de la structure Game, n'est pas utilisée pour satisfaire clairement le
protocole Identifiable. SwiftUI attend que la structure fournisse une propriété 'id' unique pour identifier chaque instance lorsqu'elle est utilisée 
dans des listes ou d'autres collections.

Comment la corriger ?

- il faut faire attention que la propriété 'id' est explicitement utilisée pour satisfaire Identifiable, ce qui est fait automatiquement dans Swift
si la propriété porte le nom exact id donc le protocole Identifiable necessite une propriété appelée 'id'
