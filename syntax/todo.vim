" File:        todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/freitass/todo.txt-vim
" Version:     0.3

if exists("b:current_syntax")
    finish
endif

" Dim grey for entire close entry, or comment lines
syntax  match  TodoDone               '^[xX]\s.\+$'
syntax  match  TodoComment            '^#\s.\+$'                       contains=TodoBUG,TodoFIXME,TodoTODO,TodoNOTE,TodoXXX


" Dark purple for 'directives' (syntax extension, like c preproc directives)
syntax  match  TodoDirective          '^#\w.*$'                         contains=TodoVId
syntax  match  TodoVId                '[A-Za-z_][A-Za-z0-9_-]\+\W\+'    contained contains=TodoNumeric,TodoNumerals

"syntax match   TodoNumeric            '\(^\|\W\)[0-9][0-9,\/\.\+-]*\($\|\W\|[A-Za-z0-9\/\^]\{1,9\}\)'  contains=TodoNumeral
"syntax match   TodoNumeric            '[0-9][0-9,\/\.\+-]*\($\|\W\|[A-Za-z0-9\/\^]\{1,9\}\)'  contains=TodoNumeral
"syntax match   TodoNumeral            '[0-9]\+'  contained

syntax  match  TodoPriorityA          '^\s*([aA][^\)]*)\s\+'            contains=TodoDate,TodoIssueID
syntax  match  TodoPriorityB          '^\s*([bB][^\)]*)\s\+'            contains=TodoDate,TodoIssueID
syntax  match  TodoBUG                'BUG'                             
syntax  match  TodoPriorityC          '^\s*([cC][^\)]*)\s\+'            contains=TodoDate,TodoIssueID
syntax  match  TodoFIXME              'FIXME'
syntax  match  TodoPriorityD          '^\s*([dD][^\)]*)\s\+'            contains=TodoDate,TodoIssueID
syntax  match  TodoTODO               'TODO'
syntax  match  TodoPriorityE          '^\s*([eE][^\)]*)\s\+'            contains=TodoDate,TodoIssueID
syntax  match  TodoNOTE               'NOTE'
syntax  match  TodoPriorityF          '^\s*([fF][^\)]*)\s\+'            contains=TodoDate,TodoIssueID
syntax  match  TodoXXX                'XXX'
syntax  match  TodoPriorityPit        '^\s*([g-rG-R][^\)]*)\s\+'        contains=TodoDate,TodoIssueID
syntax  match  TodoPriorityPermafrost '^\s*([s-zS-Z][^\)]*)\s\+'        contains=TodoDate,TodoIssueID


" Tag-Id's (Strings with numbers, ie. TODO-123 BUG456)
" this has a side effect of coloring every alphanumeric concatenation, like IE4,
" HTML5 too. But that is acceptable for me now.
" NOTE: tags of reference ID's cannot contain numericals sadly, and this only
" takes numerical ID's. So no PROJ2-8d9x3 etc. If trying to apply such format
" here, would need to detect for non-dictionary words. Ie. not practical.
syntax  match  TodoInlineRefs1    '\(^\|\s\)[A-Za-z_-]\+[\-\._]\?[0-9][0-9\-\.]*\(\s\|$\|\W\)' contains=TodoInlineRefs1,TodoProject,TodoContext
" Better to use alt. inlineref format which enforces separator, still needs some
" thought on allowed chars to pervent overlap with others. For complex Id's,
" using meta or uriref may be more suited.
"syntax  match  TodoInlineRefs2    '\(^\|\s\)[A-Za-z0-9_-]\+[\-\._][^\ ]\+\(\s\|$\|\W\)' contains=TodoInlineRefs2,TodoProject,TodoContext


"syntax  match  TodoDate           '\(^\|\s\)\d\{2,4\}-\d\{2\}-\d\{2\}'       contained contains=NONE
syntax  match  TodoDate           '\(^\|\s\)\d\{2,4\}-\d\{2\}-\d\{2\}'       contains=TodoDate,TodoIssueID

" Treat any header ending with a colon as the IssueId for the entry
" FIXME: need to match only first occurence, not meta attributes
"syntax  match  TodoIssueID        '\(^\|\s\)\w[A-Za-z0-9_\.-]\+:' contains=NONE
syntax  match  TodoIssueID        '\(^\|\s\)\([A-Za-z_][A-Za-z0-9_-]\+[\-\._]\)\?[0-9\-\.]\+:' contains=NONE

syntax  match  TodoProject        '+[^[:blank:]]\+'                          contains=NONE
syntax  match  TodoContextAlt     '@[^[:blank:]]\+'                          contains=NONE
syntax  match  TodoContext        '@[A-Z][^[:blank:]]\+'                     contains=NONE
syntax  match  TodoUser           '\~[^[:blank:]]\+'                         contains=NONE
syntax  match  TodoMeta           '\(^\|\<\)[A-Za-z\.\/_-]\+:[^[:blank:]]\+' contains=NONE
syntax  match  TodoCite           '\s*\[[^\]]*\]'
syntax  match  TodoXRef           '\s*<[^>]*>'

