BEGIN{
	ftpd=ftpr=cbrd=cbrr=0;
}
{
	if($1=="r")
	{
		if($5=="tcp")		
			ftpr++;
		else if($5=="cbr")
			cbrr++;
	}
	else if($1=="d")
	{
		if($5=="tcp")		
			ftpd++;
		else if($5=="cbr")
			cbrd++;
	}
}
END{
	print("CBR Received:%d\nDropped:%d\nFTP Received:%d Dropped:%d",cbrr,cbrd,ftpr,ftpd);

}
