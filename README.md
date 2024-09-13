# Documentation Théorique de Cast3M

Cette documentation détaille les aspects théoriques derrière certains opérateurs/directives et procédures de Cast3M

Elle est mise en forme avec grace au générateur de documentation [Sphinx](https://www.sphinx-doc.org/en/master/)

## Prérecquis :
Les prérequis sont :
- le générateur **sphinx**
- l'extension **sphinx-new-tab-link**
- le thème **renku-sphinx-theme**

Ceux-ci peuvent être installés avec pip :
```bash
pip install -U sphinx
pip install -U sphinx-new-tab-link
pip install -U renku-sphinx-theme
```

## Construction de la documentation avec Sphinx :
```bash
git clone https://github.com/dipaolaf/doc_theorique_cast3m_github.git
cd doc_theorique_cast3m_github
sphinx-build source/ build/
```

## Visualisation de la documentation avec firefox :
```bash
firefox build/index.html &
```
