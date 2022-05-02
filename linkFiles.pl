#!/usr/bin/perl

use strict;
use warnings;

=head1 install.pl

Install customized working environment to my home directory.

=cut

print STDOUT "Assuring the existence of .vim and subdirectories...\n";
my @vim_dirs = (
    'plugin',
    'templates',
);
foreach my $vim_dir ( @vim_dirs ) {
    print `mkdir -p ~/.vim/$vim_dir`;
}

_linkSyntaxConfig();
_linkConfigFiles();
_linkTemplateFiles();

my $sharedvim = "$ENV{HOME}/.vimrc";
unless ( -l $sharedvim ) {
    print STDOUT "Linking new vim config...\n";
    `ln -s $ENV{HOME}/dotfiles/.vimrc $sharedvim`;
}

my $uservim = ".vimrc.$ENV{USER}";
unless ( -l ".vimrc.$ENV{USER}" ) {
    print STDOUT "Linking user-specific vim config...\n";
    `ln -s $ENV{HOME}/dotfiles/.vimrc.$ENV{USER} $uservim`;
}

my $sqlsyn = "$ENV{HOME}/.vim/after/syntax/perl/heredoc-sql.vim";
unless ( -l $sqlsyn ) {
    print STDOUT "Linking heredoc/sql syntax highlighting...\n";
    `ln -s $ENV{HOME}/dotfiles/heredoc-sql.vim $sqlsyn`;
}

exit;

=head1 INTERNAL SUBS

=head2 _linkConfigFiles()

Link in configuration files for Bash, Bash aliases, Tmux and Ack.

=cut

sub _linkConfigFiles {
    my @files = (
        '.bash_profile',
        '.bash_aliases',
        '.ackrc',
        '.gitconfig',
        '.gnupg',
        '.tmux.conf',
    );
    foreach my $file ( @files ) {
        if ( -e "$ENV{HOME}/$file" && ! -l "$ENV{HOME}/$file" ) {
            print STDOUT "Backing up '$file'...\n";
            `mv $ENV{HOME}/$file $ENV{HOME}/${file}.bk`;
        }
        if ( -l "$ENV{HOME}/$file" ) {
            print STDOUT "$ENV{HOME}/$file: link exists.\n";
            next;
        }
        print STDOUT "Linking '$file'...\n";
        `ln -s $ENV{HOME}/dotfiles/$file ~/$file`;
    }
}

=head2 linkSyntaxConfig()

Assure the presence of certain needed or desirable syntax directories.

=cut

sub _linkSyntaxConfig {
    my @syntaxes = (
        'crontab',
        'diff',
        'html',
        'javascript',
        'perl',
        'sql',
        'svn',
        'template',
        'tmux',
        'vim'
    );
    foreach my $syntax ( @syntaxes ) {
        print `mkdir -p $ENV{HOME}/.vim/after/syntax/$syntax`;
        #my $syn_link = "$ENV{HOME}/.vim/after/syntax/$syntax/colors.vim";
        #`ln -s ~/dotfiles/colors.vim $syn_link` unless -l $syn_link;
    }
}

=head2 _linkTemplateFiles()

Link in template files to provide boilerplate when starting new files with certain extensions.

=cut

sub _linkTemplateFiles {
    my @templates = (
        'skeleton.pl',
        'skeleton.pm',
    );
    foreach my $file ( @templates ) {
        my $filepath = "$ENV{HOME}/.vim/templates/$file";
        if ( -e $filepath && ! -l $filepath ) {
            print STDOUT "Backing up '$filepath'...\n";
            `mv $filepath ${filepath}.bk`;
        }
        if ( -l $filepath ) {
            print STDOUT "$filepath: link exists.\n";
            next;
        }
        print STDOUT "Linking template '$filepath'...\n";
        `ln -s $ENV{HOME}/dotfiles/$file $filepath`;
    }
}


