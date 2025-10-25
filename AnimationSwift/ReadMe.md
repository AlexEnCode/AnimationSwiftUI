# Les animations en SwiftUI

## Introduction

SwiftUI intègre un système d’animation déclaratif puissant, conçu pour rendre les interfaces fluides, cohérentes et expressives.
Contrairement aux approches impératives, SwiftUI ne nécessite pas de calculs de progression manuels : les transitions entre états sont gérées automatiquement par le moteur d’animation.

Une animation en SwiftUI relie deux valeurs d’état.
Lorsqu’un changement d’état se produit, SwiftUI interpole les valeurs des propriétés animables (taille, couleur, position, rotation, opacité, etc.) selon le type d’animation spécifié.

---

‘‘‘
import SwiftUI

struct ModifiersExampleView: View {
    // État logique : modifié pour déclencher l’animation
    @State private var bounce = false

    var body: some View {
        VStack(spacing: 20) {
            // Icône à animer
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(Color(.systemBlue))
                // Effet animé : déplacement vertical
                .offset(y: bounce ? -80 : 80)
                // Animation explicite : ressort avec modificateurs
                .animation(
                    .interpolatingSpring(stiffness: 70, damping: 6) // Animation de base
                        .delay(0.3)           // Attente avant le départ
                        .speed(1.2)           // Légère accélération globale
                        .repeatForever(autoreverses: true), // Boucle infinie avec retour
                    value: bounce             // Lien avec la variable d’état
                )
                // Déclenchement initial
                .onAppear { bounce.toggle() }

            // Description textuelle
            Text("Exemple : ressort + modificateurs")
                .font(.headline)
        }
        .padding(40)
    }
}

#Preview {
    ModifiersExampleView()
}

‘‘‘

## 1. Les deux grandes catégories d’animations

### 1.1. Animations implicites

* Se déclenchent automatiquement lors d’un changement d’état.
* Attachées directement à une vue.
* Utilisent le modificateur **`.animation(_:value:)`**.
* S’appliquent uniquement aux changements de la variable observée passée dans `value:`.
* Permettent une animation continue tant que la valeur change.

### 1.2. Animations explicites

* Nécessitent un appel manuel pour démarrer.
* Se déclenchent à l’intérieur d’un bloc `withAnimation(_:)`.
* Permettent d’animer plusieurs vues ou propriétés simultanément.
* Offrent un meilleur contrôle sur le moment précis où débute l’animation.

---

## 2. Les familles d’animations disponibles

SwiftUI ne fixe pas un nombre exact d’animations, mais plusieurs **familles principales** regroupent les comportements types.

### 2.1. Animations temporelles (Timing Animations)

Basées sur des courbes d’accélération, ces animations définissent la vitesse de transition dans le temps.
Elles utilisent la structure **`Animation`** et peuvent être combinées avec une durée.

**Types principaux :**

* `.linear(duration:)`

  * Progression constante du début à la fin.
  * Aucun ralentissement ni accélération.

* `.easeIn(duration:)`

  * Démarrage lent, accélération progressive.
  * Idéal pour les apparitions.

* `.easeOut(duration:)`

  * Démarrage rapide, décélération vers la fin.
  * Convient aux disparitions ou aux déplacements terminaux.

* `.easeInOut(duration:)`

  * Lent au début et à la fin, rapide au centre.
  * Animation naturelle pour transitions visuelles équilibrées.

---

### 2.2. Animations à ressort (Spring Animations)

Simulent un comportement physique avec rebond.
Elles donnent un aspect naturel et vivant, particulièrement adapté aux transitions d’éléments interactifs.

**Types principaux :**

* `.spring()`

  * Animation ressort par défaut avec paramètres internes.

* `.spring(response:dampingFraction:blendDuration:)`

  * `response` : durée totale d’un aller-retour du ressort.
  * `dampingFraction` : facteur d’amortissement (0 = rebond fort, 1 = aucun rebond).
  * `blendDuration` : durée d’interpolation entre états successifs.

* `.interpolatingSpring(stiffness:damping:)`

  * `stiffness` : raideur du ressort (plus élevé = rebond rapide).
  * `damping` : force d’amortissement.

* `.bouncy(duration:extraBounce:)` *(iOS 17+)*

  * Animation simplifiée à effet ressort.
  * `duration` : durée globale.
  * `extraBounce` : intensité du rebond.

* `.snappy(duration:extraBounce:)` *(iOS 17+)*

  * Variante plus rapide et nerveuse que `.bouncy`.

---

### 2.3. Animations personnalisées

Permettent de définir des courbes d’interpolation sur mesure ou des comportements physiques précis.

**Formes disponibles :**

* `.timingCurve(c0x:c0y:c1x:c1y:duration:)`

  * Définit une courbe de Bézier personnalisée pour la vitesse.
  * Permet de reproduire les courbes CSS standard.

* `.spring(response:dampingFraction:blendDuration:)`

  * Combinaison personnalisée de ressort et de courbe temporelle.

* `.interactiveSpring(response:dampingFraction:blendDuration:)`

  * Variante réactive adaptée aux interactions utilisateur continues (gestes).

---

## 3. Modificateurs d’animation

Les modificateurs permettent d’enrichir le comportement des animations existantes.

**Liste complète des modificateurs de la structure `Animation`:**

* `.delay(_:)`

  * Délai avant le démarrage de l’animation (en secondes).

* `.speed(_:)`

  * Facteur de vitesse.
  * Supérieur à 1 pour accélérer, inférieur à 1 pour ralentir.

* `.repeatCount(_:autoreverses:)`

  * Répète un nombre déterminé de fois.
  * `autoreverses` détermine si l’animation revient en arrière après chaque cycle.