" Colour quoted values serpatedly at various levels
syntax  match  TodoQuote          '\s*\'[^\']*\''
syntax  match  TodoQuote2         '\s*\'\'[^\']*\'\''
syntax  match  TodoQuote3         '\s*\'\'\'[^\']*\'\'\''
syntax  match  TodoQuoteAngle     '\s*`[^`]*`'
syntax  match  TodoQuoteAngle2    '\s*``[^`]*``'
syntax  match  TodoQuoteAngle3    '\s*```[^`]*```'
syntax  match  TodoQuoteDouble    '\s*"[^"]*"'
syntax  match  TodoQuoteDouble2   '\s*""[^"]*""'
syntax  match  TodoQuoteDouble3   '\s*"""[^"]*"""'

syntax  match  TodoHold               '^.\+\ \[WAIT\]'              contains=TodoBUG,TodoFIXME,TodoTODO,TodoNOTE,TodoXXX,TodoDate,TodoIssueID,TodoProject,TodoContext,TodoContextAlt,TodoUser,TodoMeta,TodoCite,TodoXRef,TodoHoldTag
" ,TodoVId
syntax  match  TodoHoldTag        '\s*\[WAIT\]'


" Other priority colours might be defined by the user. 
" To load a demo into a new buffer:
"   :so $VIMRUNTIME/syntax/hitest.vim
"
" This mapping was made with colorscheme=Mustang and Tango or similary
" toned down pallette and adapted to ANSI 16-colours scheme.

highlight  default  link  TodoHold        Comment
highlight  default  link  TodoHoldTag     PreProc
highlight  default  link  TodoDone        Comment
highlight  default  link  TodoComment     Comment
highlight  default  link  TodoDirective   NonText
highlight  default  link  TodoVId         Type
highlight  default  link  TodoNumeric     Number
highlight  default  link  TodoNumeral     Type

highlight  default  link  TodoQuote        Identifier
highlight  default  link  TodoQuote2       Identifier
highlight  default  link  TodoQuote3       Identifier
highlight  default  link  TodoQuoteAngle   MatchParen
highlight  default  link  TodoQuoteAngle2  MatchParen
highlight  default  link  TodoQuoteAngle3  MatchParen
highlight  default  link  TodoQuoteDouble  WarningMsg
highlight  default  link  TodoQuoteDouble2 WarningMsg
highlight  default  link  TodoQuoteDouble3 WarningMsg

"   top-4 prios. this works best if with alternating video and white-vs-color.
highlight  default  link  TodoPriorityA  Search
highlight  default  link  TodoPriorityB  CursorLineNr
highlight  default  link  TodoPriorityC  StatusLine
highlight  default  link  TodoPriorityD  Normal
highlight  default  link  TodoPriorityE  StatusLineNC
highlight  default  link  TodoPriorityF  Comment

highlight  default  link  TodoBUG  CursorLineNr
highlight  default  link  TodoFIXME  StatusLine
highlight  default  link  TodoTODO  Normal
highlight  default  link  TodoNOTE  StatusLineNC
highlight  default  link  TodoXXX  Comment

"   and now the rest G-R, S-Z
highlight  default  link  TodoPriorityPit VertSplit
highlight  default  link  TodoPriorityPermafrost VertSplit

" Bright yellow dates
highlight  default  link  TodoDate        PreProc

" Grey ~user
highlight  default  link  TodoUser        SignColumn

" Override with some dimmer variety from VIM airline, & others
highlight  default  link  TodoInlineRefs1 NERDTreeDir
highlight  default  link  TodoInlineRefs2 NERDTreeDir
highlight  default  link  TodoCite        airline_tabfill
highlight  default  link  TodoContextAlt  NERDTreeUp
highlight  default  link  TodoContext     Directory
highlight  default  link  TodoProject     GitGutterChangeDefault

" Std. scheme refs for above
highlight  default  link  TodoInlineRefs1 MoreMsg
highlight  default  link  TodoInlineRefs2 MoreMsg
highlight  default  link  TodoCite        Type
" would like a greenish but my Identifier is too bright
highlight  default  link  TodoXRef        Comment
" White underlined for issue-id
highlight  default  link  TodoIssueID     CursorLine
" Blue @contexts
highlight  default  link  TodoContext     Directory
" Orange +projects
highlight  default  link  TodoProject     Special

" Purple for meta:data fields
highlight  default  link  TodoMeta        Type
"highlight  default  link  TodoMeta       Statement


if exists('g:todo_load_python') && g:todo_load_python
    if has('python')
        let b:curdir = expand('<sfile>:p:h')
        let s:script_dir = b:curdir . "/python/"
        execute "pyfile " . s:script_dir. "todo.py"
    elseif has('python3')
        let b:curdir = expand('<sfile>:p:h')
        let s:script_dir = b:curdir . "/python/"
        execute "py3file " . s:script_dir. "todo.py"
    else
        echom "Your version of vim has no python support. Overdue dates won't be highlighted"
    endif
endif

let b:current_syntax = "todo"
