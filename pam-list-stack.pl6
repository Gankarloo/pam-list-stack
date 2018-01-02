#!/usr/bin/env perl6

sub MAIN ( Str $pamfile, Str $method )
{

    for "/etc/pam.d/$pamfile".IO.lines -> $line {
        if $line ~~ m/ ^\@ / {
            my $include = $line.words[1];
            for "/etc/pam.d/$include".IO.lines -> $line {
                if $line ~~ m/ ^$method / {
                    say $line;
                }
            }
        }
        if $line ~~ m/ ^$method / {
            say $line;
        }
    }
}

sub USAGE(){
    print Q:c:to/EOH/; 
    Usage: {$*PROGRAM-NAME} <pamfile> <method>
     
           <pamfile> is any file in /etc/pam.d directory
           <method> is any of [auth][session][password][account]

    EOH
}
