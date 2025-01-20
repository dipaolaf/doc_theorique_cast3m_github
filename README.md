# Documentation Théorique de Cast3M

Cette documentation détaille les aspects théoriques derrière certains opérateurs/directives et procédures de Cast3M

Elle est mise en forme grâce au générateur de documentation [Sphinx](https://www.sphinx-doc.org/en/master/)

## Prérecquis :
Les prérequis sont :
- le générateur **sphinx** (la version utilisée actuellement est la 8.1.3)
- le thème **sphinx_rtd_theme**

Ceux-ci peuvent être installés avec pip :
```bash
pip install -U sphinx
pip install -U sphinx_rtd_theme
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

## Visualisation de la documentation sur Read the Docs :
Une version compilée de la branche "main" est consultable sur le site Read the Docs :
https://doc-cast3m.readthedocs.io/fr/latest/
