#!/usr/bin/perl

# Copyright (C) 2010  PTFS-Europe Ltd.

# This file is part of Koha.

# Koha is program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# Koha is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with Koha; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

use strict;
use warnings;

use CGI;

#use Data::Dumper;
use C4::Auth qw( get_template_and_user);
use C4::Output qw(output_html_with_http_headers);
use C4::AgrovocWSService
  qw( getConceptInfoByTermcode getTermByLanguage getDefinitions);

my $q = CGI->new;

my ( $template, $loggedinuser, $cookie ) = get_template_and_user(
    {   template_name   => 'agrovoc/search.tmpl',
        query           => $q,
        type            => 'intranet',
        authnotrequired => 1,
        flagsrequired   => { catalogue => 1 },
        debug           => 1,
    }
);
my $lang = $q->param('lang');
$lang ||= 'EN';

my $concept = retrieve_concept( $q->param('termcode'), $lang );
my $label    = join ' -- ', @{ $concept->{labels} };
my $show_uf  = @{ $concept->{UF} };
my $show_use = @{ $concept->{USE} };
my $show_bt  = @{ $concept->{BT} };
my $show_nt  = @{ $concept->{NT} };
my $show_rt  = @{ $concept->{RT} };
my $show_def = length $concept->{Definitions};
$template->param(
    display_term_details => 1,
    termcode             => $concept->{termcode},
    labels               => $label,
    UF                   => $concept->{UF},
    USE                  => $concept->{USE},
    BT                   => $concept->{BT},
    NT                   => $concept->{NT},
    RT                   => $concept->{RT},
    DEF                  => $concept->{Definitions},
);

output_html_with_http_headers( $q, $cookie, $template->output );

sub retrieve_concept {
    my $termcode = shift;
    my $language = shift;
    if ( $termcode && $termcode =~ m/(\d+)/ ) {
        $termcode = $1;
    } else {
        return;
    }
    my @concept_array = getConceptInfoByTermcode($termcode);

    #foreach (@concept_array) {
    #    warn("CA:$_");
    #}
    my $concept_hash = {};
    $concept_hash->{termcode} = shift @concept_array;
    $concept_hash->{termcode} =~ s/\D//g;    # remove surrounding [ ]

    my $labels  = shift @concept_array;
    my $arr_ref = [];
    if ( $labels =~ m/\[(.*)\]/ ) {
        $labels = $1;
        my @l_arr = split /,\s*/, $labels;
        while (@l_arr) {
            my $term   = shift @l_arr;
            my $l_lang = shift @l_arr;
            if ( $language eq $l_lang ) {
                push @{$arr_ref}, $term;
            }
        }
    }
    $concept_hash->{labels} = $arr_ref;
    for my $element (@concept_array) {
        my @arr         = _string2array($element);
        my $array_label = shift @arr;
        $concept_hash->{$array_label} = \@arr;
    }
    for my $arr_label (qw( UF USE BT NT RT )) {
        my $tmp_arr = [];   # cannot do this in place as we need to remove terms
                            # which lack a label in the interface language
        foreach ( @{ $concept_hash->{$arr_label} } ) {
            my $tc = $_;
            my $term_label = getTermByLanguage( $tc, $language );
            if ($term_label) {
                push @{$tmp_arr},
                  { termcode => $tc,
                    label    => $term_label,
                    language => $language,
                  };
            }
        }
        $concept_hash->{$arr_label} = $tmp_arr;
    }
    $concept_hash->{Definitions} = getDefinitions( $termcode, $language );
    $concept_hash->{Definitions} =~ s/^\s*//;
    if ( $concept_hash->{Definitions} eq q{[Scope Note:]} ) {
        $concept_hash->{Definitions} = q{};
    }

    return $concept_hash;
}

sub _string2array {
    my $string = shift;
    $string =~ s/^\[//;
    $string =~ s/\]$//;
    return split /,\s*/, $string;
}

sub search_languages {
    my $cgi_query = shift;
    my $lang_hash = {};
    if ( $cgi_query->param('lang_english') ) {
        $template->param( lang_english => 'EN' );
    }
    if ( $cgi_query->param('lang_french') ) {
        $template->param( lang_french => 'FR' );
    }
    if ( $cgi_query->param('lang_spanish') ) {
        $template->param( lang_spanish => 'ES' );
    }
    return;
}
