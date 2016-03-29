#!/bin/bash

## Set difficulty (easy,intermediate,expert)
#DIFFICULTIES="easy"
DIFFICULTIES="easy intermediate expert"

for difficulty in ${DIFFICULTIES[@]}
do
    ## Make sudoku
    echo
    echo "qqwing --generate 12 --one-line --difficulty ${difficulty} > page1.81"
          qqwing --generate 12 --one-line --difficulty ${difficulty} > page1.81

    ## Solve sudoku
    echo
    echo "cat page1.81 | qqwing --solve --one-line > page1_sol.81"
          cat page1.81 | qqwing --solve --one-line > page1_sol.81

    ## format for logicpuzzle
    echo
    echo "./createlpsudoku -o sudoku.lps -i page1.81"
          ./createlpsudoku -o sudoku.lps -i page1.81
    echo
    echo "./createlpsudoku -o sudoku_sol.lps -i page1_sol.81"
          ./createlpsudoku -o sudoku_sol.lps -i page1_sol.81 

    ## Make evenly spaced
    #echo
    #echo "sed 's/\end{lpsudoku}/\end{lpsudoku}\vskip2.0\baselineskip/' -i sudoku.lps"
    #      sed 's/\end{lpsudoku}/\end{lpsudoku}\\vskip2.0\\baselineskip/' -i sudoku.lps
    #echo
    #echo "sed 's/\end{lpsudoku}/\end{lpsudoku}\vskip2.0\baselineskip/' -i sudoku_sol.lps"
    #      sed 's/\end{lpsudoku}/\end{lpsudoku}\\vskip2.0\\baselineskip/' -i sudoku_sol.lps

    ## compile final product
    echo "latexmk -lualatex sudoku.tex sudoku_sol.tex"
          latexmk -lualatex sudoku.tex sudoku_sol.tex

    ## Merge two documents
    #echo "pdftk sudoku.pdf sudoku_sol.pdf output sudoku-${difficulty}.pdf"
    #      pdftk sudoku.pdf sudoku_sol.pdf output sudoku-${difficulty}.pdf
    echo "stapler cat sudoku.pdf sudoku_sol.pdf sudoku-${difficulty}.pdf"
          stapler cat sudoku.pdf sudoku_sol.pdf sudoku-${difficulty}.pdf
done


#echo "rm -f sudoku.pdf sudoku_sol.pdf"
#      rm -f sudoku.pdf sudoku_sol.pdf

#echo "rm -f *.lps page*81"
#      rm -f *.lps page*81

echo "latexmk -c"
      latexmk -c



