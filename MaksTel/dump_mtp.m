function dump_mtp(mtp)
 global outfilename; 
 curt=clock();
 mtpt=[curt(4),curt(5),mtp(1),mtp(2),mtp(3),mtp(4),mtp(5),mtp(6),mtp(7),mtp(8),mtp(9)];
 save('-append',outfilename,'mtpt');
end