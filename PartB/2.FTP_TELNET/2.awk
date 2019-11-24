BEGIN{
	tpkt=fpkt=fsize=tsize=0;
}
{
	if($1=="r"&& $5=="tcp")
	{
		if($9=="0.0" && $10 == "3.0")
		{
		tpkt++;
		tsize=$6;
		}
		else if($9=="2.0" && $10 == "3.1")
		{
		fpkt++;
		fsize=$6;
		}
	}
}
END{
	ttotal=tpkt*tsize*8/5;
	ftotal=fpkt*fsize*8/4;
	print("Telnet:",ttotal);
	print("\nFtp:",ftotal);
}
