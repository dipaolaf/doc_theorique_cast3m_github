# Documentation Théorique de Cast3M

Cette documentation détaille les aspects théoriques derrière certains opérateurs/directives et procédures de Cast3M

Elle est mise en forme grâce au générateur de documentation [Sphinx](https://www.sphinx-doc.org/en/master/)

## Prérecquis :
Les prérequis sont :
- le générateur **sphinx** version 6.2.1 (construction non garantie pour des versions supérieures)
- le thème **renku-sphinx-theme**

Ceux-ci peuvent être installés avec pip :
```bash
pip install -U sphinx==6.2.1
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
