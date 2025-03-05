#!/usr/bin/perl -w
#----------------------------------------------------------------------
$norefresh=0;
# Change to
# $norefresh=1;
# to enable status caching
#----------------------------------------------------------------------
use LWP::UserAgent;
use HTTP::Status;
#----------------------------------------------------------------------
$version='4.1 (c) DLI 2008';
$type="lpc";
$prompt="UU> ";
$ua = LWP::UserAgent->new();

push @{ $ua->requests_redirectable }, 'POST';
push @{ $ua->requests_redirectable }, 'GET';

#----------------------------------------------------------------------

print STDERR "UserUtil $version\n\n";

if ($#ARGV <= 1)
    {
    print STDERR 'Usage: UU <Host>[:port] <login:password> <[n]{on|off|pulse|status|power|interact}> ...'."\n";
    exit -1;
    }
($epc, $auth)=splice(@ARGV,0,2);
$base='http://'.$auth.'@'.$epc.'/';

foreach (@ARGV)
    {
    $_=lc;
    if ($_ ne 'interact')
	{
	cmd($_) && die "Unknown command $_\n";
	}
    else
	{
	print $prompt;
	while (<STDIN>)
	    {
	    s/\s+//g;
	    if ($_ eq "")
		{;}
	    elsif (($_ eq "?") || ($_ eq "help"))
		{print "Commands: {?|help} | [n]{on|off|pulse|status|power} | quit\n";}
	    elsif ($_ eq "quit")
		{last ;}
	    elsif (0==cmd($_))
	        {print "\t[OK]\n";}
	    else
		{print "\t[ERROR]\n";}
	    print $prompt;
	    }
	print "\n";
	}
    }

sub cmd
{
local ($_) = @_;
$_=lc;
s/(^[^1-8])/a$1/;
if (/^([1-8a])on$/)
    {
    ($type eq 'lpc' ) && RelLink('outlet?'.$1.'=ON') || RelLink('outleton?'.$1);
    }
elsif (/^([1-8a])off$/)
    {
    ($type eq 'lpc' ) && RelLink('outlet?'.$1.'=OFF') || RelLink('outletoff?'.$1);
    }
elsif (/^([1-8a])pulse$/)
    {
    ($type eq 'lpc' ) && RelLink('outlet?'.$1.'=CCL') || RelLink('outletgl?'.$1);
    }
elsif (/^([1-8a])status$/)
    {
    $n=$1;

    $norefresh && defined($response) && ($response->content =~/<td.*?>([1-8])<\/td>.*?<\/td>[^\/]*?\W(ON|OFF)\W/is) || RelLink('');
    $content=$response->content;

    ($type eq 'lpc') && ($content =~ /<a href=outleto/) && ($type='epc');

#newer firmware is easier to parse
    if ($content =~/<!-- state=([[:xdigit:]][[:xdigit:]]) lock=([[:xdigit:]][[:xdigit:]])/)
	{
	$state=hex($1);$lock=hex($2);
	for ($i=1;$i<=8;$i++)
	    {
	    if (($i eq $n) || ($n eq 'a'))
		{
		print $i;
		print (($state & (1 << ($i-1))) ? " ON ":" OFF");
		print (($lock & (1 << ($i-1))) ? " LOCKED\n":"\n");
		}
	    }
	}
    else
	{
	while ($content =~ /<td.*?>([1-8])<\/td>.*?<\/td>[^\/]*?\W(ON|OFF)\W/igs)
	    {
	    if (($1 eq $n) || ($n eq 'a'))
		{
		if ($2 eq "ON")
		    {print $1," ON\n";}
		else
		    {print $1," OFF\n";}
		}
	    }
	}
    }
elsif (/^([1-8a])power$/)
    {
    $n=$1;

    $norefresh && defined($response) && ($response->content =~/<td.*?>([1-8])<\/td>.*?<\/td>[^\/]*?\W(ON|OFF)\W/is) || RelLink('');
    $content=$response->content;

    if ($n =~ /[1-4a]/)
	{
	$content =~ /<!--\s+RAW\s+VA=(\d+)\s+CA=(\d+)\s+VAH=(\S+)\s+CAH=(\S+)\s+-->/igs;
	$vah=((defined $3) && ($3>0)) ? $3.'V' : 'n/a';
	$cah=((defined $4) && ($4>0)) ? $4.'A' : 'n/a';
    	print "Bus A: V=$vah I=$cah\n";
        }
    if ($n =~ /[5-8a]/)
	{
	$content =~ /<!--\s+RAW\s+VB=(\d+)\s+CB=(\d+)\s+VBH=(\S+)\s+CBH=(\S+)\s+-->/igs;
	$vbh=((defined $3) && ($3>0)) ? $3.'V' : 'n/a';
	$cbh=((defined $4) && ($4>0)) ? $4.'A' : 'n/a';
    	print "Bus B: V=$vbh I=$cbh\n";
        }
    }
else
    {
    return(1);
    }
return(0);
}

sub RelLink
{
local ($_) = @_;
my $refresh;

#print STDERR $base.$_,"\n";
$response = $ua->get($base.$_);
if ($response->is_error())
    {
    (($response->code != RC_NOT_FOUND) || ($type eq 'epc')) && die $response->status_line;
    $type='epc';
    return(0);
    }

$refresh=$response->header('refresh');
if ((defined $refresh) && ($refresh=~s/0; URL=\///i))
    {
    $response = $ua->get($base.$refresh);
    }

if ($response->is_error())
    {
    (($response->code != RC_NOT_FOUND) || ($type eq 'epc')) && die $response->status_line;
    $type='epc';
    return(0);
    }

return(1);
}
