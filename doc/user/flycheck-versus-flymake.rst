.. _flycheck-versus-flymake:

=========================
 Flycheck versus Flymake
=========================

This article compares Flycheck to the *built-in* Flymake mode.  It does not
consider third-party extensions such as flymake-easy_ or flymake-cursor_, but
references them at appropriate places.

We aim for this comparison to be fair and comprehensive, but it may contain
stale information.  Please report any incorrectness and any inconsistency you
find, and feel free to `edit this page`_ and improve it.

.. important::

   This comparison was updated at the time of the Emacs 26.1 release, which
   contains an overhaul of Flymake.  If you are using Emacs 25.3 or below, you
   can still access the comparison with the previous versions of Flymake
   `here`_.

.. _flymake-easy: https://github.com/purcell/flymake-easy
.. _flymake-cursor: https://www.emacswiki.org/emacs/flymake-cursor.el
.. _edit this page: https://github.com/flycheck/flycheck/edit/master/doc/user/flycheck-versus-flymake.rst
.. _here: /en/31/

Overview
========

This table intends to give an overview about the differences and similarities
between Flycheck and the default install of Flymake. It is not a direct
comparison to third-party extensions like flymake-easy_ or flymake-cursor_. For
a more comprehensive look compared to those extensions, please read the details
in the main article and the footnotes.

Please do **not** use this table alone to make your personal judgment.  Read the
detailed review in the following sections, too, at least with regards to the
features you are interested in.

