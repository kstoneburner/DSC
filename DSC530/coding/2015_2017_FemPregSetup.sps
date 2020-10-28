*-------------------------------------------------------------------------*
*                                                                          
*            NATIONAL SURVEY OF FAMILY GROWTH (NSFG), 2015-2017
*
*                      SPSS Pregnancy Data Setup File
*
*
*  SPSS setup sections are provided for the ASCII version of this data
*  collection.  These sections are listed below:
*
*  DATA LIST:  assigns the name, type, decimal specification (if any),
*  and specifies the beginning and ending column locations for each
*  variable in the data file. Users must replace the "data-filename"
*  in the DATA LIST statement with a filename specifying the directory
*  on the user's computer system in which the downloaded and unzipped
*  data file is physically located (e.g., "c:\temp\data.dat").
*
*  VARIABLE LABELS:  assigns descriptive labels to all variables.
*  Labels and variable names may be identical for some data files.
*
*  VALUE LABELS: assigns descriptive labels to codes found in the data
*  file.  Not all codes necessarily have assigned value labels.
*
*  CREATING A PERMANENT SPSS DATA FILE: If users wish to create and save
*  an SPSS data file for further analysis using SPSS for Windows, the
*  necessary "SAVE OUTFILE" command is provided in the last line of
*  this file.  To activate the command, users must delete the leading
*  asterisk (*) and replace "spss-filename" with a filename specifying
*  the location on the user's computer system to which the new data file
*  will be saved (e.g., SAVE OUTFILE="c:\spsswin\data\NSFG-datafile.sav").
*
*-------------------------------------------------------------------------.

* SPSS FILE HANDLE AND DATA LIST COMMANDS.

FILE HANDLE DATA / NAME="data-filename" LRECL=375 .
DATA LIST FILE=DATA/
   CASEID 1-5               PREGORDR 6-7             HOWPREG_N 8-9         
   HOWPREG_P 10             MOSCURRP 11              NOWPRGDK 12           
   PREGEND1 13              PREGEND2 14              HOWENDDK 15           
   NBRNALIV 16              MULTBRTH 17              BORNALIV 18           
   DATPRGEN_Y 19-22         AGEATEND 23-24           HPAGEEND 25-26        
   GESTASUN_M 27-28         GESTASUN_W 29-30         WKSGEST 31-32         
   MOSGEST 33-34            DK1GEST 35               DK2GEST 36            
   DK3GEST 37               BABYSEX1 38              BIRTHWGT_LB1 39-40    
   BIRTHWGT_OZ1 41-42       LOBTHWGT1 43             BABYSEX2 44           
   BIRTHWGT_LB2 45-46       BIRTHWGT_OZ2 47-48       LOBTHWGT2 49          
   BABYSEX3 50              BIRTHWGT_LB3 51          BIRTHWGT_OZ3 52-53    
   LOBTHWGT3 54             BABYDOB_Y 55-58          KIDAGE 59             
   HPAGELB 60-61            BIRTHPLC 62              PAYBIRTH1 63          
   PAYBIRTH2 64             PAYBIRTH3 65             CSECPRIM 66           
   CSECMED1 67              CSECMED2 68              CSECMED3 69           
   CSECMED4 70              CSECMED5 71              CSECMED6 72           
   CSECPLAN 73              KNEWPREG 74-75           TRIMESTR 76           
   LTRIMEST 77              PRIORSMK 78              POSTSMKS 79           
   NPOSTSMK 80              GETPRENA 81              BGNPRENA 82-83        
   PNCTRIM 84               LPNCTRI 85               LIVEHERE1 86          
   ALIVENOW1 87             WHENDIED_Y1 88-91        WHENLEFT_Y1 92-95     
   LASTAGE1 96-98           WHERENOW1 99             LEGAGREE1 100         
   PARENEND1 101            ANYNURSE1 102            FEDSOLID1 103         
   FRSTEATD_N1 104-106      FRSTEATD_P1 107          FRSTEATD1 108-109     
   QUITNURS1 110            AGEQTNUR_N1 111-113      AGEQTNUR_P1 114       
   AGEQTNUR1 115-116        LIVEHERE2 117            ALIVENOW2 118         
   WHENDIED_Y2 119-122      WHENLEFT_Y2 123-126      LASTAGE2 127-129      
   WHERENOW2 130            LEGAGREE2 131            PARENEND2 132         
   ANYNURSE2 133            FEDSOLID2 134            FRSTEATD_N2 135-136   
   FRSTEATD_P2 137          FRSTEATD2 138-139        QUITNURS2 140         
   AGEQTNUR_N2 141-142      AGEQTNUR_P2 143          AGEQTNUR2 144-145     
   LIVEHERE3 146            ALIVENOW3 147            WHENDIED_Y3 148       
   WHENLEFT_Y3 149          LASTAGE3 150             WHERENOW3 151         
   LEGAGREE3 152            PARENEND3 153            ANYNURSE3 154         
   FEDSOLID3 155            FRSTEATD_N3 156          FRSTEATD_P3 157       
   FRSTEATD3 158            QUITNURS3 159            AGEQTNUR_N3 160       
   AGEQTNUR_P3 161          AGEQTNUR3 162            PRGOUTCOME 163        
   OUTCOM_S 164             NBRNLV_S 165             ANYUSINT 166          
   EVUSEINT 167             STOPDUSE 168             WHYSTOPD 169          
   WHATMETH01 170-171       WHATMETH02 172-173       WHATMETH03 174-175    
   WHATMETH04 176-177       RESNOUSE 178             WANTBOLD 179          
   PROBBABE 180             CNFRMNO 181              WANTBLD2 182          
   TIMINGOK 183             TOOSOON_N 184-186        TOOSOON_P 187         
   WTHPART1 188             WTHPART2 189             FEELINPG 190-191      
   HPWNOLD 192              TIMOKHP 193              COHPBEG 194           
   COHPEND 195              TELLFATH 196             WHENTELL 197          
   TRYSCALE 198-199         WANTSCAL 200-201         WHYPRG1 202           
   WHYPRG2 203              WHYNOUSE1 204-205        WHYNOUSE2 206         
   WHYNOUSE3 207            WHYNOUSE4 208            WHYNOUSE5 209         
   WHYNOPG1 210-211         WHYNOPG2 212-213         MAINOUSE 214          
   PRGLNGTH 215-216         OUTCOME 217              BIRTHORD 218-219      
   DATEND 220-223           AGEPREG 224-225          DATECON 226-229       
   AGECON 230-231           FMAROUT5 232             PMARPREG 233          
   RMAROUT6 234             FMARCON5 235             RMARCON6 236          
   LEARNPRG 237-238         PNCAREWK 239-240         PAYDELIV 241          
   LBW1 242                 LIVCHILD 243             BFEEDWKS 244-246      
   OLDWANTR 247             OLDWANTP 248             WANTRESP 249          
   WANTPART 250             TOOSOON 251-253          NEWWANTR 254          
   AGER 255-256             AGESCRN 257-258          FMARITAL 259          
   RMARITAL 260             EDUCAT 261-262           HIEDUC 263-264        
   RACE 265                 HISPANIC 266             HISPRACE 267          
   HISPRACE2 268            RCURPREG 269             PREGNUM 270-271       
   PARITY 272-273           CURR_INS 274             PUBASSIS 275          
   POVERTY 276-278          LABORFOR 279             RELIGION 280          
   METRO 281                BRNOUT 282               YRSTRUS 283-286       
   PRGLNGTH_I 287           OUTCOME_I 288            BIRTHORD_I 289        
   DATEND_I 290             AGEPREG_I 291            DATECON_I 292         
   AGECON_I 293             FMAROUT5_I 294           PMARPREG_I 295        
   RMAROUT6_I 296           FMARCON5_I 297           RMARCON6_I 298        
   LEARNPRG_I 299           PNCAREWK_I 300           PAYDELIV_I 301        
   LBW1_I 302               LIVCHILD_I 303           BFEEDWKS_I 304        
   OLDWANTR_I 305           OLDWANTP_I 306           WANTRESP_I 307        
   WANTPART_I 308           TOOSOON_I 309            NEWWANTR_I 310        
   AGER_I 311               FMARITAL_I 312           RMARITAL_I 313        
   EDUCAT_I 314             HIEDUC_I 315             RACE_I 316            
   HISPANIC_I 317           HISPRACE_I 318           HISPRACE2_I 319       
   RCURPREG_I 320           PREGNUM_I 321            PARITY_I 322          
   CURR_INS_I 323           PUBASSIS_I 324           POVERTY_I 325         
   LABORFOR_I 326           RELIGION_I 327           METRO_I 328           
   WGT2015_2017 329-344     SECU 345                 SEST 346-348          
   CMINTVW 349-352          CMLSTYR 353-356          CMJAN3YR 357-360      
   CMJAN4YR 361-364         CMJAN5YR 365-368         QUARTER 369-370 (A)   
   PHASE 371 (A)            INTVWYEAR 372-375 (A) .

