# -*- coding: utf-8 -*-
import os
import sys
sys.path.append(os.path.abspath('./_custom')) 


# Configuration générale
project = 'Cast3M - Théorie'
version = '2025.0'
release = '2025.0'
author = ''
copyright = 'CEA'
language = 'fr'

extensions = [
    'sphinx.ext.todo',   # pour ajouter des avertissements "todo"
    'gibianelexer'       # lexer pour le langage Gibiane
]

templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'

pygments_style = 'my_style.MyStyle'  # style de coloration choisit
rst_prolog = """
.. role:: gibiane(code)
  :language: gibiane
   :class: highlight
"""
todo_include_todos = True
smartquotes = False  # pour éviter le remplacement automatique de simple quote en double

# Options for HTML output
html_theme = 'sphinx_rtd_theme'
html_theme_options = {
     'logo_only': True,
     'style_nav_header_background': '#006B60',
     'collapse_navigation': False,
   }
html_logo = '_static/Logo_Cast3M_blanc.png'
html_static_path = ['_static']

# Modification du thème avec un fichier css
# on veut numéroter les équations sur la droite (et pas au-dessus) avec :label: eq1
# https://stackoverflow.com/questions/14110790/numbered-math-equations-in-restructuredtext
def setup(app):
    app.add_css_file('css/custom.css')
