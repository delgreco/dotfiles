" Perl highlighting for SQL in heredocs
" Maintainer:   vim-perl <vim-perl@groups.google.com>
" Installation: Put into after/syntax/perl/heredoc-sql.vim

" XXX include guard

" XXX make the dialect configurable?
runtime! syntax/sql.vim
unlet b:current_syntax
syntax include @SQL syntax/sql.vim

" deprecated in favor of below which supported indented heredocs
" if get(g:, 'perl_fold', 0)
"   syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=SQL\)'+ end='^\z1$' contains=@SQL               fold extend
"   syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=SQL\)"' end='^\z1$' contains=@perlInterpDQ,@SQL fold extend
"   syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=SQL\)'   end='^\z1$' contains=@perlInterpDQ,@SQL fold extend
" else
"   syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=SQL\)'+ end='^\z1$' contains=@SQL
"   syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=SQL\)"' end='^\z1$' contains=@perlInterpDQ,@SQL
"   syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=SQL\)'   end='^\z1$' contains=@perlInterpDQ,@SQL
" endif

" support indented heredocs Perl 5.26 or above, we can change the above 'end' bits to:
" end='^\s*\z1$'
" and add this into the start bits for an optional tilda: \~*
if get(g:, 'perl_fold', 0)
  syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=+<<\~*\s*'\z(\%(END_\)\=SQL\)'+ end='^\s*\z1$' contains=@SQL               fold extend
  syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\~*\s*"\z(\%(END_\)\=SQL\)"' end='^\s*\z1$' contains=@perlInterpDQ,@SQL fold extend
  syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\~*\s*\z(\%(END_\)\=SQL\)'   end='^\s*\z1$' contains=@perlInterpDQ,@SQL fold extend
else
  syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=+<<\~*\s*'\z(\%(END_\)\=SQL\)'+ end='^\s*\z1$' contains=@SQL
  syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\~*\s*"\z(\%(END_\)\=SQL\)"' end='^\s*\z1$' contains=@perlInterpDQ,@SQL
  syntax region perlHereDocSQL matchgroup=perlStringStartEnd start='<<\~*\s*\z(\%(END_\)\=SQL\)'   end='^\s*\z1$' contains=@perlInterpDQ,@SQL
endif
