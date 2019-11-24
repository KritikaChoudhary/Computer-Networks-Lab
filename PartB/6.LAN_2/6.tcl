set ns [new Simulator]

set tf [open 6.tr w]
$ns trace-all $tf

set nf [open 6.nam w]
$ns namtrace-all $nf

proc finish {}  {
	global ns nf tf
	$ns flush-trace
	close  $tf
	close $nf
	exec awk -f 6.awk 6.tr &
	#exec nam 6.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$ns color 1 red
$ns color 2 blue

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns simplex-link $n3 $n2 0.3Mb 100ms DropTail
$ns simplex-link $n2 $n3 0.3Mb 100ms DropTail

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns simplex-link-op $n3 $n2 orient left
$ns simplex-link-op $n2 $n3 orient right

$ns queue-limit $n2 $n3 20

set lan [$ns newLan "$n3 $n4 $n5" 0.5Mb 40ms LL Queue/ DropTail MAC/802_3 Channel]

set tcp [new Agent/TCP/Newreno]
$tcp set window_ 8000
$tcp set packetsize_ 552
#$tcp set interval_ 0.5
$tcp set fid_ 1
$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink/DelAck]
$ns attach-agent $n4 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp set type_ FTP

$ftp attach-agent $tcp

set udp [new Agent/UDP]
$udp set fid_ 2
$ns attach-agent $n1 $udp

set null [new Agent/Null]
$ns attach-agent $n5 $null

$ns connect $udp $null

set cbr [new Application/Traffic/CBR]
$cbr set packetsize_ 1000
$cbr set type_ CBR
$cbr set rate_ 0.2Mb
$cbr set random_ false

$cbr attach-agent $udp 

set loss [new ErrorModel]
$loss ranvar [new RandomVariable/Uniform]
$loss drop-target [new Agent/Null]
$ns lossmodel $loss $n2 $n3
$loss set rate_ 0.1

$ns at 0.0 "$ftp start"
$ns at 0.5 "$cbr start"
$ns at 1.0 "$ftp stop"
$ns at 1.5 "$cbr stop"
$ns at 2.0 "finish"

$ns run 
