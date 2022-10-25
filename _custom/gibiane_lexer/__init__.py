#-*- coding: utf-8 -*-
# pylint: disable=bad-whitespace
# flake8: noqa
"""
    Pygments Gibiane Lexer
    BP, 2021
"""
from __future__ import absolute_import, unicode_literals, print_function

from .lexer import GibianeLexer

__version__         = "1.0"


def setup(app):
    """ Initializer for Sphinx extension API.
        See http://www.sphinx-doc.org/en/stable/extdev/index.html#dev-extensions.
    """
    lexer = GibianeLexer()
    for alias in lexer.aliases:
        app.add_lexer(alias, lexer)

    return dict(version=__version__)


__all__ = ['GibianeLexer', 'setup']