* SPSS FORMATS COMMAND.

FORMATS
  WGT2015_2017 (F17.11) / .

* SPSS VARIABLE LABELS COMMAND.

VARIABLE LABELS
   CASEID 'Case identification number'
   PREGORDR 'Pregnancy order (number)'
   HOWPREG_N 'BB-2 # of Weeks or Months Currently Pregnant'
   HOWPREG_P 'BB-2 Current pregnancy length reported in months or weeks'
   MOSCURRP 'Number of Months Currently Pregnant'
   NOWPRGDK 'BB-3 Which Trimester -- Current Pregnancy'
   PREGEND1 'BC-1 How Pregnancy Ended - 1st mention'
   PREGEND2 'BC-1 How Pregnancy Ended - 2nd mention'
   HOWENDDK    'BC-1b Did pregnancy result in a baby/babies born alive or did it ' +
   'end in some other way?'
   NBRNALIV 'BC-2 Number of babies born alive from this pregnancy'
   MULTBRTH 'BC-3 Was this a multiple birth'
   BORNALIV 'Number of babies born alive from this pregnancy'
   DATPRGEN_Y 'BC-4a Year when pregnancy ended (if nonlivebirth)'
   AGEATEND "BC-4b R's age at pregnancy's end date"
   HPAGEEND "BC-4c Father's age (categorical) at pregnancy's end date"
   GESTASUN_M 'BC-5 Gestational Length of Pregnancy in Months'
   GESTASUN_W 'BC-5 Gestational Length of Pregnancy in Weeks'
   WKSGEST 'Gestational length of completed pregnancy (in weeks)'
   MOSGEST 'Gestational length of completed pregnancy (in months)'
   DK1GEST 'BC-6 DK followup for gestational length of a stillbirth'
   DK2GEST 'BC-7 DK followup for gestational length of a livebirth'
   DK3GEST 'BC-8 DK followup for gestational length of a miscarr/abor/ectop'
   BABYSEX1 'BD-2 Sex of 1st Liveborn Baby from This Pregnancy'
   BIRTHWGT_LB1 'BD-3 Birthweight in Pounds - 1st baby from this pregnancy'
   BIRTHWGT_OZ1 'BD-3 Birthweight in Ounces - 1st baby from this pregnancy'
   LOBTHWGT1 'BD-4 Is Baby Low Birthweight- 1st baby from this pregnancy'
   BABYSEX2 'BD-2 Sex of 2nd Liveborn Baby from This Pregnancy'
   BIRTHWGT_LB2 'BD-3 Birthweight in Pounds - 2nd baby from this pregnancy'
   BIRTHWGT_OZ2 'BD-3 Birthweight in Ounces - 2nd baby from this pregnancy'
   LOBTHWGT2 'BD-4 Is Baby Low Birthweight- 2nd baby from this pregnancy'
   BABYSEX3 'BD-2 Sex of 3rd Liveborn Baby from This Pregnancy'
   BIRTHWGT_LB3 'BD-3 Birthweight in Pounds - 3rd baby from this pregnancy'
   BIRTHWGT_OZ3 'BD-3 Birthweight in Ounces - 3rd baby from this pregnancy'
   LOBTHWGT3 'BD-4 Is Baby Low Birthweight- 3rd baby from this pregnancy'
   BABYDOB_Y 'BD-5 Year of delivery for this pregnancy'
   KIDAGE 'Current age (in years) of child(ren) from this pregnancy'
   HPAGELB "BD-6 Father's age (categorical) at time of child(ren) s birth"
   BIRTHPLC 'BD-7 Place where R gave birth'
   PAYBIRTH1 'BD-8 Payment for delivery - 1st mention'
   PAYBIRTH2 'BD-8 Payment for delivery - 2nd mention'
   PAYBIRTH3 'BD-8 Payment for delivery - 3rd mention'
   CSECPRIM "BD-9 Is this R's first c-section?"
   CSECMED1 'BD-10 Medical reasons reported for this C-section - 1st mention'
   CSECMED2 'BD-10 Medical reasons reported for this C-section - 2nd mention'
   CSECMED3 'BD-10 Medical reasons reported for this C-section - 3rd mention'
   CSECMED4 'BD-10 Medical reasons reported for this C-section - 4th mention'
   CSECMED5 'BD-10 Medical reasons reported for this C-section - 5th mention'
   CSECMED6 'BD-10 Medical reasons reported for this C-section - 6th mention'
   CSECPLAN 'BD-11 Was this c-section planned for by R?'
   KNEWPREG 'BE-1 Weeks pregnant when R learned she was pregnant'
   TRIMESTR 'BE-2a DK followup for KNEWPREG when gestation >= 6 mos'
   LTRIMEST 'BE-2b DK followup for KNEWPREG when gestation < 6 mos'
   PRIORSMK 'BE-3 Amount R smoked in 6 mos before R knew she was pregnant'
   POSTSMKS 'BE-4 R smoked at all after R knew she was pregnant'
   NPOSTSMK 'BE-5 Amount R smoked during pregnancy after R knew she was preg'
   GETPRENA 'BE-6 Any prenatal care for this pregnancy'
   BGNPRENA 'BE-7 Weeks pregnant at first prenatal care visit'
   PNCTRIM 'BE-8a DK followup for BGNPRENA when gestation >= 6 mos'
   LPNCTRI 'BE-8b DK followup for BGNPRENA when gestation < 6 mos'
   LIVEHERE1 'BG-1 Whether child lives with R - 1st from this pregnancy'
   ALIVENOW1 'BG-2 Whether child is still alive - 1st from this pregnancy'
   WHENDIED_Y1 'BG-3 Year when child died - 1st from this pregnancy'
   WHENLEFT_Y1 'BG-4 Year when child stopped living with R- 1st from this preg'
   LASTAGE1 'Age (in mos) when child last lived w/R-1st from this pregnancy'
   WHERENOW1 'BG-5 Where child lives now - 1st from this pregnancy'
   LEGAGREE1 'BG-6 Legal agreement for where child lives - 1st from this preg'
   PARENEND1 'BG-7 Is R still legal mother of child - 1st from this pregnancy'
   ANYNURSE1 'BH-1 Whether R breastfed this child at all - 1st from this preg'
   FEDSOLID1    'BH-2 Has R fed this child anything other than breastmilk - 1st fr' +
   'om this preg'
   FRSTEATD_N1    'BH-3 Age (mos/wks/day) when 1st fed non-breastmilk - 1st from thi' +
   's preg'
   FRSTEATD_P1 'BH-3 Units (mos/wks/days) for FRSTEATD_N - 1st from this preg'
   FRSTEATD1 'Age (in mos) when 1st fed non-breastmilk - 1st from this preg'
   QUITNURS1 'BH-4 Has R stopped breastfeeding child - 1st from this preg'
   AGEQTNUR_N1    'BH-5 Age (mos/wks/day) when stopped breastfeeding - 1st from this' +
   ' preg'
   AGEQTNUR_P1 'BH-5 Units (mos/wks/days) for AGEQTNUR_N - 1st from this preg'
   AGEQTNUR1 'Age (in mos) when R stopped nursing child - 1st from this preg'
   LIVEHERE2 'BG-1 Whether child lives with R - 2nd from this pregnancy'
   ALIVENOW2 'BG-2 Whether child is still alive - 2nd from this pregnancy'
   WHENDIED_Y2 'BG-3 Year when child died - 2nd from this pregnancy'
   WHENLEFT_Y2 'BG-4 Year when child stopped living with R - 2nd from this preg'
   LASTAGE2 'Age (in mos) when child last lived w/R - 2nd from this pregnancy'
   WHERENOW2 'BG-5 Where child lives now - 2nd from this pregnancy'
   LEGAGREE2 'BG-6 Legal agreement for where child lives - 2nd from this preg'
   PARENEND2 'BG-7 Is R still legal mother of child - 2nd from this pregnancy'
   ANYNURSE2 'BH-1 Whether R breastfed this child at all - 2nd from this preg'
   FEDSOLID2    'BH-2 Has R fed this child anything other than breastmilk - 2nd fr' +
   'om this preg'
   FRSTEATD_N2    'BH-3 Age (mos/wks/day) when 1st fed non-breastmilk - 2nd from thi' +
   's preg'
   FRSTEATD_P2 'BH-3 Units (mos/wks/days) for FRSTEATD_N - 2nd from this preg'
   FRSTEATD2 'Age (in mos) when 1st fed non-breastmilk - 2nd from this preg'
   QUITNURS2 'BH-4 Has R stopped breastfeeding child - 2nd from this preg'
   AGEQTNUR_N2    'BH-5 Age (mos/wks/day) when stopped breastfeeding - 2nd from this' +
   ' preg'
   AGEQTNUR_P2 'BH-5 Units (mos/wks/days) for AGEQTNUR_N - 2nd from this preg'
   AGEQTNUR2 'Age (in mos) when R stopped nursing child - 2nd from this preg'
   LIVEHERE3 'BG-1 Whether child lives with R - 3rd from this pregnancy'
   ALIVENOW3 'BG-2 Whether child is still alive - 3rd from this pregnancy'
   WHENDIED_Y3 'BG-3 Year when child died - 3rd from this pregnancy'
   WHENLEFT_Y3 'BG-4 Year when child stopped living with R - 3rd from this preg'
   LASTAGE3 'Age (in mos) when child last lived w/R - 3rd from this pregnancy'
   WHERENOW3 'BG-5 Where child lives now - 3rd from this pregnancy'
   LEGAGREE3 'BG-6 Legal agreement for where child lives - 3rd from this preg'
   PARENEND3 'BG-7 Is R still legal mother of child - 3rd from this pregnancy'
   ANYNURSE3 'BH-1 Whether R breastfed this child at all - 3rd from this preg'
   FEDSOLID3    'BH-2 Has R fed this child anything other than breastmilk - 3rd fr' +
   'om this preg'
   FRSTEATD_N3    'BH-3 Age (mos/wks/day) when 1st fed non-breastmilk - 3rd from thi' +
   's preg'
   FRSTEATD_P3 'BH-3 Units (mos/wks/days) for FRSTEATD_N - 3rd from this preg'
   FRSTEATD3 'Age (in mos) when 1st fed non-breastmilk - 3rd from this preg'
   QUITNURS3 'BH-4 Has R stopped breastfeeding child - 3rd from this preg'
   AGEQTNUR_N3    'BH-5 Age (mos/wks/day) when stopped breastfeeding - 3rd from this' +
   ' preg'
   AGEQTNUR_P3 'BH-5 Units (mos/wks/days) for AGEQTNUR_N - 3rd from this preg'
   AGEQTNUR3 'Age (in mos) when R stopped nursing child - 3rd from this preg'
   PRGOUTCOME 'Outcome of Pregnancy (based on priority ordering)'
   OUTCOM_S 'Outcome of pregnancy (based on corrected/chron sorted data)'
   NBRNLV_S '# of babies born alive from this preg (based on CCSD)'
   ANYUSINT 'Any method use in pregnancy interval'
   EVUSEINT 'EG-1 Use any method in pregnancy interval?'
   STOPDUSE 'EG-2 Before you became preg, stop using all methods?'
   WHYSTOPD 'EG-3 Stop using methods before preg because wanted preg?'
   WHATMETH01 'EG-4 Method(s) using when became preg - 1st mention'
   WHATMETH02 'EG-4 Method(s) using when became preg - 2nd mention'
   WHATMETH03 'EG-4 Method(s) using when became preg - 3rd mention'
   WHATMETH04 'EG-4 Method(s) using when became preg - 4th mention'
   RESNOUSE 'EG-5 Reason not using/had stopped using method bec. wanted preg?'
   WANTBOLD 'EG-6 Right bef preg, want to have baby at any time in future?'
   PROBBABE 'EG-7 probably want baby at any time in future or not?'
   CNFRMNO "EG-8 Verify didn't want baby at any time in future"
   WANTBLD2    'EG-9 Right before preg, want to have baby at any time in future? ' +
   '(2nd asking)'
   TIMINGOK    'EG-10 Become preg too soon, right time, or later than you wanted?'
   TOOSOON_N 'EG-11 How much sooner than wanted became preg (months or years)'
   TOOSOON_P    'EG-11 Choose mons or yrs for how much sooner became preg than wan' +
   'ted'
   WTHPART1 'EG-12a Right before preg, want to have baby with that partner?'
   WTHPART2    'EG-12b Right bef. preg, think might ever want to have baby w/that' +
   ' partner?'
   FEELINPG 'EG-13 How happy to be preg. scale (0-10)'
   HPWNOLD    'EG-16 Right bef preg, did the father want R to have baby at any t' +
   'ime in future?'
   TIMOKHP    'EG-17 R became preg sooner, right time, or later than father of p' +
   'reg wanted'
   COHPBEG 'EG-18a Was R living w/father of preg at beginning of preg'
   COHPEND    'EG-18b Was R living w/father of preg when preg ended/baby was bor' +
   'n'
   TELLFATH 'EG-19 Did R tell father of preg that she was pregnant'
   WHENTELL    'EG-20 When did R tell father of preg about pregnancy: during or a' +
   'fter?'
   TRYSCALE 'EG-21 How hard trying to get/avoid pregnancy (0-10 scale)'
   WANTSCAL 'EG-22 How much wanted to get/avoid pregnancy (0-10 scale)'
   WHYPRG1    "EG-23 (unintended preg): method fail or R wasn't using properly-1" +
   "st mention"
   WHYPRG2    "EG-23 (unintended preg): method fail or R wasn't using properly-2" +
   "nd mention"
   WHYNOUSE1 "EG-24 (unintended preg) Reason didn't use contraceptn - 1st"
   WHYNOUSE2 "EG-24 (unintended preg) Reason didn't use contraceptn - 2nd"
   WHYNOUSE3 "EG-24 (unintended preg) Reason didn't use contraceptn - 3rd"
   WHYNOUSE4 "EG-24 (unintended preg) Reason didn't use contraceptn - 4th"
   WHYNOUSE5 "EG-24 (unintended preg) Reason didn't use contraceptn - 5th"
   WHYNOPG1    "EG-24aa open-ended response: reason didn't think could get preg -" +
   " 1st"
   WHYNOPG2    "EG-24aa open-ended response: reason didn't think could get preg -" +
   " 2nd"
   MAINOUSE "EG-24a (unintended preg) Main reason didn't use contraception"
   PRGLNGTH 'Duration of completed pregnancy in weeks'
   OUTCOME 'Pregnancy outcome'
   BIRTHORD 'Birth order'
   DATEND 'Year pregnancy ended'
   AGEPREG 'Age at pregnancy outcome'
   DATECON 'Year pregnancy began'
   AGECON 'Age at time of conception'
   FMAROUT5 'Formal marital status at pregnancy outcome'
   PMARPREG "Whether pregnancy ended before R's 1st marriage (premaritally)"
   RMAROUT6 'Informal marital status at pregnancy outcome - 6 categories'
   FMARCON5 'Formal marital status at conception - 5 categories'
   RMARCON6 'Informal marital status at conception - 6 categories'
   LEARNPRG 'Number of weeks pregnant when R learned she was pregnant'
   PNCAREWK 'Number of weeks pregnant at first prenatal care'
   PAYDELIV 'Payment for delivery'
   LBW1 'Low birthweight - 1st baby from this preg'
   LIVCHILD 'Living arrangements for 1st liveborn child from this pregnancy'
   BFEEDWKS 'Duration of breastfeeding in weeks'
   OLDWANTR 'Wantedness of pregnancy - respondent - Cycle 4 version'
   OLDWANTP    "Wantedness of preg - R's partner (father of pregnancy) - Cycle 4 " +
   "version"
   WANTRESP 'Wantedness of pregnancy -- Respondent (RECODE)'
   WANTPART "Wantedness of pregnancy -- R's partner (RECODE)"
   TOOSOON 'Number of months too soon pregnancy occurred'
   NEWWANTR 'Detailed wantedness of pregnancy - respondent'
   AGER 'Age at interview'
   AGESCRN "R's age at screener"
   FMARITAL 'Formal marital status'
   RMARITAL 'Informal Marital Status'
   EDUCAT 'Education (completed years of schooling)'
   HIEDUC 'Highest completed year of school or degree'
   RACE 'Race'
   HISPANIC 'Hispanic origin'
   HISPRACE    'Race & Hispanic origin of respondent - 1977 OMB standards (respon' +
   'dent recode)'
   HISPRACE2    'Race & Hispanic origin of respondent - 1997 OMB standards (respon' +
   'dent recode)'
   RCURPREG 'Pregnant at time of interview'
   PREGNUM 'CAPI-based total number of pregnancies'
   PARITY 'Total number of live births'
   CURR_INS 'Current health insurance coverage'
   PUBASSIS 'Whether R received public assistance in prior calendar year'
   POVERTY 'Poverty level income'
   LABORFOR 'Labor force status'
   RELIGION 'Current religious affiliation'
   METRO 'Place of residence (Metropolitan / Nonmetropolitan)'
   BRNOUT 'IB-8 R born outside of US'
   YRSTRUS 'Year R came to the United States'
   PRGLNGTH_I 'PRGLNGTH Imputation Flag'
   OUTCOME_I 'OUTCOME Imputation Flag'
   BIRTHORD_I 'BIRTHORD Imputation Flag'
   DATEND_I 'DATEND Imputation Flag'
   AGEPREG_I 'AGEPREG Imputation Flag'
   DATECON_I 'DATECON Imputation Flag'
   AGECON_I 'AGECON Imputation Flag'
   FMAROUT5_I 'FMAROUT5 Imputation Flag'
   PMARPREG_I 'PMARPREG Imputation Flag'
   RMAROUT6_I 'RMAROUT6 Imputation Flag'
   FMARCON5_I 'FMARCON5 Imputation Flag'
   RMARCON6_I 'RMARCON6 Imputation Flag'
   LEARNPRG_I 'LEARNPRG Imputation Flag'
   PNCAREWK_I 'PNCAREWK Imputation Flag'
   PAYDELIV_I 'PAYDELIV Imputation Flag'
   LBW1_I 'LBW1 Imputation Flag'
   LIVCHILD_I 'LIVCHILD Imputation Flag'
   BFEEDWKS_I 'BFEEDWKS Imputation Flag'
   OLDWANTR_I 'OLDWANTR Imputation Flag'
   OLDWANTP_I 'OLDWANTP Imputation Flag'
   WANTRESP_I 'WANTRESP Imputation Flag'
   WANTPART_I 'WANTPART Imputation Flag'
   TOOSOON_I 'TOOSOON Imputation Flag'
   NEWWANTR_I 'NEWWANTR Imputation Flag'
   AGER_I 'AGER Imputation Flag'
   FMARITAL_I 'FMARITAL Imputation Flag'
   RMARITAL_I 'RMARITAL Imputation Flag'
   EDUCAT_I 'EDUCAT Imputation Flag'
   HIEDUC_I 'HIEDUC Imputation Flag'
   RACE_I 'RACE Imputation Flag'
   HISPANIC_I 'HISPANIC Imputation Flag'
   HISPRACE_I 'HISPRACE Imputation Flag'
   HISPRACE2_I 'HISPRACE2 Imputation Flag'
   RCURPREG_I 'RCURPREG Imputation Flag'
   PREGNUM_I 'PREGNUM Imputation Flag'
   PARITY_I 'PARITY Imputation Flag'
   CURR_INS_I 'CURR_INS Imputation Flag'
   PUBASSIS_I 'PUBASSIS Imputation Flag'
   POVERTY_I 'POVERTY Imputation Flag'
   LABORFOR_I 'LABORFOR Imputation Flag'
   RELIGION_I 'RELIGION Imputation Flag'
   METRO_I 'METRO Imputation Flag'
   WGT2015_2017 'Final weight for the 2015-2017 NSFG'
   SECU 'Randomized version of the sampling error computational unit'
   SEST 'Randomized version of the stratum'
   CMINTVW    'Century month for date of interview  (Computed in Flow Check A-1)'
   CMLSTYR    'Century month for month/year of interview minus one year (Compute' +
   'd in Flow Check A-1)'
   CMJAN3YR    'Century month of January Three Years Prior to Year of interview (' +
   'Computed in Flow Check A-1)'
   CMJAN4YR    'Century month of January Four Years Prior to Year of Interview (C' +
   'omputed in Flow Check A-1)'
   CMJAN5YR    'Century month of January Five Years Prior to Year of Interview (C' +
   'omputed in Flow Check A-1)'
   QUARTER 'Quarter when case was sampled'
   PHASE 'Regular- or double-sample portion of the quarter'
   INTVWYEAR 'Calendar year when interview occurred' .