* `.repeatForever(autoreverses:)`

  * Boucle indéfiniment l’animation.
  * `autoreverses` active le retour inverse après chaque cycle.

* `.easeIn`, `.easeOut`, `.easeInOut`, `.linear`

  * Peuvent être combinées entre elles avec les modificateurs ci-dessus.

---

## 4. Transitions

Les transitions déterminent **comment une vue entre ou sort** de la hiérarchie.
Elles s’appliquent aux vues conditionnelles (par exemple via `if`).

**Types standards disponibles dans `Transition`:**

* `.opacity` : fondu entrant/sortant.
* `.scale` : agrandissement ou réduction lors de l’apparition/disparition.
* `.slide` : glissement horizontal depuis/vers le bord par défaut.
* `.move(edge:)` : mouvement à partir d’un bord spécifique (`.top`, `.bottom`, `.leading`, `.trailing`).
* `.offset(x:y:)` : déplacement avec translation personnalisée.
* `.asymmetric(insertion:removal:)` : transitions différentes pour l’entrée et la sortie.

**Modificateurs associés :**

* `.combined(with:)` : combine plusieurs transitions (ex. `slide` + `opacity`).
* `.animation(_:)` : associe une animation spécifique à la transition.

---

## 5. Séquencement et combinaison

SwiftUI permet de composer plusieurs animations en parallèle ou en série.

**Principes de combinaison :**

* Enchaîner des animations successives en ajoutant des délais (`.delay`).
* Superposer plusieurs animations sur des propriétés différentes.
* Utiliser plusieurs `withAnimation` pour créer des étapes séquentielles.
* Ajuster la fluidité via `.blendDuration` dans les ressorts.

**Animation groupée :**

* Les changements effectués dans un même bloc `withAnimation` sont animés simultanément.
* SwiftUI gère automatiquement la synchronisation.

---

## 6. Nouvelles API d’animation (iOS 17 et +)

### 6.1. PhaseAnimator

Outil pour définir plusieurs phases d’animation successives.
Permet de décrire un ensemble d’états (par exemple “fermé”, “ouvert”, “rebondi”) et la manière dont la vue passe de l’un à l’autre.
Fonctionne avec des tableaux d’états et un déclencheur (`trigger`).

### 6.2. KeyframeAnimator

Permet de définir des animations à plusieurs étapes précises (keyframes).
Chaque étape dispose d’une durée, d’une interpolation et d’une valeur cible.
Approche similaire aux systèmes d’animation des outils de motion design (After Effects, CSS keyframes).

---

## 7. Bonnes pratiques

* Utiliser les animations pour renforcer la compréhension, jamais pour distraire.
* Privilégier des durées comprises entre 0.2 et 0.6 secondes pour la plupart des actions.
* Éviter les changements trop rapides ou simultanés qui perturbent la lisibilité.
* Harmoniser le style d’animation sur toute l’application.
* Limiter la complexité des transitions simultanées pour préserver la performance.
* Toujours tester sur appareil réel pour observer le ressenti utilisateur.

---

## 8. Tableau récapitulatif des familles et modificateurs

| Famille                     | Type ou Modificateur                                                                  | Description                         | Plateforme |
| --------------------------- | ------------------------------------------------------------------------------------- | ----------------------------------- | ---------- |
| **Timing**                  | `.linear`, `.easeIn`, `.easeOut`, `.easeInOut`                                        | Courbes d’accélération standard     | Tous       |
| **Ressort**                 | `.spring`, `.interpolatingSpring`, `.spring(response:dampingFraction:blendDuration:)` | Simule un rebond physique           | Tous       |
| **Avancées (iOS 17+)**      | `.bouncy`, `.snappy`                                                                  | Variantes simplifiées de ressorts   | iOS 17+    |
| **Personnalisées**          | `.timingCurve`, `.interactiveSpring`                                                  | Courbes ou ressorts configurables   | Tous       |
| **Modificateurs temporels** | `.delay`, `.speed`, `.repeatCount`, `.repeatForever`                                  | Contrôle du rythme de l’animation   | Tous       |
| **Transitions**             | `.slide`, `.opacity`, `.scale`, `.move(edge:)`, `.asymmetric`                         | Entrée et sortie de vues            | Tous       |
| **Transitions combinées**   | `.combined(with:)`                                                                    | Fusion de plusieurs transitions     | Tous       |
| **API avancées**            | `PhaseAnimator`, `KeyframeAnimator`                                                   | Gestion multi-phases ou images clés | iOS 17+    |

---

## 9. Conclusion

SwiftUI offre un cadre d’animation complet et extensible, fondé sur la simplicité du déclaratif.
Les animations y sont intégrées de manière fluide et naturelle, favorisant la cohérence des interactions.

Les points essentiels à retenir :

* Une animation est la conséquence d’un changement d’état.
* Deux approches sont possibles : implicite ou explicite.
* Les familles principales couvrent les courbes temporelles, les ressorts, les transitions et les animations multi-phases.
* Les modificateurs permettent d’enrichir le rythme, la répétition et le délai.
* Les nouvelles API (à partir d’iOS 17) simplifient la création d’animations complexes.

---

## 10. Références officielles

* [Apple Developer Documentation – Animation](https://developer.apple.com/documentation/swiftui/animation)
* [Apple Developer Documentation – Transition](https://developer.apple.com/documentation/swiftui/transition)
* [WWDC 2023 – Animate with SwiftUI](https://developer.apple.com/videos/play/wwdc2023/10156/)
* [WWDC 2024 – What’s New in SwiftUI Animations](https://developer.apple.com/videos/)

---

