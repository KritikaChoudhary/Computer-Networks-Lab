set ns [new Simulator]

set tf [open 5.tr w]
$ns trace-all $tf

set nf [open 5.nam w]
$ns namtrace-all $nf

$ns color 1 red
$ns color 2 blue

proc finish {}  {
	global ns nf tf
	$ns flush-trace
	close  $tf
	close $nf
	exec awk -f 5.awk 5.tr &
	exec nam 5.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]

$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns simplex-link $n3 $n2 0.3Mb 100ms DropTail
$ns simplex-link $n2 $n3 0.3Mb 100ms DropTail

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns simplex-link-op $n3 $n2 orient left
$ns simplex-link-op $n2 $n3 orient right

set lan [$ns newLan "$n3 $n4 $n5 $n6 " 0.5Mb 40ms LL Queue/ DropTail MAC/Csma/Cd Channel]

set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp
$tcp set packetsize_ 552
$tcp set fid_ 1

set sink [new Agent/TCPSink/DelAck]
$ns attach-agent $n4 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp set type_ FTP


$ftp attach-agent $tcp

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp
$udp set fid_ 2

set null [new Agent/Null]
$ns attach-agent $n6 $null

$ns connect $udp $null

set cbr [new Application/Traffic/CBR]
$cbr set packetsize_ 1000
$cbr set type_ CBR
$cbr set rate_ 0.05Mb
$cbr set random_ false

$cbr attach-agent $udp 

$n0 color red
$n2 color red

$ns at 0.5 "$ftp start"
$ns at 0.7 "$cbr start"
$ns at 7.0 "$ftp stop"
$ns at 7.2 "$cbr stop"
$ns at 14 "finish"

$ns run 
