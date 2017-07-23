
Proposed Syntax additions to todo.txt
Partially implemented in htd.

The traditional todo.txt is a simple format, but it has a few shortcomings.
The following introduce some concepts that make it a bit more generic, add
optionally more complex structure, but aim for the same simple syntax.

There are three new principle concepts in all described below:

- external content
- task comment structure, identity and references
- multi-user awareness

The syntax is probably quite restrictive for sanity: a lot of the
operations you will want to do on the file obey the single-line principle and
will likely be regex based.

But ofcourse using symbolic references like tags screams for some kind of
machine aided processing. And finally having only room for single line calls for
a bit of integration with contexts that can handle multiline content.


.. _Issue:

Issue
  Or double-layered structured task line description.

  Part of my personal quest, is to go from source-embedded TODO/FIXME/BUG/...
  comments, to tracked issues in some backend.

  To todo.txt, my 'issue' or task line, is a single line of text in a file
  somewhere. And it has no concept like the above tags. Also as a line-based
  format its possilities are restricted.

  To facility workflows that do, I would like to introduce a further segmentation
  into the issue description.

  The new element introduced is a Tag-ID reference. Tailed by ': ' it indicates
  either:

  1. the principle issue ID the task line represents if it is at the start of
     the description. Or
  2. a linked entity such as a comment on the principle or current task

  Are there more layers. N-ary sounds fine to me..

  That segments the description and adds structure and some semantics to a
  single line task description like todo.txt.

  If an app choose to handle such layering, it should specify also a mode
  of context, project and metadata attribute handling. Ie. can they belong to a
  sub-entity or not and how.


Comment
  Idk. if there is prior art here. But lets reserve the octotrophe and make the
  'empty-preprocessor' a indicator for comment lines::

    # ... comment ..

  reserving and distinguishing for further extensions:

  - Preprocessor commands e.g. ``#[A-Z_]...ascii``, or shebang ``#!`` and
    other octotrophe + nonwhitespace modelines as distinct from
  - Comment lines ``#\s``, maybe with modelines.

  And the right to ignore or strip comments w/o. affecting functionality,
  and handle all other with specified knowledge. Specifically that unknown or
  unrecognized directives should be discarded.


.. _Reference:

Reference
  Using all-capital words separated from a numerical ID is a common way to refer
  to externally indexed, globally reasonably well-defined entities. This can
  be PEP in the context of Python development. Or RFC, BUG, USER, etc.

  This introduces the concept of a Tag-ID, as a form of Identifier_.

  A tag-ID reference should be handled as a symbolic link, which may also be
  contained as first-class text, and substituted or represented by an
  equivalent symbol.

  As a first-class part of the description it appears as is as a link or
  representation of the entity, but in square brackets it concerns and links
  the preceeding description.
  If trailed by ':' it signifies a multi-layer structure described in Issue_.

  In each case the tag represents a link or shared identity, probably also
  represented by for example an issue title or URL.
  In all cases it may represent an externally recorded entity, or it can be just
  for local task handling.  If the tasks are local to a file record, it may
  still add references on external entities.

  In a primary/secondary structured task, it should reflect on the entity for
  which description it was found in.

  Using tags like this raises a design decision point, concerning
  the valid characters and implications of the tag-ID I go into in Identifier.


.. _Source:

Source
  todo.txt has no concept of multifile storage, well beyond todo and done.

  A regular editor can provide the context and UI to navigate from one file
  to another given some identifier in the source. Without making that conceptual
  concext too complex here, it would be nice to have a fairly dumb text editor
  be able to jump files too.

  Having a way to refer to entities may help a more sophisticated editor.
  But size, complexity and the single-line restriction all threaten to limit the
  use of todo.txt in tasks workflows.

  - too much text reduces the usability of the single filtered list view style
    of interaction
  - preformatted content is not possible, or far t0o verbose
  - there are no forms of composite lists, even like simply breaking up a list
    into several source locations.

  Here lets mention Projects and Contexts. These naturaly make task lines a
  candidate for some more intelligent, context aware handling.
  As for multipart content or preprocessing IIRC from my Processing sketches
  this is the c-style way of including a local file, and a file in a library
  on a lookup path::

    #include "my/id.ext"
    #include <my/id.ext>

  I have no use for it at the moment. I think context and projects are a better
  match for handling of migrating tasks.
  But additionally the ``<scheme:ID>`` is too interesting no to mention here
  and describe in Symbolize_.


