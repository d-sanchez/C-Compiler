\documentclass[border=10pt]{standalone}\usepackage{qtree} \begin{document} \Tree [.{Translation Node}  [.{External Declaration}  [.{Function Definition}  [.{Declaration Specifiers}  [ int ]  ]  [.Declarator  [.{Direct Declarator}  {main}  ]  ]  [.{Compound Statement} {Open Bracket}  [.{Declaration List}  [.{Declaration List}  [.{Declaration List} [ .{Declaration}  [.{Declaration Specifiers}  [ int ]  ]  [.{Init Declarator List}  [.{Init Declarator}  [.Declarator  [.{Direct Declarator}  {x}  ]  ]  ]  ]  ]  ] [ .{Declaration}  [.{Declaration Specifiers}  [ char ]  ]  [.{Init Declarator List}  [.{Init Declarator}  [.Declarator  [.{Direct Declarator}  {y}  ]  ]  ]  ]  ]  ] [ .{Declaration}  [.{Declaration Specifiers}  [ float ]  ]  [.{Init Declarator List}  [.{Init Declarator}  [.Declarator  [.{Direct Declarator}  {z}  ]  ]  ]  ]  ]  ]  {Closed Bracket} ]  ]  ]  ] \end{document} 