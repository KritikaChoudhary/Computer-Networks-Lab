BEGIN{
	pkt=0;
}
{
	type=$5;
	event=$1;
	if (type=="cbr")
	{
		if(event=="d")
		pkt++;
	}
}
END{
	print("Packets dropped:%d",pkt);
}