Tilde
  The tilde came from Spanish, and Latin `titulus`, and is used for omission.
  Such as the entry word in a dictionary [WP]. In shell it stands in for the
  users home directory, and is found in URL's as the user's (public HTML) HTTP
  basepath. As in ``http://localhost/~username``.

  In a todo.txt task, it refers to the tasks identity iot. make a terse
  reference from a Linked Description to a containing issue if it is standing
  alone.

  If used as prefix, it can be equivalent to a user metadata property.


.. _User:

User
  There is no user concept in the original todo.txt. In effect the editing of
  a file locks all of the 'issues' for the current user.

  To add awareness of assignment, creator etc. the concept introduced and
  combined with the Tilde extension, and the metadata specification.

  Some more concepts and settings are needed.
  If an implementation is user aware, it should by default handle (e.g.) the
  'user:me' meta key as equivalent to '~me'. And is illegal for both to exists
  in a task.
  From here more extended concepts can be thought of, but that is left for
  another day. An editing session could show several users, or one. Hide the
  attributes. Use extended creator/assigned-to mappings. Use roles for the
  editing session.


Priority
  A to F, or even Z, the source specification is a bit limited with it priority
  ordering, and kind of reduces it to (A) to (F) or six tags. Or maybe 26...

  I would like a more liberal format. Perhaps to utilize and specify later
  extended functionality. E.g. I want to order order sequences of tasks to do
  next and use some other identifier format for this. It seems like a good
  indicator for organizing things in time between its creation and completion.
  Maybe the field could occur more than once too.

  The Priority field should at the start of the line, and be IdxChars surrounded
  by round brackets. It is not an error to have multiple fields, but only one
  priority can sensible used (in this specification).
  If an app insists is may discard other fields.


.. _Identifier:

Identifier
  See also Symbolize_, Source_, and Reference_.

  Tag-ID
    The characters that make up a **Reference**, or the **Primary ID**
    and **Seconary ID**

    No mention of the Tag-Id separator was yet made. Some markups consider
    space a valid separator with a limited set of tags.

    As a tag used for citation reference ID, even a hypen is not requied.
    Reducing the syntax to something like::

      [A-Z]+[\s-]?[0-9]+

    If these are literal with little ASCII separators. Maybe spaces, things in
    between titles and lables and machine ids.

  Additional or varying identification schemes can be implemented using Metadata.
  In fact, it is tempting to make a bit of overlap with Metadata using
  ``<TAG>:<ID>`` as seperate and additional mode(s) of identification.

  Other concepts play up here too. The backend, or index, registry for the
  actual records or just a counter. Editing sessions. Etc.

  The basis of User_, Source_ and identity of Issue_ should take thinking of
  a workable, highly integrated GTD oriented workflow a bit further.

  TODO: maybe one or several ID separor sorts indicate further modes of use.


.. _Symbolize:

Symbolize
  Make an Tag, ID or reference symbolic, ie. abbreviated or even blank,
  by surrounding it with angle branckets. It works on inline tag-ID.

  Like Reference_, but with other types. Scheme indicates its type.
  Otherwise some order of default routing to a protocol may happen.
  Ie. http(s)://.. might be entered as //.. Mail-to for user. Etc.

  Maybe an app would say that ``<#>`` represents a local ID, or rather the
  primary local task ID. And ``<some-URI>`` says its maybe here or there.
  ``</..>`` or ``<./>`` may indicate local paths that are actual local entities
  represented by the task lines.

  To make lists, for classification or other fields there are better todo.txt
  attributes. But a URI can be used to embed additional attributes.


Description
  In the context of todo.txt, you will want to edit the an enitre line at once.
  But to facilitate integration lets define a boundary for the literal text
  as distinct from other fields of attribute values.

  The description is all of the literal text excluding the attibutes. Ie. the
  task line stripped from:

    - Priority or Orders
    - Creation Date
    - Done
    - Completion Date
    - Contexts
    - Projects
    - Pending
    - Primary ID
    - Seconary IDs, and secondary descriptions[*]_
    - Footnote references

.. [*] See Issue_ spec.


Linked Description
  ..


Sequence
  Unless the processor knows what it is doing or what the user wants, todo.txt
  list files are ordered. And to be kept in order. Including comments; sentinel
  and preprocessor lines.


----

Std. todo.txt fields commonly supported:

Priority
  ..
Created Date
  ..
Done
  ..
Completion Date
  ..
Description
  ..
Context
  ..
Project
  ..
Metadata
  ..
Pending
  The "[WAIT]" suffix. I don't like this very much and would ignore/rewrite it
  to something more aligned with the priorities tag and position.

----

TODO: accumulate seqs, patterns here. adj. syntax file.

DelimChars
  ..
IdChars
  ..
IdxChars
  Express a scalar value of some unit


