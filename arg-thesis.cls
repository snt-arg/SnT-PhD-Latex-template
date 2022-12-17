% https://www.overleaf.com/learn/latex/Writing_your_own_class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{arg-thesis}[2022/12/31 Thesis class]


\DeclareOption{defended}{\def\@defended{1}}
% every option not explicitly defined
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper]{report}

% packages (keep after LoadClass)
\RequirePackage[left=3cm,right=2.5cm]{geometry}
\RequirePackage[overload]{textcase}
\RequirePackage[svgnames]{xcolor}
\RequirePackage[colorlinks]{hyperref}
\RequirePackage{tikz}
\RequirePackage{setspace}
\RequirePackage{graphicx}
\RequirePackage[backend=biber, style=numeric, sorting=none, urldate=comp]{biblatex}
\RequirePackage[Lenny]{fncychap}
\RequirePackage[acronym]{glossaries}
\RequirePackage[capitalise]{cleveref}
\RequirePackage{amsmath,amssymb,amsfonts,amsthm}
\RequirePackage{float}


% hyper setup
\hypersetup{
     colorlinks = true,
     allcolors  = MidnightBlue
}

% graphix setup
\DeclareGraphicsExtensions{.pdf,.jpeg,.jpg,.png,.eps}

%Setting line spacing 1.5
\setstretch{1.5}