* SPSS VALUE LABELS COMMAND.

VALUE LABELS
 PREGORDR
     1 '1ST PREGNANCY'
     2 '2ND PREGNANCY'
     3 '3RD PREGNANCY'
     4 '4TH PREGNANCY'
     5 '5TH PREGNANCY'
     6 '6TH PREGNANCY'
     7 '7TH PREGNANCY'
     8 '8TH PREGNANCY'
     9 '9TH PREGNANCY'
     10 '10TH PREGNANCY'
     11 '11TH PREGNANCY'
     12 '12TH PREGNANCY'
     13 '13TH PREGNANCY'
     14 '14TH PREGNANCY'
     15 '15TH PREGNANCY'
     16 '16TH PREGNANCY'
     17 '17TH PREGNANCY'
     18 '18TH PREGNANCY'
     19 '19TH PREGNANCY'
     20 '20TH PREGNANCY' /
 HOWPREG_N
     98 'Refused'
     99 "Don't know" /
 HOWPREG_P
     1 'Weeks'
     2 'Months'
     8 'Refused'
     9 "Don't know" /
 MOSCURRP
     98 'Refused'
     99 "Don't know" /
 NOWPRGDK
     1 'First trimester'
     2 'Second trimester'
     3 'Third trimester'
     8 'Refused'
     9 "Don't know" /
 PREGEND1 PREGEND2
     1 'Miscarriage'
     2 'Stillbirth'
     3 'Abortion'
     4 'Ectopic or tubal pregnancy'
     5 'Live birth by Cesarean section'
     6 'Live birth by vaginal delivery'
     8 'Refused'
     9 "Don't know" /
 HOWENDDK
     1 'Live birth'
     5 'Some other way'
     8 'Refused'
     9 "Don't know" /
 NBRNALIV BORNALIV
     1 '1 BABY'
     2 '2 BABIES'
     3 '3 OR MORE BABIES'
     8 'Refused'
     9 "Don't know" /
 MULTBRTH DK2GEST CSECPRIM CSECPLAN POSTSMKS GETPRENA LIVEHERE1 ALIVENOW1 
 LEGAGREE1 PARENEND1 ANYNURSE1 FEDSOLID1 QUITNURS1 LIVEHERE2 ALIVENOW2 
 LEGAGREE2 PARENEND2 ANYNURSE2 FEDSOLID2 QUITNURS2 LIVEHERE3 ALIVENOW3 
 LEGAGREE3 PARENEND3 ANYNURSE3 FEDSOLID3 QUITNURS3 EVUSEINT STOPDUSE 
 WHYSTOPD RESNOUSE COHPBEG COHPEND TELLFATH BRNOUT
     1 'Yes'
     5 'No'
     8 'Refused'
     9 "Don't know" /
 DATPRGEN_Y BABYDOB_Y WHENDIED_Y1 WHENLEFT_Y1 WHENDIED_Y2 WHENLEFT_Y2 
 WHENDIED_Y3 WHENLEFT_Y3 DATEND DATECON YRSTRUS
     9997 'Not ascertained'
     9998 'Refused'
     9999 "Don't know" /
 AGEATEND
     98 'Refused'
     99 "Don't know" /
 HPAGEEND HPAGELB
     1 'Under 20 years'
     2 '20-24 years'
     3 '25-29 years'
     4 '30-34 years'
     5 '35-39 years'
     6 '40 years or older'
     98 'Refused'
     99 "Don't know" /
 GESTASUN_M MOSGEST
     98 'Refused'
     99 "Don't know" /
 GESTASUN_W
     98 'Refused'
     99 "Don't know" /
 WKSGEST
     98 'Refused'
     99 "Don't know" /
 DK1GEST
     1 'Less than 6 months'
     2 '6 months or more'
     8 'Refused'
     9 "Don't know" /
 DK3GEST
     1 'Less than 3 months'
     2 '3 months or more, but less than 6 months'
     3 '6 months or more'
     8 'Refused'
     9 "Don't know" /
 BABYSEX1 BABYSEX2 BABYSEX3
     1 'Male'
     2 'Female'
     8 'Refused'
     9 "Don't know" /
 BIRTHWGT_LB1 BIRTHWGT_LB2 BIRTHWGT_LB3
     6 '6 POUNDS'
     7 '7 POUNDS'
     8 '8 POUNDS'
     98 'Refused'
     99 "Don't know" /
 BIRTHWGT_OZ1 BIRTHWGT_OZ2 BIRTHWGT_OZ3
     98 'Refused'
     99 "Don't know" /
 LOBTHWGT1 LOBTHWGT2 LOBTHWGT3
     1 '5 1/2 pounds or more'
     2 'Less than 5 1/2 pounds'
     8 'Refused'
     9 "Don't know" /
 KIDAGE
     0 'Less than 1 year'
     1 '1 year old'
     2 '2 years old'
     3 '3 years old'
     4 '4 years old'
     5 '5 years old'
     6 '6-11 years old'
     7 '12-17 years old'
     8 '18 years or older' /
 BIRTHPLC
     1 'In a hospital'
     2 'In a birthing center'
     3 'In your home'
     4 'Some other place'
     8 'Refused'
     9 "Don't know" /
 PAYBIRTH1 PAYBIRTH2 PAYBIRTH3
     1 'Insurance'
     2 'Co-payment or out-of-pocket payment'
     3 'Medicaid'
     4 'No payment required'
     5 'Some other way'
     8 'Refused'
     9 "Don't know" /
 CSECMED1 CSECMED2 CSECMED3 CSECMED4 CSECMED5 CSECMED6
     1 'Labor was taking too long'
     2 'Maternity care provider concerned that baby was too big'
     3 'Baby was in the wrong position (e.g, breech)'
     4 'Maternity care provider concerned about your health'
     5 "Maternity care provider concerned about your baby's health"
     6 'Some other medical reason'
     7 'There was no medical reason'
     8 'Refused'
     9 "Don't know" /
 KNEWPREG BGNPRENA
     98 'Refused'
     99 "Don't know" /
 TRIMESTR PNCTRIM
     1 'Less than 3 months,'
     2 'At least 3 months , but less than 6 months'
     3 '6 or more months'
     8 'Refused'
     9 "Don't know" /
 LTRIMEST LPNCTRI
     1 'Less than 3 months'
     2 '3 or more months'
     8 'Refused'
     9 "Don't know" /
 PRIORSMK
     0 'None'
     1 'About one cigarette a day or less'
     2 'Just a few cigarettes a day (2-4)'
     3 'About half a pack a day (5-14)'
     4 'About a pack a day (15-24)'
     5 'About 1 1/2 packs a day (25-34)'
     6 'About 2 packs a day (35-44)'
     7 'More than 2 packs a day (45 or more)'
     8 'Refused'
     9 "Don't know" /
 NPOSTSMK
     1 'About one cigarette a day or less'
     2 'Just a few cigarettes a day (2-4)'
     3 'About half a pack a day (5-14)'
     4 'About a pack a day (15-24)'
     5 'About 1 1/2 packs a day (25-34)'
     6 'About 2 packs a day (35-44)'
     7 'More than 2 packs a day (45 or more)'
     8 'Refused'
     9 "Don't know" /
 LASTAGE1 LASTAGE2 LASTAGE3
     996 'Still breastfeeding this child'
     997 'Not ascertained'
     998 'Refused'
     999 "Don't know" /
 WHERENOW1 WHERENOW2 WHERENOW3
     1 'With biological father'
     2 'With other relatives'
     3 'With adoptive family'
     4 'Away at school/college'
     5 'Living on own'
     6 'Other'
     8 'Refused'
     9 "Don't know" /
 FRSTEATD_N1 FRSTEATD_N2 FRSTEATD_N3
     998 'Refused'
     999 "Don't know" /
 FRSTEATD_P1 FRSTEATD_P2 FRSTEATD_P3
     1 'Months'
     2 'Weeks'
     3 'Days'
     8 'Refused'
     9 "Don't know" /
 FRSTEATD1 FRSTEATD2 FRSTEATD3
     0 'LESS THAN 1 MONTH'
     1 '1 MONTH'
     2 '2 MONTHS'
     3 '3 MONTHS'
     4 '4 MONTHS'
     5 '5 MONTHS'
     6 '6 MONTHS'
     98 'Refused'
     99 "Don't know" /
 AGEQTNUR_N1 AGEQTNUR_N2 AGEQTNUR_N3
     996 'Still breastfeeding this child'
     998 'Refused'
     999 "Don't know" /
 AGEQTNUR_P1 AGEQTNUR_P2 AGEQTNUR_P3
     1 'Months'
     2 'Weeks'
     3 'Days'
     8 'Refused'
     9 "Don't know" /
 AGEQTNUR1 AGEQTNUR2 AGEQTNUR3
     0 'LESS THAN 1 MONTH OLD'
     1 '1 MONTH OLD'
     2 '2 MONTHS OLD'
     3 '3 MONTHS OLD'
     98 'Refused'
     99 "Don't know" /
 PRGOUTCOME OUTCOM_S
     1 'LIVE BIRTH'
     2 'PREGNANCY LOSS OR ABORTION'
     3 'CURRENT PREGNANCY'
     8 'Refused'
     9 "Don't know" /
 NBRNLV_S
     1 '1 BABY'
     2 '2 BABIES'
     3 '3 BABIES'
     8 'Refused'
     9 "Don't know" /
 ANYUSINT
     1 'Yes'
     5 'No'
     7 'Not ascertained'
     8 'Refused'
     9 "Don't know" /
 WHATMETH01 WHATMETH02 WHATMETH03 WHATMETH04
     1 'No method used'
     3 'Birth control pills'
     4 'Condom'
     5 "Partner's vasectomy"
     6 'Female sterilizing operation, such as tubal sterilization and hysterectomy'
     7 'Withdrawal, pulling out'
     8 'Depo-Provera, injectables'
     9 'Hormonal implant (Norplant, Implanon, or Nexplanon)'
     10 'Calendar rhythm, Standard Days, or Cycle Beads method'
     11 'Safe period by temperature or cervical mucus test (Two Day, Billings Ovulation, or Sympto-thermal Method)'
     12 'Diaphragm'
     13 'Female condom, vaginal pouch'
     14 'Foam'
     15 'Jelly or cream'
     16 'Cervical cap'
     17 'Suppository, insert'
     18 'Today sponge'
     19 'IUD, coil, or loop'
     20 'Emergency contraception'
     21 'Other method'
     22 'Respondent was sterile'
     23 "Respondent's partner was sterile"
     24 'Lunelle injectable (monthly shot)'
     25 'Contraceptive patch'
     26 'Vaginal contraceptive ring'
     98 'Refused'
     99 "Don't know" /
 WANTBOLD
     1 'Yes'
     5 'No'
     6 "Not sure, Don't know"
     8 'Refused'
     9 "Don't know" /
 PROBBABE
     1 'Probably yes'
     5 'Probably not'
     6 "Didn't care"
     8 'Refused'
     9 "Don't know" /
 CNFRMNO
     1 'Correct'
     2 'Incorrect'
     8 'Refused'
     9 "Don't know" /
 WANTBLD2
     1 'Yes'
     2 'No'
     6 "Not sure, Don't know"
     7 "Didn't care"
     8 'Refused'
     9 "Don't know" /
 TIMINGOK TIMOKHP
     1 'Sooner'
     2 'Right time'
     3 'Later'
     4 "Didn't care"
     8 'Refused'
     9 "Don't know" /
 TOOSOON_N
     998 'Refused'
     999 "Don't know" /
 TOOSOON_P
     1 'Months'
     2 'Years'
     8 'Refused'
     9 "Don't know" /
 WTHPART1 WTHPART2
     1 'Definitely yes'
     2 'Probably yes'
     3 'Probably no'
     4 'Definitely no'
     8 'Refused'
     9 "Don't know" /
 FEELINPG
     0 'VERY UNHAPPY'
     1 '1'
     2 '2'
     3 '3'
     4 '4'
     5 '5'
     6 '6'
     7 '7'
     8 '8'
     9 '9'
     10 'VERY HAPPY'
     98 'REFUSED'
     99 "DON'T KNOW" /
 HPWNOLD
     1 'Yes'
     5 'No'
     6 "Not sure, Don't know"
     7 'Not ascertained'
     8 'Refused'
     9 "Don't know" /
 WHENTELL
     1 'During the pregnancy'
     2 'After the [pregnancy ended/baby was born]'
     8 'Refused'
     9 "Don't know" /
 TRYSCALE WANTSCAL
     0 '0'
     1 '1'
     2 '2'
     3 '3'
     4 '4'
     5 '5'
     6 '6'
     7 '7'
     8 '8'
     9 '9'
     10 '10'
     98 'Refused'
     99 "Don't know" /
 WHYPRG1 WHYPRG2
     1 'Your birth control method failed'
     2 'You did not use your birth control method properly'
     3 "Respondent wasn't using a method"
     8 'Refused'
     9 "Don't know" /
 WHYNOUSE1 WHYNOUSE2 WHYNOUSE3 WHYNOUSE4 WHYNOUSE5
     1 'You did not expect to have sex'
     2 'You did not think you could get pregnant'
     3 "You didn't really mind if you got pregnant"
     4 'You were worried about the side effects of birth control'
     5 'Your male partner did not want you to use a birth control method'
     6 'Your male partner himself did not want to use a birth control method'
     7 '(IF VOLUNTEERED:)Respondent was using a method'
     8 'You could not get a method'
     9 'You were not taking, or using, your method consistently'
     98 'Refused'
     99 "Don't know" /
 WHYNOPG1 WHYNOPG2
     1 'Diagnosis of repro problems/condition'
     2 'Prior preg or attempt: problems with or treatments/ART needed'
     3 'Prior unprotected sex, no preg'
     4 "Just didn't think would get preg/misunderstood risk"
     5 "Just didn't think could get preg"
     6 "Don't know why/didn't think about it/naive/mistake"
     7 'Thought method was still working (still in her system)'
     8 'Prior/recent miscarriage(s)'
     9 'Menstrual cycle problems/irregularity'
     10 'Had recent birth'
     11 'Perceive infertile or difficult getting preg/carrying to term'
     12 'Lack of education/knowledge'
     13 'Endometriosis'
     14 'Age (too old)'
     15 'Breastfeeding'
     16 'Believed partner subfecund/infertile/sterile'
     17 'Withdrawal failed'
     18 'Thought it was safe period in cycle'
     19 'Method failure (pill, condom, tubal, IUD)'
     20 'Other'
     97 'Not ascertained'
     98 'Refused'
     99 "Don't know" /
 MAINOUSE
     1 'You did not expect to have sex'
     2 'You did not think you could get pregnant'
     3 "You didn't really mind if you got pregnant"
     4 'You were worried about the side effects of birth control'
     5 'Your male partner did not want you to use a birth control method'
     6 'Your male partner himself did not want to use a birth control method'
     8 'You could not get a method'
     9 'You were not taking, or using, your method consistently'
     98 'Refused'
     99 "Don't know" /
 PRGLNGTH
     98 'Refused'
     99 "Don't know" /
 OUTCOME
     1 'LIVE BIRTH'
     2 'INDUCED ABORTION'
     3 'STILLBIRTH'
     4 'MISCARRIAGE'
     5 'ECTOPIC PREGNANCY'
     6 'CURRENT PREGNANCY' /
 BIRTHORD
     1 '1ST BIRTH'
     2 '2ND BIRTH'
     3 '3RD BIRTH'
     4 '4TH BIRTH'
     5 '5TH BIRTH'
     6 '6TH BIRTH'
     7 '7TH BIRTH'
     8 '8TH BIRTH'
     9 '9TH BIRTH'
     10 '10TH BIRTH'
     11 '11TH BIRTH'
     12 '12TH BIRTH'
     13 '13TH BIRTH'
     14 '14TH BIRTH' /
 FMAROUT5 FMARCON5
     1 'MARRIED'
     2 'DIVORCED'
     3 'WIDOWED'
     4 'SEPARATED'
     5 'NEVER MARRIED' /
 PMARPREG
     1 'YES'
     2 'No' /
 RMAROUT6 RMARCON6
     1 'MARRIED'
     2 'DIVORCED'
     3 'WIDOWED'
     4 'SEPARATED'
     5 'COHABITING'
     6 'NEVER MARRIED, NOT COHABITING' /
 PNCAREWK
     95 'NO PRENATAL CARE FOR THIS PREGNANCY' /
 PAYDELIV
     1 'OWN INCOME ONLY'
     2 'INSURANCE ONLY'
     3 'OWN INCOME & INSURANCE ONLY'
     4 'MEDICAID/GOVT ASSISTANCE MENTIONED AT ALL'
     5 'ALL OTHER COMBINATIONS OF PAYMENT METHODS' /
 LBW1
     1 'YES, LOW BIRTH WEIGHT'
     2 'NO, NOT LOW BIRTH WEIGHT' /
 LIVCHILD
     1 'Child lives with R'
     2 'Child is dead'
     3 'Child lives with adoptive parents/family'
     4 'Child lives with biological father'
     5 'Child lives with other relatives'
     6 "Child's living arrangements are other or unknown" /
 BFEEDWKS
     0 'Less than 1 week'
     994 'STILL BREASTFEEDING THIS CHILD'
     995 'NEVER BREAST-FED THIS CHILD' /
 OLDWANTR OLDWANTP WANTRESP WANTPART
     1 'LATER, OVERDUE'
     2 'RIGHT TIME'
     3 'TOO SOON, MISTIMED'
     4 "DIDN'T CARE, INDIFFERENT"
     5 'UNWANTED'
     6 "DON'T KNOW, NOT SURE" /
 TOOSOON
     998 'Refused'
     999 "Don't know" /
 NEWWANTR
     1 'Later, overdue'
     2 'Right time'
     3 'Too soon: by less than 2 years'
     4 'Too soon: by 2 years or more'
     5 "Didn't care, indifferent"
     6 'Unwanted'
     7 "Don't know, not sure" /
 AGER
     15 '15 YEARS'
     16 '16 YEARS'
     17 '17 YEARS'
     18 '18 YEARS'
     19 '19 YEARS'
     20 '20 YEARS'
     21 '21 YEARS'
     22 '22 YEARS'
     23 '23 YEARS'
     24 '24 YEARS'
     25 '25 YEARS'
     26 '26 YEARS'
     27 '27 YEARS'
     28 '28 YEARS'
     29 '29 YEARS'
     30 '30 YEARS'
     31 '31 YEARS'
     32 '32 YEARS'
     33 '33 YEARS'
     34 '34 YEARS'
     35 '35 YEARS'
     36 '36 YEARS'
     37 '37 YEARS'
     38 '38 YEARS'
     39 '39 YEARS'
     40 '40 YEARS'
     41 '41 YEARS'
     42 '42 YEARS'
     43 '43 YEARS'
     44 '44 YEARS'
     45 '45 YEARS'
     46 '46 YEARS'
     47 '47 YEARS'
     48 '48 YEARS' /
 AGESCRN
     15 '15 years'
     16 '16 years'
     17 '17 years'
     18 '18 years'
     19 '19 years'
     20 '20 years'
     21 '21 years'
     22 '22 years'
     23 '23 years'
     24 '24 years'
     25 '25 years'
     26 '26 years'
     27 '27 years'
     28 '28 years'
     29 '29 years'
     30 '30 years'
     31 '31 years'
     32 '32 years'
     33 '33 years'
     34 '34 years'
     35 '35 years'
     36 '36 years'
     37 '37 years'
     38 '38 years'
     39 '39 years'
     40 '40 years'
     41 '41 years'
     42 '42 years'
     43 '43 years'
     44 '44 years'
     45 '45 years'
     46 '46 years'
     47 '47 years'
     48 '48 years'
     49 '49 years' /
 FMARITAL
     1 'MARRIED TO A PERSON OF THE OPPOSITE SEX'
     2 'WIDOWED'
     3 'DIVORCED OR ANNULLED'
     4 'SEPARATED'
     5 'NEVER MARRIED' /
 RMARITAL
     1 'CURRENTLY MARRIED'
     2 'NOT MARRIED BUT LIVING WITH OPP SEX PARTNER'
     3 'WIDOWED'
     4 'DIVORCED'
     5 'SEPARATED FOR REASONS OF MARITAL DISCORD'
     6 'NEVER BEEN MARRIED' /
 EDUCAT
     9 '9TH GRADE OR LESS'
     10 '10TH GRADE'
     11 '11TH GRADE'
     12 '12TH GRADE'
     13 '1 YEAR OF COLLEGE/GRAD SCHOOL'
     14 '2 YEARS OF COLLEGE/GRAD SCHOOL'
     15 '3 YEARS OF COLLEGE/GRAD SCHOOL'
     16 '4 YEARS OF COLLEGE/GRAD SCHOOL'
     17 '5 YEARS OF COLLEGE/GRAD SCHOOL'
     18 '6 YEARS OF COLLEGE/GRAD SCHOOL'
     19 '7+ YEARS OF COLLEGE/GRAD SCHOOL' /
 HIEDUC
     5 '9TH GRADE OR LESS'
     6 '10TH GRADE'
     7 '11TH GRADE'
     8 '12TH GRADE, NO DIPLOMA (NOR GED)'
     9 'HIGH SCHOOL GRADUATE (DIPLOMA OR GED)'
     10 'SOME COLLEGE BUT NO DEGREE'
     11 'ASSOCIATE DEGREE IN COLLEGE/UNIVERSITY'
     12 "BACHELOR'S DEGREE"
     13 "MASTER'S DEGREE"
     14 'DOCTORATE DEGREE'
     15 'PROFESSIONAL DEGREE' /
 RACE
     1 'BLACK'
     2 'WHITE'
     3 'OTHER' /
 HISPANIC
     1 'HISPANIC'
     2 'NON-HISPANIC' /
 HISPRACE
     1 'Hispanic'
     2 'Non-Hispanic White'
     3 'Non-Hispanic Black'
     4 'Non-Hispanic Other' /
 HISPRACE2
     1 'Hispanic'
     2 'Non-Hispanic White, Single Race'
     3 'Non-Hispanic Black, Single Race'
     4 'Non-Hispanic Other or Multiple Race' /
 RCURPREG
     1 'YES (CURRENTLY PREGNANT)'
     2 'NO (NOT CURRENTLY PREGNANT)' /
 PREGNUM
     0 'NONE'
     1 '1 PREGNANCY'
     2 '2 PREGNANCIES'
     3 '3 PREGNANCIES'
     4 '4 PREGNANCIES'
     5 '5 PREGNANCIES'
     6 '6 PREGNANCIES' /
 PARITY
     0 '0 BABIES'
     1 '1 BABY'
     2 '2 BABIES'
     3 '3 BABIES'
     4 '4 BABIES' /
 CURR_INS
     1 'Currently covered by private health insurance or Medi-Gap'
     2 'Currently covered by Medicaid, CHIP, or a state-sponsored health plan'
     3 'Currently covered by Medicare, military health care, or other government health care'
     4 'Currently covered only by a single-service plan, only by the Indian Health Service, or currently not covered by health insurance' /
 PUBASSIS
     1 'YES (RECEIVED PUBLIC ASSISTANCE IN [INTERVIEW YEAR -1])'
     2 'NO (DID NOT RECEIVE PUBLIC ASSISTANCE IN [INTERVIEW YEAR -1])' /
 POVERTY
     500 '500 PERCENT OF POVERTY LEVEL OR GREATER' /
 LABORFOR
     1 'WORKING FULL-TIME'
     2 'WORKING PART-TIME'
     3 'WORKING-TEMP ILL/ETC'
     4 'WORKING-MATERNITY OR FAMILY LEAVE'
     5 'NOT WORKING BUT LOOKING FOR WORK'
     6 'SCHOOL'
     7 'KEEPING HOUSE'
     8 'CARING FOR FAMILY'
     9 'OTHER' /
 RELIGION
     1 'NO RELIGION'
     2 'CATHOLIC'
     3 'PROTESTANT'
     4 'OTHER RELIGIONS' /
 METRO
     1 'PRINCIPAL CITY OF MSA'
     2 'OTHER MSA'
     3 'NOT MSA' /
 PRGLNGTH_I OUTCOME_I BIRTHORD_I DATEND_I AGEPREG_I DATECON_I AGECON_I 
 FMAROUT5_I PMARPREG_I RMAROUT6_I FMARCON5_I RMARCON6_I LEARNPRG_I PNCAREWK_I 
 PAYDELIV_I LBW1_I LIVCHILD_I BFEEDWKS_I OLDWANTR_I OLDWANTP_I WANTRESP_I 
 WANTPART_I TOOSOON_I NEWWANTR_I AGER_I FMARITAL_I RMARITAL_I EDUCAT_I 
 HIEDUC_I RACE_I HISPANIC_I HISPRACE_I HISPRACE2_I RCURPREG_I PREGNUM_I 
 PARITY_I CURR_INS_I PUBASSIS_I POVERTY_I LABORFOR_I RELIGION_I METRO_I
     0 'QUESTIONNAIRE DATA (NOT IMPUTED)'
     1 'MULTIPLE REGRESSION IMPUTATION'
     2 'LOGICAL IMPUTATION' /
 CMINTVW CMLSTYR
     9997 'Not ascertained'
     9998 'Refused'
     9999 "Don't know" /
 CMJAN3YR
     1345 'January 2012'
     1357 'January 2013'
     1369 'January 2014' /
 CMJAN4YR
     1333 'January 2011'
     1345 'January 2012'
     1357 'January 2013' /
 CMJAN5YR
     1321 'January 2010'
     1333 'January 2011'
     1345 'January 2012' /
 QUARTER
     '17' '17'
     '18' '18'
     '19' '19'
     '20' '20'
     '21' '21'
     '22' '22'
     '23' '23'
     '24' '24' /
 PHASE
     '1' 'First 10 weeks of quarter'
     '2' 'Last 2 weeks of quarter (double sample)' /
 INTVWYEAR
     '2015' '2015'
     '2016' '2016'
     '2017' '2017' / .

EXECUTE.

* CREATE SPSS SYSTEM FILE.

*SAVE OUTFILE="spss-filename.sav".
