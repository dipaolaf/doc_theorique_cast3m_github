from pygments.style import Style
from pygments.token import Keyword, Operator, Name, Comment, String, Error, Text, \
     Number, Generic, Whitespace, Punctuation, Other, Literal


class MyStyle(Style):
    default_style = ""
    background_color = "#f8f8f8"
    styles = {
        Comment:    "italic #999999",
        Keyword:    "bold #2986cc", #operateurs gibiane
        Operator:   "bold #2986cc", #operateurs arithmetique (+ - * / >EG ...)
        Name.Builtin: "bold #6aa84f", #procedures gibiane
        Name.Constant: "#660000", #VRAI, FAUX ...
        String:     "#ae59c3",
        Number:     "#e78a29",
    }