% definitions
\newcommand{\bornDate}[1]{\def\@bornDate{#1}}
\newcommand{\bornLocation}[1]{\def\@bornLocation{#1}}
\newcommand{\defenceDate}[1]{\def\@defenceDate{#1}}
\newcommand{\phdNumber}[1]{\def\@phdNumber{#1}}
\newcommand{\university}[1]{\def\@university{#1}}
\newcommand{\faculty}[1]{\def\@faculty{#1}}
\newcommand{\group}[1]{\def\@group{#1}}
\newcommand{\degreeTitle}[1]{\def\@degreeTitle{#1}}
\newcommand{\degreeIn}[1]{\def\@degreeIn{#1}}
\newcommand{\cetmembers}[1]{\def\@cetmembers{#1}}
\newcommand{\defencemembers}[1]{\def\@defencemembers{#1}}
\newcommand{\defencedate}[1]{\def\@defencedate{#1}}
\newcommand{\signatureImage}[1]{\def\@signatureImage{#1}}
\newcommand{\signatureLocation}[1]{\def\@signatureLocation{#1}}

\def\@unilogo{template-pictures/University_of_Luxembourg_logo_(fr)-1.pdf}

% redefine abstract
\newbox\@abstractbox
\renewenvironment{abstract}{%
  \global\setbox\@abstractbox=\vtop\bgroup
  \par\medskip\noindent\unskip\ignorespaces\it}
{\egroup}

% define acknowledgments
\newbox\@acknowledgmentbox
\newenvironment{acknolegements}{%
  \bgroup\begin{minipage}[c]{0.75\textwidth}\global\setbox\@acknowledgmentbox=\vtop\bgroup
  \par\medskip\noindent\unskip\ignorespaces}
{\par\nobreak\smallskip\hfill\@author\egroup\end{minipage}\egroup}

\newbox\@quoteauthor
\newbox\@quoteauthorcite
\newenvironment{citequote}[1][Shakespeare]{%
  \sbox\@quoteauthorcite{#1}
  \bgroup\begin{centering}\begin{minipage}{0.6\textwidth}\bgroup\global\setbox\@quoteauthor=\vtop\bgroup
  \par\medskip\noindent\unskip\ignorespaces\it}
{\par\hspace{1em plus 1fill}---\usebox{\@quoteauthorcite}\egroup\egroup\end{minipage}\end{centering}\egroup}

% custom maketitle
\renewcommand{\maketitle}{{%
    \raggedright
    \pagenumbering{roman}%
    \thispagestyle{empty}%
    % cover page after defense
    \ifcsname @defended\endcsname%
            \begin{minipage}[H]{\linewidth}%
            \begin{center}
            \includegraphics[width=1.5cm]{\@unilogo}%
            \end{center}
            \begin{center}
            \textbf{\footnotesize{\@phdNumber}}\par
            \ifcsname @faculty\endcsname
                \textbf{\footnotesize{\@faculty}}\par
            \fi
            \vspace{0.5cm}
            \LARGE{DISSERTATION}\par
            \vspace{0.3cm}
            \large{Defence held on \@defenceDate~in Luxembourg}\par
            to obtain the degree of\par
            \vspace{0.3cm}
            \textbf{\large{\MakeUppercase{\@degreeTitle}}}\par
            \textbf{\large{\MakeUppercase{\@degreeIn}}}\par
            \large{by}\par
            \textbf{\large{\@author}}\par
            \small{Born on \@bornDate~in \@bornLocation}\par
            \vspace{0.5cm}
            %\noindent\rule{12cm}{0.4pt}\par
            \large{\textsc{\textbf{\@title}}}\par
            %\noindent\rule{12cm}{0.4pt}
            \vspace{0.5cm}
            \end{center}\par
            \noindent\textbf{\large{Dissertation defence committee:}}\par%
            \foreach \x\y in \@defencemembers {{\x\\[-5pt]\indent\hspace{0.5cm}{\scriptsize{\y}}}\par}%
        \end{minipage}
        \thispagestyle{empty}%
        %
        %
        \newpage
        \ % The empty page
        \newpage\clearpage
        \thispagestyle{empty}
    \fi

    % cover page needed before and after defense
    \noindent\begin{minipage}{\linewidth}
    \begin{center}\includegraphics[width=0.3\linewidth]{\@unilogo}\end{center}
    \centering{\huge{\textsc{\@university}}}\par
    \ifcsname @faculty\endcsname
        \vspace{0.5cm}
        \centering{\Large{\textsc{\@faculty}}}\par
    \fi
    \vspace{0.5cm}
    \centering{\large{\textsc{\@group}}}\par
    \vspace{0.5cm}
    \large{\textsc{Doctoral Thesis}}
    
    \noindent\rule{\textwidth}{1pt}
    \huge{\textsc{\@title}}
    \noindent\rule{\textwidth}{1pt}
    \vspace{0.5cm}
    \end{minipage}
    
    \noindent\large{\textbf{Author}}\hfill\@author\par
    \vspace{0.2cm}
    \noindent\large{\textbf{Dissertation Supervisors}}\hfill%
    \foreach \x in \@cetmembers {\hfill\x\par}%
    
    \newpage
    \ % The empty page
    \newpage\clearpage
    % declaration of authorship
    \section*{Declaration of Authorship}
    I, \@author, declare that the Ph.D. thesis entitled "\@title" and the work presented in it are my own. I confirm that:
    \begin{itemize}
        \item This work was done wholly or mainly while in candidature for a research degree at this University.
        \item Where any part of this thesis has previously been submitted for a degree or any other qualification at this University or any other institution, this has been clearly stated.
        \item Where I have consulted the published work of others, this is always clearly attributed.
        \item Where I have quoted from the work of others, the source is always given. With the exception of such quotations, this thesis is entirely my own work.
        \item I have acknowledged all main sources of help.
        \item Where the thesis is based on work done by myself jointly with others, I have made clear exactly what was done by others and what I have contributed myself.
    \end{itemize}
    \vspace{1.5cm}\par
    \begin{centering}
    \@author\par
    \vspace{0.5cm}
    \noindent\includegraphics[width=4cm]{\@signatureImage}\par
    \vspace{0.5cm}
    \@signatureLocation, \today
    \end{centering}
    \ % The empty page   
    % abstract
    \chapter*{Abstract}
    \usebox{\@abstractbox}
    \newpage
    \ % The empty page
    \newpage
    % personal quote
    \vspace*{\fill}
    {\centering\usebox{\@quoteauthor}\par}
    \vspace*{\fill}
    \newpage
    \ % The empty page
    \newpage
    % acknowledgments
    \begin{centering}
    \section*{Acknowledgements}
    \end{centering}
    {\centering\usebox{\@acknowledgmentbox}\par}
    %
    \newpage
    \ % The empty page
    \clearpage
    \renewcommand*\contentsname{Index}
    \tableofcontents
    \newpage
    \listoffigures
    \listoftables
    \newpage
    \printglossary[type=\acronymtype]
    \newpage
    \pagenumbering{arabic} 
    \setcounter{page}{1}
}}