+---------------------------+-----------------------+-----------------------+
|                           |Flycheck               |Flymake                |
+===========================+=======================+=======================+
|Supports Emacs versions    ||min-emacs|            |22+                    |
+---------------------------+-----------------------+-----------------------+
|Built-in                   |no [#]_                |yes                    |
+---------------------------+-----------------------+-----------------------+
|`Enables automatically if  |yes                    |no                     |
|possible <Enabling Syntax  |                       |                       |
|Checking_>`_               |                       |                       |
+---------------------------+-----------------------+-----------------------+
|Checks after               |save, newline, change  |newline, change        |
+---------------------------+-----------------------+-----------------------+
|Checks in background       |yes                    |yes                    |
+---------------------------+-----------------------+-----------------------+
|`Automatic syntax checker  |by major mode and      |user-defined [#]_      |
|selection <Syntax checker  |custom predicates      |                       |
|selection_>`_              |                       |                       |
+---------------------------+-----------------------+-----------------------+
|`Manual syntax checker     |yes                    |yes                    |
|selection <Manual          |                       |                       |
|Selection_>`_              |                       |                       |
+---------------------------+-----------------------+-----------------------+
|`Multiple syntax checkers  |yes                    |yes                    |
|per buffer`_               |                       |                       |
+---------------------------+-----------------------+-----------------------+
|`Supported languages`_     |>50                    |2 [#]_                 |
|                           |                       |                       |
+---------------------------+-----------------------+-----------------------+
|Checking remote files      |said to work, but not  |partly?                |
|via Tramp                  |officially supported   |                       |
|                           |[#]_                   |                       |
+---------------------------+-----------------------+-----------------------+
|`Definition of new         |single declarative     |function definition    |
|syntax checkers`_          |function/macro         |[#]_                   |
+---------------------------+-----------------------+-----------------------+
|`Error levels`_            |errors, warnings,      |errors, warnings,      |
|                           |infos, custom levels   |notes, custom levels   |
|                           |                       |                       |
+---------------------------+-----------------------+-----------------------+
|`Error identifiers`_       |yes                    |no                     |
+---------------------------+-----------------------+-----------------------+
|`Error parsing`_           |can use arbitrary      |can use arbitrary      |
|                           |functions; helpers for |parsing functions; no  |
|                           |regexp, JSON and XML   |built-in helpers       |
+---------------------------+-----------------------+-----------------------+
|Error highlighting in      |yes                    |yes                    |
|buffers                    |                       |                       |
+---------------------------+-----------------------+-----------------------+
|Fringe icons for errors    |yes                    |yes (Emacs 24.1+)      |
+---------------------------+-----------------------+-----------------------+
|`Error message display`_   |tooltip, echo area,    |tooltip only [#]_      |
|                           |fully customizable     |                       |
+---------------------------+-----------------------+-----------------------+
|List of all errors         |yes                    |yes                    |
+---------------------------+-----------------------+-----------------------+
|`Resource consumption`_    |low                    |high                   |
+---------------------------+-----------------------+-----------------------+
|`Unit tests`_              |all syntax checkers,   |none?                  |
|                           |large parts of         |                       |
|                           |internals              |                       |
+---------------------------+-----------------------+-----------------------+

Detailed review
===============

Relation to Emacs
-----------------

**Flymake** is part of GNU Emacs since GNU Emacs 22.  As such, contributions to
Flymake are subject to the FSF policies on GNU projects.  Most notably,
contributors are required to assign their copyright to the FSF.

**Flycheck** is not part of GNU Emacs, and is **unlikely to ever be** (see
`issue 801`_).  However, it is free software as well, and publicly developed on
the well-known code hosting platform :gh:`Github <flycheck/flycheck>`.
Contributing to Flycheck does not require a copyright assignment, only an
explicit agreement that your contributions will be under the GPL.

.. _issue 801: https://github.com/flycheck/flycheck/issues/801

Enabling syntax checking
------------------------

**Flymake** is not enabled automatically for supported languages.  It must be
enabled for each mode individually.

**Flycheck** provides a global mode `global-flycheck-mode`, which enables syntax
checking in every supported language.

Syntax checkers
---------------

Supported languages
~~~~~~~~~~~~~~~~~~~

**Flymake** comes only with Emacs Lisp support, and a Ruby backend is provided
as an example in the manual.  However, it is likely that extension packages for
other languages will be written and made available in MELPA_.

**Flycheck** provides support for `over 50 languages <flycheck-languages>` with
over 100 syntax checkers, most of them contributed by the community.  Notably,
Flycheck does *not* support Java and Makefiles.

.. _Flymake page: https://www.emacswiki.org/emacs/FlyMake
.. _MELPA: http://melpa.org/

Definition of new syntax checkers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Flymake** backends are single functions which take a callback function, and
should report diagnostics to the callback.

**Flycheck** provides a single function `flycheck-define-checker` to define a
new syntax checker.  This function uses a declarative syntax which is easy to
understand even for users unfamiliar with Emacs Lisp.  In fact most syntax
checkers in Flycheck were contributed by the community.

For example, the Perl checker in Flycheck is defined as follows:

.. code-block:: elisp

   (flycheck-define-checker perl
     "A Perl syntax checker using the Perl interpreter.

   See URL `http://www.perl.org'."
     :command ("perl" "-w" "-c" source)
     :error-patterns
     ((error line-start (minimal-match (message))
             " at " (file-name) " line " line
             (or "." (and ", " (zero-or-more not-newline))) line-end))
     :modes (perl-mode cperl-mode))

Customization of syntax checkers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Flymake** does not provide built-in means to customize syntax checkers.
Instead, when defining a new syntax checker the user needs to declare
customization variables explicitly and explicitly check their value in the init
function.

**Flycheck** provides built-in functions to add customization variables to
syntax checkers and splice the value of these variables into the argument list
of a syntax checking tool.  Many syntax checkers in Flycheck provide
customization variables.  For instance, you can customize the enabled warnings
for C with `flycheck-clang-warnings`.  Flycheck also tries to automatically find
configuration files for syntax checkers.

Executables of syntax checkers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Flymake** does not provide built-in means to change the executable of a syntax
checker.

**Flycheck** implicitly defines a variable to set the path of a syntax checker
tool for each defined syntax checker and provides the interactive command
`flycheck-set-checker-executable` to change the executable used in a buffer.

Syntax checker selection
------------------------

**Flymake** selects backends based on the content of the
`flymake-diagnostic-functions` hook.  This allows users to add backends for
specific modes or even files.

**Flycheck** uses the major mode to select a syntax checker.  Custom predicates
allows one to refine the selection of a checker further.

Custom predicates
~~~~~~~~~~~~~~~~~

**Flymake** may allow for backends to implement custom logic to decide whether
to run the check or not.  There are no easily-defined predicate functions.

**Flycheck** also supports custom predicate function.  For instance, Emacs uses
a single major mode for various shell script types (e.g. Bash, Zsh, POSIX Shell,
etc.), so Flycheck additionally uses a custom predicate to look at the value of
the variable `sh-shell` in Sh Mode buffers to determine which shell to use for
syntax checking.

Manual selection
~~~~~~~~~~~~~~~~

**Flymake** users may manually select a specific by backend by overriding the
value of the backends list.

**Flycheck** provides the local variable `flycheck-checker` to explicitly use a
specific syntax checker for a buffer and the command `flycheck-select-checker`
to set this variable interactively.

Multiple syntax checkers per buffer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Flymake** will use all the backends added to the
`flymake-diagnostic-functions` hook to check a buffer; all backends are started
at the same time, but errors are reported in the buffer as soon as a backend
returns them.

**Flycheck** can also apply multiple syntax checkers per buffer, but in sequence
rather than concurrently.  For instance, Flycheck will check PHP files with PHP
CLI first to find syntax errors, then with PHP MessDetector to additionally find
idiomatic and semantic errors, and eventually with PHP CheckStyle to find
stylistic errors.  The user will see all errors reported by all of these tools
in the buffer.  However, if the first checker reported at least one error, then
the subsequent checkers would not be run.

Errors
------

Error levels
~~~~~~~~~~~~

**Flymake** supports error, warning and note levels by default.  Additional
error levels can easily be defined by adding them to
`flymake-diagnostic-types-alist`.

**Flycheck** supports error, warning and info messages.  Flycheck allows you to
define new error levels for use in custom syntax checkers with
`flycheck-define-error-level`.

Error identifiers
~~~~~~~~~~~~~~~~~

**Flymake** does not support unique identifiers for different kinds of errors.

**Flycheck** supports unique identifiers for different kinds of errors, if a
syntax checker provides these.  The identifiers appear in the error list and in
error display, and can be copied independently, for instance for use in an
inline suppression comment or to search the web for a particular kind of error.
Some checkers can also provide more detailed error explanations based on these
error identifiers.

Error parsing
~~~~~~~~~~~~~

**Flymake** lets backend choose how they want to parse error messages from
tools.  There are no built-in helpers for defining error patterns, or for
parsing JSON or XML formats.

**Flycheck** can use regular expressions as well as custom parsing functions.
The preferred way to define a checker is to use the `rx` syntax, extended with
custom forms for readable error patterns.  Flycheck includes some ready-to-use
parsing functions for well-known output formats, such as Checkstyle XML.

Error message display
~~~~~~~~~~~~~~~~~~~~~

In GUI frames, **Flymake** shows error messages in a tool tip, if the user
hovers the mouse over an error location.  It does not provide means to show
error messages in a TTY frame, or with the keyboard only.

The third-party library flymake-cursor_ shows Flymake error messages at point
in the echo area, by overriding internal Flymake functions.

**Flycheck** shows error message tool tips as well, but also displays error
messages in the echo area, if the point is at an error location.  This feature
is fully customizable via `flycheck-display-errors-function`, with several
`extensions <flycheck-extensions>` already using that functionality.

Resource consumption
--------------------

Syntax checking
~~~~~~~~~~~~~~~

**Flymake** starts a syntax check after every change, regardless of whether the
buffer is visible in a window or not.  It does not limit the number of
concurrent syntax checks.  As such, Flymake starts many concurrent syntax
checks when many buffers are changed at the same time (e.g. after a VCS revert),
which is known to freeze Emacs temporarily.

**Flycheck** does not conduct syntax checks in buffers which are not visible in
any window.  Instead it defers syntax checks in such buffers until after the
buffer is visible again.  Hence, Flycheck does only start as many concurrent
syntax checks as there are visible windows in the current Emacs session.

Checking for changes
~~~~~~~~~~~~~~~~~~~~

**Flymake** uses a *separate* timer (in `flymake-timer`) to periodically check
for changes in each buffer.  These timers run even if the corresponding buffers
do not change.  This is known to cause considerable CPU load with many open
buffers.

**Flycheck** does not use timers at all to check for changes.  Instead it
registers a handler for Emacs' built-in `after-change-functions` hook which is
run after changes to the buffer.  This handler is only invoked when the buffer
actually changed and starts a one-shot timer to delay the syntax check until the
editing stopped for a short time, to save resources and avoid checking
half-finished editing.

Unit tests
----------

**Flymake** does not appear to have a test suite at all.

**Flycheck** has unit tests for all built-in syntax checkers, and for large
parts of the underlying machinery and API.  Contributed syntax checkers are
required to have test cases.  A subset of the test suite is continuously run on
`Travis CI`_.

.. _Travis CI: https://travis-ci.org/flycheck/flycheck

.. rubric:: Footnotes

.. [#] Flycheck is **unlikely to ever become part of Emacs**, see `issue 801`_.

.. [#] The 3rd party library flymake-easy_ allows to use syntax checkers per
       major mode.

.. [#] It is likely that more Flymake backends will be available on MELPA.

.. [#] See for instance `this comment`_.

       .. _this comment: https://github.com/flycheck/flycheck/issues/883#issuecomment-188248824

.. [#] `flymake-easy`_ provides a function to define a new syntax checker, which
       sets all required variables at once.

.. [#] The 3rd party library `flymake-cursor`_ shows Flymake error messages at
       point in the echo area.
