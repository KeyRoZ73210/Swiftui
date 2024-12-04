# Réponses


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
