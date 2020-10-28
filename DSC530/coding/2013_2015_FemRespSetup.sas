/*--------------------------------------------------------------------------
 |
 |           NATIONAL SURVEY OF FAMILY GROWTH (NSFG), 2013-2015
 |
 |                       SAS Female Data Setup File
 |
 |
 | SAS setup sections are provided for the ASCII version of this data
 | collection.  These sections are listed below:
 |
 | PROC FORMAT:  creates user-defined formats for the variables. Formats
 | replace original value codes with value code descriptions. Only
 | variables with user-defined formats are included in this section.
 |
 | DATA:  begins a SAS data step and names an output SAS data set.
 |
 | INFILE:  identifies the input file to be read with the input statement.
 | Users must replace the "data-filename" with a filename specifying the
 | directory on the user's computer system in which the downloaded and
 | unzipped data file is physically located (e.g., "c:\temp\data.dat").
 |
 | INPUT:  assigns the name, type, decimal specification (if any), and
 | specifies the beginning and ending column locations for each variable
 | in the data file.
 |
 | LABEL:  assigns descriptive labels to all variables. Variable labels
 | and variable names may be identical for some variables.
 |
 | MISSING VALUE NOTE:  To maintain the original meaning of missing codes,
 | users may want to take advantage of the SAS missing values (the letters
 | A-Z or an underscore preceded by a period).
 |
 | An example of a standard missing value recode:
 |
 |   IF (RELATION = 98 OR RELATION = 99) THEN RELATION = .; 
 |
 | The same example using special missing value recodes:
 |
 |    IF RELATION = 98 THEN RELATION = .A;
 |    IF RELATION = 99 THEN RELATION = .B;
 |
 | FORMAT:  associates the formats created by the PROC FORMAT step with
 | the variables named in the INPUT statement.
 |
 | Users should modify this setup file to suit their specific needs.
 | To include these sections in the final SAS setup, users should remove the
 | SAS comment indicators from the desired section(s).
 |
 |-------------------------------------------------------------------------*/

* SAS PROC FORMAT;

/*
PROC FORMAT;
   value ABNPAP3F
      1="Yes"
      5="No"
      6="No Pap test in past 3 years"
      8="Refused"
      9="Don't know" ;
   value ACASILANG
      1="English"
      2="Spanish"
      7="Not ascertained" ;
   value ADDEXP
      0="NO ADDITIONAL BIRTHS"
      5=".5 ADDITIONAL BIRTHS"
      10="1 ADDITIONAL BIRTH"
      15="1.5 ADDITIONAL BIRTHS"
      20="2 ADDITIONAL BIRTHS"
      25="2.5 ADDITIONAL BIRTHS"
      30="3 ADDITIONAL BIRTHS"
      35="3.5 ADDITIONAL BIRTHS"
      40="4 ADDITIONAL BIRTHS"
      45="4.5 ADDITIONAL BIRTHS"
      50="5 ADDITIONAL BIRTHS"
      55="5.5 ADDITIONAL BIRTHS"
      60="6 ADDITIONAL BIRTHS"
      65="6.5 ADDITIONAL BIRTHS"
      70="7 ADDITIONAL BIRTHS"
      75="7.5 ADDITIONAL BIRTHS"
      80="8 ADDITIONAL BIRTHS"
      85="8.5 ADDITIONAL BIRTHS"
      90="9 ADDITIONAL BIRTHS"
      95="9.5 ADDITIONAL BIRTH" ;
   value ADPTOTKD
      1="Yes, adopted"
      3="Yes, became guardian"
      5="No, neither"
      8="Refused"
      9="Don't know" ;
   value AG95NRDF
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value AG95RDF
      98="Refused"
      99="Don't know" ;
   value AGDGFMT
      1="Strongly agree"
      2="Agree"
      3="Disagree"
      4="Strongly disagree"
      5="If R insists: Neither agree nor disagree"
      8="Refused"
      9="Don't know" ;
   value AGE25NRDF
      98="Refused"
      99="Don't know" ;
   value AGE44NRDF
      98="Refused"
      99="Don't know" ;
   value AGECANCER
      98="Refused"
      99="Don't know" ;
   value AGEF2F
      1="Younger than 18"
      2="18-21"
      3="22-29"
      4="30 or older"
      8="Refused"
      9="Don't know" ;
   value AGEFHPV
      96="R only had 1 HPV exam"
      98="Refused"
      99="Don't know" ;
   value AGEFMT
      15="15 years"
      16="16 years"
      17="17 years"
      18="18 years"
      19="19 years"
      20="20 years"
      21="21 years"
      22="22 years"
      23="23 years"
      24="24 years"
      25="25 years"
      26="26 years"
      27="27 years"
      28="28 years"
      29="29 years"
      30="30 years"
      31="31 years"
      32="32 years"
      33="33 years"
      34="34 years"
      35="35 years"
      36="36 years"
      37="37 years"
      38="38 years"
      39="39 years"
      40="40 years"
      41="41 years"
      42="42 years"
      43="43 years"
      98="Refused"
      99="Don't know" ;
   value AGEFPAP
      96="R only had 1 pap test"
      98="Refused"
      99="Don't know" ;
   value AGEFPEL
      96="R only had 1 pelvic exam"
      98="Refused"
      99="Don't know" ;
   value AGEHP
      98="Refused"
      99="Don't know" ;
   value AGEMAM1F
      98="Refused"
      99="Don't know" ;
   value AGEMOMBF
      1="LESS THAN 18 YEARS"
      2="18-19 YEARS"
      3="20-24 YEARS"
      4="25-29 YEARS"
      5="30 OR OLDER"
      95="NO MOTHER OR MOTHER-FIGURE"
      96="MOTHER-FIGURE HAD NO CHILDREN" ;
   value AGERFEMC
      98="Refused"
      99="Don't know" ;
   value AGERFF
      15="15 YEARS"
      16="16 YEARS"
      17="17 YEARS"
      18="18 YEARS"
      19="19 YEARS"
      20="20 YEARS"
      21="21 YEARS"
      22="22 YEARS"
      23="23 YEARS"
      24="24 YEARS"
      25="25 YEARS"
      26="26 YEARS"
      27="27 YEARS"
      28="28 YEARS"
      29="29 YEARS"
      30="30 YEARS"
      31="31 YEARS"
      32="32 YEARS"
      33="33 YEARS"
      34="34 YEARS"
      35="35 YEARS"
      36="36 YEARS"
      37="37 YEARS"
      38="38 YEARS"
      39="39 YEARS"
      40="40 YEARS"
      41="41 YEARS"
      42="42 YEARS"
      43="43 YEARS" ;
   value AGESCRN
      15="15 years"
      16="16 years"
      17="17 years"
      18="18 years"
      19="19 years"
      20="20 years"
      21="21 years"
      22="22 years"
      23="23 years"
      24="24 years"
      25="25 years"
      26="26 years"
      27="27 years"
      28="28 years"
      29="29 years"
      30="30 years"
      31="31 years"
      32="32 years"
      33="33 years"
      34="34 years"
      35="35 years"
      36="36 years"
      37="37 years"
      38="38 years"
      39="39 years"
      40="40 years"
      41="41 years"
      42="42 years"
      43="43 years"
      44="44 years"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value AIDSTALKF
      1="How HIV/AIDS is transmitted"
      2="Other sexually transmitted diseases like gonorrhea, herpes, or Hepatitis C"
      3="The correct use of condoms"
      4="Needle cleaning/using clean needles"
      5="Dangers of needle sharing"
      6="Abstinence from sex (not having sex)"
      7="Reducing your number of sexual partners"
      8="Condom use to prevent HIV or STD transmission"
      9='"Safe sex" practices (abstinence, condom use, etc)'
      10="Getting tested and knowing your HIV status"
      20="Some other topic - not shown separately"
      98="Refused"
      99="Don't know" ;
   value ANYBCF
      1="yes, at least one month of method use"
      2="no, no months of method use" ;
   value APROCESSF
      1="Fees were too high"
      2="There were not enough kids available"
      3="Some other reason"
      8="Refused"
      9="Don't know" ;
   value ATTNDF
      1="More than once a week"
      2="Once a week"
      3="2-3 times a month"
      4="Once a month (about 12 times a year)"
      5="3-11 times a year"
      6="Once or twice a year"
      7="Never"
      8="Refused"
      9="Don't know" ;
   value ATTRACT
      1="Only attracted to males"
      2="Mostly attracted to males"
      3="Equally attracted to males and females"
      4="Mostly attracted to females"
      5="Only attracted to females"
      6="Not sure"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value BARRIERF
      1="I did not need to see a doctor in the last year"
      2="I did not know where to go for care"
      3="I could not afford to pay for a visit"
      4="I was afraid to hear bad news"
      5="I had privacy/confidentiality concerns"
      6="I could not take time off from work"
      7="Insurance"
      8="Not sexually active"
      9="Time/busy"
      10="Didn't make appt"
      11="Don't like/trust doctors"
      20="Something else (please specify)"
      98="Refused"
      99="Don't know" ;
   value BCPLCF
      1="Private doctor's office"
      2="HMO facility"
      3="Community health clinic, community clinic, public health clinic"
      4="Family planning or Planned Parenthood Clinic"
      5="Employer or company clinic"
      6="School or school-based clinic"
      7="Hospital outpatient clinic"
      8="Hospital emergency room"
      9="Hospital regular room"
      10="Urgent care center, urgi-care or walk-in facility"
      20="Some other place"
      98="Refused"
      99="Don't know" ;
   value BCREAS
      1="Yes"
      5="No"
      6="No, not using any method at the time"
      8="Refused"
      9="Don't know" ;
   value BCWHYFF
      1="Health or medical problem"
      2="Some other reason"
      3="Both"
      8="Refused"
      9="Don't know" ;
   value BFAFTF
      1="Before"
      2="After"
      8="Refused"
      9="Don't know" ;
   value BIONUMFF
      1="1 CHILD"
      2="2 CHILDREN"
      98="Refused"
      99="Don't know" ;
   value BIRTHS5F
      0="0 BIRTHS"
      1="1 BIRTH"
      2="2 BIRTHS" ;
   value BMI
      95="Could not be defined" ;
   value BNGE30T
      0="NONE"
      1="1 TIME"
      2="2 TIMES"
      3="3 TIMES"
      4="4 TIMES"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value CANCTYPE
      1="Bladder cancer"
      2="Bone cancer"
      3="Brain cancer or tumor, spinal cord cancer, or other cancer of the central nervous system"
      4="Breast cancer"
      5="Cervical cancer (cancer of the cervix)"
      6="Colon cancer"
      7="Endometrial cancer (cancer of the uterus)"
      8="Head and neck cancer"
      9="Heart cancer"
      10="Leukemia/blood cancer"
      11="Liver cancer"
      12="Lung cancer"
      13="Lymphoma including Hodgkins disease/lymphoma and non-Hodgkins lymphomas"
      14="Melanoma"
      15="Neuroblastoma"
      16="Oral (mouth) cancer"
      17="Ovarian cancer"
      18="Pancreatic cancer"
      19="Pharyngeal (throat) cancer"
      20="BLANK"
      21="Rectal cancer"
      22="Renal (kidney) cancer"
      23="Stomach cancer"
      24="Thyroid cancer"
      25="Other"
      98="Refused"
      99="Don't know" ;
   value CASIGRAD
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value CASINUM
      0="NO PREGNANCIES"
      1="1 PREGNANCY"
      2="2 PREGNANCIES"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value CASISMK
      0="NEVER SMOKED REGULARLY"
      11="11 YEARS OR YOUNGER"
      12="12 YEARS OLD"
      13="13 YEARS OLD"
      14="14 YEARS OLD"
      15="15 YEARS OLD"
      16="16 YEARS OLD"
      17="17 YEARS OLD"
      18="18 YEARS OLD"
      19="19 YEARS OLD"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value CEBOW
      0="NONE"
      1="1 CHILD"
      2="2 CHILDREN" ;
   value CHBOTHER
      1="A great deal"
      2="Some"
      3="A little"
      4="Not at all"
      8="Refused"
      9="Don't know" ;
   value CHOSDISB
      1="A child with no disability"
      2="A child with a mild disability"
      3="A child with a severe disability"
      4="Indifferent"
      8="Refused"
      9="Don't know" ;
   value CHOSEAGE
      1="A child younger than 2 years"
      2="A child 2-5 years old"
      3="A child 6-12 years old"
      4="A child 13 years old or older"
      5="Indifferent"
      8="Refused"
      9="Don't know" ;
   value CHOSENUM
      1="A single child"
      2="2 or more brothers and sisters at once"
      3="Indifferent"
      8="Refused"
      9="Don't know" ;
   value CHOSESEX
      1="Boy"
      2="Girl"
      3="Indifferent"
      8="Refused"
      9="Don't know" ;
   value CHOSRACE
      1="Black"
      2="White"
      3="Some other race"
      4="Indifferent"
      8="Refused"
      9="Don't know" ;
   value CMFMT
      9997="Not ascertained"
      9998="Refused"
      9999="Don't know" ;
   value CMFSEX
      9996="Only had sex once with this partner"
      9998="Refused"
      9999="Don't know" ;
   value CMFSTSEX
      9996="Never had sex"
      9998="Refused"
      9999="Don't know" ;
   value CMLSEXFP
      9996="Only had sex once with first partner"
      9998="Refused"
      9999="Don't know" ;
   value CMPGVISL
      9996="Only had 1 visit"
      9998="Refused"
      9999="Don't know" ;
   value COHEVER
      1="YES, EVER COHABITED (LIVED WITH A MAN OUTSIDE OF MARRIAGE)"
      2="NO, NEVER COHABITED (LIVED WITH A MAN OUTSIDE OF MARRIAGE)" ;
   value COHNUM
      0="None"
      1="One"
      2="Two"
      3-HIGH="Three or more" ;
   value COHOUT
      1="INTACT COHABITATION"
      2="INTACT MARRIAGE"
      3="DISSOLVED MARRIAGE"
      4="DISSOLVED COHABITATION" ;
   value COHSTAT
      1="NEVER COHABITED OUTSIDE OF MARRIAGE"
      2="FIRST COHABITED BEFORE FIRST MARRIAGE"
      3="FIRST COHABITED AFTER FIRST MARRIAGE" ;
   value CON1MARF
      0="LESS THAN 1 MONTH"
      995="FIRST CONCEPTION AFTER OR IN SAME MONTH AS FIRST MARRIAGE"
      996="HAS BEEN MARRIED, BUT HAS NEVER BEEN PREGNANT" ;
   value CONDTMS
      0="Not at all or never"
      998="Refused"
      999="Don't know" ;
   value CONSTATF
      1="Female sterilization"
      2="Male sterilization"
      3="Norplant or Implanon implant"
      5="Depo-Provera (injectable)"
      6="Pill"
      7="Contraceptive Patch"
      8="Contraceptive Ring"
      9="Emergency contraception"
      10="IUD"
      11="Diaphragm (with or w/out jelly or cream)"
      12="(Male) Condom"
      13="Female condom/vaginal pouch"
      14="Foam"
      15="Cervical Cap"
      16="Today(TM) Sponge"
      17="Suppository or insert"
      18="Jelly or cream (not with diaphragm)"
      19="Periodic abstinence: NFP, cervical mucus test or temperature rhythm"
      20="Periodic abstinence: calendar rhythm"
      21="Withdrawal"
      22="Other method"
      30="Pregnant"
      31="Seeking Pregnancy"
      32="Postpartum"
      33="Sterile--nonsurgical--female"
      34="Sterile--nonsurgical--male"
      35="Sterile--surgical--female (noncontraceptive)"
      36="Sterile--surgical--male (noncontraceptive)"
      37="[code not used]"
      38="Sterile--unknown reasons-male"
      39="[code not used]"
      40="Other nonuser--never had intercourse since first period"
      41="Other nonuser--has had intercourse, but not in the 3 months prior to interview"
      42="Other nonuser--had intercourse in the 3 months prior to interview"
      88="Inapplicable (no 2nd, 3rd, or 4th method reported)" ;
   value COVERHOWF
      1="Private health insurance plan (from employer or workplace; purchased directly; through a state or local government program or community program)"
      2="Medicaid-additional name(s) for Medicaid in this state: [MEDICAID_FILL]"
      3="Medicare"
      4="Medi-GAP"
      5="Military health care including: the VA, CHAMPUS, TRICARE, CHAMP-VA"
      6="Indian Health Service, or Single Service Plan"
      7="CHIP"
      8="State-sponsored health plan"
      9="Other government health care"
      98="Refused"
      99="Don't know" ;
   value CSPBIO
      0="No joint biological children"
      1="1 joint biological child"
      2="2 joint biological children"
      3="3 or more joint biological children" ;
   value CSPNOT
      0="No such child"
      1="1 or more such children" ;
   value CURR_INS
      1="Currently covered by private health insurance or Medi-Gap"
      2="Currently covered by Medicaid, CHIP, or a state-sponsored health plan"
      3="Currently covered by Medicare, military health care, or other government health care"
      4="Currently covered only by a single-service plan, only by the Indian Health Service, or currently not covered by health insurance" ;
   value CURRPRTS
      0="NONE"
      1="1 PARTNER" ;
   value CURRREL
      2="Engaged to him"
      4="Going with him or going steady"
      5="Going out with him once in a while"
      6="Just friends"
      7="Had just met him"
      8="Something else"
      98="Refused"
      99="Don't know" ;
   value DATESEX1F
      9595="NEVER HAD A MENSTRUAL PERIOD BUT HAS HAD INTERCOURSE" ;
   value DEFPROBF
      1="Definitely yes"
      2="Probably yes"
      3="Probably no"
      4="Definitely no"
      8="Refused"
      9="Don't know" ;
   value DEGREES
      1="Associate's degree"
      2="Bachelor's degree"
      3="Master's degree"
      4="Doctorate degree"
      5="Professional school degree"
      8="Refused"
      9="Don't know" ;
   value DFPRBNAF
      1="Definitely yes"
      2="Probably yes"
      3="Probably no"
      4="Definitely no"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value DGHT918F
      0="No daughters"
      1="1 daughter"
      2="2 or more daughters" ;
   value DIABETES
      1="Yes"
      3="If volunteered: Borderline or Pre-Diabetes"
      5="No"
      8="Refused"
      9="Don't know" ;
   value DIPGED
      1="High school diploma"
      2="GED only"
      3="Both"
      5="Neither"
      8="Refused"
      9="Don't know" ;
   value DOLASTWK
      1="Working"
      2="Working - Maternity leave or temp leave"
      3="Not working, looking for work"
      4="Keeping house or taking care of family"
      5="In school"
      6="Other"
      8="Refused"
      9="Don't know" ;
   value DRINKF
      1="Never"
      2="Once or twice during the year"
      3="Several times during the year"
      4="About once a month"
      5="About once a week"
      6="About once a day"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value DRNK30D
      0="0 DAYS"
      1="1 DAY"
      2="2 DAYS"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value DRNKNUM
      1="1 DRINK"
      2="2 DRINKS"
      3="3 DRINKS"
      4="4 DRINKS"
      5="5 DRINKS"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value DRUGDEVE
      0="No method ever"
      1="1 method"
      2="2 methods"
      98="Refused"
      99="Don't know" ;
   value DRUGFRF
      1="Never"
      2="Once or twice during the year"
      3="Several times during the year"
      4="About once a month or more"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value DUCHFREQ
      1="Never"
      2="Once a month or less often"
      3="2-3 times a month"
      4="Once a week"
      5="2-3 times a week"
      6="4-6 times a week"
      7="Every day"
      8="Refused"
      9="Don't know" ;
   value DURFSTER
      1="Less than six months"
      2="At least six months, but less than a year"
      3="At least a year but less than two years"
      4="At least two years but less than three years"
      5="Three years or more"
      8="Refused"
      9="Don't know" ;
   value DURTRY_N
      95="Not trying to get pregnant"
      98="Refused"
      99="Don't know" ;
   value DURTRY_P
      1="Months"
      2="Years"
      8="Refused"
      9="Don't know" ;
   value EARN
      1="Under $96 (weekly)/Under $417 (monthly)/Under $5,000 (yearly)"
      2="$96-$143 (weekly)/$417-624 (monthly)/$5,000-7,499 (yearly)"
      3="$144-191 (weekly)/$625-832 (monthly)/$7,500-9,999 (yearly)"
      4="$192-239 (weekly)/$833-1,041 (monthly)/$10,000-12,499 (yearly)"
      5="$240-288 (weekly)/$1,042-1,249 (monthly)/$12,500-14,999 (yearly)"
      6="$289-384 (weekly)/$1,250-1,666 (monthly)/$15,000-19,999 (yearly)"
      7="$385-480 (weekly)/$1,667-2,082 (monthly)/$20,000-24,999 (yearly)"
      8="$481-576 (weekly)/$2,083-2,499 (monthly)/$25,000-29,999 (yearly)"
      9="$577-672 (weekly)/$2,500-2,916 (monthly)/$30,000-34,999 (yearly)"
      10="$673-768 (weekly)/$2,917-3,332 (monthly)/$35,000-39,999 (yearly)"
      11="$769-961 (weekly)/$3,333-4,166 (monthly)/$40,000-49,999 (yearly)"
      12="$962-1,153 (weekly)/$4,167-4,999 (monthly)/$50,000-59,999 (yearly)"
      13="$1,154-1,441 (weekly)/$5,000-6,249 (monthly)/$60,000-74,999 (yearly)"
      14="$1,442-1,922 (weekly)/$6,250-8,332 (monthly)/$75,000-99,999 (yearly)"
      15="$1,923 or more (weekly)/$8,333 or more (monthly)/$100,000 or more (yearly)"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value ECREASONF
      1="You were worried your birth control method would not work"
      2="You didn't use birth control that time"
      3="Some other reason"
      8="Refused"
      9="Don't know" ;
   value ECRX
      1="With a prescription"
      2="Without a prescription"
      8="Refused"
      9="Don't know" ;
   value ECWHEN
      1="Within the last 12 months"
      2="Over 12 months ago"
      8="Refused"
      9="Don't know" ;
   value EDUCAT
      9="9TH GRADE OR LESS"
      10="10TH GRADE"
      11="11TH GRADE"
      12="12TH GRADE"
      13="1 YEAR OF COLLEGE/GRAD SCHOOL"
      14="2 YEARS OF COLLEGE/GRAD SCHOOL"
      15="3 YEARS OF COLLEGE/GRAD SCHOOL"
      16="4 YEARS OF COLLEGE/GRAD SCHOOL"
      17="5 YEARS OF COLLEGE/GRAD SCHOOL"
      18="6 YEARS OF COLLEGE/GRAD SCHOOL"
      19="7+ YEARS OF COLLEGE/GRAD SCHOOL" ;
   value EDUCFMT
      1="Less than high school"
      2="High school graduate or GED"
      3="Some college but no degree"
      4="2-year college degree (e.g., Associate's degree)"
      5="4-year college graduate (e.g., BA, BS)"
      6="Graduate or professional school"
      8="Refused"
      9="Don't know" ;
   value EDUCMOM
      1="Less than high school"
      2="High school graduate or GED"
      3="Some college, including 2-year degrees"
      4="Bachelor's degree or higher"
      95="No mother-figure identified" ;
   value ENGAGF
      1="YES, ENGAGED TO BE MARRIED"
      3="NOT ENGAGED BUT HAD DEFINITE PLANS TO GET MARRIED"
      5="NO, NEITHER ENGAGED NOR HAD DEFINITE PLANS"
      8="Refused"
      9="Don't know" ;
   value ENGSPEAK
      1="Very well"
      2="Well"
      3="Not well"
      4="Not at all"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value EVERADPT
      1="YES, HAS ADOPTED A CHILD"
      3="NO, BUT IS CURRENTLY TRYING TO ADOPT SPECIFIC CHILD"
      5="NO, AND NOT TRYING TO ADOPT A SPECIFIC CHILD" ;
   value EVERTUBS
      1="Yes"
      3="If volunteered: Operation failed"
      4="If volunteered: Had ESSURE procedure"
      5="No"
      6="If volunteered: Operation already reversed"
      8="Refused"
      9="Don't know" ;
   value EVHIVTST
      0="NO HIV TEST REPORTED"
      1="YES, ONLY AS PART OF BLOOD DONATION"
      2="YES, ONLY OUTSIDE OF BLOOD DONATION"
      3="YES, IN BOTH CONTEXTS" ;
   value EVIUDTYPF
      1="Copper-bearing (such as Copper-T or ParaGard)"
      2="Hormonal IUD (such as Mirena or Skyla)"
      3="Other"
      8="Refused"
      9="Don't know" ;
   value EVMARCOH
      1="YES, EVER MARRIED OR COHABITED"
      2="NO, NEVER MARRIED OR COHABITED" ;
   value EVRMARRY
      0="NEVER MARRIED"
      1="EVER MARRIED" ;
   value EXPGRADE2F
      9="9th grade or less"
      10="10th grade"
      11="11th grade"
      12="12th grade"
      13="1 year of college or less"
      14="2 years of college"
      15="3 years of college"
      16="4 years of college/grad school"
      17="5 years of college/grad school"
      18="6 years of college/grad school"
      19="7 or more years of college and/or grad school"
      98="Refused"
      99="Don't know" ;
   value FECUND
      1="SURGICALLY STERILE, CONTRACEPTIVE"
      2="SURGICALLY STERILE, NONCONTRACEPTIVE"
      3="STERILE, NONSURGICAL"
      4="SUBFECUND"
      5="LONG INTERVAL (INFERTILE FOR 36+ MONTHS)"
      6="FECUND" ;
   value FIRSMETHF
      3="Birth control pills"
      4="Condom"
      5="Partner's vasectomy"
      6="Female sterilizing operation, such as tubal sterilization and hysterectomy"
      7="Withdrawal, pulling out"
      8="Depo-Provera, injectables"
      9="Hormonal implant (Norplant, Implanon, or Nexplanon)"
      10="Calendar rhythm, Standard Days, or Cycle Beads method"
      11="Safe period by temperature or cervical mucus test (Two Day, Billings Ovulation, or Sympto-thermal Method)"
      12="Diaphragm"
      13="Female condom, vaginal pouch"
      14="Foam"
      15="Jelly or cream"
      16="Cervical cap"
      17="Suppository, insert"
      18="Today sponge"
      19="IUD, coil, or loop"
      20="Emergency contraception"
      21="Other method -- specify"
      22="Respondent was sterile"
      23="Respondent's partner was sterile"
      24="Lunelle injectable (monthly shot)"
      25="Contraceptive patch"
      26="Vaginal contraceptive ring"
      98="Refused"
      99="Don't know" ;
   value FIRSTIME1F
      2="The first time you had intercourse"
      3="Less than a month after your first intercourse"
      4="One to three months after first intercourse"
      5="Four to twelve months after first intercourse"
      6="More than twelve months after first intercourse"
      8="Refused"
      9="Don't know" ;
   value FIRSTIME2F
      1="Before your first intercourse"
      2="The first time you had intercourse"
      3="Less than a month after your first intercourse"
      4="One to three months after first intercourse"
      5="Four to twelve months after first intercourse"
      6="More than twelve months after first intercourse"
      8="Refused"
      9="Don't know" ;
   value FMARIT
      0="DON'T KNOW/REFUSED"
      1="MARRIED"
      2="WIDOWED"
      3="DIVORCED"
      4="SEPARATED"
      5="NEVER MARRIED" ;
   value FMARITAL
      1="MARRIED TO A PERSON OF THE OPPOSITE SEX"
      2="WIDOWED"
      3="DIVORCED OR ANNULLED"
      4="SEPARATED"
      5="NEVER MARRIED" ;
   value FMARNO
      0="NEVER BEEN MARRIED"
      1="1 TIME"
      2="2 TIMES"
      3="3 TIMES" ;
   value FMARSTAT
      3="Widowed"
      4="Divorced or annulled"
      5="Separated, because you and your spouse are not getting along"
      6="Never been married"
      8="Refused"
      9="Don't know" ;
   value FMEDREASF
      1="Medical problems with your female organs"
      2="Pregnancy would be dangerous to your health"
      3="You would probably lose a pregnancy"
      4="You would probably have an unhealthy child"
      5="Some other medical reason"
      6="No medical reason for operation"
      8="Refused"
      9="Don't know" ;
   value FMETHODF
      1="Pill"
      2="Condom"
      3="Partner's vasectomy"
      4="Female sterilizing operation/tubal ligation"
      5="Withdrawal"
      6="Depo-Provera, injectables"
      7="Hormonal implant (Norplant, Implanon, or Nexplanon)"
      8="Calendar rhythm, Standard Days, or Cycle Beads method"
      9="Safe period by temperature or cervical mucus test (Two Day, Billings Ovulation, or Sympto-thermal Method)"
      10="Diaphragm"
      11="Female condom, vaginal pouch"
      12="Foam"
      13="Jelly or cream"
      15="Suppository, insert"
      16="Todaytm sponge"
      17="IUD, coil, loop"
      18="Emergency contraception"
      19="Other method"
      20="Respondent sterile (aside from sterilizing operation above)"
      22="Lunelle injectable"
      23="Contraceptive patch"
      24="Contraceptive ring" ;
   value FMINCDK1F
      1="Less than $50,000"
      5="$50,000 or more"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value FMT15F
      1="Less than 15 years"
      2="15 years or older"
      8="Refused"
      9="Don't know" ;
   value FMT18F
      1="Less than 18 years"
      2="18 years or older"
      8="Refused"
      9="Don't know" ;
   value FMT20F
      1="Less than 20 years"
      2="20 years or older"
      8="Refused"
      9="Don't know" ;
   value FPDUR
      997="Only had sex once with first partner" ;
   value FPRELAGEF
      1="Older"
      2="Younger"
      3="Same age"
      8="Refused"
      9="Don't know" ;
   value FPRELYRS
      1="1-2 years"
      2="3-5 years"
      3="6-10 years"
      4="More than 10 years"
      8="Refused"
      9="Don't know" ;
   value FPT12MOS
      1="Full-time"
      2="Part-time"
      3="Some of each"
      8="Refused"
      9="Don't know" ;
   value FPTIT
      1="TITLE X CLINIC"
      2="NON-TITLE X CLINIC" ;
   value FPTITHIV
      1="Clinic: Title X=yes; health department=yes"
      2="Clinic: Title X=yes; health department=no"
      3="Clinic: Title X=no; health department=yes"
      4="Clinic: Title X=no; health department=no"
      5="Clinic: Title X=yes; agency unknown"
      6="Clinic: Title X=no; agency unknown"
      7="Employer or company clinic/worksite"
      8="Private Doctor's office or HMO"
      9="Hospital emergency room/regular room/urgent care"
      10="Home"
      11="Military site"
      12="Lab or blood bank"
      13="Some other place" ;
   value FSEXREL
      1="Married to him"
      2="Engaged to him"
      3="Living together in a sexual relationship, but not engaged"
      4="Going with him or going steady"
      5="Going out with him once in a while"
      6="Just friends"
      7="Had just met him"
      8="Something else"
      98="Refused"
      99="Don't know" ;
   value FSTSERVF
      1="A method of birth control or prescription for a method"
      2="A check-up or medical test related to using a birth control method"
      3="Counseling or information about birth control"
      4="Counseling or information about getting sterilized"
      5="Emergency contraception or a prescription for EC"
      6="Counseling or information about Emergency contraception?"
      7="[EMPTY/A sterilizing operation]"
      8="Refused"
      9="Don't know" ;
   value FUNDAMF
      1="A born again Christian"
      2="A charismatic"
      3="An evangelical"
      4="A fundamentalist"
      5="None of the above"
      8="Refused"
      9="Don't know" ;
   value GENHEALT
      1="Excellent"
      2="Very good"
      3="Good"
      4="Fair"
      5="Poor"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value GRFSTSX
      1="1st grade"
      2="2nd grade"
      3="3rd grade"
      4="4th grade"
      5="5th grade"
      6="6th grade"
      7="7th grade"
      8="8th grade"
      9="9th grade"
      10="10th grade"
      11="11th grade"
      12="12th grade"
      13="1st year of college"
      14="2nd year of college"
      15="3rd year of college"
      16="4th year of college"
      96="Not in school"
      98="Refused"
      99="Don't know" ;
   value HADSEX
      1="YES, R EVER HAD INTERCOURSE"
      2="NO, R NEVER HAD INTERCOURSE" ;
   value HHADALL
      1="Yes"
      5="No"
      6="If volunteered: R was not in a relationship with a man at the time she had this operation"
      8="Refused"
      9="Don't know" ;
   value HHFAMTYP
      1="No spouse/partner and no child(ren) (of R) 18 or younger"
      2="Spouse/partner, but no child(ren) (of R) 18 or younger"
      3="Spouse and R's child(ren) 18 or younger"
      4="Cohabiting partner and R's child(ren) 18 or younger"
      5="No spouse/partner, but child(ren) of R, 18 or younger" ;
   value HHKIDTYP
      0="No child(ren) 18 or younger in HH or only older child(ren)"
      1="At least one biological child (of R's) under 18 in HH, no nonbiological child(ren)"
      2="Any non-biological child (of R's) 18 or younger in HH" ;
   value HHPARTYP
      1="Both biological or both adoptive parents"
      2="Biological and step- or adoptive parent"
      3="Single parent (biological, adoptive, or stepparent)"
      4="Other" ;
   value HIEDUC
      5="9TH GRADE OR LESS"
      6="10TH GRADE"
      7="11TH GRADE"
      8="12TH GRADE, NO DIPLOMA (NOR GED)"
      9="HIGH SCHOOL GRADUATE (DIPLOMA OR GED)"
      10="SOME COLLEGE BUT NO DEGREE"
      11="ASSOCIATE DEGREE IN COLLEGE/UNIVERSITY"
      12="BACHELOR'S DEGREE"
      13="MASTER'S DEGREE"
      14="DOCTORATE DEGREE"
      15="PROFESSIONAL DEGREE" ;
   value HIGRADE
      9="9th grade or less"
      10="10th grade"
      11="11th grade"
      12="12th grade"
      13="1 year of college or less"
      14="2 years of college"
      15="3 years of college"
      16="4 years of college/grad school"
      17="5 years of college/grad school"
      18="6 years of college/grad school"
      19="7 or more years of college and/or grad school"
      98="Refused"
      99="Don't know" ;
   value HISCHGRD
      1="1st grade"
      2="2nd grade"
      3="3rd grade"
      4="4th grade"
      5="5th grade"
      6="6th grade"
      7="7th grade"
      8="8th grade"
      9="9th grade"
      10="10th grade"
      11="11th grade"
      12="12th grade"
      98="Refused"
      99="Don't know" ;
   value HISPANIC
      1="HISPANIC"
      2="NON-HISPANIC" ;
   value HISPGRPF
      1="Mexican, Mexican American, or Chicana, only"
      2="All other Hispanic or Latina groups, including multiple responses"
      8="Refused"
      9="Don't know" ;
   value HISPRACE
      1="Hispanic"
      2="Non-Hispanic White"
      3="Non-Hispanic Black"
      4="Non-Hispanic Other" ;
   value HISPRACE2F
      1="Hispanic"
      2="Non-Hispanic White, Single Race"
      3="Non-Hispanic Black, Single Race"
      4="Non-Hispanic Other or Multiple Race" ;
   value HIVTST
      1="Part of medical checkup or surgical procedure (a doctor or medical provider asked for the test)"
      2="Required for health or life insurance coverage"
      3="Required for marriage license or to get married"
      4="Required for military service or a job"
      5="You wanted to find out if infected or not (you were the one who asked for the test)"
      6="Someone else suggested you should be tested (followed by WHOSUGG question)"
      7="Intentionally blank (a code used only for females, prenatal testing)"
      8="You might have been exposed through sex or drug use"
      9="You might have been exposed in some other way"
      20="Some other reason - not shown separately"
      21="Required for immigration or travel"
      22="Required for incarceration"
      23="Required for school"
      98="Refused"
      99="Don't know" ;
   value HMOTHMEN
      1="1 MAN"
      2="2 MEN"
      98="Refused"
      99="Don't know" ;
   value HOWMANYR
      1="One"
      2="More than one"
      8="Refused"
      9="Don't know" ;
   value HOWMUCHF
      1="1-2 years"
      2="3-5 years"
      3="6-10 years"
      4="More than 10 years"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value HOWPRGF
      98="Refused"
      99="Don't know" ;
   value HOWPRGWM
      1="Weeks"
      2="Months"
      8="Refused"
      9="Don't know" ;
   value HPLOCALE
      1="In household"
      2="Lives elsewhere"
      8="Refused"
      9="Don't know" ;
   value HPPREGQ
      1="Yes"
      5="No"
      6="(If volunteered:) no current partner"
      8="Refused"
      9="Don't know" ;
   value HPVSEX1F
      1="First intercourse"
      5="First HPV vaccine shot"
      8="Refused"
      9="Don't know" ;
   value HRACED
      1="Hispanic"
      2="Non-Hispanic White"
      3="Non-Hispanic Black"
      4="Non-Hispanic Other"
      5="NA/DK/RF" ;
   value IDCLINIC
      0="0"
      1="1"
      2="2"
      3="3"
      4="4"
      5="5"
      6="6"
      7="7"
      8="8"
      9="9"
      10="10"
      11="11"
      12="12" ;
   value IMPFLG
      0="QUESTIONNAIRE DATA (NOT IMPUTED)"
      1="MULTIPLE REGRESSION IMPUTATION"
      2="LOGICAL IMPUTATION" ;
   value INCHES
      60="60 inches or less"
      61="61 inches"
      62="62 inches"
      63="63 inches"
      64="64 inches"
      65="65 inches"
      66="66 inches"
      67="67 inches"
      68="68 inches"
      69="69 inches or more"
      96="Could not be defined" ;
   value INCWMYF
      1="Week"
      2="Month"
      3="Year"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value INFERT
      1="SURGICALLY STERILE"
      2="INFERTILE"
      3="FECUND" ;
   value INFRTPRBF
      1="Problems with ovulation"
      2="Blocked tubes"
      3="Other tube or pelvic problems"
      4="Endometriosis"
      5="Semen or sperm problems"
      6="Any other infertility problems"
      7="None of these problems"
      8="Refused"
      9="Don't know" ;
   value INTACT18F
      1="Yes"
      2="No"
      8="Refused"
      9="Don't know" ;
   value INTCTFAM
      1="TWO BIOLOGICAL OR ADOPTIVE PARENTS FROM BIRTH"
      2="ANYTHING OTHER THAN 2 BIOLOGICAL OR ADOPTIVE PARENTS FROM BIRTH" ;
   value INTENT
      1="R INTENDS TO HAVE (MORE) CHILDREN"
      2="R DOES NOT INTEND TO HAVE (MORE) CHILDREN"
      3="R DOES NOT KNOW HER INTENT" ;
   value INTEXPF
      0="NONE"
      1="1 CHILD"
      2="2 CHILDREN"
      3="3 CHILDREN"
      98="Refused"
      99="Don't know" ;
   value INTNEXT
      1="Within the next 2 years"
      2="2-5 years from now"
      3="More than 5 years from now"
      8="Refused"
      9="Don't know" ;
   value INTOFTF
      1="Every year"
      2="Every 2 years"
      3="Every 3 years"
      4="Every 4 years"
      7="Every 5 years"
      8="Less often than every 5 years"
      95="If R volunteers: More than once a year"
      96="If R volunteers: She would never need to be tested"
      98="Refused"
      99="Don't know" ;
   value IUDTYPE
      1="Copper-bearing (such as Copper-T or ParaGard)"
      2="Hormonal IUD (such as Mirena or Skyla)"
      3="Other"
      8="Refused"
      9="Don't know" ;
   value JEXPECTS
      0="NONE"
      1="1 CHILD"
      98="Refused"
      99="Don't know" ;
   value KID18BF
      0="NONE"
      98="Refused"
      99="Don't know" ;
   value KID1PLUS
      0="NONE"
      98="Refused"
      99="Don't know" ;
   value KNDMDHLPF
      1="A method of birth control (or prescription)"
      2="Birth control counseling"
      3="Emergency contraception"
      4="Counseling about Emergency Contraception"
      5="A check-up or test for birth control"
      6="A pregnancy test"
      7="An abortion"
      8="A Pap smear or pelvic exam"
      9="Post-pregnancy care"
      10="STD or HIV testing/treatment/counseling"
      20="Other"
      98="Refused"
      99="Don't know" ;
   value LABORFOR
      1="Working full-time"
      2="Working part-time"
      3="Working, but on vacation, strike, or had temporary illness"
      4="Working - maternity or family leave"
      5="Not working but looking for work"
      6="In school"
      7="Keeping house"
      8="Caring for family"
      9="Other" ;
   value LASTHPV
      1="A year ago or less"
      2="More than 1 year ago but not more than 2 years"
      3="More than 2 years ago but not more than 3 years"
      4="More than 3 years ago but not more than 5 years"
      5="Over 5 years ago"
      8="Refused"
      9="Don't know" ;
   value LASTPAP
      1="A year ago or less"
      2="More than 1 year ago but not more than 2 years"
      3="More than 2 years ago but not more than 3 years"
      4="More than 3 years ago but not more than 5 years"
      5="Over 5 years ago"
      6="Never had Pap test"
      8="Refused"
      9="Don't know" ;
   value LASTPEL
      1="A year ago or less"
      2="More than 1 year ago but not more than 2 years"
      3="More than 2 years ago but not more than 3 years"
      4="More than 3 years ago but not more than 5 years"
      5="Over 5 years ago"
      6="Never had pelvic exam"
      8="Refused"
      9="Don't know" ;
   value LBPREGS
      0="NONE"
      1="1 PREGNANCY"
      2="2 PREGNANCIES"
      3="3 PREGNANCIES" ;
   value LIFEPRT
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      4="4 PARTNERS"
      5="5 PARTNERS"
      6="6 PARTNERS"
      7="7 PARTNERS"
      8="8 PARTNERS"
      9="9 PARTNERS"
      50="50 OR MORE PARTNERS"
      998="Refused"
      999="Don't know" ;
   value LIFEPRTS
      0="NONE"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      4="4 PARTNERS"
      5="5 PARTNERS"
      6="6 PARTNERS"
      7="7 PARTNERS"
      8="8 PARTNERS"
      9="9 PARTNERS"
      50="50 OR MORE PARTNERS"
      98="Refused"
      99="Don't know" ;
   value LIFPRTNR
      0="NONE"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      4="4 PARTNERS"
      5="5 PARTNERS"
      6="6 PARTNERS"
      7="7 PARTNERS"
      8="8 PARTNERS"
      9="9 PARTNERS"
      50="50 OR MORE PARTNERS" ;
   value LIVCHLDR
      1="Child lives with R"
      2="Child is dead"
      3="Child lives with adoptive parents/family"
      4="Child lives with biological father"
      5="Child lives with other relatives"
      6="Child's living arrangements are other or unknown" ;
   value LKNLK1FMT
      1="Very likely"
      2="Somewhat likely"
      3="Not very likely"
      4="Not at all likely"
      8="Refused"
      9="Don't know" ;
   value LKNLK2FMT
      1="Very likely"
      2="Somewhat likely"
      3="Not too likely"
      4="Not likely at all"
      8="Refused"
      9="Don't know" ;
   value LSEXPAGE
      997="Not ascertained" ;
   value LSTGRADE
      0="No formal schooling"
      9="9TH GRADE"
      10="10TH GRADE"
      11="11TH GRADE"
      12="12TH GRADE"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value LSTSEXFPF
      13="Winter"
      14="Spring"
      15="Summer"
      16="Fall"
      96="Only had sex once"
      98="Refused"
      99="Don't know" ;
   value LVSIT14F
      1="Biological mother or adoptive mother"
      2="Other mother figure"
      3="No mother figure"
      8="Refused"
      9="Don't know" ;
   value LVSIT14M
      1="Biological father or adoptive father"
      2="Step-father"
      3="No father figure"
      4="Other father figure"
      8="Refused"
      9="Don't know" ;
   value MAINNOUSE
      1="You do not expect to have sex"
      2="You do not think you can get pregnant"
      3="You don't really mind if you get pregnant"
      4="You are worried about the side effects of birth control"
      5="Your male partner does not want you to use a birth control method"
      6="Your male partner himself does not want to use a birth control method"
      7="(IF VOLUNTEERED:)Respondent is using a method"
      8="You could not get a method"
      9="You are not taking, or using, your method consistently"
      98="Refused"
      99="Don't know" ;
   value MALFEMF
      1="Male"
      2="Female"
      8="Refused"
      9="Don't know" ;
   value MALFEMNAF
      1="Male"
      2="Female"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value MANRASDU
      1="Biological father"
      2="Step-father"
      3="No father figure"
      4="Other father figure"
      8="Refused"
      9="Don't know" ;
   value MANRELF
      1="HUSBAND"
      2="MALE COHABITING PARTNER"
      8="Refused"
      9="Don't know" ;
   value MAR1BIRF
      0="LESS THAN 1 MONTH"
      888="FIRST BIRTH OCCURRED BEFORE FIRST MARRIAGE" ;
   value MAR1CONF
      0="LESS THAN 1 MONTH"
      995="FIRST CONCEPTION BEFORE FIRST MARRIAGE"
      996="HAS BEEN PREGNANT, BUT HAS NEVER BEEN MARRIED" ;
   value MARENDF
      1="DIVORCED OR ANNULLED"
      2="SEPARATED"
      3="WIDOWED" ;
   value MARENDHX
      1="Death of husband"
      2="Divorce"
      3="Annulment"
      8="Refused"
      9="Don't know" ;
   value MARPRGF
      1="Married"
      2="Divorced"
      3="Widowed"
      4="Separated"
      5="Never married" ;
   value MARSTAT
      1="Married to a person of the opposite sex"
      2="Not married but living together with a partner of the opposite sex"
      3="Widowed"
      4="Divorced or annulled"
      5="Separated, because you and your spouse are not getting along"
      6="Never been married"
      8="Refused"
      9="Don't know" ;
   value MAYBPREG
      1="Probably pregnant"
      5="Probably not pregnant"
      8="Refused"
      9="Don't know" ;
   value MC1SIMSQ
      1="Same time"
      2="Different times"
      8="Refused"
      9="Don't know" ;
   value MCMONS
      995="R reported a month and year instead"
      998="Refused"
      999="Don't know" ;
   value MDDEGRE
      1="Less than high school"
      2="High school graduate or GED"
      3="Some college, including 2-year degrees"
      4="Bachelor's degree or higher"
      8="Refused"
      9="Don't know" ;
   value MEDREASF
      1="Pregnancy would be dangerous to your health"
      2="You would probably lose a pregnancy"
      3="You would probably have an unhealthy child"
      4="He had health problem that required the operation"
      5="Some other medical reason"
      6="No medical reason for operation"
      8="Refused"
      9="Don't know" ;
   value MENARCHE
      10="10 YEARS"
      11="11 YEARS"
      12="12 YEARS"
      13="13 YEARS"
      14="14 YEARS"
      96="PERIODS HAVE NOT YET BEGUN"
      98="Refused"
      99="Don't know" ;
   value METH12MF
      1="Pill"
      2="Condom"
      3="Partner's vasectomy"
      4="Female sterilizing operation/tubal ligation"
      5="Withdrawal"
      6="Depo-Provera injectable"
      7="Implant (Norplant, Implanon, or Nexplanon)"
      8="Calendar rhythm, Standard Days, or Cycle Beads method"
      9="Safe period by temperature or cervical mucus test (Two Day, Billings Ovulation, or Sympto-thermal Method)"
      10="Diaphragm"
      11="Female condom, vaginal pouch"
      12="Foam"
      13="Jelly or cream"
      14="Cervical cap"
      15="Suppository, insert"
      16="Today sponge"
      17="IUD, coil, loop"
      18="Emergency contraception"
      19="Other method"
      20="Respondent sterile (aside from sterilizing operation above)"
      21="Respondent's partner sterile (aside from vasectomy above)"
      22="Lunelle injectable"
      23="Contraceptive patch"
      24="Contraceptive ring" ;
   value METH3MF
      1="Pill"
      2="Condom"
      3="Partner's vasectomy"
      4="Female sterilizing operation/tubal ligation"
      5="Withdrawal"
      6="Depo-Provera, injectables"
      7="Implant (Norplant, Implanon, or Nexplanon)"
      8="Calendar rhythm, Standard Days, or Cycle Beads method"
      9="Safe period by temperature or cervical mucus test (Two Day, Billings Ovulation, or Sympto-thermal Method)"
      10="Diaphragm"
      11="Female condom, vaginal pouch"
      12="Foam"
      13="Jelly or cream"
      14="Cervical cap"
      15="Suppository, insert"
      16="Today sponge"
      17="IUD, coil, loop"
      18="Emergency contraception"
      19="Other method"
      20="Respondent sterile (aside from sterilizing operation above)"
      21="Respondent's partner sterile (aside from vasectomy above)"
      22="Lunelle injectable"
      23="Contraceptive patch"
      24="Contraceptive ring" ;
   value METHHXF
      1="No method used"
      2="EMPTY (IF JAN)/Same as previous month"
      3="Birth control pills"
      4="Condom"
      5="Partner's vasectomy"
      6="Female sterilizing operation, such as tubal sterilization and hysterectomy"
      7="Withdrawal, pulling out"
      8="Depo-Provera, injectables"
      9="Hormonal implant (Norplant, Implanon, or Nexplanon)"
      10="Calendar rhythm, Standard Days, or Cycle Beads method"
      11="Safe period by temperature or cervical mucus test (Two Day, Billings Ovulation, or Sympto-thermal Method)"
      12="Diaphragm"
      13="Female condom, vaginal pouch"
      14="Foam"
      15="Jelly or cream"
      16="Cervical cap"
      17="Suppository, insert"
      18="Today sponge"
      19="IUD, coil, or loop"
      20="Emergency contraception"
      21="Other method -- specify"
      22="Respondent was sterile"
      23="Respondent's partner was sterile"
      25="Contraceptive patch"
      26="Vaginal contraceptive ring"
      55="EMPTY (IF JAN)/Same method used thru end of year"
      98="Refused"
      99="Don't know" ;
   value METHPRSF
      0="1st meth was nonprescription"
      1="1st meth was prescription" ;
   value METHSTOPF
      3="Birth control pills"
      4="Condom"
      5="Partner's vasectomy"
      6="Female sterilizing operation, such as tubal sterilization and hysterectomy"
      7="Withdrawal, pulling out"
      8="Depo-Provera, injectables (shots)"
      9="Hormonal implant (Norplant, Implanon, or Nexplanon)"
      10="Calendar rhythm, Standard Days, or Cycle Beads method"
      11="Safe period by temperature or cervical mucus test (Two Day, Billings Ovulation, or Sympto-thermal Method)"
      12="Diaphragm"
      13="Female condom, vaginal pouch"
      14="Foam"
      15="Jelly or cream"
      16="Cervical cap"
      17="Suppository, insert"
      18="Today sponge"
      19="IUD, coil, or loop"
      21="Other method"
      24="Lunelle injectable (monthly shot)"
      25="Contraceptive patch"
      26="Vaginal contraceptive ring"
      98="Refused"
      99="Don't know" ;
   value METHYNF
      1="Used in past 12 months"
      5="Not used in past 12 mos or dk/rf"
      8="Refused"
      9="Don't know" ;
   value METRO
      1="PRINCIPAL CITY OF MSA"
      2="OTHER MSA"
      3="NOT MSA" ;
   value MINCDNF
      1="You had all the children you wanted"
      2="Your husband or partner had all the children he wanted"
      3="Medical reasons"
      4="Problems with other methods of birth control"
      5="Some other reason not mentioned above"
      8="Refused"
      9="Don't know" ;
   value MISSPILL
      1="Never missed"
      2="Missed only one"
      3="Missed two or more"
      4="Did not use pill over past 4 weeks"
      8="Refused"
      9="Don't know" ;
   value MNTHFMT
      13="Winter"
      14="Spring"
      15="Summer"
      16="Fall"
      98="Refused"
      99="Don't know" ;
   value MNYFSTER
      1="1 setting or location"
      2="2 settings or locations"
      3="3 settings or locations"
      98="Refused"
      99="Don't know" ;
   value MOM18F
      1="Under 18"
      2="18-19"
      3="20-24"
      4="25 or older"
      8="Refused"
      9="Don't know" ;
   value MOMFSTCH
      1="LESS THAN 18 YEARS"
      2="18-19 YEARS"
      3="20-24 YEARS"
      4="25-29 YEARS"
      5="30 OR OLDER"
      96="MOTHER OR MOTHER-FIGURE DID NOT HAVE ANY CHILDREN"
      98="Refused"
      99="Don't know" ;
   value MOMWORKD
      1="Full-time"
      2="Part-time"
      3="Equal amounts full-time and part-time"
      4="Not at all (for pay)"
      8="Refused"
      9="Don't know" ;
   value MON12PRT
      0="NONE"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      998="Refused"
      999="Don't know" ;
   value MOSPRGF
      98="Refused"
      99="Don't know" ;
   value MREASFMT
      1="Part of a routine exam"
      2="Because of a medical problem"
      3="Other reason"
      8="Refused"
      9="Don't know" ;
   value MTCHMANF
      1="Your first former husband, [NAME], married [DATE], marriage ended [DATE]"
      2="Your second former husband, [NAME], married [DATE], marriage ended [DATE]"
      3="Your third former husband, [NAME], married [DATE], marriage ended [DATE]"
      4="Your fourth former husband, [NAME], married [DATE], marriage ended [DATE]"
      5="Your fifth former husband, [NAME], married [DATE], marriage ended [DATE]"
      6="Your sixth former husband, [NAME], married [DATE], marriage ended [DATE]"
      7="Your current husband, [NAME], married [DATE], still married or (Your husband, from whom you are separated, married [DATE], still married"
      8="Your current partner, [NAME], began living together [DATE], still living together"
      9="Your first former partner [NAME], began living together [DATE], stopped living together [DATE]"
      10="Your second cohabiting partner, [NAME], began living together [DATE], stopped living together [DATE]"
      11="Your third cohabiting partner, [NAME], began living together [DATE], stopped living together [DATE]"
      12="Your fourth cohabiting partner, [NAME], began living together [DATE], stopped living together [DATE]"
      20="None of the Above"
      98="Refused"
      99="Don't know" ;
   value MTHUSE12F
      1="USED A METHOD"
      2="DID NOT USE A METHOD"
      95="NEVER USED A METHOD" ;
   value MTHUSE3F
      1="USED A METHOD AT LAST INTERCOURSE IN PAST 3 MONTHS"
      2="DID NOT USE A METHOD AT LAST INTERCOURSE IN PAST 3 MONTHS"
      95="NEVER USED A METHOD" ;
   value MULTRACED
      1="Yes, multiple races reported"
      2="No, multiple races not reported"
      3="NA/DK/RF" ;
   value N0Y1F
      0="No"
      1="Yes" ;
   value NCHILDHH
      0="No children of respondent age 18 or younger in the household"
      1="1 of respondent's children 18 or younger in the household"
      2="2 of respondent's children 18 or younger in the household"
      3="3 or more of respondent's children 18 or younger in the household" ;
   value NEWMETHF
      1="Abstinence"
      2="Tubal ligation/female sterilization"
      3="Vaginal contraceptive film"
      4="Other method, not shown separately"
      5="Response was coded as a method in EA-1 through EA-14"
      8="Refused"
      9="Don't know" ;
   value NNONMONOG1F
      1="1 partner"
      2="2 or more partners"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value NNONMONOG2F
      1="1 other partner besides you"
      2="2 other partners besides you"
      3="3 or more other partners besides you"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value NOCHCHF
      1="No chance"
      2="A little chance"
      3="50-50 chance"
      4="A pretty good chance"
      5="An almost certain chance"
      8="Refused"
      9="Don't know" ;
   value NOHIVTST
      1="You have never been offered an HIV test"
      2="You are worried about what other people would think if you got tested for HIV"
      3="It's unlikely you've been exposed to HIV"
      4="You were afraid to find out if you were HIV positive (that you had HIV)"
      5="You don't like needles"
      20="Some other reason"
      21="R reported spouse or partner tested negative"
      22="Never had sexual intercourse"
      23="No health insurance or coverage, or R couldn't afford an HIV test"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value NOSEX12F
      0="NONE"
      1="1 MONTH"
      2="2 MONTHS"
      3="3 MONTHS"
      4="4 MONTHS"
      5="5 MONTHS"
      6="6 MONTHS"
      7="7 MONTHS"
      8="8 MONTHS"
      9="9 MONTHS"
      10="10 MONTHS"
      11="11 MONTHS"
      12="12 MONTHS"
      95="NEVER HAD INTERCOURSE" ;
   value NOSEX36F
      1="No, no months of non-intercourse -- intercourse in all months"
      2="Yes, one or more months of non-intercourse" ;
   value NOWCOVERF
      1="Private health insurance plan (from employer or workplace; purchased directly; through a state or local government program or community program)"
      2="Medicaid-additional name(s) for Medicaid in this state: [MEDICAID_FILL]"
      3="Medicare"
      4="Medi-GAP"
      5="Military health care including: the VA, CHAMPUS, TRICARE, CHAMP-VA"
      6="None, Indian Health Service, or Single Service Plan"
      7="CHIP"
      8="State-sponsored health plan"
      9="Other government health care"
      98="Refused"
      99="Don't know" ;
   value NOWPRGDK
      1="First trimester"
      2="Second trimester"
      3="Third trimester"
      8="Refused"
      9="Don't know" ;
   value NRACED
      1="Hispanic"
      2="Non-Hispanic White, Single Race"
      3="Non-Hispanic Black, Single Race"
      4="Non-Hispanic Other or Multiple Race"
      5="NA/DK/RF" ;
   value NUMBCVIS
      1="Single visit"
      5="More than one visit"
      8="Refused"
      9="Don't know" ;
   value NUMFMHH
      0="NO FAMILY MEMBERS"
      1="1 FAMILY MEMBER"
      2="2 FAMILY MEMBERS"
      3="3 FAMILY MEMBERS"
      4="4 FAMILY MEMBERS"
      5="5 FAMILY MEMBERS"
      6="6 FAMILY MEMBERS"
      7="7 FAMILY MEMBERS OR MORE" ;
   value NUMJOBF
      1="1 job"
      2="2 jobs"
      3="3 jobs"
      4="4 jobs"
      5="5 jobs"
      6="6 jobs"
      8="Refused"
      9="Don't know" ;
   value NUMKDHH
      0="NO CHILDREN"
      1="1 CHILD"
      2="2 CHILDREN"
      3="3 CHILDREN"
      4="4 CHILDREN"
      5="5 CHILDREN OR MORE" ;
   value NUMMTH12A
      0="No methods"
      1="1 method"
      8="Refused"
      9="Don't know" ;
   value NUMNOCOV
      1="1 Month"
      2="2 Months"
      3="3 Months"
      4="4 Months"
      5="5 Months"
      6="6 Months"
      7="7 Months"
      8="8 Months"
      9="9 Months"
      10="10 Months"
      11="11 Months"
      12="12 Months"
      98="Refused"
      99="Don't know" ;
   value NUMP3MOS
      0="NONE"
      1="1 PARTNER" ;
   value NUMPREGF
      0="NONE"
      1="1 PREGNANCY"
      2="2 PREGNANCIES"
      3="3 PREGNANCIES"
      4="4 PREGNANCIES"
      5="5 PREGNANCIES"
      6="6 PREGNANCIES"
      98="Refused"
      99="Don't know" ;
   value NUMRACE
      1="SINGLE RACE REPORTED"
      2="2 OR MORE RACES REPORTED" ;
   value NUMSVC12A
      0="No services"
      1="1 service"
      2="2 services"
      98="Refused"
      99="Don't know" ;
   value NUMVSTPG
      1="1 VISIT"
      2="2 VISITS"
      3="3 VISITS"
      4="4 VISITS"
      98="Refused"
      99="Don't know" ;
   value NWWANTRPF
      1="Later, overdue"
      2="Right time"
      3="Too soon: by less than 2 years"
      4="Too soon: by 2 years or more"
      5="Didn't care, indifferent"
      6="Unwanted"
      7="Don't know, not sure" ;
   value OKBORNUS
      1="United States"
      5="Another country"
      8="Refused"
      9="Don't know" ;
   value OKDISABLF
      1="Physical disability"
      2="Emotional disturbance"
      3="Mental retardation"
      4="None of the above"
      8="Refused"
      9="Don't know" ;
   value ONETWO2F
      1="1"
      98="Refused"
      99="Don't know" ;
   value ONETWOF
      0="0"
      1="1"
      98="Refused"
      99="Don't know" ;
   value ORIENT
      1="Heterosexual or straight"
      2="Homosexual, gay, or lesbian"
      3="Bisexual"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value OTHRMETHF
      9="Hormonal implant (Norplant, Implanon, or Nexplanon)"
      12="Diaphragm"
      13="Female condom, vaginal pouch"
      14="Foam"
      15="Jelly or cream"
      16="Cervical cap"
      17="Suppository, insert"
      18="Today sponge"
      19="IUD, coil, or loop"
      21="Other method -- specify"
      24="Lunelle"
      95="No other methods ever used"
      98="Refused"
      99="Don't know" ;
   value OTMEDHEPF
      1="Surgery or drug treatment for endometriosis"
      2="In vitro fertilization (IVF)"
      3="Surgery or drug treatment for uterine fibroids"
      4="Some other female pelvic surgery"
      5="Other medical help"
      8="Refused"
      9="Don't know" ;
   value OUTCOMRF
      1="LIVE BIRTH"
      2="INDUCED ABORTION"
      3="STILLBIRTH"
      4="MISCARRIAGE"
      5="ECTOPIC PREGNANCY"
      6="CURRENT PREGNANCY" ;
   value OWWNTF
      1="LATER, OVERDUE"
      2="RIGHT TIME"
      3="TOO SOON, MISTIMED"
      4="DIDN'T CARE, INDIFFERENT"
      5="UNWANTED"
      6="DON'T KNOW, NOT SURE" ;
   value P_ASTYP
      1="Public assist prog, e.g. AFDC or ADC"
      2="General/Emergency/Other assistance"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value P12METHF
      1="Every time"
      2="Most of the time"
      3="About half of the time"
      4="Some of the time"
      5="None of the time"
      8="Refused"
      9="Don't know" ;
   value P12MOCON
      1="Every time"
      2="Most of the time"
      3="About half of the time"
      4="Some of the time"
      5="None of the time"
      8="Refused"
      9="Don't know" ;
   value P1YFSEXF
      13="Winter"
      14="Spring"
      15="Summer"
      16="Fall"
      96="Only had sex once with this partner"
      98="Refused"
      99="Don't know" ;
   value P1YHSAGE
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value P1YRAGE
      98="Refused"
      99="Don't know" ;
   value P1YRELP
      1="First former husband"
      2="Second former husband"
      3="Third former husband"
      4="Fourth former husband"
      5="Fifth former husband"
      6="Sixth former husband"
      7="Current husband or (current husband from whom she is separated)"
      8="Current cohabiting partner"
      9="First former cohabiting partner"
      10="Second former cohabiting partner"
      11="Third former cohabiting partner"
      12="Fourth former cohabiting partner"
      13="First sexual partner"
      20="None of the above"
      98="Refused"
      99="Don't know" ;
   value PARAGEF
      1="R LIVED WITH BOTH BIOLOGICAL OR BOTH ADOPTIVE PARENTS AT AGE 14"
      2="R LIVED WITH BIOLOGICAL MOTHER AND STEPFATHER AT AGE 14"
      3="R LIVED IN ANY OTHER PARENTAL SITUATION OR A NONPARENTAL SITUATION AT AGE 14" ;
   value PARITY
      0="0 BABIES"
      1="1 BABY"
      2="2 BABIES"
      3="3 BABIES"
      4="4 BABIES" ;
   value PARTDURF
      997="Only had sex once with partner" ;
   value PARTLIF
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      4="4 PARTNERS"
      5="5 PARTNERS"
      6="6 PARTNERS"
      7="7 PARTNERS"
      8="8 PARTNERS"
      9="9 PARTNERS"
      10="10 PARTNERS"
      50="50 OR MORE PARTNERS"
      997="Not ascertained"
      998="Refused"
      999="Don't know" ;
   value PARTS12F
      0="NONE"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      9997="Not ascertained"
      9998="Refused"
      9999="Don't know" ;
   value PARTS1YR
      0="NONE"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      4="4 PARTNERS"
      5="5 PARTNERS"
      6="6 PARTNERS" ;
   value PAYFMT
      1="Insurance"
      2="Co-payment"
      3="Out-of-pocket payment"
      4="Medicaid"
      5="No payment required"
      6="Some other way"
      8="Refused"
      9="Don't know" ;
   value PIDTX
      1="1 TIME"
      98="Refused"
      99="Don't know" ;
   value PLACE1FMT
      1="Private doctor's office"
      2="HMO facility"
      3="Community health clinic, community clinic, public health clinic"
      4="Family planning or Planned Parenthood clinic"
      5="Employer or company clinic"
      6="School or school-based clinic"
      7="Hospital outpatient clinic"
      8="Hospital emergency room"
      9="Hospital regular room"
      10="Urgent care center, urgi-care, or walk-in facility"
      11="Friend"
      12="Partner or spouse"
      13="Drug store"
      14="Mail order/Internet"
      20="Some other place"
      98="Refused"
      99="Don't know" ;
   value PLCHIV
      1="Private doctor's office"
      2="HMO facility"
      3="Community health clinic, community clinic, public health clinic"
      4="Family planning or Planned Parenthood clinic"
      5="Employer or company clinic"
      6="School or school-based clinic (including college or university)"
      7="Hospital outpatient clinic"
      8="Hospital emergency room"
      9="Hospital regular room"
      10="Urgent care center, urgi-care, or walk-in facility"
      11="Your worksite"
      12="Your home"
      13="Military induction or military service site"
      14="Sexually transmitted disease (STD) clinic"
      15="Laboratory or blood bank"
      20="Some other place -- specify"
      21="Prison or jail"
      22="Mobile testing or community testing site"
      23="Drug, alcohol, or rehabilitation center"
      98="Refused"
      99="Don't know" ;
   value PLCOPF
      1="Private doctor's office"
      2="HMO facility"
      3="Community health clinic, community clinic, or public health clinic"
      4="Family planning or Planned Parenthood clinic"
      5="Employer or company clinic"
      6="School or school-based"
      7="Hospital outpatient clinic"
      8="Hospital emergency room"
      9="Hospital regular room"
      10="Urgent care center, urgi-care or walk-in facility"
      20="Some other place"
      98="Refused"
      99="Don't know" ;
   value PLIFPRTNR
      0="NONE"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      4="4 PARTNERS"
      5="5 PARTNERS"
      6="6 PARTNERS"
      7="7 PARTNERS"
      8="8 PARTNERS"
      9="9 PARTNERS"
      50="50 OR MORE PARTNERS"
      998="Refused"
      999="Don't know" ;
   value POTFRF
      1="Never"
      2="Once or twice during the year"
      3="Several times during the year"
      4="About once a month"
      5="About once a week"
      6="About once a day or more"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value POVERTY
      500="500 percent of poverty level or greater" ;
   value PRECANCER
      1="Abnormal Pap test result, suspicious for cancer, but no real cancer found"
      2="Pre-cancer (cervical intraepithelial lesion or CIN)"
      3="Cervical cancer"
      8="Refused"
      9="Don't know" ;
   value PREGHIV
      1="Yes"
      5="No"
      6="Never went for prenatal care"
      8="Refused"
      9="Don't know" ;
   value PREGNUMF
      0="NONE"
      1="1 PREGNANCY"
      2="2 PREGNANCIES"
      3="3 PREGNANCIES"
      4="4 PREGNANCIES"
      5="5 PREGNANCIES"
      6="6 PREGNANCIES" ;
   value PREVCOHB
      0="NONE"
      1="1 FORMER COHABITING PARTNER"
      2="2 FORMER COHABITING PARTNER"
      98="Refused"
      99="Don't know" ;
   value PREVHUSB
      0="NONE"
      1="1 FORMER HUSBAND"
      98="Refused"
      99="Don't know" ;
   value PRGVISIT
      0="NO VISITS IN LAST 12 MONTHS"
      1="1 VISIT"
      2="2 VISITS"
      3="3 VISITS"
      4="4 VISITS"
      98="Refused"
      99="Don't know" ;
   value PRIMLANG
      1="English"
      2="Spanish"
      7="Other"
      8="Refused"
      9="Don't know" ;
   value PROBWANT
      1="Probably want"
      2="Probably do not want"
      8="Refused"
      9="Don't know" ;
   value PRT12F
      0="0 PARTNERS"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      997="Not ascertained"
      998="Refused"
      999="Don't know" ;
   value PRTS12MB
      0="0 PARTNERS"
      1="1 PARTNER"
      2="2 PARTNERS"
      3="3 PARTNERS"
      4="4 PARTNERS"
      5="5 PARTNERS"
      6="6 PARTNERS"
      7="7 PARTNERS"
      8="8 PARTNERS"
      9="9 PARTNERS"
      10="10 PARTNERS"
      20="20 OR MORE PARTNERS"
      997="Not ascertained"
      998="Refused"
      999="Don't know" ;
   value PSTWKSF
      998="Refused"
      999="Don't know" ;
   value PUBASSIS
      1="Yes (received public assistance in [INTERVIEW YEAR-1])"
      2="No (did not receive public assistance in [INTERVIEW YEAR-1])" ;
   value R_FOSTER
      1="YES FOSTER"
      3="NO FOSTER, NOT INTACT"
      5="NO FOSTER, INTACT" ;
   value RACE
      1="BLACK"
      2="WHITE"
      3="OTHER" ;
   value RACE13GRF
      4="Black or African American"
      5="White"
      8="Refused"
      9="Don't know" ;
   value RACEFMTD
      1="Black"
      2="White"
      3="Other"
      4="NA/DK/RF" ;
   value RCNTPGHF
      13="Winter"
      14="Spring"
      15="Summer"
      16="Fall"
      96="R only had one visit for help to become pregnant"
      98="Refused"
      99="Don't know" ;
   value RCURPREG
      1="YES (CURRENTLY PREGNANT)"
      2="NO (NOT CURRENTLY PREGNANT)" ;
   value REACTSLF
      1="Very upset"
      2="A little upset"
      3="A little pleased"
      4="Very pleased"
      5="If R insists: She wouldn't care"
      8="Refused"
      9="Don't know" ;
   value REASDIFFF
      1="You have difficulty getting pregnant"
      2="You have difficulty carrying baby to term"
      3="Pregnancy is dangerous to your health"
      4="You are likely to have an unhealthy baby"
      5="Some other reason"
      8="Refused"
      9="Don't know" ;
   value REASMAMF
      1="Part of a routine exam"
      2="Because of a problem or lump"
      3="Because of family or personal history of cancer"
      4="Other reason"
      8="Refused"
      9="Don't know" ;
   value REASMFMT
      1="Too expensive"
      2="Insurance did not cover it"
      3="Too difficult to use"
      4="Too messy"
      5="Your partner did not like it"
      6="You had side effects"
      7="You were worried you might have side effects"
      8="You worried the method would not work"
      9="The method failed, you became pregnant"
      10="The method did not protect against disease"
      11="Because of other health problems, a doctor told you that you should not use the method again"
      12="The method decreased your sexual pleasure"
      13="Too difficult to obtain the method"
      14="Did not like the changes to your menstrual cycle"
      15="Other -- specify"
      98="Refused"
      99="Don't know" ;
   value REASNONOF
      1="Dangerous for you"
      2="Dangerous for your baby"
      3="Some other reason"
      8="Refused"
      9="Don't know" ;
   value REASP
      1="Impossible due to problems with sperm or semen"
      2="Impossible due to testicular problems or varicocele"
      3="Impossible due to other illnesses or treatment for other illnesses"
      4="Impossible for other reasons"
      8="Refused"
      9="Don't know" ;
   value REASR
      1="Impossible due to problems with ovulation"
      2="Impossible due to problems with uterus, cervix, or fallopian tubes"
      3="Impossible due to other illnesses or treatment for other illnesses such as cancer"
      4="Impossible due to menopause"
      20="Impossible for other reasons"
      30="R volunteers it is not impossible for her"
      98="Refused"
      99="Don't know" ;
   value REGCAR12F
      1="Regular place"
      2="Regular place, but go to more than 1 place regularly"
      3="Usually go somewhere else"
      4="No usual place"
      8="Refused"
      9="Don't know" ;
   value RELAGENAF
      1="Older"
      2="Younger"
      3="Same age"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value RELATPF
      1="Married to him"
      2="Engaged to him"
      3="Living together in a sexual relationship, but not engaged"
      4="Going out with him or going steady"
      5="Going out with him once in a while"
      6="Just friends"
      7="Had just met him"
      8="Something else" ;
   value RELCURR
      1="No religion"
      2="Catholic"
      3="Baptist/Southern Baptist"
      4="Methodist, Lutheran, Presbyterian, Episcopal"
      5="Fundamentalist Protestant"
      6="Other Protestant denomination"
      7="Protestant - No specific denomination"
      8="Other religion"
      9="Refused"
      10="Don't know" ;
   value RELDLIFE
      1="Very important"
      2="Somewhat important"
      3="Not important"
      8="Refused"
      9="Don't know" ;
   value RELIGION
      1="NO RELIGION"
      2="CATHOLIC"
      3="PROTESTANT"
      4="OTHER RELIGIONS" ;
   value RELOTHKD
      1="Your husband's child (stepchild)"
      2="The child of a blood relative"
      3="The child of a relative by marriage"
      4="The child of a friend"
      5="Your boyfriend or partner's child"
      6="Related to you in some other way"
      7="Unrelated to you previously in any way"
      8="Refused"
      9="Don't know" ;
   value RELTRAD
      1="Evangelical Prot"
      2="Mainline Prot"
      3="Black Prot"
      4="Catholic"
      5="Other religion"
      6="No religious affiilation"
      8="Refused"
      9="Don't know" ;
   value REPORTF
      1="REPORTED"
      2="NOT REPORTED" ;
   value RETROVIR
      1="Definitely true"
      2="Probably true"
      3="Probably false"
      4="Definitely false"
      5="Don't know if true or false"
      8="Refused"
      9="Don't know" ;
   value RHHIVT2F
      1="I didn't want to get tested by a doctor or at an HIV testing site"
      2="I didn't want other people to know I am getting tested"
      3="I wanted to get tested together with someone, before we had sex"
      4="I wanted to get tested by myself, before having sex"
      5="I wanted to get tested by myself, after having sex"
      6="A sex partner asked me to take a rapid home HIV test"
      20="Other reason"
      98="Refused"
      99="Don't know" ;
   value RISKF
      1="A lot"
      2="A little"
      3="Not at all"
      4="No opinion"
      8="Refused"
      9="Don't know" ;
   value RMARFMT
      1="Married"
      2="Divorced"
      3="Widowed"
      4="Separated"
      5="Cohabiting"
      6="Never married, not cohabiting" ;
   value RMARITAL
      1="CURRENTLY MARRIED TO A PERSON OF THE OPPOSITE SEX"
      2="NOT MARRIED BUT LIVING WITH OPP SEX PARTNER"
      3="WIDOWED"
      4="DIVORCED OR ANNULLED"
      5="SEPARATED FOR REASONS OF MARITAL DISCORD"
      6="NEVER BEEN MARRIED" ;
   value ROSCNT
      1="1 HOUSEHOLD MEMBER"
      2="2 HOUSEHOLD MEMBERS"
      3="3 HOUSEHOLD MEMBERS"
      4="4 HOUSEHOLD MEMBERS"
      5="5 HOUSEHOLD MEMBERS"
      6="6 HOUSEHOLD MEMBERS"
      7="7 HOUSEHOLD MEMBERS"
      8="8 OR MORE HOUSEHOLD MEMBERS"
      98="Refused"
      99="Don't know" ;
   value ROST2TOP
      0="No children"
      1="1 child"
      2="2 or more children" ;
   value ROST4TOP
      0="No children"
      1="1 child"
      2="2 children"
      3="3 children"
      4="4 children or more" ;
   value ROST5TOP
      0="No children"
      1="1 child"
      2="2 children"
      3="3 children"
      4="4 children"
      5="5 or more children" ;
   value RSCRRACE
      4="Black or African American"
      5="White"
      6="Hispanic"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value RSTRSTAT
      0="NOT STERILE"
      1="SURGICALLY STERILE"
      2="NONSURGICALLY STERILE"
      8="Refused"
      9="Don't know" ;
   value RWEIGHT
      110="110 POUNDS OR LESS"
      256="256 POUNDS OR MORE"
      997="Not ascertained"
      998="Refused"
      999="Don't know" ;
   value SAMESEX1F
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value SEEKWHO1F
      1="Current husband/partner"
      5="Another partner"
      8="Refused"
      9="Don't know" ;
   value SEX1FOR
      0="SAME MONTH AS MARRIAGE"
      996="AFTER FIRST MARRIAGE" ;
   value SEX1MTHDF
      1="Pill"
      2="Condom"
      3="Partner's vasectomy"
      4="Female sterilizing operation/tubal ligation"
      5="Withdrawal"
      6="Depo-Provera, injectables"
      7="Implant (Norplant, Implanon, or Nexplanon)"
      8="Calendar rhythm, Standard Days, or Cycle Beads method"
      9="Safe period by temperature or cervical mucus test (Two Day, Billing Ovulation, or Sympto-thermal Method)"
      10="Diaphragm"
      11="Female condom, vaginal pouch"
      12="Foam"
      13="Jelly or cream"
      14="Cervical cap"
      15="Suppository, insert"
      16="Today sponge"
      17="IUD, coil, loop"
      18="Emergency contraception"
      19="Other method"
      20="Respondent sterile (aside from sterilizing operation above)"
      21="Respondent sterile (aside from vasectomy above)"
      22="Lunelle injectable"
      23="Contraceptive patch"
      24="Contraceptive ring"
      95="Never used a method"
      96="Did not use a method at 1st intercourse" ;
   value SEXEVER
      1="YES (R HAS HAD SEX AFTER 1ST PERIOD)"
      2="NO (NO PERIOD, NO SEX AT ALL, OR NO SEX SINCE 1ST PERIOD)" ;
   value SEXMAR
      0="FIRST INTERCOURSE IN SAME MONTH AS MARRIAGE"
      996="FIRST INTERCOURSE AFTER FIRST MARRIAGE" ;
   value SEXONCE
      1="YES (R HAS HAD SEX ONLY ONCE)"
      2="NO (R HAS HAD SEX MORE THAN ONCE)" ;
   value SEXOUT
      1="Intact cohabitation"
      2="Intact marriage"
      3="Dissolved marriage"
      4="Dissolved cohabitation"
      5="Never married or cohabited with 1st sexual partner" ;
   value SEXUNION
      0="First intercourse in same month as marriage or cohabitation"
      996="First intercourse after first marriage or cohabitation" ;
   value SMOKE12F
      1="None"
      2="About one cigarette a day or less"
      3="Just a few cigarettes a day, between 2 to 4 cigarettes"
      4="About half a pack a day, between 5 to 14 cigarettes"
      5="About a pack a day, between 15 to 24 cigarettes"
      6="More than a pack a day, 25 or more cigarettes"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value SON918F
      0="0 SONS"
      1="1 SON"
      2="2 OR MORE SONS" ;
   value SPLSTWKF
      1="Working"
      2="Working - Paternity leave or temp leave"
      3="Not working, looking for work"
      4="Keeping house or taking care of family"
      5="Other"
      8="Refused"
      9="Don't know" ;
   value SRCSRV
      1="CLINIC: TITLE X=YES HEALTH DEPT=YES"
      2="CLINIC: TITLE X=YES HEALTH DEPT=NO"
      3="CLINIC: TITLE X=NO HEALTH DEPT=YES"
      4="CLINIC: TITLE X=NO HEALTH DEPT=NO"
      5="CLINIC: TITLE X=YES AGENCY UNKNOWN"
      6="CLINIC: TITLE X=NO AGENCY UNKNOWN"
      7="EMPLOYER OR COMPANY CLINIC"
      8="PRIVATE DOCTOR'S OFFICE OR HMO"
      9="HOSPITAL EMERGENCY REGULAR ROOM/REGULAR ROOM/URGENT CARE"
      10="SOME OTHER PLACE" ;
   value STOPCONDFMT
      1="Allergy (latex/spermicide)"
      2="Didn't like it / Didn't like how it felt"
      3="Pain/discomfort/irritation"
      4="Yeast infection"
      5="Worried it would fall off / break / not prevent pregnancy"
      6="Inconvenient"
      7="Not spontaneous"
      8="Frustrating to use"
      9="Other (Too few cases, not classifiable elsewhere)"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value STOPDEPOFMT
      1="Weight gain"
      2="Bleeding problems (spotting, too much, irregularly)"
      3="Headaches/migraines"
      4="Mood swings/depression"
      5="Hair loss or growth"
      6="Hormonal problems/changes"
      7="Decreased sex drive"
      8="Skin problems"
      9="Menstrual periods stopped"
      10="Weight loss"
      11="Nausea/sickness"
      12="Don't like shots/needles"
      13="Safety/health concerns, such as bone density loss"
      14="Worried about getting pregnant after use"
      15="Other side effects"
      16="Other (Too few cases, not classifiable elsewhere)"
      98="Refused"
      99="Don't know" ;
   value STOPIUDFMT
      1="Weight gain"
      2="Bleeding problems (spotting, too much, irregularly)"
      3="Headaches/migraines"
      4="Mood swings/depression"
      5="Hair loss or growth"
      6="Vaginal infection"
      7="Abdominal pain or cramping; back pain"
      8="Skin problems"
      9="Pain or discomfort during intercourse"
      10="Nausea/sickness"
      11="IUD moved or was expelled"
      12="Other side effects"
      13="Other (Too few cases, not classifiable elsewhere)"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value STOPPILLFMT
      1="Can't remember to take pill (regularly)"
      2="Interfered with other medications"
      3="Weight gain"
      4="Headaches/migraines"
      5="Mood swings/depression"
      6="Bleeding problems (spotting, too much, irregularly)"
      7="Hair loss"
      8="Nausea/sickness"
      9="Skin problems"
      10="Hormonal problems/changes"
      11="Didn't like/Didn't want to use"
      12="Concerns about risks, such as breast cancer"
      13="Not effective at preventing cramps"
      14="Weight loss"
      15="Menstrual cramps"
      16="Leg cramps"
      17="Dizziness"
      18="Decreased sex drive"
      19="High blood pressure"
      20="Blood clots"
      21="Fatigue"
      22="Other side effects"
      23="Other (Too few cases, not classifiable elsewhere)"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value STRLOPER
      1="TUBAL LIGATION OR STERILIZATION"
      2="HYSTERECTOMY"
      3="VASECTOMY"
      4="OTHER OPERATION OR TYPE UNKNOWN"
      5="NOT SURGICALLY STERILE" ;
   value SUREINTCHP
      1="Very sure"
      2="Somewhat sure"
      3="Not at all sure"
      8="Refused"
      9="Don't know" ;
   value SXEDGRF
      1="1st grade"
      2="2nd grade"
      3="3rd grade"
      4="4th grade"
      5="5th grade"
      6="6th grade"
      7="7th grade"
      8="8th grade"
      9="9th grade"
      10="10th grade"
      11="11th grade"
      12="12th grade"
      13="1st year of college"
      14="2nd year of college"
      15="3rd year of college"
      16="4th year of college"
      96="Not in school when received instruction"
      98="Refused"
      99="Don't know" ;
   value TALKPARF
      1="How to say no to sex"
      2="Methods of birth control"
      3="Where to get birth control"
      4="Sexually transmitted diseases"
      5="How to prevent HIV/AIDS"
      6="How to use a condom"
      8="Waiting until marriage to have sex"
      95="None of the above"
      98="Refused"
      99="Don't know" ;
   value TIMALON
      1="Yes"
      5="No"
      6="Did not have a health care visit in the past 12 months"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value TIMESMAR
      1="1 TIME"
      2="2 TIMES"
      3="3 TIMES"
      4="4 TIMES"
      5="5 TIMES"
      6="6 TIMES"
      98="Refused"
      99="Don't know" ;
   value TIMING
      1="Before first vaginal intercourse"
      3="After first vaginal intercourse"
      5="Same occasion"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value TMAFTIN
      1="Less than a month after your first intercourse,"
      2="One to three months after your first intercourse,"
      3="Four to twelve months after your first intercourse,"
      4="More than a year after your first intercourse"
      8="Refused"
      9="Don't know" ;
   value TMWK12MO
      1="Full-time"
      2="Part-time"
      3="Some of each"
      8="Refused"
      9="Don't know" ;
   value TOTINCR
      1="Under $5000"
      2="$5000-$7499"
      3="$7500-$9999"
      4="$10,000-$12,499"
      5="$12,500-$14,999"
      6="$15,000-$19,999"
      7="$20,000-$24,999"
      8="$25,000-$29,999"
      9="$30,000-$34,999"
      10="$35,000-$39,999"
      11="$40,000-$49,999"
      12="$50,000-$59,999"
      13="$60,000-$74,999"
      14="$75,000-$99,999"
      15="$100,000 or more" ;
   value TPRGMISS
      0="NONE"
      1="1 PREGNANCY"
      2="2 PREGNANCIES"
      98="Refused"
      99="Don't know" ;
   value TPRGOUTF
      0="NONE"
      1="1 PREGNANCY"
      2="2 PREGNANCIES" ;
   value TRYEITHRF
      1="Yes, trying to adopt"
      3="Yes, trying to become guardian"
      5="No, neither"
      8="Refused"
      9="Don't know" ;
   value TRYLONG
      1="Less than 1 year"
      2="1-2 years"
      3="Or longer than 2 years"
      8="Refused"
      9="Don't know" ;
   value TRYLONG2F
      98="Refused"
      99="Don't know" ;
   value TURNDOWN
      1="Turned down"
      2="Unable to find child"
      3="Decided not to pursue"
      8="Refused"
      9="Don't know" ;
   value TYPALLMCF
      1="Instructions to take complete bed rest"
      2="Instructions to limit your physical activity"
      3="Testing to diagnose problems related to miscarriage"
      4="Drugs to prevent miscarriage, such as progesterone suppositories"
      5="Stitches in your cervix, also known as the 'purse-string' procedure"
      6="Other types of medical help"
      8="Refused"
      9="Don't know" ;
   value TYPALLPGF
      1="Advice"
      2="Infertility testing"
      3="Drugs to improve your ovulation"
      4="Surgery to correct blocked tubes"
      5="Artificial insemination"
      6="Other types of medical help"
      8="Refused"
      9="Don't know" ;
   value UNIT_TRYLONG
      1="Months"
      5="Years"
      8="Refused"
      9="Don't know" ;
   value UNIT30D
      1="Days per week"
      5="Days per month"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value USEFSTSX
      1="YES"
      5="NO"
      98="Refused"
      99="Don't know" ;
   value USLPLACE
      1="Private doctor's office or HMO"
      2="Community health clinic, community clinic, public health clinic"
      3="Family planning or Planned Parenthood Clinic"
      4="Employer or company clinic"
      5="School or school-based clinic"
      6="Hospital outpatient clinic"
      7="Hospital emergency room"
      8="Hospital regular room"
      9="Urgent care center, urgi-care, or walk-in facility"
      10="Sexually transmitted disease (STD) clinic"
      20="Some other place"
      98="Refused"
      99="Don't know" ;
   value VOLSEX1F
      1="Voluntary"
      5="Not voluntary"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value VRY1STSX
      9996="RESPONDED SHE NEVER HAD INTERCOURSE" ;
   value WANTP5F
      0="No wanted pregnancies in last 5 years" ;
   value WANTSEXF
      1="I really didn't want it to happen at the time"
      2="I had mixed feelings -- part of me wanted it to happen at the time and part of me didn't"
      3="I really wanted it to happen at the time"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value WHARTIN
      1="Husband or partner"
      3="Donor"
      5="Both husband or partner and donor"
      8="Refused"
      9="Don't know" ;
   value WHATOPSM
      1="Vasectomy"
      2="Other operation"
      5="If volunteered: Operation failed"
      6="If volunteered: Operation already reversed"
      8="Refused"
      9="Don't know" ;
   value WHICH1ST
      1="Sexual intercourse"
      2="Menstrual period"
      8="Refused"
      9="Don't know" ;
   value WHOSUGG
      1="Doctor or other medical care provider"
      2="Sexual partner"
      3="Someone else"
      8="Refused"
      9="Don't know" ;
   value WHOTEST
      1="You"
      3="Him"
      5="Both of you"
      8="Refused"
      9="Don't know" ;
   value WHRKDSF
      1="In this household"
      2="With their mother"
      3="With grandparents or other relatives"
      4="Somewhere else"
      8="Refused"
      9="Don't know" ;
   value WHTOOPRC
      1="Operation affects only one tube"
      2="Operation affects only one ovary"
      3="Some other operation"
      4="Other sterilizing operation"
      8="Refused"
      9="Don't know" ;
   value WHYCONDL
      1="To prevent pregnancy"
      2="To prevent diseases like syphilis, gonorrhea or AIDS"
      3="For both reasons"
      4="For some other reason"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value WHYNOGET
      1="You thought the testing site would contact you"
      2="You were afraid to find out if you were HIV positive (that you had HIV)"
      3="You didn't want to know your HIV test results"
      4="You didn't know where or how to get your test result"
      20="Some other reason"
      98="Refused"
      99="Don't know" ;
   value WHYNOTPGF
      1="Diagnosis of repro problems/condition"
      2="Prior preg or attempt: problems with or treatments/ART needed"
      3="Prior unprotected sex, no preg"
      4="Perceive infertile or difficulty getting preg/carrying to term"
      5="Menopause related"
      6="One ovary/fallopian tube/low or no ovulation"
      7="Endometriosis"
      8="Breastfeeding"
      9="Partner sterile"
      10="Not having sex"
      11="Other"
      97="Not ascertained"
      98="Refused"
      99="Don't know" ;
   value WHYNOUSNG
      1="You do not expect to have sex"
      2="You do not think you can get pregnant"
      3="You don't really mind if you get pregnant"
      4="You are worried about the side effects of birth control"
      5="Your male partner does not want you to use a birth control method"
      6="Your male partner himself does not want to use a birth control method"
      7="(IF VOLUNTEERED:)Respondent is using a method"
      8="You could not get a method"
      9="You are not taking, or using, your method consistently"
      98="Refused"
      99="Don't know" ;
   value WHYPSTDF
      1="Could walk in or get same-day appointment"
      2="Cost"
      3="Privacy concern"
      4="Expert care here"
      5="Embarrassed to go to usual provider"
      6="Other"
      8="Refused"
      9="Don't know" ;
   value WNFSTSEXF
      13="Winter"
      14="Spring"
      15="Summer"
      16="Fall"
      96="If R insists: Never had sex"
      98="Refused"
      99="Don't know" ;
   value WNSEXAFMF
      13="Winter"
      14="Spring"
      15="Summer"
      16="Fall"
      96="If R insists: no sex since first menstrual period"
      98="Refused"
      99="Don't know" ;
   value WOMRASDU
      1="Biological mother"
      2="Other mother figure"
      3="No mother figure"
      8="Refused"
      9="Don't know" ;
   value WRK12MOS
      0="No months"
      1="1 Month"
      2="2 Months"
      3="3 Months"
      4="4 Months"
      5="5 Months"
      6="6 Months"
      7="7 Months"
      8="8 Months"
      9="9 Months"
      10="10 Months"
      11="11 Months"
      12="12 Months"
      98="Refused"
      99="Don't know" ;
   value WTHPARNW
      1="Both biological or adoptive parents"
      2="Other or no parental figures"
      8="Refused"
      9="Don't know" ;
   value Y1N2RECF
      1="YES"
      2="NO" ;
   value Y1N52D
      1="Yes"
      5="No"
      98="Refused"
      99="Don't know" ;
   value Y1N5C
      1="YES"
      5="NO" ;
   value Y1N5JPC
      1="Yes"
      5="No"
      6="IF VOLUNTEERED : JOINT PHYSICAL CUSTODY"
      8="Refused"
      9="Don't know" ;
   value Y1N5NAC
      1="YES"
      5="NO"
      7="Not ascertained" ;
   value Y1N5NALC
      1="Yes"
      5="No"
      7="Not ascertained" ;
   value Y1N5RDF
      1="Yes"
      5="No"
      8="Refused"
      9="Don't know" ;
   value YEARFMT
      9997="Not ascertained"
      9998="Refused"
      9999="Don't know" ;
   value YESNONAF
      1="Yes"
      5="No"
      7="Not ascertained"
      8="Refused"
      9="Don't know" ;
   value YNOSEX
      1="Against religion or morals"
      2="Don't want to get pregnant"
      3="Don't want to get a sexually transmitted disease"
      4="Haven't found the right person yet"
      5="In a relationship, but waiting for the right time"
      6="Other"
      8="Refused"
      9="Don't know" ;
   value YQUITTRY
      1="Adoption process only"
      2="Own situation only"
      3="Both"
      8="Refused"
      9="Don't know" ;
   value YRSTRUS
      .="Born in US" ;
   value YUSEPILLF
      1="Birth control"
      2="Cramps, or pain during menstrual periods"
      3="Treatment for acne"
      4="Endometriosis"
      5="Other reasons"
      6="To regulate your menstrual periods"
      7="To reduce menstrual bleeding"
      8="Treatment for hot flashes or other peri-menopausal symptoms"
      98="Refused"
      99="Don't know" ;
   value $PHASE
      1="First 10 weeks of quarter"
      2="Last 2 weeks of quarter (double sample)" ;
   value $QUARTER
      9="9"
      10="10"
      11="11"
      12="12"
      13="13"
      14="14"
      15="15"
      16="16" ;
   value $YEARF
      2013="2013"
      2014="2014"
      2015="2015" ;
*/


* SAS DATA, INFILE, INPUT STATEMENTS;

DATA;
INFILE "data-filename" LRECL=5084;
INPUT
   CASEID  1-5              RSCRNINF  6              RSCRAGE  7-8          
   RSCRHISP  9              RSCRRACE  10             AGE_A  11-12          
   AGE_R  13-14             CMBIRTH  15-18           AGESCRN  19-20        
   MARSTAT  21              FMARSTAT  22             FMARIT  23            
   EVRMARRY  24             HISP  25                 HISPGRP  26           
   PRIMLANG1  27            PRIMLANG2  28            PRIMLANG3  29         
   ROSCNT  30               NUMCHILD  31             HHKIDS18  32          
   DAUGHT918  33            SON918  34               NONBIOKIDS  35        
   HPLOCALE  36             MANREL  37               GOSCHOL  38           
   VACA  39                 HIGRADE  40-41           COMPGRD  42           
   DIPGED  43               EARNHS_M  44-45          EARNHS_Y  46-49       
   CMHSGRAD  50-53          HISCHGRD  54-55          LSTGRADE  56-57       
   MYSCHOL_M  58-59         MYSCHOL_Y  60-63         CMLSTSCH  64-67       
   HAVEDEG  68              DEGREES  69              EARNBA_M  70-71       
   EARNBA_Y  72-75          EXPSCHL  76              EXPGRADE  77-78       
   CMBAGRAD  79-82          WTHPARNW  83             ONOWN  84             
   ONOWN18  85              INTACT  86               PARMARR  87           
   INTACT18  88             LVSIT14F  89             LVSIT14M  90          
   WOMRASDU  91             MOMDEGRE  92             MOMWORKD  93          
   MOMFSTCH  94-95          MOM18  96                MANRASDU  97          
   R_FOSTER  98             EVRFSTER  99             MNYFSTER  100-101     
   DURFSTER  102            MENARCHE  103-104        PREGNOWQ  105         
   MAYBPREG  106            NUMPREGS  107-108        EVERPREG  109         
   CURRPREG  110            HOWPREG_N  111-112       HOWPREG_P  113        
   NOWPRGDK  114            MOSCURRP  115            NPREGS_S  116-117     
   HASBABES  118            NUMBABES  119-120        NBABES_S  121-122     
   CMLASTLB  123-126        CMLSTPRG  127-130        CMFSTPRG  131-134     
   CMPG1BEG  135-138        NPLACED  139             NDIED  140            
   NADOPTV  141             TOTPLACD  142            OTHERKID  143         
   NOTHRKID  144-145        SEXOTHKD  146            RELOTHKD  147         
   ADPTOTKD  148            TRYADOPT  149            TRYEITHR  150         
   STILHERE  151            DATKDCAM_M  152-153      DATKDCAM_Y  154-157   
   CMOKDCAM  158-161        OTHKDFOS  162            OKDDOB_M  163-164     
   OKDDOB_Y  165-168        CMOKDDOB  169-172        OTHKDSPN  173         
   OTHKDRAC1  174           OTHKDRAC2  175           KDBSTRAC  176         
   OKBORNUS  177            OKDISABL1  178           OKDISABL2  179        
   SEXOTHKD2  180           RELOTHKD2  181           ADPTOTKD2  182        
   TRYADOPT2  183           TRYEITHR2  184           STILHERE2  185        
   DATKDCAM_M2  186-187     DATKDCAM_Y2  188-191     CMOKDCAM2  192-195    
   OTHKDFOS2  196           OKDDOB_M2  197-198       OKDDOB_Y2  199-202    
   CMOKDDOB2  203-206       OTHKDSPN2  207           OTHKDRAC6  208        
   OTHKDRAC7  209           KDBSTRAC2  210           OKBORNUS2  211        
   OKDISABL5  212           OKDISABL6  213           SEXOTHKD3  214        
   RELOTHKD3  215           ADPTOTKD3  216           TRYADOPT3  217        
   TRYEITHR3  218           STILHERE3  219           DATKDCAM_M3  220-221  
   DATKDCAM_Y3  222-225     CMOKDCAM3  226-229       OTHKDFOS3  230        
   OKDDOB_M3  231-232       OKDDOB_Y3  233-236       CMOKDDOB3  237-240    
   OTHKDSPN3  241           OTHKDRAC11  242          OTHKDRAC12  243       
   KDBSTRAC3  244           OKBORNUS3  245           OKDISABL9  246        
   OKDISABL10  247          SEXOTHKD4  248           RELOTHKD4  249        
   ADPTOTKD4  250           TRYADOPT4  251           TRYEITHR4  252        
   STILHERE4  253           DATKDCAM_M4  254-255     DATKDCAM_Y4  256-259  
   CMOKDCAM4  260-263       OTHKDFOS4  264           OKDDOB_M4  265-266    
   OKDDOB_Y4  267-270       CMOKDDOB4  271-274       OTHKDSPN4  275        
   OTHKDRAC16  276          OTHKDRAC17  277          KDBSTRAC4  278        
   OKBORNUS4  279           OKDISABL13  280          OKDISABL14  281       
   SEXOTHKD5  282           RELOTHKD5  283           ADPTOTKD5  284        
   TRYADOPT5  285           TRYEITHR5  286           STILHERE5  287        
   DATKDCAM_M5  288-289     DATKDCAM_Y5  290-293     CMOKDCAM5  294-297    
   OTHKDFOS5  298           OKDDOB_M5  299           OKDDOB_Y5  300-303    
   CMOKDDOB5  304-307       OTHKDSPN5  308           OTHKDRAC21  309       
   OTHKDRAC22  310          KDBSTRAC5  311           OKBORNUS5  312        
   OKDISABL17  313          OKDISABL18  314          SEXOTHKD6  315        
   RELOTHKD6  316           ADPTOTKD6  317           TRYADOPT6  318        
   TRYEITHR6  319           STILHERE6  320           DATKDCAM_M6  321      
   DATKDCAM_Y6  322         CMOKDCAM6  323           OTHKDFOS6  324        
   OKDDOB_M6  325           OKDDOB_Y6  326           CMOKDDOB6  327        
   OTHKDSPN6  328           OTHKDRAC26  329          OTHKDRAC27  330       
   KDBSTRAC6  331           OKBORNUS6  332           OKDISABL21  333       
   OKDISABL22  334          SEXOTHKD7  335           RELOTHKD7  336        
   ADPTOTKD7  337           TRYADOPT7  338           TRYEITHR7  339        
   STILHERE7  340           DATKDCAM_M7  341         DATKDCAM_Y7  342      
   CMOKDCAM7  343           OTHKDFOS7  344           OKDDOB_M7  345        
   OKDDOB_Y7  346           CMOKDDOB7  347           OTHKDSPN7  348        
   OTHKDRAC31  349          OTHKDRAC32  350          KDBSTRAC7  351        
   OKBORNUS7  352           OKDISABL25  353          OKDISABL26  354       
   SEXOTHKD8  355           RELOTHKD8  356           ADPTOTKD8  357        
   TRYADOPT8  358           TRYEITHR8  359           STILHERE8  360        
   DATKDCAM_M8  361         DATKDCAM_Y8  362         CMOKDCAM8  363        
   OTHKDFOS8  364           OKDDOB_M8  365           OKDDOB_Y8  366        
   CMOKDDOB8  367           OTHKDSPN8  368           OTHKDRAC36  369       
   OTHKDRAC37  370          KDBSTRAC8  371           OKBORNUS8  372        
   OKDISABL29  373          OKDISABL30  374          SEXOTHKD9  375        
   RELOTHKD9  376           ADPTOTKD9  377           TRYADOPT9  378        
   TRYEITHR9  379           STILHERE9  380           DATKDCAM_M9  381      
   DATKDCAM_Y9  382-385     CMOKDCAM9  386-389       OTHKDFOS9  390        
   OKDDOB_M9  391           OKDDOB_Y9  392-395       CMOKDDOB9  396-399    
   OTHKDSPN9  400           OTHKDRAC41  401          OTHKDRAC42  402       
   KDBSTRAC9  403           OKBORNUS9  404           OKDISABL33  405       
   OKDISABL34  406          SEXOTHKD10  407          RELOTHKD10  408       
   ADPTOTKD10  409          TRYADOPT10  410          TRYEITHR10  411       
   STILHERE10  412          DATKDCAM_M10  413        DATKDCAM_Y10  414     
   CMOKDCAM10  415          OTHKDFOS10  416          OKDDOB_M10  417       
   OKDDOB_Y10  418          CMOKDDOB10  419          OTHKDSPN10  420       
   OTHKDRAC46  421          OTHKDRAC47  422          KDBSTRAC10  423       
   OKBORNUS10  424          OKDISABL37  425          OKDISABL38  426       
   SEXOTHKD11  427          RELOTHKD11  428          ADPTOTKD11  429       
   TRYADOPT11  430          TRYEITHR11  431          STILHERE11  432       
   DATKDCAM_M11  433        DATKDCAM_Y11  434-437    CMOKDCAM11  438-441   
   OTHKDFOS11  442          OKDDOB_M11  443          OKDDOB_Y11  444-447   
   CMOKDDOB11  448-451      OTHKDSPN11  452          OTHKDRAC51  453       
   OTHKDRAC52  454          KDBSTRAC11  455          OKBORNUS11  456       
   OKDISABL41  457          OKDISABL42  458          SEXOTHKD12  459       
   RELOTHKD12  460          ADPTOTKD12  461          TRYADOPT12  462       
   TRYEITHR12  463          STILHERE12  464          DATKDCAM_M12  465     
   DATKDCAM_Y12  466        CMOKDCAM12  467          OTHKDFOS12  468       
   OKDDOB_M12  469          OKDDOB_Y12  470          CMOKDDOB12  471       
   OTHKDSPN12  472          OTHKDRAC56  473          OTHKDRAC57  474       
   KDBSTRAC12  475          OKBORNUS12  476          OKDISABL45  477       
   OKDISABL46  478          SEXOTHKD13  479          RELOTHKD13  480       
   ADPTOTKD13  481          TRYADOPT13  482          TRYEITHR13  483       
   STILHERE13  484          DATKDCAM_M13  485        DATKDCAM_Y13  486     
   CMOKDCAM13  487          OTHKDFOS13  488          OKDDOB_M13  489       
   OKDDOB_Y13  490          CMOKDDOB13  491          OTHKDSPN13  492       
   OTHKDRAC61  493          OTHKDRAC62  494          KDBSTRAC13  495       
   OKBORNUS13  496          OKDISABL49  497          OKDISABL50  498       
   SEXOTHKD14  499          RELOTHKD14  500          ADPTOTKD14  501       
   TRYADOPT14  502          TRYEITHR14  503          STILHERE14  504       
   DATKDCAM_M14  505        DATKDCAM_Y14  506-509    CMOKDCAM14  510-513   
   OTHKDFOS14  514          OKDDOB_M14  515          OKDDOB_Y14  516-519   
   CMOKDDOB14  520-523      OTHKDSPN14  524          OTHKDRAC66  525       
   OTHKDRAC67  526          KDBSTRAC14  527          OKBORNUS14  528       
   OKDISABL53  529          OKDISABL54  530          SEXOTHKD15  531       
   RELOTHKD15  532          ADPTOTKD15  533          TRYADOPT15  534       
   TRYEITHR15  535          STILHERE15  536          DATKDCAM_M15  537     
   DATKDCAM_Y15  538        CMOKDCAM15  539          OTHKDFOS15  540       
   OKDDOB_M15  541          OKDDOB_Y15  542          CMOKDDOB15  543       
   OTHKDSPN15  544          OTHKDRAC71  545          OTHKDRAC72  546       
   KDBSTRAC15  547          OKBORNUS15  548          OKDISABL57  549       
   OKDISABL58  550          EVERADPT  551            SEEKADPT  552         
   CONTAGEM  553            TRYLONG  554             KNOWADPT  555         
   CHOSESEX  556            TYPESEXF  557            TYPESEXM  558         
   CHOSRACE  559            TYPRACBK  560            TYPRACWH  561         
   TYPRACOT  562            CHOSEAGE  563            TYPAGE2M  564         
   TYPAGE5M  565            TYPAG12M  566            TYPAG13M  567         
   CHOSDISB  568            TYPDISBN  569            TYPDISBM  570         
   TYPDISBS  571            CHOSENUM  572            TYPNUM1M  573         
   TYPNUM2M  574            EVWNTANO  575            EVCONTAG  576         
   TURNDOWN  577            YQUITTRY  578            APROCESS1  579        
   APROCESS2  580           HRDEMBRYO  581           TIMESMAR  582         
   HSBVERIF  583            WHMARHX_M  584-585       WHMARHX_Y  586-589    
   CMMARRHX  590-593        AGEMARHX  594-595        HXAGEMAR  596-597     
   DOBHUSBX_M  598-599      DOBHUSBX_Y  600-603      CMHSBDOBX  604-607    
   LVTOGHX  608             STRTOGHX_M  609-610      STRTOGHX_Y  611-614   
   CMPMCOHX  615-618        ENGAGHX  619             HSBMULT1  620         
   HSBRACE1  621            HSBHRACE1  622           HSBNRACE1  623        
   CHEDMARN  624            MARBEFHX  625            KIDSHX  626           
   NUMKDSHX  627-628        KIDLIVHX  629            CHKID18A  630         
   CHKID18B  631-632        WHRCHKDS1  633           WHRCHKDS2  634        
   WHRCHKDS3  635           WHRCHKDS4  636           SUPPORCH  637         
   BIOHUSBX  638            BIONUMHX  639            MARENDHX  640         
   WNDIEHX_M  641-642       WNDIEHX_Y  643-646       CMHSBDIEX  647-650    
   DIVDATHX_M  651-652      DIVDATHX_Y  653-656      CMDIVORCX  657-660    
   WNSTPHX_M  661-662       WNSTPHX_Y  663-666       CMSTPHSBX  667-670    
   WHMARHX_M2  671-672      WHMARHX_Y2  673-676      CMMARRHX2  677-680    
   AGEMARHX2  681-682       HXAGEMAR2  683-684       DOBHUSBX_M2  685-686  
   DOBHUSBX_Y2  687-690     CMHSBDOBX2  691-694      LVTOGHX2  695         
   STRTOGHX_M2  696-697     STRTOGHX_Y2  698-701     CMPMCOHX2  702-705    
   ENGAGHX2  706            HSBMULT2  707            HSBRACE2  708         
   HSBHRACE2  709           HSBNRACE2  710           CHEDMARN2  711        
   MARBEFHX2  712           KIDSHX2  713             NUMKDSHX2  714        
   KIDLIVHX2  715           CHKID18A2  716           CHKID18B2  717        
   WHRCHKDS5  718           WHRCHKDS6  719           WHRCHKDS7  720        
   WHRCHKDS8  721           SUPPORCH2  722           BIOHUSBX2  723        
   BIONUMHX2  724-725       MARENDHX2  726           WNDIEHX_M2  727       
   WNDIEHX_Y2  728-731      CMHSBDIEX2  732-735      DIVDATHX_M2  736-737  
   DIVDATHX_Y2  738-741     CMDIVORCX2  742-745      WNSTPHX_M2  746-747   
   WNSTPHX_Y2  748-751      CMSTPHSBX2  752-755      WHMARHX_M3  756-757   
   WHMARHX_Y3  758-761      CMMARRHX3  762-765       AGEMARHX3  766-767    
   HXAGEMAR3  768-769       DOBHUSBX_M3  770-771     DOBHUSBX_Y3  772-775  
   CMHSBDOBX3  776-779      LVTOGHX3  780            STRTOGHX_M3  781-782  
   STRTOGHX_Y3  783-786     CMPMCOHX3  787-790       ENGAGHX3  791         
   HSBMULT3  792            HSBRACE3  793            HSBHRACE3  794        
   HSBNRACE3  795           CHEDMARN3  796           MARBEFHX3  797        
   KIDSHX3  798             NUMKDSHX3  799           KIDLIVHX3  800        
   CHKID18A3  801           CHKID18B3  802           WHRCHKDS9  803        
   WHRCHKDS10  804          WHRCHKDS11  805          WHRCHKDS12  806       
   SUPPORCH3  807           BIOHUSBX3  808           BIONUMHX3  809        
   MARENDHX3  810           WNDIEHX_M3  811-812      WNDIEHX_Y3  813-816   
   CMHSBDIEX3  817-820      DIVDATHX_M3  821-822     DIVDATHX_Y3  823-826  
   CMDIVORCX3  827-830      WNSTPHX_M3  831-832      WNSTPHX_Y3  833-836   
   CMSTPHSBX3  837-840      WHMARHX_M4  841-842      WHMARHX_Y4  843-846   
   CMMARRHX4  847-850       AGEMARHX4  851           HXAGEMAR4  852-853    
   DOBHUSBX_M4  854-855     DOBHUSBX_Y4  856-859     CMHSBDOBX4  860-863   
   LVTOGHX4  864            STRTOGHX_M4  865-866     STRTOGHX_Y4  867-870  
   CMPMCOHX4  871-874       ENGAGHX4  875            HSBMULT4  876         
   HSBRACE4  877            HSBHRACE4  878           HSBNRACE4  879        
   CHEDMARN4  880           MARBEFHX4  881           KIDSHX4  882          
   NUMKDSHX4  883           KIDLIVHX4  884           CHKID18A4  885        
   CHKID18B4  886           WHRCHKDS13  887          WHRCHKDS14  888       
   WHRCHKDS15  889          WHRCHKDS16  890          SUPPORCH4  891        
   BIOHUSBX4  892           BIONUMHX4  893           MARENDHX4  894        
   WNDIEHX_M4  895          WNDIEHX_Y4  896          CMHSBDIEX4  897       
   DIVDATHX_M4  898-899     DIVDATHX_Y4  900-903     CMDIVORCX4  904-907   
   WNSTPHX_M4  908-909      WNSTPHX_Y4  910-913      CMSTPHSBX4  914-917   
   WHMARHX_M5  918          WHMARHX_Y5  919-922      CMMARRHX5  923-926    
   AGEMARHX5  927           HXAGEMAR5  928-929       DOBHUSBX_M5  930      
   DOBHUSBX_Y5  931-934     CMHSBDOBX5  935-937      LVTOGHX5  938         
   STRTOGHX_M5  939         STRTOGHX_Y5  940-943     CMPMCOHX5  944-947    
   ENGAGHX5  948            CHEDMARN5  949           MARBEFHX5  950        
   KIDSHX5  951             NUMKDSHX5  952-953       KIDLIVHX5  954        
   CHKID18A5  955           CHKID18B5  956           WHRCHKDS17  957       
   WHRCHKDS18  958          WHRCHKDS19  959          WHRCHKDS20  960       
   SUPPORCH5  961           BIOHUSBX5  962           BIONUMHX5  963        
   MARENDHX5  964           WNDIEHX_M5  965          WNDIEHX_Y5  966       
   CMHSBDIEX5  967          DIVDATHX_M5  968         DIVDATHX_Y5  969      
   CMDIVORCX5  970          WNSTPHX_M5  971          WNSTPHX_Y5  972-975   
   CMSTPHSBX5  976-979      CMMARRCH  980-983        CMDOBCH  984-987      
   PREVHUSB  988            WNSTRTCP_M  989-990      WNSTRTCP_Y  991-994   
   CMSTRTCP  995-998        CPHERAGE  999-1000       CPHISAGE  1001-1002   
   WNCPBRN_M  1003-1004     WNCPBRN_Y  1005-1008     CMDOBCP  1009-1012    
   CPENGAG1  1013           WILLMARR  1014           CURCOHMULT  1015      
   CURCOHRACE  1016         CURCOHHRACE  1017        CURCOHNRACE  1018     
   CPEDUC  1019             CPMARBEF  1020           CPKIDS  1021          
   CPNUMKDS  1022-1023      CPKIDLIV  1024           CPKID18A  1025        
   CPKID18B  1026-1027      WHRCPKDS1  1028          WHRCPKDS2  1029       
   WHRCPKDS3  1030          WHRCPKDS4  1031          SUPPORCP  1032        
   BIOCP  1033              BIONUMCP  1034           CMSTRTHP  1035-1038   
   LIVEOTH  1039            EVRCOHAB  1040           HMOTHMEN  1041-1042   
   PREVCOHB  1043-1044      STRTOTHX_M  1045-1046    STRTOTHX_Y  1047-1050 
   CMCOHSTX  1051-1054      HERAGECX  1055-1056      HISAGECX  1057-1058   
   WNBRNCX_M  1059-1060     WNBRNCX_Y  1061-1064     CMDOBCX  1065-1068    
   ENGAG1CX  1069           COH1MULT  1070           COH1RACE  1071        
   COH1HRACE  1072          COH1NRACE  1073          MAREVCX  1074         
   CXKIDS  1075             BIOFCPX  1076            BIONUMCX  1077        
   STPTOGCX_M  1078-1079    STPTOGCX_Y  1080-1083    CMSTPCOHX  1084-1087  
   STRTOTHX_M2  1088-1089   STRTOTHX_Y2  1090-1093   CMCOHSTX2  1094-1097  
   HERAGECX2  1098-1099     HISAGECX2  1100-1101     WNBRNCX_M2  1102-1103 
   WNBRNCX_Y2  1104-1107    CMDOBCX2  1108-1111      ENGAG1CX2  1112       
   MAREVCX2  1113           CXKIDS2  1114            BIOFCPX2  1115        
   BIONUMCX2  1116          STPTOGCX_M2  1117-1118   STPTOGCX_Y2  1119-1122
   CMSTPCOHX2  1123-1126    STRTOTHX_M3  1127-1128   STRTOTHX_Y3  1129-1132
   CMCOHSTX3  1133-1136     HERAGECX3  1137-1138     HISAGECX3  1139-1140  
   WNBRNCX_M3  1141-1142    WNBRNCX_Y3  1143-1146    CMDOBCX3  1147-1150   
   ENGAG1CX3  1151          MAREVCX3  1152           CXKIDS3  1153         
   BIOFCPX3  1154           BIONUMCX3  1155          STPTOGCX_M3  1156-1157
   STPTOGCX_Y3  1158-1161   CMSTPCOHX3  1162-1165    STRTOTHX_M4  1166-1167
   STRTOTHX_Y4  1168-1171   CMCOHSTX4  1172-1175     HERAGECX4  1176-1177  
   HISAGECX4  1178-1179     WNBRNCX_M4  1180-1181    WNBRNCX_Y4  1182-1185 
   CMDOBCX4  1186-1189      ENGAG1CX4  1190          MAREVCX4  1191        
   CXKIDS4  1192            BIOFCPX4  1193           BIONUMCX4  1194       
   STPTOGCX_M4  1195-1196   STPTOGCX_Y4  1197-1200   CMSTPCOHX4  1201-1204 
   COHCHANCE  1205          MARRCHANCE  1206         PMARCOH  1207         
   EVERSEX  1208            RHADSEX  1209            YNOSEX  1210          
   WNFSTSEX_M  1211-1212    WNFSTSEX_Y  1213-1216    CMFSTSEX  1217-1220   
   AGEFSTSX  1221-1222      C_SEX18  1223            C_SEX15  1224         
   C_SEX20  1225            GRFSTSX  1226-1227       SXMTONCE  1228        
   TALKPAR1  1229-1230      TALKPAR2  1231           TALKPAR3  1232        
   TALKPAR4  1233           TALKPAR5  1234           TALKPAR6  1235        
   TALKPAR7  1236           SEDNO  1237              SEDNOG  1238-1239     
   SEDNOSX  1240            SEDBC  1241              SEDBCG  1242-1243     
   SEDBCSX  1244            SEDWHBC  1245            SEDWHBCG  1246-1247   
   SEDWBCSX  1248           SEDCOND  1249            SEDCONDG  1250-1251   
   SEDCONSX  1252           SEDSTD  1253             SEDSTDG  1254-1255    
   SEDSTDSX  1256           SEDHIV  1257             SEDHIVG  1258-1259    
   SEDHIVSX  1260           SEDABST  1261            SEDABSTG  1262-1263   
   SEDABSSX  1264           SAMEMAN  1265            WHOFSTPR  1266-1267   
   FPAGE  1268-1269         FPRELAGE  1270           FPRELYRS  1271        
   KNOWFP  1272-1273        STILFPSX  1274           LSTSEXFP_M  1275-1276 
   LSTSEXFP_Y  1277-1280    CMLSEXFP  1281-1284      CMFPLAST  1285-1288   
   FPOTHREL  1289-1290      FPEDUC  1291             FSEXMULT  1292        
   FSEXRACE  1293           FSEXHRACE  1294          FSEXNRACE  1295       
   FPRN  1296               WHICH1ST  1297           SEXAFMEN  1298        
   WNSEXAFM_M  1299-1300    WNSEXAFM_Y  1301-1304    CMSEXAFM  1305-1308   
   AGESXAFM  1309-1310      AFMEN18  1311            AFMEN15  1312         
   AFMEN20  1313            LIFEPRT  1314-1316       LIFEPRT_LO  1317-1319 
   LIFEPRT_HI  1320-1322    PTSB4MAR  1323-1325      PTSB4MAR_LO  1326-1328
   PTSB4MAR_HI  1329-1331   MON12PRT  1332-1334      MON12PRT_LO  1335-1337
   MON12PRT_HI  1338-1340   PARTS12  1341-1344       LIFEPRTS  1345-1346   
   WHOSNC1Y  1347           MATCHFP  1348            MATCHHP  1349-1350    
   P1YRELP  1351-1352       CMLSEX  1353-1356        P1YLSEX_M  1357-1358  
   P1YLSEX_Y  1359-1362     P1YCURRP  1363           PCURRNT  1364         
   MATCHFP2  1365           MATCHHP2  1366-1367      P1YRELP2  1368-1369   
   CMLSEX2  1370-1373       P1YLSEX_M2  1374-1375    P1YLSEX_Y2  1376-1379 
   P1YCURRP2  1380          PCURRNT2  1381           MATCHFP3  1382        
   MATCHHP3  1383-1384      P1YRELP3  1385-1386      CMLSEX3  1387-1390    
   P1YLSEX_M3  1391-1392    P1YLSEX_Y3  1393-1396    P1YCURRP3  1397       
   PCURRNT3  1398           P1YOTHREL  1399-1400     P1YRAGE  1401-1402    
   P1YHSAGE  1403-1404      P1YRF  1405-1406         P1YFSEX_M  1407-1408  
   P1YFSEX_Y  1409-1412     CMFSEX  1413-1416        CMFSEXTOT  1417-1420  
   P1YEDUC  1421            P1YMULT1  1422           P1YRACE1  1423        
   P1YHRACE1  1424          P1YNRACE1  1425          P1YRN  1426-1427      
   P1YOTHREL2  1428-1429    P1YRAGE2  1430-1431      P1YHSAGE2  1432-1433  
   P1YRF2  1434             P1YFSEX_M2  1435-1436    P1YFSEX_Y2  1437-1440 
   CMFSEX2  1441-1444       CMFSEXTOT2  1445-1448    P1YEDUC2  1449        
   P1YMULT2  1450           P1YRACE2  1451           P1YHRACE2  1452       
   P1YNRACE2  1453          P1YRN2  1454             P1YOTHREL3  1455-1456 
   P1YRAGE3  1457-1458      P1YHSAGE3  1459-1460     P1YRF3  1461-1462     
   P1YFSEX_M3  1463-1464    P1YFSEX_Y3  1465-1468    CMFSEX3  1469-1472    
   CMFSEXTOT3  1473-1476    P1YEDUC3  1477           P1YMULT3  1478        
   P1YRACE3  1479           P1YHRACE3  1480          P1YNRACE3  1481       
   P1YRN3  1482             CURRPRTT  1483           CURRPRTS  1484        
   CMCURRP1  1485-1488      CMCURRP2  1489-1492      CMCURRP3  1493        
   EVERTUBS  1494           ESSURE  1495             EVERHYST  1496        
   EVEROVRS  1497           EVEROTHR  1498           WHTOOPRC  1499        
   ONOTFUNC  1500           DFNLSTRL  1501           ANYTUBAL  1502        
   HYST  1503               OVAREM  1504             OTHR  1505            
   ANYFSTER  1506           ANYOPSMN  1507           WHATOPSM  1508        
   DFNLSTRM  1509           ANYMSTER  1510           ANYVAS  1511          
   OTHRM  1512              DATFEMOP_M  1513-1514    DATFEMOP_Y  1515-1518 
   CMTUBLIG  1519-1522      PLCFEMOP  1523-1524      INPATIEN  1525        
   PAYRSTER1  1526          PAYRSTER2  1527          RHADALL  1528         
   HHADALL  1529            FMEDREAS1  1530          FMEDREAS2  1531       
   FMEDREAS3  1532          FMEDREAS4  1533          BCREAS  1534          
   BCWHYF  1535             MINCDNNR  1536           DATFEMOP_M2  1537-1538
   DATFEMOP_Y2  1539-1542   CMHYST  1543-1546        PLCFEMOP2  1547-1548  
   PAYRSTER6  1549          PAYRSTER7  1550          RHADALL2  1551        
   HHADALL2  1552           FMEDREAS7  1553          FMEDREAS8  1554       
   FMEDREAS9  1555          FMEDREAS10  1556         BCREAS2  1557         
   BCWHYF2  1558            MINCDNNR2  1559          DATFEMOP_M3  1560-1561
   DATFEMOP_Y3  1562-1565   CMOVAREM  1566-1569      PLCFEMOP3  1570       
   PAYRSTER11  1571         PAYRSTER12  1572         RHADALL3  1573        
   HHADALL3  1574           FMEDREAS13  1575         FMEDREAS14  1576      
   FMEDREAS15  1577         FMEDREAS16  1578         BCREAS3  1579         
   BCWHYF3  1580            MINCDNNR3  1581          DATFEMOP_M4  1582-1583
   DATFEMOP_Y4  1584-1587   CMOTSURG  1588-1591      PLCFEMOP4  1592       
   PAYRSTER16  1593         PAYRSTER17  1594         RHADALL4  1595        
   HHADALL4  1596           FMEDREAS19  1597         FMEDREAS20  1598      
   FMEDREAS21  1599         FMEDREAS22  1600         BCREAS4  1601         
   BCWHYF4  1602            MINCDNNR4  1603          CMOPER1  1604-1607    
   OPERSAME1  1608          OPERSAME2  1609          OPERSAME3  1610       
   OPERSAME4  1611          OPERSAME5  1612          OPERSAME6  1613       
   DATEOPMN_M  1614-1615    DATEOPMN_Y  1616-1619    CMMALEOP  1620-1623   
   WITHIMOP  1624           VASJAN4YR  1625          PLACOPMN  1626-1627   
   PAYMSTER1  1628          PAYMSTER2  1629          RHADALLM  1630        
   HHADALLM  1631           MEDREAS1  1632           MEDREAS2  1633        
   BCREASM  1634            BCWHYM  1635             MINCDNMN  1636        
   REVSTUBL  1637           DATRVSTB_M  1638         DATRVSTB_Y  1639-1642 
   CMLIGREV  1643-1646      REVSVASX  1647           DATRVVEX_M  1648-1649 
   DATRVVEX_Y  1650-1653    CMVASREV  1654-1657      TUBS  1658            
   VASECT  1659             RSURGSTR  1660           PSURGSTR  1661        
   ONLYTBVS  1662           RWANTRVT  1663           MANWANTT  1664        
   RWANTREV  1665           MANWANTR  1666           POSIBLPG  1667        
   REASIMPR  1668-1669      POSIBLMN  1670           REASIMPP  1671        
   CANHAVER  1672           REASDIFF1  1673          REASDIFF2  1674       
   REASDIFF3  1675          REASDIFF4  1676          REASDIFF5  1677       
   CANHAVEM  1678           PREGNONO  1679           REASNONO1  1680       
   REASNONO2  1681          REASNONO3  1682          RSTRSTAT  1683        
   PSTRSTAT  1684           PILL  1685               CONDOM  1686          
   VASECTMY  1687           DEPOPROV  1688           WIDRAWAL  1689        
   RHYTHM  1690             SDAYCBDS  1691           TEMPSAFE  1692        
   PATCH  1693              RING  1694               MORNPILL  1695        
   ECTIMESX  1696-1697      ECREASON1  1698          ECREASON2  1699       
   ECREASON3  1700          ECRX  1701               ECWHERE  1702-1703    
   ECWHEN  1704             OTHRMETH01  1705-1706    OTHRMETH02  1707-1708 
   OTHRMETH03  1709-1710    OTHRMETH04  1711-1712    OTHRMETH05  1713-1714 
   OTHRMETH06  1715-1716    OTHRMETH07  1717         EVIUDTYP1  1718       
   EVIUDTYP2  1719          NEWMETH  1720            EVERUSED  1721        
   METHDISS  1722           METHSTOP01  1723-1724    METHSTOP02  1725-1726 
   METHSTOP03  1727-1728    METHSTOP04  1729-1730    METHSTOP05  1731-1732 
   METHSTOP06  1733-1734    METHSTOP07  1735-1736    METHSTOP08  1737-1738 
   METHSTOP09  1739         METHSTOP10  1740         REASPILL01  1741-1742 
   REASPILL02  1743-1744    REASPILL03  1745-1746    REASPILL04  1747-1748 
   REASPILL05  1749-1750    REASPILL06  1751-1752    STOPPILL1  1753-1754  
   STOPPILL2  1755-1756     STOPPILL3  1757-1758     STOPPILL4  1759-1760  
   STOPPILL5  1761-1762     STOPPILL6  1763-1764     REASCOND01  1765-1766 
   REASCOND02  1767-1768    REASCOND03  1769-1770    REASCOND04  1771-1772 
   REASCOND05  1773-1774    REASCOND06  1775-1776    REASCOND07  1777      
   STOPCOND1  1778-1779     STOPCOND2  1780          REASDEPO01  1781-1782 
   REASDEPO02  1783-1784    REASDEPO03  1785-1786    REASDEPO04  1787-1788 
   REASDEPO05  1789-1790    REASDEPO06  1791-1792    REASDEPO07  1793      
   REASDEPO08  1794         STOPDEPO1  1795-1796     STOPDEPO2  1797-1798  
   STOPDEPO3  1799-1800     STOPDEPO4  1801-1802     STOPDEPO5  1803-1804  
   TYPEIUD_1  1805          TYPEIUD_2  1806          REASIUD01  1807-1808  
   REASIUD02  1809-1810     REASIUD03  1811-1812     REASIUD04  1813       
   REASIUD05  1814          STOPIUD1  1815-1816      STOPIUD2  1817-1818   
   STOPIUD3  1819-1820      STOPIUD4  1821-1822      STOPIUD5  1823        
   FIRSMETH1  1824-1825     FIRSMETH2  1826-1827     FIRSMETH3  1828-1829  
   FIRSMETH4  1830-1831     NUMFIRSM  1832           DRUGDEV  1833-1834    
   DRUGDEV2  1835           DRUGDEV3  1836           DRUGDEV4  1837        
   FIRSTIME1  1838          FIRSTIME2  1839          USEFSTSX  1840-1841   
   CMFIRSM  1842-1845       MTHFSTSX1  1846-1847     MTHFSTSX2  1848-1849  
   MTHFSTSX3  1850-1851     MTHFSTSX4  1852-1853     WNFSTUSE_M  1854-1855 
   WNFSTUSE_Y  1856-1859    FMETHPRS  1860           FMETHPRS2  1861       
   FMETHPRS3  1862          FMETHPRS4  1863          CMFSTUSE  1864-1867   
   AGEFSTUS  1868-1869      PLACGOTF  1870-1871      PLACGOTF2  1872-1873  
   PLACGOTF3  1874-1875     PLACGOTF4  1876-1877     USEFRSTS  1878        
   MTHFRSTS1  1879-1880     MTHFRSTS2  1881-1882     MTHFRSTS3  1883-1884  
   MTHFRSTS4  1885          INTR_EC3  1886           CMMONSX  1887-1890    
   MONSX  1891              CMMONSX2  1892-1895      MONSX2  1896          
   CMMONSX3  1897-1900      MONSX3  1901             CMMONSX4  1902-1905   
   MONSX4  1906             CMMONSX5  1907-1910      MONSX5  1911          
   CMMONSX6  1912-1915      MONSX6  1916             CMMONSX7  1917-1920   
   MONSX7  1921             CMMONSX8  1922-1925      MONSX8  1926          
   CMMONSX9  1927-1930      MONSX9  1931             CMMONSX10  1932-1935  
   MONSX10  1936            CMMONSX11  1937-1940     MONSX11  1941         
   CMMONSX12  1942-1945     MONSX12  1946            CMMONSX13  1947-1950  
   MONSX13  1951            CMMONSX14  1952-1955     MONSX14  1956         
   CMMONSX15  1957-1960     MONSX15  1961            CMMONSX16  1962-1965  
   MONSX16  1966            CMMONSX17  1967-1970     MONSX17  1971         
   CMMONSX18  1972-1975     MONSX18  1976            CMMONSX19  1977-1980  
   MONSX19  1981            CMMONSX20  1982-1985     MONSX20  1986         
   CMMONSX21  1987-1990     MONSX21  1991            CMMONSX22  1992-1995  
   MONSX22  1996            CMMONSX23  1997-2000     MONSX23  2001         
   CMMONSX24  2002-2005     MONSX24  2006            CMMONSX25  2007-2010  
   MONSX25  2011            CMMONSX26  2012-2015     MONSX26  2016         
   CMMONSX27  2017-2020     MONSX27  2021            CMMONSX28  2022-2025  
   MONSX28  2026            CMMONSX29  2027-2030     MONSX29  2031         
   CMMONSX30  2032-2035     MONSX30  2036            CMMONSX31  2037-2040  
   MONSX31  2041            CMMONSX32  2042-2045     MONSX32  2046         
   CMMONSX33  2047-2050     MONSX33  2051            CMMONSX34  2052-2055  
   MONSX34  2056            CMMONSX35  2057-2060     MONSX35  2061         
   CMMONSX36  2062-2065     MONSX36  2066            CMMONSX37  2067-2070  
   MONSX37  2071            CMMONSX38  2072-2075     MONSX38  2076         
   CMMONSX39  2077-2080     MONSX39  2081            CMMONSX40  2082-2085  
   MONSX40  2086            CMMONSX41  2087-2090     MONSX41  2091         
   CMMONSX42  2092-2095     MONSX42  2096            CMMONSX43  2097-2100  
   MONSX43  2101            CMMONSX44  2102-2105     MONSX44  2106         
   CMMONSX45  2107-2110     MONSX45  2111            CMMONSX46  2112-2115  
   MONSX46  2116            CMMONSX47  2117-2120     MONSX47  2121         
   CMMONSX48  2122-2125     MONSX48  2126            CMSTRTMC  2127-2130   
   CMENDMC  2131-2134       INTR_ED4A  2135          NUMMCMON  2136-2137   
   MC1MONS1  2138-2140      MC1SIMSQ  2141           MC1MONS2  2142-2144   
   MC1MONS3  2145-2147      DATBEGIN_M  2148-2149    DATBEGIN_Y  2150-2153 
   CMDATBEGIN  2154-2157    CURRMETH1  2158-2159     CURRMETH2  2160-2161  
   CURRMETH3  2162-2163     CURRMETH4  2164-2165     LSTMONMETH1  2166-2167
   LSTMONMETH2  2168-2169   LSTMONMETH3  2170-2171   LSTMONMETH4  2172-2173
   PILL_12  2174            DIAPH_12  2175           IUD_12  2176          
   IMPLANT_12  2177         DEPO_12  2178            CERVC_12  2179        
   MPILL_12  2180           PATCH_12  2181           RING_12  2182         
   METHX1  2183-2184        METHX2  2185-2186        METHX3  2187-2188     
   METHX4  2189-2190        METHX5  2191-2192        METHX6  2193-2194     
   METHX7  2195-2196        METHX8  2197-2198        METHX9  2199-2200     
   METHX10  2201-2202       METHX11  2203-2204       METHX12  2205-2206    
   METHX13  2207-2208       METHX14  2209-2210       METHX15  2211-2212    
   METHX16  2213-2214       METHX17  2215-2216       METHX18  2217-2218    
   METHX19  2219-2220       METHX20  2221-2222       METHX21  2223-2224    
   METHX22  2225-2226       METHX23  2227-2228       METHX24  2229-2230    
   METHX25  2231-2232       METHX26  2233-2234       METHX27  2235-2236    
   METHX28  2237-2238       METHX29  2239-2240       METHX30  2241-2242    
   METHX31  2243-2244       METHX32  2245-2246       METHX33  2247-2248    
   METHX34  2249-2250       METHX35  2251-2252       METHX36  2253-2254    
   METHX37  2255-2256       METHX38  2257-2258       METHX39  2259-2260    
   METHX40  2261-2262       METHX41  2263-2264       METHX42  2265-2266    
   METHX43  2267-2268       METHX44  2269-2270       METHX45  2271-2272    
   METHX46  2273-2274       METHX47  2275-2276       METHX48  2277-2278    
   METHX49  2279-2280       METHX50  2281-2282       METHX51  2283-2284    
   METHX52  2285-2286       METHX53  2287-2288       METHX54  2289-2290    
   METHX55  2291-2292       METHX56  2293-2294       METHX57  2295-2296    
   METHX58  2297-2298       METHX59  2299-2300       METHX60  2301-2302    
   METHX61  2303-2304       METHX62  2305-2306       METHX63  2307-2308    
   METHX64  2309-2310       METHX65  2311-2312       METHX66  2313-2314    
   METHX67  2315-2316       METHX68  2317-2318       METHX69  2319-2320    
   METHX70  2321-2322       METHX71  2323-2324       METHX72  2325-2326    
   METHX73  2327-2328       METHX74  2329-2330       METHX75  2331-2332    
   METHX76  2333-2334       METHX77  2335-2336       METHX78  2337-2338    
   METHX79  2339-2340       METHX80  2341-2342       METHX81  2343-2344    
   METHX82  2345-2346       METHX83  2347-2348       METHX84  2349-2350    
   METHX85  2351-2352       METHX86  2353-2354       METHX87  2355-2356    
   METHX88  2357-2358       METHX89  2359-2360       METHX90  2361-2362    
   METHX91  2363-2364       METHX92  2365-2366       METHX93  2367-2368    
   METHX94  2369-2370       METHX95  2371-2372       METHX96  2373-2374    
   METHX97  2375-2376       METHX98  2377-2378       METHX99  2379-2380    
   METHX100  2381-2382      METHX101  2383-2384      METHX102  2385-2386   
   METHX103  2387-2388      METHX104  2389-2390      METHX105  2391-2392   
   METHX106  2393-2394      METHX107  2395-2396      METHX108  2397-2398   
   METHX109  2399-2400      METHX110  2401-2402      METHX111  2403-2404   
   METHX112  2405-2406      METHX113  2407-2408      METHX114  2409-2410   
   METHX115  2411-2412      METHX116  2413-2414      METHX117  2415-2416   
   METHX118  2417-2418      METHX119  2419-2420      METHX120  2421-2422   
   METHX121  2423-2424      METHX122  2425-2426      METHX123  2427-2428   
   METHX124  2429-2430      METHX125  2431-2432      METHX126  2433-2434   
   METHX127  2435-2436      METHX128  2437-2438      METHX129  2439-2440   
   METHX130  2441-2442      METHX131  2443-2444      METHX132  2445-2446   
   METHX133  2447-2448      METHX134  2449-2450      METHX135  2451-2452   
   METHX136  2453-2454      METHX137  2455-2456      METHX138  2457-2458   
   METHX139  2459-2460      METHX140  2461-2462      METHX141  2463-2464   
   METHX142  2465-2466      METHX143  2467-2468      METHX144  2469-2470   
   METHX145  2471-2472      METHX146  2473-2474      METHX147  2475-2476   
   METHX148  2477-2478      METHX149  2479-2480      METHX150  2481-2482   
   METHX151  2483-2484      METHX152  2485-2486      METHX153  2487-2488   
   METHX154  2489-2490      METHX155  2491-2492      METHX156  2493-2494   
   METHX157  2495-2496      METHX158  2497-2498      METHX159  2499-2500   
   METHX160  2501-2502      METHX161  2503-2504      METHX162  2505-2506   
   METHX163  2507-2508      METHX164  2509-2510      METHX165  2511-2512   
   METHX166  2513-2514      METHX167  2515-2516      METHX168  2517        
   METHX169  2518-2519      METHX170  2520-2521      METHX171  2522-2523   
   METHX172  2524           METHX173  2525-2526      METHX174  2527-2528   
   METHX175  2529-2530      METHX176  2531           METHX177  2532-2533   
   METHX178  2534-2535      METHX179  2536-2537      METHX180  2538        
   METHX181  2539-2540      METHX182  2541-2542      METHX183  2543-2544   
   METHX184  2545           METHX185  2546-2547      METHX186  2548-2549   
   METHX187  2550           METHX188  2551           METHX189  2552-2553   
   METHX190  2554-2555      METHX191  2556           METHX192  2557        
   CMMHCALX1  2558-2561     CMMHCALX2  2562-2565     CMMHCALX3  2566-2569  
   CMMHCALX4  2570-2573     CMMHCALX5  2574-2577     CMMHCALX6  2578-2581  
   CMMHCALX7  2582-2585     CMMHCALX8  2586-2589     CMMHCALX9  2590-2593  
   CMMHCALX10  2594-2597    CMMHCALX11  2598-2601    CMMHCALX12  2602-2605 
   CMMHCALX13  2606-2609    CMMHCALX14  2610-2613    CMMHCALX15  2614-2617 
   CMMHCALX16  2618-2621    CMMHCALX17  2622-2625    CMMHCALX18  2626-2629 
   CMMHCALX19  2630-2633    CMMHCALX20  2634-2637    CMMHCALX21  2638-2641 
   CMMHCALX22  2642-2645    CMMHCALX23  2646-2649    CMMHCALX24  2650-2653 
   CMMHCALX25  2654-2657    CMMHCALX26  2658-2661    CMMHCALX27  2662-2665 
   CMMHCALX28  2666-2669    CMMHCALX29  2670-2673    CMMHCALX30  2674-2677 
   CMMHCALX31  2678-2681    CMMHCALX32  2682-2685    CMMHCALX33  2686-2689 
   CMMHCALX34  2690-2693    CMMHCALX35  2694-2697    CMMHCALX36  2698-2701 
   CMMHCALX37  2702-2705    CMMHCALX38  2706-2709    CMMHCALX39  2710-2713 
   CMMHCALX40  2714-2717    CMMHCALX41  2718-2721    CMMHCALX42  2722-2725 
   CMMHCALX43  2726-2729    CMMHCALX44  2730-2733    CMMHCALX45  2734-2737 
   CMMHCALX46  2738-2741    CMMHCALX47  2742-2745    CMMHCALX48  2746-2749 
   NUMMULTX1  2750          NUMMULTX2  2751          NUMMULTX3  2752       
   NUMMULTX4  2753          NUMMULTX5  2754          NUMMULTX6  2755       
   NUMMULTX7  2756          NUMMULTX8  2757          NUMMULTX9  2758       
   NUMMULTX10  2759         NUMMULTX11  2760         NUMMULTX12  2761      
   NUMMULTX13  2762         NUMMULTX14  2763         NUMMULTX15  2764      
   NUMMULTX16  2765         NUMMULTX17  2766         NUMMULTX18  2767      
   NUMMULTX19  2768         NUMMULTX20  2769         NUMMULTX21  2770      
   NUMMULTX22  2771         NUMMULTX23  2772         NUMMULTX24  2773      
   NUMMULTX25  2774         NUMMULTX26  2775         NUMMULTX27  2776      
   NUMMULTX28  2777         NUMMULTX29  2778         NUMMULTX30  2779      
   NUMMULTX31  2780         NUMMULTX32  2781         NUMMULTX33  2782      
   NUMMULTX34  2783         NUMMULTX35  2784         NUMMULTX36  2785      
   NUMMULTX37  2786         NUMMULTX38  2787         NUMMULTX39  2788      
   NUMMULTX40  2789         NUMMULTX41  2790         NUMMULTX42  2791      
   NUMMULTX43  2792         NUMMULTX44  2793         NUMMULTX45  2794      
   NUMMULTX46  2795         NUMMULTX47  2796         NUMMULTX48  2797      
   SALMX1  2798             SALMX2  2799             SALMX3  2800          
   SALMX4  2801             SALMX5  2802             SALMX6  2803          
   SALMX7  2804             SALMX8  2805             SALMX9  2806          
   SALMX10  2807            SALMX11  2808            SALMX12  2809         
   SALMX13  2810            SALMX14  2811            SALMX15  2812         
   SALMX16  2813            SALMX17  2814            SALMX18  2815         
   SALMX19  2816            SALMX20  2817            SALMX21  2818         
   SALMX22  2819            SALMX23  2820            SALMX24  2821         
   SALMX25  2822            SALMX26  2823            SALMX27  2824         
   SALMX28  2825            SALMX29  2826            SALMX30  2827         
   SALMX31  2828            SALMX32  2829            SALMX33  2830         
   SALMX34  2831            SALMX35  2832            SALMX36  2833         
   SALMX37  2834            SALMX38  2835            SALMX39  2836         
   SALMX40  2837            SALMX41  2838            SALMX42  2839         
   SALMX43  2840            SALMX44  2841            SALMX45  2842         
   SALMX46  2843            SALMX47  2844            SALMX48  2845         
   SAYX1  2846              SAYX2  2847              SAYX3  2848           
   SAYX4  2849              SAYX5  2850              SAYX6  2851           
   SAYX7  2852              SAYX8  2853              SAYX9  2854           
   SAYX10  2855             SAYX11  2856             SAYX12  2857          
   SAYX13  2858             SAYX14  2859             SAYX15  2860          
   SAYX16  2861             SAYX17  2862             SAYX18  2863          
   SAYX19  2864             SAYX20  2865             SAYX21  2866          
   SAYX22  2867             SAYX23  2868             SAYX24  2869          
   SAYX25  2870             SAYX26  2871             SAYX27  2872          
   SAYX28  2873             SAYX29  2874             SAYX30  2875          
   SAYX31  2876             SAYX32  2877             SAYX33  2878          
   SAYX34  2879             SAYX35  2880             SAYX36  2881          
   SAYX37  2882             SAYX38  2883             SAYX39  2884          
   SAYX40  2885             SAYX41  2886             SAYX42  2887          
   SAYX43  2888             SAYX44  2889             SAYX45  2890          
   SAYX46  2891             SAYX47  2892             SAYX48  2893          
   SIMSEQX1  2894           SIMSEQX2  2895           SIMSEQX3  2896        
   SIMSEQX4  2897           SIMSEQX5  2898           SIMSEQX6  2899        
   SIMSEQX7  2900           SIMSEQX8  2901           SIMSEQX9  2902        
   SIMSEQX10  2903          SIMSEQX11  2904          SIMSEQX12  2905       
   SIMSEQX13  2906          SIMSEQX14  2907          SIMSEQX15  2908       
   SIMSEQX16  2909          SIMSEQX17  2910          SIMSEQX18  2911       
   SIMSEQX19  2912          SIMSEQX20  2913          SIMSEQX21  2914       
   SIMSEQX22  2915          SIMSEQX23  2916          SIMSEQX24  2917       
   SIMSEQX25  2918          SIMSEQX26  2919          SIMSEQX27  2920       
   SIMSEQX28  2921          SIMSEQX29  2922          SIMSEQX30  2923       
   SIMSEQX31  2924          SIMSEQX32  2925          SIMSEQX33  2926       
   SIMSEQX34  2927          SIMSEQX35  2928          SIMSEQX36  2929       
   SIMSEQX37  2930          SIMSEQX38  2931          SIMSEQX39  2932       
   SIMSEQX40  2933          SIMSEQX41  2934          SIMSEQX42  2935       
   SIMSEQX43  2936          SIMSEQX44  2937          SIMSEQX45  2938       
   SIMSEQX46  2939          SIMSEQX47  2940          SIMSEQX48  2941       
   USELSTP  2942            LSTMTHP1  2943-2944      LSTMTHP2  2945-2946   
   LSTMTHP3  2947-2948      LSTMTHP4  2949-2950      USEFSTP  2951         
   FSTMTHP1  2952-2953      FSTMTHP2  2954-2955      FSTMTHP3  2956-2957   
   FSTMTHP4  2958-2959      USELSTP2  2960           LSTMTHP5  2961-2962   
   LSTMTHP6  2963-2964      LSTMTHP7  2965-2966      LSTMTHP8  2967-2968   
   USEFSTP2  2969           FSTMTHP5  2970-2971      FSTMTHP6  2972-2973   
   FSTMTHP7  2974-2975      FSTMTHP8  2976-2977      USELSTP3  2978        
   LSTMTHP9  2979-2980      LSTMTHP10  2981-2982     LSTMTHP11  2983-2984  
   LSTMTHP12  2985-2986     USEFSTP3  2987           FSTMTHP9  2988-2989   
   FSTMTHP10  2990-2991     FSTMTHP11  2992-2993     FSTMTHP12  2994-2995  
   WYNOTUSE  2996           HPPREGQ  2997            DURTRY_N  2998-2999   
   DURTRY_P  3000           WHYNOUSING1  3001-3002   WHYNOUSING2  3003     
   WHYNOUSING3  3004        WHYNOUSING4  3005        WHYNOUSING5  3006     
   WHYNOTPG1  3007-3008     WHYNOTPG2  3009          MAINNOUSE  3010-3011  
   YUSEPILL1  3012-3013     YUSEPILL2  3014          YUSEPILL3  3015       
   YUSEPILL4  3016          YUSEPILL5  3017          YUSEPILL6  3018       
   YUSEPILL7  3019          IUDTYPE  3020            PST4WKSX  3021-3023   
   PSWKCOND1  3024          PSWKCOND2  3025-3027     COND1BRK  3028        
   COND1OFF  3029           CONDBRFL  3030-3032      CONDOFF  3033-3035    
   MISSPILL  3036           P12MOCON  3037           PXNOFREQ  3038        
   BTHCON12  3039           MEDTST12  3040           BCCNS12  3041         
   STEROP12  3042           STCNS12  3043            EMCON12  3044         
   ECCNS12  3045            NUMMTH12  3046           PRGTST12  3047        
   ABORT12  3048            PAP12  3049              PELVIC12  3050        
   PRENAT12  3051           PARTUM12  3052           STDSVC12  3053        
   BARRIER1  3054-3055      BARRIER2  3056-3057      BARRIER3  3058-3059   
   BARRIER4  3060           NUMSVC12  3061-3062      NUMBCVIS  3063        
   BC12PLCX  3064-3065      BC12PLCX2  3066-3067     BC12PLCX3  3068-3069  
   BC12PLCX4  3070-3071     BC12PLCX5  3072-3073     BC12PLCX6  3074-3075  
   BC12PLCX7  3076-3077     BC12PLCX8  3078-3079     BC12PLCX9  3080-3081  
   BC12PLCX10  3082-3083    BC12PLCX11  3084-3085    BC12PLCX12  3086-3087 
   BC12PLCX13  3088-3089    BC12PLCX14  3090-3091    BC12PLCX15  3092-3093 
   IDCLINIC  3094-3095      PGTSTBC2  3096           PAPPLBC2  3097        
   PAPPELEC  3098           STDTSCON  3099           WHYPSTD  3100         
   BC12PAYX1  3101          BC12PAYX2  3102          BC12PAYX3  3103       
   BC12PAYX4  3104          BC12PAYX7  3105          BC12PAYX8  3106       
   BC12PAYX9  3107          BC12PAYX10  3108         BC12PAYX13  3109      
   BC12PAYX14  3110         BC12PAYX15  3111         BC12PAYX16  3112      
   BC12PAYX19  3113         BC12PAYX20  3114         BC12PAYX21  3115      
   BC12PAYX22  3116         BC12PAYX25  3117         BC12PAYX26  3118      
   BC12PAYX27  3119         BC12PAYX28  3120         BC12PAYX31  3121      
   BC12PAYX32  3122         BC12PAYX33  3123         BC12PAYX34  3124      
   BC12PAYX37  3125         BC12PAYX38  3126         BC12PAYX39  3127      
   BC12PAYX40  3128         BC12PAYX43  3129         BC12PAYX44  3130      
   BC12PAYX45  3131         BC12PAYX46  3132         BC12PAYX49  3133      
   BC12PAYX50  3134         BC12PAYX51  3135         BC12PAYX52  3136      
   BC12PAYX55  3137         BC12PAYX56  3138         BC12PAYX57  3139      
   BC12PAYX58  3140         BC12PAYX61  3141         BC12PAYX62  3142      
   BC12PAYX63  3143         BC12PAYX64  3144         BC12PAYX67  3145      
   BC12PAYX68  3146         BC12PAYX69  3147         BC12PAYX70  3148      
   BC12PAYX73  3149         BC12PAYX74  3150         BC12PAYX75  3151      
   BC12PAYX76  3152         BC12PAYX79  3153         BC12PAYX80  3154      
   BC12PAYX81  3155         BC12PAYX82  3156         BC12PAYX85  3157      
   BC12PAYX86  3158         BC12PAYX87  3159         BC12PAYX88  3160      
   REGCAR12_F_01  3161      REGCAR12_F_02  3162      REGCAR12_F_03  3163   
   REGCAR12_F_04  3164      REGCAR12_F_05  3165      REGCAR12_F_06  3166   
   REGCAR12_F_07  3167      REGCAR12_F_08  3168      REGCAR12_F_09  3169   
   REGCAR12_F_10  3170      REGCAR12_F_11  3171      REGCAR12_F_12  3172   
   REGCAR12_F_13  3173      REGCAR12_F_14  3174      REGCAR12_F_15  3175   
   DRUGDEVE  3176           FSTSVC12  3177           WNFSTSVC_M  3178-3179 
   WNFSTSVC_Y  3180-3183    CMFSTSVC  3184-3187      B4AFSTIN  3188        
   TMAFTIN  3189            FSTSERV1  3190           FSTSERV2  3191        
   FSTSERV3  3192           FSTSERV4  3193           FSTSERV5  3194        
   FSTSERV6  3195           BCPLCFST  3196-3197      EVERFPC  3198         
   KNDMDHLP01  3199-3200    KNDMDHLP02  3201-3202    KNDMDHLP03  3203-3204 
   KNDMDHLP04  3205-3206    KNDMDHLP05  3207-3208    KNDMDHLP06  3209-3210 
   KNDMDHLP07  3211-3212    KNDMDHLP08  3213-3214    LASTPAP  3215         
   MREASPAP  3216           AGEFPAP  3217-3218       AGEFPAP2  3219        
   ABNPAP3  3220            INTPAP  3221-3222        PELWPAP  3223         
   LASTPEL  3224            MREASPEL  3225           AGEFPEL  3226-3227    
   AGEPEL2  3228            INTPEL  3229-3230        EVHPVTST  3231        
   HPVWPAP  3232            LASTHPV  3233            MREASHPV  3234        
   AGEFHPV  3235-3236       AGEHPV2  3237            INTHPV  3238-3239     
   RWANT  3240              PROBWANT  3241           PWANT  3242           
   JINTEND  3243            JSUREINT  3244           JINTENDN  3245-3246   
   JEXPECTL  3247-3248      JEXPECTS  3249-3250      JINTNEXT  3251        
   INTEND  3252             SUREINT  3253            INTENDN  3254-3255    
   EXPECTL  3256-3257       EXPECTS  3258            INTNEXT  3259         
   HLPPRG  3260             HOWMANYR  3261           SEEKWHO1  3262        
   SEEKWHO2  3263           TYPALLPG1  3264          TYPALLPG2  3265       
   TYPALLPG3  3266          TYPALLPG4  3267          TYPALLPG5  3268       
   TYPALLPG6  3269          WHOTEST  3270            WHARTIN  3271         
   OTMEDHEP1  3272          OTMEDHEP2  3273          OTMEDHEP3  3274       
   OTMEDHEP4  3275          INSCOVPG  3276           FSTHLPPG_M  3277-3278 
   FSTHLPPG_Y  3279-3282    CMPGVIS1  3283-3286      TRYLONG2  3287-3288   
   UNIT_TRYLONG  3289       HLPPGNOW  3290           RCNTPGH_M  3291-3292  
   RCNTPGH_Y  3293-3296     CMPGVISL  3297-3300      NUMVSTPG  3301-3302   
   PRGVISIT  3303-3304      HLPMC  3305              TYPALLMC1  3306       
   TYPALLMC2  3307          TYPALLMC3  3308          TYPALLMC4  3309       
   TYPALLMC5  3310          TYPALLMC6  3311          MISCNUM  3312-3313    
   INFRTPRB1  3314          INFRTPRB2  3315          INFRTPRB3  3316       
   INFRTPRB4  3317          INFRTPRB5  3318          DUCHFREQ  3319        
   PID  3320                PIDSYMPT  3321           PIDTX  3322-3323      
   LSTPIDTX_M  3324-3325    LSTPIDTX_Y  3326-3329    CMPIDLST  3330-3333   
   DIABETES  3334           GESTDIAB  3335           UF  3336              
   ENDO  3337               OVUPROB  3338            DEAF  3339            
   BLIND  3340              DIFDECIDE  3341          DIFWALK  3342         
   DIFDRESS  3343           DIFOUT  3344             EVRCANCER  3345       
   AGECANCER  3346-3347     CANCTYPE  3348-3349      PRECANCER  3350       
   MAMMOG  3351             AGEMAMM1  3352-3353      REASMAMM1  3354       
   FAMHYST  3355            FAMRISK  3356            PILLRISK  3357        
   ALCORISK  3358           CANCFUTR  3359           CANCWORRY  3360       
   DONBLOOD  3361           HIVTEST  3362            NOHIVTST  3363-3364   
   WHENHIV_M  3365-3366     WHENHIV_Y  3367-3370     CMHIVTST  3371-3374   
   HIVTSTYR  3375           HIVRESULT  3376          WHYNOGET  3377-3378   
   PLCHIV  3379-3380        RHHIVT1  3381            RHHIVT21  3382        
   RHHIVT22  3383           HIVTST  3384-3385        WHOSUGG  3386         
   TALKDOCT  3387           AIDSTALK01  3388-3389    AIDSTALK02  3390-3391 
   AIDSTALK03  3392-3393    AIDSTALK04  3394-3395    AIDSTALK05  3396-3397 
   AIDSTALK06  3398-3399    AIDSTALK07  3400-3401    AIDSTALK08  3402-3403 
   AIDSTALK09  3404-3405    AIDSTALK10  3406-3407    AIDSTALK11  3408-3409 
   RETROVIR  3410           PREGHIV  3411            EVERVACC  3412        
   HPVSHOT1  3413-3414      HPVSEX1  3415            VACCPROB  3416        
   USUALCAR  3417           USLPLACE  3418-3419      USL12MOS  3420        
   COVER12  3421            NUMNOCOV  3422-3423      COVERHOW01  3424-3425 
   COVERHOW02  3426         COVERHOW03  3427         COVERHOW04  3428      
   NOWCOVER01  3429-3430    NOWCOVER02  3431         NOWCOVER03  3432      
   PARINSUR  3433           SAMEADD  3434            CNTRY10  3435         
   BRNOUT  3436             YRSTRUS  3437-3440       RELRAISD  3441-3442   
   ATTND14  3443            RELCURR  3444-3445       RELTRAD  3446         
   FUNDAM1  3447            FUNDAM2  3448            FUNDAM3  3449         
   FUNDAM4  3450            RELDLIFE  3451           ATTNDNOW  3452        
   WRK12MOS  3453-3454      FPT12MOS  3455           DOLASTWK1  3456       
   DOLASTWK2  3457          DOLASTWK3  3458          DOLASTWK4  3459       
   DOLASTWK5  3460          RWRKST  3461             WORKP12  3462         
   RPAYJOB  3463            RNUMJOB  3464            RFTPTX  3465          
   REARNTY  3466            SPLSTWK1  3467           SPLSTWK2  3468        
   SPLSTWK3  3469           SPLSTWK4  3470           SPLSTWK5  3471        
   SPWRKST  3472            SPPAYJOB  3473           SPNUMJOB  3474        
   SPFTPTX  3475            SPEARNTY  3476           STAYTOG  3477         
   SAMESEX  3478            SXOK18  3479             SXOK16  3480          
   CHUNLESS  3481           CHSUPPOR  3482           GAYADOPT  3483        
   OKCOHAB  3484            REACTSLF  3485           CHBOTHER  3486        
   MARRFAIL  3487           CHCOHAB  3488            PRVNTDIV  3489        
   LESSPLSR  3490           EMBARRAS  3491           ACASILANG  3492       
   GENHEALT  3493           INCHES  3494-3495        RWEIGHT  3496-3498    
   BMI  3499-3500           ENGSPEAK  3501           CASIBIRTH  3502-3503  
   CASILOSS  3504-3505      CASIABOR  3506-3507      CASIADOP  3508        
   EVSUSPEN  3509           GRADSUSP  3510-3511      SMK100  3512          
   AGESMK  3513-3514        SMOKE12  3515            DRINK12  3516         
   UNIT30D  3517            DRINK30D  3518-3519      DRINKDAY  3520-3521   
   BINGE30  3522-3523       DRNKMOST  3524-3525      BINGE12  3526         
   POT12  3527              COC12  3528              CRACK12  3529         
   CRYSTMTH12  3530         INJECT12  3531           VAGSEX  3532          
   AGEVAGR  3533-3534       AGEVAGM  3535-3536       CONDVAG  3537         
   WHYCONDL  3538           GETORALM  3539           GIVORALM  3540        
   CONDFELL  3541           ANYORAL  3542            TIMING  3543          
   ANALSEX  3544            CONDANAL  3545           OPPSEXANY  3546       
   OPPSEXGEN  3547          CONDSEXL  3548           WANTSEX1  3549        
   VOLSEX1  3550            HOWOLD  3551-3552        GIVNDRUG  3553        
   HEBIGOLD  3554           ENDRELAT  3555           WORDPRES  3556        
   THRTPHYS  3557           PHYSHURT  3558           HELDDOWN  3559        
   EVRFORCD  3560           AGEFORC1  3561-3562      GIVNDRG2  3563        
   HEBIGOL2  3564           ENDRELA2  3565           WRDPRES2  3566        
   THRTPHY2  3567           PHYSHRT2  3568           HELDDWN2  3569        
   PARTSLIF_1  3570-3572    PARTSLFV  3573           PARTSLIF_2  3574-3576 
   OPPLIFENUM  3577-3579    PARTS12M_1  3580-3582    PARTS12V  3583        
   PARTS12M_2  3584-3586    OPPYEARNUM  3587-3589    NEWYEAR  3590-3592    
   NEWLIFE  3593-3595       VAGNUM12  3596-3598      ORALNUM12  3599-3601  
   ANALNUM12  3602-3604     CURRPAGE  3605-3606      RELAGE  3607          
   HOWMUCH  3608            CURRPAGE2  3609-3610     RELAGE2  3611         
   HOWMUCH2  3612           CURRPAGE3  3613-3614     RELAGE3  3615         
   HOWMUCH3  3616           BISEXPRT  3617           NONMONOG  3618        
   NNONMONOG1  3619         NNONMONOG2  3620         NNONMONOG3  3621      
   MALSHT12  3622           PROSTFRQ  3623           JOHNFREQ  3624        
   HIVMAL12  3625           GIVORALF  3626           GETORALF  3627        
   FEMSEX  3628             SAMESEXANY  3629         FEMPARTS_1  3630-3632 
   FEMLIFEV  3633           FEMPARTS_2  3634-3636    SAMLIFENUM  3637-3639 
   FEMPRT12_1  3640-3642    FEM12V  3643             FEMPRT12_2  3644-3646 
   SAMYEARNUM  3647-3649    SAMESEX1  3650-3651      MFLASTP  3652         
   ATTRACT  3653            ORIENT  3654             CONFCONC  3655        
   TIMALON  3656            RISKCHEK1  3657          RISKCHEK2  3658       
   RISKCHEK3  3659          RISKCHEK4  3660          CHLAMTST  3661        
   STDOTHR12  3662          STDTRT12  3663           GON  3664             
   CHLAM  3665              HERPES  3666             GENWARTS  3667        
   SYPHILIS  3668           EVRINJECT  3669          EVRSHARE  3670        
   EARNTYPE  3671           EARN  3672-3673          EARNDK1  3674         
   EARNDK2  3675            EARNDK3  3676            EARNDK4  3677         
   WAGE  3678               SELFINC  3679            SOCSEC  3680          
   DISABIL  3681            RETIRE  3682             SSI  3683             
   UNEMP  3684              CHLDSUPP  3685           INTEREST  3686        
   DIVIDEND  3687           OTHINC  3688             TOINCWMY  3689        
   TOTINC  3690-3691        FMINCDK1  3692           FMINCDK2  3693        
   FMINCDK3  3694           FMINCDK4  3695           FMINCDK5  3696        
   PUBASST  3697            PUBASTYP1  3698          FOODSTMP  3699        
   WIC  3700                HLPTRANS  3701           HLPCHLDC  3702        
   HLPJOB  3703             FREEFOOD  3704           HUNGRY  3705          
   MED_COST  3706           AGER  3707-3708          FMARITAL  3709        
   RMARITAL  3710           EDUCAT  3711-3712        HIEDUC  3713-3714     
   HISPANIC  3715           NUMRACE  3716            RACE  3717            
   HISPRACE  3718           HISPRACE2  3719          NUMKDHH  3720         
   NUMFMHH  3721            HHFAMTYP  3722           HHPARTYP  3723        
   NCHILDHH  3724           HHKIDTYP  3725           CSPBBHH  3726         
   CSPBSHH  3727            CSPOKDHH  3728           INTCTFAM  3729        
   PARAGE14  3730           EDUCMOM  3731-3732       AGEMOMB1  3733-3734   
   AGER_I  3735             FMARITAL_I  3736         RMARITAL_I  3737      
   EDUCAT_I  3738           HIEDUC_I  3739           HISPANIC_I  3740      
   RACE_I  3741             HISPRACE_I  3742         HISPRACE2_I  3743     
   NUMKDHH_I  3744          NUMFMHH_I  3745          HHFAMTYP_I  3746      
   HHPARTYP_I  3747         NCHILDHH_I  3748         HHKIDTYP_I  3749      
   CSPBBHH_I  3750          CSPBSHH_I  3751          CSPOKDHH_I  3752      
   INTCTFAM_I  3753         PARAGE14_I  3754         EDUCMOM_I  3755       
   AGEMOMB1_I  3756         RCURPREG  3757           PREGNUM  3758-3759    
   COMPREG  3760-3761       LOSSNUM  3762-3763       ABORTION  3764        
   LBPREGS  3765-3766       PARITY  3767-3768        BIRTHS5  3769         
   OUTCOM01  3770           OUTCOM02  3771           OUTCOM03  3772        
   OUTCOM04  3773           OUTCOM05  3774           OUTCOM06  3775        
   OUTCOM07  3776           OUTCOM08  3777           OUTCOM09  3778        
   OUTCOM10  3779           OUTCOM11  3780           OUTCOM12  3781        
   OUTCOM13  3782           OUTCOM14  3783           OUTCOM15  3784        
   OUTCOM16  3785           OUTCOM17  3786           OUTCOM18  3787        
   OUTCOM19  3788           OUTCOM20  3789           DATEND01  3790-3793   
   DATEND02  3794-3797      DATEND03  3798-3801      DATEND04  3802-3805   
   DATEND05  3806-3809      DATEND06  3810-3813      DATEND07  3814-3817   
   DATEND08  3818-3821      DATEND09  3822-3825      DATEND10  3826-3829   
   DATEND11  3830-3833      DATEND12  3834-3837      DATEND13  3838-3841   
   DATEND14  3842-3845      DATEND15  3846-3849      DATEND16  3850-3853   
   DATEND17  3854-3857      DATEND18  3858-3861      DATEND19  3862-3865   
   DATEND20  3866-3869      AGEPRG01  3870-3873      AGEPRG02  3874-3877   
   AGEPRG03  3878-3881      AGEPRG04  3882-3885      AGEPRG05  3886-3889   
   AGEPRG06  3890-3893      AGEPRG07  3894-3897      AGEPRG08  3898-3901   
   AGEPRG09  3902-3905      AGEPRG10  3906-3909      AGEPRG11  3910-3913   
   AGEPRG12  3914-3917      AGEPRG13  3918-3921      AGEPRG14  3922-3925   
   AGEPRG15  3926-3929      AGEPRG16  3930-3933      AGEPRG17  3934-3937   
   AGEPRG18  3938-3941      AGEPRG19  3942-3945      AGEPRG20  3946-3949   
   DATCON01  3950-3953      DATCON02  3954-3957      DATCON03  3958-3961   
   DATCON04  3962-3965      DATCON05  3966-3969      DATCON06  3970-3973   
   DATCON07  3974-3977      DATCON08  3978-3981      DATCON09  3982-3985   
   DATCON10  3986-3989      DATCON11  3990-3993      DATCON12  3994-3997   
   DATCON13  3998-4001      DATCON14  4002-4005      DATCON15  4006-4009   
   DATCON16  4010-4013      DATCON17  4014-4017      DATCON18  4018-4021   
   DATCON19  4022-4025      DATCON20  4026-4029      AGECON01  4030-4033   
   AGECON02  4034-4037      AGECON03  4038-4041      AGECON04  4042-4045   
   AGECON05  4046-4049      AGECON06  4050-4053      AGECON07  4054-4057   
   AGECON08  4058-4061      AGECON09  4062-4065      AGECON10  4066-4069   
   AGECON11  4070-4073      AGECON12  4074-4077      AGECON13  4078-4081   
   AGECON14  4082-4085      AGECON15  4086-4089      AGECON16  4090-4093   
   AGECON17  4094-4097      AGECON18  4098-4101      AGECON19  4102-4105   
   AGECON20  4106-4109      MAROUT01  4110           MAROUT02  4111        
   MAROUT03  4112           MAROUT04  4113           MAROUT05  4114        
   MAROUT06  4115           MAROUT07  4116           MAROUT08  4117        
   MAROUT09  4118           MAROUT10  4119           MAROUT11  4120        
   MAROUT12  4121           MAROUT13  4122           MAROUT14  4123        
   MAROUT15  4124           MAROUT16  4125           MAROUT17  4126        
   MAROUT18  4127           MAROUT19  4128           MAROUT20  4129        
   RMAROUT01  4130          RMAROUT02  4131          RMAROUT03  4132       
   RMAROUT04  4133          RMAROUT05  4134          RMAROUT06  4135       
   RMAROUT07  4136          RMAROUT08  4137          RMAROUT09  4138       
   RMAROUT10  4139          RMAROUT11  4140          RMAROUT12  4141       
   RMAROUT13  4142          RMAROUT14  4143          RMAROUT15  4144       
   RMAROUT16  4145          RMAROUT17  4146          RMAROUT18  4147       
   RMAROUT19  4148          RMAROUT20  4149          MARCON01  4150        
   MARCON02  4151           MARCON03  4152           MARCON04  4153        
   MARCON05  4154           MARCON06  4155           MARCON07  4156        
   MARCON08  4157           MARCON09  4158           MARCON10  4159        
   MARCON11  4160           MARCON12  4161           MARCON13  4162        
   MARCON14  4163           MARCON15  4164           MARCON16  4165        
   MARCON17  4166           MARCON18  4167           MARCON19  4168        
   MARCON20  4169           RMARCON01  4170          RMARCON02  4171       
   RMARCON03  4172          RMARCON04  4173          RMARCON05  4174       
   RMARCON06  4175          RMARCON07  4176          RMARCON08  4177       
   RMARCON09  4178          RMARCON10  4179          RMARCON11  4180       
   RMARCON12  4181          RMARCON13  4182          RMARCON14  4183       
   RMARCON15  4184          RMARCON16  4185          RMARCON17  4186       
   RMARCON18  4187          RMARCON19  4188          RMARCON20  4189       
   CEBOW  4190              CEBOWC  4191             DATBABY1  4192-4195   
   AGEBABY1  4196-4199      LIVCHILD01  4200         LIVCHILD02  4201      
   LIVCHILD03  4202         LIVCHILD04  4203         LIVCHILD05  4204      
   LIVCHILD06  4205         LIVCHILD07  4206         LIVCHILD08  4207      
   LIVCHILD09  4208         LIVCHILD10  4209         LIVCHILD11  4210      
   LIVCHILD12  4211         LIVCHILD13  4212         LIVCHILD14  4213      
   LIVCHILD15  4214         LIVCHILD16  4215         LIVCHILD17  4216      
   LIVCHILD18  4217         LIVCHILD19  4218         LIVCHILD20  4219      
   RCURPREG_I  4220         PREGNUM_I  4221          COMPREG_I  4222       
   LOSSNUM_I  4223          ABORTION_I  4224         LBPREGS_I  4225       
   PARITY_I  4226           BIRTHS5_I  4227          OUTCOM01_I  4228      
   OUTCOM02_I  4229         OUTCOM03_I  4230         OUTCOM04_I  4231      
   OUTCOM05_I  4232         OUTCOM06_I  4233         OUTCOM07_I  4234      
   OUTCOM08_I  4235         OUTCOM09_I  4236         OUTCOM10_I  4237      
   OUTCOM11_I  4238         OUTCOM12_I  4239         OUTCOM13_I  4240      
   OUTCOM14_I  4241         OUTCOM15_I  4242         OUTCOM16_I  4243      
   OUTCOM17_I  4244         OUTCOM18_I  4245         OUTCOM19_I  4246      
   OUTCOM20_I  4247         DATEND01_I  4248         DATEND02_I  4249      
   DATEND03_I  4250         DATEND04_I  4251         DATEND05_I  4252      
   DATEND06_I  4253         DATEND07_I  4254         DATEND08_I  4255      
   DATEND09_I  4256         DATEND10_I  4257         DATEND11_I  4258      
   DATEND12_I  4259         DATEND13_I  4260         DATEND14_I  4261      
   DATEND15_I  4262         DATEND16_I  4263         DATEND17_I  4264      
   DATEND18_I  4265         DATEND19_I  4266         DATEND20_I  4267      
   AGEPRG01_I  4268         AGEPRG02_I  4269         AGEPRG03_I  4270      
   AGEPRG04_I  4271         AGEPRG05_I  4272         AGEPRG06_I  4273      
   AGEPRG07_I  4274         AGEPRG08_I  4275         AGEPRG09_I  4276      
   AGEPRG10_I  4277         AGEPRG11_I  4278         AGEPRG12_I  4279      
   AGEPRG13_I  4280         AGEPRG14_I  4281         AGEPRG15_I  4282      
   AGEPRG16_I  4283         AGEPRG17_I  4284         AGEPRG18_I  4285      
   AGEPRG19_I  4286         AGEPRG20_I  4287         DATCON01_I  4288      
   DATCON02_I  4289         DATCON03_I  4290         DATCON04_I  4291      
   DATCON05_I  4292         DATCON06_I  4293         DATCON07_I  4294      
   DATCON08_I  4295         DATCON09_I  4296         DATCON10_I  4297      
   DATCON11_I  4298         DATCON12_I  4299         DATCON13_I  4300      
   DATCON14_I  4301         DATCON15_I  4302         DATCON16_I  4303      
   DATCON17_I  4304         DATCON18_I  4305         DATCON19_I  4306      
   DATCON20_I  4307         AGECON01_I  4308         AGECON02_I  4309      
   AGECON03_I  4310         AGECON04_I  4311         AGECON05_I  4312      
   AGECON06_I  4313         AGECON07_I  4314         AGECON08_I  4315      
   AGECON09_I  4316         AGECON10_I  4317         AGECON11_I  4318      
   AGECON12_I  4319         AGECON13_I  4320         AGECON14_I  4321      
   AGECON15_I  4322         AGECON16_I  4323         AGECON17_I  4324      
   AGECON18_I  4325         AGECON19_I  4326         AGECON20_I  4327      
   MAROUT01_I  4328         MAROUT02_I  4329         MAROUT03_I  4330      
   MAROUT04_I  4331         MAROUT05_I  4332         MAROUT06_I  4333      
   MAROUT07_I  4334         MAROUT08_I  4335         MAROUT09_I  4336      
   MAROUT10_I  4337         MAROUT11_I  4338         MAROUT12_I  4339      
   MAROUT13_I  4340         MAROUT14_I  4341         MAROUT15_I  4342      
   MAROUT16_I  4343         MAROUT17_I  4344         MAROUT18_I  4345      
   MAROUT19_I  4346         MAROUT20_I  4347         RMAROUT01_I  4348     
   RMAROUT02_I  4349        RMAROUT03_I  4350        RMAROUT04_I  4351     
   RMAROUT05_I  4352        RMAROUT06_I  4353        RMAROUT07_I  4354     
   RMAROUT08_I  4355        RMAROUT09_I  4356        RMAROUT10_I  4357     
   RMAROUT11_I  4358        RMAROUT12_I  4359        RMAROUT13_I  4360     
   RMAROUT14_I  4361        RMAROUT15_I  4362        RMAROUT16_I  4363     
   RMAROUT17_I  4364        RMAROUT18_I  4365        RMAROUT19_I  4366     
   RMAROUT20_I  4367        MARCON01_I  4368         MARCON02_I  4369      
   MARCON03_I  4370         MARCON04_I  4371         MARCON05_I  4372      
   MARCON06_I  4373         MARCON07_I  4374         MARCON08_I  4375      
   MARCON09_I  4376         MARCON10_I  4377         MARCON11_I  4378      
   MARCON12_I  4379         MARCON13_I  4380         MARCON14_I  4381      
   MARCON15_I  4382         MARCON16_I  4383         MARCON17_I  4384      
   MARCON18_I  4385         MARCON19_I  4386         MARCON20_I  4387      
   RMARCON01_I  4388        RMARCON02_I  4389        RMARCON03_I  4390     
   RMARCON04_I  4391        RMARCON05_I  4392        RMARCON06_I  4393     
   RMARCON07_I  4394        RMARCON08_I  4395        RMARCON09_I  4396     
   RMARCON10_I  4397        RMARCON11_I  4398        RMARCON12_I  4399     
   RMARCON13_I  4400        RMARCON14_I  4401        RMARCON15_I  4402     
   RMARCON16_I  4403        RMARCON17_I  4404        RMARCON18_I  4405     
   RMARCON19_I  4406        RMARCON20_I  4407        CEBOW_I  4408         
   CEBOWC_I  4409           DATBABY1_I  4410         AGEBABY1_I  4411      
   LIVCHILD01_I  4412       LIVCHILD02_I  4413       LIVCHILD03_I  4414    
   LIVCHILD04_I  4415       LIVCHILD05_I  4416       LIVCHILD06_I  4417    
   LIVCHILD07_I  4418       LIVCHILD08_I  4419       LIVCHILD09_I  4420    
   LIVCHILD10_I  4421       LIVCHILD11_I  4422       LIVCHILD12_I  4423    
   LIVCHILD13_I  4424       LIVCHILD14_I  4425       LIVCHILD15_I  4426    
   LIVCHILD16_I  4427       LIVCHILD17_I  4428       LIVCHILD18_I  4429    
   LIVCHILD19_I  4430       LIVCHILD20_I  4431       FMARNO  4432          
   CSPBIOKD  4433-4434      MARDAT01  4435-4438      MARDAT02  4439-4442   
   MARDAT03  4443-4446      MARDAT04  4447-4450      MARDAT05  4451-4454   
   MARDIS01  4455-4458      MARDIS02  4459-4462      MARDIS03  4463-4466   
   MARDIS04  4467-4470      MARDIS05  4471-4474      MAREND01  4475        
   MAREND02  4476           MAREND03  4477           MAREND04  4478        
   MAREND05  4479           FMAR1AGE  4480-4481      AGEDISS1  4482-4483   
   AGEDD1  4484-4485        MAR1DISS  4486-4488      DD1REMAR  4489-4491   
   MAR1BIR1  4492-4494      MAR1CON1  4495-4497      CON1MAR1  4498-4500   
   B1PREMAR  4501           COHEVER  4502            EVMARCOH  4503        
   PMARRNO  4504            NONMARR  4505-4506       TIMESCOH  4507-4508   
   COHAB1  4509-4512        COHSTAT  4513            COHOUT  4514          
   COH1DUR  4515-4517       HADSEX  4518             SEXONCE  4519         
   SEXEVER  4520            VRY1STAG  4521-4522      SEX1AGE  4523-4524    
   VRY1STSX  4525-4528      DATESEX1  4529-4532      FSEXPAGE  4533-4535   
   SEXMAR  4536-4538        SEX1FOR  4539-4541       SEXUNION  4542-4544   
   SEXOUT  4545             FPDUR  4546-4548         PARTS1YR  4549        
   LSEXDATE  4550-4553      SEX3MO  4554             NUMP3MOS  4555-4556   
   LSEXRAGE  4557-4558      LSEXPAGE  4559-4561      PARTDUR1  4562-4564   
   PARTDUR2  4565-4567      PARTDUR3  4568-4570      RELATP1  4571         
   RELATP2  4572            RELATP3  4573            LIFPRTNR  4574-4575   
   FMARNO_I  4576           CSPBIOKD_I  4577         MARDAT01_I  4578      
   MARDAT02_I  4579         MARDAT03_I  4580         MARDAT04_I  4581      
   MARDAT05_I  4582         MARDIS01_I  4583         MARDIS02_I  4584      
   MARDIS03_I  4585         MARDIS04_I  4586         MARDIS05_I  4587      
   MAREND01_I  4588         MAREND02_I  4589         MAREND03_I  4590      
   MAREND04_I  4591         MAREND05_I  4592         FMAR1AGE_I  4593      
   AGEDISS1_I  4594         AGEDD1_I  4595           MAR1DISS_I  4596      
   DD1REMAR_I  4597         MAR1BIR1_I  4598         MAR1CON1_I  4599      
   CON1MAR1_I  4600         B1PREMAR_I  4601         COHEVER_I  4602       
   EVMARCOH_I  4603         PMARRNO_I  4604          NONMARR_I  4605       
   TIMESCOH_I  4606         COHAB1_I  4607           COHSTAT_I  4608       
   COHOUT_I  4609           COH1DUR_I  4610          HADSEX_I  4611        
   SEXEVER_I  4612          VRY1STAG_I  4613         SEX1AGE_I  4614       
   VRY1STSX_I  4615         DATESEX1_I  4616         SEXONCE_I  4617       
   FSEXPAGE_I  4618         SEXMAR_I  4619           SEX1FOR_I  4620       
   SEXUNION_I  4621         SEXOUT_I  4622           FPDUR_I  4623         
   PARTS1YR_I  4624         LSEXDATE_I  4625         SEXP3MO_I  4626       
   NUMP3MOS_I  4627         LSEXRAGE_I  4628         PARTDUR1_I  4629      
   PARTDUR2_I  4630         PARTDUR3_I  4631         RELATP1_I  4632       
   RELATP2_I  4633          RELATP3_I  4634          LIFPRTNR_I  4635      
   STRLOPER  4636           FECUND  4637             ANYBC36  4638         
   NOSEX36  4639            INFERT  4640             ANYBC12  4641         
   ANYMTHD  4642            NOSEX12  4643-4644       SEXP3MO  4645         
   CONSTAT1  4646-4647      CONSTAT2  4648-4649      CONSTAT3  4650-4651   
   CONSTAT4  4652-4653      PILLR  4654              CONDOMR  4655         
   SEX1MTHD1  4656-4657     SEX1MTHD2  4658-4659     SEX1MTHD3  4660-4661  
   SEX1MTHD4  4662-4663     MTHUSE12  4664-4665      METH12M1  4666-4667   
   METH12M2  4668-4669      METH12M3  4670-4671      METH12M4  4672        
   MTHUSE3  4673-4674       METH3M1  4675-4676       METH3M2  4677-4678    
   METH3M3  4679-4680       METH3M4  4681            FMETHOD1  4682-4683   
   FMETHOD2  4684-4685      FMETHOD3  4686-4687      FMETHOD4  4688-4689   
   DATEUSE1  4690-4694      OLDWP01  4695            OLDWP02  4696         
   OLDWP03  4697            OLDWP04  4698            OLDWP05  4699         
   OLDWP06  4700            OLDWP07  4701            OLDWP08  4702         
   OLDWP09  4703            OLDWP10  4704            OLDWP11  4705         
   OLDWP12  4706            OLDWP13  4707            OLDWP14  4708         
   OLDWP15  4709            OLDWP16  4710            OLDWP17  4711         
   OLDWP18  4712            OLDWP19  4713            OLDWP20  4714         
   OLDWR01  4715            OLDWR02  4716            OLDWR03  4717         
   OLDWR04  4718            OLDWR05  4719            OLDWR06  4720         
   OLDWR07  4721            OLDWR08  4722            OLDWR09  4723         
   OLDWR10  4724            OLDWR11  4725            OLDWR12  4726         
   OLDWR13  4727            OLDWR14  4728            OLDWR15  4729         
   OLDWR16  4730            OLDWR17  4731            OLDWR18  4732         
   OLDWR19  4733            OLDWR20  4734            WANTRP01  4735        
   WANTRP02  4736           WANTRP03  4737           WANTRP04  4738        
   WANTRP05  4739           WANTRP06  4740           WANTRP07  4741        
   WANTRP08  4742           WANTRP09  4743           WANTRP10  4744        
   WANTRP11  4745           WANTRP12  4746           WANTRP13  4747        
   WANTRP14  4748           WANTRP15  4749           WANTRP16  4750        
   WANTRP17  4751           WANTRP18  4752           WANTRP19  4753        
   WANTRP20  4754           WANTP01  4755            WANTP02  4756         
   WANTP03  4757            WANTP04  4758            WANTP05  4759         
   WANTP06  4760            WANTP07  4761            WANTP08  4762         
   WANTP09  4763            WANTP10  4764            WANTP11  4765         
   WANTP12  4766            WANTP13  4767            WANTP14  4768         
   WANTP15  4769            WANTP16  4770            WANTP17  4771         
   WANTP18  4772            WANTP19  4773            WANTP20  4774         
   NWWANTRP01  4775         NWWANTRP02  4776         NWWANTRP03  4777      
   NWWANTRP04  4778         NWWANTRP05  4779         NWWANTRP06  4780      
   NWWANTRP07  4781         NWWANTRP08  4782         NWWANTRP09  4783      
   NWWANTRP10  4784         NWWANTRP11  4785         NWWANTRP12  4786      
   NWWANTRP13  4787         NWWANTRP14  4788         NWWANTRP15  4789      
   NWWANTRP16  4790         NWWANTRP17  4791         NWWANTRP18  4792      
   NWWANTRP19  4793         NWWANTRP20  4794         WANTP5  4795          
   STRLOPER_I  4796         FECUND_I  4797           INFERT_I  4798        
   ANYMTHD_I  4799          NOSEX12_I  4800          SEX3MO_I  4801        
   CONSTAT1_I  4802         CONSTAT2_I  4803         CONSTAT3_I  4804      
   CONSTAT4_I  4805         PILLR_I  4806            CONDOMR_I  4807       
   SEX1MTHD1_I  4808        SEX1MTHD2_I  4809        SEX1MTHD3_I  4810     
   SEX1MTHD4_I  4811        MTHUSE12_I  4812         METH12M1_I  4813      
   METH12M2_I  4814         METH12M3_I  4815         METH12M4_I  4816      
   MTHUSE3_I  4817          METH3M1_I  4818          METH3M2_I  4819       
   METH3M3_I  4820          METH3M4_I  4821          FMETHOD1_I  4822      
   FMETHOD2_I  4823         FMETHOD3_I  4824         FMETHOD4_I  4825      
   DATEUSE1_I  4826         OLDWP01_I  4827          OLDWP02_I  4828       
   OLDWP03_I  4829          OLDWP04_I  4830          OLDWP05_I  4831       
   OLDWP06_I  4832          OLDWP07_I  4833          OLDWP08_I  4834       
   OLDWP09_I  4835          OLDWP10_I  4836          OLDWP11_I  4837       
   OLDWP12_I  4838          OLDWP13_I  4839          OLDWP14_I  4840       
   OLDWP15_I  4841          OLDWP16_I  4842          OLDWP17_I  4843       
   OLDWP18_I  4844          OLDWP19_I  4845          OLDWP20_I  4846       
   OLDWR01_I  4847          OLDWR02_I  4848          OLDWR03_I  4849       
   OLDWR04_I  4850          OLDWR05_I  4851          OLDWR06_I  4852       
   OLDWR07_I  4853          OLDWR08_I  4854          OLDWR09_I  4855       
   OLDWR10_I  4856          OLDWR11_I  4857          OLDWR12_I  4858       
   OLDWR13_I  4859          OLDWR14_I  4860          OLDWR15_I  4861       
   OLDWR16_I  4862          OLDWR17_I  4863          OLDWR18_I  4864       
   OLDWR19_I  4865          OLDWR20_I  4866          WANTRP01_I  4867      
   WANTRP02_I  4868         WANTRP03_I  4869         WANTRP04_I  4870      
   WANTRP05_I  4871         WANTRP06_I  4872         WANTRP07_I  4873      
   WANTRP08_I  4874         WANTRP09_I  4875         WANTRP10_I  4876      
   WANTRP11_I  4877         WANTRP12_I  4878         WANTRP13_I  4879      
   WANTRP14_I  4880         WANTRP15_I  4881         WANTRP16_I  4882      
   WANTRP17_I  4883         WANTRP18_I  4884         WANTRP19_I  4885      
   WANTRP20_I  4886         WANTP01_I  4887          WANTP02_I  4888       
   WANTP03_I  4889          WANTP04_I  4890          WANTP05_I  4891       
   WANTP06_I  4892          WANTP07_I  4893          WANTP08_I  4894       
   WANTP09_I  4895          WANTP10_I  4896          WANTP11_I  4897       
   WANTP12_I  4898          WANTP13_I  4899          WANTP14_I  4900       
   WANTP15_I  4901          WANTP16_I  4902          WANTP17_I  4903       
   WANTP18_I  4904          WANTP19_I  4905          WANTP20_I  4906       
   NWWANTRP01_I  4907       NWWANTRP02_I  4908       NWWANTRP03_I  4909    
   NWWANTRP04_I  4910       NWWANTRP05_I  4911       NWWANTRP06_I  4912    
   NWWANTRP07_I  4913       NWWANTRP08_I  4914       NWWANTRP09_I  4915    
   NWWANTRP10_I  4916       NWWANTRP11_I  4917       NWWANTRP12_I  4918    
   NWWANTRP13_I  4919       NWWANTRP14_I  4920       NWWANTRP15_I  4921    
   NWWANTRP16_I  4922       NWWANTRP17_I  4923       NWWANTRP18_I  4924    
   NWWANTRP19_I  4925       NWWANTRP20_I  4926       WANTP5_I  4927        
   FPTIT12  4928            FPTITMED  4929           FPTITSTE  4930-4931   
   FPTITBC  4932-4933       FPTITCHK  4934-4935      FPTITCBC  4936-4937   
   FPTITCST  4938-4939      FPTITEC  4940-4941       FPTITCEC  4942-4943   
   FPTITPRE  4944-4945      FPTITABO  4946-4947      FPTITPAP  4948-4949   
   FPTITPEL  4950-4951      FPTITPRN  4952-4953      FPTITPPR  4954-4955   
   FPTITSTD  4956-4957      FPREGFP  4958            FPREGMED  4959        
   FPTIT12_I  4960          FPTITMED_I  4961         FPTITSTE_I  4962      
   FPTITBC_I  4963          FPTITCHK_I  4964         FPTITCBC_I  4965      
   FPTITCST_I  4966         FPTITEC_I  4967          FPTITCEC_I  4968      
   FPTITPRE_I  4969         FPTITABO_I  4970         FPTITPAP_I  4971      
   FPTITPEL_I  4972         FPTITPRN_I  4973         FPTITPPR_I  4974      
   FPTITSTD_I  4975         FPREGFP_I  4976          FPREGMED_I  4977      
   INTENT  4978             ADDEXP  4979-4981        INTENT_I  4982        
   ADDEXP_I  4983           ANYPRGHP  4984           ANYMSCHP  4985        
   INFEVER  4986            OVULATE  4987            TUBES  4988           
   INFERTR  4989            INFERTH  4990            ADVICE  4991          
   INSEM  4992              INVITRO  4993            ENDOMET  4994         
   FIBROIDS  4995           PIDTREAT  4996           EVHIVTST  4997        
   FPTITHIV  4998-4999      ANYPRGHP_I  5000         ANYMSCHP_I  5001      
   INFEVER_I  5002          OVULATE_I  5003          TUBES_I  5004         
   INFERTR_I  5005          INFERTH_I  5006          ADVICE_I  5007        
   INSEM_I  5008            INVITRO_I  5009          ENDOMET_I  5010       
   FIBROIDS_I  5011         PIDTREAT_I  5012         EVHIVTST_I  5013      
   FPTITHIV_I  5014         CURR_INS  5015           METRO  5016           
   RELIGION  5017           LABORFOR  5018           CURR_INS_I  5019      
   METRO_I  5020            RELIGION_I  5021         LABORFOR_I  5022      
   POVERTY  5023-5025       TOTINCR  5026-5027       PUBASSIS  5028        
   POVERTY_I  5029          TOTINCR_I  5030          PUBASSIS_I  5031      
   WGT2013_2015  5032-5047   SECU  5048               SEST  5049-5051       
   CMINTVW  5052-5055       CMLSTYR  5056-5059       CMJAN3YR  5060-5063   
   CMJAN4YR  5064-5067      CMJAN5YR  5068-5071      QUARTER $ 5072-5073   
   PHASE $ 5074             INTVWYEAR $ 5075-5078    INTVLNGTH  5079-5084  
 ;                       


* SAS LABEL STATEMENT;

LABEL
   CASEID = "Respondent ID number"
   RSCRNINF = "Whether R was also the screener informant"
   RSCRAGE = "R's age as reported in screener"
   RSCRHISP = "R's Hispanic origin as reported in screener"
   RSCRRACE = "R's race as reported in screener"
   AGE_A = "AA-1 R's age at interview"
   AGE_R = "R's age at interview"
   CMBIRTH = "Century month for R's birth"
   AGESCRN = "R's age at screener"
   MARSTAT = "AB-1 R's marital status"
   FMARSTAT = "AB-2 R's formal marital status"
   FMARIT = "Formal marital status at time of interview"
   EVRMARRY = "Whether R was ever married"
   HISP = "AC-1 R is of Hispanic/Latina origin"
   HISPGRP = "AC-2 Hispanic/Latina origin -- group"
   PRIMLANG1 = "AC-6 Language spoken in home"
   PRIMLANG2 = "AC-6 Language spoken in home - 2nd mention"
   PRIMLANG3 = "AC-6 Language spoken in home - 3rd mention"
   ROSCNT = "Number of HH members based on HH roster"
   NUMCHILD = "Number of children in HH < 13 yrs with RELAR = codes 3 to 8"
   HHKIDS18 = "Number of children in HH < 19 yrs with RELAR = codes 3 to 10"
   DAUGHT918 = "Number of daughters in HH 9-18 yrs with RELAR = 3 or 5"
   SON918 = "Number of sons in HH 9-18 yrs with RELAR = 3 or 5"
   NONBIOKIDS = "Number of children in HH < 19 yrs with RELAR = codes 4 to 10"
   HPLOCALE = "AD-8 Where H/P currently lives, if not on HH roster"
   MANREL = "Man in HH is R's husband or cohabiting partner"
   GOSCHOL = "AF-1 R currently enrolled in regular school"
   VACA = "AF-2 R on vacation from school"
   HIGRADE = "AF-3 R's current grade in school or highest grade/year attended"
   COMPGRD = "AF-4 R completed current grade or highest grade/year attended"
   DIPGED = "AF-6 Which - high school diploma, GED, or both - does R have?"
   EARNHS_M = "AF-7 Month high school diploma obtained"
   EARNHS_Y = "AF-7 Year high school diploma obtained"
   CMHSGRAD = "Century month, high school graduation"
   HISCHGRD = "AF-8 R not in sch, no dipl-last grade of elem/jr/hi sch attended"
   LSTGRADE = "Highest grade of elem/junior/high school R attended"
   MYSCHOL_M = "AF-9 Month R last attended elem/jr/hi sch-R not in sch/no dipl"
   MYSCHOL_Y = "AF-9 Year R last attended elem/jr/hi sch-R not in sch/no dipl"
   CMLSTSCH = "Century month R last attended elem/jr/hi sch-not in sch/no dipl"
   HAVEDEG = "AF-10 R has college or university degree"
   DEGREES = "AF-11 R's highest college or university degree received"
   EARNBA_M = "AF-12 Month R received her Bachelor's degree"
   EARNBA_Y = "AF-12 Year R received her Bachelor's degree"
   EXPSCHL = "AF-13 Expect to go back to school"
   EXPGRADE = "AF-14 Highest grade/degree expect to complete"
   CMBAGRAD = "Century month R received her Bachelor's degree"
   WTHPARNW = "R is living with parents or parent figures - based on HH roster"
   ONOWN = "AG-0a Did R ever live away from parents/guardians before age 18"
   ONOWN18 = "Whether R lived on own before age 18"
   INTACT = "AG-1 R always lived with both biological/adoptive parents"
   PARMARR = "AG-2 R's biological parents married at R's birth"
   INTACT18 = "Whether R lived in intact family from birth to age 18"
   LVSIT14F = "AG-3 Female parent/parent-figure at age 14 - fam not intact thru 18"
   LVSIT14M = "AG-4 Male parent/parent-figure at age 14 - fam not intact thru 18"
   WOMRASDU = "AG-5 Woman who raised R during teens - fam not intact thru 18"
   MOMDEGRE = "AG-6 Highest level of education female parent (figure) completed"
   MOMWORKD = "AG-7 Female parent (figure) worked full/parttime when R was 5-15"
   MOMFSTCH = "AG-9 Age of female parent (figure) at her first birth"
   MOM18 = "AG-10 Estimated age of female parent (figure) at her first birth"
   MANRASDU = "AG-11 Man who raised R during teens - fam not intact thru 18"
   R_FOSTER = "Whether R is living/has lived with a foster parent (FC A-32a)"
   EVRFSTER = "AG-13 R ever lived in a foster home"
   MNYFSTER = "AG-14 Number of foster homes R lived in"
   DURFSTER = "AG-15 Total time spent in foster care"
   MENARCHE = "BA-1 Age at first menstrual period"
   PREGNOWQ = "BA-2 Whether R is currently pregnant"
   MAYBPREG = "BA-3 Whether R is probably pregnant now"
   NUMPREGS = "BB-1 Number of pregnancies in lifetime (including current)"
   EVERPREG = "Whether R has ever been pregnant"
   CURRPREG = "Whether R is currently pregnant"
   HOWPREG_N = "BB-2 Number of Weeks or Months Currently Pregnant"
   HOWPREG_P = "BB-2 Current pregnancy length reported in months or weeks"
   NOWPRGDK = "BB-3 Which Trimester -- Current Pregnancy"
   MOSCURRP = "Number of Months Currently Pregnant"
   NPREGS_S = "Total number of pregnancies (based on CCSD)"
   HASBABES = "Whether R has had any live births"
   NUMBABES = "Total number of liveborn babies (before CCSD)"
   NBABES_S = "Total number of liveborn babies (based on CCSD)"
   CMLASTLB = "CM date of R's most recent live birth"
   CMLSTPRG = "CM date of R's most recent completed pregnancy"
   CMFSTPRG = "CM date of R's 1st completed pregnancy"
   CMPG1BEG = "CM date when R's 1st pregnancy began"
   NPLACED = "# of R's bio children R placed for adoption (based on BPA)"
   NDIED = "# of R's bio children that died shortly after birth (BDS)"
   NADOPTV = "# of R's bio children living with adoptive families (based on BG-5 WHERENOW)"
   TOTPLACD = "# of R's bio children she (or someone) placed for adoption"
   OTHERKID = "BJ-1 Have any nonbiological children lived with R"
   NOTHRKID = "BJ-2 Number of nonbiological children who lived with R"
   SEXOTHKD = "BJ-4 Sex of nonbiological child who lived w/R - 1st child"
   RELOTHKD = "BJ-5 Relationship of nonbiological child to R - 1st child"
   ADPTOTKD = "BJ-6 R legally adopted nonbiological child - 1st child"
   TRYADOPT = "BJ-7a R trying to adopt nonbiological child - 1st child"
   TRYEITHR = "BJ-7b R trying to adopt/become guardian of nonbio child-1st child"
   STILHERE = "BJ-8 Nonbiological child still living with R - 1st child"
   DATKDCAM_M = "BJ-9 Month nonbiological child began living with R - 1st child"
   DATKDCAM_Y = "BJ-9 Year nonbiological child began living with R - 1st child"
   CMOKDCAM = "CM date when nonbiological child came to live with R - 1st child"
   OTHKDFOS = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 1st child"
   OKDDOB_M = "BJ-11 Month of nonbiological child's birth - 1st child"
   OKDDOB_Y = "BJ-11 Year of nonbiological child's birth - 1st child"
   CMOKDDOB = "CM DOB for nonbiological child - 1st child"
   OTHKDSPN = "BJ-12 Nonbiological child is of Hispanic origin - 1st child"
   OTHKDRAC1 = "BJ-13 Nonbiological child's race - 1st child, 1st mention"
   OTHKDRAC2 = "BJ-13 Nonbiological child's race - 1st child, 2nd mention"
   KDBSTRAC = "BJ-14 Race best descibes nonbiological child - 1st child"
   OKBORNUS = "BJ-15 Nonbiological child born outside the U.S. - 1st child"
   OKDISABL1 = "BJ-16 Nonbio child has phys/ment disability - 1st child, 1st mention"
   OKDISABL2 = "BJ-16 Nonbio child has phys/ment disability - 1st child, 2nd mention"
   SEXOTHKD2 = "BJ-4 Sex of nonbiological child who lived w/R - 2nd child"
   RELOTHKD2 = "BJ-5 Relationship of nonbiological child to R - 2nd child"
   ADPTOTKD2 = "BJ-6 R legally adopted nonbiological child - 2nd child"
   TRYADOPT2 = "BJ-7a R trying to adopt nonbiological child - 2nd child"
   TRYEITHR2 = "BJ-7b R trying to adopt/become guardian of nonbio child - 2nd child"
   STILHERE2 = "BJ-8 Nonbiological child still living with R - 2nd child"
   DATKDCAM_M2 = "BJ-9 Month nonbiological child began living with R - 2nd child"
   DATKDCAM_Y2 = "BJ-9 Year nonbiological child began living with R - 2nd child"
   CMOKDCAM2 = "CM date when nonbiological child came to live with R - 2nd child"
   OTHKDFOS2 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 2nd child"
   OKDDOB_M2 = "BJ-11 Month of nonbiological child's birth - 2nd child"
   OKDDOB_Y2 = "BJ-11 Year of nonbiological child's birth - 2nd child"
   CMOKDDOB2 = "CM DOB for nonbiological child - 2nd child"
   OTHKDSPN2 = "BJ-12 Nonbiological child is of Hispanic origin - 2nd child"
   OTHKDRAC6 = "BJ-13 Nonbiological child's race - 2nd child, 1st mention"
   OTHKDRAC7 = "BJ-13 Nonbiological child's race - 2nd child, 2nd mention"
   KDBSTRAC2 = "BJ-14 Race best descibes nonbiological child - 2nd child"
   OKBORNUS2 = "BJ-15 Nonbiological child born outside the U.S. - 2nd child"
   OKDISABL5 = "BJ-16 Nonbio child has phys/ment disability - 2nd child, 1st mention"
   OKDISABL6 = "BJ-16 Nonbio child has phys/ment disability - 2nd child, 2nd mention"
   SEXOTHKD3 = "BJ-4 Sex of nonbiological child who lived w/R - 3rd child"
   RELOTHKD3 = "BJ-5 Relationship of nonbiological child to R - 3rd child"
   ADPTOTKD3 = "BJ-6 R legally adopted nonbiological child - 3rd child"
   TRYADOPT3 = "BJ-7a R trying to adopt nonbiological child - 3rd child"
   TRYEITHR3 = "BJ-7b R trying to adopt/become guardian of nonbio child - 3rd child"
   STILHERE3 = "BJ-8 Nonbiological child still living with R - 3rd child"
   DATKDCAM_M3 = "BJ-9 Month nonbiological child began living with R - 3rd child"
   DATKDCAM_Y3 = "BJ-9 Year nonbiological child began living with R - 3rd child"
   CMOKDCAM3 = "CM date when nonbiological child came to live with R - 3rd child"
   OTHKDFOS3 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 3rd child"
   OKDDOB_M3 = "BJ-11 Month of nonbiological child's birth - 3rd child"
   OKDDOB_Y3 = "BJ-11 Year of nonbiological child's birth - 3rd child"
   CMOKDDOB3 = "CM DOB for nonbiological child - 3rd child"
   OTHKDSPN3 = "BJ-12 Nonbiological child is of Hispanic origin - 3rd child"
   OTHKDRAC11 = "BJ-13 Nonbiological child's race - 3rd child, 1st mention"
   OTHKDRAC12 = "BJ-13 Nonbiological child's race - 3rd child, 2nd mention"
   KDBSTRAC3 = "BJ-14 Race best descibes nonbiological child - 3rd child"
   OKBORNUS3 = "BJ-15 Nonbiological child born outside the U.S. - 3rd child"
   OKDISABL9 = "BJ-16 Nonbio child has phys/ment disability - 3rd child, 1st mention"
   OKDISABL10 = "BJ-16 Nonbio child has phys/ment disability - 3rd child, 2nd mention"
   SEXOTHKD4 = "BJ-4 Sex of nonbiological child who lived w/R - 4th child"
   RELOTHKD4 = "BJ-5 Relationship of nonbiological child to R - 4th child"
   ADPTOTKD4 = "BJ-6 R legally adopted nonbiological child - 4th child"
   TRYADOPT4 = "BJ-7a R trying to adopt nonbiological child - 4th child"
   TRYEITHR4 = "BJ-7b R trying to adopt/become guardian of nonbio child - 4th child"
   STILHERE4 = "BJ-8 Nonbiological child still living with R - 4th child"
   DATKDCAM_M4 = "BJ-9 Month nonbiological child began living with R - 4th child"
   DATKDCAM_Y4 = "BJ-9 Year nonbiological child began living with R - 4th child"
   CMOKDCAM4 = "CM date when nonbiological child came to live with R - 4th child"
   OTHKDFOS4 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 4th child"
   OKDDOB_M4 = "BJ-11 Month of nonbiological child's birth - 4th child"
   OKDDOB_Y4 = "BJ-11 Year of nonbiological child's birth - 4th child"
   CMOKDDOB4 = "CM DOB for nonbiological child - 4th child"
   OTHKDSPN4 = "BJ-12 Nonbiological child is of Hispanic origin - 4th child"
   OTHKDRAC16 = "BJ-13 Nonbiological child's race - 4th child, 1st mention"
   OTHKDRAC17 = "BJ-13 Nonbiological child's race - 4th child, 2nd mention"
   KDBSTRAC4 = "BJ-14 Race best descibes nonbiological child - 4th child"
   OKBORNUS4 = "BJ-15 Nonbiological child born outside the U.S. - 4th child"
   OKDISABL13 = "BJ-16 Nonbio child has phys/ment disability - 4th child, 1st mention"
   OKDISABL14 = "BJ-16 Nonbio child has phys/ment disability - 4th child, 2nd mention"
   SEXOTHKD5 = "BJ-4 Sex of nonbiological child who lived w/R - 5th child"
   RELOTHKD5 = "BJ- 5 Relationship of nonbiological child to R - 5th child"
   ADPTOTKD5 = "BJ-6 R legally adopted nonbiological child - 5th child"
   TRYADOPT5 = "BJ-7a R trying to adopt nonbiological child - 5th child"
   TRYEITHR5 = "BJ-7b R trying to adopt/become guardian of nonbio child - 5th child"
   STILHERE5 = "BJ-8 Nonbiological child still living with R - 5th child"
   DATKDCAM_M5 = "BJ-9 Month nonbiological child began living with R - 5th child"
   DATKDCAM_Y5 = "BJ-9 Year nonbiological child began living with R - 5th child"
   CMOKDCAM5 = "CM date when nonbiological child came to live with R - 5th child"
   OTHKDFOS5 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 5th child"
   OKDDOB_M5 = "BJ-11 Month of nonbiological child's birth - 5th child"
   OKDDOB_Y5 = "BJ-11 Year of nonbiological child's birth - 5th child"
   CMOKDDOB5 = "CM DOB for nonbiological child - 5th child"
   OTHKDSPN5 = "BJ-12 Nonbiological child is of Hispanic origin - 5th child"
   OTHKDRAC21 = "BJ-13 Nonbiological child's race - 5th child, 1st mention"
   OTHKDRAC22 = "BJ-13 Nonbiological child's race - 5th child, 2nd mention"
   KDBSTRAC5 = "BJ-14 Race best descibes nonbiological child - 5th child"
   OKBORNUS5 = "BJ-15 Nonbiological child born outside the U.S. - 5th child"
   OKDISABL17 = "BJ-16 Nonbio child has phys/ment disability - 5th child, 1st mention"
   OKDISABL18 = "BJ-16 Nonbio child has phys/ment disability - 5th child, 2nd mention"
   SEXOTHKD6 = "BJ-4 Sex of nonbiological child who lived w/R - 6th child"
   RELOTHKD6 = "BJ-5 Relationship of nonbiological child to R - 6th child"
   ADPTOTKD6 = "BJ-6 R legally adopted nonbiological child - 6th child"
   TRYADOPT6 = "BJ-7a R trying to adopt nonbiological child - 6th child"
   TRYEITHR6 = "BJ-7b R trying to adopt/become guardian of nonbio child - 6th child"
   STILHERE6 = "BJ-8 Nonbiological child still living with R - 6th child"
   DATKDCAM_M6 = "BJ-9 Month nonbiological child began living with R - 6th child"
   DATKDCAM_Y6 = "BJ-9 Year nonbiological child began living with R - 6th child"
   CMOKDCAM6 = "CM date when nonbiological child came to live with R - 6th child"
   OTHKDFOS6 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 6th child"
   OKDDOB_M6 = "BJ-11 Month of nonbiological child's birth - 6th child"
   OKDDOB_Y6 = "BJ-11 Year of nonbiological child's birth - 6th child"
   CMOKDDOB6 = "CM DOB for nonbiological child - 6th child"
   OTHKDSPN6 = "BJ-12 Nonbiological child is of Hispanic origin - 6th child"
   OTHKDRAC26 = "BJ-13 Nonbiological child's race - 6th child, 1st mention"
   OTHKDRAC27 = "BJ-13 Nonbiological child's race - 6th child, 2nd mention"
   KDBSTRAC6 = "BJ-14 Race best descibes nonbiological child - 6th child"
   OKBORNUS6 = "BJ-15 Nonbiological child born outside the U.S. - 6th child"
   OKDISABL21 = "BJ-16 Nonbio child has phys/ment disability - 6th child, 1st mention"
   OKDISABL22 = "BJ-16 Nonbio child has phys/ment disability - 6th child, 2nd mention"
   SEXOTHKD7 = "BJ-4 Sex of nonbiological child who lived w/R - 7th child"
   RELOTHKD7 = "BJ-5 Relationship of nonbiological child to R - 7th child"
   ADPTOTKD7 = "BJ-6 R legally adopted nonbiological child - 7th child"
   TRYADOPT7 = "BJ-7a R trying to adopt nonbiological child - 7th child"
   TRYEITHR7 = "BJ-7b R trying to adopt/become guardian of nonbio child -7th child"
   STILHERE7 = "BJ-8 Nonbiological child still living with R - 7th child"
   DATKDCAM_M7 = "BJ-9 Month nonbiological child began living with R - 7th child"
   DATKDCAM_Y7 = "BJ-9 Year nonbiological child began living with R - 7th child"
   CMOKDCAM7 = "CM date when nonbiological child came to live with R - 7th child"
   OTHKDFOS7 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs -7th child"
   OKDDOB_M7 = "BJ-11 Month of nonbiological child's birth - 7th child"
   OKDDOB_Y7 = "BJ-11 Year of nonbiological child's birth - 7th child"
   CMOKDDOB7 = "CM DOB for nonbiological child - 7th child"
   OTHKDSPN7 = "BJ-12 Nonbiological child is of Hispanic origin - 7th child"
   OTHKDRAC31 = "BJ-13 Nonbiological child's race - 7th child, 1st mention"
   OTHKDRAC32 = "BJ-13 Nonbiological child's race - 7th child, 2nd mention"
   KDBSTRAC7 = "BJ-14 Race best descibes nonbiological child - 7th child"
   OKBORNUS7 = "BJ-15 Nonbiological child born outside the U.S. - 7th child"
   OKDISABL25 = "BJ-16 Nonbio child has phys/ment disability - 7th child, 1st mention"
   OKDISABL26 = "BJ-16 Nonbio child has phys/ment disability - 7th child, 2nd mention"
   SEXOTHKD8 = "BJ-4 Sex of nonbiological child who lived w/R - 8th child"
   RELOTHKD8 = "BJ-5 Relationship of nonbiological child to R - 8th child"
   ADPTOTKD8 = "BJ-6 R legally adopted nonbiological child - 8th child"
   TRYADOPT8 = "BJ-7a R trying to adopt nonbiological child - 8th child"
   TRYEITHR8 = "BJ-7b R trying to adopt/become guardian of nonbio child - 8th child"
   STILHERE8 = "BJ-8 Nonbiological child still living with R - 8th child"
   DATKDCAM_M8 = "BJ-9 Month nonbiological child began living with R - 8th child"
   DATKDCAM_Y8 = "BJ-9 Year nonbiological child began living with R - 8th child"
   CMOKDCAM8 = "CM date when nonbiological child came to live with R - 8th child"
   OTHKDFOS8 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 8th child"
   OKDDOB_M8 = "BJ-11 Month of nonbiological child's birth - 8th child"
   OKDDOB_Y8 = "BJ-11 Year of nonbiological child's birth - 8th child"
   CMOKDDOB8 = "CM DOB for nonbiological child - 8th child"
   OTHKDSPN8 = "BJ-12 Nonbiological child is of Hispanic origin - 8th child"
   OTHKDRAC36 = "BJ-13 Nonbiological child's race - 8th child, 1st mention"
   OTHKDRAC37 = "BJ-13 Nonbiological child's race - 8th child, 2nd mention"
   KDBSTRAC8 = "BJ-14 Race best descibes nonbiological child - 8th child"
   OKBORNUS8 = "BJ-15 Nonbiological child born outside the U.S. - 8th child"
   OKDISABL29 = "BJ-16 Nonbio child has phys/ment disability - 8th child, 1st mention"
   OKDISABL30 = "BJ-16 Nonbio child has phys/ment disability - 8th child, 2nd mention"
   SEXOTHKD9 = "BJ-4 Sex of nonbiological child who lived w/R - 9th child"
   RELOTHKD9 = "BJ-5 Relationship of nonbiological child to R - 9th child"
   ADPTOTKD9 = "BJ-6 R legally adopted nonbiological child - 9th child"
   TRYADOPT9 = "BJ-7a R trying to adopt nonbiological child - 9th child"
   TRYEITHR9 = "BJ-7b R trying to adopt/become guardian of nonbio child 9th child"
   STILHERE9 = "BJ-8 Nonbiological child still living with R - 9th child"
   DATKDCAM_M9 = "BJ-9 Month nonbiological child began living with R - 9th child"
   DATKDCAM_Y9 = "BJ-9 Year nonbiological child began living with R - 9th child"
   CMOKDCAM9 = "CM date when nonbiological child came to live with R - 9th child"
   OTHKDFOS9 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 9th child"
   OKDDOB_M9 = "BJ-11 Month of nonbiological child's birth - 9th child"
   OKDDOB_Y9 = "BJ-11 Year of nonbiological child's birth - 9th child"
   CMOKDDOB9 = "CM DOB for nonbiological child - 9th child"
   OTHKDSPN9 = "BJ-12 Nonbiological child is of Hispanic origin - 9th child"
   OTHKDRAC41 = "BJ-13 Nonbiological child's race - 9th child, 1st mention"
   OTHKDRAC42 = "BJ-13 Nonbiological child's race - 9th child, 2nd mention"
   KDBSTRAC9 = "BJ-14 Race best descibes nonbiological child - 9th child"
   OKBORNUS9 = "BJ-15 Nonbiological child born outside the U.S. - 9th child"
   OKDISABL33 = "BJ-16 Nonbio child has phys/ment disability - 9th child, 1st mention"
   OKDISABL34 = "BJ-16 Nonbio child has phys/ment disability - 9th child, 2nd mention"
   SEXOTHKD10 = "BJ-4 Sex of nonbiological child who lived w/R - 10th child"
   RELOTHKD10 = "BJ-5 Relationship of nonbiological child to R - 10th child"
   ADPTOTKD10 = "BJ-6 R legally adopted nonbiological child - 10th child"
   TRYADOPT10 = "BJ-7a R trying to adopt nonbiological child - 10th child"
   TRYEITHR10 = "BJ-7b R trying to adopt/become guardian of nonbio child - 10th child"
   STILHERE10 = "BJ-8 Nonbiological child still living with R - 10th child"
   DATKDCAM_M10 = "BJ-9 Month nonbiological child began living with R - 10th child"
   DATKDCAM_Y10 = "BJ-9 Year nonbiological child began living with R - 10th child"
   CMOKDCAM10 = "CM date when nonbiological child came to live with R - 10th child"
   OTHKDFOS10 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 10th child"
   OKDDOB_M10 = "BJ-11 Month of nonbiological child's birth - 10th child"
   OKDDOB_Y10 = "BJ-11 Year of nonbiological child's birth - 10th child"
   CMOKDDOB10 = "CM DOB for nonbiological child - 10th child"
   OTHKDSPN10 = "BJ-12 Nonbiological child is of Hispanic origin - 10th child"
   OTHKDRAC46 = "BJ-13 Nonbiological child's race - 10th child, 1st mention"
   OTHKDRAC47 = "BJ-13 Nonbiological child's race - 10th child, 2nd mention"
   KDBSTRAC10 = "BJ-14 Race best descibes nonbiological child - 10th child"
   OKBORNUS10 = "BJ-15 Nonbiological child born outside the U.S. - 10th child"
   OKDISABL37 = "BJ-16 Nonbio child has phys/ment disability - 10th child, 1st mention"
   OKDISABL38 = "BJ-16 Nonbio child has phys/ment disability - 10th child, 2nd mention"
   SEXOTHKD11 = "BJ-4 Sex of nonbiological child who lived w/R - 11th child"
   RELOTHKD11 = "BJ-5 Relationship of nonbiological child to R - 11th child"
   ADPTOTKD11 = "BJ-6 R legally adopted nonbiological child - 11th child"
   TRYADOPT11 = "BJ-7a R trying to adopt nonbiological child - 11th child"
   TRYEITHR11 = "BJ-7b R trying to adopt/become guardian of nonbio child - 11th child"
   STILHERE11 = "BJ-8 Nonbiological child still living with R - 11th child"
   DATKDCAM_M11 = "BJ-9 Month nonbiological child began living with R - 11th child"
   DATKDCAM_Y11 = "BJ-9 Year nonbiological child began living with R - 11th child"
   CMOKDCAM11 = "CM date when nonbiological child came to live with R - 11th child"
   OTHKDFOS11 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 11th child"
   OKDDOB_M11 = "BJ-11 Month of nonbiological child's birth - 11th child"
   OKDDOB_Y11 = "BJ-11 Year of nonbiological child's birth - 11th child"
   CMOKDDOB11 = "CM DOB for nonbiological child - 11th child"
   OTHKDSPN11 = "BJ-12 Nonbiological child is of Hispanic origin - 11th child"
   OTHKDRAC51 = "BJ-13 Nonbiological child's race - 11th child, 1st mention"
   OTHKDRAC52 = "BJ-13 Nonbiological child's race - 11th child, 2nd mention"
   KDBSTRAC11 = "BJ-14 Race best descibes nonbiological child - 11th child"
   OKBORNUS11 = "BJ-15 Nonbiological child born outside the U.S. - 11th child"
   OKDISABL41 = "BJ-16 Nonbio child has phys/ment disability - 11th child, 1st mention"
   OKDISABL42 = "BJ-16 Nonbio child has phys/ment disability - 11th child, 2nd mention"
   SEXOTHKD12 = "BJ-4 Sex of nonbiological child who lived w/R - 12th child"
   RELOTHKD12 = "BJ-5 Relationship of nonbiological child to R - 12th child"
   ADPTOTKD12 = "BJ-6 R legally adopted nonbiological child - 12th child"
   TRYADOPT12 = "BJ-7a R trying to adopt nonbiological child - 12th child"
   TRYEITHR12 = "BJ-7b R trying to adopt/become guardian of nonbio child - 12th child"
   STILHERE12 = "BJ-8 Nonbiological child still living with R - 12th child"
   DATKDCAM_M12 = "BJ-9 Month nonbiological child began living with R - 12th child"
   DATKDCAM_Y12 = "BJ-9 Year nonbiological child began living with R - 12th child"
   CMOKDCAM12 = "CM date when nonbiological child came to live with R - 12th child"
   OTHKDFOS12 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 12th child"
   OKDDOB_M12 = "BJ-11 Month of nonbiological child's birth - 12th child"
   OKDDOB_Y12 = "BJ-11 Year of nonbiological child's birth - 12th child"
   CMOKDDOB12 = "CM DOB for nonbiological child - 12th child"
   OTHKDSPN12 = "BJ-12 Nonbiological child is of Hispanic origin - 12th child"
   OTHKDRAC56 = "BJ-13 Nonbiological child's race - 12th child, 1st mention"
   OTHKDRAC57 = "BJ-13 Nonbiological child's race - 12th child, 2nd mention"
   KDBSTRAC12 = "BJ-14 Race best descibes nonbiological child - 12th child"
   OKBORNUS12 = "BJ-15 Nonbiological child born outside the U.S. - 12th child"
   OKDISABL45 = "BJ-16 Nonbio child has phys/ment disability - 12th child, 1st mention"
   OKDISABL46 = "BJ-16 Nonbio child has phys/ment disability - 12th child, 2nd mention"
   SEXOTHKD13 = "BJ-4 Sex of nonbiological child who lived w/R - 13th child"
   RELOTHKD13 = "BJ-5 Relationship of nonbiological child to R - 13th child"
   ADPTOTKD13 = "BJ-6 R legally adopted nonbiological child - 13th child"
   TRYADOPT13 = "BJ-7a R trying to adopt nonbiological child - 13th child"
   TRYEITHR13 = "BJ-7b R trying to adopt/become guardian of nonbio child - 13th child"
   STILHERE13 = "BJ-8 Nonbiological child still living with R - 13th child"
   DATKDCAM_M13 = "BJ-9 Month nonbiological child began living with R - 13th child"
   DATKDCAM_Y13 = "BJ-9 Year nonbiological child began living with R - 13th child"
   CMOKDCAM13 = "CM date when nonbiological child came to live with R - 13th child"
   OTHKDFOS13 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 13th child"
   OKDDOB_M13 = "BJ-11 Month of nonbiological child's birth - 13th child"
   OKDDOB_Y13 = "BJ-11 Year of nonbiological child's birth - 13th child"
   CMOKDDOB13 = "CM DOB for nonbiological child - 13th child"
   OTHKDSPN13 = "BJ-12 Nonbiological child is of Hispanic origin - 13th child"
   OTHKDRAC61 = "BJ-13 Nonbiological child's race - 13th child, 1st mention"
   OTHKDRAC62 = "BJ-13 Nonbiological child's race - 13th child, 2nd mention"
   KDBSTRAC13 = "BJ-14 Race best descibes nonbiological child - 13th child"
   OKBORNUS13 = "BJ-15 Nonbiological child born outside the U.S. - 13th child"
   OKDISABL49 = "BJ-16 Nonbio child has phys/ment disability - 13th child, 1st mention"
   OKDISABL50 = "BJ-16 Nonbio child has phys/ment disability - 13th child, 2nd mention"
   SEXOTHKD14 = "BJ-4 Sex of nonbiological child who lived w/R - 14th child"
   RELOTHKD14 = "BJ-5 Relationship of nonbiological child to R - 14th child"
   ADPTOTKD14 = "BJ-6 R legally adopted nonbiological child - 14th child"
   TRYADOPT14 = "BJ-7a R trying to adopt nonbiological child - 14th child"
   TRYEITHR14 = "BJ-7b R trying to adopt/become guardian of nonbio child - 14th child"
   STILHERE14 = "BJ-8 Nonbiological child still living with R - 14th child"
   DATKDCAM_M14 = "BJ-9 Month nonbiological child began living with R - 14th child"
   DATKDCAM_Y14 = "BJ-9 Year nonbiological child began living with R - 14th child"
   CMOKDCAM14 = "CM date when nonbiological child came to live with R - 14th child"
   OTHKDFOS14 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 14th child"
   OKDDOB_M14 = "BJ-11 Month of nonbiological child's birth - 14th child"
   OKDDOB_Y14 = "BJ-11 Year of nonbiological child's birth - 14th child"
   CMOKDDOB14 = "CM DOB for nonbiological child - 14th child"
   OTHKDSPN14 = "BJ-12 Nonbiological child is of Hispanic origin - 14th child"
   OTHKDRAC66 = "BJ-13 Nonbiological child's race - 14th child, 1st mention"
   OTHKDRAC67 = "BJ-13 Nonbiological child's race - 14th child, 2nd mention"
   KDBSTRAC14 = "BJ-14 Race best descibes nonbiological child - 14th child"
   OKBORNUS14 = "BJ-15 Nonbiological child born outside the U.S. - 14th child"
   OKDISABL53 = "BJ-16 Nonbio child has phys/ment disability - 14th child, 1st mention"
   OKDISABL54 = "BJ-16 Nonbio child has phys/ment disability - 14th child, 2nd mention"
   SEXOTHKD15 = "BJ-4 Sex of nonbiological child who lived w/R - 15th child"
   RELOTHKD15 = "BJ-5 Relationship of nonbiological child to R - 15th child"
   ADPTOTKD15 = "BJ-6 R legally adopted nonbiological child - 15th child"
   TRYADOPT15 = "BJ-7a R trying to adopt nonbiological child - 15th child"
   TRYEITHR15 = "BJ-7b R trying to adopt/become guardian of nonbio child - 15th child"
   STILHERE15 = "BJ-8 Nonbiological child still living with R - 15th child"
   DATKDCAM_M15 = "BJ-9 Month nonbiological child began living with R - 15th child"
   DATKDCAM_Y15 = "BJ-9 Year nonbiological child began living with R - 15th child"
   CMOKDCAM15 = "CM date when nonbiological child came to live with R - 15th child"
   OTHKDFOS15 = "BJ-10 Child was foster/related child placed w/R by Soc Svcs - 15th child"
   OKDDOB_M15 = "BJ-11 Month of nonbiological child's birth - 15th child"
   OKDDOB_Y15 = "BJ-11 Year of nonbiological child's birth - 15th child"
   CMOKDDOB15 = "CM DOB for nonbiological child - 15th child"
   OTHKDSPN15 = "BJ-12 Nonbiological child is of Hispanic origin - 15th child"
   OTHKDRAC71 = "BJ-13 Nonbiological child's race - 15th child, 1st mention"
   OTHKDRAC72 = "BJ-13 Nonbiological child's race - 15th child, 2nd mention"
   KDBSTRAC15 = "BJ-14 Race best descibes nonbiological child - 15th child"
   OKBORNUS15 = "BJ-15 Nonbiological child born outside the U.S. - 15th child"
   OKDISABL57 = "BJ-16 Nonbio child has phys/ment disability - 15th child, 1st mention"
   OKDISABL58 = "BJ-16 Nonbio child has phys/ment disability - 15th child, 2nd mention"
   EVERADPT = "R's experience with adoption (based on BJ series)"
   SEEKADPT = "BK-1 R is currently seeking to adopt"
   CONTAGEM = "BK-2 R has taken specific steps to adopt"
   TRYLONG = "BK-3 How long R has been seeking to adopt"
   KNOWADPT = "BK-4 R is seeking to adopt a child she knows"
   CHOSESEX = "BK-5 Sex of child R prefers to adopt"
   TYPESEXF = "BK-6a R prefers a boy, would accept a girl"
   TYPESEXM = "BK-6b R prefers a girl, would accept a boy"
   CHOSRACE = "BK-7 Race of child R prefers to adopt"
   TYPRACBK = "BK-8a R prefers white/other race child, would accept a black child"
   TYPRACWH = "BK-8b R prefers black/other race child, would accept a white child"
   TYPRACOT = "BK-8c R prefers white/black child, would accept an other race child"
   CHOSEAGE = "BK-9 Age of child R prefers to adopt"
   TYPAGE2M = "BK-10a R prefers different age, would accept a child 2 or younger"
   TYPAGE5M = "BK-10b R prefers different age, would accept a child 2-5 years old"
   TYPAG12M = "BK-10c R prefers different age, would accept a child 6-12 years old"
   TYPAG13M = "BK-10d R prefers different age, would accept a child 13 or older"
   CHOSDISB = "BK-11 Disability status of child R prefers to adopt"
   TYPDISBN = "BK-12a R prefers diff status, would accept child w/out disability"
   TYPDISBM = "BK-12b R prefers diff status, would accept child w/mild disability"
   TYPDISBS = "BK-12c R prefers diff status, would accept child w/severe disability"
   CHOSENUM = "BK-13 Number of children R prefers to adopt"
   TYPNUM1M = "BK-14a R prefers 2 or more siblings, would accept a single child"
   TYPNUM2M = "BK-14b R prefers single child, would accept 2 or more siblings"
   EVWNTANO = "BL-1 R has ever considered adopting a child"
   EVCONTAG = "BL-2 R has ever taken specific steps to adopt a child"
   TURNDOWN = "BL-3 R was turned down for/decided not to pursue adoption"
   YQUITTRY = "BL-4 R decided not to pursue adoption because of adoption process or own situation"
   APROCESS1 = "BL-5 If adoption process, reason R stopped seeking to adopt - 1st mention"
   APROCESS2 = "BL-5 If adoption process, reason R stopped seeking to adopt - 2nd mention"
   HRDEMBRYO = "BL-6 R has heard of frozen embryo donation or adoption"
   TIMESMAR = "CA-1 Number of Times R Has Been Married"
   HSBVERIF = "CA-2b Verify Current Husband's Name"
   WHMARHX_M = "CB-1m Month Married to 1st Husband"
   WHMARHX_Y = "CB-1y Year Married to 1st Husband"
   CMMARRHX = "CM for Date of 1st Marriage"
   AGEMARHX = "CB-2 R's Age at Marriage-1st Husband"
   HXAGEMAR = "CB-3 Husband's Age At Marriage-1st Husband"
   DOBHUSBX_M = "CB-4m Month Husband Was Born-1st Husband"
   DOBHUSBX_Y = "CB-4y Year Husband Was Born-1st Husband"
   CMHSBDOBX = "CM for 1st Husband's Date of Birth"
   LVTOGHX = "CB-5 Cohabited Before Marriage-1st Husband"
   STRTOGHX_M = "CB-6m Month Began 1st Cohabitation-1st Husband"
   STRTOGHX_Y = "CB-6y Year Began 1st Cohabitation-1st Husband"
   CMPMCOHX = "CM Date When R Began Living (premaritally) with 1st husband"
   ENGAGHX = "CB-7 Engaged When R Began Premarital Cohabitation-1st Husband"
   HSBMULT1 = "Multiple races reported for 1st husband"
   HSBRACE1 = "RACE-recode-like variable for 1st husband"
   HSBHRACE1 = "HISPRACE-recode-like variable for 1st husband"
   HSBNRACE1 = "HISPRACE2-recode-like variable for 1st husband"
   CHEDMARN = "CB-11 Highest Level of Education-1st Husband"
   MARBEFHX = "CB-12 Was He Married Before-1st Husband"
   KIDSHX = "CB-13 Did He Have Kids From Prior Relationship-1st Husband"
   NUMKDSHX = "CB-14 Number of Kids From Prior Relationships-1st Husband"
   KIDLIVHX = "CB-15 Any Kids From Prior Relationships Live w/R & 1st Husband"
   CHKID18A = "CB-16a Is This Child 18 or Younger - Curr (if 1st) Husband"
   CHKID18B = "CB-16b # of These Children 18 or Younger - Curr (if 1st) Husband"
   WHRCHKDS1 = "CB-17 Where Current (if 1st) Husband's Child(ren) Lives Now-1st Mention"
   WHRCHKDS2 = "CB-17 Where Current (if 1st) Husband's Child(ren) Lives Now-2nd Mention"
   WHRCHKDS3 = "CB-17 Where Current (if 1st) Husband's Child(ren) Lives Now-3rd Mention"
   WHRCHKDS4 = "CB-17 Where Curr Husband's Child(ren) Lives Now-4th Mention"
   SUPPORCH = "CB-18 Does Current (if 1st) Husband Financially Support Kids <=18 Elsewhere"
   BIOHUSBX = "CB-18b Did R have bio kids with this husband- 1st Husband"
   BIONUMHX = "CB-18c Number of bio kids R and husband had together-1st Husband"
   MARENDHX = "CB-19 How Marriage Ended-1st Husband"
   WNDIEHX_M = "CB-20m Month of Death-1st Husband"
   WNDIEHX_Y = "CB-20y Year of Death-1st Husband"
   CMHSBDIEX = "CM for Date When 1st Husband Died"
   DIVDATHX_M = "CB-21m Month of Divorce-1st Husband"
   DIVDATHX_Y = "CB-21y Year of Divorce-1st Husband"
   CMDIVORCX = "CM for Date of Divorce or Annulment From 1st Husband"
   WNSTPHX_M = "CB-22m Month Stopped Living Together-1st Husband"
   WNSTPHX_Y = "CB-22y Year Stopped Living Together-1st Husband"
   CMSTPHSBX = "CM for Date R Stopped Living with 1st Husband"
   WHMARHX_M2 = "CB-1m Month Married to 2nd Husband"
   WHMARHX_Y2 = "CB-1y Year Married to 2nd Husband"
   CMMARRHX2 = "CM for Date of 2nd Marriage"
   AGEMARHX2 = "CB-2 R's Age at Marriage-2nd Husband"
   HXAGEMAR2 = "CB-3 Husband's Age At Marriage-2nd Husband"
   DOBHUSBX_M2 = "CB-4m Month Husband Was Born-2nd Husband"
   DOBHUSBX_Y2 = "CB-4y Year Husband Was Born-2nd Husband"
   CMHSBDOBX2 = "CM for 2nd Husband's Date of Birth"
   LVTOGHX2 = "CB-5 Cohabited Before Marriage-2nd Husband"
   STRTOGHX_M2 = "CB-6m Month Began 1st Cohabitation-2nd Husband"
   STRTOGHX_Y2 = "CB-6y Year Began 1st Cohabitation-2nd Husband"
   CMPMCOHX2 = "CM Date When R Began Living (premaritally) with 2nd husband"
   ENGAGHX2 = "CB-7 Engaged When R Began Premarital Cohabitation-2nd Husband"
   HSBMULT2 = "Multiple races reported for 2nd husband"
   HSBRACE2 = "RACE-recode-like variable for 2nd husband"
   HSBHRACE2 = "HISPRACE-recode-like variable for 2nd husband"
   HSBNRACE2 = "HISPRACE2-recode-like variable for 2nd husband"
   CHEDMARN2 = "CB-11 Highest Level of Education-2nd Husband"
   MARBEFHX2 = "CB-12 Was He Married Before-2nd Husband"
   KIDSHX2 = "CB-13 Did He Have Kids From Prior Relationship-2nd Husband"
   NUMKDSHX2 = "CB-14 Number of Kids From Prior Relationships-2nd Husband"
   KIDLIVHX2 = "CB-15 Any Kids From Prior Relationships Live w/R & 2nd Husband"
   CHKID18A2 = "CB-16a Is This Child 18 or Younger - Curr (if 2nd) Husband"
   CHKID18B2 = "CB-16b # of These Children 18 or Younger - Curr (if 2nd) Husband"
   WHRCHKDS5 = "CB-17 Where Current (if 2nd) Husband's Child(ren) Lives Now-1st Mention"
   WHRCHKDS6 = "CB-17 Where Current (if 2nd) Husband's Child(ren) Lives Now-2nd Mention"
   WHRCHKDS7 = "CB-17 Where Current (if 2nd) Husband's Child(ren) Lives Now-3rd Mention"
   WHRCHKDS8 = "CB-17 Where Curr Husband's Child(ren) Lives Now-4th Mention"
   SUPPORCH2 = "CB-18 Does Current (if 2nd) Husband Financially Support Kids <=18 Elsewhere"
   BIOHUSBX2 = "CB-18b Did R have bio kids with this husband-2nd Husband"
   BIONUMHX2 = "CB-18c Number of bio kids R and husband had together-2nd Husband"
   MARENDHX2 = "CB-19 How Marriage Ended-2nd Husband"
   WNDIEHX_M2 = "CB-20m Month of Death-2nd Husband"
   WNDIEHX_Y2 = "CB-20y Year of Death-2nd Husband"
   CMHSBDIEX2 = "CM for Date When 2nd Husband Died"
   DIVDATHX_M2 = "CB-21m Month of Divorce-2nd Husband"
   DIVDATHX_Y2 = "CB-21y Year of Divorce-2nd Husband"
   CMDIVORCX2 = "CM for Date of Divorce or Annulment From 2nd Husband"
   WNSTPHX_M2 = "CB-22m Month Stopped Living Together-2nd Husband"
   WNSTPHX_Y2 = "CB-22y Year Stopped Living Together-2nd Husband"
   CMSTPHSBX2 = "CM for Date R Stopped Living with 2nd Husband"
   WHMARHX_M3 = "CB-1m Month Married to 3rd Husband"
   WHMARHX_Y3 = "CB-1y Year Married to 3rd Husband"
   CMMARRHX3 = "CM for Date of 3rd Marriage"
   AGEMARHX3 = "CB-2 R's Age at Marriage-3rd Husband"
   HXAGEMAR3 = "CB-3 Husband's Age At Marriage-3rd Husband"
   DOBHUSBX_M3 = "CB-4m Month Husband Was Born-3rd Husband"
   DOBHUSBX_Y3 = "CB-4y Year Husband Was Born-3rd Husband"
   CMHSBDOBX3 = "CM for 3rd Husband's Date of Birth"
   LVTOGHX3 = "CB-5 Cohabited Before Marriage-3rd Husband"
   STRTOGHX_M3 = "CB-6m Month Began 1st Cohabitation-3rd Husband"
   STRTOGHX_Y3 = "CB-6y Year Began 1st Cohabitation-3rd Husband"
   CMPMCOHX3 = "CM Date When R Began Living (premaritally) with 3rd husband"
   ENGAGHX3 = "CB-7 Engaged When R Began Premarital Cohabitation-3rd Husband"
   HSBMULT3 = "Multiple races reported for 3rd husband"
   HSBRACE3 = "RACE-recode-like variable for 3rd husband"
   HSBHRACE3 = "HISPRACE-recode-like variable for 3rd husband"
   HSBNRACE3 = "HISPRACE2-recode-like variable for 3rd husband"
   CHEDMARN3 = "CB-11 Highest Level of Education-3rd Husband"
   MARBEFHX3 = "CB-12 Was He Married Before-3rd Husband"
   KIDSHX3 = "CB-13 Did He Have Kids From Prior Relationship-3rd Husband"
   NUMKDSHX3 = "CB-14 Number of Kids From Prior Relationships-3rd Husband"
   KIDLIVHX3 = "CB-15 Any Kids From Prior Relationships Live w/R & 3rd Husband"
   CHKID18A3 = "CB-16a Is This Child 18 or Younger - Curr (if 3rd) Husband"
   CHKID18B3 = "CB-16b # of These Children 18 or Younger - Curr (if 3rd) Husband"
   WHRCHKDS9 = "CB-17 Where Current (if 3rd) Husband's Child(ren) Lives Now-1st Mention"
   WHRCHKDS10 = "CB-17 Where Current (if 3rd) Husband's Child(ren) Lives Now-2nd Mention"
   WHRCHKDS11 = "CB-17 Where Current (if 3rd) Husband's Child(ren) Lives Now-3rd Mention"
   WHRCHKDS12 = "CB-17 Where Curr Husband's Child(ren) Lives Now-4th Mention"
   SUPPORCH3 = "CB-18 Does Current (if 3rd) Husband Financially Support Kids <=18 Elsewhere"
   BIOHUSBX3 = "CB-18b Did R have bio kids with this husband-3rd Husband"
   BIONUMHX3 = "CB-18c Number of bio kids R and  husband had together-3rd Husband"
   MARENDHX3 = "CB-19 How Marriage Ended-3rd Husband"
   WNDIEHX_M3 = "CB-20 Month of Death-3rd Husband"
   WNDIEHX_Y3 = "CB-20 Year of Death-3rd Husband"
   CMHSBDIEX3 = "CM for Date When 3rd Husband Died"
   DIVDATHX_M3 = "CB-21m Month of Divorce-3rd Husband"
   DIVDATHX_Y3 = "CB-21y Year of Divorce-3rd Husband"
   CMDIVORCX3 = "CM for Date of Divorce or Annulment From 3rd Husband"
   WNSTPHX_M3 = "CB-22m Month Stopped Living Together-3rd Husband"
   WNSTPHX_Y3 = "CB-22y Year Stopped Living Together-3rd Husband"
   CMSTPHSBX3 = "CM for Date R Stopped Living with 3rd Husband"
   WHMARHX_M4 = "CB-1m Month Married to 4th Husband"
   WHMARHX_Y4 = "CB-1y Year Married to 4th Husband"
   CMMARRHX4 = "CM for Date of 4th Marriage"
   AGEMARHX4 = "CB-2 R's Age at Marriage-4th Husband"
   HXAGEMAR4 = "CB-3 Husband's Age At Marriage-4th Husband"
   DOBHUSBX_M4 = "CB-4m Month Husband Was Born-4th Husband"
   DOBHUSBX_Y4 = "CB-4y Year Husband Was Born-4th Husband"
   CMHSBDOBX4 = "CM for 4th Husband's Date of Birth"
   LVTOGHX4 = "CB-5 Cohabited Before Marriage-4th Husband"
   STRTOGHX_M4 = "CB-6m Month Began 1st Cohabitation-4th Husband"
   STRTOGHX_Y4 = "CB-6y Year Began 1st Cohabitation-4th Husband"
   CMPMCOHX4 = "CM Date When R Began Living (premaritally) with 4th husband"
   ENGAGHX4 = "CB-7 Engaged When R Began Premarital Cohabitation-4th Husband"
   HSBMULT4 = "Multiple races reported for 4th husband"
   HSBRACE4 = "RACE-recode-like variable for 4th husband"
   HSBHRACE4 = "HISPRACE-recode-like variable for 4th husband"
   HSBNRACE4 = "HISPRACE2-recode-like variable for 4th husband"
   CHEDMARN4 = "CB-11 Highest Level of Education-4th Husband"
   MARBEFHX4 = "CB-12 Was He Married Before-4th Husband"
   KIDSHX4 = "CB-13 Did He Have Kids From Prior Relationship-4th Husband"
   NUMKDSHX4 = "CB-14 Number of Kids From Prior Relationships-4th Husband"
   KIDLIVHX4 = "CB-15 Any Kids From Prior Relationships Live w/R & 4th Husband"
   CHKID18A4 = "CB-16a Is This Child 18 or Younger - Curr (if 4th) Husband"
   CHKID18B4 = "CB-16b # of These Children 18 or Younger - Curr (if 4th) Husband"
   WHRCHKDS13 = "CB-17 Where Current (if 4th) Husband's Child(ren) Lives Now-1st Mention"
   WHRCHKDS14 = "CB-17 Where Current (if 4th) Husband's Child(ren) Lives Now-2nd Mention"
   WHRCHKDS15 = "CB-17 Where Current (if 4th) Husband's Child(ren) Lives Now-3rd Mention"
   WHRCHKDS16 = "CB-17 Where Curr Husband's Child(ren) Lives Now-4th Mention"
   SUPPORCH4 = "CB-18 Does Current (if 4th) Husband Financially Support Kids <=18 Elsewhere"
   BIOHUSBX4 = "CB-18b Did R have bio kids with this husband-4th Husband"
   BIONUMHX4 = "CB-18c Number of bio kids R and  husband had together-4th Husband"
   MARENDHX4 = "CB-19 How Marriage Ended-4th Husband"
   WNDIEHX_M4 = "CB-20m Month of Death-4th Husband"
   WNDIEHX_Y4 = "CB-20y Year of Death-4th Husband"
   CMHSBDIEX4 = "CM for Date When 4th Husband Died"
   DIVDATHX_M4 = "CB-21m Month of Divorce-4th Husband"
   DIVDATHX_Y4 = "CB-21y Year of Divorce-4th Husband"
   CMDIVORCX4 = "CM for Date of Divorce or Annulment From 4th Husband"
   WNSTPHX_M4 = "CB-22m Month Stopped Living Together-4th Husband"
   WNSTPHX_Y4 = "CB-22y Year Stopped Living Together-4th Husband"
   CMSTPHSBX4 = "CM for Date R Stopped Living with 4th Husband"
   WHMARHX_M5 = "CB-1m Month Married to 5th Husband"
   WHMARHX_Y5 = "CB-1y Year Married to 5th Husband"
   CMMARRHX5 = "CM for Date of 5th Marriage"
   AGEMARHX5 = "CB-2 R's Age at Marriage-5th Husband"
   HXAGEMAR5 = "CB-3 Husband's Age At Marriage-5th Husband"
   DOBHUSBX_M5 = "CB-4m Month Husband Was Born-5th Husband"
   DOBHUSBX_Y5 = "CB-4y Year Husband Was Born-5th Husband"
   CMHSBDOBX5 = "CM for 5th Husband's Date of Birth"
   LVTOGHX5 = "CB-5 Cohabited Before Marriage-5th Husband"
   STRTOGHX_M5 = "CB-6m Month Began 1st Cohabitation-5th Husband"
   STRTOGHX_Y5 = "CB-6y Year Began 1st Cohabitation-5th Husband"
   CMPMCOHX5 = "CM Date When R Began Living (premaritally) with 5th husband"
   ENGAGHX5 = "CB-7 Engaged When R Began Premarital Cohabitation-5th Husband"
   CHEDMARN5 = "CB-11 Highest Level of Education-5th Husband"
   MARBEFHX5 = "CB-12 Was He Married Before-5th Husband"
   KIDSHX5 = "CB-13 Did He Have Kids From Prior Relationship-5th Husband"
   NUMKDSHX5 = "CB-14 Number of Kids From Prior Relationships-5th Husband"
   KIDLIVHX5 = "CB-15 Any Kids From Prior Relationships Live w/R & 5th Husband"
   CHKID18A5 = "CB-16a Is This Child 18 or Younger - Curr (if 5th) Husband"
   CHKID18B5 = "CB-16b # of These Children 18 or Younger - Curr (if 5th) Husband"
   WHRCHKDS17 = "CB-17 Where Current (if 5th) Husband's Child(ren) Lives Now-1st Mention"
   WHRCHKDS18 = "CB-17 Where Current (if 5th) Husband's Child(ren) Lives Now-2nd Mention"
   WHRCHKDS19 = "CB-17 Where Current (if 5th) Husband's Child(ren) Lives Now-3rd Mention"
   WHRCHKDS20 = "CB-17 Where Curr Husband's Child(ren) Lives Now-4th Mention"
   SUPPORCH5 = "CB-18 Does Current (if 5th) Husband Financially Support Kids <=18 Elsewhere"
   BIOHUSBX5 = "CB-18b Did R have bio kids with this  husband-5th Husband"
   BIONUMHX5 = "CB-18c Number of bio kids R and  husband had together-5th Husband"
   MARENDHX5 = "CB-19 How Marriage Ended-5th Husband"
   WNDIEHX_M5 = "CB-20m Month of Death-5th Husband"
   WNDIEHX_Y5 = "CB-20y Year of Death-5th Husband"
   CMHSBDIEX5 = "CM for Date When 5th Husband Died"
   DIVDATHX_M5 = "CB-21m Month of Divorce-5th Husband"
   DIVDATHX_Y5 = "CB-21y Year of Divorce-5th Husband"
   CMDIVORCX5 = "CM for Date of Divorce or Annulment From 5th Husband"
   WNSTPHX_M5 = "CB-22m Month Stopped Living Together-5th Husband"
   WNSTPHX_Y5 = "CB-22y Year Stopped Living Together-5th Husband"
   CMSTPHSBX5 = "CM for Date R Stopped Living with 5th Husband"
   CMMARRCH = "CM for Date of Marriage to Current Husband"
   CMDOBCH = "CM for Current Husband's Date of Birth"
   PREVHUSB = "Number of Previous Husbands (incl. separated)"
   WNSTRTCP_M = "CC-2m Month Began Cohabitation - Current Partner"
   WNSTRTCP_Y = "CC-2y Year Began Cohabitation - Current Partner"
   CMSTRTCP = "CM for date when R began cohabiting w/current partner"
   CPHERAGE = "CC-3 R's Age When Began Cohabiting w/Current Partner"
   CPHISAGE = "CC-4 Partner's Age When Began Cohabiting - Current Partner"
   WNCPBRN_M = "CC-5m Month Partner Was Born- Current Cohabiting Partner"
   WNCPBRN_Y = "CC-5y Year Partner Was Born- Current Cohabiting Partner"
   CMDOBCP = "CM For Current cohabiting partner's DOB"
   CPENGAG1 = "CC-6 Engaged When Began Cohabiting-Current Cohabiting Partner"
   WILLMARR = "CC-7 R Thinks She Will Marry-Curr Cohabiting Partner"
   CURCOHMULT = "Multiple races reported for current cohab partner"
   CURCOHRACE = "RACE-recode-like variable for current cohab partner"
   CURCOHHRACE = "HISPRACE-recode-like variable for current cohab partner"
   CURCOHNRACE = "HISPRACE2-recode-like variable for current cohab partner"
   CPEDUC = "CC-11 Level of Education-Current Cohabiting Partner"
   CPMARBEF = "CC-12 Was He Married Before - Current Cohabiting Partner"
   CPKIDS = "CC-13 Kids From Prior Relationships-Current Cohabiting Partner"
   CPNUMKDS = "CC-14 # of Kids From Prior Relationships-Curr Cohab Partner"
   CPKIDLIV = "CC-15 Kids From Prior Relationships Live w/R"
   CPKID18A = "CC-16a Is This Child 18 or Younger-Curr Cohabiting Partner"
   CPKID18B = "CC-16b # of His Children 18 or Younger-Curr Cohabiting Partner"
   WHRCPKDS1 = "CC-17 Where Curr Cohab s Child(ren) Lives Now-1st Mention"
   WHRCPKDS2 = "CC-17 Where Curr Cohab s Child(ren) Lives Now-2nd Mention"
   WHRCPKDS3 = "CC-17 Where Curr Cohab s Child(ren) Lives Now-3rd Mention"
   WHRCPKDS4 = "CC-17 Where Curr Cohab s Child(ren) Lives Now-4th Mention"
   SUPPORCP = "CC-18 Does Curr Cohab Financially Support Kids <=18 Elsewhere"
   BIOCP = "CC-19 Did R have bio kids with current partner?"
   BIONUMCP = "CC-20 Number of bio kids R and current partner have together"
   CMSTRTHP = "CM for date R began living with current husband or cohab partner"
   LIVEOTH = "CD-1 Ever Cohabited With Any (Other) Man"
   EVRCOHAB = "Whether R Has Ever Lived With a Non Marital Partner"
   HMOTHMEN = "CD-2 Number of Other Men R Has Cohabited With"
   PREVCOHB = "Number of former cohabiting partners"
   STRTOTHX_M = "CD-4m Month Began Cohabitation - 1st former partner"
   STRTOTHX_Y = "CD-4y Year Began Cohabitation - 1st former partner"
   CMCOHSTX = "CM for Start of Cohabitation with R's 1st Former Partner"
   HERAGECX = "CD-5 R's Age When Began Cohabiting w/ 1st Former Partner"
   HISAGECX = "CD-6 Partner's Age When Began Cohabiting - 1st Former Partner"
   WNBRNCX_M = "CD-7m Month Partner Was Born-1st former cohab partner"
   WNBRNCX_Y = "CD-7y Year Partner Was Born-1st former cohab partner"
   CMDOBCX = "CM for 1st former cohabiting partner's DOB"
   ENGAG1CX = "CD-8 Engaged When Began Cohabiting-1st former cohab partner"
   COH1MULT = "Multiple races reported for 1st former cohabiting partner"
   COH1RACE = "RACE-recode-like variable for 1st former cohabiting partner"
   COH1HRACE = "HISPRACE-recode-like variable for 1st former cohabiting partner"
   COH1NRACE = "HISPRACE2-recode-like variable for 1st former cohabiting partner"
   MAREVCX = "CD-12 Was He Married Before-1st former cohabiting partner"
   CXKIDS = "CD-13 Any Kids From Prior Relationhips-1st former cohab partner"
   BIOFCPX = "CD-13b Did R have bio kids with this cohab partner-1st former cohab partner"
   BIONUMCX = "CD-13c Number of bio kids R and cohab partner have together-1st former cohab partner"
   STPTOGCX_M = "CD-14m Month Stopped Cohabiting-1st former cohabiting partner"
   STPTOGCX_Y = "CD-14y Year Stopped Cohabiting-1st former cohabiting partner"
   CMSTPCOHX = "CM when R stopped cohabiting with 1st former cohab partner"
   STRTOTHX_M2 = "CD-4m Month Began Cohabitation - 2nd former partner"
   STRTOTHX_Y2 = "CD-4y Year Began Cohabitation - 2nd former partner"
   CMCOHSTX2 = "CM for Start of Cohabitation with R's 2nd Former Partner"
   HERAGECX2 = "CD-5 R's Age When Began Cohabiting w/ 2nd Former Partner"
   HISAGECX2 = "CD-6 Partner's Age When Began Cohabiting - 2nd Former Partner"
   WNBRNCX_M2 = "CD-7m Month Partner Was Born-2nd former cohab partner"
   WNBRNCX_Y2 = "CD-7y Year Partner Was Born-2nd former cohab partner"
   CMDOBCX2 = "CM for 2nd former cohabiting partner's DOB"
   ENGAG1CX2 = "CD-8 Engaged When Began Cohabiting-2nd former cohab partner"
   MAREVCX2 = "CD-12 Was He Married Before-2nd former cohabiting partner"
   CXKIDS2 = "CD-13 Any Kids From Prior Relationhips-2nd former cohab partner"
   BIOFCPX2 = "CD-13b Did R have bio kids with this cohab partner-2nd former cohab partner"
   BIONUMCX2 = "CD-13c Number of bio kids R and cohab partner have together-2nd former cohab partner"
   STPTOGCX_M2 = "CD-14m Month Stopped Cohabiting-2nd former cohabiting partner"
   STPTOGCX_Y2 = "CD-14y Year Stopped Cohabiting-2nd former cohabiting partner"
   CMSTPCOHX2 = "CM when R stopped cohabiting with 2nd former cohab partner"
   STRTOTHX_M3 = "CD-4m Month Began Cohabitation - 3rd former partner"
   STRTOTHX_Y3 = "CD-4y Year Began Cohabitation - 3rd former partner"
   CMCOHSTX3 = "CM for Start of Cohabitation with R's 3rd Former Partner"
   HERAGECX3 = "CD-5 R's Age When Began Cohabiting w/ 3rd Former Partner"
   HISAGECX3 = "CD-6 Partner's Age When Began Cohabiting - 3rd Former Partner"
   WNBRNCX_M3 = "CD-7m Month Partner Was Born-3rd former cohab partner"
   WNBRNCX_Y3 = "CD-7y Year Partner Was Born-3rd former cohab partner"
   CMDOBCX3 = "CM for 3rd former cohabiting partner's DOB"
   ENGAG1CX3 = "CD-8 Engaged When Began Cohabiting-3rd former cohab partner"
   MAREVCX3 = "CD-12 Was He Married Before-3rd former cohabiting partner"
   CXKIDS3 = "CD-13 Any Kids From Prior Relationships-3rd former cohab partner"
   BIOFCPX3 = "CD-13b Did R have bio kids with this cohab partner-3rd former cohab partner"
   BIONUMCX3 = "CD-13c Number of bio kids R and cohab partner have together-3rd former cohab partner"
   STPTOGCX_M3 = "CD-14m Month Stopped Cohabiting-3rd former cohabiting partner"
   STPTOGCX_Y3 = "CD-14y Year Stopped Cohabiting-3rd former cohabiting partner"
   CMSTPCOHX3 = "CM when R stopped cohabiting with 3rd former cohab partner"
   STRTOTHX_M4 = "CD-4m Month Began Cohabitation - 4th former partner"
   STRTOTHX_Y4 = "CD-4y Year Began Cohabitation - 4th former partner"
   CMCOHSTX4 = "CM for Start of Cohabitation with R's 4th Former Partner"
   HERAGECX4 = "CD-5 R's Age When Began Cohabiting w/ 4th Former Partner"
   HISAGECX4 = "CD-6 Partner's Age When Began Cohabiting - 4th Former Partner"
   WNBRNCX_M4 = "CD-7m Month Partner Was Born-4th former cohab partner"
   WNBRNCX_Y4 = "CD-7y Year Partner Was Born-4th former cohab partner"
   CMDOBCX4 = "CM for 4th former cohabiting partner's DOB"
   ENGAG1CX4 = "CD-8 Engaged When Began Cohabiting-4th former cohab partner"
   MAREVCX4 = "CD-12 Was He Married Before-4th former cohabiting partner"
   CXKIDS4 = "CD-13 Any Kids From Prior Relationhips-4th former cohab partner"
   BIOFCPX4 = "CD-13b Did R have bio kids with this cohab partner-4th former cohab partner"
   BIONUMCX4 = "CD-13c Number of bio kids R and cohab partner have together-4th former cohab partner"
   STPTOGCX_M4 = "CD-14m Month Stopped Cohabiting-4th former cohabiting partner"
   STPTOGCX_Y4 = "CD-14y Year Stopped Cohabiting-4th former cohabiting partner"
   CMSTPCOHX4 = "CM when R stopped cohabiting with 4th former cohab partner"
   COHCHANCE = "CD-15 R thinks she will cohabit in the future"
   MARRCHANCE = "CD-16 R thinks she will (re)marry in the future"
   PMARCOH = "CD-17 R thinks she will live with a future husband before marriage"
   EVERSEX = "CE-1 Ever Had Sexual Intercourse with a Man"
   RHADSEX = "Whether R Has Ever Had Sex (Heterosexual Vaginal Intercourse)"
   YNOSEX = "CE-2 Main Reason R Has Not Had Sex With a Man"
   WNFSTSEX_M = "CE-3m Month of First Sexual Intercourse"
   WNFSTSEX_Y = "CE-3y Year of First Sexual Intercourse"
   CMFSTSEX = "CM for Date of First Sexual Intercourse"
   AGEFSTSX = "CE-4 Age at First Sexual Intercourse"
   C_SEX18 = "CE-5 Was R less than 18 or 18+ at 1st sex"
   C_SEX15 = "CE-6 Was R less than 15 or 15+ at 1st sex"
   C_SEX20 = "CE-7 Was R less than 20 or 20+ at 1st sex"
   GRFSTSX = "CE-8 Grade R Was in at First Sexual Intercourse"
   SXMTONCE = "CE-9 Has R Had Sexual Intercourse More Than Once"
   TALKPAR1 = "CF-1 Sex Ed Topics R Has Discussed with Parents -1st Mention"
   TALKPAR2 = "CF-1 Sex Ed Topics R Has Discussed with Parents -2nd Mention"
   TALKPAR3 = "CF-1 Sex Ed Topics R Has Discussed with Parents -3rd Mention"
   TALKPAR4 = "CF-1 Sex Ed Topics R Has Discussed with Parents -4th Mention"
   TALKPAR5 = "CF-1 Sex Ed Topics R Has Discussed with Parents -5th Mention"
   TALKPAR6 = "CF-1 Sex Ed Topics R Has Discussed with Parents -6th Mention"
   TALKPAR7 = "CF-1 Sex Ed Topics R Has Discussed with Parents -7th Mention"
   SEDNO = "CF-2 Formal Sex Ed Before 18: How to Say No to Sex"
   SEDNOG = "CF-3 Grade R Received Sex Ed on How to Say No to Sex"
   SEDNOSX = "CF-4 Rec d Sex Ed on How to Say No to Sex Before/After 1st Sex"
   SEDBC = "CF-5 Formal Sex Ed Before 18: Methods of Birth Control"
   SEDBCG = "CF-6 R's Grade When Received Instruction on Birth Control"
   SEDBCSX = "CF-7 Rec d Sex Ed on Birth Control Methods Before/After 1st Sex"
   SEDWHBC = "CF-8 Formal Sex Ed Before 18: Where to Get Birth Control"
   SEDWHBCG = "CF-9 R's Grade When Received Instruction on Where to Get Birth Control"
   SEDWBCSX = "CF-10 R rec d Instruction-Where to Get Birth Control before/after 1st sex"
   SEDCOND = "CF-11 Formal Sex Ed Before 18: How to Use a Condom"
   SEDCONDG = "CF-12 R's Grade When Received Instruction on How to Use a Condom"
   SEDCONSX = "CF-13 R rec d Instruction-How to Use a Condom before/after 1st sex"
   SEDSTD = "CF-14 Formal Sex Ed Before 18: STD"
   SEDSTDG = "CF-15 Grade R 1st Received Sex Ed on STDs"
   SEDSTDSX = "CF-16 Received Sex Ed on STD before/after 1st sex"
   SEDHIV = "CF-17 Formal Sex Ed Before 18: HIV/AIDS"
   SEDHIVG = "CF-18 Grade R 1st Received Sex Ed on HIV/AIDS"
   SEDHIVSX = "CF-19 Received Sex Ed on HIV/AIDS before/after 1st sex"
   SEDABST = "CF-20 Formal Sex Ed Before 18: Waiting Until Marriage"
   SEDABSTG = "CF-21 R's Grade When Received Instruction on Waiting Until Marriage"
   SEDABSSX = "CF-22 R rec d instruction-Waiting Until Marriage before/after 1st sex"
   SAMEMAN = "CG-2 1st Partner Already Discussed as a Husband or Cohab Partner?"
   WHOFSTPR = "CG-3 Which man already discussed was R's 1st Sexual Partner?"
   FPAGE = "CG-4 1st Partner's Age at R's 1st Sex"
   FPRELAGE = "CG-4b Was 1st Sexual Partner Older/Younger/Same Age as R"
   FPRELYRS = "CG-4c How Many Years Older/Younger Than R Was 1st Sex Partner"
   KNOWFP = "CG-5 Relationship with 1st Partner at 1st Sex"
   STILFPSX = "CG-6 Is 1st Sexual Partner a Current Sexual Partner"
   LSTSEXFP_M = "CG-7m Month R Last Had Sex With 1st Sexual Partner"
   LSTSEXFP_Y = "CG-7y Year R Last Had Sex With 1st Sexual Partner"
   CMLSEXFP = "CM for Date of Last Sex With 1st Sexual Partner"
   CMFPLAST = "CM for Date of Last or Only Sex with 1st Sexual Partner"
   FPOTHREL = "CG-7a Relationship with Partner at Last Sex"
   FPEDUC = "CG-7b Highest level of education - 1st Sexual Partner"
   FSEXMULT = "Multiple races reported for 1st sexual partner"
   FSEXRACE = "RACE-recode-like variable for 1st sexual partner"
   FSEXHRACE = "HISPRACE-recode-like variable for 1st sexual partner"
   FSEXNRACE = "HISPRACE2-recode-like variable for 1st sexual partner"
   FPRN = "CG-7f Describe Current Relationship with 1st Sexual Partner"
   WHICH1ST = "CG-8 First Sexual Intercourse Before or After Menarche"
   SEXAFMEN = "CG-9 Whether R Had Sex Since Menarche"
   WNSEXAFM_M = "CG-10m Month of 1st Sex After Menarche"
   WNSEXAFM_Y = "CG-10y Year of 1st Sex After Menarche"
   CMSEXAFM = "CM for Date of 1st Sex After Menarche"
   AGESXAFM = "CG-11 Age at 1st Sex After Menarche"
   AFMEN18 = "CG-12 Was R less than 18 or 18+ at 1st sex after menarche"
   AFMEN15 = "CG-13 Was R less than 15 or 15+ at 1st sex after menarche"
   AFMEN20 = "CG-14 Was R less than 20 or 20+ at 1st sex after menarche"
   LIFEPRT = "CH-1 # of Male Sex Partners in Entire Life"
   LIFEPRT_LO = "CH-1b # of Male Sex Partners in Entire Life: Low end of range"
   LIFEPRT_HI = "CH-1c # of Male Sex Partners in Entire Life: High end of range"
   PTSB4MAR = "CH-2 # of Male Sex Partners Prior to 1st Marriage"
   PTSB4MAR_LO = "CH-2b # of Male Sex Partners Prior to 1st Marriage: Low end of range"
   PTSB4MAR_HI = "CH-2c # of Male Sex Partners Prior to 1st Marriage: High end of range"
   MON12PRT = "CH-3 # of Male Sex Partners in Last 12 Months"
   MON12PRT_LO = "CH-3b # of Male Sex Partners in Last 12 Months: Low end of range"
   MON12PRT_HI = "CH-3c # of Male Sex Partners in Last 12 Months: High end of range"
   PARTS12 = "Number of Partners in Last 12 Months"
   LIFEPRTS = "Number of Male Sexual Partners in Lifetime"
   WHOSNC1Y = "CI-1 Is R's One Partner in Last 12 Mos Her Current H/P?"
   MATCHFP = "CI-4 Is last partner same as 1st partner ever?"
   MATCHHP = "CI-5 Which H/P already discussed, if any, is last partner?"
   P1YRELP = "Relationship of last partner to R"
   CMLSEX = "CM of last sex with last partner"
   P1YLSEX_M = "CI-6m Month of Last Sex-last partner"
   P1YLSEX_Y = "CI-6y Year of Last Sex-last partner"
   P1YCURRP = "CI-7 Whether partner is current-last partner"
   PCURRNT = "Whether partner is current - last partner"
   MATCHFP2 = "CI-4 Is 2nd-to-last partner same as 1st partner ever?"
   MATCHHP2 = "CI-5 Which H/P already discussed, if any, is 2nd-to-last partner?"
   P1YRELP2 = "Relationship of 2nd-to-last partner to R"
   CMLSEX2 = "CM of last sex with 2nd-to-last partner in last 12 mos"
   P1YLSEX_M2 = "CI-6m Month of Last Sex-2nd-to-last partner"
   P1YLSEX_Y2 = "CI-6y Year of Last Sex-2nd-to-last partner"
   P1YCURRP2 = "CI-7 Whether partner is current (2nd-to-last partner)"
   PCURRNT2 = "Whether partner is current (2nd-to-last partner)"
   MATCHFP3 = "CI-4 Is 3rd-to-last partner same as 1st partner ever?"
   MATCHHP3 = "CI-5 Which H/P already discussed, if any, is 3rd-to-last partner?"
   P1YRELP3 = "Relationship of 3rd-to-last partner to R"
   CMLSEX3 = "CM of last sex with 3rd-to-last partner in last 12 mos"
   P1YLSEX_M3 = "CI-6m Month of Last Sex-3rd-to-last partner"
   P1YLSEX_Y3 = "CI-6y Year of Last Sex-3rd-to-last partner"
   P1YCURRP3 = "CI-7 Whether partner is current (3rd-to-last partner)"
   PCURRNT3 = "Whether partner is current (3rd-to-last partner)"
   P1YOTHREL = "CI-8 Relationship at last Sex with last partner"
   P1YRAGE = "CI-9 R's Age at 1st Sex with last partner"
   P1YHSAGE = "CI-10 Partner's Age at 1st Sex with R -last partner"
   P1YRF = "CI-11 Relationship with last partner at 1st Sex with him"
   P1YFSEX_M = "CI-12m Month of 1st Sex with last partner"
   P1YFSEX_Y = "CI-12y Year of 1st Sex with last Partner"
   CMFSEX = "CM of first sex with last partner"
   CMFSEXTOT = "CM of first or only sex with last partner"
   P1YEDUC = "CI-13 Highest Level of Education-last Partner"
   P1YMULT1 = "Multiple races reported for most recent partner in last 12 mos"
   P1YRACE1 = "RACE-recode-like variable for most recent partner in last 12 mos"
   P1YHRACE1 = "HISPRACE-recode-like variable for most recent partner in last 12mos"
   P1YNRACE1 = "HISPRACE2-recode-like variable for most recent partner in last 12mos"
   P1YRN = "CI-17 Type of Current Relationship-last Partner"
   P1YOTHREL2 = "CI-8 Relationship at last Sex with 2nd-to-last partner"
   P1YRAGE2 = "CI-9 R's Age at 1st Sex with 2nd-to-last partner"
   P1YHSAGE2 = "CI-10 Partner's Age at 1st Sex with R -2nd-to-last partner"
   P1YRF2 = "CI-11 Relationship with 2nd-to-last partner at 1st Sex with him"
   P1YFSEX_M2 = "CI-12m Month of 1st Sex with 2nd-to-last partner"
   P1YFSEX_Y2 = "CI-12y Year of 1st Sex with 2nd-to-last partner"
   CMFSEX2 = "CM of first sex with 2nd-to-last partner"
   CMFSEXTOT2 = "CM of first or only sex with 2nd-to-last partner"
   P1YEDUC2 = "CI-13 Highest Level of Education-2nd-to-last partner"
   P1YMULT2 = "Multiple races reported for 2nd-to-last partner in last 12 mos"
   P1YRACE2 = "RACE-recode-like variable for 2nd-to-last partner in last 12 mos"
   P1YHRACE2 = "HISPRACE-recode-like variable for 2nd-to-last partner in last 12 mos"
   P1YNRACE2 = "HISPRACE2-recode-like variable for 2nd-to-last partner in last 12 mos"
   P1YRN2 = "CI-17 Type of Current Relationship-2nd-to-last partner"
   P1YOTHREL3 = "CI-8 Relationship at last Sex with 3rd-to-last partner"
   P1YRAGE3 = "CI-9 R's Age at 1st Sex with 3rd-to-last partner"
   P1YHSAGE3 = "CI-10 Partner's Age at 1st Sex with R -3rd-to-last partner"
   P1YRF3 = "CI-11 Relationship with 3rd-to-last partner at 1st Sex with him"
   P1YFSEX_M3 = "CI-12m Month of 1st Sex with 3rd-to-last partner"
   P1YFSEX_Y3 = "CI-12y Year of 1st Sex with 3rd-to-last partner"
   CMFSEX3 = "CM of first sex with 3rd-to-last partner"
   CMFSEXTOT3 = "CM of first or only sex with 3rd-to-last partner"
   P1YEDUC3 = "CI-13 Highest Level of Education-3rd-to-last partner"
   P1YMULT3 = "Multiple races reported for 3rd-to-last partner in last 12 mos"
   P1YRACE3 = "RACE-recode-like variable for 3rd-to-last partner in last 12 mos"
   P1YHRACE3 = "HISPRACE-recode-like variable for 3rd-to-last partner in last 12 mos"
   P1YNRACE3 = "HISPRACE2-recode-like variable for 3rd-to-last partner in last 12 mos"
   P1YRN3 = "CI-17 Type of Current Relationship-3rd-to-last partner"
   CURRPRTT = "# of Current Male Sexual Partners-including curr H/P"
   CURRPRTS = "# of Current Male Sexual Partners, not including curr H/P"
   CMCURRP1 = "CM for Date of Last or Only Sex With CURPART1"
   CMCURRP2 = "CM for Date of Last or Only Sex With CURPART2"
   CMCURRP3 = "CM for Date of Last or Only Sex With CURPART3"
   EVERTUBS = "DA-1 R Ever Had Tubes Tied/Cut/Removed"
   ESSURE = "DA-1b Ever had tubal sterilization procedure called ESSURE"
   EVERHYST = "DA-2 R Ever Had Hysterectomy"
   EVEROVRS = "DA-3 R Ever Had Both Ovaries Removed"
   EVEROTHR = "DA-4 R Ever Had Any Other Sterilizing Operation"
   WHTOOPRC = "DA-5a Codes for Spontaneous Description of Other Operation"
   ONOTFUNC = "DA-6 R Sterile from Operation on 1 Tube/Ovary"
   DFNLSTRL = "DA-7 R Sterile From This Other Operation"
   ANYTUBAL = "R ever had a tubal sterilization (Regardless of reversal)"
   HYST = "R is surgically sterile at interview due to hysterectomy"
   OVAREM = "R is surgically sterile at interview due to ovary removal"
   OTHR = "R is surgically sterile at interview due to other female operation"
   ANYFSTER = "R Ever Had Sterilizing Operation (Regardless of Reversal)"
   ANYOPSMN = "DA-8 R's Curr H/P Ever Had Vasectomy or Other Sterilizing Operation"
   WHATOPSM = "DA-9 Type of Sterilizing Operation R's Current H/P Had"
   DFNLSTRM = "DA-10 is R's Curr H/P completely sterile/impossible to become father"
   ANYMSTER = "R's H/P Ever Had Sterilizing Operation Regardless of Reversal"
   ANYVAS = "R's H/P ever had a vasectomy, regardless of later reversal"
   OTHRM = "R's H/P curr sterile from operation other than vasectomy (computed in Flow Check D-7)"
   DATFEMOP_M = "DB-1 Month of R's tubal sterilization"
   DATFEMOP_Y = "DB-1 Year of R's tubal sterilization"
   CMTUBLIG = "Date (CM) for R's Tubal Ligation/Sterilization"
   PLCFEMOP = "DB-2 Site of R's tubal sterilization"
   INPATIEN = "DB-2a Overnight Stay in Hospital for Tubal Ligation"
   PAYRSTER1 = "DB-2b How Paid for Tubal Sterilization-1st Mention"
   PAYRSTER2 = "DB-2b How Paid for Tubal Sterilization-2nd Mention"
   RHADALL = "DB-3a R Had All The Kids She Wanted-Tubal Steril"
   HHADALL = "DB-3b H/P Had All The Kids He Wanted-Tubal Steril"
   FMEDREAS1 = "DB-4 Medical reason for tubal sterilization-1st mention"
   FMEDREAS2 = "DB-4 Medical reason for tubal sterilization-2nd mention"
   FMEDREAS3 = "DB-4 Medical reason for tubal sterilization-3rd mention"
   FMEDREAS4 = "DB-4 Medical reason for tubal sterilization-4th mention"
   BCREAS = "DB-5a Problems with Birth Control Method-tubal steril"
   BCWHYF = "DB-5b Medical Problems with Birth Control-tubal steril"
   MINCDNNR = "DB-6 Main reason for tubal sterilization"
   DATFEMOP_M2 = "DB-1 Month of R's hysterectomy"
   DATFEMOP_Y2 = "DB-1 Year of R's hysterectomy"
   CMHYST = "Date (CM) for R's Hysterectomy"
   PLCFEMOP2 = "DB-2 Site of R's hysterectomy"
   PAYRSTER6 = "DB-2b How Paid for Hysterectomy-1st Mention"
   PAYRSTER7 = "DB-2b How Paid for Hysterectomy-2nd Mention"
   RHADALL2 = "DB-3a R Had All The Kids She Wanted-Hysterectomy"
   HHADALL2 = "DB-3b H/P Had All The Kids He Wanted-Hysterectomy"
   FMEDREAS7 = "DB-4 Medical reason for hysterectomy-1st mention"
   FMEDREAS8 = "DB-4 Medical reason for hysterectomy-2nd mention"
   FMEDREAS9 = "DB-4 Medical reason for hysterectomy-3rd mention"
   FMEDREAS10 = "DB-4 Medical reason for hysterectomy-4th mention"
   BCREAS2 = "DB-5a Problems with Birth Control Method-hysterectomy"
   BCWHYF2 = "DB-5b Medical Problems with Birth Control-hysterectomy"
   MINCDNNR2 = "DB-6 Main reason for hysterectomy"
   DATFEMOP_M3 = "DB-1 Month of R's ovary removal"
   DATFEMOP_Y3 = "DB-1 Year of R's ovary removal"
   CMOVAREM = "Date (CM) For R's Ovary Removal"
   PLCFEMOP3 = "DB-2 Site of R's ovary removal"
   PAYRSTER11 = "DB-2b How Paid for Ovary Removal-1st Mention"
   PAYRSTER12 = "DB-2b How Paid for Ovary Removal-2nd Mention"
   RHADALL3 = "DB-3a R Had All The Kids She Wanted-Ovary Removal"
   HHADALL3 = "DB-3b H/P Had All The Kids He Wanted-Ovary Removal"
   FMEDREAS13 = "DB-4 Medical reason for ovary removal-1st mention"
   FMEDREAS14 = "DB-4 Medical reason for ovary removal-2nd mention"
   FMEDREAS15 = "DB-4 Medical reason for ovary removal-3rd mention"
   FMEDREAS16 = "DB-4 Medical reason for ovary removal-4th mention"
   BCREAS3 = "DB-5a Problems with Birth Control Method-ovary removal"
   BCWHYF3 = "DB-5b Medical Problems with Birth Control-ovary removal"
   MINCDNNR3 = "DB-6 Main reason for ovary removal"
   DATFEMOP_M4 = "DB-1 Month of R's other sterilizing operation"
   DATFEMOP_Y4 = "DB-1 Year of R's other sterilizing operation"
   CMOTSURG = "Date (CM) For R's Other Sterilizing Operation"
   PLCFEMOP4 = "DB-2 Site of R's other sterilizing operation"
   PAYRSTER16 = "DB-2b How Paid for Other Sterilizing Operation-1st Mention"
   PAYRSTER17 = "DB-2b How Paid for Other Sterilizing Operation-2nd Mention"
   RHADALL4 = "DB-3a R Had All The Kids She Wanted-Other Sterilizing Operation"
   HHADALL4 = "DB-3b H/P Had All The Kids He Wanted-Other Sterilizing Operation"
   FMEDREAS19 = "DB-4 Medical reason for Other Sterilizing operation-1st mention"
   FMEDREAS20 = "DB-4 Medical reason for Other Sterilizing operation-2nd mention"
   FMEDREAS21 = "DB-4 Medical reason for Other Sterilizing operation-3rd mention"
   FMEDREAS22 = "DB-4 Medical reason for Other Sterilizing operation-4th mention"
   BCREAS4 = "DB-5a Problems with Birth Control Method-Other Sterilizing Operation"
   BCWHYF4 = "DB-5b Medical Problems with Birth Control-Other Sterilizing Operation"
   MINCDNNR4 = "DB-6 Main reason for other sterilizing operation"
   CMOPER1 = "Date (CM) For R's 1st (or only) Sterilizing Operation"
   OPERSAME1 = "DB-6b Tubal & Hysterectomy in Same Mo/Yr Done at Same Time"
   OPERSAME2 = "DB-6b Tubal & Ovary Removal in Same Mo/Yr Done at Same Time"
   OPERSAME3 = "DB-6b Tubal & Other Female Operation in Same Mo/Yr Done at Same Time"
   OPERSAME4 = "DB-6b Hysterectomy & Ovary Removal in Same Mo/Yr Done at Same Time"
   OPERSAME5 = "DB-6b Hysterectomy & Other Female Operation in Same Mo/Yr Done at Same Time"
   OPERSAME6 = "DB-6b Ovary Removal & Other Female Operation in Same Mo/Yr Done at Same Time"
   DATEOPMN_M = "DB-7 Month When Current H/P Had Sterilizing Operation"
   DATEOPMN_Y = "DB-7 Year When Current H/P Had Sterilizing Operation"
   CMMALEOP = "Date (CM) for R's Current H/P Sterilizing Operation"
   WITHIMOP = "DB-8 Was R in Relationship with H/P When He Had Sterilization Operation"
   VASJAN4YR = "DB-8b Had Sterilization Operation since CMJAN4YR"
   PLACOPMN = "DB-9 Site of H/P's Sterilizing Operation"
   PAYMSTER1 = "DB-10 How paid for current H/P's operation-1st mention"
   PAYMSTER2 = "DB-10 How paid for current H/P's operation-2nd mention"
   RHADALLM = "DB-11a At H/P's Operation, R Had All The Children She Wanted"
   HHADALLM = "DB-11b At H/P's Operation, H/P Had All The Children He Wanted"
   MEDREAS1 = "DB-12 Medical reason for H/P's operation-1st mention"
   MEDREAS2 = "DB-12 Medical reason for H/P's operation-2nd mention"
   BCREASM = "DB-13a At H/P's Operation, Had Problems with Birth Control Method"
   BCWHYM = "DB-13b At H/P's Operation, Had Medical Problems with Birth Control"
   MINCDNMN = "DB-14 Main Reason for H/P's Sterilizing Operation"
   REVSTUBL = "DC-1 Ever had surgery to reverse tubal sterilization"
   DATRVSTB_M = "DC-2 Month of Tubal Sterilization Reversal"
   DATRVSTB_Y = "DC-2 Year of Tubal Sterilization Reversal"
   CMLIGREV = "Date (CM) of R's Reversal of Tubal Sterilization"
   REVSVASX = "DC-3 R's Current H/P Ever Had Surgery to Reverse Vasectomy"
   DATRVVEX_M = "DC-4 Month of Current H/P's Vasectomy Reversal"
   DATRVVEX_Y = "DC-4 Year of Current H/P's Vasectomy Reversal"
   CMVASREV = "Date (CM) For R's Current H/P's Vasectomy Reversal"
   TUBS = "R currently sterile from tubal ligation"
   VASECT = "R's H/P currently sterile from vasectomy"
   RSURGSTR = "Whether R is Surgically Sterile at Interview"
   PSURGSTR = "Whether R's Current H/P is Surgically Sterile at Interview"
   ONLYTBVS = "Whether R & H/P's Only Sterile Ops=Tubal or Vasectomy"
   RWANTRVT = "DC-5 R Wants to Reverse Her Tubal Ligation"
   MANWANTT = "DC-6 R's H/P Wants R to Reverse Her Tubal Ligation"
   RWANTREV = "DC-7 R Wants H/P to Reverse His Vasectomy"
   MANWANTR = "DC-8 R's H/P Wants to Reverse His Vasectomy"
   POSIBLPG = "DE-1 Physically Possible for R to Have a Baby"
   REASIMPR = "DE-2 Why Impossible for R to Have a Baby"
   POSIBLMN = "DE-3 Physically Possible for R's Current H/P to Father a Baby"
   REASIMPP = "DE-4 Why Impossible for R's Current H/P to Father a Baby"
   CANHAVER = "DF-1 Physically Difficult for R to Have a Baby"
   REASDIFF1 = "DF-2 Why Physically Difficult for R to Have Baby-1st mention"
   REASDIFF2 = "DF-2 Why Physically Difficult for R to Have Baby-2nd mention"
   REASDIFF3 = "DF-2 Why Physically Difficult for R to Have Baby-3rd mention"
   REASDIFF4 = "DF-2 Why Physically Difficult for R to Have Baby-4th mention"
   REASDIFF5 = "DF-2 Why Physically Difficult for R to Have Baby-5th mention"
   CANHAVEM = "DF-3 R's Current H/P Has Physical Difficulty Fathering a Baby"
   PREGNONO = "DF-4 Doctor Ever Advised R Never to Become Pregnant"
   REASNONO1 = "DF-5 Why R was Advised Against Pregnancy-1st mention"
   REASNONO2 = "DF-5 Why R was Advised Against Pregnancy-2nd mention"
   REASNONO3 = "DF-5 Why R was Advised Against Pregnancy-3rd mention"
   RSTRSTAT = "R's Sterility Status at Time of Interview"
   PSTRSTAT = "R's Current H/P's Sterility Status at Time of Interview"
   PILL = "EA-1 R ever used Birth Control Pills?"
   CONDOM = "EA-2 R ever used Condoms?"
   VASECTMY = "EA-3 R ever used partner's vasectomy?"
   DEPOPROV = "EA-4 R ever used Depo-Provera, Injectables?"
   WIDRAWAL = "EA-6 R ever used withdrawal?"
   RHYTHM = "EA-7 R ever used calendar rhythm method?"
   SDAYCBDS = "EA-7b R ever used Standard Days or CycleBeads method?"
   TEMPSAFE = "EA-8 R ever used symptothermal method?"
   PATCH = "EA-9 R ever used contraceptive patch?"
   RING = "EA-10 R ever used vaginal contraceptive ring or "NuvaRing"?"
   MORNPILL = "EA-11 R ever used emergency contraception?"
   ECTIMESX = "EA-12 Number of times R used emergency contraception"
   ECREASON1 = "EA-13 Reason R Used Emergency Contraception-1st Reason"
   ECREASON2 = "EA-13 Reason R Used Emergency Contraception-2nd Reason"
   ECREASON3 = "EA-13 Reason R Used Emergency Contraception-3rd Reason"
   ECRX = "EA-13aa Get emergency contraception with or without prescription?"
   ECWHERE = "EA-13a Where R last got emergency contraception"
   ECWHEN = "EA-13b R last got emergency contraception within past 12 mons or longer ago"
   OTHRMETH01 = "EA-14 Which other method ever used(if any)? - 1st mention"
   OTHRMETH02 = "EA-14 Which other method ever used(if any)? - 2nd mention"
   OTHRMETH03 = "EA-14 Which other method ever used(if any)? - 3rd mention"
   OTHRMETH04 = "EA-14 Which other method ever used(if any)? - 4th mention"
   OTHRMETH05 = "EA-14 Which other method ever used(if any)? - 5th mention"
   OTHRMETH06 = "EA-14 Which other method ever used(if any)? - 6th mention"
   OTHRMETH07 = "EA-14 Which other method ever used(if any)? - 7th mention"
   EVIUDTYP1 = "EA-15a Types of IUD ever used - 1st mention"
   EVIUDTYP2 = "EA-15a Types of IUD ever used - 2nd mention"
   NEWMETH = "Code for other method specified in EA-15 SP_OTHRMETH"
   EVERUSED = "R ever used any method (from EA  series & sterilization info from D)"
   METHDISS = "EA-16 R ever stop using method because dissatisfied with it"
   METHSTOP01 = "EA-17 Method Stopped Using Due to Dissatisfaction-1st Method"
   METHSTOP02 = "EA-17 Method Stopped Using Due to Dissatisfaction-2nd Method"
   METHSTOP03 = "EA-17 Method Stopped Using Due to Dissatisfaction-3rd Method"
   METHSTOP04 = "EA-17 Method Stopped Using Due to Dissatisfaction-4th Method"
   METHSTOP05 = "EA-17 Method Stopped Using Due to Dissatisfaction-5th Method"
   METHSTOP06 = "EA-17 Method Stopped Using Due to Dissatisfaction-6th Method"
   METHSTOP07 = "EA-17 Method Stopped Using Due to Dissatisfaction-7th Method"
   METHSTOP08 = "EA-17 Method Stopped Using Due to Dissatisfaction-8th Method"
   METHSTOP09 = "EA-17 Method Stopped Using Due to Dissatisfaction-9th Method"
   METHSTOP10 = "EA-17 Method Stopped Using Due to Dissatisfaction-10th Method"
   REASPILL01 = "EA-18 Reason not satisfied with the pill - 1st mention"
   REASPILL02 = "EA-18 Reason not satisfied with the pill - 2nd mention"
   REASPILL03 = "EA-18 Reason not satisfied with the pill - 3rd mention"
   REASPILL04 = "EA-18 Reason not satisfied with the pill - 4th mention"
   REASPILL05 = "EA-18 Reason not satisfied with the pill - 5th mention"
   REASPILL06 = "EA-18 Reason not satisfied with the pill - 6th mention"
   STOPPILL1 = "Open-ended response to reason(s) for discontinuation of pill: 1st mention"
   STOPPILL2 = "Open-ended response to reason(s) for discontinuation of pill: 2nd mention"
   STOPPILL3 = "Open-ended response to reason(s) for discontinuation of pill: 3rd mention"
   STOPPILL4 = "Open-ended response to reason(s) for discontinuation of pill: 4th mention"
   STOPPILL5 = "Open-ended response to reason(s) for discontinuation of pill: 5th mention"
   STOPPILL6 = "Open-ended response to reason(s) for discontinuation of pill: 6th mention"
   REASCOND01 = "EA-19 Reason not satisfied with condom - 1st mention"
   REASCOND02 = "EA-19 Reason not satisfied with condom - 2nd mention"
   REASCOND03 = "EA-19 Reason not satisfied with condom - 3rd mention"
   REASCOND04 = "EA-19 Reason not satisfied with condom - 4th mention"
   REASCOND05 = "EA-19 Reason not satisfied with condom - 5th mention"
   REASCOND06 = "EA-19 Reason not satisfied with condom - 6th mention"
   REASCOND07 = "EA-19 Reason not satisfied with condom - 7th mention"
   STOPCOND1 = "Open-ended response to reason(s) for discontinuation of condom: 1st mention"
   STOPCOND2 = "Open-ended response to reason(s) for discontinuation of condom: 2nd mention"
   REASDEPO01 = "EA-20 Reason not satisfied with Depo-Provera - 1st mention"
   REASDEPO02 = "EA-20 Reason not satisfied with Depo-Provera - 2nd mention"
   REASDEPO03 = "EA-20 Reason not satisfied with Depo-Provera - 3rd mention"
   REASDEPO04 = "EA-20 Reason not satisfied with Depo-Provera - 4th mention"
   REASDEPO05 = "EA-20 Reason not satisfied with Depo-Provera - 5th mention"
   REASDEPO06 = "EA-20 Reason not satisfied with Depo-Provera - 6th mention"
   REASDEPO07 = "EA-20 Reason not satisfied with Depo-Provera - 7th mention"
   REASDEPO08 = "EA-20 Reason not satisfied with Depo-Provera - 8th mention"
   STOPDEPO1 = "Open-ended response to reason(s) for discontinuation of Depo Provera: 1st mention"
   STOPDEPO2 = "Open-ended response to reason(s) for discontinuation of Depo Provera: 2nd mention"
   STOPDEPO3 = "Open-ended response to reason(s) for discontinuation of Depo Provera: 3rd mention"
   STOPDEPO4 = "Open-ended response to reason(s) for discontinuation of Depo Provera: 4th mention"
   STOPDEPO5 = "Open-ended response to reason(s) for discontinuation of Depo Provera: 5th mention"
   TYPEIUD_1 = "EA-21 Type of IUD that was discontinued due to dissatisfaction - 1st mention"
   TYPEIUD_2 = "EA-21 Type of IUD that was discontinued due to dissatisfaction - 2nd mention"
   REASIUD01 = "EA-21a Reason not satisfied with IUD - 1st mention"
   REASIUD02 = "EA-21a Reason not satisfied with IUD - 2nd mention"
   REASIUD03 = "EA-21a Reason not satisfied with IUD - 3rd mention"
   REASIUD04 = "EA-21a Reason not satisfied with IUD - 4th mention"
   REASIUD05 = "EA-21a Reason not satisfied with IUD - 5th mention"
   STOPIUD1 = "Open-ended response to reason(s) for discontinuation of IUD: 1st mention"
   STOPIUD2 = "Open-ended response to reason(s) for discontinuation of IUD: 2nd mention"
   STOPIUD3 = "Open-ended response to reason(s) for discontinuation of IUD: 3rd mention"
   STOPIUD4 = "Open-ended response to reason(s) for discontinuation of IUD: 4th mention"
   STOPIUD5 = "Open-ended response to reason(s) for discontinuation of IUD: 5th mention"
   FIRSMETH1 = "EB-1 First method ever used - 1st mention"
   FIRSMETH2 = "EB-1 First method ever used - 2nd mention"
   FIRSMETH3 = "EB-1 First method ever used - 3rd mention"
   FIRSMETH4 = "EB-1 First method ever used - 4th mention"
   NUMFIRSM = "Total number of responses in EB-1 FIRSMETH"
   DRUGDEV = "Yes if 1st method was drug or device, no otherwise (1st meth)"
   DRUGDEV2 = "Yes if 1st method was drug or device, no otherwise (2nd meth)"
   DRUGDEV3 = "Yes if 1st method was drug or device, no otherwise (3rd meth)"
   DRUGDEV4 = "Yes if 1st method was drug or device, no otherwise (4th meth)"
   FIRSTIME1 = "EB-2 when 1st method use vis-a-vis 1st sex (noncontinuous meth)"
   FIRSTIME2 = "EB-2 when first method use vis-a-vis 1st sex (continuous method)"
   USEFSTSX = "Whether R used a method at first sex (total universe)"
   CMFIRSM = "CM for date of first method use (total universe)"
   MTHFSTSX1 = "Method used at first sex-1st mention (tot universe)"
   MTHFSTSX2 = "Method used at first sex-2nd mention (tot universe)"
   MTHFSTSX3 = "Method used at first sex-3rd mention (tot universe)"
   MTHFSTSX4 = "Method used at first sex-4th mention (tot universe)"
   WNFSTUSE_M = "EB-3 Month R First Used a Method"
   WNFSTUSE_Y = "EB-3 Year R First Used a Method"
   FMETHPRS = "Whether 1st method perscrip or non prescrip (1st meth)"
   FMETHPRS2 = "Whether 1st method perscrip or non prescrip (2nd meth)"
   FMETHPRS3 = "Whether 1st method perscrip or non prescrip (3rd meth)"
   FMETHPRS4 = "Whether 1st method perscrip or non prescrip (4th meth)"
   CMFSTUSE = "Century month for date first used a method (if not at first sex) (partial univ)"
   AGEFSTUS = "EB-4 Age When First Used Method"
   PLACGOTF = "EB-5 Where R Got 1st Method-1st method mentioned"
   PLACGOTF2 = "EB-5 Where R Got 1st Method-2nd method mentioned"
   PLACGOTF3 = "EB-5 Where R Got 1st Method-3rd method mentioned"
   PLACGOTF4 = "EB-5 Where R Got 1st Method-4th method mentioned"
   USEFRSTS = "EB-6 R Use Any Method at First Sex (1st meth use was bef 1st sx)"
   MTHFRSTS1 = "EB-8 Method Used at  First Sex (1st meth use was bef 1st sx) -1st mention"
   MTHFRSTS2 = "EB-8 Method Used at  First Sex (1st meth use was bef 1st sx) -2nd mention"
   MTHFRSTS3 = "EB-8 Method Used at  First Sex (1st meth use was bef 1st sx) -3rd mention"
   MTHFRSTS4 = "EB-8 Method Used at  First Sex (1st meth use was bef 1st sx) -4th mention"
   INTR_EC3 = "EC-3 Any times since [Jan,intvw yr-3/date 1st sex] no sex for 1  mon?"
   CMMONSX = "Century month of this entry in the months of nonintercourse series (Jan, intvw yr-3)"
   MONSX = "EC-8 Sex in January [intvw yr-3]?"
   CMMONSX2 = "Century month of this entry in the months of nonintercourse series (Feb, intvw yr-3)"
   MONSX2 = "EC-8 Sex in February [intvw yr-3]?"
   CMMONSX3 = "Century month of this entry in the months of nonintercourse series (March, intvw yr-3)"
   MONSX3 = "EC-8 Sex in March [intvw yr-3]?"
   CMMONSX4 = "Century month of this entry in the months of nonintercourse series (April, intvw yr-3)"
   MONSX4 = "EC-8 Sex in April [intvw yr-3]?"
   CMMONSX5 = "Century month of this entry in the months of nonintercourse series (May, intvw yr-3)"
   MONSX5 = "EC-8 Sex in May [intvw yr-3]?"
   CMMONSX6 = "Century month of this entry in the months of nonintercourse series (June, intvw yr-3)"
   MONSX6 = "EC-8 Sex in June [intvw yr-3]?"
   CMMONSX7 = "Century month of this entry in the months of nonintercourse series (July, intvw yr-3)"
   MONSX7 = "EC-8 Sex in July [intvw yr-3]?"
   CMMONSX8 = "Century month of this entry in the months of nonintercourse series (Aug, intvw yr-3)"
   MONSX8 = "EC-8 Sex in August [intvw yr-3]?"
   CMMONSX9 = "Century month of this entry in the months of nonintercourse series (Sept, intvw yr-3)"
   MONSX9 = "EC-8 Sex in September [intvw yr-3]?"
   CMMONSX10 = "Century month of this entry in the months of nonintercourse series (Oct, intvw yr-3)"
   MONSX10 = "EC-8 Sex in October [intvw yr-3]?"
   CMMONSX11 = "Century month of this entry in the months of nonintercourse series (Nov, intvw yr-3)"
   MONSX11 = "EC-8 Sex in November [intvw yr-3]?"
   CMMONSX12 = "Century month of this entry in the months of nonintercourse series (Dec, intvw yr-3)"
   MONSX12 = "EC-8 Sex in December [intvw yr-3]?"
   CMMONSX13 = "Century month of this entry in the months of nonintercourse series (Jan, intvw yr-2)"
   MONSX13 = "EC-8 Sex in January [intvw yr-2]?"
   CMMONSX14 = "Century month of this entry in the months of nonintercourse series (Feb, intvw yr-2)"
   MONSX14 = "EC-8 Sex in February [intvw yr-2]?"
   CMMONSX15 = "Century month of this entry in the months of nonintercourse series (March, intvw yr-2)"
   MONSX15 = "EC-8 Sex in March [intvw yr-2]?"
   CMMONSX16 = "Century month of this entry in the months of nonintercourse series (April, intvw yr-2)"
   MONSX16 = "EC-8 Sex in April [intvw yr-2]?"
   CMMONSX17 = "Century month of this entry in the months of nonintercourse series (May, intvw yr-2)"
   MONSX17 = "EC-8 Sex in May [intvw yr-2]?"
   CMMONSX18 = "Century month of this entry in the months of nonintercourse series (June, intvw yr-2)"
   MONSX18 = "EC-8 Sex in June [intvw yr-2]?"
   CMMONSX19 = "Century month of this entry in the months of nonintercourse series (July, intvw yr-2)"
   MONSX19 = "EC-8 Sex in July [intvw yr-2]?"
   CMMONSX20 = "Century month of this entry in the months of nonintercourse series (Aug, intvw yr-2)"
   MONSX20 = "EC-8 Sex in August [intvw yr-2]?"
   CMMONSX21 = "Century month of this entry in the months of nonintercourse series (Sept, intvw yr-2)"
   MONSX21 = "EC-8 Sex in September [intvw yr-2]?"
   CMMONSX22 = "Century month of this entry in the months of nonintercourse series (Oct, intvw yr-2)"
   MONSX22 = "EC-8 Sex in October [intvw yr-2]?"
   CMMONSX23 = "Century month of this entry in the months of nonintercourse series (Nov, intvw yr-2)"
   MONSX23 = "EC-8 Sex in November [intvw yr-2]?"
   CMMONSX24 = "Century month of this entry in the months of nonintercourse series (Dec, intvw yr-2)"
   MONSX24 = "EC-8 Sex in December [intvw yr-2]?"
   CMMONSX25 = "Century month of this entry in the months of nonintercourse series (Jan, intvw yr-1)"
   MONSX25 = "EC-8 Sex in January [intvw yr-1]?"
   CMMONSX26 = "Century month of this entry in the months of nonintercourse series (Feb, intvw yr-1)"
   MONSX26 = "EC-8 Sex in February [intvw yr-1]?"
   CMMONSX27 = "Century month of this entry in the months of nonintercourse series (March, intvw yr-1)"
   MONSX27 = "EC-8 Sex in March [intvw yr-1]?"
   CMMONSX28 = "Century month of this entry in the months of nonintercourse series (April, intvw yr-1)"
   MONSX28 = "EC-8 Sex in April [intvw yr-1]?"
   CMMONSX29 = "Century month of this entry in the months of nonintercourse series (May, intvw yr-1)"
   MONSX29 = "EC-8 Sex in May [intvw yr-1]?"
   CMMONSX30 = "Century month of this entry in the months of nonintercourse series (June, intvw yr-1)"
   MONSX30 = "EC-8 Sex in June [intvw yr-1]?"
   CMMONSX31 = "Century month of this entry in the months of nonintercourse series (July, intvw yr-1)"
   MONSX31 = "EC-8 Sex in July [intvw yr-1]?"
   CMMONSX32 = "Century month of this entry in the months of nonintercourse series (Aug, intvw yr-1)"
   MONSX32 = "EC-8 Sex in August [intvw yr-1]?"
   CMMONSX33 = "Century month of this entry in the months of nonintercourse series (Sept, intvw yr-1)"
   MONSX33 = "EC-8 Sex in September [intvw yr-1]?"
   CMMONSX34 = "Century month of this entry in the months of nonintercourse series (Oct, intvw yr-1)"
   MONSX34 = "EC-8 Sex in October [intvw yr-1]?"
   CMMONSX35 = "Century month of this entry in the months of nonintercourse series (Nov, intvw yr-1)"
   MONSX35 = "EC-8 Sex in November [intvw yr-1]?"
   CMMONSX36 = "Century month of this entry in the months of nonintercourse series (Dec, intvw yr-1)"
   MONSX36 = "EC-8 Sex in December [intvw yr-1]?"
   CMMONSX37 = "Century month of this entry in the months of nonintercourse series (Jan, intvw yr)"
   MONSX37 = "EC-8 Sex in January [intvw yr]?"
   CMMONSX38 = "Century month of this entry in the months of nonintercourse series (Feb, intvw yr)"
   MONSX38 = "EC-8 Sex in February [intvw yr]?"
   CMMONSX39 = "Century month of this entry in the months of nonintercourse series (March, intvw yr)"
   MONSX39 = "EC-8 Sex in March [intvw yr]?"
   CMMONSX40 = "Century month of this entry in the months of nonintercourse series (April, intvw yr)"
   MONSX40 = "EC-8 Sex in April [intvw yr]?"
   CMMONSX41 = "Century month of this entry in the months of nonintercourse series (May, intvw yr)"
   MONSX41 = "EC-8 Sex in May [intvw yr]?"
   CMMONSX42 = "Century month of this entry in the months of nonintercourse series (June, intvw yr)"
   MONSX42 = "EC-8 Sex in June [intvw yr]?"
   CMMONSX43 = "Century month of this entry in the months of nonintercourse series (July, intvw yr)"
   MONSX43 = "EC-8 Sex in July [intvw yr]?"
   CMMONSX44 = "Century month of this entry in the months of nonintercourse series (Aug, intvw yr)"
   MONSX44 = "EC-8 Sex in August [intvw yr]?"
   CMMONSX45 = "Century month of this entry in the months of nonintercourse series (Sept, intvw yr)"
   MONSX45 = "EC-8 Sex in September [intvw yr]?"
   CMMONSX46 = "Century month of this entry in the months of nonintercourse series (Oct, intvw yr)"
   MONSX46 = "EC-8 Sex in October [intvw yr]?"
   CMMONSX47 = "Century month of this entry in the months of nonintercourse series (Nov, intvw yr)"
   MONSX47 = "EC-8 Sex in November [intvw yr]?"
   CMMONSX48 = "Century month of this entry in the months of nonintercourse series (Dec, intvw yr)"
   MONSX48 = "EC-8 Sex in December [intvw yr]?"
   CMSTRTMC = "Century month for date of starting month of method calendar"
   CMENDMC = "Century month for date of ending month of method calendar"
   INTR_ED4A = "ED-4a For Rs who had hysterectomies before start of meth cal: use any method since Jan [interview yr - 3]/start of method calendar]?"
   NUMMCMON = "Number of months of meth. calendar asked about"
   MC1MONS1 = "ED-9a # of months using method specified in 1st MC month (one method mentioned)"
   MC1SIMSQ = "ED-9b Using methods in 1st MC month at same or diff times (2+ methods mentioned)"
   MC1MONS2 = "ED-9c # of months using methods together (1st MC month) (2+ methods mentioned, used at same time)"
   MC1MONS3 = "ED-9d # of months using method combinations (1st MC month) (2+ methods mentioned, used at diff times)"
   DATBEGIN_M = "ED-9 Month R Began Using method/method combo used in Jan [interview yr-3]"
   DATBEGIN_Y = "ED-9 Year R Began Using method/method combo used in Jan [interview yr-3]"
   CMDATBEGIN = "CM date  R Began Using method/method combo used in Jan [interview yr-3]"
   CURRMETH1 = "Method used in month of interview (1st mention)"
   CURRMETH2 = "Method used in month of interview (2nd mention)"
   CURRMETH3 = "Method used in month of interview (3rd mention)"
   CURRMETH4 = "Method used in month of interview (4th mention)"
   LSTMONMETH1 = "Method used in month before interview (1st mention)"
   LSTMONMETH2 = "Method used in month before interview (2nd mention)"
   LSTMONMETH3 = "Method used in month before interview (3rd mention)"
   LSTMONMETH4 = "Method used in month before interview (4th mention)"
   PILL_12 = "FC E-55 R used pill in 12 mos before interview?"
   DIAPH_12 = "FC E-55 R used diaphragm in the 12 mos before interview?"
   IUD_12 = "FC E-55 R used IUD in the 12 mos before interview?"
   IMPLANT_12 = "FC E-55 R used hormonal implants (Norplant or Implanon) in 12 mos before interview?"
   DEPO_12 = "FC E-55 R used Depo-provera injectables in the 12 mos before interview?"
   CERVC_12 = "FC E-55 R used cervical cap in the 12 mos before interview"
   MPILL_12 = "FC E-55 R used emergency contraceptive in the 12 mos before interview?"
   PATCH_12 = "FC E-55 R used contraceptive patch in the 12 mos before interview?"
   RING_12 = "FC E-55 R used contraceptive ring in the 12 mos before interview?"
   METHX1 = "ED-6 Method(s) used in Jan [interview yr-3] - 1st mention"
   METHX2 = "ED-6 Method(s) used in Jan [interview yr-3]-2nd mention"
   METHX3 = "ED-6 Method(s) used in Jan [interview yr-3]-3rd mention"
   METHX4 = "ED-6 Method(s) used in Jan [interview yr-3]-4th mention"
   METHX5 = "ED-6 Method(s) used in Feb [interview yr-3] - 1st mention"
   METHX6 = "ED-6 Method(s) used in Feb [interview yr-3]-2nd mention"
   METHX7 = "ED-6 Method(s) used in Feb [interview yr-3] - 3rd mention"
   METHX8 = "ED-6 Method(s) used in Feb [interview yr-3]-4th mention"
   METHX9 = "ED-6 Method(s) used in March [interview yr-3] - 1st mention"
   METHX10 = "ED-6 Method(s) used in March [interview yr-3]-2nd mention"
   METHX11 = "ED-6 Method(s) used in March [interview yr-3] - 3rd mention"
   METHX12 = "ED-6 Method(s) used in March [interview yr-3]-4th mention"
   METHX13 = "ED-6 Method(s) used in April [interview yr-3] - 1st mention"
   METHX14 = "ED-6 Method(s) used in April [interview yr-3]-2nd mention"
   METHX15 = "ED-6 Method(s) used in April [interview yr-3] - 3rd mention"
   METHX16 = "ED-6 Method(s) used in April [interview yr-3]-4th mention"
   METHX17 = "ED-6 Method(s) used in May [interview yr-3] - 1st mention"
   METHX18 = "ED-6 Method(s) used in May [interview yr-3]-2nd mention"
   METHX19 = "ED-6 Method(s) used in May [interview yr-3] - 3rd mention"
   METHX20 = "ED-6 Method(s) used in May [interview yr-3]-4th mention"
   METHX21 = "ED-6 Method(s) used in June [interview yr-3] - 1st mention"
   METHX22 = "ED-6 Method(s) used in June [interview yr-3]-2nd mention"
   METHX23 = "ED-6 Method(s) used in June [interview yr-3] - 3rd mention"
   METHX24 = "ED-6 Method(s) used in June [interview yr-3]-4th mention"
   METHX25 = "ED-6 Method(s) used in July [interview yr-3] - 1st mention"
   METHX26 = "ED-6 Method(s) used in July [interview yr-3]-2nd mention"
   METHX27 = "ED-6 Method(s) used in July [interview yr-3] - 3rd mention"
   METHX28 = "ED-6 Method(s) used in July [interview yr-3]-4th mention"
   METHX29 = "ED-6 Method(s) used in Aug [interview yr-3] - 1st mention"
   METHX30 = "ED-6 Method(s) used in Aug [interview yr-3]-2nd mention"
   METHX31 = "ED-6 Method(s) used in Aug [interview yr-3] - 3rd mention"
   METHX32 = "ED-6 Method(s) used in Aug [interview yr-3]-4th mention"
   METHX33 = "ED-6 Method(s) used in Sept [interview yr-3] - 1st mention"
   METHX34 = "ED-6 Method(s) used in Sept [interview yr-3]-2nd mention"
   METHX35 = "ED-6 Method(s) used in Sept [interview yr-3] - 3rd mention"
   METHX36 = "ED-6 Method(s) used in Sept [interview yr-3]-4th mention"
   METHX37 = "ED-6 Method(s) used in Oct [interview yr-3] - 1st mention"
   METHX38 = "ED-6 Method(s) used in Oct [interview yr-3]-2nd mention"
   METHX39 = "ED-6 Method(s) used in Oct [interview yr-3] - 3rd mention"
   METHX40 = "ED-6 Method(s) used in Oct [interview yr-3]-4th mention"
   METHX41 = "ED-6 Method(s) used in Nov [interview yr-3] - 1st mention"
   METHX42 = "ED-6 Method(s) used in Nov [interview yr-3]-2nd mention"
   METHX43 = "ED-6 Method(s) used in Nov [interview yr-3] - 3rd mention"
   METHX44 = "ED-6 Method(s) used in Nov [interview yr-3]-4th mention"
   METHX45 = "ED-6 Method(s) used in Dec [interview yr-3] - 1st mention"
   METHX46 = "ED-6 Method(s) used in Dec [interview yr-3]-2nd mention"
   METHX47 = "ED-6 Method(s) used in Dec [interview yr-3] - 3rd mention"
   METHX48 = "ED-6 Method(s) used in Dec [interview yr-3]-4th mention"
   METHX49 = "ED-6 Method(s) used in Jan [interview yr-2] - 1st mention"
   METHX50 = "ED-6 Method(s) used in Jan [interview yr-2]-2nd mention"
   METHX51 = "ED-6 Method(s) used in Jan [interview yr-2]-3rd mention"
   METHX52 = "ED-6 Method(s) used in Jan [interview yr-2]-4th mention"
   METHX53 = "ED-6 Method(s) used in Feb [interview yr-2] - 1st mention"
   METHX54 = "ED-6 Method(s) used in Feb [interview yr-2]-2nd mention"
   METHX55 = "ED-6 Method(s) used in Feb [interview yr-2] - 3rd mention"
   METHX56 = "ED-6 Method(s) used in Feb [interview yr-2]-4th mention"
   METHX57 = "ED-6 Method(s) used in March [interview yr-2] - 1st mention"
   METHX58 = "ED-6 Method(s) used in March [interview yr-2]-2nd mention"
   METHX59 = "ED-6 Method(s) used in March [interview yr-2] - 3rd mention"
   METHX60 = "ED-6 Method(s) used in March [interview yr-2]-4th mention"
   METHX61 = "ED-6 Method(s) used in April [interview yr-2] - 1st mention"
   METHX62 = "ED-6 Method(s) used in April [interview yr-2]-2nd mention"
   METHX63 = "ED-6 Method(s) used in April [interview yr-2] - 3rd mention"
   METHX64 = "ED-6 Method(s) used in April [interview yr-2]-4th mention"
   METHX65 = "ED-6 Method(s) used in May [interview yr-2] - 1st mention"
   METHX66 = "ED-6 Method(s) used in May [interview yr-2]-2nd mention"
   METHX67 = "ED-6 Method(s) used in May [interview yr-2] - 3rd mention"
   METHX68 = "ED-6 Method(s) used in May [interview yr-2]-4th mention"
   METHX69 = "ED-6 Method(s) used in June [interview yr-2] - 1st mention"
   METHX70 = "ED-6 Method(s) used in June [interview yr-2]-2nd mention"
   METHX71 = "ED-6 Method(s) used in June [interview yr-2] - 3rd mention"
   METHX72 = "ED-6 Method(s) used in June [interview yr-2]-4th mention"
   METHX73 = "ED-6 Method(s) used in July [interview yr-2] - 1st mention"
   METHX74 = "ED-6 Method(s) used in July [interview yr-2]-2nd mention"
   METHX75 = "ED-6 Method(s) used in July [interview yr-2] - 3rd mention"
   METHX76 = "ED-6 Method(s) used in July [interview yr-2]-4th mention"
   METHX77 = "ED-6 Method(s) used in Aug [interview yr-2] - 1st mention"
   METHX78 = "ED-6 Method(s) used in Aug [interview yr-2]-2nd mention"
   METHX79 = "ED-6 Method(s) used in Aug [interview yr-2] - 3rd mention"
   METHX80 = "ED-6 Method(s) used in Aug [interview yr-2]-4th mention"
   METHX81 = "ED-6 Method(s) used in Sept [interview yr-2] - 1st mention"
   METHX82 = "ED-6 Method(s) used in Sept [interview yr-2]-2nd mention"
   METHX83 = "ED-6 Method(s) used in Sept [interview yr-2] - 3rd mention"
   METHX84 = "ED-6 Method(s) used in Sept [interview yr-2]-4th mention"
   METHX85 = "ED-6 Method(s) used in Oct [interview yr-2] - 1st mention"
   METHX86 = "ED-6 Method(s) used in Oct [interview yr-2]-2nd mention"
   METHX87 = "ED-6 Method(s) used in Oct [interview yr-2] - 3rd mention"
   METHX88 = "ED-6 Method(s) used in Oct [interview yr-2]-4th mention"
   METHX89 = "ED-6 Method(s) used in Nov [interview yr-2] - 1st mention"
   METHX90 = "ED-6 Method(s) used in Nov [interview yr-2]-2nd mention"
   METHX91 = "ED-6 Method(s) used in Nov [interview yr-2] - 3rd mention"
   METHX92 = "ED-6 Method(s) used in Nov [interview yr-2]-4th mention"
   METHX93 = "ED-6 Method(s) used in Dec [interview yr-2] - 1st mention"
   METHX94 = "ED-6 Method(s) used in Dec [interview yr-2]-2nd mention"
   METHX95 = "ED-6 Method(s) used in Dec [interview yr-2] - 3rd mention"
   METHX96 = "ED-6 Method(s) used in Dec [interview yr-2]-4th mention"
   METHX97 = "ED-6 Method(s) used in Jan [interview yr-1] - 1st mention"
   METHX98 = "ED-6 Method(s) used in Jan [interview yr-1]-2nd mention"
   METHX99 = "ED-6 Method(s) used in Jan [interview yr-1]-3rd mention"
   METHX100 = "ED-6 Method(s) used in Jan [interview yr-1]-4th mention"
   METHX101 = "ED-6 Method(s) used in Feb [interview yr-1] - 1st mention"
   METHX102 = "ED-6 Method(s) used in Feb [interview yr-1]-2nd mention"
   METHX103 = "ED-6 Method(s) used in Feb [interview yr-1] - 3rd mention"
   METHX104 = "ED-6 Method(s) used in Feb [interview yr-1]-4th mention"
   METHX105 = "ED-6 Method(s) used in March [interview yr-1] - 1st mention"
   METHX106 = "ED-6 Method(s) used in March [interview yr-1]-2nd mention"
   METHX107 = "ED-6 Method(s) used in March [interview yr-1] - 3rd mention"
   METHX108 = "ED-6 Method(s) used in March [interview yr-1]-4th mention"
   METHX109 = "ED-6 Method(s) used in April [interview yr-1] - 1st mention"
   METHX110 = "ED-6 Method(s) used in April [interview yr-1]-2nd mention"
   METHX111 = "ED-6 Method(s) used in April [interview yr-1] - 3rd mention"
   METHX112 = "ED-6 Method(s) used in April [interview yr-1]-4th mention"
   METHX113 = "ED-6 Method(s) used in May [interview yr-1] - 1st mention"
   METHX114 = "ED-6 Method(s) used in May [interview yr-1]-2nd mention"
   METHX115 = "ED-6 Method(s) used in May [interview yr-1] - 3rd mention"
   METHX116 = "ED-6 Method(s) used in May [interview yr-1]-4th mention"
   METHX117 = "ED-6 Method(s) used in June [interview yr-1] - 1st mention"
   METHX118 = "ED-6 Method(s) used in June [interview yr-1]-2nd mention"
   METHX119 = "ED-6 Method(s) used in June [interview yr-1] - 3rd mention"
   METHX120 = "ED-6 Method(s) used in June [interview yr-1]-4th mention"
   METHX121 = "ED-6 Method(s) used in July [interview yr-1] - 1st mention"
   METHX122 = "ED-6 Method(s) used in July [interview yr-1]-2nd mention"
   METHX123 = "ED-6 Method(s) used in July [interview yr-1] - 3rd mention"
   METHX124 = "ED-6 Method(s) used in July [interview yr-1]-4th mention"
   METHX125 = "ED-6 Method(s) used in Aug [interview yr-1] - 1st mention"
   METHX126 = "ED-6 Method(s) used in Aug [interview yr-1]-2nd mention"
   METHX127 = "ED-6 Method(s) used in Aug [interview yr-1] - 3rd mention"
   METHX128 = "ED-6 Method(s) used in Aug [interview yr-1]-4th mention"
   METHX129 = "ED-6 Method(s) used in Sept [interview yr-1] - 1st mention"
   METHX130 = "ED-6 Method(s) used in Sept [interview yr-1]-2nd mention"
   METHX131 = "ED-6 Method(s) used in Sept [interview yr-1] - 3rd mention"
   METHX132 = "ED-6 Method(s) used in Sept [interview yr-1]-4th mention"
   METHX133 = "ED-6 Method(s) used in Oct [interview yr-1] - 1st mention"
   METHX134 = "ED-6 Method(s) used in Oct [interview yr-1]-2nd mention"
   METHX135 = "ED-6 Method(s) used in Oct [interview yr-1] - 3rd mention"
   METHX136 = "ED-6 Method(s) used in Oct [interview yr-1]-4th mention"
   METHX137 = "ED-6 Method(s) used in Nov [interview yr-1] - 1st mention"
   METHX138 = "ED-6 Method(s) used in Nov [interview yr-1]-2nd mention"
   METHX139 = "ED-6 Method(s) used in Nov [interview yr-1] - 3rd mention"
   METHX140 = "ED-6 Method(s) used in Nov [interview yr-1]-4th mention"
   METHX141 = "ED-6 Method(s) used in Dec [interview yr-1] - 1st mention"
   METHX142 = "ED-6 Method(s) used in Dec [interview yr-1]-2nd mention"
   METHX143 = "ED-6 Method(s) used in Dec [interview yr-1] - 3rd mention"
   METHX144 = "ED-6 Method(s) used in Dec [interview yr-1]-4th mention"
   METHX145 = "ED-6 Method(s) used in Jan [interview yr] - 1st mention"
   METHX146 = "ED-6 Method(s) used in Jan [interview yr]-2nd mention"
   METHX147 = "ED-6 Method(s) used in Jan [interview yr]-3rd mention"
   METHX148 = "ED-6 Method(s) used in Jan [interview yr]-4th mention"
   METHX149 = "ED-6 Method(s) used in Feb [interview yr] - 1st mention"
   METHX150 = "ED-6 Method(s) used in Feb [interview yr]-2nd mention"
   METHX151 = "ED-6 Method(s) used in Feb [interview yr] - 3rd mention"
   METHX152 = "ED-6 Method(s) used in Feb [interview yr]-4th mention"
   METHX153 = "ED-6 Method(s) used in March [interview yr] - 1st mention"
   METHX154 = "ED-6 Method(s) used in March [interview yr]-2nd mention"
   METHX155 = "ED-6 Method(s) used in March [interview yr] - 3rd mention"
   METHX156 = "ED-6 Method(s) used in March [interview yr]-4th mention"
   METHX157 = "ED-6 Method(s) used in April [interview yr] - 1st mention"
   METHX158 = "ED-6 Method(s) used in April [interview yr]-2nd mention"
   METHX159 = "ED-6 Method(s) used in April [interview yr] - 3rd mention"
   METHX160 = "ED-6 Method(s) used in April [interview yr]-4th mention"
   METHX161 = "ED-6 Method(s) used in May [interview yr] - 1st mention"
   METHX162 = "ED-6 Method(s) used in May [interview yr]-2nd mention"
   METHX163 = "ED-6 Method(s) used in May [interview yr] - 3rd mention"
   METHX164 = "ED-6 Method(s) used in May [interview yr]-4th mention"
   METHX165 = "ED-6 Method(s) used in June [interview yr] - 1st mention"
   METHX166 = "ED-6 Method(s) used in June [interview yr]-2nd mention"
   METHX167 = "ED-6 Method(s) used in June [interview yr] - 3rd mention"
   METHX168 = "ED-6 Method(s) used in June [interview yr]-4th mention"
   METHX169 = "ED-6 Method(s) used in July [interview yr] - 1st mention"
   METHX170 = "ED-6 Method(s) used in July [interview yr]-2nd mention"
   METHX171 = "ED-6 Method(s) used in July [interview yr] - 3rd mention"
   METHX172 = "ED-6 Method(s) used in July [interview yr]-4th mention"
   METHX173 = "ED-6 Method(s) used in Aug [interview yr] - 1st mention"
   METHX174 = "ED-6 Method(s) used in Aug [interview yr]-2nd mention"
   METHX175 = "ED-6 Method(s) used in Aug [interview yr] - 3rd mention"
   METHX176 = "ED-6 Method(s) used in Aug [interview yr]-4th mention"
   METHX177 = "ED-6 Method(s) used in Sept [interview yr] - 1st mention"
   METHX178 = "ED-6 Method(s) used in Sept [interview yr]-2nd mention"
   METHX179 = "ED-6 Method(s) used in Sept [interview yr] - 3rd mention"
   METHX180 = "ED-6 Method(s) used in Sept [interview yr]-4th mention"
   METHX181 = "ED-6 Method(s) used in Oct [interview yr] - 1st mention"
   METHX182 = "ED-6 Method(s) used in Oct [interview yr]-2nd mention"
   METHX183 = "ED-6 Method(s) used in Oct [interview yr] - 3rd mention"
   METHX184 = "ED-6 Method(s) used in Oct [interview yr]-4th mention"
   METHX185 = "ED-6 Method(s) used in Nov [interview yr] - 1st mention"
   METHX186 = "ED-6 Method(s) used in Nov [interview yr]-2nd mention"
   METHX187 = "ED-6 Method(s) used in Nov [interview yr] - 3rd mention"
   METHX188 = "ED-6 Method(s) used in Nov [interview yr]-4th mention"
   METHX189 = "ED-6 Method(s) used in Dec [interview yr] - 1st mention"
   METHX190 = "ED-6 Method(s) used in Dec [interview yr]-2nd mention"
   METHX191 = "ED-6 Method(s) used in Dec [interview yr] - 3rd mention"
   METHX192 = "ED-6 Method(s) used in Dec [interview yr]-4th mention"
   CMMHCALX1 = "Century month of Jan [interview yr-3] in the method history calendar"
   CMMHCALX2 = "Century month of  Feb [interview yr-3] in the method history calendar"
   CMMHCALX3 = "Century month of  March [interview yr-3] in the method history calendar"
   CMMHCALX4 = "Century month of  April [interview yr-3] in the method history calendar"
   CMMHCALX5 = "Century month of  May [interview yr-3] in the method history calendar"
   CMMHCALX6 = "Century month of  June [interview yr-3] in the method history calendar"
   CMMHCALX7 = "Century month of  July [interview yr-3] in the method history calendar"
   CMMHCALX8 = "Century month of  Aug [interview yr-3] in the method history calendar"
   CMMHCALX9 = "Century month of  Sept [interview yr-3] in the method history calendar"
   CMMHCALX10 = "Century month of  Oct [interview yr-3] in the method history calendar"
   CMMHCALX11 = "Century month of  Nov [interview yr-3] in the method history calendar"
   CMMHCALX12 = "Century month of  Dec [interview yr-3] in the method history calendar"
   CMMHCALX13 = "Century month of Jan [interview yr-2] in the method history calendar"
   CMMHCALX14 = "Century month of  Feb [interview yr-2] in the method history calendar"
   CMMHCALX15 = "Century month of  March [interview yr-2] in the method history calendar"
   CMMHCALX16 = "Century month of  April [interview yr-2] in the method history calendar"
   CMMHCALX17 = "Century month of  May [interview yr-2] in the method history calendar"
   CMMHCALX18 = "Century month of  June [interview yr-2] in the method history calendar"
   CMMHCALX19 = "Century month of  July [interview yr-2] in the method history calendar"
   CMMHCALX20 = "Century month of  Aug [interview yr-2] in the method history calendar"
   CMMHCALX21 = "Century month of  Sept [interview yr-2] in the method history calendar"
   CMMHCALX22 = "Century month of  Oct [interview yr-2] in the method history calendar"
   CMMHCALX23 = "Century month of  Nov [interview yr-2] in the method history calendar"
   CMMHCALX24 = "Century month of  Dec [interview yr-2] in the method history calendar"
   CMMHCALX25 = "Century month of Jan [interview yr-1] in the method history calendar"
   CMMHCALX26 = "Century month of  Feb [interview yr-1] in the method history calendar"
   CMMHCALX27 = "Century month of  March [interview yr-1] in the method history calendar"
   CMMHCALX28 = "Century month of  April [interview yr-1] in the method history calendar"
   CMMHCALX29 = "Century month of  May [interview yr-1] in the method history calendar"
   CMMHCALX30 = "Century month of  June [interview yr-1] in the method history calendar"
   CMMHCALX31 = "Century month of  July [interview yr-1] in the method history calendar"
   CMMHCALX32 = "Century month of  Aug [interview yr-1] in the method history calendar"
   CMMHCALX33 = "Century month of  Sept [interview yr-1] in the method history calendar"
   CMMHCALX34 = "Century month of  Oct [interview yr-1] in the method history calendar"
   CMMHCALX35 = "Century month of  Nov [interview yr-1] in the method history calendar"
   CMMHCALX36 = "Century month of  Dec [interview yr-1] in the method history calendar"
   CMMHCALX37 = "Century month of Jan [interview yr] in the method history calendar"
   CMMHCALX38 = "Century month of  Feb [interview yr] in the method history calendar"
   CMMHCALX39 = "Century month of  March [interview yr] in the method history calendar"
   CMMHCALX40 = "Century month of  April [interview yr] in the method history calendar"
   CMMHCALX41 = "Century month of  May [interview yr] in the method history calendar"
   CMMHCALX42 = "Century month of  June [interview yr] in the method history calendar"
   CMMHCALX43 = "Century month of  July [interview yr] in the method history calendar"
   CMMHCALX44 = "Century month of  Aug [interview yr] in the method history calendar"
   CMMHCALX45 = "Century month of  Sept [interview yr] in the method history calendar"
   CMMHCALX46 = "Century month of  Oct [interview yr] in the method history calendar"
   CMMHCALX47 = "Century month of  Nov [interview yr] in the method history calendar"
   CMMHCALX48 = "Century month of  Dec [interview yr] in the method history calendar"
   NUMMULTX1 = "Number of Methods Reported in Jan [interview yr-3]"
   NUMMULTX2 = "Number of Methods Reported in Feb [interview yr-3]"
   NUMMULTX3 = "Number of Methods Reported in March [interview yr-3]"
   NUMMULTX4 = "Number of Methods Reported in April [interview yr-3]"
   NUMMULTX5 = "Number of Methods Reported in May [interview yr-3]"
   NUMMULTX6 = "Number of Methods Reported in June [interview yr-3]"
   NUMMULTX7 = "Number of Methods Reported in July [interview yr-3]"
   NUMMULTX8 = "Number of Methods Reported in Aug [interview yr-3]"
   NUMMULTX9 = "Number of Methods Reported in Sept [interview yr-3]"
   NUMMULTX10 = "Number of Methods Reported in Oct [interview yr-3]"
   NUMMULTX11 = "Number of Methods Reported in Nov [interview yr-3]"
   NUMMULTX12 = "Number of Methods Reported in Dec [interview yr-3]"
   NUMMULTX13 = "Number of Methods Reported in Jan [interview yr-2]"
   NUMMULTX14 = "Number of Methods Reported in Feb [interview yr-2]"
   NUMMULTX15 = "Number of Methods Reported in March [interview yr-2]"
   NUMMULTX16 = "Number of Methods Reported in April [interview yr-2]"
   NUMMULTX17 = "Number of Methods Reported in May [interview yr-2]"
   NUMMULTX18 = "Number of Methods Reported in June [interview yr-2]"
   NUMMULTX19 = "Number of Methods Reported in July [interview yr-2]"
   NUMMULTX20 = "Number of Methods Reported in Aug [interview yr-2]"
   NUMMULTX21 = "Number of Methods Reported in Sept [interview yr-2]"
   NUMMULTX22 = "Number of Methods Reported in Oct [interview yr-2]"
   NUMMULTX23 = "Number of Methods Reported in Nov [interview yr-2]"
   NUMMULTX24 = "Number of Methods Reported in Dec [interview yr-2]"
   NUMMULTX25 = "Number of Methods Reported in Jan [interview yr-1]"
   NUMMULTX26 = "Number of Methods Reported in Feb [interview yr-1]"
   NUMMULTX27 = "Number of Methods Reported in March [interview yr-1]"
   NUMMULTX28 = "Number of Methods Reported in April [interview yr-1]"
   NUMMULTX29 = "Number of Methods Reported in May [interview yr-1]"
   NUMMULTX30 = "Number of Methods Reported in June [interview yr-1]"
   NUMMULTX31 = "Number of Methods Reported in July [interview yr-1]"
   NUMMULTX32 = "Number of Methods Reported in Aug [interview yr-1]"
   NUMMULTX33 = "Number of Methods Reported in Sept [interview yr-1]"
   NUMMULTX34 = "Number of Methods Reported in Oct [interview yr-1]"
   NUMMULTX35 = "Number of Methods Reported in Nov [interview yr-1]"
   NUMMULTX36 = "Number of Methods Reported in Dec [interview yr-1]"
   NUMMULTX37 = "Number of Methods Reported in Jan [interview yr]"
   NUMMULTX38 = "Number of Methods Reported in Feb [interview yr]"
   NUMMULTX39 = "Number of Methods Reported in March [interview yr]"
   NUMMULTX40 = "Number of Methods Reported in April [interview yr]"
   NUMMULTX41 = "Number of Methods Reported in May [interview yr]"
   NUMMULTX42 = "Number of Methods Reported in June [interview yr]"
   NUMMULTX43 = "Number of Methods Reported in July [interview yr]"
   NUMMULTX44 = "Number of Methods Reported in Aug [interview yr]"
   NUMMULTX45 = "Number of Methods Reported in Sept [interview yr]"
   NUMMULTX46 = "Number of Methods Reported in Oct [interview yr]"
   NUMMULTX47 = "Number of Methods Reported in Nov [interview yr]"
   NUMMULTX48 = "Number of Methods Reported in Dec [interview yr]"
   SALMX1 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Jan [interview yr-3]"
   SALMX2 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Feb [interview yr-3]"
   SALMX3 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST -Mar [interview yr-3]"
   SALMX4 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - April [interview yr-3]"
   SALMX5 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - May [interview yr-3]"
   SALMX6 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - June [interview yr-3]"
   SALMX7 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - July [interview yr-3]"
   SALMX8 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Aug [interview yr-3]"
   SALMX9 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Sept [interview yr-3]"
   SALMX10 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Oct [interview yr-3]"
   SALMX11 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Nov [interview yr-3]"
   SALMX12 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Dec [interview yr-3]"
   SALMX13 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Jan [interview yr-2]"
   SALMX14 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Feb [interview yr-2]"
   SALMX15 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Mar [interview yr-2]"
   SALMX16 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - April [interview yr-2]"
   SALMX17 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - May [interview yr-2]"
   SALMX18 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - June [interview yr-2]"
   SALMX19 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - July [interview yr-2]"
   SALMX20 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Aug [interview yr-2]"
   SALMX21 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Sept [interview yr-2]"
   SALMX22 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Oct [interview yr-2]"
   SALMX23 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Nov [interview yr-2]"
   SALMX24 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Dec [interview yr-2]"
   SALMX25 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Jan [interview yr-1]"
   SALMX26 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Feb [interview yr-1]"
   SALMX27 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Mar [interview yr-1]"
   SALMX28 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - April [interview yr-1]"
   SALMX29 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - May [interview yr-1]"
   SALMX30 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - June [interview yr-1]"
   SALMX31 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - July [interview yr-1]"
   SALMX32 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Aug [interview yr-1]"
   SALMX33 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Sept [interview yr-1]"
   SALMX34 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Oct [interview yr-1]"
   SALMX35 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Nov [interview yr-1]"
   SALMX36 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Dec [interview yr-1]"
   SALMX37 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Jan [interview yr]"
   SALMX38 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Feb [interview yr]"
   SALMX39 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Mar [interview yr]"
   SALMX40 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - April [interview yr]"
   SALMX41 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - May [interview yr]"
   SALMX42 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - June [interview yr]"
   SALMX43 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - July [interview yr]"
   SALMX44 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Aug [interview yr]"
   SALMX45 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Sept [interview yr]"
   SALMX46 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Oct [interview yr]"
   SALMX47 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Nov [interview yr]"
   SALMX48 = "Flag indicating whether " Same as last month"  was original answer to ED-6 METHHIST - Dec [interview yr]"
   SAYX1 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Jan [interview yr-3]"
   SAYX2 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Feb [interview yr-3]"
   SAYX3 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Mar [interview yr-3]"
   SAYX4 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - April [interview yr-3]"
   SAYX5 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - May [interview yr-3]"
   SAYX6 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - June [interview yr-3]"
   SAYX7 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - July [interview yr-3]"
   SAYX8 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Aug [interview yr-3]"
   SAYX9 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Sept [interview yr-3]"
   SAYX10 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Oct [interview yr-3]"
   SAYX11 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Nov [interview yr-3]"
   SAYX12 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Dec [interview yr-3]"
   SAYX13 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Jan [interview yr-2]"
   SAYX14 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Feb [interview yr-2]"
   SAYX15 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Mar [interview yr-2]"
   SAYX16 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - April [interview yr-2]"
   SAYX17 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - May [interview yr-2]"
   SAYX18 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - June [interview yr-2]"
   SAYX19 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - July [interview yr-2]"
   SAYX20 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Aug [interview yr-2]"
   SAYX21 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Sept [interview yr-2]"
   SAYX22 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Oct [interview yr-2]"
   SAYX23 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Nov [interview yr-2]"
   SAYX24 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Dec [interview yr-2]"
   SAYX25 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Jan [interview yr-1]"
   SAYX26 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Feb [interview yr-1]"
   SAYX27 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Mar [interview yr-1]"
   SAYX28 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - April [interview yr-1]"
   SAYX29 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - May [interview yr-1]"
   SAYX30 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - June [interview yr-1]"
   SAYX31 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - July [interview yr-1]"
   SAYX32 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Aug [interview yr-1]"
   SAYX33 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Sept [interview yr-1]"
   SAYX34 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Oct [interview yr-1]"
   SAYX35 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Nov [interview yr-1]"
   SAYX36 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Dec [interview yr-1]"
   SAYX37 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Jan [interview yr]"
   SAYX38 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Feb [interview yr]"
   SAYX39 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Mar [interview yr]"
   SAYX40 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - April [interview yr]"
   SAYX41 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - May [interview yr]"
   SAYX42 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - June [interview yr]"
   SAYX43 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - July [interview yr]"
   SAYX44 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Aug [interview yr]"
   SAYX45 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Sept [interview yr]"
   SAYX46 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Oct [interview yr]"
   SAYX47 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Nov [interview yr]"
   SAYX48 = "Flag indicating whether " Same all year"  was original answer to ED-6 METHHIST - Dec [interview yr]"
   SIMSEQX1 = "ED-10 Use Methods Together or at Different Times - Jan [interview yr-3]"
   SIMSEQX2 = "ED-10 Use Methods Together or at Different Times - Feb [interview yr-3]"
   SIMSEQX3 = "ED-10 Use Methods Together or at Different Times - Mar [interview yr-3]"
   SIMSEQX4 = "ED-10 Use Methods Together or at Different Times - April [interview yr-3]"
   SIMSEQX5 = "ED-10 Use Methods Together or at Different Times - May [interview yr-3]"
   SIMSEQX6 = "ED-10 Use Methods Together or at Different Times - June [interview yr-3]"
   SIMSEQX7 = "ED-10 Use Methods Together or at Different Times - July [interview yr-3]"
   SIMSEQX8 = "ED-10 Use Methods Together or at Different Times - Aug [interview yr-3]"
   SIMSEQX9 = "ED-10 Use Methods Together or at Different Times - Sept [interview yr-3]"
   SIMSEQX10 = "ED-10 Use Methods Together or at Different Times - Oct [interview yr-3]"
   SIMSEQX11 = "ED-10 Use Methods Together or at Different Times - Nov [interview yr-3]"
   SIMSEQX12 = "ED-10 Use Methods Together or at Different Times - Dec [interview yr-3]"
   SIMSEQX13 = "ED-10 Use Methods Together or at Different Times - Jan [interview yr-2]"
   SIMSEQX14 = "ED-10 Use Methods Together or at Different Times - Feb [interview yr-2]"
   SIMSEQX15 = "ED-10 Use Methods Together or at Different Times - Mar [interview yr-2]"
   SIMSEQX16 = "ED-10 Use Methods Together or at Different Times - April [interview yr-2]"
   SIMSEQX17 = "ED-10 Use Methods Together or at Different Times - May [interview yr-2]"
   SIMSEQX18 = "ED-10 Use Methods Together or at Different Times - June [interview yr-2]"
   SIMSEQX19 = "ED-10 Use Methods Together or at Different Times - July [interview yr-2]"
   SIMSEQX20 = "ED-10 Use Methods Together or at Different Times - Aug [interview yr-2]"
   SIMSEQX21 = "ED-10 Use Methods Together or at Different Times - Sept [interview yr-2]"
   SIMSEQX22 = "ED-10 Use Methods Together or at Different Times - Oct [interview yr-2]"
   SIMSEQX23 = "ED-10 Use Methods Together or at Different Times - Nov [interview yr-2]"
   SIMSEQX24 = "ED-10 Use Methods Together or at Different Times - Dec [interview yr-2]"
   SIMSEQX25 = "ED-10 Use Methods Together or at Different Times - Jan [interview yr-1]"
   SIMSEQX26 = "ED-10 Use Methods Together or at Different Times - Feb [interview yr-1]"
   SIMSEQX27 = "ED-10 Use Methods Together or at Different Times - Mar [interview yr-1]"
   SIMSEQX28 = "ED-10 Use Methods Together or at Different Times - April [interview yr-1]"
   SIMSEQX29 = "ED-10 Use Methods Together or at Different Times - May [interview yr-1]"
   SIMSEQX30 = "ED-10 Use Methods Together or at Different Times - June [interview yr-1]"
   SIMSEQX31 = "ED-10 Use Methods Together or at Different Times - July [interview yr-1]"
   SIMSEQX32 = "ED-10 Use Methods Together or at Different Times - Aug [interview yr-1]"
   SIMSEQX33 = "ED-10 Use Methods Together or at Different Times - Sept [interview yr-1]"
   SIMSEQX34 = "ED-10 Use Methods Together or at Different Times - Oct [interview yr-1]"
   SIMSEQX35 = "ED-10 Use Methods Together or at Different Times - Nov [interview yr-1]"
   SIMSEQX36 = "ED-10 Use Methods Together or at Different Times - Dec [interview yr-1]"
   SIMSEQX37 = "ED-10 Use Methods Together or at Different Times - Jan [interview yr]"
   SIMSEQX38 = "ED-10 Use Methods Together or at Different Times - Feb [interview yr]"
   SIMSEQX39 = "ED-10 Use Methods Together or at Different Times - Mar [interview yr]"
   SIMSEQX40 = "ED-10 Use Methods Together or at Different Times - April [interview yr]"
   SIMSEQX41 = "ED-10 Use Methods Together or at Different Times - May [interview yr]"
   SIMSEQX42 = "ED-10 Use Methods Together or at Different Times - June [interview yr]"
   SIMSEQX43 = "ED-10 Use Methods Together or at Different Times - July [interview yr]"
   SIMSEQX44 = "ED-10 Use Methods Together or at Different Times - Aug [interview yr]"
   SIMSEQX45 = "ED-10 Use Methods Together or at Different Times - Sept [interview yr]"
   SIMSEQX46 = "ED-10 Use Methods Together or at Different Times - Oct [interview yr]"
   SIMSEQX47 = "ED-10 Use Methods Together or at Different Times - Nov [interview yr]"
   SIMSEQX48 = "ED-10 Use Methods Together or at Different Times - Dec [interview yr]"
   USELSTP = "EF-1 Use Method at Last Sex with last partner in past 12 months?"
   LSTMTHP1 = "EF-2 Method Used at Last Sex with last partner in past 12 mons -1st mention"
   LSTMTHP2 = "EF-2 Method Used at Last Sex with last partner in past 12 mons -2nd mention"
   LSTMTHP3 = "EF-2 Method Used at Last Sex with last partner in past 12 mons -3rd mention"
   LSTMTHP4 = "EF-2 Method Used at Last Sex with last partner in past 12 mons -4th mention"
   USEFSTP = "EF-3 Use Method at First Sex with last partner in past 12 months?"
   FSTMTHP1 = "EF-4 Method used at first sex with last partner in past 12 mons -1st mention"
   FSTMTHP2 = "EF-4 Method used at first sex with last partner in past 12 mons -2nd mention"
   FSTMTHP3 = "EF-4 Method used at first sex with last partner in past 12 mons -3rd mention"
   FSTMTHP4 = "EF-4 Method used at first sex with last partner in past 12 mons -4th mention"
   USELSTP2 = "EF-1 Use Method at Last Sex with 2nd-to-last partner in past 12 months?"
   LSTMTHP5 = "EF-2 Method Used at Last Sex with 2nd-to-last partner in past 12 mons -1st mention"
   LSTMTHP6 = "EF-2 Method Used at Last Sex with 2nd-to-last partner in past 12 mons -2nd mention"
   LSTMTHP7 = "EF-2 Method Used at Last Sex with 2nd-to-last partner in past 12 mons -3rd mention"
   LSTMTHP8 = "EF-2 Method Used at Last Sex with 2nd-to-last partner in past 12 mons -4th mention"
   USEFSTP2 = "EF-3 Use Method at First Sex with 2nd-to-last partner in past 12 months?"
   FSTMTHP5 = "EF-4 Method used at first sex with 2nd-to-last partner in past 12 mons -1st mention"
   FSTMTHP6 = "EF-4 Method used at first sex with 2nd-to-last partner in past 12 mons -2nd mention"
   FSTMTHP7 = "EF-4 Method used at first sex with 2nd-to-last partner in past 12 mons -3rd mention"
   FSTMTHP8 = "EF-4 Method used at first sex with 2nd-to-last partner in past 12 mons -4th mention"
   USELSTP3 = "EF-1 Use Method at Last Sex with 3rd-to-last partner in past 12 months?"
   LSTMTHP9 = "EF-2 Method Used at Last Sex with 3rd-to-last partner in past 12 mons - 1st mention"
   LSTMTHP10 = "EF-2 Method Used at Last Sex with 3rd-to-last partner in past 12 mons -2nd mention"
   LSTMTHP11 = "EF-2 Method Used at Last Sex with 3rd-to-last partner in past 12 mons -3rd mention"
   LSTMTHP12 = "EF-2 Method Used at Last Sex with 3rd-to-last partner in past 12 mons -4th mention"
   USEFSTP3 = "EF-3 use method at first sex with 3rd-to-last partner in past 12 months?"
   FSTMTHP9 = "EF-4 Method used at first sex with 3rd-to-last partner in past 12 mons -1st mention"
   FSTMTHP10 = "EF-4 Method used at first sex with 3rd-to-last partner in past 12 mons -2nd mention"
   FSTMTHP11 = "EF-4 Method used at first sex with 3rd-to-last partner in past 12 mons -3rd mention"
   FSTMTHP12 = "EF-4 Method used at first sex with 3rd-to-last partner in past 12 mons -4th mention"
   WYNOTUSE = "EH-1 Reason not using birth control because you want to become pregnant?"
   HPPREGQ = "EH-2 Does partner want you to become pregnant?"
   DURTRY_N = "EH-2a How long have you been trying to get pregnant?  (number)"
   DURTRY_P = "EH-2b How long have you been trying to get pregnant? (unit: Mons/Yrs)"
   WHYNOUSING1 = "EH-2c Reason not using birth control (at risk of unint preg) - 1st mention"
   WHYNOUSING2 = "EH-2c Reason not using birth control (at risk of unint preg) - 2nd mention"
   WHYNOUSING3 = "EH-2c Reason not using birth control (at risk of unint preg) - 3rd mention"
   WHYNOUSING4 = "EH-2c Reason not using birth control (at risk of unint preg) - 4th mention"
   WHYNOUSING5 = "EH-2c Reason not using birth control (at risk of unint preg) - 5th mention"
   WHYNOTPG1 = "EH-2cc open-ended response: reason don't think can get preg - 1st"
   WHYNOTPG2 = "EH-2cc open-ended response: reason don't think can get preg - 2nd"
   MAINNOUSE = "EH-2d Main reason not using birth control (at risk of unint preg)"
   YUSEPILL1 = "EJ-1 Reasons for recent pill use-1st mention"
   YUSEPILL2 = "EJ-1 Reasons for recent pill use-2nd mention"
   YUSEPILL3 = "EJ-1 Reasons for recent pill use-3rd mention"
   YUSEPILL4 = "EJ-1 Reasons for recent pill use-4th mention"
   YUSEPILL5 = "EJ-1 Reasons for recent pill use-5th mention"
   YUSEPILL6 = "EJ-1 Reasons for recent pill use-6th mention"
   YUSEPILL7 = "EJ-1 Reasons for recent pill use-7th mention"
   IUDTYPE = "EJ-3 Type of IUD used the last two months"
   PST4WKSX = "EL-1 # times sex with male in last 4 weeks"
   PSWKCOND1 = "EL-2 Use a condom during sex with male in last 4 wks"
   PSWKCOND2 = "EL-3 How many times use condom during sex last 4 wks"
   COND1BRK = "EL-3a Did condom break"
   COND1OFF = "EL-3b When was the condom used"
   CONDBRFL = "EL-3c How many times use condom break or completely fall off"
   CONDOFF = "EL-3d How many times was the condom put on after or taken off during sex"
   MISSPILL = "EL-3e number of pills missed"
   P12MOCON = "EL-4 How many times used condom during sex last 12 mons"
   PXNOFREQ = "EL-5 How many times used any method during sex last 12 mons"
   BTHCON12 = "FA-1b Rec'd Method Birth Control/Prescription-Last 12 Months"
   MEDTST12 = "FA-1c Rec'd Checkup for Birth Control Last 12 Months"
   BCCNS12 = "FA-1d Rec'd Counseling About Birth Control Last 12 Months"
   STEROP12 = "FA-1e Rec'd sterilizing operation in last 12 months?"
   STCNS12 = "FA-1f Rec'd Counseling re Getting Sterilized Last 12 Months"
   EMCON12 = "FA-1g Rec'd Emergency Contraception/Prescription Last 12 Months"
   ECCNS12 = "FA-1h Rec'd Counseling re Emergency Contraception Last 12 Months"
   NUMMTH12 = "# of BC Methods used (drug/device) Last 12 Months"
   PRGTST12 = "FA-3a Received Pregnancy Test Last 12 Months"
   ABORT12 = "FA-3b Received Abortion Last 12 Months"
   PAP12 = "FA-3c Received Pap Smear Last 12 Months"
   PELVIC12 = "FA-3d Received Pelvic Exam Last 12 Months"
   PRENAT12 = "FA-3e Received Prenatal Care Last 12 Months"
   PARTUM12 = "FA-3f Received Post-Pregnancy Care Last 12 Months"
   STDSVC12 = "FA-3g  Rec'd test for STD Last 12 Months"
   BARRIER1 = "FA-3h Reason Did Not See a Doctor in Last 12 months - 1st mention"
   BARRIER2 = "FA-3h Reason Did Not See a Doctor in Last 12 months - 2nd mention"
   BARRIER3 = "FA-3h Reason Did Not See a Doctor in Last 12 months - 3rd mention"
   BARRIER4 = "FA-3h Reason Did Not See a Doctor in Last 12 months - 4th mention"
   NUMSVC12 = "# of Services Received in Last 12 Months"
   NUMBCVIS = "FA-4 Received Services Last 12 Months at 1 or More Visits"
   BC12PLCX = "FA-5 Where R Rec'd all services in one visit"
   BC12PLCX2 = "FA-5 Where R Rec'd Method of Birth Control/Prescription in Last 12 Months"
   BC12PLCX3 = "FA-5 Where R Rec'd Check-up for Birth Control in Last 12 Months"
   BC12PLCX4 = "FA-5 Where R Rec'd Counseling about Birth Control in Last 12 Months"
   BC12PLCX5 = "FA-5 Where R Rec'd sterilizing operation in Last 12 Months"
   BC12PLCX6 = "FA-5 Where R Rec'd Counseling on Getting Sterilized in Last 12 Months"
   BC12PLCX7 = "FA-5 Where R Rec'd Emergency Contraception in Last 12 Months"
   BC12PLCX8 = "FA-5 Where R Rec'd Counseling on Emerg. Contraception in Last 12 Months"
   BC12PLCX9 = "FA-5 Where R Rec'd Pregnancy Test in Last 12 Months"
   BC12PLCX10 = "FA-5 Where R Rec'd Abortion in Last 12 Months"
   BC12PLCX11 = "FA-5 Where R Rec'd Pap Smear in Last 12 Months"
   BC12PLCX12 = "FA-5 Where R Rec'd Pelvic Exam in Last 12 Months"
   BC12PLCX13 = "FA-5 Where R Rec'd Prenatal Care in Last 12 Months"
   BC12PLCX14 = "FA-5 Where R Rec'd Post-pregnancy care in Last 12 Months"
   BC12PLCX15 = "FA-5 Where R Rec'd testing for STD in Last 12 Months"
   IDCLINIC = "Number of times identified a clinic"
   PGTSTBC2 = "FA-5a During Visit For Preg Test, Dr. Talk About BC"
   PAPPLBC2 = "FA-5b During Visit For Pap/Pelvic, Dr. Talk About BC"
   PAPPELEC = "FA-5c During Visit Pap/Pelvic,Dr Talk-Emergency Contraception"
   STDTSCON = "FA-5d During Visit STD,Dr Talk-Using Condom to Prevent Disease"
   WHYPSTD = "FA-5e Main reason chose place for STD test"
   BC12PAYX1 = "Fa-6 Way Bill Was Paid-all services in one visit, 1st method"
   BC12PAYX2 = "Fa-6 Way Bill Was Paid-all services in one visit, 2nd method"
   BC12PAYX3 = "Fa-6 Way Bill Was Paid-all services in one visit, 3rd method"
   BC12PAYX4 = "Fa-6 Way Bill Was Paid-all services in one visit, 4th method"
   BC12PAYX7 = "Fa-6 Way Bill Was Paid-method BC/prescription, 1st method"
   BC12PAYX8 = "Fa-6 Way Bill Was Paid-method BC/prescription, 2nd method"
   BC12PAYX9 = "Fa-6 Way Bill Was Paid-method BC/prescription, 3rd method"
   BC12PAYX10 = "Fa-6 Way Bill Was Paid-method BC/prescription, 4th method"
   BC12PAYX13 = "Fa-6 Way Bill Was Paid-check up for BC, 1st method"
   BC12PAYX14 = "Fa-6 Way Bill Was Paid-check up for BC, 2nd method"
   BC12PAYX15 = "Fa-6 Way Bill Was Paid-check up for BC, 3rd method"
   BC12PAYX16 = "Fa-6 Way Bill Was Paid-check up for BC, 4th method"
   BC12PAYX19 = "Fa-6 Way Bill Was Paid-counseling about BC, 1st method"
   BC12PAYX20 = "Fa-6 Way Bill Was Paid-counseling about BC, 2nd  method"
   BC12PAYX21 = "Fa-6 Way Bill Was Paid-counseling about BC, 3rd method"
   BC12PAYX22 = "Fa-6 Way Bill Was Paid-counseling about BC, 4th method"
   BC12PAYX25 = "Fa-6 Ways Bill Was paid-sterilizing operation, 1st method"
   BC12PAYX26 = "Fa-6 Ways Bill Was paid-sterilizing operation, 2nd method"
   BC12PAYX27 = "Fa-6 Ways Bill Was paid-sterilizing operation, 3rd method"
   BC12PAYX28 = "Fa-6 Ways Bill Was paid-sterilizing operation, 4th method"
   BC12PAYX31 = "Fa-6 Way Bill Was Paid-counseling sterilization,  1st method"
   BC12PAYX32 = "Fa-6 Way Bill Was Paid-counseling sterilization,  2nd method"
   BC12PAYX33 = "Fa-6 Way Bill Was Paid-counseling sterilization,  3rd method"
   BC12PAYX34 = "Fa-6 Way Bill Was Paid-counseling sterilization,  4th method"
   BC12PAYX37 = "Fa-6 Way Bill Was Paid-EC/prescription, 1st method"
   BC12PAYX38 = "Fa-6 Way Bill Was Paid-EC/prescription, 2nd method"
   BC12PAYX39 = "Fa-6 Way Bill Was Paid-EC/prescription, 3rd method"
   BC12PAYX40 = "Fa-6 Way Bill Was Paid-EC/prescription, 4th method"
   BC12PAYX43 = "Fa-6 Way Bill Was Paid-counseling EC, 1st method"
   BC12PAYX44 = "Fa-6 Way Bill Was Paid-counseling EC, 2nd method"
   BC12PAYX45 = "Fa-6 Way Bill Was Paid-counseling EC, 3rd method"
   BC12PAYX46 = "Fa-6 Way Bill Was Paid-counseling EC, 4th method"
   BC12PAYX49 = "Fa-6 Way Bill Was Paid-pregnancy test, 1st method"
   BC12PAYX50 = "Fa-6 Way Bill Was Paid-pregnancy test, 2nd method"
   BC12PAYX51 = "Fa-6 Way Bill Was Paid-pregnancy test, 3rd method"
   BC12PAYX52 = "Fa-6 Way Bill Was Paid-pregnancy test, 4th method"
   BC12PAYX55 = "Fa-6 Way Bill Was Paid-abortion, 1st method"
   BC12PAYX56 = "Fa-6 Way Bill Was Paid-abortion, 2nd method"
   BC12PAYX57 = "Fa-6 Way Bill Was Paid-abortion, 3rd method"
   BC12PAYX58 = "Fa-6 Way Bill Was Paid-abortion, 4th method"
   BC12PAYX61 = "Fa-6 Way Bill Was Paid-pap smear, 1st method"
   BC12PAYX62 = "Fa-6 Way Bill Was Paid-pap smear, 2nd method"
   BC12PAYX63 = "Fa-6 Way Bill Was Paid-pap smear, 3rd method"
   BC12PAYX64 = "Fa-6 Way Bill Was Paid-pap smear, 4th method"
   BC12PAYX67 = "Fa-6 Way Bill Was Paid-pelvic exam, 1st method"
   BC12PAYX68 = "Fa-6 Way Bill Was Paid-pelvic exam, 2nd method"
   BC12PAYX69 = "Fa-6 Way Bill Was Paid-pelvic exam, 3rd method"
   BC12PAYX70 = "Fa-6 Way Bill Was Paid-pelvic exam, 4th method"
   BC12PAYX73 = "Fa-6 Way Bill Was Paid-prenatal, 1st method"
   BC12PAYX74 = "Fa-6 Way Bill Was Paid-prenatal, 2nd method"
   BC12PAYX75 = "Fa-6 Way Bill Was Paid-prenatal, 3rd method"
   BC12PAYX76 = "Fa-6 Way Bill Was Paid-prenatal, 4th method"
   BC12PAYX79 = "Fa-6 Way Bill Was Paid-post-pregnancy, 1st method"
   BC12PAYX80 = "Fa-6 Way Bill Was Paid-post-pregnancy, 2nd method"
   BC12PAYX81 = "Fa-6 Way Bill Was Paid-post-pregnancy, 3rd method"
   BC12PAYX82 = "Fa-6 Way Bill Was Paid-post-pregnancy, 4th method"
   BC12PAYX85 = "Fa-6 Way Bill Was Paid-testing for std, 1st method"
   BC12PAYX86 = "Fa-6 Way Bill Was Paid-testing for std, 2nd method"
   BC12PAYX87 = "Fa-6 Way Bill Was Paid-testing for std, 3rd method"
   BC12PAYX88 = "Fa-6 Way Bill Was Paid-testing for std, 4th method"
   REGCAR12_F_01 = "FA-9 Clinic Rec'd all services in one visit"
   REGCAR12_F_02 = "FA-9 Clinic Rec'd Method BC or Prescription was R's Reg Place"
   REGCAR12_F_03 = "FA-9 Clinic Rec'd Check-up for Birth Control was R's Reg Place"
   REGCAR12_F_04 = "FA-9 Clinic Rec'd Counseling for BC was R's Reg Place"
   REGCAR12_F_05 = "FA-9 Clinic Rec'd sterilizing operation was R's Regular Place"
   REGCAR12_F_06 = "FA-9 Clinic Rec'd Counseling for Sterilization was R's Reg Place"
   REGCAR12_F_07 = "FA-9 Clinic Rec'd EC /Prescription was R's Reg Place"
   REGCAR12_F_08 = "FA-9 Clinic Rec'd Counseling on EC was R's Regr Place"
   REGCAR12_F_09 = "FA-9 Clinic Rec'd pregnancy test was R's Regr Place"
   REGCAR12_F_10 = "FA-9 Clinic Rec'd an Abortion was R's Regular Place"
   REGCAR12_F_11 = "FA-9 Clinic Rec'd a Pap Smear was R's Regular Place"
   REGCAR12_F_12 = "FA-9 Clinic Rec'd Pelvic exam was R's Regular Place"
   REGCAR12_F_13 = "FA-9 Clinic Rec'd Prenatal Care was R's Regular Place"
   REGCAR12_F_14 = "FA-9 Clinic Rec'd Post-Pregnancy Care  was R's Regular Place"
   REGCAR12_F_15 = "FA-9 Clinic Rec'd testing for STD was R's Reg Place"
   DRUGDEVE = "# of Birth Control Methods (drug/device) Ever Used"
   FSTSVC12 = "FB-1 Services in Last 12 Months the First R Ever Received"
   WNFSTSVC_M = "FB-2 Month R First Received Birth Control Services"
   WNFSTSVC_Y = "FB-3 Year R First Received Birth Control Services"
   CMFSTSVC = "CM Received 1st Birth Control Service"
   B4AFSTIN = "FB-4 If DK, Was 1st Service Before/After 1st Intercourse"
   TMAFTIN = "FB-5 How long after 1st sex did R receive 1st BC service"
   FSTSERV1 = "FB-6 Service(s) R Received The First Time-1st mention"
   FSTSERV2 = "FB-6 Service(s) R Received The First Time-2nd mention"
   FSTSERV3 = "FB-6 Service(s) R Received The First Time-3rd mention"
   FSTSERV4 = "FB-6 Service(s) R Received The First Time-4th mention"
   FSTSERV5 = "FB-6 Service(s) R Received The First Time-5th mention"
   FSTSERV6 = "FB-6 Service(s) R Received The First Time-6th mention"
   BCPLCFST = "FB-7 Where R Received 1st Birth Control Service"
   EVERFPC = "FC-1 Has R ever Visited Clinic for Medical/BC Service"
   KNDMDHLP01 = "FC-2 Medical Services R Received at Clinic -1st mention"
   KNDMDHLP02 = "FC-2 Medical Services R Received at Clinic -2nd mention"
   KNDMDHLP03 = "FC-2 Medical Services R Received at Clinic -3rd mention"
   KNDMDHLP04 = "FC-2 Medical Services R Received at Clinic -4th mention"
   KNDMDHLP05 = "FC-2 Medical Services R Received at Clinic -5th mention"
   KNDMDHLP06 = "FC-2 Medical Services R Received at Clinic -6th mention"
   KNDMDHLP07 = "FC-2 Medical Services R Received at Clinic -7th mention"
   KNDMDHLP08 = "FC-2 Medical Services R Received at Clinic -8th mention"
   LASTPAP = "FD-2 When was last Pap test"
   MREASPAP = "FD-3 Main reason for last Pap test"
   AGEFPAP = "FD-4 Age at first Pap test"
   AGEFPAP2 = "FD-4a Was R younger than 18, 18-21, 22-29, or 30 or older at first Pap test"
   ABNPAP3 = "FD-5 Has R had abnormal Pap test in the last 3 years"
   INTPAP = "FD-6 How often R thinks she will need a Pap test"
   PELWPAP = "FE-1 Was pelvic exam done at same time as Pap test"
   LASTPEL = "FE-2 When was last pelvic exam"
   MREASPEL = "FE-3 Main reason for last pelvic exam"
   AGEFPEL = "FE-4 Age at first pelvic exam"
   AGEPEL2 = "FE-4a Was R younger than 18, 18-21, 22-29, or 30 or older at first pelvic exam"
   INTPEL = "FE-5 How often R thinks she will need a pelvic exam"
   EVHPVTST = "FF-2 Ever had HPV test"
   HPVWPAP = "FF-3 Was HPV test done at same time as Pap test"
   LASTHPV = "FF-3c When was last HPV test"
   MREASHPV = "FF-4 Main reason for last HPV test"
   AGEFHPV = "FF-5 Age at first HPV test"
   AGEHPV2 = "FF-5a Was R younger than 18, 18-21, 22-29, or 30 or older at first HPV test"
   INTHPV = "FF-6 How often R thinks she will need an HPV test"
   RWANT = "GA-1 R Wants A(another) Baby Some Time?"
   PROBWANT = "GA-1a R Prob Wants/does not want A(another) Baby Some Time?"
   PWANT = "GA-2 R's H/P Wants A(another) Baby Some Time?"
   JINTEND = "GB-1 R & H/P Intend to have A(another) Baby Some Time?"
   JSUREINT = "GB-2 How sure R & H/P will/will not have A(another) Baby?"
   JINTENDN = "GB-3 How Many (More) Babies R and H/P Intend?"
   JEXPECTL = "GB-4 Largest Number of (additional) Babies R and H/P Intend"
   JEXPECTS = "GB-5 Smallest Number of (additional) Babies R and H/P Intend"
   JINTNEXT = "GB-6 When R & H/P expect 1st/next child to be born"
   INTEND = "GC-1 R Intends to Have A(another) Baby Some Time?"
   SUREINT = "GC-2 R How Sure R will/ will not have A(another) baby?"
   INTENDN = "GC-3 Number of (more) Babies R Intends"
   EXPECTL = "GC-4 Largest Number of (additional) Babies R Intends"
   EXPECTS = "GC-5 Smallest Number of (additional) Babies R Intends"
   INTNEXT = "GC-6 When R expects 1st/next child to be born"
   HLPPRG = "HA-1 Ever Received Medical Help to Get Pregnant"
   HOWMANYR = "HA-2 # of Partners with Whom R Sought Medical Help to Get Pregnant"
   SEEKWHO1 = "HA-3 Sought Medical Help to Get Pregnant with Current H/P"
   SEEKWHO2 = "HA-4 Ever Sought Medical Help to Get Pregnant with Current H/P"
   TYPALLPG1 = "HA-5 Infertility Services Received-1st mention"
   TYPALLPG2 = "HA-5 Infertility Services Received-2nd mention"
   TYPALLPG3 = "HA-5 Infertility Services Received-3rd mention"
   TYPALLPG4 = "HA-5 Infertility Services Received-4th mention"
   TYPALLPG5 = "HA-5 Infertility Services Received-5th mention"
   TYPALLPG6 = "HA-5 Infertility Services Received-6th mention"
   WHOTEST = "HA-5a Who had Infertility Testing - R or Partner or Both"
   WHARTIN = "HA-5b R Inseminated with Partner or Donor Sperm"
   OTMEDHEP1 = "HA-5c Other Infertility Services Received-1st mention"
   OTMEDHEP2 = "HA-5c Other Infertility Services Received-2nd mention"
   OTMEDHEP3 = "HA-5c Other Infertility Services Received-3rd mention"
   OTMEDHEP4 = "HA-5c Other Infertility Services Received-4th mention"
   INSCOVPG = "HA-6 Infertility Services Covered by Private Insurance"
   FSTHLPPG_M = "HA-7 Month 1st Went for Medical Help To Get Pregnant"
   FSTHLPPG_Y = "HA-7 Year 1st Went for Medical Help To Get Pregnant"
   CMPGVIS1 = "Date (CM) of First Visit for Medical Help to Get Pregnant"
   TRYLONG2 = "HA-8 How Long R Trying To Get Pregnant"
   UNIT_TRYLONG = "HA-8 Unit (months/years) for How Long Trying to Get Pregnant"
   HLPPGNOW = "HA-9 R Currently Pursuing Medical Help to Get Pregnant"
   RCNTPGH_M = "HA-10 Month of Last/Most Recent Visit for Help to Get Pregnant"
   RCNTPGH_Y = "HA-10 Year of Last/Most Recent Visit for Help to Get Pregnant"
   CMPGVISL = "Date (CM) of Last/Most Recent Visit for Medical Help to Get Pregnant"
   NUMVSTPG = "HA-11 # Visits in Last 12 Mos for Medical Help to Get Pregnant"
   PRGVISIT = "# of Visits in Last 12 Months for Medical Help to Get Pregnant"
   HLPMC = "HB-1 Ever Received Medical Help To Prevent Miscarriage"
   TYPALLMC1 = "HB-2 Miscarriage Services-1st Mentioned"
   TYPALLMC2 = "HB-2 Miscarriage Services-2nd Mentioned"
   TYPALLMC3 = "HB-2 Miscarriage Services-3rd Mentioned"
   TYPALLMC4 = "HB-2 Miscarriage Services-4th Mentioned"
   TYPALLMC5 = "HB-2 Miscarriage Services-5th Mentioned"
   TYPALLMC6 = "HB-2 Miscarriage Services-6th Mentioned"
   MISCNUM = "HB-3 # of Miscarriages at First Visit for Miscarriage Services"
   INFRTPRB1 = "HB-4 Ever Told You Had Any Infertility Problems-1st Mentioned"
   INFRTPRB2 = "HB-4 Ever Told You Had Any Infertility Problems-2nd Mentioned"
   INFRTPRB3 = "HB-4 Ever Told You Had Any Infertility Problems-3rd Mentioned"
   INFRTPRB4 = "HB-4 Ever Told You Had Any Infertility Problems-4th Mentioned"
   INFRTPRB5 = "HB-4 Ever Told You Had Any Infertility Problems-5th Mentioned"
   DUCHFREQ = "HC-1 Last 12 Mos: How Often R Douched"
   PID = "HD-1 Has R Ever Been Treated For PID"
   PIDSYMPT = "HD-2 Was R Having Any Symptoms that Prompted PID Treatment"
   PIDTX = "HD-3 Number of Times R was Treated For PID"
   LSTPIDTX_M = "HD-4 Month R Was Last Treated For PID"
   LSTPIDTX_Y = "HD-4 Year R Was Last Treated For PID"
   CMPIDLST = "Date (CM) of Last/Most Recent PID Treatment"
   DIABETES = "HD-5 Diabetes: Ever Diagnosed"
   GESTDIAB = "HD-6 Nongestational Diabetes: Ever Diagnosed"
   UF = "HD-8 Uterine Fibroids: Ever Diagnosed"
   ENDO = "HD-9 Endometriosis: Ever Diagnosed"
   OVUPROB = "HD-10 Ovulation/Menstrual Problems: Ever Diagnosed"
   DEAF = "HD-11 R has any serious difficulty hearing"
   BLIND = "HD-12 R has any serious difficulty seeing"
   DIFDECIDE = "HD-13 R has any serious difficulty w/memory or decision-making"
   DIFWALK = "HD-14 R has any serious difficulty walking or climbing stairs"
   DIFDRESS = "HD-15 R has any serious difficulty dressing or bathing"
   DIFOUT = "HD-16 R has any difficulty doing errands alone due to phys/mental/emotional conditions"
   EVRCANCER = "HD-17 R has ever had cancer"
   AGECANCER = "HD-17a Age when R was first told she had cancer"
   CANCTYPE = "HD-17b Type of cancer R (first) had"
   PRECANCER = "HD-17c Type of cervical cancer diagnosis R had"
   MAMMOG = "HD-18 R has ever had a mammogram"
   AGEMAMM1 = "HD-18a Age when R first had a mammogram"
   REASMAMM1 = "HD-18b Main reason for R's first mammogram"
   FAMHYST = "HD-19 R has family history of breast cancer"
   FAMRISK = "HD-20 R's assessment of breast cancer risk due to family history"
   PILLRISK = "HD-21 R's assessment of breast cancer risk due to OC pill use"
   ALCORISK = "HD-22 R's assessment of breast cancer risk due to alcohol consumption"
   CANCFUTR = "HD-23 R's perceived likelihood of getting breast cancer in future"
   CANCWORRY = "HD-24 R is often bothered by worry about breast cancer risk"
   DONBLOOD = "HE-1 Has R Ever Donated Blood or Blood Products"
   HIVTEST = "HE-2 Any HIV Test Outside of Blood Donation"
   NOHIVTST = "HE-2b R's main reason for never having had an HIV test"
   WHENHIV_M = "HE-3 Month of Most Recent HIV Test"
   WHENHIV_Y = "HE-3 Year of Most Recent HIV Test"
   CMHIVTST = "Date (CM) of Last (or Most Recent) HIV Test"
   HIVTSTYR = "HE-3b Has R had HIV test in last 12 months"
   HIVRESULT = "HE-3d Whether R found out results of last HIV test"
   WHYNOGET = "HE-3e Main reason why R did not get results of last HIV test"
   PLCHIV = "HE-4 Place Where R Had Last HIV Test"
   RHHIVT1 = "HE-4j Used a rapid home HIV test"
   RHHIVT21 = "HE-4k Reasons for rapid home HIV test - 1st mentioned"
   RHHIVT22 = "HE-4k Reasons for rapid home HIV test - 2nd mentioned"
   HIVTST = "HE-5 Reason For This Last HIV Test-1st mention"
   WHOSUGG = "HE-5b Who suggested R be tested for HIV"
   TALKDOCT = "HE-6 Has a doctor ever talked with R about HIV/AIDS"
   AIDSTALK01 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-1st mention"
   AIDSTALK02 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-2nd mention"
   AIDSTALK03 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-3rd mention"
   AIDSTALK04 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-4th mention"
   AIDSTALK05 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-5th mention"
   AIDSTALK06 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-6th mention"
   AIDSTALK07 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-7th mention"
   AIDSTALK08 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-8th mention"
   AIDSTALK09 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-9th mention"
   AIDSTALK10 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-10th mention"
   AIDSTALK11 = "HE-7 HIV Topics Covered in Discussion with Doctor/Provider-11th mention"
   RETROVIR = "HE-8 T/F: Treatment to Prevent Perinatal HIV Transmission"
   PREGHIV = "HE-9 R Tested for HIV During Last Completed Pregnancy"
   EVERVACC = "HF-1 Ever received HPV vaccine?"
   HPVSHOT1 = "HF-2 Age when R received first HPV vaccine shot"
   HPVSEX1 = "HF-2b Which came first - 1st intercourse or 1st HPV vaccine shot"
   VACCPROB = "HF-3 How Likely R Will Receive HPV Vaccine in Next 12 Mos"
   USUALCAR = "IA-0a Is there place R usually goes when sick"
   USLPLACE = "IA-0b Place R usually goes when sick"
   USL12MOS = "IA-0c R has gone to her usual source of health care in last 12 months"
   COVER12 = "IA-1 Whether R lacked health care coverage any time in last 12 months"
   NUMNOCOV = "IA-2 How many of the last 12 months was R without coverage"
   COVERHOW01 = "IA-3 Type of health care coverage last 12 months - 1st mention"
   COVERHOW02 = "IA-3 Type of health care coverage last 12 months - 2nd mention"
   COVERHOW03 = "IA-3 Type of health care coverage last 12 months - 3rd mention"
   COVERHOW04 = "IA-3 Type of health care coverage last 12 months - 4th mention"
   NOWCOVER01 = "IA-4 Type of health care R covered by now - 1st mention"
   NOWCOVER02 = "IA-4 Type of health care R covered by now - 2nd mention"
   NOWCOVER03 = "IA-4 Type of health care R covered by now - 3rd mention"
   PARINSUR = "IA-5 Covered by parents' plan"
   SAMEADD = "IB-1 R living at curr address on April 1, 2010"
   CNTRY10 = "IB-2 R living in US on April 1, 2010"
   BRNOUT = "IB-8 Whether R was born outside of US"
   YRSTRUS = "Year R came to the United States to stay"
   RELRAISD = "IC-1/IC-2 Religion in which R was raised"
   ATTND14 = "IC-4 How often R attended religious services at age 14"
   RELCURR = "IC-5/IC-6 Religion R is now"
   RELTRAD = "Current religious affiliation by Protestant categories"
   FUNDAM1 = "IC-8 Fundamental affiliation, if any - 1st mention"
   FUNDAM2 = "IC-8 Fundamental affiliation, if any - 2nd mention"
   FUNDAM3 = "IC-8 Fundamental affiliation, if any - 3rd mention"
   FUNDAM4 = "IC-8 Fundamental affiliation, if any - 4th mention"
   RELDLIFE = "IC-9 How important is religion in R's daily life"
   ATTNDNOW = "IC-10 How often R currently attends religious services"
   WRK12MOS = "ID-4 How many of the last 12 months did R work"
   FPT12MOS = "ID-5 Did R work full-time, part-time or both in last 12 months"
   DOLASTWK1 = "IE-1 What R was doing last week (employment status) - 1st mention"
   DOLASTWK2 = "IE-1 What R was doing last week (employment status) - 2nd mention"
   DOLASTWK3 = "IE-1 What was R doing last week (employment status) - 3rd mention"
   DOLASTWK4 = "IE-1 What R was doing last week (employment status) - 4th mention"
   DOLASTWK5 = "IE-1 What R was doing last week (employment status) - 5th mention"
   RWRKST = "Whether R is currently employed (working or temporarily on leave from a job)"
   WORKP12 = "Whether R worked in the previous 12 months"
   RPAYJOB = "IE-2 Did R ever work at job for pay on regular basis"
   RNUMJOB = "IE-3 Number of jobs R worked last week or last week R worked"
   RFTPTX = "IE-4 R worked full- or part-time at curr/last/primary job"
   REARNTY = "Whether R ever worked at all"
   SPLSTWK1 = "IF-1 H/P doing what last week (employment status) - 1st mention"
   SPLSTWK2 = "IF-1 H/P doing what last week (employment status) - 2nd mention"
   SPLSTWK3 = "IF-1 H/P doing what last week (employment status) - 3rd mention"
   SPLSTWK4 = "IF-1 H/P doing what last week (employment status) - 4th mention"
   SPLSTWK5 = "IF-1 H/P doing what last week (employment status) - 5th mention"
   SPWRKST = "Whether R's husband/partner is currently employed (working or temporarily on leave from a job)"
   SPPAYJOB = "IF-2 Did H/P ever work at a job for pay on regular basis"
   SPNUMJOB = "IF-3 Number of jobs H/P worked last week or last week worked"
   SPFTPTX = "IF-4 H/P worked full- or part-time at curr/last/primary job"
   SPEARNTY = "Whether R's husband/partner ever worked for pay"
   STAYTOG = "IH-2 Divorce best solution when cannot work out marriage problems"
   SAMESEX = "IH-3 Sexual relations between two same-sex adults is all right"
   SXOK18 = "IH-5 All right for unmarried 18 year olds have sex if strong affection"
   SXOK16 = "IH-6 All right for unmarried 16 year olds have sex if strong affection"
   CHUNLESS = "IH-6a People can't be really happy unless they have children"
   CHSUPPOR = "IH-8 Okay for unmarried woman to have and raise a child"
   GAYADOPT = "IH-9 Gay adults should have the right to adopt children"
   OKCOHAB = "IH-10 A young couple should not live together unless married"
   REACTSLF = "IH-14 How R would feel if she got pregnant now"
   CHBOTHER = "IH-15 How bothered would R be if she did not have children"
   MARRFAIL = "IH-16 Marriage has not worked out for most people R knows"
   CHCOHAB = "IH-17 OK for cohab couple to have and raise children"
   PRVNTDIV = "IH-18 Living together before marriage may prevent divorce"
   LESSPLSR = "II-2 Chance R would feel less physical pleasure if partner used condom"
   EMBARRAS = "II-4 Chance condom discussion would embarrass R and partner"
   ACASILANG = "II-6 Language to be used in ACASI"
   GENHEALT = "JA-4 R's General Health"
   INCHES = "Height (converted to inches) (original version)"
   RWEIGHT = "JA-6 R's Weight (pounds)"
   BMI = "Body Mass Index (computed in post-processing)"
   ENGSPEAK = "JA-7 How well does R speak English"
   CASIBIRTH = "JB-1 # of pregnancies ending in live birth in 5 yrs bef intvw"
   CASILOSS = "JB-2 # of pregnancies ending in spont loss in 5 yrs bef intvw"
   CASIABOR = "JB-3 # of pregnancies ending in abortion in 5 yrs bef intvw"
   CASIADOP = "JB-4 R ever placed a child she gave birth to for adoption"
   EVSUSPEN = "JC0-a Ever been suspended or expelled from school?"
   GRADSUSP = "JC0-b Grade when  suspended or expelled from school"
   SMK100 = "JC-1 Has R Smoked at Least 100 Cigarettes in Life"
   AGESMK = "JC-2 Age That R First Began Smoking Regularly"
   SMOKE12 = "JC-3 Last 12 months: How Often R Smoked Cigarettes"
   DRINK12 = "JC-4 Last 12 months: How Often Drank Alcoholic Beverages"
   UNIT30D = "JC-4a-U Drinking in past 30 days - unit of response"
   DRINK30D = "JC-4a-N Drinking in past 30 days - amount"
   DRINKDAY = "JC-4b Number of drinks R had on average on days R drank"
   BINGE30 = "JC-4c Number of times R binge-drank in past 30 days"
   DRNKMOST = "JC-4d Largest number of drinks R had on any occasion in past 30 days"
   BINGE12 = "JC-5 Last 12 months: How Often Binge Drank (4+ in Couple of Hours)"
   POT12 = "JC-6 Last 12 months: How Often Smoked Marijuana"
   COC12 = "JC-7 Last 12 months: How Often Used Cocaine"
   CRACK12 = "JC-8 Last 12 months: How Often Used Crack"
   CRYSTMTH12 = "JC-8a Last 12 months: How Often Used Crystal/Meth"
   INJECT12 = "JC-9 Last 12 months: How Often Injected Non-Prescription Drugs"
   VAGSEX = "JD-1 Ever Had Vaginal Intercourse with a Male"
   AGEVAGR = "JD-2 R's Age at First Vaginal Intercourse with a Male"
   AGEVAGM = "JD-3 R's Partner's Age at First Vaginal Intercourse w/a Male"
   CONDVAG = "JD-4 R Used Condom at Last Vaginal Intercourse with a Male"
   WHYCONDL = "JD-5 Reason R Used Condom at Last Vaginal Intercourse w/a Male"
   GETORALM = "JD-6 R has ever received oral sex from a male"
   GIVORALM = "JD-7 R has ever performed oral sex on a male"
   CONDFELL = "JD-8 R Used Condom at Last Oral Sex with a Male"
   ANYORAL = "Whether R has ever had oral sex with a male (computed in FC J-8b)"
   TIMING = "JD-8b First oral sex before, after, or during first vag  sex?"
   ANALSEX = "JD-9 R Ever Had Anal Sex with a Male"
   CONDANAL = "JD-10 R Used Condom at Last Anal Sex with a Male"
   OPPSEXANY = "Ever Had Vaginal, Oral, or Anal Sex with a Male (computed in FC J-9)"
   OPPSEXGEN = "Ever Had Male-Genital-Involving Sex with a Male (computed in FC J-9)"
   CONDSEXL = "JD-11 R Used Condom at Last Sex (any type) with a Male"
   WANTSEX1 = "JE-1 How much R wanted her first vaginal intercourse to happen"
   VOLSEX1 = "JE-2 R's First Vaginal Intercourse Voluntary or Not Voluntary"
   HOWOLD = "JE-3 R's Age at This First Vaginal Intercourse"
   GIVNDRUG = "JE-4a How forced: R was given alcohol/drugs"
   HEBIGOLD = "JE-4b How forced: he was bigger than R, or grown up, R young"
   ENDRELAT = "JE-4c How forced: he said relationship would end if no sex"
   WORDPRES = "JE-4d How forced: R was pressured by his words but no threats of harm"
   THRTPHYS = "JE-4e How forced: R was threatened with physical hurt/injury"
   PHYSHURT = "JE-4f How forced: R was physically hurt/injured"
   HELDDOWN = "JE-4g How forced: R was physically held down"
   EVRFORCD = "JE-5 R Ever Been Forced by a Man to Have Vaginal Sex"
   AGEFORC1 = "JE-6 R's Age at First Forced Vaginal Sex by a Man"
   GIVNDRG2 = "JE-7a How forced: R was given alcohol/drugs"
   HEBIGOL2 = "JE-7b How forced: he was bigger than R or grown up, R young"
   ENDRELA2 = "JE-7c How forced: he said relationship would end if no sex"
   WRDPRES2 = "JE-7d How forced: pressured by his words but not threats of harm"
   THRTPHY2 = "JE-7e How forced: R was threatened with physical hurt/injury"
   PHYSHRT2 = "JE-7f How forced: R was physically hurt/injured"
   HELDDWN2 = "JE-7g How forced: R was physically held down"
   PARTSLIF_1 = "JF-1 # of Male Sex Partners in Entire Life (any type of sex)"
   PARTSLFV = "JF_1v Verify # of Sex Partners in Entire Life (any type of sex)"
   PARTSLIF_2 = "JF-1 # of Male Sex Partners in Entire Life (any type of sex)"
   OPPLIFENUM = "Number of opposite-sex partners in lifetime for all types of sex (computed in FC J-14d)"
   PARTS12M_1 = "JF-2 # of Male Sex Partners in Last 12 months (any type of sex)"
   PARTS12V = "JF_2v Verify # of Sex Partners in Last 12 months (any type of sex)"
   PARTS12M_2 = "JF-2 # of Male Sex Partners in Last 12 months (any type of sex)"
   OPPYEARNUM = "Number of opposite-sex partners in last 12 months for all types of sex. (computed in FC J-14f)"
   NEWYEAR = "JF-2YR re-ask # male partners in last 12 months"
   NEWLIFE = "JF-2LF re-ask # male partners in lifetime"
   VAGNUM12 = "JF-2YRa # male partners past 12 months had vaginal intercourse with"
   ORALNUM12 = "JF-2YRb # male partners past 12 months had oral sex with"
   ANALNUM12 = "JF-2YRc # male partners past 12 months had anal sex with"
   CURRPAGE = "JF-2a Age of R's 1st Current Partner at Last Sex"
   RELAGE = "JF-2b Is 1st Current Partner Older/Younger/Same Age"
   HOWMUCH = "JF-2c Age Difference between 1st Current Partner & R"
   CURRPAGE2 = "JF-2a Age of R's 2nd Current Partner at Last Sex"
   RELAGE2 = "JF-2b Is 2nd Current Partner Older/Younger/Same Age"
   HOWMUCH2 = "JF-2c Age Difference between 2nd Current Partner & R"
   CURRPAGE3 = "JF-2a Age of R's 3rd Current Partner at Last Sex"
   RELAGE3 = "JF-2b Is 3rd Current Partner Older/Younger/Same Age"
   HOWMUCH3 = "JF-2c Age Difference between 3rd Current Partner & R"
   BISEXPRT = "JF-3 Last 12 months: R Had Sex w/Male Who Ever Had Sex w/Males"
   NONMONOG = "JF-4 Last 12 months: R Had Sex w/Male Who Had Other Partners"
   NNONMONOG1 = "JF-5a Number of male partners in last year who were having sex with others"
   NNONMONOG2 = "JF-5b Number of other partners R's 1 partner in last year had at same time"
   NNONMONOG3 = "JF-5c Number of other partners R's most recent partner in last year had at same time"
   MALSHT12 = "JF-6 Last 12 months: R had sex w/male intravenous drug user"
   PROSTFRQ = "JF-7 Last 12 months: R took money or drugs from male for sex"
   JOHNFREQ = "JF-8 Last 12 months: R gave money or drugs to male for sex"
   HIVMAL12 = "JF-9 Last 12 months: R had sex with an HIV-positive male"
   GIVORALF = "JG-1a R performed oral sex on another female?"
   GETORALF = "JG-1b Another female ever performed oral sex on R?"
   FEMSEX = "JG-1c R ever had sexual experience with a female"
   SAMESEXANY = "Ever Had Sexual Contact with a Female (computed in FC J-19)"
   FEMPARTS_1 = "JG-2 Number of Female Sex Partners in Entire Life"
   FEMLIFEV = "JG-2v Verify # of Female Sex Partners in Entire Life"
   FEMPARTS_2 = "JG-2 Number of Female Sex Partners in Entire Life"
   SAMLIFENUM = "Number of same-sex partners in lifetime (computed in FC J-19d)"
   FEMPRT12_1 = "JG-3 Number of Female Sex Partners in Last 12 Months"
   FEM12V = "JG-3v Verify # of Female Sex Partners in Last 12 Months"
   FEMPRT12_2 = "JG-3 Number of Female Sex Partners in Last 12 months"
   SAMYEARNUM = "Number of same-sex partners in last 12 months (computed in FC J-19f)"
   SAMESEX1 = "JG-4 R's age at first sexual experience with same-sex (female) partner"
   MFLASTP = "JH-1 Was R's Last Sex Partner Male or Female"
   ATTRACT = "JH-2 R's Sexual Attraction to Males vs Females"
   ORIENT = "JH-3 R's Sexual Orientation"
   CONFCONC = "JH-3a Not go for sexual or reproductive health care because your parents might find out"
   TIMALON = "JH-3b Dr ever spend any time alone with you without a parent"
   RISKCHEK1 = "JH-3c Dr ever asked R about sexual orientation or sex of her partners"
   RISKCHEK2 = "JH-3d Dr ever asked R about her number of sexual partners"
   RISKCHEK3 = "JH-3e Dr ever asked R about her use of condoms"
   RISKCHEK4 = "JH-3f Dr ever asked R about the types of sex she has"
   CHLAMTST = "JH-4 Last 12 months: R tested for chlamydia"
   STDOTHR12 = "JH-4b STD testing (other than chlamydia) in last 12 months"
   STDTRT12 = "JH-5 Last 12 months: R treated for any STD"
   GON = "JH-6 Last 12 months: R told she had gonorrhea"
   CHLAM = "JH-7 Last 12 months: R told she had chlamydia"
   HERPES = "JH-8 R ever (in life) told she had genital herpes"
   GENWARTS = "JH-9 R ever (in life) told she had genital warts"
   SYPHILIS = "JH-10 R ever (in life) told she had syphilis"
   EVRINJECT = "JH-11 Ever injected non-prescription drugs in lifetime"
   EVRSHARE = "JH-12 Ever (In Life) Shared an IV Needle"
   EARNTYPE = "JI-0a Report total earnings before taxes by week/month/year"
   EARN = "JI-0b Total earnings reported by category"
   EARNDK1 = "JI-0c If DK/RF total earnings, was it $20,000 or more"
   EARNDK2 = "JI-0d If more than $20,000, was it $50,000 or more"
   EARNDK3 = "JI-0e If more than $50,000, was it $75,000 or more"
   EARNDK4 = "JI-0f If more than $75,000, was it $100,000 or more"
   WAGE = "JI-1a In prior calendar year, received income from wages/salaries"
   SELFINC = "JI-1b In prior calendar year, received income from self-employment"
   SOCSEC = "JI-1c In prior calendar year, received income from Social Security"
   DISABIL = "JI-1d In prior calendar year, received income from disability pension"
   RETIRE = "JI-1e In prior calendar year, received income from retirement"
   SSI = "JI-1f In prior calendar year, received income from Supplemental Security Income"
   UNEMP = "JI-1g In prior calendar year, received income from unemployment comp"
   CHLDSUPP = "JI-1h In prior calendar year, received income from child support"
   INTEREST = "JI-1i In prior calendar year, received interest from savings"
   DIVIDEND = "JI-1j In prior calendar year, received dividends from stocks/royalties/trusts"
   OTHINC = "JI-1k In prior calendar year, received other income (ex: alimony, VA, Worker's Comp)"
   TOINCWMY = "JI-2 Prefer to report total income per week/month/year"
   TOTINC = "JI-3 Total combined family income reported by category in prior calendar year"
   FMINCDK1 = "JI-3a If DK/RF combined family income, was it less than $50,000 or $50,000 or more?"
   FMINCDK2 = "JI-3b If income less than $50,000, was it less than $35,000?"
   FMINCDK3 = "JI-3c If income less than $35,000, was it less than poverty threshold?"
   FMINCDK4 = "JI-3d If income more than $50,000, was it $75,000 or more?"
   FMINCDK5 = "JI-3e If income more than $75,000, was it $100,000 or more?"
   PUBASST = "JI-4 Received CASH assistance from state/county welfare program in prior calendar year"
   PUBASTYP1 = "JI-5 Type of CASH assistance program in prior calendar year-1st mention"
   FOODSTMP = "JI-6 In prior calendar year, received food stamps"
   WIC = "JI-7 In prior calendar year, received WIC"
   HLPTRANS = "JI-8a In prior calendar year, received transportation assistance"
   HLPCHLDC = "JI-8b In prior calendar year, received child care services or assistance"
   HLPJOB = "JI-8c In prior calendar year, received job training/search help from social svcs"
   FREEFOOD = "JI-9 In last 12 months, received free or reduced-cost food because couldn't afford to buy food"
   HUNGRY = "JI-10 In last 12 months, a family member was hungry because could not afford more food"
   MED_COST = "JI-11 In last 12 months, a family member didn't see doctor because of cost"
   AGER = "R's age at interview (RECODE)"
   FMARITAL = "Formal (legal) marital status (RECODE)"
   RMARITAL = "Informal marital status (RECODE)"
   EDUCAT = "Education (number of years of schooling) (RECODE)"
   HIEDUC = "Highest completed year of school or highest degree received (RECODE)"
   HISPANIC = "Hispanic origin of respondent (RECODE)"
   NUMRACE = "Intermediate variable for multiple race reporting (used for HISPRACE2)"
   RACE = "Race of respondent (RECODE)"
   HISPRACE = "Race & Hispanic origin of respondent - 1977 OMB standards (RECODE)"
   HISPRACE2 = "Race & Hispanic origin of respondent - 1997 OMB standards (RECODE)"
   NUMKDHH = "Number of bio/adopt/related/legal children under age 18 in household (RECODE)"
   NUMFMHH = "Number of family members in household (RECODE)"
   HHFAMTYP = "Type of household/family structure (RECODE)"
   HHPARTYP = "Type of parental situation in household (RECODE)"
   NCHILDHH = "Number of R's bio or non-bio children (18 or younger) living in household (RECODE)"
   HHKIDTYP = "Whether R has children (18 or younger), and whether bio or non-bio, living in the household (RECODE)"
   CSPBBHH = "Number of R's biological children (18 or younger) with current spouse/cohabiting partner who live in household (RECODE)"
   CSPBSHH = "Number of R's biological children (18 or younger) in household who are the not the biological children of her current husband/cohabiting partner (RECODE)"
   CSPOKDHH = "Number of all other children (18 or younger) living in household with R and current spouse/cohabiting partner (RECODE)"
   INTCTFAM = "Intact status of childhood family (RECODE)"
   PARAGE14 = "Parental living situation at age 14 (RECODE)"
   EDUCMOM = "Mother's (or mother-figure's) education (RECODE)"
   AGEMOMB1 = "Age of mother (or mother-figure) at first birth (RECODE)"
   AGER_I = "AGER Imputation Flag"
   FMARITAL_I = "FMARITAL Imputation Flag"
   RMARITAL_I = "RMARITAL Imputation Flag"
   EDUCAT_I = "EDUCAT Imputation Flag"
   HIEDUC_I = "HIEDUC Imputation Flag"
   HISPANIC_I = "HISPANIC Imputation Flag"
   RACE_I = "RACE Imputation Flag"
   HISPRACE_I = "HISPRACE Imputation Flag"
   HISPRACE2_I = "HISPRACE2 Imputation Flag"
   NUMKDHH_I = "NUMKDHH Imputation Flag"
   NUMFMHH_I = "NUMFMHH Imputation Flag"
   HHFAMTYP_I = "HHFAMTYP Imputation Flag"
   HHPARTYP_I = "HHPARTYP Imputation Flag"
   NCHILDHH_I = "NCHILDHH Imputation Flag"
   HHKIDTYP_I = "HHKIDTYP Imputation Flag"
   CSPBBHH_I = "CSPBBHH Imputation Flag"
   CSPBSHH_I = "CSPBSHH Imputation Flag"
   CSPOKDHH_I = "CSPOKHH Imputation Flag"
   INTCTFAM_I = "INTCTFAM Imputation Flag"
   PARAGE14_I = "PARAGE14 Imputation Flag"
   EDUCMOM_I = "EDUCMOM Imputation Flag"
   AGEMOMB1_I = "AGEMOMB1 Imputation Flag"
   RCURPREG = "Whether R is currently pregnant (RECODE)"
   PREGNUM = "CAPI-based total number of pregnancies (RECODE)"
   COMPREG = "CAPI-based total number of completed pregnancies (RECODE)"
   LOSSNUM = "CAPI-based total number of spontaneous pregnancy losses (RECODE)"
   ABORTION = "CAPI-based total number of induced abortions (RECODE)"
   LBPREGS = "CAPI-based total number of pregs ending in live birth (RECODE)"
   PARITY = "CAPI-based total number of live births (accounting for mult birth) (RECODE)"
   BIRTHS5 = "Number of live births in last 5 years (RECODE)"
   OUTCOM01 = "Outcome of pregnancy  - 1st  (RECODE)"
   OUTCOM02 = "Outcome of pregnancy  - 2nd (RECODE)"
   OUTCOM03 = "Outcome of pregnancy  - 3rd (RECODE)"
   OUTCOM04 = "Outcome of pregnancy  - 4th (RECODE)"
   OUTCOM05 = "Outcome of pregnancy  - 5th (RECODE)"
   OUTCOM06 = "Outcome of pregnancy  - 6th (RECODE)"
   OUTCOM07 = "Outcome of pregnancy  - 7th (RECODE)"
   OUTCOM08 = "Outcome of pregnancy  - 8th (RECODE)"
   OUTCOM09 = "Outcome of pregnancy  - 9th (RECODE)"
   OUTCOM10 = "Outcome of pregnancy  - 10th (RECODE)"
   OUTCOM11 = "Outcome of pregnancy  - 11th (RECODE)"
   OUTCOM12 = "Outcome of pregnancy  - 12th (RECODE)"
   OUTCOM13 = "Outcome of pregnancy  - 13th (RECODE)"
   OUTCOM14 = "Outcome of pregnancy  - 14th (RECODE)"
   OUTCOM15 = "Outcome of pregnancy  - 15th (RECODE)"
   OUTCOM16 = "Outcome of pregnancy  - 16th (RECODE)"
   OUTCOM17 = "Outcome of pregnancy  - 17th (RECODE)"
   OUTCOM18 = "Outcome of pregnancy  - 18th (RECODE)"
   OUTCOM19 = "Outcome of pregnancy  - 19th (RECODE)"
   OUTCOM20 = "Outcome of pregnancy  - 20th (RECODE)"
   DATEND01 = "CM date when pregnancy ended - 1st (RECODE)"
   DATEND02 = "CM date when pregnancy ended - 2nd (RECODE)"
   DATEND03 = "CM date when pregnancy ended - 3rd (RECODE)"
   DATEND04 = "CM date when pregnancy ended - 4th (RECODE)"
   DATEND05 = "CM date when pregnancy ended - 5th (RECODE)"
   DATEND06 = "CM date when pregnancy ended - 6th (RECODE)"
   DATEND07 = "CM date when pregnancy ended - 7th (RECODE)"
   DATEND08 = "CM date when pregnancy ended - 8th (RECODE)"
   DATEND09 = "CM date when pregnancy ended - 9th (RECODE)"
   DATEND10 = "CM date when pregnancy ended - 10th (RECODE)"
   DATEND11 = "CM date when pregnancy ended - 11th (RECODE)"
   DATEND12 = "CM date when pregnancy ended - 12th (RECODE)"
   DATEND13 = "CM date when pregnancy ended - 13th (RECODE)"
   DATEND14 = "CM date when pregnancy ended - 14th (RECODE)"
   DATEND15 = "CM date when pregnancy ended - 15th (RECODE)"
   DATEND16 = "CM date when pregnancy ended - 16th (RECODE)"
   DATEND17 = "CM date when pregnancy ended - 17th (RECODE)"
   DATEND18 = "CM date when pregnancy ended - 18th (RECODE)"
   DATEND19 = "CM date when pregnancy ended - 19th (RECODE)"
   DATEND20 = "CM date when pregnancy ended - 20th (RECODE)"
   AGEPRG01 = "Age when pregnancy ended - 1st (RECODE)"
   AGEPRG02 = "Age when pregnancy ended - 2nd (RECODE)"
   AGEPRG03 = "Age when pregnancy ended - 3rd (RECODE)"
   AGEPRG04 = "Age when pregnancy ended - 4th (RECODE)"
   AGEPRG05 = "Age when pregnancy ended - 5th (RECODE)"
   AGEPRG06 = "Age when pregnancy ended - 6th (RECODE)"
   AGEPRG07 = "Age when pregnancy ended - 7th (RECODE)"
   AGEPRG08 = "Age when pregnancy ended - 8th (RECODE)"
   AGEPRG09 = "Age when pregnancy ended - 9th (RECODE)"
   AGEPRG10 = "Age when pregnancy ended - 10th (RECODE)"
   AGEPRG11 = "Age when pregnancy ended - 11th (RECODE)"
   AGEPRG12 = "Age when pregnancy ended - 12th (RECODE)"
   AGEPRG13 = "Age when pregnancy ended - 13th (RECODE)"
   AGEPRG14 = "Age when pregnancy ended - 14th (RECODE)"
   AGEPRG15 = "Age when pregnancy ended - 15th (RECODE)"
   AGEPRG16 = "Age when pregnancy ended - 16th (RECODE)"
   AGEPRG17 = "Age when pregnancy ended - 17th (RECODE)"
   AGEPRG18 = "Age when pregnancy ended - 18th (RECODE)"
   AGEPRG19 = "Age when pregnancy ended - 19th (RECODE)"
   AGEPRG20 = "Age when pregnancy ended - 20th (RECODE)"
   DATCON01 = "CM date when pregnancy began - 1st (RECODE)"
   DATCON02 = "CM date when pregnancy began - 2nd (RECODE)"
   DATCON03 = "CM date when pregnancy began - 3rd (RECODE)"
   DATCON04 = "CM date when pregnancy began - 4th (RECODE)"
   DATCON05 = "CM date when pregnancy began - 5th (RECODE)"
   DATCON06 = "CM date when pregnancy began - 6th (RECODE)"
   DATCON07 = "CM date when pregnancy began - 7th (RECODE)"
   DATCON08 = "CM date when pregnancy began - 8th (RECODE)"
   DATCON09 = "CM date when pregnancy began - 9th (RECODE)"
   DATCON10 = "CM date when pregnancy began - 10th (RECODE)"
   DATCON11 = "CM date when pregnancy began - 11th (RECODE)"
   DATCON12 = "CM date when pregnancy began - 12th (RECODE)"
   DATCON13 = "CM date when pregnancy began - 13th (RECODE)"
   DATCON14 = "CM date when pregnancy began - 14th (RECODE)"
   DATCON15 = "CM date when pregnancy began - 15th (RECODE)"
   DATCON16 = "CM date when pregnancy began - 16th (RECODE)"
   DATCON17 = "CM date when pregnancy began - 17th (RECODE)"
   DATCON18 = "CM date when pregnancy began - 18th (RECODE)"
   DATCON19 = "CM date when pregnancy began - 19th (RECODE)"
   DATCON20 = "CM date when pregnancy began - 20th (RECODE)"
   AGECON01 = "Age when pregnancy began - 1st (RECODE)"
   AGECON02 = "Age when pregnancy began - 2nd (RECODE)"
   AGECON03 = "Age when pregnancy began - 3rd (RECODE)"
   AGECON04 = "Age when pregnancy began - 4th (RECODE)"
   AGECON05 = "Age when pregnancy began - 5th (RECODE)"
   AGECON06 = "Age when pregnancy began - 6th (RECODE)"
   AGECON07 = "Age when pregnancy began - 7th (RECODE)"
   AGECON08 = "Age when pregnancy began - 8th (RECODE)"
   AGECON09 = "Age when pregnancy began - 9th (RECODE)"
   AGECON10 = "Age when pregnancy began - 10th (RECODE)"
   AGECON11 = "Age when pregnancy began - 11th (RECODE)"
   AGECON12 = "Age when pregnancy began - 12th (RECODE)"
   AGECON13 = "Age when pregnancy began - 13th (RECODE)"
   AGECON14 = "Age when pregnancy began - 14th (RECODE)"
   AGECON15 = "Age when pregnancy began - 15th (RECODE)"
   AGECON16 = "Age when pregnancy began - 16th (RECODE)"
   AGECON17 = "Age when pregnancy began - 17th (RECODE)"
   AGECON18 = "Age when pregnancy began - 18th (RECODE)"
   AGECON19 = "Age when pregnancy began - 19th (RECODE)"
   AGECON20 = "Age when pregnancy began - 20th (RECODE)"
   MAROUT01 = "Formal marital status when pregnancy ended - 1st (RECODE)"
   MAROUT02 = "Formal marital status when pregnancy ended - 2nd (RECODE)"
   MAROUT03 = "Formal marital status when pregnancy ended - 3rd (RECODE)"
   MAROUT04 = "Formal marital status when pregnancy ended - 4th (RECODE)"
   MAROUT05 = "Formal marital status when pregnancy ended - 5th (RECODE)"
   MAROUT06 = "Formal marital status when pregnancy ended - 6th (RECODE)"
   MAROUT07 = "Formal marital status when pregnancy ended - 7th (RECODE)"
   MAROUT08 = "Formal marital status when pregnancy ended - 8th (RECODE)"
   MAROUT09 = "Formal marital status when pregnancy ended - 9th (RECODE)"
   MAROUT10 = "Formal marital status when pregnancy ended - 10th (RECODE)"
   MAROUT11 = "Formal marital status when pregnancy ended - 11th (RECODE)"
   MAROUT12 = "Formal marital status when pregnancy ended - 12th (RECODE)"
   MAROUT13 = "Formal marital status when pregnancy ended - 13th (RECODE)"
   MAROUT14 = "Formal marital status when pregnancy ended - 14th (RECODE)"
   MAROUT15 = "Formal marital status when pregnancy ended - 15th (RECODE)"
   MAROUT16 = "Formal marital status when pregnancy ended - 16th (RECODE)"
   MAROUT17 = "Formal marital status when pregnancy ended - 17th (RECODE)"
   MAROUT18 = "Formal marital status when pregnancy ended - 18th (RECODE)"
   MAROUT19 = "Formal marital status when pregnancy ended - 19th (RECODE)"
   MAROUT20 = "Formal marital status when pregnancy ended - 20th (RECODE)"
   RMAROUT01 = "Informal marital status when pregnancy ended - 1st (RECODE)"
   RMAROUT02 = "Informal marital status when pregnancy ended - 2nd (RECODE)"
   RMAROUT03 = "Informal marital status when pregnancy ended - 3rd (RECODE)"
   RMAROUT04 = "Informal marital status when pregnancy ended - 4th (RECODE)"
   RMAROUT05 = "Informal marital status when pregnancy ended - 5th (RECODE)"
   RMAROUT06 = "Informal marital status when pregnancy ended - 6th (RECODE)"
   RMAROUT07 = "Informal marital status when pregnancy ended - 7th (RECODE)"
   RMAROUT08 = "Informal marital status when pregnancy ended - 8th (RECODE)"
   RMAROUT09 = "Informal marital status when pregnancy ended - 9th (RECODE)"
   RMAROUT10 = "Informal marital status when pregnancy ended - 10th (RECODE)"
   RMAROUT11 = "Informal marital status when pregnancy ended - 11th (RECODE)"
   RMAROUT12 = "Informal marital status when pregnancy ended - 12th (RECODE)"
   RMAROUT13 = "Informal marital status when pregnancy ended - 13th (RECODE)"
   RMAROUT14 = "Informal marital status when pregnancy ended - 14th (RECODE)"
   RMAROUT15 = "Informal marital status when pregnancy ended - 15th (RECODE)"
   RMAROUT16 = "Informal marital status when pregnancy ended - 16th (RECODE)"
   RMAROUT17 = "Informal marital status when pregnancy ended - 17th (RECODE)"
   RMAROUT18 = "Informal marital status when pregnancy ended - 18th (RECODE)"
   RMAROUT19 = "Informal marital status when pregnancy ended - 19th (RECODE)"
   RMAROUT20 = "Informal marital status when pregnancy ended - 20th (RECODE)"
   MARCON01 = "Formal marital status when pregnancy began - 1st (RECODE)"
   MARCON02 = "Formal marital status when pregnancy began - 2nd (RECODE)"
   MARCON03 = "Formal marital status when pregnancy began - 3rd (RECODE)"
   MARCON04 = "Formal marital status when pregnancy began - 4th (RECODE)"
   MARCON05 = "Formal marital status when pregnancy began - 5th (RECODE)"
   MARCON06 = "Formal marital status when pregnancy began - 6th (RECODE)"
   MARCON07 = "Formal marital status when pregnancy began - 7th (RECODE)"
   MARCON08 = "Formal marital status when pregnancy began - 8th (RECODE)"
   MARCON09 = "Formal marital status when pregnancy began - 9th (RECODE)"
   MARCON10 = "Formal marital status when pregnancy began - 10th (RECODE)"
   MARCON11 = "Formal marital status when pregnancy began - 11th (RECODE)"
   MARCON12 = "Formal marital status when pregnancy began - 12th (RECODE)"
   MARCON13 = "Formal marital status when pregnancy began - 13th (RECODE)"
   MARCON14 = "Formal marital status when pregnancy began - 14th (RECODE)"
   MARCON15 = "Formal marital status when pregnancy began - 15th (RECODE)"
   MARCON16 = "Formal marital status when pregnancy began - 16th (RECODE)"
   MARCON17 = "Formal marital status when pregnancy began - 17th (RECODE)"
   MARCON18 = "Formal marital status when pregnancy began - 18th (RECODE)"
   MARCON19 = "Formal marital status when pregnancy began - 19th (RECODE)"
   MARCON20 = "Formal marital status when pregnancy began - 20th (RECODE)"
   RMARCON01 = "Informal marital status when pregnancy began - 1st (RECODE)"
   RMARCON02 = "Informal marital status when pregnancy began - 2nd (RECODE)"
   RMARCON03 = "Informal marital status when pregnancy began - 3rd (RECODE)"
   RMARCON04 = "Informal marital status when pregnancy began - 4th (RECODE)"
   RMARCON05 = "Informal marital status when pregnancy began - 5th (RECODE)"
   RMARCON06 = "Informal marital status when pregnancy began - 6th (RECODE)"
   RMARCON07 = "Informal marital status when pregnancy began - 7th (RECODE)"
   RMARCON08 = "Informal marital status when pregnancy began - 8th (RECODE)"
   RMARCON09 = "Informal marital status when pregnancy began - 9th (RECODE)"
   RMARCON10 = "Informal marital status when pregnancy began - 10th (RECODE)"
   RMARCON11 = "Informal marital status when pregnancy began - 11th (RECODE)"
   RMARCON12 = "Informal marital status when pregnancy began - 12th (RECODE)"
   RMARCON13 = "Informal marital status when pregnancy began - 13th (RECODE)"
   RMARCON14 = "Informal marital status when pregnancy began - 14th (RECODE)"
   RMARCON15 = "Informal marital status when pregnancy began - 15th (RECODE)"
   RMARCON16 = "Informal marital status when pregnancy began - 16th (RECODE)"
   RMARCON17 = "Informal marital status when pregnancy began - 17th (RECODE)"
   RMARCON18 = "Informal marital status when pregnancy began - 18th (RECODE)"
   RMARCON19 = "Informal marital status when pregnancy ended - 19th (RECODE)"
   RMARCON20 = "Informal marital status when pregnancy ended - 20th (RECODE)"
   CEBOW = "Number of children born out of wedlock (RECODE)"
   CEBOWC = "Number of children born in cohabiting unions (RECODE)"
   DATBABY1 = "CM date of 1st live birth (RECODE)"
   AGEBABY1 = "Age at 1st live birth (RECODE)"
   LIVCHILD01 = "Living arrangements of 1st liveborn child from 1st pregnancy (RECODE)"
   LIVCHILD02 = "Living arrangements of 1st liveborn child from 2nd pregnancy (RECODE)"
   LIVCHILD03 = "Living arrangements of 1st liveborn child from 3rd pregnancy (RECODE)"
   LIVCHILD04 = "Living arrangements of 1st liveborn child from 4th pregnancy (RECODE)"
   LIVCHILD05 = "Living arrangements of 1st liveborn child from 5th pregnancy (RECODE)"
   LIVCHILD06 = "Living arrangements of 1st liveborn child from 6th pregnancy (RECODE)"
   LIVCHILD07 = "Living arrangements of 1st liveborn child from 7th pregnancy (RECODE)"
   LIVCHILD08 = "Living arrangements of 1st liveborn child from 8th pregnancy (RECODE)"
   LIVCHILD09 = "Living arrangements of 1st liveborn child from 9th pregnancy (RECODE)"
   LIVCHILD10 = "Living arrangements of 1st liveborn child from 10th pregnancy (RECODE)"
   LIVCHILD11 = "Living arrangements of 1st liveborn child from 11th pregnancy (RECODE)"
   LIVCHILD12 = "Living arrangements of 1st liveborn child from 12th pregnancy (RECODE)"
   LIVCHILD13 = "Living arrangements of 1st liveborn child from 13th pregnancy (RECODE)"
   LIVCHILD14 = "Living arrangements of 1st liveborn child from 14th pregnancy (RECODE)"
   LIVCHILD15 = "Living arrangements of 1st liveborn child from 15th pregnancy (RECODE)"
   LIVCHILD16 = "Living arrangements of 1st liveborn child from 16th pregnancy (RECODE)"
   LIVCHILD17 = "Living arrangements of 1st liveborn child from 17th pregnancy (RECODE)"
   LIVCHILD18 = "Living arrangements of 1st liveborn child from 18th pregnancy (RECODE)"
   LIVCHILD19 = "Living arrangements of 1st liveborn child from 19th pregnancy (RECODE)"
   LIVCHILD20 = "Living arrangements of 1st liveborn child from 20th pregnancy (RECODE)"
   RCURPREG_I = "RCURPREG Imputation Flag"
   PREGNUM_I = "PREGNUM Imputation Flag"
   COMPREG_I = "COMPREG Imputation Flag"
   LOSSNUM_I = "LOSSNUM Imputation Flag"
   ABORTION_I = "ABORTION Imputation Flag"
   LBPREGS_I = "LBPREGS Imputation Flag"
   PARITY_I = "PARITY Imputation Flag"
   BIRTHS5_I = "BIRTHS5 Imputation Flag"
   OUTCOM01_I = "OUTCOM01 Imputation Flag"
   OUTCOM02_I = "OUTCOM02 Imputation Flag"
   OUTCOM03_I = "OUTCOM03 Imputation Flag"
   OUTCOM04_I = "OUTCOM04 Imputation Flag"
   OUTCOM05_I = "OUTCOM05 Imputation Flag"
   OUTCOM06_I = "OUTCOM06 Imputation Flag"
   OUTCOM07_I = "OUTCOM07 Imputation Flag"
   OUTCOM08_I = "OUTCOM08 Imputation Flag"
   OUTCOM09_I = "OUTCOM09 Imputation Flag"
   OUTCOM10_I = "OUTCOM10 Imputation Flag"
   OUTCOM11_I = "OUTCOM11 Imputation Flag"
   OUTCOM12_I = "OUTCOM12 Imputation Flag"
   OUTCOM13_I = "OUTCOM13 Imputation Flag"
   OUTCOM14_I = "OUTCOM14 Imputation Flag"
   OUTCOM15_I = "OUTCOM15 Imputation Flag"
   OUTCOM16_I = "OUTCOM16 Imputation Flag"
   OUTCOM17_I = "OUTCOM17 Imputation Flag"
   OUTCOM18_I = "OUTCOM18 Imputation Flag"
   OUTCOM19_I = "OUTCOM19 Imputation Flag"
   OUTCOM20_I = "OUTCOM20 Imputation Flag"
   DATEND01_I = "DATEND01 Imputation Flag"
   DATEND02_I = "DATEND02 Imputation Flag"
   DATEND03_I = "DATEND03 Imputation Flag"
   DATEND04_I = "DATEND04 Imputation Flag"
   DATEND05_I = "DATEND05 Imputation Flag"
   DATEND06_I = "DATEND06 Imputation Flag"
   DATEND07_I = "DATEND07 Imputation Flag"
   DATEND08_I = "DATEND08 Imputation Flag"
   DATEND09_I = "DATEND09 Imputation Flag"
   DATEND10_I = "DATEND10 Imputation Flag"
   DATEND11_I = "DATEND11 Imputation Flag"
   DATEND12_I = "DATEND12 Imputation Flag"
   DATEND13_I = "DATEND13 Imputation Flag"
   DATEND14_I = "DATEND14 Imputation Flag"
   DATEND15_I = "DATEND15 Imputation Flag"
   DATEND16_I = "DATEND16 Imputation Flag"
   DATEND17_I = "DATEND17 Imputation Flag"
   DATEND18_I = "DATEND18 Imputation Flag"
   DATEND19_I = "DATEND19 Imputation Flag"
   DATEND20_I = "DATEND20 Imputation Flag"
   AGEPRG01_I = "AGEPRG01 Imputation Flag"
   AGEPRG02_I = "AGEPRG02 Imputation Flag"
   AGEPRG03_I = "AGEPRG03 Imputation Flag"
   AGEPRG04_I = "AGEPRG04 Imputation Flag"
   AGEPRG05_I = "AGEPRG05 Imputation Flag"
   AGEPRG06_I = "AGEPRG06 Imputation Flag"
   AGEPRG07_I = "AGEPRG07 Imputation Flag"
   AGEPRG08_I = "AGEPRG08 Imputation Flag"
   AGEPRG09_I = "AGEPRG09 Imputation Flag"
   AGEPRG10_I = "AGEPRG10 Imputation Flag"
   AGEPRG11_I = "AGEPRG11 Imputation Flag"
   AGEPRG12_I = "AGEPRG12 Imputation Flag"
   AGEPRG13_I = "AGEPRG13 Imputation Flag"
   AGEPRG14_I = "AGEPRG14 Imputation Flag"
   AGEPRG15_I = "AGEPRG15 Imputation Flag"
   AGEPRG16_I = "AGEPRG16 Imputation Flag"
   AGEPRG17_I = "AGEPRG17 Imputation Flag"
   AGEPRG18_I = "AGEPRG18 Imputation Flag"
   AGEPRG19_I = "AGEPRG19 Imputation Flag"
   AGEPRG20_I = "AGEPRG20 Imputation Flag"
   DATCON01_I = "DATCON01 Imputation Flag"
   DATCON02_I = "DATCON02 Imputation Flag"
   DATCON03_I = "DATCON03 Imputation Flag"
   DATCON04_I = "DATCON04 Imputation Flag"
   DATCON05_I = "DATCON05 Imputation Flag"
   DATCON06_I = "DATCON06 Imputation Flag"
   DATCON07_I = "DATCON07 Imputation Flag"
   DATCON08_I = "DATCON08 Imputation Flag"
   DATCON09_I = "DATCON09 Imputation Flag"
   DATCON10_I = "DATCON10 Imputation Flag"
   DATCON11_I = "DATCON11 Imputation Flag"
   DATCON12_I = "DATCON12 Imputation Flag"
   DATCON13_I = "DATCON13 Imputation Flag"
   DATCON14_I = "DATCON14 Imputation Flag"
   DATCON15_I = "DATCON15 Imputation Flag"
   DATCON16_I = "DATCON16 Imputation Flag"
   DATCON17_I = "DATCON17 Imputation Flag"
   DATCON18_I = "DATCON18 Imputation Flag"
   DATCON19_I = "DATCON19 Imputation Flag"
   DATCON20_I = "DATCON20 Imputation Flag"
   AGECON01_I = "AGECON01 Imputation Flag"
   AGECON02_I = "AGECON02 Imputation Flag"
   AGECON03_I = "AGECON03 Imputation Flag"
   AGECON04_I = "AGECON04 Imputation Flag"
   AGECON05_I = "AGECON05 Imputation Flag"
   AGECON06_I = "AGECON06 Imputation Flag"
   AGECON07_I = "AGECON07 Imputation Flag"
   AGECON08_I = "AGECON08 Imputation Flag"
   AGECON09_I = "AGECON09 Imputation Flag"
   AGECON10_I = "AGECON10 Imputation Flag"
   AGECON11_I = "AGECON11 Imputation Flag"
   AGECON12_I = "AGECON12 Imputation Flag"
   AGECON13_I = "AGECON13 Imputation Flag"
   AGECON14_I = "AGECON14 Imputation Flag"
   AGECON15_I = "AGECON15 Imputation Flag"
   AGECON16_I = "AGECON16 Imputation Flag"
   AGECON17_I = "AGECON17 Imputation Flag"
   AGECON18_I = "AGECON18 Imputation Flag"
   AGECON19_I = "AGECON19 Imputation Flag"
   AGECON20_I = "AGECON20 Imputation Flag"
   MAROUT01_I = "MAROUT01 Imputation Flag"
   MAROUT02_I = "MAROUT02 Imputation Flag"
   MAROUT03_I = "MAROUT03 Imputation Flag"
   MAROUT04_I = "MAROUT04 Imputation Flag"
   MAROUT05_I = "MAROUT05 Imputation Flag"
   MAROUT06_I = "MAROUT06 Imputation Flag"
   MAROUT07_I = "MAROUT07 Imputation Flag"
   MAROUT08_I = "MAROUT08 Imputation Flag"
   MAROUT09_I = "MAROUT09 Imputation Flag"
   MAROUT10_I = "MAROUT10 Imputation Flag"
   MAROUT11_I = "MAROUT11 Imputation Flag"
   MAROUT12_I = "MAROUT12 Imputation Flag"
   MAROUT13_I = "MAROUT13 Imputation Flag"
   MAROUT14_I = "MAROUT14 Imputation Flag"
   MAROUT15_I = "MAROUT15 Imputation Flag"
   MAROUT16_I = "MAROUT16 Imputation Flag"
   MAROUT17_I = "MAROUT17 Imputation Flag"
   MAROUT18_I = "MAROUT18 Imputation Flag"
   MAROUT19_I = "MAROUT19 Imputation Flag"
   MAROUT20_I = "MAROUT20 Imputation Flag"
   RMAROUT01_I = "RMAROUT01 Imputation Flag"
   RMAROUT02_I = "RMAROUT02 Imputation Flag"
   RMAROUT03_I = "RMAROUT03 Imputation Flag"
   RMAROUT04_I = "RMAROUT04 Imputation Flag"
   RMAROUT05_I = "RMAROUT05 Imputation Flag"
   RMAROUT06_I = "RMAROUT06 Imputation Flag"
   RMAROUT07_I = "RMAROUT07 Imputation Flag"
   RMAROUT08_I = "RMAROUT08 Imputation Flag"
   RMAROUT09_I = "RMAROUT09 Imputation Flag"
   RMAROUT10_I = "RMAROUT10 Imputation Flag"
   RMAROUT11_I = "RMAROUT11 Imputation Flag"
   RMAROUT12_I = "RMAROUT12 Imputation Flag"
   RMAROUT13_I = "RMAROUT13 Imputation Flag"
   RMAROUT14_I = "RMAROUT14 Imputation Flag"
   RMAROUT15_I = "RMAROUT15 Imputation Flag"
   RMAROUT16_I = "RMAROUT16 Imputation Flag"
   RMAROUT17_I = "RMAROUT17 Imputation Flag"
   RMAROUT18_I = "RMAROUT18 Imputation Flag"
   RMAROUT19_I = "RMAROUT19 Imputation Flag"
   RMAROUT20_I = "RMAROUT20 Imputation Flag"
   MARCON01_I = "MARCON01 Imputation Flag"
   MARCON02_I = "MARCON02 Imputation Flag"
   MARCON03_I = "MARCON03 Imputation Flag"
   MARCON04_I = "MARCON04 Imputation Flag"
   MARCON05_I = "MARCON05 Imputation Flag"
   MARCON06_I = "MARCON06 Imputation Flag"
   MARCON07_I = "MARCON07 Imputation Flag"
   MARCON08_I = "MARCON08 Imputation Flag"
   MARCON09_I = "MARCON09 Imputation Flag"
   MARCON10_I = "MARCON10 Imputation Flag"
   MARCON11_I = "MARCON11 Imputation Flag"
   MARCON12_I = "MARCON12 Imputation Flag"
   MARCON13_I = "MARCON13 Imputation Flag"
   MARCON14_I = "MARCON14 Imputation Flag"
   MARCON15_I = "MARCON15 Imputation Flag"
   MARCON16_I = "MARCON16 Imputation Flag"
   MARCON17_I = "MARCON17 Imputation Flag"
   MARCON18_I = "MARCON18 Imputation Flag"
   MARCON19_I = "MARCON19 Imputation Flag"
   MARCON20_I = "MARCON20 Imputation Flag"
   RMARCON01_I = "RMARCON01 Imputation Flag"
   RMARCON02_I = "RMARCON02 Imputation Flag"
   RMARCON03_I = "RMARCON03 Imputation Flag"
   RMARCON04_I = "RMARCON04 Imputation Flag"
   RMARCON05_I = "RMARCON05 Imputation Flag"
   RMARCON06_I = "RMARCON06 Imputation Flag"
   RMARCON07_I = "RMARCON07 Imputation Flag"
   RMARCON08_I = "RMARCON08 Imputation Flag"
   RMARCON09_I = "RMARCON09 Imputation Flag"
   RMARCON10_I = "RMARCON10 Imputation Flag"
   RMARCON11_I = "RMARCON11 Imputation Flag"
   RMARCON12_I = "RMARCON12 Imputation Flag"
   RMARCON13_I = "RMARCON13 Imputation Flag"
   RMARCON14_I = "RMARCON14 Imputation Flag"
   RMARCON15_I = "RMARCON15 Imputation Flag"
   RMARCON16_I = "RMARCON16 Imputation Flag"
   RMARCON17_I = "RMARCON17 Imputation Flag"
   RMARCON18_I = "RMARCON18 Imputation Flag"
   RMARCON19_I = "RMARCON19 Imputation Flag"
   RMARCON20_I = "RMARCON20 Imputation Flag"
   CEBOW_I = "CEBOW Imputation Flag"
   CEBOWC_I = "CEBOWC Imputation Flag"
   DATBABY1_I = "DATBABY1 Imputation Flag"
   AGEBABY1_I = "AGEBABY1 Imputation Flag"
   LIVCHILD01_I = "LIVCHILD01 Imputation Flag"
   LIVCHILD02_I = "LIVCHILD02 Imputation Flag"
   LIVCHILD03_I = "LIVCHILD03 Imputation Flag"
   LIVCHILD04_I = "LIVCHILD04 Imputation Flag"
   LIVCHILD05_I = "LIVCHILD05 Imputation Flag"
   LIVCHILD06_I = "LIVCHILD06 Imputation Flag"
   LIVCHILD07_I = "LIVCHILD07 Imputation Flag"
   LIVCHILD08_I = "LIVCHILD08 Imputation Flag"
   LIVCHILD09_I = "LIVCHILD09 Imputation Flag"
   LIVCHILD10_I = "LIVCHILD10 Imputation Flag"
   LIVCHILD11_I = "LIVCHILD11 Imputation Flag"
   LIVCHILD12_I = "LIVCHILD12 Imputation Flag"
   LIVCHILD13_I = "LIVCHILD13 Imputation Flag"
   LIVCHILD14_I = "LIVCHILD14 Imputation Flag"
   LIVCHILD15_I = "LIVCHILD15 Imputation Flag"
   LIVCHILD16_I = "LIVCHILD16 Imputation Flag"
   LIVCHILD17_I = "LIVCHILD17 Imputation Flag"
   LIVCHILD18_I = "LIVCHILD18 Imputation Flag"
   LIVCHILD19_I = "LIVCHILD19 Imputation Flag"
   LIVCHILD20_I = "LIVCHILD20 Imputation Flag"
   FMARNO = "Number of times R has been married (RECODE)"
   CSPBIOKD = "Total number of biological children R has had with current spouse or cohabiting partner (RECODE)"
   MARDAT01 = "CM date of R's 1st marriage (RECODE)"
   MARDAT02 = "CM date of R's 2nd marriage (RECODE)"
   MARDAT03 = "CM date of R's 3rd marriage (RECODE)"
   MARDAT04 = "CM date of R's 4th marriage (RECODE)"
   MARDAT05 = "CM date of R's 5th marriage (RECODE)"
   MARDIS01 = "CM date when R's 1st marriage ended (RECODE)"
   MARDIS02 = "CM date when R's 2nd marriage ended (RECODE)"
   MARDIS03 = "CM date when R's 3rd marriage ended (RECODE)"
   MARDIS04 = "CM date when R's 4th marriage ended (RECODE)"
   MARDIS05 = "CM date when R's 5th marriage ended (RECODE)"
   MAREND01 = "How R's 1st marriage ended (RECODE)"
   MAREND02 = "How R's 2nd marriage ended (RECODE)"
   MAREND03 = "How R's 3rd marriage ended (RECODE)"
   MAREND04 = "How R's 4th marriage ended (RECODE)"
   MAREND05 = "How R's 5th marriage ended (RECODE)"
   FMAR1AGE = "Age at first marriage (RECODE)"
   AGEDISS1 = "Age at dissolution of first marriage (RECODE)"
   AGEDD1 = "Age at divorce or death:  1st marriage (RECODE)"
   MAR1DISS = "Months btw/1st marriage & dissolution (or interview) (RECODE)"
   DD1REMAR = "Months btw/divorce or death (1st marriage) and remarriage (or interview) (RECODE)"
   MAR1BIR1 = "Months btw/1st marriage & 1st birth (or interview) (RECODE)"
   MAR1CON1 = "Months btw/1st marriage & 1st conception (or interview) (RECODE)"
   CON1MAR1 = "Months btw/1st conception & 1st marriage (or interview) (RECODE)"
   B1PREMAR = "Whether R's first birth was premarital (RECODE)"
   COHEVER = "Whether R ever cohabited outside of marriage (RECODE)"
   EVMARCOH = "Whether R ever married or cohabited (RECODE)"
   PMARRNO = "Number of premarital cohabitations (RECODE)"
   NONMARR = "Number of nonmarital cohabitations (RECODE)"
   TIMESCOH = "Total number of cohabitations  (RECODE)"
   COHAB1 = "Date of 1st cohabitation (incl. premarital cohabitation) (RECODE)"
   COHSTAT = "Cohabitation experience relative to 1st marriage (RECODE)"
   COHOUT = "Outcome of 1st cohabitation (RECODE)"
   COH1DUR = "Duration (in months) of R's first cohabitation (RECODE)"
   HADSEX = "Whether R has ever had sexual intercourse with a male (RECODE)"
   SEXONCE = "Whether R has had sex only once (RECODE)"
   SEXEVER = "Whether R has ever had sexual intercourse with a male since menarche (RECODE)"
   VRY1STAG = "Age at first intercourse (even if before menarche) (RECODE)"
   SEX1AGE = "Age at first intercourse since menarche (RECODE)"
   VRY1STSX = "CM date of first intercourse (even if before menarche) (RECODE)"
   DATESEX1 = "CM date of first intercourse since menarche (RECODE)"
   FSEXPAGE = "Age of R's first sexual partner at time of first sex (RECODE)"
   SEXMAR = "Mos btw/1st intercourse (even if before menarche) & 1st marriage (or interview) (RECODE)"
   SEX1FOR = "Mos btw/1st intercourse since menarche & 1st marriage (or interview)  (RECODE)"
   SEXUNION = "Months between 1st intercourse and 1st coresidential union (marriage or cohabitation) (RECODE)"
   SEXOUT = "Outcome of 1st sexual intercourse (RECODE)"
   FPDUR = "Months between 1st and last/most recent intercourse with 1st partner ever (RECODE)"
   PARTS1YR = "Number of opposite-sex partners in last 12 mos (RECODE)"
   LSEXDATE = "CM date of last or most recent sexual intercourse (RECODE)"
   SEX3MO = "Whether R had sex in past 3 months (from sexual partner dates) (RECODE)"
   NUMP3MOS = "Number of male partners in last 3 mos (RECODE)"
   LSEXRAGE = "R's age at last or most recent sexual intercourse (RECODE)"
   LSEXPAGE = "R's partner's age at last sexual intercourse (for partners in last 12 mos)"
   PARTDUR1 = "Months between 1st and most recent intercourse with last/most recent partner (RECODE)"
   PARTDUR2 = "Months between 1st and most recent intercourse with 2nd-to-last partner within past 12 mos (RECODE)"
   PARTDUR3 = "Months between 1st and most recent intercourse with 3rd-to-last partner within past 12 mos (RECODE)"
   RELATP1 = "Relationship at time of 1st sex with last/most recent partner (RECODE)"
   RELATP2 = "Relationship at time of 1st sex with 2nd-to-last partner within past 12 mos (RECODE)"
   RELATP3 = "Relationship at time of 1st sex with 3rd-to-last partner within past 12 mos (RECODE)"
   LIFPRTNR = "Number of opposite-sex partners in lifetime  (RECODE)"
   FMARNO_I = "FMARNO Imputation Flag"
   CSPBIOKD_I = "CSPBIOKD Imputation Flag"
   MARDAT01_I = "MARDAT01 Imputation Flag"
   MARDAT02_I = "MARDAT02 Imputation Flag"
   MARDAT03_I = "MARDAT03 Imputation Flag"
   MARDAT04_I = "MARDAT04 Imputation Flag"
   MARDAT05_I = "MARDAT05 Imputation Flag"
   MARDIS01_I = "MARDIS01 Imputation Flag"
   MARDIS02_I = "MARDIS02 Imputation Flag"
   MARDIS03_I = "MARDIS03 Imputation Flag"
   MARDIS04_I = "MARDIS04 Imputation Flag"
   MARDIS05_I = "MARDIS05 Imputation Flag"
   MAREND01_I = "MAREND1 Imputation Flag"
   MAREND02_I = "MAREND2 Imputation Flag"
   MAREND03_I = "MAREND3 Imputation Flag"
   MAREND04_I = "MAREND4 Imputation Flag"
   MAREND05_I = "MAREND5 Imputation Flag"
   FMAR1AGE_I = "FMAR1AGE Imputation Flag"
   AGEDISS1_I = "AGEDISS1 Imputation Flag"
   AGEDD1_I = "AGEDD1 Imputation Flag"
   MAR1DISS_I = "MAR1DISS Imputation Flag"
   DD1REMAR_I = "DD1REMAR Imputation Flag"
   MAR1BIR1_I = "MAR1BIR1 Imputation Flag"
   MAR1CON1_I = "MAR1CON1 Imputation Flag"
   CON1MAR1_I = "CON1MAR1 Imputation Flag"
   B1PREMAR_I = "B1PREMAR Imputation Flag"
   COHEVER_I = "COHEVER Imputation Flag"
   EVMARCOH_I = "EVMARCOH Imputation Flag"
   PMARRNO_I = "PMARRNO Imputation Flag"
   NONMARR_I = "NONMARR Imputation Flag"
   TIMESCOH_I = "TIMESCOH Imputation Flag"
   COHAB1_I = "COHAB1 Imputation Flag"
   COHSTAT_I = "COHSTAT Imputation Flag"
   COHOUT_I = "COHOUT Imputation Flag"
   COH1DUR_I = "COH1DUR Imputation Flag"
   HADSEX_I = "HADSEX Imputation Flag"
   SEXEVER_I = "SEXEVER Imputation Flag"
   VRY1STAG_I = "VRY1STAG Imputation Flag"
   SEX1AGE_I = "SEX1AGE Imputation Flag"
   VRY1STSX_I = "VRY1STSX Imputation Flag"
   DATESEX1_I = "DATESEX1 Imputation Flag"
   SEXONCE_I = "SEXONCE Imputation Flag"
   FSEXPAGE_I = "FSEXPAGE Imputation Flag"
   SEXMAR_I = "SEXMAR Imputation Flag"
   SEX1FOR_I = "SEX1FOR Imputation Flag"
   SEXUNION_I = "SEXUNION Imputation Flag"
   SEXOUT_I = "SEXOUT Imputation Flag"
   FPDUR_I = "FPDUR Imputation Flag"
   PARTS1YR_I = "PARTS1YR Imputation Flag"
   LSEXDATE_I = "LSEXDATE Imputation Flag"
   SEXP3MO_I = "SEXP3MO Imputation Flag"
   NUMP3MOS_I = "NUMP3MOS Imputation Flag"
   LSEXRAGE_I = "LSEXRAGE Imputation Flag"
   PARTDUR1_I = "PARTDUR1 Imputation Flag"
   PARTDUR2_I = "PARTDUR2 Imputation Flag"
   PARTDUR3_I = "PARTDUR3 Imputation Flag"
   RELATP1_I = "RELATP1 Imputation Flag"
   RELATP2_I = "RELATP2 Imputation Flag"
   RELATP3_I = "RELATP3 Imputation Flag"
   LIFPRTNR_I = "LIFPRTNR Imputation Flag"
   STRLOPER = "Type of sterilization operation "in effect" (RECODE)"
   FECUND = "Fecundity status (RECODE)"
   ANYBC36 = "Any method use in 36 months before interview"
   NOSEX36 = "Any months of NONintercourse in 36 months before interview"
   INFERT = "Infertility status (RECODE)"
   ANYBC12 = "Any method use in 12 months before interview"
   ANYMTHD = "Ever used any method for any reason (RECODE)"
   NOSEX12 = "Number of months of nonintercourse in the 12 months prior to interview (RECODE)"
   SEXP3MO = "Whether R had sex in past 3 months (from months of nonintercourse series) (RECODE)"
   CONSTAT1 = "Current contraceptive status (1st priority code) (RECODE)"
   CONSTAT2 = "2nd priority code for current contraceptive status (RECODE)"
   CONSTAT3 = "3rd priority code for current contraceptive status (RECODE)"
   CONSTAT4 = "4th priority code for current contraceptive status (RECODE)"
   PILLR = "Ever used the pill for any reason (RECODE)"
   CONDOMR = "Ever used condom (RECODE)"
   SEX1MTHD1 = "Contraceptive method used at first sex, if any: 1st mentioned (RECODE)"
   SEX1MTHD2 = "Contraceptive method used at first sex, if any: 2nd mentioned (RECODE)"
   SEX1MTHD3 = "Contraceptive method used at first sex, if any: 3rd mentioned (RECODE)"
   SEX1MTHD4 = "Contraceptive method used at first sex, if any: 4th mentioned (RECODE)"
   MTHUSE12 = "Whether used any contraceptive method at last sex in past 12 months (RECODE)"
   METH12M1 = "Contraceptive method used at last sex past 12 mos: 1st mentioned (RECODE)"
   METH12M2 = "Contraceptive method used at last sex past 12 mos: 2nd mentioned (RECODE)"
   METH12M3 = "Contraceptive method used at last sex past 12 mos: 3rd mentioned (RECODE)"
   METH12M4 = "Contraceptive method used at last sex past 12 mos: 4th mentioned (RECODE)"
   MTHUSE3 = "Whether used any contraceptive method at last sex in past 3 mos (RECODE)"
   METH3M1 = "Contraceptive method used last sex past 3 mos: 1st mentioned (RECODE)"
   METH3M2 = "Contraceptive method used last sex past 3 mos: 2nd mentioned (RECODE)"
   METH3M3 = "Contraceptive method used last sex past 3 mos: 3rd mentioned (RECODE)"
   METH3M4 = "Contraceptive method used last sex past 3 mos: 4th mentioned (RECODE)"
   FMETHOD1 = "First method ever used: 1st mentioned (RECODE)"
   FMETHOD2 = "First method ever used: 2nd mentioned (RECODE)"
   FMETHOD3 = "First method ever used: 3rd mentioned (RECODE)"
   FMETHOD4 = "First method ever used: 4th mentioned (RECODE)"
   DATEUSE1 = "Date R used first method for the first time (RECODE)"
   OLDWP01 = "Wantedness of 1st pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP02 = "Wantedness of 2nd pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP03 = "Wantedness of 3rd pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP04 = "Wantedness of 4th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP05 = "Wantedness of 5th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP06 = "Wantedness of 6th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP07 = "Wantedness of 7th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP08 = "Wantedness of 8th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP09 = "Wantedness of 9th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP10 = "Wantedness of 10th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP11 = "Wantedness of 11th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP12 = "Wantedness of 12th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP13 = "Wantedness of 13th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP14 = "Wantedness of 14th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP15 = "Wantedness of 15th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP16 = "Wantedness of 16th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP17 = "Wantedness of 17th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP18 = "Wantedness of 18th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP19 = "Wantedness of 19th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWP20 = "Wantedness of 20th pregnancy--R's partner--cycle 4 version (RECODE)"
   OLDWR01 = "Wantedness of 1st pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR02 = "Wantedness of 2nd pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR03 = "Wantedness of 3rd pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR04 = "Wantedness of 4th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR05 = "Wantedness of 5th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR06 = "Wantedness of 6th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR07 = "Wantedness of 7th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR08 = "Wantedness of 8th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR09 = "Wantedness of 9th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR10 = "Wantedness of 10th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR11 = "Wantedness of 11th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR12 = "Wantedness of 12th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR13 = "Wantedness of 13th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR14 = "Wantedness of 14th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR15 = "Wantedness of 15th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR16 = "Wantedness of 16th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR17 = "Wantedness of 17th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR18 = "Wantedness of 18th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR19 = "Wantedness of 19th pregnancy--Respondent--cycle 4 version (RECODE)"
   OLDWR20 = "Wantedness of 20th pregnancy--Respondent--cycle 4 version (RECODE)"
   WANTRP01 = "Wantedness of 1st pregnancy--Respondent (RECODE)"
   WANTRP02 = "Wantedness of 2nd pregnancy--Respondent (RECODE)"
   WANTRP03 = "Wantedness of 3rd pregnancy--Respondent (RECODE)"
   WANTRP04 = "Wantedness of 4th pregnancy--Respondent (RECODE)"
   WANTRP05 = "Wantedness of 5th pregnancy--Respondent (RECODE)"
   WANTRP06 = "Wantedness of 6th pregnancy--Respondent (RECODE)"
   WANTRP07 = "Wantedness of 7th pregnancy--Respondent (RECODE)"
   WANTRP08 = "Wantedness of 8th pregnancy--Respondent (RECODE)"
   WANTRP09 = "Wantedness of 9th pregnancy--Respondent (RECODE)"
   WANTRP10 = "Wantedness of 10th pregnancy--Respondent (RECODE)"
   WANTRP11 = "Wantedness of 11th pregnancy--Respondent (RECODE)"
   WANTRP12 = "Wantedness of 12th pregnancy--Respondent (RECODE)"
   WANTRP13 = "Wantedness of 13th pregnancy--Respondent (RECODE)"
   WANTRP14 = "Wantedness of 14th pregnancy--Respondent (RECODE)"
   WANTRP15 = "Wantedness of 15th pregnancy--Respondent (RECODE)"
   WANTRP16 = "Wantedness of 16th pregnancy--Respondent (RECODE)"
   WANTRP17 = "Wantedness of 17th pregnancy--Respondent (RECODE)"
   WANTRP18 = "Wantedness of 18th pregnancy--Respondent (RECODE)"
   WANTRP19 = "Wantedness of 19th pregnancy--Respondent (RECODE)"
   WANTRP20 = "Wantedness of 20th pregnancy--Respondent (RECODE)"
   WANTP01 = "Wantedness of 1st pregnancy--R's partner (RECODE)"
   WANTP02 = "Wantedness of 2nd pregnancy--R's partner (RECODE)"
   WANTP03 = "Wantedness of 3rd pregnancy--R's partner (RECODE)"
   WANTP04 = "Wantedness of 4th pregnancy--R's partner (RECODE)"
   WANTP05 = "Wantedness of 5th pregnancy--R's partner (RECODE)"
   WANTP06 = "Wantedness of 6th pregnancy--R's partner (RECODE)"
   WANTP07 = "Wantedness of 7th pregnancy--R's partner (RECODE)"
   WANTP08 = "Wantedness of 8th pregnancy--R's partner (RECODE)"
   WANTP09 = "Wantedness of 9th pregnancy--R's partner (RECODE)"
   WANTP10 = "Wantedness of 10th pregnancy--R's partner (RECODE)"
   WANTP11 = "Wantedness of 11th pregnancy--R's partner (RECODE)"
   WANTP12 = "Wantedness of 12th pregnancy--R's partner (RECODE)"
   WANTP13 = "Wantedness of 13th pregnancy--R's partner (RECODE)"
   WANTP14 = "Wantedness of 14th pregnancy--R's partner (RECODE)"
   WANTP15 = "Wantedness of 15th pregnancy--R's partner (RECODE)"
   WANTP16 = "Wantedness of 16th pregnancy--R's partner (RECODE)"
   WANTP17 = "Wantedness of 17th pregnancy--R's partner (RECODE)"
   WANTP18 = "Wantedness of 18th pregnancy--R's partner (RECODE)"
   WANTP19 = "Wantedness of 19th pregnancy--R's partner (RECODE)"
   WANTP20 = "Wantedness of 20th pregnancy--R's partner (RECODE)"
   NWWANTRP01 = "Detailed wantedness of 1st pregnancy--Respondent (RECODE)"
   NWWANTRP02 = "Detailed wantedness of 2nd pregnancy--Respondent (RECODE)"
   NWWANTRP03 = "Detailed wantedness of 3rd pregnancy--Respondent (RECODE)"
   NWWANTRP04 = "Detailed wantedness of 4th pregnancy--Respondent (RECODE)"
   NWWANTRP05 = "Detailed wantedness of 5th pregnancy--Respondent (RECODE)"
   NWWANTRP06 = "Detailed wantedness of 6th pregnancy--Respondent (RECODE)"
   NWWANTRP07 = "Detailed wantedness of 7th pregnancy--Respondent (RECODE)"
   NWWANTRP08 = "Detailed wantedness of 8th pregnancy--Respondent (RECODE)"
   NWWANTRP09 = "Detailed wantedness of 9th pregnancy--Respondent (RECODE)"
   NWWANTRP10 = "Detailed wantedness of 10th pregnancy--Respondent (RECODE)"
   NWWANTRP11 = "Detailed wantedness of 11th pregnancy--Respondent (RECODE)"
   NWWANTRP12 = "Detailed wantedness of 12th pregnancy--Respondent (RECODE)"
   NWWANTRP13 = "Detailed wantedness of 13th pregnancy--Respondent (RECODE)"
   NWWANTRP14 = "Detailed wantedness of 14th pregnancy--Respondent (RECODE)"
   NWWANTRP15 = "Detailed wantedness of 15th pregnancy--Respondent (RECODE)"
   NWWANTRP16 = "Detailed wantedness of 16th pregnancy--Respondent (RECODE)"
   NWWANTRP17 = "Detailed wantedness of 17th pregnancy--Respondent (RECODE)"
   NWWANTRP18 = "Detailed wantedness of 18th pregnancy--Respondent (RECODE)"
   NWWANTRP19 = "Detailed wantedness of 19th pregnancy--Respondent (RECODE)"
   NWWANTRP20 = "Detailed wantedness of 20th pregnancy--Respondent (RECODE)"
   WANTP5 = "Number of wanted pregnancies in the last 5 years (RECODE)"
   STRLOPER_I = "STRLOPER Imputation Flag"
   FECUND_I = "FECUND Imputation Flag"
   INFERT_I = "INFERT Imputation Flag"
   ANYMTHD_I = "ANYMTHD Imputation Flag"
   NOSEX12_I = "NOSEX12 Imputation Flag"
   SEX3MO_I = "SEX3MO Imputation Flag"
   CONSTAT1_I = "CONSTAT1 Imputation Flag"
   CONSTAT2_I = "CONSTAT2 Imputation Flag"
   CONSTAT3_I = "CONSTAT3 Imputation Flag"
   CONSTAT4_I = "CONSTAT4 Imputation Flag"
   PILLR_I = "PILLR Imputation Flag"
   CONDOMR_I = "CONDOMR Imputation Flag"
   SEX1MTHD1_I = "SEX1MTHD1 Imputation Flag"
   SEX1MTHD2_I = "SEX1MTHD2 Imputation Flag"
   SEX1MTHD3_I = "SEX1MTHD3 Imputation Flag"
   SEX1MTHD4_I = "SEX1MTHD4 Imputation Flag"
   MTHUSE12_I = "MTHUSE12 Imputation Flag"
   METH12M1_I = "METH12M1 Imputation Flag"
   METH12M2_I = "METH12M2 Imputation Flag"
   METH12M3_I = "METH12M3 Imputation Flag"
   METH12M4_I = "METH12M4 Imputation Flag"
   MTHUSE3_I = "MTHUSE3 Imputation Flag"
   METH3M1_I = "METH3M1 Imputation Flag"
   METH3M2_I = "METH3M2 Imputation Flag"
   METH3M3_I = "METH3M3 Imputation Flag"
   METH3M4_I = "METH3M4 Imputation Flag"
   FMETHOD1_I = "FMETHOD1 Imputation Flag"
   FMETHOD2_I = "FMETHOD2 Imputation Flag"
   FMETHOD3_I = "FMETHOD3 Imputation Flag"
   FMETHOD4_I = "FMETHOD4 Imputation Flag"
   DATEUSE1_I = "DATEUSE1 Imputation Flag"
   OLDWP01_I = "OLDWP01 Imputation Flag"
   OLDWP02_I = "OLDWP02 Imputation Flag"
   OLDWP03_I = "OLDWP03 Imputation Flag"
   OLDWP04_I = "OLDWP04 Imputation Flag"
   OLDWP05_I = "OLDWP05 Imputation Flag"
   OLDWP06_I = "OLDWP06 Imputation Flag"
   OLDWP07_I = "OLDWP07 Imputation Flag"
   OLDWP08_I = "OLDWP08 Imputation Flag"
   OLDWP09_I = "OLDWP09 Imputation Flag"
   OLDWP10_I = "OLDWP10 Imputation Flag"
   OLDWP11_I = "OLDWP11 Imputation Flag"
   OLDWP12_I = "OLDWP12 Imputation Flag"
   OLDWP13_I = "OLDWP13 Imputation Flag"
   OLDWP14_I = "OLDWP14 Imputation Flag"
   OLDWP15_I = "OLDWP15 Imputation Flag"
   OLDWP16_I = "OLDWP16 Imputation Flag"
   OLDWP17_I = "OLDWP17 Imputation Flag"
   OLDWP18_I = "OLDWP18 Imputation Flag"
   OLDWP19_I = "OLDWP19 Imputation Flag"
   OLDWP20_I = "OLDWP20 Imputation Flag"
   OLDWR01_I = "OLDWR01 Imputation Flag"
   OLDWR02_I = "OLDWR02 Imputation Flag"
   OLDWR03_I = "OLDWR03 Imputation Flag"
   OLDWR04_I = "OLDWR04 Imputation Flag"
   OLDWR05_I = "OLDWR05 Imputation Flag"
   OLDWR06_I = "OLDWR06 Imputation Flag"
   OLDWR07_I = "OLDWR07 Imputation Flag"
   OLDWR08_I = "OLDWR08 Imputation Flag"
   OLDWR09_I = "OLDWR09 Imputation Flag"
   OLDWR10_I = "OLDWR10 Imputation Flag"
   OLDWR11_I = "OLDWR11 Imputation Flag"
   OLDWR12_I = "OLDWR12 Imputation Flag"
   OLDWR13_I = "OLDWR13 Imputation Flag"
   OLDWR14_I = "OLDWR14 Imputation Flag"
   OLDWR15_I = "OLDWR15 Imputation Flag"
   OLDWR16_I = "OLDWR16 Imputation Flag"
   OLDWR17_I = "OLDWR17 Imputation Flag"
   OLDWR18_I = "OLDWR18 Imputation Flag"
   OLDWR19_I = "OLDWR19 Imputation Flag"
   OLDWR20_I = "OLDWR20 Imputation Flag"
   WANTRP01_I = "WANTRP01 Imputation Flag"
   WANTRP02_I = "WANTRP02 Imputation Flag"
   WANTRP03_I = "WANTRP03 Imputation Flag"
   WANTRP04_I = "WANTRP04 Imputation Flag"
   WANTRP05_I = "WANTRP05 Imputation Flag"
   WANTRP06_I = "WANTRP06 Imputation Flag"
   WANTRP07_I = "WANTRP07 Imputation Flag"
   WANTRP08_I = "WANTRP08 Imputation Flag"
   WANTRP09_I = "WANTRP09Imputation Flag"
   WANTRP10_I = "WANTRP10 Imputation Flag"
   WANTRP11_I = "WANTRP11 Imputation Flag"
   WANTRP12_I = "WANTRP12 Imputation Flag"
   WANTRP13_I = "WANTRP13 Imputation Flag"
   WANTRP14_I = "WANTRP14 Imputation Flag"
   WANTRP15_I = "WANTRP15 Imputation Flag"
   WANTRP16_I = "WANTRP16 Imputation Flag"
   WANTRP17_I = "WANTRP17 Imputation Flag"
   WANTRP18_I = "WANTRP18 Imputation Flag"
   WANTRP19_I = "WANTRP19 Imputation Flag"
   WANTRP20_I = "WANTRP20 Imputation Flag"
   WANTP01_I = "WANTP01 Imputation Flag"
   WANTP02_I = "WANTP02 Imputation Flag"
   WANTP03_I = "WANTP03 Imputation Flag"
   WANTP04_I = "WANTP04 Imputation Flag"
   WANTP05_I = "WANTP05 Imputation Flag"
   WANTP06_I = "WANTP06 Imputation Flag"
   WANTP07_I = "WANTP07 Imputation Flag"
   WANTP08_I = "WANTP08 Imputation Flag"
   WANTP09_I = "WANTP09 Imputation Flag"
   WANTP10_I = "WANTP10 Imputation Flag"
   WANTP11_I = "WANTP11 Imputation Flag"
   WANTP12_I = "WANTP12 Imputation Flag"
   WANTP13_I = "WANTP13 Imputation Flag"
   WANTP14_I = "WANTP14 Imputation Flag"
   WANTP15_I = "WANTP15 Imputation Flag"
   WANTP16_I = "WANTP16 Imputation Flag"
   WANTP17_I = "WANTP17 Imputation Flag"
   WANTP18_I = "WANTP18 Imputation Flag"
   WANTP19_I = "WANTP19 Imputation Flag"
   WANTP20_I = "WANTP20 Imputation Flag"
   NWWANTRP01_I = "NWWANTRP01 Imputation Flag"
   NWWANTRP02_I = "NWWANTRP02 Imputation Flag"
   NWWANTRP03_I = "NWWANTRP03 Imputation Flag"
   NWWANTRP04_I = "NWWANTRP04 Imputation Flag"
   NWWANTRP05_I = "NWWANTRP05 Imputation Flag"
   NWWANTRP06_I = "NWWANTRP06 Imputation Flag"
   NWWANTRP07_I = "NWWANTRP07 Imputation Flag"
   NWWANTRP08_I = "NWWANTRP08 Imputation Flag"
   NWWANTRP09_I = "NWWANTRP09 Imputation Flag"
   NWWANTRP10_I = "NWWANTRP10 Imputation Flag"
   NWWANTRP11_I = "NWWANTRP11 Imputation Flag"
   NWWANTRP12_I = "NWWANTRP12 Imputation Flag"
   NWWANTRP13_I = "NWWANTRP13 Imputation Flag"
   NWWANTRP14_I = "NWWANTRP14 Imputation Flag"
   NWWANTRP15_I = "NWWANTRP15 Imputation Flag"
   NWWANTRP16_I = "NWWANTRP16 Imputation Flag"
   NWWANTRP17_I = "NWWANTRP17 Imputation Flag"
   NWWANTRP18_I = "NWWANTRP18 Imputation Flag"
   NWWANTRP19_I = "NWWANTRP19 Imputation Flag"
   NWWANTRP20_I = "NWWANTRP20 Imputation Flag"
   WANTP5_I = "WANTP5 Imputation Flag"
   FPTIT12 = "Type of clinic used for fp services in last 12 months (RECODE)"
   FPTITMED = "Type of clinic used for medical services in last 12 months (RECODE)"
   FPTITSTE = "Source of services in last 12 months: Sterilization operation (RECODE)"
   FPTITBC = "Source of services last 12 mos: Method of BC or prescription (RECODE)"
   FPTITCHK = "Source of services in last 12 mos: Check-up or test re: BC  (RECODE)"
   FPTITCBC = "Source of services in last 12 mos: Counseling re BC (RECODE)"
   FPTITCST = "Source of services in last 12 mos: Counseling re sterilization (RECODE)"
   FPTITEC = "Source of service in last 12 months: EC or prescription (RECODE)"
   FPTITCEC = "Source of service in last 12 mos: Counseling or info on EC (RECODE)"
   FPTITPRE = "Source of service in last 12 mos: Pregnancy test (RECODE)"
   FPTITABO = "Source of service in last 12 mos: Abortion (RECODE)"
   FPTITPAP = "Source of service in last 12 mos: Pap smear (RECODE)"
   FPTITPEL = "Source of service in last 12 mos: Pelvic exam (RECODE)"
   FPTITPRN = "Source of service in last 12 mos: Prenatal care (RECODE)"
   FPTITPPR = "Source of service in last 12 mos: Post-pregnancy care (RECODE)"
   FPTITSTD = "Source of service in last 12 mos: testing for STD (RECODE)"
   FPREGFP = "Title X clinic used for FP svcs: Regular place for care (RECODE)"
   FPREGMED = "Title X clinic used for med svcs: Regular place for care (RECODE)"
   FPTIT12_I = "FPTIT12 Imputation Flag"
   FPTITMED_I = "FPTITMED Imputation Flag"
   FPTITSTE_I = "FPTITSTE Imputation Flag"
   FPTITBC_I = "FPTITBC Imputation Flag"
   FPTITCHK_I = "FPTITCHK Imputation Flag"
   FPTITCBC_I = "FPTITCBC Imputation Flag"
   FPTITCST_I = "FPTITCST Imputation Flag"
   FPTITEC_I = "FPTITEC Imputation Flag"
   FPTITCEC_I = "FPTITCEC Imputation Flag"
   FPTITPRE_I = "FPTITPRE Imputation Flag"
   FPTITABO_I = "FPTITABO Imputation Flag"
   FPTITPAP_I = "FPTITPAP Imputation Flag"
   FPTITPEL_I = "FPTITPEL Imputation Flag"
   FPTITPRN_I = "FPTITPRN Imputation Flag"
   FPTITPPR_I = "FPTITPPR Imputation Flag"
   FPTITSTD_I = "FPTITSTD Imputation Flag"
   FPREGFP_I = "FPREGFP Imputation Flag"
   FPREGMED_I = "FPREGMED Imputation Flag"
   INTENT = "Intentions for additional births (RECODE)"
   ADDEXP = "Central number of additional births expected (RECODE)"
   INTENT_I = "INTENT Imputation Flag"
   ADDEXP_I = "ADDEXP Imputation Flag"
   ANYPRGHP = "Any medical help to become pregnant (RECODE)"
   ANYMSCHP = "Any medical help to prevent miscarriage (RECODE)"
   INFEVER = "Ever used infertility services of any kind (RECODE)"
   OVULATE = "Infertility services: drugs to improve ovulation (RECODE)"
   TUBES = "Infertility services: surgery to correct blocked tubes (RECODE)"
   INFERTR = "Infertility services: Infertility testing on R (RECODE)"
   INFERTH = "Infertility services: Infertility testing on H/P (RECODE)"
   ADVICE = "Infertility services: Advice (RECODE)"
   INSEM = "Infertility services: Artificial insemination (RECODE)"
   INVITRO = "Infertility services: In vitro fertilization or other assisted reproduction (RECODE)"
   ENDOMET = "Infertility services: Surgery or drug treatment for endometriosis (RECODE)"
   FIBROIDS = "Infertility services: Surgery for uterine fibroids (RECODE)"
   PIDTREAT = "Ever been treated for PID (RECODE)"
   EVHIVTST = "Ever had an HIV test (RECODE)"
   FPTITHIV = "Source of service in the last 12 mos: HIV test (RECODE)"
   ANYPRGHP_I = "ANYPRGHP Imputation Flag"
   ANYMSCHP_I = "ANYMSCHP Imputation Flag"
   INFEVER_I = "INFEVER Imputation Flag"
   OVULATE_I = "OVULATE Imputation Flag"
   TUBES_I = "TUBES Imputation Flag"
   INFERTR_I = "INFERTR Imputation Flag"
   INFERTH_I = "INFERTH Imputation Flag"
   ADVICE_I = "ADVICE Imputation Flag"
   INSEM_I = "INSEM Imputation Flag"
   INVITRO_I = "INVITRO Imputation Flag"
   ENDOMET_I = "ENDOMET Imputation Flag"
   FIBROIDS_I = "FIBROIDS Imputation Flag"
   PIDTREAT_I = "PIDTREAT Imputation Flag"
   EVHIVTST_I = "EVHIVTST Imputation Flag"
   FPTITHIV_I = "FPTITHIV Imputation Flag"
   CURR_INS = "Current health insurance status"
   METRO = "Place of residence (metropolitan-non-metropolitan) (RECODE)"
   RELIGION = "Current religious affiliation (RECODE)"
   LABORFOR = "Labor force status (RECODE)"
   CURR_INS_I = "CURR_INS Imputation Flag"
   METRO_I = "METRO Imputation Flag"
   RELIGION_I = "RELIGION Imputation Flag"
   LABORFOR_I = "LABORFOR Imputation Flag"
   POVERTY = "Poverty level income (RECODE)"
   TOTINCR = "Total income of R's family (RECODE)"
   PUBASSIS = "Whether R received public assistance in last calendar year (RECODE)"
   POVERTY_I = "POVERTY Imputation Flag"
   TOTINCR_I = "TOTINCR Imputation Flag"
   PUBASSIS_I = "PUBASSIS Imputation Flag"
   WGT2013_2015 = "Final weight for the 2013-2015 NSFG"
   SECU = "Randomized version of the sampling error computational unit"
   SEST = "Randomized version of the stratum"
   CMINTVW = "Century month for date of interview (Computed in Flow Check A-1)"
   CMLSTYR = "Century month for month/year of interview minus one year (Computed in Flow Check A-1)"
   CMJAN3YR = "Century month of January Three Years Prior to Year of interview (Computed in Flow Check A-1)"
   CMJAN4YR = "Century month of January Four Years Prior to Year of Interview (Computed in Flow Check A-1)"
   CMJAN5YR = "Century month of January Five Years Prior to Year of Interview (Computed in Flow Check A-1)"
   QUARTER = "Quarter when case was sampled"
   PHASE = "Regular- or double-sample portion of the quarter"
   INTVWYEAR = "Calendar year when interview occurred"
   INTVLNGTH = "Interview Length in Minutes" ;


* SAS FORMAT STATEMENT;
/*
FORMAT
   RSCRNINF        Y1N5NALC.
   RSCRAGE         AGESCRN.
   RSCRHISP        YESNONAF.
   RSCRRACE        RSCRRACE.
   AGE_A           AGEFMT.
   AGE_R           AGEFMT.
   CMBIRTH         CMFMT.
   AGESCRN         AGESCRN.
   MARSTAT         MARSTAT.
   FMARSTAT        FMARSTAT.
   FMARIT          FMARIT.
   EVRMARRY        EVRMARRY.
   HISP            Y1N5RDF.
   HISPGRP         HISPGRPF.
   PRIMLANG1       PRIMLANG.
   PRIMLANG2       PRIMLANG.
   PRIMLANG3       PRIMLANG.
   ROSCNT          ROSCNT.
   NUMCHILD        ROST4TOP.
   HHKIDS18        ROST5TOP.
   DAUGHT918       DGHT918F.
   SON918          SON918F.
   NONBIOKIDS      ROST2TOP.
   HPLOCALE        HPLOCALE.
   MANREL          MANRELF.
   GOSCHOL         Y1N5RDF.
   VACA            Y1N5RDF.
   HIGRADE         HIGRADE.
   COMPGRD         Y1N5RDF.
   DIPGED          DIPGED.
   EARNHS_M        MNTHFMT.
   EARNHS_Y        YEARFMT.
   CMHSGRAD        CMFMT.
   HISCHGRD        HISCHGRD.
   LSTGRADE        LSTGRADE.
   MYSCHOL_M       MNTHFMT.
   MYSCHOL_Y       YEARFMT.
   CMLSTSCH        CMFMT.
   HAVEDEG         Y1N5RDF.
   DEGREES         DEGREES.
   EARNBA_M        MNTHFMT.
   EARNBA_Y        YEARFMT.
   EXPSCHL         Y1N5RDF.
   EXPGRADE        EXPGRADE2F.
   CMBAGRAD        CMFMT.
   WTHPARNW        WTHPARNW.
   ONOWN           Y1N5RDF.
   ONOWN18         Y1N5RDF.
   INTACT          Y1N5RDF.
   PARMARR         Y1N5RDF.
   INTACT18        INTACT18F.
   LVSIT14F        LVSIT14F.
   LVSIT14M        LVSIT14M.
   WOMRASDU        WOMRASDU.
   MOMDEGRE        MDDEGRE.
   MOMWORKD        MOMWORKD.
   MOMFSTCH        MOMFSTCH.
   MOM18           MOM18F.
   MANRASDU        MANRASDU.
   R_FOSTER        R_FOSTER.
   EVRFSTER        Y1N5RDF.
   MNYFSTER        MNYFSTER.
   DURFSTER        DURFSTER.
   MENARCHE        MENARCHE.
   PREGNOWQ        Y1N5RDF.
   MAYBPREG        MAYBPREG.
   NUMPREGS        NUMPREGF.
   EVERPREG        Y1N5C.
   CURRPREG        Y1N5C.
   HOWPREG_N       HOWPRGF.
   HOWPREG_P       HOWPRGWM.
   NOWPRGDK        NOWPRGDK.
   MOSCURRP        MOSPRGF.
   NPREGS_S        NUMPREGF.
   HASBABES        Y1N5RDF.
   NUMBABES        PARITY.
   NBABES_S        PARITY.
   CMLASTLB        CMFMT.
   CMLSTPRG        CMFMT.
   CMFSTPRG        CMFMT.
   CMPG1BEG        CMFMT.
   NPLACED         KID1PLUS.
   NDIED           KID1PLUS.
   NADOPTV         KID1PLUS.
   TOTPLACD        KID1PLUS.
   OTHERKID        Y1N5RDF.
   NOTHRKID        BIONUMFF.
   SEXOTHKD        MALFEMF.
   RELOTHKD        RELOTHKD.
   ADPTOTKD        ADPTOTKD.
   TRYADOPT        Y1N5RDF.
   TRYEITHR        TRYEITHRF.
   STILHERE        Y1N5RDF.
   DATKDCAM_M      MNTHFMT.
   DATKDCAM_Y      YEARFMT.
   CMOKDCAM        CMFMT.
   OTHKDFOS        Y1N5RDF.
   OKDDOB_M        MNTHFMT.
   OKDDOB_Y        YEARFMT.
   CMOKDDOB        CMFMT.
   OTHKDSPN        Y1N5RDF.
   OTHKDRAC1       RACE13GRF.
   OTHKDRAC2       RACE13GRF.
   KDBSTRAC        RACE13GRF.
   OKBORNUS        OKBORNUS.
   OKDISABL1       OKDISABLF.
   OKDISABL2       OKDISABLF.
   SEXOTHKD2       MALFEMF.
   RELOTHKD2       RELOTHKD.
   ADPTOTKD2       ADPTOTKD.
   TRYADOPT2       Y1N5RDF.
   TRYEITHR2       TRYEITHRF.
   STILHERE2       Y1N5RDF.
   DATKDCAM_M2     MNTHFMT.
   DATKDCAM_Y2     YEARFMT.
   CMOKDCAM2       CMFMT.
   OTHKDFOS2       Y1N5RDF.
   OKDDOB_M2       MNTHFMT.
   OKDDOB_Y2       YEARFMT.
   CMOKDDOB2       CMFMT.
   OTHKDSPN2       Y1N5RDF.
   OTHKDRAC6       RACE13GRF.
   OTHKDRAC7       RACE13GRF.
   KDBSTRAC2       RACE13GRF.
   OKBORNUS2       OKBORNUS.
   OKDISABL5       OKDISABLF.
   OKDISABL6       OKDISABLF.
   SEXOTHKD3       MALFEMF.
   RELOTHKD3       RELOTHKD.
   ADPTOTKD3       ADPTOTKD.
   TRYADOPT3       Y1N5RDF.
   TRYEITHR3       TRYEITHRF.
   STILHERE3       Y1N5RDF.
   DATKDCAM_M3     MNTHFMT.
   DATKDCAM_Y3     YEARFMT.
   CMOKDCAM3       CMFMT.
   OTHKDFOS3       Y1N5RDF.
   OKDDOB_M3       MNTHFMT.
   OKDDOB_Y3       YEARFMT.
   CMOKDDOB3       CMFMT.
   OTHKDSPN3       Y1N5RDF.
   OTHKDRAC11      RACE13GRF.
   OTHKDRAC12      RACE13GRF.
   KDBSTRAC3       RACE13GRF.
   OKBORNUS3       OKBORNUS.
   OKDISABL9       OKDISABLF.
   OKDISABL10      OKDISABLF.
   SEXOTHKD4       MALFEMF.
   RELOTHKD4       RELOTHKD.
   ADPTOTKD4       ADPTOTKD.
   TRYADOPT4       Y1N5RDF.
   TRYEITHR4       TRYEITHRF.
   STILHERE4       Y1N5RDF.
   DATKDCAM_M4     MNTHFMT.
   DATKDCAM_Y4     YEARFMT.
   CMOKDCAM4       CMFMT.
   OTHKDFOS4       Y1N5RDF.
   OKDDOB_M4       MNTHFMT.
   OKDDOB_Y4       YEARFMT.
   CMOKDDOB4       CMFMT.
   OTHKDSPN4       Y1N5RDF.
   OTHKDRAC16      RACE13GRF.
   OTHKDRAC17      RACE13GRF.
   KDBSTRAC4       RACE13GRF.
   OKBORNUS4       OKBORNUS.
   OKDISABL13      OKDISABLF.
   OKDISABL14      OKDISABLF.
   SEXOTHKD5       MALFEMF.
   RELOTHKD5       RELOTHKD.
   ADPTOTKD5       ADPTOTKD.
   TRYADOPT5       Y1N5RDF.
   TRYEITHR5       TRYEITHRF.
   STILHERE5       Y1N5RDF.
   DATKDCAM_M5     MNTHFMT.
   DATKDCAM_Y5     YEARFMT.
   CMOKDCAM5       CMFMT.
   OTHKDFOS5       Y1N5RDF.
   OKDDOB_M5       MNTHFMT.
   OKDDOB_Y5       YEARFMT.
   CMOKDDOB5       CMFMT.
   OTHKDSPN5       Y1N5RDF.
   OTHKDRAC21      RACE13GRF.
   OTHKDRAC22      RACE13GRF.
   KDBSTRAC5       RACE13GRF.
   OKBORNUS5       OKBORNUS.
   OKDISABL17      OKDISABLF.
   OKDISABL18      OKDISABLF.
   SEXOTHKD6       MALFEMF.
   RELOTHKD6       RELOTHKD.
   ADPTOTKD6       ADPTOTKD.
   TRYADOPT6       Y1N5RDF.
   TRYEITHR6       TRYEITHRF.
   STILHERE6       Y1N5RDF.
   DATKDCAM_M6     MNTHFMT.
   DATKDCAM_Y6     YEARFMT.
   CMOKDCAM6       CMFMT.
   OTHKDFOS6       Y1N5RDF.
   OKDDOB_M6       MNTHFMT.
   OKDDOB_Y6       YEARFMT.
   CMOKDDOB6       CMFMT.
   OTHKDSPN6       Y1N5RDF.
   OTHKDRAC26      RACE13GRF.
   OTHKDRAC27      RACE13GRF.
   KDBSTRAC6       RACE13GRF.
   OKBORNUS6       OKBORNUS.
   OKDISABL21      OKDISABLF.
   OKDISABL22      OKDISABLF.
   SEXOTHKD7       MALFEMF.
   RELOTHKD7       RELOTHKD.
   ADPTOTKD7       ADPTOTKD.
   TRYADOPT7       Y1N5RDF.
   TRYEITHR7       TRYEITHRF.
   STILHERE7       Y1N5RDF.
   DATKDCAM_M7     MNTHFMT.
   DATKDCAM_Y7     YEARFMT.
   CMOKDCAM7       CMFMT.
   OTHKDFOS7       Y1N5RDF.
   OKDDOB_M7       MNTHFMT.
   OKDDOB_Y7       YEARFMT.
   CMOKDDOB7       CMFMT.
   OTHKDSPN7       Y1N5RDF.
   OTHKDRAC31      RACE13GRF.
   OTHKDRAC32      RACE13GRF.
   KDBSTRAC7       RACE13GRF.
   OKBORNUS7       OKBORNUS.
   OKDISABL25      OKDISABLF.
   OKDISABL26      OKDISABLF.
   SEXOTHKD8       MALFEMF.
   RELOTHKD8       RELOTHKD.
   ADPTOTKD8       ADPTOTKD.
   TRYADOPT8       Y1N5RDF.
   TRYEITHR8       TRYEITHRF.
   STILHERE8       Y1N5RDF.
   DATKDCAM_M8     MNTHFMT.
   DATKDCAM_Y8     YEARFMT.
   CMOKDCAM8       CMFMT.
   OTHKDFOS8       Y1N5RDF.
   OKDDOB_M8       MNTHFMT.
   OKDDOB_Y8       YEARFMT.
   CMOKDDOB8       CMFMT.
   OTHKDSPN8       Y1N5RDF.
   OTHKDRAC36      RACE13GRF.
   OTHKDRAC37      RACE13GRF.
   KDBSTRAC8       RACE13GRF.
   OKBORNUS8       OKBORNUS.
   OKDISABL29      OKDISABLF.
   OKDISABL30      OKDISABLF.
   SEXOTHKD9       MALFEMF.
   RELOTHKD9       RELOTHKD.
   ADPTOTKD9       ADPTOTKD.
   TRYADOPT9       Y1N5RDF.
   TRYEITHR9       TRYEITHRF.
   STILHERE9       Y1N5RDF.
   DATKDCAM_M9     MNTHFMT.
   DATKDCAM_Y9     YEARFMT.
   CMOKDCAM9       CMFMT.
   OTHKDFOS9       Y1N5RDF.
   OKDDOB_M9       MNTHFMT.
   OKDDOB_Y9       YEARFMT.
   CMOKDDOB9       CMFMT.
   OTHKDSPN9       Y1N5RDF.
   OTHKDRAC41      RACE13GRF.
   OTHKDRAC42      RACE13GRF.
   KDBSTRAC9       RACE13GRF.
   OKBORNUS9       OKBORNUS.
   OKDISABL33      OKDISABLF.
   OKDISABL34      OKDISABLF.
   SEXOTHKD10      MALFEMF.
   RELOTHKD10      RELOTHKD.
   ADPTOTKD10      ADPTOTKD.
   TRYADOPT10      Y1N5RDF.
   TRYEITHR10      TRYEITHRF.
   STILHERE10      Y1N5RDF.
   DATKDCAM_M10    MNTHFMT.
   DATKDCAM_Y10    YEARFMT.
   CMOKDCAM10      CMFMT.
   OTHKDFOS10      Y1N5RDF.
   OKDDOB_M10      MNTHFMT.
   OKDDOB_Y10      YEARFMT.
   CMOKDDOB10      CMFMT.
   OTHKDSPN10      Y1N5RDF.
   OTHKDRAC46      RACE13GRF.
   OTHKDRAC47      RACE13GRF.
   KDBSTRAC10      RACE13GRF.
   OKBORNUS10      OKBORNUS.
   OKDISABL37      OKDISABLF.
   OKDISABL38      OKDISABLF.
   SEXOTHKD11      MALFEMF.
   RELOTHKD11      RELOTHKD.
   ADPTOTKD11      ADPTOTKD.
   TRYADOPT11      Y1N5RDF.
   TRYEITHR11      TRYEITHRF.
   STILHERE11      Y1N5RDF.
   DATKDCAM_M11    MNTHFMT.
   DATKDCAM_Y11    YEARFMT.
   CMOKDCAM11      CMFMT.
   OTHKDFOS11      Y1N5RDF.
   OKDDOB_M11      MNTHFMT.
   OKDDOB_Y11      YEARFMT.
   CMOKDDOB11      CMFMT.
   OTHKDSPN11      Y1N5RDF.
   OTHKDRAC51      RACE13GRF.
   OTHKDRAC52      RACE13GRF.
   KDBSTRAC11      RACE13GRF.
   OKBORNUS11      OKBORNUS.
   OKDISABL41      OKDISABLF.
   OKDISABL42      OKDISABLF.
   SEXOTHKD12      MALFEMF.
   RELOTHKD12      RELOTHKD.
   ADPTOTKD12      ADPTOTKD.
   TRYADOPT12      Y1N5RDF.
   TRYEITHR12      TRYEITHRF.
   STILHERE12      Y1N5RDF.
   DATKDCAM_M12    MNTHFMT.
   DATKDCAM_Y12    YEARFMT.
   CMOKDCAM12      CMFMT.
   OTHKDFOS12      Y1N5RDF.
   OKDDOB_M12      MNTHFMT.
   OKDDOB_Y12      YEARFMT.
   CMOKDDOB12      CMFMT.
   OTHKDSPN12      Y1N5RDF.
   OTHKDRAC56      RACE13GRF.
   OTHKDRAC57      RACE13GRF.
   KDBSTRAC12      RACE13GRF.
   OKBORNUS12      OKBORNUS.
   OKDISABL45      OKDISABLF.
   OKDISABL46      OKDISABLF.
   SEXOTHKD13      MALFEMF.
   RELOTHKD13      RELOTHKD.
   ADPTOTKD13      ADPTOTKD.
   TRYADOPT13      Y1N5RDF.
   TRYEITHR13      TRYEITHRF.
   STILHERE13      Y1N5RDF.
   DATKDCAM_M13    MNTHFMT.
   DATKDCAM_Y13    YEARFMT.
   CMOKDCAM13      CMFMT.
   OTHKDFOS13      Y1N5RDF.
   OKDDOB_M13      MNTHFMT.
   OKDDOB_Y13      YEARFMT.
   CMOKDDOB13      CMFMT.
   OTHKDSPN13      Y1N5RDF.
   OTHKDRAC61      RACE13GRF.
   OTHKDRAC62      RACE13GRF.
   KDBSTRAC13      RACE13GRF.
   OKBORNUS13      OKBORNUS.
   OKDISABL49      OKDISABLF.
   OKDISABL50      OKDISABLF.
   SEXOTHKD14      MALFEMF.
   RELOTHKD14      RELOTHKD.
   ADPTOTKD14      ADPTOTKD.
   TRYADOPT14      Y1N5RDF.
   TRYEITHR14      TRYEITHRF.
   STILHERE14      Y1N5RDF.
   DATKDCAM_M14    MNTHFMT.
   DATKDCAM_Y14    YEARFMT.
   CMOKDCAM14      CMFMT.
   OTHKDFOS14      Y1N5RDF.
   OKDDOB_M14      MNTHFMT.
   OKDDOB_Y14      YEARFMT.
   CMOKDDOB14      CMFMT.
   OTHKDSPN14      Y1N5RDF.
   OTHKDRAC66      RACE13GRF.
   OTHKDRAC67      RACE13GRF.
   KDBSTRAC14      RACE13GRF.
   OKBORNUS14      OKBORNUS.
   OKDISABL53      OKDISABLF.
   OKDISABL54      OKDISABLF.
   SEXOTHKD15      MALFEMF.
   RELOTHKD15      RELOTHKD.
   ADPTOTKD15      ADPTOTKD.
   TRYADOPT15      Y1N5RDF.
   TRYEITHR15      TRYEITHRF.
   STILHERE15      Y1N5RDF.
   DATKDCAM_M15    MNTHFMT.
   DATKDCAM_Y15    YEARFMT.
   CMOKDCAM15      CMFMT.
   OTHKDFOS15      Y1N5RDF.
   OKDDOB_M15      MNTHFMT.
   OKDDOB_Y15      YEARFMT.
   CMOKDDOB15      CMFMT.
   OTHKDSPN15      Y1N5RDF.
   OTHKDRAC71      RACE13GRF.
   OTHKDRAC72      RACE13GRF.
   KDBSTRAC15      RACE13GRF.
   OKBORNUS15      OKBORNUS.
   OKDISABL57      OKDISABLF.
   OKDISABL58      OKDISABLF.
   EVERADPT        EVERADPT.
   SEEKADPT        Y1N5RDF.
   CONTAGEM        Y1N5RDF.
   TRYLONG         TRYLONG.
   KNOWADPT        Y1N5RDF.
   CHOSESEX        CHOSESEX.
   TYPESEXF        Y1N5RDF.
   TYPESEXM        Y1N5RDF.
   CHOSRACE        CHOSRACE.
   TYPRACBK        Y1N5RDF.
   TYPRACWH        Y1N5RDF.
   TYPRACOT        Y1N5RDF.
   CHOSEAGE        CHOSEAGE.
   TYPAGE2M        Y1N5RDF.
   TYPAGE5M        Y1N5RDF.
   TYPAG12M        Y1N5RDF.
   TYPAG13M        Y1N5RDF.
   CHOSDISB        CHOSDISB.
   TYPDISBN        Y1N5RDF.
   TYPDISBM        Y1N5RDF.
   TYPDISBS        Y1N5RDF.
   CHOSENUM        CHOSENUM.
   TYPNUM1M        Y1N5RDF.
   TYPNUM2M        Y1N5RDF.
   EVWNTANO        Y1N5RDF.
   EVCONTAG        Y1N5RDF.
   TURNDOWN        TURNDOWN.
   YQUITTRY        YQUITTRY.
   APROCESS1       APROCESSF.
   APROCESS2       APROCESSF.
   HRDEMBRYO       Y1N5RDF.
   TIMESMAR        TIMESMAR.
   HSBVERIF        Y1N5RDF.
   WHMARHX_M       MNTHFMT.
   WHMARHX_Y       YEARFMT.
   CMMARRHX        CMFMT.
   AGEMARHX        AGERFEMC.
   HXAGEMAR        AGEHP.
   DOBHUSBX_M      MNTHFMT.
   DOBHUSBX_Y      YEARFMT.
   CMHSBDOBX       CMFMT.
   LVTOGHX         Y1N5RDF.
   STRTOGHX_M      MNTHFMT.
   STRTOGHX_Y      YEARFMT.
   CMPMCOHX        CMFMT.
   ENGAGHX         ENGAGF.
   HSBMULT1        MULTRACED.
   HSBRACE1        RACEFMTD.
   HSBHRACE1       HRACED.
   HSBNRACE1       NRACED.
   CHEDMARN        EDUCFMT.
   MARBEFHX        Y1N5RDF.
   KIDSHX          Y1N5RDF.
   NUMKDSHX        BIONUMFF.
   KIDLIVHX        Y1N5RDF.
   CHKID18A        Y1N5RDF.
   CHKID18B        KID18BF.
   WHRCHKDS1       WHRKDSF.
   WHRCHKDS2       WHRKDSF.
   WHRCHKDS3       WHRKDSF.
   WHRCHKDS4       WHRKDSF.
   SUPPORCH        Y1N5JPC.
   BIOHUSBX        Y1N5RDF.
   BIONUMHX        BIONUMFF.
   MARENDHX        MARENDHX.
   WNDIEHX_M       MNTHFMT.
   WNDIEHX_Y       YEARFMT.
   CMHSBDIEX       CMFMT.
   DIVDATHX_M      MNTHFMT.
   DIVDATHX_Y      YEARFMT.
   CMDIVORCX       CMFMT.
   WNSTPHX_M       MNTHFMT.
   WNSTPHX_Y       YEARFMT.
   CMSTPHSBX       CMFMT.
   WHMARHX_M2      MNTHFMT.
   WHMARHX_Y2      YEARFMT.
   CMMARRHX2       CMFMT.
   AGEMARHX2       AGERFEMC.
   HXAGEMAR2       AGEHP.
   DOBHUSBX_M2     MNTHFMT.
   DOBHUSBX_Y2     YEARFMT.
   CMHSBDOBX2      CMFMT.
   LVTOGHX2        Y1N5RDF.
   STRTOGHX_M2     MNTHFMT.
   STRTOGHX_Y2     YEARFMT.
   CMPMCOHX2       CMFMT.
   ENGAGHX2        ENGAGF.
   HSBMULT2        MULTRACED.
   HSBRACE2        RACEFMTD.
   HSBHRACE2       HRACED.
   HSBNRACE2       NRACED.
   CHEDMARN2       EDUCFMT.
   MARBEFHX2       Y1N5RDF.
   KIDSHX2         Y1N5RDF.
   NUMKDSHX2       BIONUMFF.
   KIDLIVHX2       Y1N5RDF.
   CHKID18A2       Y1N5RDF.
   CHKID18B2       KID18BF.
   WHRCHKDS5       WHRKDSF.
   WHRCHKDS6       WHRKDSF.
   WHRCHKDS7       WHRKDSF.
   WHRCHKDS8       WHRKDSF.
   SUPPORCH2       Y1N5JPC.
   BIOHUSBX2       Y1N5RDF.
   BIONUMHX2       BIONUMFF.
   MARENDHX2       MARENDHX.
   WNDIEHX_M2      MNTHFMT.
   WNDIEHX_Y2      YEARFMT.
   CMHSBDIEX2      CMFMT.
   DIVDATHX_M2     MNTHFMT.
   DIVDATHX_Y2     YEARFMT.
   CMDIVORCX2      CMFMT.
   WNSTPHX_M2      MNTHFMT.
   WNSTPHX_Y2      YEARFMT.
   CMSTPHSBX2      CMFMT.
   WHMARHX_M3      MNTHFMT.
   WHMARHX_Y3      YEARFMT.
   CMMARRHX3       CMFMT.
   AGEMARHX3       AGERFEMC.
   HXAGEMAR3       AGEHP.
   DOBHUSBX_M3     MNTHFMT.
   DOBHUSBX_Y3     YEARFMT.
   CMHSBDOBX3      CMFMT.
   LVTOGHX3        Y1N5RDF.
   STRTOGHX_M3     MNTHFMT.
   STRTOGHX_Y3     YEARFMT.
   CMPMCOHX3       CMFMT.
   ENGAGHX3        ENGAGF.
   HSBMULT3        MULTRACED.
   HSBRACE3        RACEFMTD.
   HSBHRACE3       HRACED.
   HSBNRACE3       NRACED.
   CHEDMARN3       EDUCFMT.
   MARBEFHX3       Y1N5RDF.
   KIDSHX3         Y1N5RDF.
   NUMKDSHX3       BIONUMFF.
   KIDLIVHX3       Y1N5RDF.
   CHKID18A3       Y1N5RDF.
   CHKID18B3       KID18BF.
   WHRCHKDS9       WHRKDSF.
   WHRCHKDS10      WHRKDSF.
   WHRCHKDS11      WHRKDSF.
   WHRCHKDS12      WHRKDSF.
   SUPPORCH3       Y1N5JPC.
   BIOHUSBX3       Y1N5RDF.
   BIONUMHX3       BIONUMFF.
   MARENDHX3       MARENDHX.
   WNDIEHX_M3      MNTHFMT.
   WNDIEHX_Y3      YEARFMT.
   CMHSBDIEX3      CMFMT.
   DIVDATHX_M3     MNTHFMT.
   DIVDATHX_Y3     YEARFMT.
   CMDIVORCX3      CMFMT.
   WNSTPHX_M3      MNTHFMT.
   WNSTPHX_Y3      YEARFMT.
   CMSTPHSBX3      CMFMT.
   WHMARHX_M4      MNTHFMT.
   WHMARHX_Y4      YEARFMT.
   CMMARRHX4       CMFMT.
   AGEMARHX4       AGERFEMC.
   HXAGEMAR4       AGEHP.
   DOBHUSBX_M4     MNTHFMT.
   DOBHUSBX_Y4     YEARFMT.
   CMHSBDOBX4      CMFMT.
   LVTOGHX4        Y1N5RDF.
   STRTOGHX_M4     MNTHFMT.
   STRTOGHX_Y4     YEARFMT.
   CMPMCOHX4       CMFMT.
   ENGAGHX4        ENGAGF.
   HSBMULT4        MULTRACED.
   HSBRACE4        RACEFMTD.
   HSBHRACE4       HRACED.
   HSBNRACE4       NRACED.
   CHEDMARN4       EDUCFMT.
   MARBEFHX4       Y1N5RDF.
   KIDSHX4         Y1N5RDF.
   NUMKDSHX4       BIONUMFF.
   KIDLIVHX4       Y1N5RDF.
   CHKID18A4       Y1N5RDF.
   CHKID18B4       KID18BF.
   WHRCHKDS13      WHRKDSF.
   WHRCHKDS14      WHRKDSF.
   WHRCHKDS15      WHRKDSF.
   WHRCHKDS16      WHRKDSF.
   SUPPORCH4       Y1N5JPC.
   BIOHUSBX4       Y1N5RDF.
   BIONUMHX4       BIONUMFF.
   MARENDHX4       MARENDHX.
   WNDIEHX_M4      MNTHFMT.
   WNDIEHX_Y4      YEARFMT.
   CMHSBDIEX4      CMFMT.
   DIVDATHX_M4     MNTHFMT.
   DIVDATHX_Y4     YEARFMT.
   CMDIVORCX4      CMFMT.
   WNSTPHX_M4      MNTHFMT.
   WNSTPHX_Y4      YEARFMT.
   CMSTPHSBX4      CMFMT.
   WHMARHX_M5      MNTHFMT.
   WHMARHX_Y5      YEARFMT.
   CMMARRHX5       CMFMT.
   AGEMARHX5       AGERFEMC.
   HXAGEMAR5       AGEHP.
   DOBHUSBX_M5     MNTHFMT.
   DOBHUSBX_Y5     YEARFMT.
   CMHSBDOBX5      CMFMT.
   LVTOGHX5        Y1N5RDF.
   STRTOGHX_M5     MNTHFMT.
   STRTOGHX_Y5     YEARFMT.
   CMPMCOHX5       CMFMT.
   ENGAGHX5        ENGAGF.
   CHEDMARN5       EDUCFMT.
   MARBEFHX5       Y1N5RDF.
   KIDSHX5         Y1N5RDF.
   NUMKDSHX5       BIONUMFF.
   KIDLIVHX5       Y1N5RDF.
   CHKID18A5       Y1N5RDF.
   CHKID18B5       KID18BF.
   WHRCHKDS17      WHRKDSF.
   WHRCHKDS18      WHRKDSF.
   WHRCHKDS19      WHRKDSF.
   WHRCHKDS20      WHRKDSF.
   SUPPORCH5       Y1N5JPC.
   BIOHUSBX5       Y1N5RDF.
   BIONUMHX5       BIONUMFF.
   MARENDHX5       MARENDHX.
   WNDIEHX_M5      MNTHFMT.
   WNDIEHX_Y5      YEARFMT.
   CMHSBDIEX5      CMFMT.
   DIVDATHX_M5     MNTHFMT.
   DIVDATHX_Y5     YEARFMT.
   CMDIVORCX5      CMFMT.
   WNSTPHX_M5      MNTHFMT.
   WNSTPHX_Y5      YEARFMT.
   CMSTPHSBX5      CMFMT.
   CMMARRCH        CMFMT.
   CMDOBCH         CMFMT.
   PREVHUSB        PREVHUSB.
   WNSTRTCP_M      MNTHFMT.
   WNSTRTCP_Y      YEARFMT.
   CMSTRTCP        CMFMT.
   CPHERAGE        AGERFEMC.
   CPHISAGE        AGEHP.
   WNCPBRN_M       MNTHFMT.
   WNCPBRN_Y       YEARFMT.
   CMDOBCP         CMFMT.
   CPENGAG1        ENGAGF.
   WILLMARR        DEFPROBF.
   CURCOHMULT      MULTRACED.
   CURCOHRACE      RACEFMTD.
   CURCOHHRACE     HRACED.
   CURCOHNRACE     NRACED.
   CPEDUC          EDUCFMT.
   CPMARBEF        Y1N5RDF.
   CPKIDS          Y1N5RDF.
   CPNUMKDS        BIONUMFF.
   CPKIDLIV        Y1N5RDF.
   CPKID18A        Y1N5RDF.
   CPKID18B        KID18BF.
   WHRCPKDS1       WHRKDSF.
   WHRCPKDS2       WHRKDSF.
   WHRCPKDS3       WHRKDSF.
   WHRCPKDS4       WHRKDSF.
   SUPPORCP        Y1N5JPC.
   BIOCP           Y1N5RDF.
   BIONUMCP        BIONUMFF.
   CMSTRTHP        CMFMT.
   LIVEOTH         Y1N5RDF.
   EVRCOHAB        Y1N5C.
   HMOTHMEN        HMOTHMEN.
   PREVCOHB        PREVCOHB.
   STRTOTHX_M      MNTHFMT.
   STRTOTHX_Y      YEARFMT.
   CMCOHSTX        CMFMT.
   HERAGECX        AGERFEMC.
   HISAGECX        AGEHP.
   WNBRNCX_M       MNTHFMT.
   WNBRNCX_Y       YEARFMT.
   CMDOBCX         CMFMT.
   ENGAG1CX        ENGAGF.
   COH1MULT        MULTRACED.
   COH1RACE        RACEFMTD.
   COH1HRACE       HRACED.
   COH1NRACE       NRACED.
   MAREVCX         Y1N5RDF.
   CXKIDS          Y1N5RDF.
   BIOFCPX         Y1N5RDF.
   BIONUMCX        BIONUMFF.
   STPTOGCX_M      MNTHFMT.
   STPTOGCX_Y      YEARFMT.
   CMSTPCOHX       CMFMT.
   STRTOTHX_M2     MNTHFMT.
   STRTOTHX_Y2     YEARFMT.
   CMCOHSTX2       CMFMT.
   HERAGECX2       AGERFEMC.
   HISAGECX2       AGEHP.
   WNBRNCX_M2      MNTHFMT.
   WNBRNCX_Y2      YEARFMT.
   CMDOBCX2        CMFMT.
   ENGAG1CX2       ENGAGF.
   MAREVCX2        Y1N5RDF.
   CXKIDS2         Y1N5RDF.
   BIOFCPX2        Y1N5RDF.
   BIONUMCX2       BIONUMFF.
   STPTOGCX_M2     MNTHFMT.
   STPTOGCX_Y2     YEARFMT.
   CMSTPCOHX2      CMFMT.
   STRTOTHX_M3     MNTHFMT.
   STRTOTHX_Y3     YEARFMT.
   CMCOHSTX3       CMFMT.
   HERAGECX3       AGERFEMC.
   HISAGECX3       AGEHP.
   WNBRNCX_M3      MNTHFMT.
   WNBRNCX_Y3      YEARFMT.
   CMDOBCX3        CMFMT.
   ENGAG1CX3       ENGAGF.
   MAREVCX3        Y1N5RDF.
   CXKIDS3         Y1N5RDF.
   BIOFCPX3        Y1N5RDF.
   BIONUMCX3       BIONUMFF.
   STPTOGCX_M3     MNTHFMT.
   STPTOGCX_Y3     YEARFMT.
   CMSTPCOHX3      CMFMT.
   STRTOTHX_M4     MNTHFMT.
   STRTOTHX_Y4     YEARFMT.
   CMCOHSTX4       CMFMT.
   HERAGECX4       AGERFEMC.
   HISAGECX4       AGEHP.
   WNBRNCX_M4      MNTHFMT.
   WNBRNCX_Y4      YEARFMT.
   CMDOBCX4        CMFMT.
   ENGAG1CX4       ENGAGF.
   MAREVCX4        Y1N5RDF.
   CXKIDS4         Y1N5RDF.
   BIOFCPX4        Y1N5RDF.
   BIONUMCX4       BIONUMFF.
   STPTOGCX_M4     MNTHFMT.
   STPTOGCX_Y4     YEARFMT.
   CMSTPCOHX4      CMFMT.
   COHCHANCE       DEFPROBF.
   MARRCHANCE      DEFPROBF.
   PMARCOH         DEFPROBF.
   EVERSEX         Y1N5RDF.
   RHADSEX         Y1N5C.
   YNOSEX          YNOSEX.
   WNFSTSEX_M      WNFSTSEXF.
   WNFSTSEX_Y      YEARFMT.
   CMFSTSEX        CMFSTSEX.
   AGEFSTSX        AGE44NRDF.
   C_SEX18         FMT18F.
   C_SEX15         FMT15F.
   C_SEX20         FMT20F.
   GRFSTSX         GRFSTSX.
   SXMTONCE        Y1N5RDF.
   TALKPAR1        TALKPARF.
   TALKPAR2        TALKPARF.
   TALKPAR3        TALKPARF.
   TALKPAR4        TALKPARF.
   TALKPAR5        TALKPARF.
   TALKPAR6        TALKPARF.
   TALKPAR7        TALKPARF.
   SEDNO           Y1N5RDF.
   SEDNOG          SXEDGRF.
   SEDNOSX         BFAFTF.
   SEDBC           Y1N5RDF.
   SEDBCG          SXEDGRF.
   SEDBCSX         BFAFTF.
   SEDWHBC         Y1N5RDF.
   SEDWHBCG        SXEDGRF.
   SEDWBCSX        BFAFTF.
   SEDCOND         Y1N5RDF.
   SEDCONDG        SXEDGRF.
   SEDCONSX        BFAFTF.
   SEDSTD          Y1N5RDF.
   SEDSTDG         SXEDGRF.
   SEDSTDSX        BFAFTF.
   SEDHIV          Y1N5RDF.
   SEDHIVG         SXEDGRF.
   SEDHIVSX        BFAFTF.
   SEDABST         Y1N5RDF.
   SEDABSTG        SXEDGRF.
   SEDABSSX        BFAFTF.
   SAMEMAN         Y1N5RDF.
   WHOFSTPR        MTCHMANF.
   FPAGE           AG95RDF.
   FPRELAGE        FPRELAGEF.
   FPRELYRS        FPRELYRS.
   KNOWFP          FSEXREL.
   STILFPSX        Y1N5RDF.
   LSTSEXFP_M      LSTSEXFPF.
   LSTSEXFP_Y      YEARFMT.
   CMLSEXFP        CMLSEXFP.
   CMFPLAST        CMFMT.
   FPOTHREL        FSEXREL.
   FPEDUC          EDUCFMT.
   FSEXMULT        MULTRACED.
   FSEXRACE        RACEFMTD.
   FSEXHRACE       HRACED.
   FSEXNRACE       NRACED.
   FPRN            CURRREL.
   WHICH1ST        WHICH1ST.
   SEXAFMEN        Y1N5RDF.
   WNSEXAFM_M      WNSEXAFMF.
   WNSEXAFM_Y      YEARFMT.
   CMSEXAFM        CMFSTSEX.
   AGESXAFM        AGE44NRDF.
   AFMEN18         FMT18F.
   AFMEN15         FMT15F.
   AFMEN20         FMT20F.
   LIFEPRT         LIFEPRT.
   LIFEPRT_LO      LIFEPRT.
   LIFEPRT_HI      LIFEPRT.
   PTSB4MAR        PLIFPRTNR.
   PTSB4MAR_LO     PLIFPRTNR.
   PTSB4MAR_HI     PLIFPRTNR.
   MON12PRT        MON12PRT.
   MON12PRT_LO     MON12PRT.
   MON12PRT_HI     MON12PRT.
   PARTS12         PARTS12F.
   LIFEPRTS        LIFEPRTS.
   WHOSNC1Y        Y1N5RDF.
   MATCHFP         Y1N5RDF.
   MATCHHP         MTCHMANF.
   P1YRELP         P1YRELP.
   CMLSEX          CMFMT.
   P1YLSEX_M       MNTHFMT.
   P1YLSEX_Y       YEARFMT.
   P1YCURRP        Y1N5RDF.
   PCURRNT         Y1N5C.
   MATCHFP2        Y1N5RDF.
   MATCHHP2        MTCHMANF.
   P1YRELP2        P1YRELP.
   CMLSEX2         CMFMT.
   P1YLSEX_M2      MNTHFMT.
   P1YLSEX_Y2      YEARFMT.
   P1YCURRP2       Y1N5RDF.
   PCURRNT2        Y1N5C.
   MATCHFP3        Y1N5RDF.
   MATCHHP3        MTCHMANF.
   P1YRELP3        P1YRELP.
   CMLSEX3         CMFMT.
   P1YLSEX_M3      MNTHFMT.
   P1YLSEX_Y3      YEARFMT.
   P1YCURRP3       Y1N5RDF.
   PCURRNT3        Y1N5C.
   P1YOTHREL       FSEXREL.
   P1YRAGE         P1YRAGE.
   P1YHSAGE        P1YHSAGE.
   P1YRF           FSEXREL.
   P1YFSEX_M       P1YFSEXF.
   P1YFSEX_Y       YEARFMT.
   CMFSEX          CMFSEX.
   CMFSEXTOT       CMFMT.
   P1YEDUC         EDUCFMT.
   P1YMULT1        MULTRACED.
   P1YRACE1        RACEFMTD.
   P1YHRACE1       HRACED.
   P1YNRACE1       NRACED.
   P1YRN           CURRREL.
   P1YOTHREL2      FSEXREL.
   P1YRAGE2        P1YRAGE.
   P1YHSAGE2       P1YHSAGE.
   P1YRF2          FSEXREL.
   P1YFSEX_M2      P1YFSEXF.
   P1YFSEX_Y2      YEARFMT.
   CMFSEX2         CMFSEX.
   CMFSEXTOT2      CMFMT.
   P1YEDUC2        EDUCFMT.
   P1YMULT2        MULTRACED.
   P1YRACE2        RACEFMTD.
   P1YHRACE2       HRACED.
   P1YNRACE2       NRACED.
   P1YRN2          CURRREL.
   P1YOTHREL3      FSEXREL.
   P1YRAGE3        P1YRAGE.
   P1YHSAGE3       P1YHSAGE.
   P1YRF3          FSEXREL.
   P1YFSEX_M3      P1YFSEXF.
   P1YFSEX_Y3      YEARFMT.
   CMFSEX3         CMFSEX.
   CMFSEXTOT3      CMFMT.
   P1YEDUC3        EDUCFMT.
   P1YMULT3        MULTRACED.
   P1YRACE3        RACEFMTD.
   P1YHRACE3       HRACED.
   P1YNRACE3       NRACED.
   P1YRN3          CURRREL.
   CURRPRTT        CURRPRTS.
   CURRPRTS        CURRPRTS.
   CMCURRP1        CMFMT.
   CMCURRP2        CMFMT.
   CMCURRP3        CMFMT.
   EVERTUBS        EVERTUBS.
   ESSURE          Y1N5RDF.
   EVERHYST        Y1N5RDF.
   EVEROVRS        Y1N5RDF.
   EVEROTHR        Y1N5RDF.
   WHTOOPRC        WHTOOPRC.
   ONOTFUNC        Y1N5RDF.
   DFNLSTRL        Y1N5RDF.
   ANYTUBAL        Y1N5C.
   HYST            Y1N5C.
   OVAREM          Y1N5C.
   OTHR            Y1N5C.
   ANYFSTER        Y1N5C.
   ANYOPSMN        Y1N5RDF.
   WHATOPSM        WHATOPSM.
   DFNLSTRM        Y1N5RDF.
   ANYMSTER        Y1N5C.
   ANYVAS          Y1N5C.
   OTHRM           Y1N2RECF.
   DATFEMOP_M      MNTHFMT.
   DATFEMOP_Y      YEARFMT.
   CMTUBLIG        CMFMT.
   PLCFEMOP        PLCOPF.
   INPATIEN        Y1N5RDF.
   PAYRSTER1       PAYFMT.
   PAYRSTER2       PAYFMT.
   RHADALL         Y1N5RDF.
   HHADALL         HHADALL.
   FMEDREAS1       FMEDREASF.
   FMEDREAS2       FMEDREASF.
   FMEDREAS3       FMEDREASF.
   FMEDREAS4       FMEDREASF.
   BCREAS          BCREAS.
   BCWHYF          BCWHYFF.
   MINCDNNR        MINCDNF.
   DATFEMOP_M2     MNTHFMT.
   DATFEMOP_Y2     YEARFMT.
   CMHYST          CMFMT.
   PLCFEMOP2       PLCOPF.
   PAYRSTER6       PAYFMT.
   PAYRSTER7       PAYFMT.
   RHADALL2        Y1N5RDF.
   HHADALL2        HHADALL.
   FMEDREAS7       FMEDREASF.
   FMEDREAS8       FMEDREASF.
   FMEDREAS9       FMEDREASF.
   FMEDREAS10      FMEDREASF.
   BCREAS2         BCREAS.
   BCWHYF2         BCWHYFF.
   MINCDNNR2       MINCDNF.
   DATFEMOP_M3     MNTHFMT.
   DATFEMOP_Y3     YEARFMT.
   CMOVAREM        CMFMT.
   PLCFEMOP3       PLCOPF.
   PAYRSTER11      PAYFMT.
   PAYRSTER12      PAYFMT.
   RHADALL3        Y1N5RDF.
   HHADALL3        HHADALL.
   FMEDREAS13      FMEDREASF.
   FMEDREAS14      FMEDREASF.
   FMEDREAS15      FMEDREASF.
   FMEDREAS16      FMEDREASF.
   BCREAS3         BCREAS.
   BCWHYF3         BCWHYFF.
   MINCDNNR3       MINCDNF.
   DATFEMOP_M4     MNTHFMT.
   DATFEMOP_Y4     YEARFMT.
   CMOTSURG        CMFMT.
   PLCFEMOP4       PLCOPF.
   PAYRSTER16      PAYFMT.
   PAYRSTER17      PAYFMT.
   RHADALL4        Y1N5RDF.
   HHADALL4        HHADALL.
   FMEDREAS19      FMEDREASF.
   FMEDREAS20      FMEDREASF.
   FMEDREAS21      FMEDREASF.
   FMEDREAS22      FMEDREASF.
   BCREAS4         BCREAS.
   BCWHYF4         BCWHYFF.
   MINCDNNR4       MINCDNF.
   CMOPER1         CMFMT.
   OPERSAME1       Y1N5RDF.
   OPERSAME2       Y1N5RDF.
   OPERSAME3       Y1N5RDF.
   OPERSAME4       Y1N5RDF.
   OPERSAME5       Y1N5RDF.
   OPERSAME6       Y1N5RDF.
   DATEOPMN_M      MNTHFMT.
   DATEOPMN_Y      YEARFMT.
   CMMALEOP        CMFMT.
   WITHIMOP        Y1N5RDF.
   VASJAN4YR       Y1N5RDF.
   PLACOPMN        PLCOPF.
   PAYMSTER1       PAYFMT.
   PAYMSTER2       PAYFMT.
   RHADALLM        Y1N5RDF.
   HHADALLM        Y1N5RDF.
   MEDREAS1        MEDREASF.
   MEDREAS2        MEDREASF.
   BCREASM         BCREAS.
   BCWHYM          BCWHYFF.
   MINCDNMN        MINCDNF.
   REVSTUBL        Y1N5RDF.
   DATRVSTB_M      MNTHFMT.
   DATRVSTB_Y      YEARFMT.
   CMLIGREV        CMFMT.
   REVSVASX        Y1N5RDF.
   DATRVVEX_M      MNTHFMT.
   DATRVVEX_Y      YEARFMT.
   CMVASREV        CMFMT.
   TUBS            Y1N5C.
   VASECT          Y1N5C.
   RSURGSTR        Y1N5C.
   PSURGSTR        Y1N5C.
   ONLYTBVS        Y1N5C.
   RWANTRVT        DFPRBNAF.
   MANWANTT        DEFPROBF.
   RWANTREV        DEFPROBF.
   MANWANTR        DEFPROBF.
   POSIBLPG        Y1N5RDF.
   REASIMPR        REASR.
   POSIBLMN        Y1N5RDF.
   REASIMPP        REASP.
   CANHAVER        Y1N5RDF.
   REASDIFF1       REASDIFFF.
   REASDIFF2       REASDIFFF.
   REASDIFF3       REASDIFFF.
   REASDIFF4       REASDIFFF.
   REASDIFF5       REASDIFFF.
   CANHAVEM        Y1N5RDF.
   PREGNONO        Y1N5RDF.
   REASNONO1       REASNONOF.
   REASNONO2       REASNONOF.
   REASNONO3       REASNONOF.
   RSTRSTAT        RSTRSTAT.
   PSTRSTAT        RSTRSTAT.
   PILL            Y1N5RDF.
   CONDOM          Y1N5RDF.
   VASECTMY        Y1N5RDF.
   DEPOPROV        Y1N5RDF.
   WIDRAWAL        Y1N5RDF.
   RHYTHM          Y1N5RDF.
   SDAYCBDS        Y1N5RDF.
   TEMPSAFE        Y1N5RDF.
   PATCH           Y1N5RDF.
   RING            Y1N5RDF.
   MORNPILL        Y1N5RDF.
   ECTIMESX        ONETWO2F.
   ECREASON1       ECREASONF.
   ECREASON2       ECREASONF.
   ECREASON3       ECREASONF.
   ECRX            ECRX.
   ECWHERE         PLACE1FMT.
   ECWHEN          ECWHEN.
   OTHRMETH01      OTHRMETHF.
   OTHRMETH02      OTHRMETHF.
   OTHRMETH03      OTHRMETHF.
   OTHRMETH04      OTHRMETHF.
   OTHRMETH05      OTHRMETHF.
   OTHRMETH06      OTHRMETHF.
   OTHRMETH07      OTHRMETHF.
   EVIUDTYP1       EVIUDTYPF.
   EVIUDTYP2       EVIUDTYPF.
   NEWMETH         NEWMETHF.
   EVERUSED        YESNONAF.
   METHDISS        Y1N5RDF.
   METHSTOP01      METHSTOPF.
   METHSTOP02      METHSTOPF.
   METHSTOP03      METHSTOPF.
   METHSTOP04      METHSTOPF.
   METHSTOP05      METHSTOPF.
   METHSTOP06      METHSTOPF.
   METHSTOP07      METHSTOPF.
   METHSTOP08      METHSTOPF.
   METHSTOP09      METHSTOPF.
   METHSTOP10      METHSTOPF.
   REASPILL01      REASMFMT.
   REASPILL02      REASMFMT.
   REASPILL03      REASMFMT.
   REASPILL04      REASMFMT.
   REASPILL05      REASMFMT.
   REASPILL06      REASMFMT.
   STOPPILL1       STOPPILLFMT.
   STOPPILL2       STOPPILLFMT.
   STOPPILL3       STOPPILLFMT.
   STOPPILL4       STOPPILLFMT.
   STOPPILL5       STOPPILLFMT.
   STOPPILL6       STOPPILLFMT.
   REASCOND01      REASMFMT.
   REASCOND02      REASMFMT.
   REASCOND03      REASMFMT.
   REASCOND04      REASMFMT.
   REASCOND05      REASMFMT.
   REASCOND06      REASMFMT.
   REASCOND07      REASMFMT.
   STOPCOND1       STOPCONDFMT.
   STOPCOND2       STOPCONDFMT.
   REASDEPO01      REASMFMT.
   REASDEPO02      REASMFMT.
   REASDEPO03      REASMFMT.
   REASDEPO04      REASMFMT.
   REASDEPO05      REASMFMT.
   REASDEPO06      REASMFMT.
   REASDEPO07      REASMFMT.
   REASDEPO08      REASMFMT.
   STOPDEPO1       STOPDEPOFMT.
   STOPDEPO2       STOPDEPOFMT.
   STOPDEPO3       STOPDEPOFMT.
   STOPDEPO4       STOPDEPOFMT.
   STOPDEPO5       STOPDEPOFMT.
   TYPEIUD_1       IUDTYPE.
   TYPEIUD_2       IUDTYPE.
   REASIUD01       REASMFMT.
   REASIUD02       REASMFMT.
   REASIUD03       REASMFMT.
   REASIUD04       REASMFMT.
   REASIUD05       REASMFMT.
   STOPIUD1        STOPIUDFMT.
   STOPIUD2        STOPIUDFMT.
   STOPIUD3        STOPIUDFMT.
   STOPIUD4        STOPIUDFMT.
   STOPIUD5        STOPIUDFMT.
   FIRSMETH1       FIRSMETHF.
   FIRSMETH2       FIRSMETHF.
   FIRSMETH3       FIRSMETHF.
   FIRSMETH4       FIRSMETHF.
   NUMFIRSM        ONETWOF.
   DRUGDEV         Y1N52D.
   DRUGDEV2        Y1N52D.
   DRUGDEV3        Y1N52D.
   DRUGDEV4        Y1N52D.
   FIRSTIME1       FIRSTIME1F.
   FIRSTIME2       FIRSTIME2F.
   USEFSTSX        USEFSTSX.
   CMFIRSM         CMFMT.
   MTHFSTSX1       FIRSMETHF.
   MTHFSTSX2       FIRSMETHF.
   MTHFSTSX3       FIRSMETHF.
   MTHFSTSX4       FIRSMETHF.
   WNFSTUSE_M      MNTHFMT.
   WNFSTUSE_Y      YEARFMT.
   FMETHPRS        METHPRSF.
   FMETHPRS2       METHPRSF.
   FMETHPRS3       METHPRSF.
   FMETHPRS4       METHPRSF.
   CMFSTUSE        CMFMT.
   AGEFSTUS        AGE44NRDF.
   PLACGOTF        PLACE1FMT.
   PLACGOTF2       PLACE1FMT.
   PLACGOTF3       PLACE1FMT.
   PLACGOTF4       PLACE1FMT.
   USEFRSTS        Y1N5RDF.
   MTHFRSTS1       FIRSMETHF.
   MTHFRSTS2       FIRSMETHF.
   MTHFRSTS3       FIRSMETHF.
   MTHFRSTS4       FIRSMETHF.
   INTR_EC3        Y1N5RDF.
   MONSX           Y1N5RDF.
   MONSX2          Y1N5RDF.
   MONSX3          Y1N5RDF.
   MONSX4          Y1N5RDF.
   MONSX5          Y1N5RDF.
   MONSX6          Y1N5RDF.
   MONSX7          Y1N5RDF.
   MONSX8          Y1N5RDF.
   MONSX9          Y1N5RDF.
   MONSX10         Y1N5RDF.
   MONSX11         Y1N5RDF.
   MONSX12         Y1N5RDF.
   MONSX13         Y1N5RDF.
   MONSX14         Y1N5RDF.
   MONSX15         Y1N5RDF.
   MONSX16         Y1N5RDF.
   MONSX17         Y1N5RDF.
   MONSX18         Y1N5RDF.
   MONSX19         Y1N5RDF.
   MONSX20         Y1N5RDF.
   MONSX21         Y1N5RDF.
   MONSX22         Y1N5RDF.
   MONSX23         Y1N5RDF.
   MONSX24         Y1N5RDF.
   MONSX25         Y1N5RDF.
   MONSX26         Y1N5RDF.
   MONSX27         Y1N5RDF.
   MONSX28         Y1N5RDF.
   MONSX29         Y1N5RDF.
   MONSX30         Y1N5RDF.
   MONSX31         Y1N5RDF.
   MONSX32         Y1N5RDF.
   MONSX33         Y1N5RDF.
   MONSX34         Y1N5RDF.
   MONSX35         Y1N5RDF.
   MONSX36         Y1N5RDF.
   MONSX37         Y1N5RDF.
   MONSX38         Y1N5RDF.
   MONSX39         Y1N5RDF.
   MONSX40         Y1N5RDF.
   MONSX41         Y1N5RDF.
   MONSX42         Y1N5RDF.
   MONSX43         Y1N5RDF.
   MONSX44         Y1N5RDF.
   MONSX45         Y1N5RDF.
   MONSX46         Y1N5RDF.
   MONSX47         Y1N5RDF.
   MONSX48         Y1N5RDF.
   CMSTRTMC        CMFMT.
   CMENDMC         CMFMT.
   INTR_ED4A       Y1N5RDF.
   MC1MONS1        MCMONS.
   MC1SIMSQ        MC1SIMSQ.
   MC1MONS2        MCMONS.
   MC1MONS3        MCMONS.
   DATBEGIN_M      MNTHFMT.
   DATBEGIN_Y      YEARFMT.
   CMDATBEGIN      CMFMT.
   CURRMETH1       METHHXF.
   CURRMETH2       METHHXF.
   CURRMETH3       METHHXF.
   CURRMETH4       METHHXF.
   LSTMONMETH1     METHHXF.
   LSTMONMETH2     METHHXF.
   LSTMONMETH3     METHHXF.
   LSTMONMETH4     METHHXF.
   PILL_12         METHYNF.
   DIAPH_12        METHYNF.
   IUD_12          METHYNF.
   IMPLANT_12      METHYNF.
   DEPO_12         METHYNF.
   CERVC_12        METHYNF.
   MPILL_12        METHYNF.
   PATCH_12        METHYNF.
   RING_12         METHYNF.
   METHX1          METHHXF.
   METHX2          METHHXF.
   METHX3          METHHXF.
   METHX4          METHHXF.
   METHX5          METHHXF.
   METHX6          METHHXF.
   METHX7          METHHXF.
   METHX8          METHHXF.
   METHX9          METHHXF.
   METHX10         METHHXF.
   METHX11         METHHXF.
   METHX12         METHHXF.
   METHX13         METHHXF.
   METHX14         METHHXF.
   METHX15         METHHXF.
   METHX16         METHHXF.
   METHX17         METHHXF.
   METHX18         METHHXF.
   METHX19         METHHXF.
   METHX20         METHHXF.
   METHX21         METHHXF.
   METHX22         METHHXF.
   METHX23         METHHXF.
   METHX24         METHHXF.
   METHX25         METHHXF.
   METHX26         METHHXF.
   METHX27         METHHXF.
   METHX28         METHHXF.
   METHX29         METHHXF.
   METHX30         METHHXF.
   METHX31         METHHXF.
   METHX32         METHHXF.
   METHX33         METHHXF.
   METHX34         METHHXF.
   METHX35         METHHXF.
   METHX36         METHHXF.
   METHX37         METHHXF.
   METHX38         METHHXF.
   METHX39         METHHXF.
   METHX40         METHHXF.
   METHX41         METHHXF.
   METHX42         METHHXF.
   METHX43         METHHXF.
   METHX44         METHHXF.
   METHX45         METHHXF.
   METHX46         METHHXF.
   METHX47         METHHXF.
   METHX48         METHHXF.
   METHX49         METHHXF.
   METHX50         METHHXF.
   METHX51         METHHXF.
   METHX52         METHHXF.
   METHX53         METHHXF.
   METHX54         METHHXF.
   METHX55         METHHXF.
   METHX56         METHHXF.
   METHX57         METHHXF.
   METHX58         METHHXF.
   METHX59         METHHXF.
   METHX60         METHHXF.
   METHX61         METHHXF.
   METHX62         METHHXF.
   METHX63         METHHXF.
   METHX64         METHHXF.
   METHX65         METHHXF.
   METHX66         METHHXF.
   METHX67         METHHXF.
   METHX68         METHHXF.
   METHX69         METHHXF.
   METHX70         METHHXF.
   METHX71         METHHXF.
   METHX72         METHHXF.
   METHX73         METHHXF.
   METHX74         METHHXF.
   METHX75         METHHXF.
   METHX76         METHHXF.
   METHX77         METHHXF.
   METHX78         METHHXF.
   METHX79         METHHXF.
   METHX80         METHHXF.
   METHX81         METHHXF.
   METHX82         METHHXF.
   METHX83         METHHXF.
   METHX84         METHHXF.
   METHX85         METHHXF.
   METHX86         METHHXF.
   METHX87         METHHXF.
   METHX88         METHHXF.
   METHX89         METHHXF.
   METHX90         METHHXF.
   METHX91         METHHXF.
   METHX92         METHHXF.
   METHX93         METHHXF.
   METHX94         METHHXF.
   METHX95         METHHXF.
   METHX96         METHHXF.
   METHX97         METHHXF.
   METHX98         METHHXF.
   METHX99         METHHXF.
   METHX100        METHHXF.
   METHX101        METHHXF.
   METHX102        METHHXF.
   METHX103        METHHXF.
   METHX104        METHHXF.
   METHX105        METHHXF.
   METHX106        METHHXF.
   METHX107        METHHXF.
   METHX108        METHHXF.
   METHX109        METHHXF.
   METHX110        METHHXF.
   METHX111        METHHXF.
   METHX112        METHHXF.
   METHX113        METHHXF.
   METHX114        METHHXF.
   METHX115        METHHXF.
   METHX116        METHHXF.
   METHX117        METHHXF.
   METHX118        METHHXF.
   METHX119        METHHXF.
   METHX120        METHHXF.
   METHX121        METHHXF.
   METHX122        METHHXF.
   METHX123        METHHXF.
   METHX124        METHHXF.
   METHX125        METHHXF.
   METHX126        METHHXF.
   METHX127        METHHXF.
   METHX128        METHHXF.
   METHX129        METHHXF.
   METHX130        METHHXF.
   METHX131        METHHXF.
   METHX132        METHHXF.
   METHX133        METHHXF.
   METHX134        METHHXF.
   METHX135        METHHXF.
   METHX136        METHHXF.
   METHX137        METHHXF.
   METHX138        METHHXF.
   METHX139        METHHXF.
   METHX140        METHHXF.
   METHX141        METHHXF.
   METHX142        METHHXF.
   METHX143        METHHXF.
   METHX144        METHHXF.
   METHX145        METHHXF.
   METHX146        METHHXF.
   METHX147        METHHXF.
   METHX148        METHHXF.
   METHX149        METHHXF.
   METHX150        METHHXF.
   METHX151        METHHXF.
   METHX152        METHHXF.
   METHX153        METHHXF.
   METHX154        METHHXF.
   METHX155        METHHXF.
   METHX156        METHHXF.
   METHX157        METHHXF.
   METHX158        METHHXF.
   METHX159        METHHXF.
   METHX160        METHHXF.
   METHX161        METHHXF.
   METHX162        METHHXF.
   METHX163        METHHXF.
   METHX164        METHHXF.
   METHX165        METHHXF.
   METHX166        METHHXF.
   METHX167        METHHXF.
   METHX168        METHHXF.
   METHX169        METHHXF.
   METHX170        METHHXF.
   METHX171        METHHXF.
   METHX172        METHHXF.
   METHX173        METHHXF.
   METHX174        METHHXF.
   METHX175        METHHXF.
   METHX176        METHHXF.
   METHX177        METHHXF.
   METHX178        METHHXF.
   METHX179        METHHXF.
   METHX180        METHHXF.
   METHX181        METHHXF.
   METHX182        METHHXF.
   METHX183        METHHXF.
   METHX184        METHHXF.
   METHX185        METHHXF.
   METHX186        METHHXF.
   METHX187        METHHXF.
   METHX188        METHHXF.
   METHX189        METHHXF.
   METHX190        METHHXF.
   METHX191        METHHXF.
   METHX192        METHHXF.
   NUMMULTX1       ONETWOF.
   NUMMULTX2       ONETWOF.
   NUMMULTX3       ONETWOF.
   NUMMULTX4       ONETWOF.
   NUMMULTX5       ONETWOF.
   NUMMULTX6       ONETWOF.
   NUMMULTX7       ONETWOF.
   NUMMULTX8       ONETWOF.
   NUMMULTX9       ONETWOF.
   NUMMULTX10      ONETWOF.
   NUMMULTX11      ONETWOF.
   NUMMULTX12      ONETWOF.
   NUMMULTX13      ONETWOF.
   NUMMULTX14      ONETWOF.
   NUMMULTX15      ONETWOF.
   NUMMULTX16      ONETWOF.
   NUMMULTX17      ONETWOF.
   NUMMULTX18      ONETWOF.
   NUMMULTX19      ONETWOF.
   NUMMULTX20      ONETWOF.
   NUMMULTX21      ONETWOF.
   NUMMULTX22      ONETWOF.
   NUMMULTX23      ONETWOF.
   NUMMULTX24      ONETWOF.
   NUMMULTX25      ONETWOF.
   NUMMULTX26      ONETWOF.
   NUMMULTX27      ONETWOF.
   NUMMULTX28      ONETWOF.
   NUMMULTX29      ONETWOF.
   NUMMULTX30      ONETWOF.
   NUMMULTX31      ONETWOF.
   NUMMULTX32      ONETWOF.
   NUMMULTX33      ONETWOF.
   NUMMULTX34      ONETWOF.
   NUMMULTX35      ONETWOF.
   NUMMULTX36      ONETWOF.
   NUMMULTX37      ONETWOF.
   NUMMULTX38      ONETWOF.
   NUMMULTX39      ONETWOF.
   NUMMULTX40      ONETWOF.
   NUMMULTX41      ONETWOF.
   NUMMULTX42      ONETWOF.
   NUMMULTX43      ONETWOF.
   NUMMULTX44      ONETWOF.
   NUMMULTX45      ONETWOF.
   NUMMULTX46      ONETWOF.
   NUMMULTX47      ONETWOF.
   NUMMULTX48      ONETWOF.
   SALMX1          N0Y1F.
   SALMX2          N0Y1F.
   SALMX3          N0Y1F.
   SALMX4          N0Y1F.
   SALMX5          N0Y1F.
   SALMX6          N0Y1F.
   SALMX7          N0Y1F.
   SALMX8          N0Y1F.
   SALMX9          N0Y1F.
   SALMX10         N0Y1F.
   SALMX11         N0Y1F.
   SALMX12         N0Y1F.
   SALMX13         N0Y1F.
   SALMX14         N0Y1F.
   SALMX15         N0Y1F.
   SALMX16         N0Y1F.
   SALMX17         N0Y1F.
   SALMX18         N0Y1F.
   SALMX19         N0Y1F.
   SALMX20         N0Y1F.
   SALMX21         N0Y1F.
   SALMX22         N0Y1F.
   SALMX23         N0Y1F.
   SALMX24         N0Y1F.
   SALMX25         N0Y1F.
   SALMX26         N0Y1F.
   SALMX27         N0Y1F.
   SALMX28         N0Y1F.
   SALMX29         N0Y1F.
   SALMX30         N0Y1F.
   SALMX31         N0Y1F.
   SALMX32         N0Y1F.
   SALMX33         N0Y1F.
   SALMX34         N0Y1F.
   SALMX35         N0Y1F.
   SALMX36         N0Y1F.
   SALMX37         N0Y1F.
   SALMX38         N0Y1F.
   SALMX39         N0Y1F.
   SALMX40         N0Y1F.
   SALMX41         N0Y1F.
   SALMX42         N0Y1F.
   SALMX43         N0Y1F.
   SALMX44         N0Y1F.
   SALMX45         N0Y1F.
   SALMX46         N0Y1F.
   SALMX47         N0Y1F.
   SALMX48         N0Y1F.
   SAYX1           N0Y1F.
   SAYX2           N0Y1F.
   SAYX3           N0Y1F.
   SAYX4           N0Y1F.
   SAYX5           N0Y1F.
   SAYX6           N0Y1F.
   SAYX7           N0Y1F.
   SAYX8           N0Y1F.
   SAYX9           N0Y1F.
   SAYX10          N0Y1F.
   SAYX11          N0Y1F.
   SAYX12          N0Y1F.
   SAYX13          N0Y1F.
   SAYX14          N0Y1F.
   SAYX15          N0Y1F.
   SAYX16          N0Y1F.
   SAYX17          N0Y1F.
   SAYX18          N0Y1F.
   SAYX19          N0Y1F.
   SAYX20          N0Y1F.
   SAYX21          N0Y1F.
   SAYX22          N0Y1F.
   SAYX23          N0Y1F.
   SAYX24          N0Y1F.
   SAYX25          N0Y1F.
   SAYX26          N0Y1F.
   SAYX27          N0Y1F.
   SAYX28          N0Y1F.
   SAYX29          N0Y1F.
   SAYX30          N0Y1F.
   SAYX31          N0Y1F.
   SAYX32          N0Y1F.
   SAYX33          N0Y1F.
   SAYX34          N0Y1F.
   SAYX35          N0Y1F.
   SAYX36          N0Y1F.
   SAYX37          N0Y1F.
   SAYX38          N0Y1F.
   SAYX39          N0Y1F.
   SAYX40          N0Y1F.
   SAYX41          N0Y1F.
   SAYX42          N0Y1F.
   SAYX43          N0Y1F.
   SAYX44          N0Y1F.
   SAYX45          N0Y1F.
   SAYX46          N0Y1F.
   SAYX47          N0Y1F.
   SAYX48          N0Y1F.
   SIMSEQX1        MC1SIMSQ.
   SIMSEQX2        MC1SIMSQ.
   SIMSEQX3        MC1SIMSQ.
   SIMSEQX4        MC1SIMSQ.
   SIMSEQX5        MC1SIMSQ.
   SIMSEQX6        MC1SIMSQ.
   SIMSEQX7        MC1SIMSQ.
   SIMSEQX8        MC1SIMSQ.
   SIMSEQX9        MC1SIMSQ.
   SIMSEQX10       MC1SIMSQ.
   SIMSEQX11       MC1SIMSQ.
   SIMSEQX12       MC1SIMSQ.
   SIMSEQX13       MC1SIMSQ.
   SIMSEQX14       MC1SIMSQ.
   SIMSEQX15       MC1SIMSQ.
   SIMSEQX16       MC1SIMSQ.
   SIMSEQX17       MC1SIMSQ.
   SIMSEQX18       MC1SIMSQ.
   SIMSEQX19       MC1SIMSQ.
   SIMSEQX20       MC1SIMSQ.
   SIMSEQX21       MC1SIMSQ.
   SIMSEQX22       MC1SIMSQ.
   SIMSEQX23       MC1SIMSQ.
   SIMSEQX24       MC1SIMSQ.
   SIMSEQX25       MC1SIMSQ.
   SIMSEQX26       MC1SIMSQ.
   SIMSEQX27       MC1SIMSQ.
   SIMSEQX28       MC1SIMSQ.
   SIMSEQX29       MC1SIMSQ.
   SIMSEQX30       MC1SIMSQ.
   SIMSEQX31       MC1SIMSQ.
   SIMSEQX32       MC1SIMSQ.
   SIMSEQX33       MC1SIMSQ.
   SIMSEQX34       MC1SIMSQ.
   SIMSEQX35       MC1SIMSQ.
   SIMSEQX36       MC1SIMSQ.
   SIMSEQX37       MC1SIMSQ.
   SIMSEQX38       MC1SIMSQ.
   SIMSEQX39       MC1SIMSQ.
   SIMSEQX40       MC1SIMSQ.
   SIMSEQX41       MC1SIMSQ.
   SIMSEQX42       MC1SIMSQ.
   SIMSEQX43       MC1SIMSQ.
   SIMSEQX44       MC1SIMSQ.
   SIMSEQX45       MC1SIMSQ.
   SIMSEQX46       MC1SIMSQ.
   SIMSEQX47       MC1SIMSQ.
   SIMSEQX48       MC1SIMSQ.
   USELSTP         Y1N5RDF.
   LSTMTHP1        FIRSMETHF.
   LSTMTHP2        FIRSMETHF.
   LSTMTHP3        FIRSMETHF.
   LSTMTHP4        FIRSMETHF.
   USEFSTP         Y1N5RDF.
   FSTMTHP1        FIRSMETHF.
   FSTMTHP2        FIRSMETHF.
   FSTMTHP3        FIRSMETHF.
   FSTMTHP4        FIRSMETHF.
   USELSTP2        Y1N5RDF.
   LSTMTHP5        FIRSMETHF.
   LSTMTHP6        FIRSMETHF.
   LSTMTHP7        FIRSMETHF.
   LSTMTHP8        FIRSMETHF.
   USEFSTP2        Y1N5RDF.
   FSTMTHP5        FIRSMETHF.
   FSTMTHP6        FIRSMETHF.
   FSTMTHP7        FIRSMETHF.
   FSTMTHP8        FIRSMETHF.
   USELSTP3        Y1N5RDF.
   LSTMTHP9        FIRSMETHF.
   LSTMTHP10       FIRSMETHF.
   LSTMTHP11       FIRSMETHF.
   LSTMTHP12       FIRSMETHF.
   USEFSTP3        Y1N5RDF.
   FSTMTHP9        FIRSMETHF.
   FSTMTHP10       FIRSMETHF.
   FSTMTHP11       FIRSMETHF.
   FSTMTHP12       FIRSMETHF.
   WYNOTUSE        Y1N5RDF.
   HPPREGQ         HPPREGQ.
   DURTRY_N        DURTRY_N.
   DURTRY_P        DURTRY_P.
   WHYNOUSING1     WHYNOUSNG.
   WHYNOUSING2     WHYNOUSNG.
   WHYNOUSING3     WHYNOUSNG.
   WHYNOUSING4     WHYNOUSNG.
   WHYNOUSING5     WHYNOUSNG.
   WHYNOTPG1       WHYNOTPGF.
   WHYNOTPG2       WHYNOTPGF.
   MAINNOUSE       MAINNOUSE.
   YUSEPILL1       YUSEPILLF.
   YUSEPILL2       YUSEPILLF.
   YUSEPILL3       YUSEPILLF.
   YUSEPILL4       YUSEPILLF.
   YUSEPILL5       YUSEPILLF.
   YUSEPILL6       YUSEPILLF.
   YUSEPILL7       YUSEPILLF.
   IUDTYPE         IUDTYPE.
   PST4WKSX        PSTWKSF.
   PSWKCOND1       Y1N5RDF.
   PSWKCOND2       PSTWKSF.
   COND1BRK        Y1N5RDF.
   COND1OFF        Y1N5RDF.
   CONDBRFL        CONDTMS.
   CONDOFF         CONDTMS.
   MISSPILL        MISSPILL.
   P12MOCON        P12MOCON.
   PXNOFREQ        P12METHF.
   BTHCON12        Y1N5RDF.
   MEDTST12        Y1N5RDF.
   BCCNS12         Y1N5RDF.
   STEROP12        Y1N5RDF.
   STCNS12         Y1N5RDF.
   EMCON12         Y1N5RDF.
   ECCNS12         Y1N5RDF.
   NUMMTH12        NUMMTH12A.
   PRGTST12        Y1N5RDF.
   ABORT12         Y1N5RDF.
   PAP12           Y1N5RDF.
   PELVIC12        Y1N5RDF.
   PRENAT12        Y1N5RDF.
   PARTUM12        Y1N5RDF.
   STDSVC12        Y1N5RDF.
   BARRIER1        BARRIERF.
   BARRIER2        BARRIERF.
   BARRIER3        BARRIERF.
   BARRIER4        BARRIERF.
   NUMSVC12        NUMSVC12A.
   NUMBCVIS        NUMBCVIS.
   BC12PLCX        BCPLCF.
   BC12PLCX2       BCPLCF.
   BC12PLCX3       BCPLCF.
   BC12PLCX4       BCPLCF.
   BC12PLCX5       BCPLCF.
   BC12PLCX6       BCPLCF.
   BC12PLCX7       BCPLCF.
   BC12PLCX8       BCPLCF.
   BC12PLCX9       BCPLCF.
   BC12PLCX10      BCPLCF.
   BC12PLCX11      BCPLCF.
   BC12PLCX12      BCPLCF.
   BC12PLCX13      BCPLCF.
   BC12PLCX14      BCPLCF.
   BC12PLCX15      BCPLCF.
   IDCLINIC        IDCLINIC.
   PGTSTBC2        Y1N5RDF.
   PAPPLBC2        Y1N5RDF.
   PAPPELEC        Y1N5RDF.
   STDTSCON        Y1N5RDF.
   WHYPSTD         WHYPSTDF.
   BC12PAYX1       PAYFMT.
   BC12PAYX2       PAYFMT.
   BC12PAYX3       PAYFMT.
   BC12PAYX4       PAYFMT.
   BC12PAYX7       PAYFMT.
   BC12PAYX8       PAYFMT.
   BC12PAYX9       PAYFMT.
   BC12PAYX10      PAYFMT.
   BC12PAYX13      PAYFMT.
   BC12PAYX14      PAYFMT.
   BC12PAYX15      PAYFMT.
   BC12PAYX16      PAYFMT.
   BC12PAYX19      PAYFMT.
   BC12PAYX20      PAYFMT.
   BC12PAYX21      PAYFMT.
   BC12PAYX22      PAYFMT.
   BC12PAYX25      PAYFMT.
   BC12PAYX26      PAYFMT.
   BC12PAYX27      PAYFMT.
   BC12PAYX28      PAYFMT.
   BC12PAYX31      PAYFMT.
   BC12PAYX32      PAYFMT.
   BC12PAYX33      PAYFMT.
   BC12PAYX34      PAYFMT.
   BC12PAYX37      PAYFMT.
   BC12PAYX38      PAYFMT.
   BC12PAYX39      PAYFMT.
   BC12PAYX40      PAYFMT.
   BC12PAYX43      PAYFMT.
   BC12PAYX44      PAYFMT.
   BC12PAYX45      PAYFMT.
   BC12PAYX46      PAYFMT.
   BC12PAYX49      PAYFMT.
   BC12PAYX50      PAYFMT.
   BC12PAYX51      PAYFMT.
   BC12PAYX52      PAYFMT.
   BC12PAYX55      PAYFMT.
   BC12PAYX56      PAYFMT.
   BC12PAYX57      PAYFMT.
   BC12PAYX58      PAYFMT.
   BC12PAYX61      PAYFMT.
   BC12PAYX62      PAYFMT.
   BC12PAYX63      PAYFMT.
   BC12PAYX64      PAYFMT.
   BC12PAYX67      PAYFMT.
   BC12PAYX68      PAYFMT.
   BC12PAYX69      PAYFMT.
   BC12PAYX70      PAYFMT.
   BC12PAYX73      PAYFMT.
   BC12PAYX74      PAYFMT.
   BC12PAYX75      PAYFMT.
   BC12PAYX76      PAYFMT.
   BC12PAYX79      PAYFMT.
   BC12PAYX80      PAYFMT.
   BC12PAYX81      PAYFMT.
   BC12PAYX82      PAYFMT.
   BC12PAYX85      PAYFMT.
   BC12PAYX86      PAYFMT.
   BC12PAYX87      PAYFMT.
   BC12PAYX88      PAYFMT.
   REGCAR12_F_01   REGCAR12F.
   REGCAR12_F_02   REGCAR12F.
   REGCAR12_F_03   REGCAR12F.
   REGCAR12_F_04   REGCAR12F.
   REGCAR12_F_05   REGCAR12F.
   REGCAR12_F_06   REGCAR12F.
   REGCAR12_F_07   REGCAR12F.
   REGCAR12_F_08   REGCAR12F.
   REGCAR12_F_09   REGCAR12F.
   REGCAR12_F_10   REGCAR12F.
   REGCAR12_F_11   REGCAR12F.
   REGCAR12_F_12   REGCAR12F.
   REGCAR12_F_13   REGCAR12F.
   REGCAR12_F_14   REGCAR12F.
   REGCAR12_F_15   REGCAR12F.
   DRUGDEVE        DRUGDEVE.
   FSTSVC12        Y1N5RDF.
   WNFSTSVC_M      MNTHFMT.
   WNFSTSVC_Y      YEARFMT.
   CMFSTSVC        CMFMT.
   B4AFSTIN        BFAFTF.
   TMAFTIN         TMAFTIN.
   FSTSERV1        FSTSERVF.
   FSTSERV2        FSTSERVF.
   FSTSERV3        FSTSERVF.
   FSTSERV4        FSTSERVF.
   FSTSERV5        FSTSERVF.
   FSTSERV6        FSTSERVF.
   BCPLCFST        BCPLCF.
   EVERFPC         Y1N5RDF.
   KNDMDHLP01      KNDMDHLPF.
   KNDMDHLP02      KNDMDHLPF.
   KNDMDHLP03      KNDMDHLPF.
   KNDMDHLP04      KNDMDHLPF.
   KNDMDHLP05      KNDMDHLPF.
   KNDMDHLP06      KNDMDHLPF.
   KNDMDHLP07      KNDMDHLPF.
   KNDMDHLP08      KNDMDHLPF.
   LASTPAP         LASTPAP.
   MREASPAP        MREASFMT.
   AGEFPAP         AGEFPAP.
   AGEFPAP2        AGEF2F.
   ABNPAP3         ABNPAP3F.
   INTPAP          INTOFTF.
   PELWPAP         Y1N5RDF.
   LASTPEL         LASTPEL.
   MREASPEL        MREASFMT.
   AGEFPEL         AGEFPEL.
   AGEPEL2         AGEF2F.
   INTPEL          INTOFTF.
   EVHPVTST        Y1N5RDF.
   HPVWPAP         Y1N5RDF.
   LASTHPV         LASTHPV.
   MREASHPV        MREASFMT.
   AGEFHPV         AGEFHPV.
   AGEHPV2         AGEF2F.
   INTHPV          INTOFTF.
   RWANT           Y1N5RDF.
   PROBWANT        PROBWANT.
   PWANT           DEFPROBF.
   JINTEND         Y1N5RDF.
   JSUREINT        SUREINTCHP.
   JINTENDN        INTEXPF.
   JEXPECTL        INTEXPF.
   JEXPECTS        JEXPECTS.
   JINTNEXT        INTNEXT.
   INTEND          Y1N5RDF.
   SUREINT         SUREINTCHP.
   INTENDN         INTEXPF.
   EXPECTL         INTEXPF.
   EXPECTS         JEXPECTS.
   INTNEXT         INTNEXT.
   HLPPRG          Y1N5RDF.
   HOWMANYR        HOWMANYR.
   SEEKWHO1        SEEKWHO1F.
   SEEKWHO2        Y1N5RDF.
   TYPALLPG1       TYPALLPGF.
   TYPALLPG2       TYPALLPGF.
   TYPALLPG3       TYPALLPGF.
   TYPALLPG4       TYPALLPGF.
   TYPALLPG5       TYPALLPGF.
   TYPALLPG6       TYPALLPGF.
   WHOTEST         WHOTEST.
   WHARTIN         WHARTIN.
   OTMEDHEP1       OTMEDHEPF.
   OTMEDHEP2       OTMEDHEPF.
   OTMEDHEP3       OTMEDHEPF.
   OTMEDHEP4       OTMEDHEPF.
   INSCOVPG        Y1N5RDF.
   FSTHLPPG_M      MNTHFMT.
   FSTHLPPG_Y      YEARFMT.
   CMPGVIS1        CMFMT.
   TRYLONG2        TRYLONG2F.
   UNIT_TRYLONG    UNIT_TRYLONG.
   HLPPGNOW        Y1N5RDF.
   RCNTPGH_M       RCNTPGHF.
   RCNTPGH_Y       YEARFMT.
   CMPGVISL        CMPGVISL.
   NUMVSTPG        NUMVSTPG.
   PRGVISIT        PRGVISIT.
   HLPMC           Y1N5RDF.
   TYPALLMC1       TYPALLMCF.
   TYPALLMC2       TYPALLMCF.
   TYPALLMC3       TYPALLMCF.
   TYPALLMC4       TYPALLMCF.
   TYPALLMC5       TYPALLMCF.
   TYPALLMC6       TYPALLMCF.
   MISCNUM         TPRGMISS.
   INFRTPRB1       INFRTPRBF.
   INFRTPRB2       INFRTPRBF.
   INFRTPRB3       INFRTPRBF.
   INFRTPRB4       INFRTPRBF.
   INFRTPRB5       INFRTPRBF.
   DUCHFREQ        DUCHFREQ.
   PID             Y1N5RDF.
   PIDSYMPT        Y1N5RDF.
   PIDTX           PIDTX.
   LSTPIDTX_M      MNTHFMT.
   LSTPIDTX_Y      YEARFMT.
   CMPIDLST        CMFMT.
   DIABETES        DIABETES.
   GESTDIAB        Y1N5RDF.
   UF              Y1N5RDF.
   ENDO            Y1N5RDF.
   OVUPROB         Y1N5RDF.
   DEAF            Y1N5RDF.
   BLIND           Y1N5RDF.
   DIFDECIDE       Y1N5RDF.
   DIFWALK         Y1N5RDF.
   DIFDRESS        Y1N5RDF.
   DIFOUT          Y1N5RDF.
   EVRCANCER       Y1N5RDF.
   AGECANCER       AGECANCER.
   CANCTYPE        CANCTYPE.
   PRECANCER       PRECANCER.
   MAMMOG          Y1N5RDF.
   AGEMAMM1        AGEMAM1F.
   REASMAMM1       REASMAMF.
   FAMHYST         Y1N5RDF.
   FAMRISK         RISKF.
   PILLRISK        RISKF.
   ALCORISK        RISKF.
   CANCFUTR        LKNLK1FMT.
   CANCWORRY       AGDGFMT.
   DONBLOOD        Y1N5RDF.
   HIVTEST         Y1N5RDF.
   NOHIVTST        NOHIVTST.
   WHENHIV_M       MNTHFMT.
   WHENHIV_Y       YEARFMT.
   CMHIVTST        CMFMT.
   HIVTSTYR        Y1N5RDF.
   HIVRESULT       Y1N5RDF.
   WHYNOGET        WHYNOGET.
   PLCHIV          PLCHIV.
   RHHIVT1         Y1N5RDF.
   RHHIVT21        RHHIVT2F.
   RHHIVT22        RHHIVT2F.
   HIVTST          HIVTST.
   WHOSUGG         WHOSUGG.
   TALKDOCT        Y1N5RDF.
   AIDSTALK01      AIDSTALKF.
   AIDSTALK02      AIDSTALKF.
   AIDSTALK03      AIDSTALKF.
   AIDSTALK04      AIDSTALKF.
   AIDSTALK05      AIDSTALKF.
   AIDSTALK06      AIDSTALKF.
   AIDSTALK07      AIDSTALKF.
   AIDSTALK08      AIDSTALKF.
   AIDSTALK09      AIDSTALKF.
   AIDSTALK10      AIDSTALKF.
   AIDSTALK11      AIDSTALKF.
   RETROVIR        RETROVIR.
   PREGHIV         PREGHIV.
   EVERVACC        Y1N5RDF.
   HPVSHOT1        AGE25NRDF.
   HPVSEX1         HPVSEX1F.
   VACCPROB        LKNLK2FMT.
   USUALCAR        Y1N5RDF.
   USLPLACE        USLPLACE.
   USL12MOS        Y1N5RDF.
   COVER12         Y1N5RDF.
   NUMNOCOV        NUMNOCOV.
   COVERHOW01      COVERHOWF.
   COVERHOW02      COVERHOWF.
   COVERHOW03      COVERHOWF.
   COVERHOW04      COVERHOWF.
   NOWCOVER01      NOWCOVERF.
   NOWCOVER02      NOWCOVERF.
   NOWCOVER03      NOWCOVERF.
   PARINSUR        Y1N5RDF.
   SAMEADD         Y1N5RDF.
   CNTRY10         Y1N5RDF.
   BRNOUT          Y1N5RDF.
   YRSTRUS         YRSTRUS.
   RELRAISD        RELCURR.
   ATTND14         ATTNDF.
   RELCURR         RELCURR.
   RELTRAD         RELTRAD.
   FUNDAM1         FUNDAMF.
   FUNDAM2         FUNDAMF.
   FUNDAM3         FUNDAMF.
   FUNDAM4         FUNDAMF.
   RELDLIFE        RELDLIFE.
   ATTNDNOW        ATTNDF.
   WRK12MOS        WRK12MOS.
   FPT12MOS        FPT12MOS.
   DOLASTWK1       DOLASTWK.
   DOLASTWK2       DOLASTWK.
   DOLASTWK3       DOLASTWK.
   DOLASTWK4       DOLASTWK.
   DOLASTWK5       DOLASTWK.
   RWRKST          Y1N5C.
   WORKP12         Y1N5C.
   RPAYJOB         Y1N5RDF.
   RNUMJOB         NUMJOBF.
   RFTPTX          TMWK12MO.
   REARNTY         Y1N5C.
   SPLSTWK1        SPLSTWKF.
   SPLSTWK2        SPLSTWKF.
   SPLSTWK3        SPLSTWKF.
   SPLSTWK4        SPLSTWKF.
   SPLSTWK5        SPLSTWKF.
   SPWRKST         Y1N5C.
   SPPAYJOB        Y1N5RDF.
   SPNUMJOB        NUMJOBF.
   SPFTPTX         TMWK12MO.
   SPEARNTY        Y1N5C.
   STAYTOG         AGDGFMT.
   SAMESEX         AGDGFMT.
   SXOK18          AGDGFMT.
   SXOK16          AGDGFMT.
   CHUNLESS        AGDGFMT.
   CHSUPPOR        AGDGFMT.
   GAYADOPT        AGDGFMT.
   OKCOHAB         AGDGFMT.
   REACTSLF        REACTSLF.
   CHBOTHER        CHBOTHER.
   MARRFAIL        AGDGFMT.
   CHCOHAB         AGDGFMT.
   PRVNTDIV        AGDGFMT.
   LESSPLSR        NOCHCHF.
   EMBARRAS        NOCHCHF.
   ACASILANG       ACASILANG.
   GENHEALT        GENHEALT.
   INCHES          INCHES.
   RWEIGHT         RWEIGHT.
   BMI             BMI.
   ENGSPEAK        ENGSPEAK.
   CASIBIRTH       CASINUM.
   CASILOSS        CASINUM.
   CASIABOR        CASINUM.
   CASIADOP        YESNONAF.
   EVSUSPEN        YESNONAF.
   GRADSUSP        CASIGRAD.
   SMK100          YESNONAF.
   AGESMK          CASISMK.
   SMOKE12         SMOKE12F.
   DRINK12         DRINKF.
   UNIT30D         UNIT30D.
   DRINK30D        DRNK30D.
   DRINKDAY        DRNKNUM.
   BINGE30         BNGE30T.
   DRNKMOST        DRNKNUM.
   BINGE12         DRINKF.
   POT12           POTFRF.
   COC12           DRUGFRF.
   CRACK12         DRUGFRF.
   CRYSTMTH12      DRUGFRF.
   INJECT12        DRUGFRF.
   VAGSEX          YESNONAF.
   AGEVAGR         AG95NRDF.
   AGEVAGM         AG95NRDF.
   CONDVAG         YESNONAF.
   WHYCONDL        WHYCONDL.
   GETORALM        YESNONAF.
   GIVORALM        YESNONAF.
   CONDFELL        YESNONAF.
   ANYORAL         Y1N5NAC.
   TIMING          TIMING.
   ANALSEX         YESNONAF.
   CONDANAL        YESNONAF.
   OPPSEXANY       Y1N5NAC.
   OPPSEXGEN       Y1N5NAC.
   CONDSEXL        YESNONAF.
   WANTSEX1        WANTSEXF.
   VOLSEX1         VOLSEX1F.
   HOWOLD          AG95NRDF.
   GIVNDRUG        YESNONAF.
   HEBIGOLD        YESNONAF.
   ENDRELAT        YESNONAF.
   WORDPRES        YESNONAF.
   THRTPHYS        YESNONAF.
   PHYSHURT        YESNONAF.
   HELDDOWN        YESNONAF.
   EVRFORCD        YESNONAF.
   AGEFORC1        AG95NRDF.
   GIVNDRG2        YESNONAF.
   HEBIGOL2        YESNONAF.
   ENDRELA2        YESNONAF.
   WRDPRES2        YESNONAF.
   THRTPHY2        YESNONAF.
   PHYSHRT2        YESNONAF.
   HELDDWN2        YESNONAF.
   PARTSLIF_1      PARTLIF.
   PARTSLFV        YESNONAF.
   PARTSLIF_2      PARTLIF.
   OPPLIFENUM      PARTLIF.
   PARTS12M_1      PRTS12MB.
   PARTS12V        YESNONAF.
   PARTS12M_2      PRTS12MB.
   OPPYEARNUM      PRTS12MB.
   NEWYEAR         PRT12F.
   NEWLIFE         PRT12F.
   VAGNUM12        PRT12F.
   ORALNUM12       PRT12F.
   ANALNUM12       PRT12F.
   CURRPAGE        AG95NRDF.
   RELAGE          RELAGENAF.
   HOWMUCH         HOWMUCHF.
   CURRPAGE2       AG95NRDF.
   RELAGE2         RELAGENAF.
   HOWMUCH2        HOWMUCHF.
   CURRPAGE3       AG95NRDF.
   RELAGE3         RELAGENAF.
   HOWMUCH3        HOWMUCHF.
   BISEXPRT        YESNONAF.
   NONMONOG        YESNONAF.
   NNONMONOG1      NNONMONOG1F.
   NNONMONOG2      NNONMONOG2F.
   NNONMONOG3      NNONMONOG2F.
   MALSHT12        YESNONAF.
   PROSTFRQ        YESNONAF.
   JOHNFREQ        YESNONAF.
   HIVMAL12        YESNONAF.
   GIVORALF        YESNONAF.
   GETORALF        YESNONAF.
   FEMSEX          YESNONAF.
   SAMESEXANY      Y1N5NAC.
   FEMPARTS_1      PRT12F.
   FEMLIFEV        YESNONAF.
   FEMPARTS_2      PRT12F.
   SAMLIFENUM      PRT12F.
   FEMPRT12_1      PRT12F.
   FEM12V          YESNONAF.
   FEMPRT12_2      PRT12F.
   SAMYEARNUM      PRT12F.
   SAMESEX1        SAMESEX1F.
   MFLASTP         MALFEMNAF.
   ATTRACT         ATTRACT.
   ORIENT          ORIENT.
   CONFCONC        YESNONAF.
   TIMALON         TIMALON.
   RISKCHEK1       YESNONAF.
   RISKCHEK2       YESNONAF.
   RISKCHEK3       YESNONAF.
   RISKCHEK4       YESNONAF.
   CHLAMTST        YESNONAF.
   STDOTHR12       YESNONAF.
   STDTRT12        YESNONAF.
   GON             YESNONAF.
   CHLAM           YESNONAF.
   HERPES          YESNONAF.
   GENWARTS        YESNONAF.
   SYPHILIS        YESNONAF.
   EVRINJECT       YESNONAF.
   EVRSHARE        YESNONAF.
   EARNTYPE        INCWMYF.
   EARN            EARN.
   EARNDK1         YESNONAF.
   EARNDK2         YESNONAF.
   EARNDK3         YESNONAF.
   EARNDK4         YESNONAF.
   WAGE            YESNONAF.
   SELFINC         YESNONAF.
   SOCSEC          YESNONAF.
   DISABIL         YESNONAF.
   RETIRE          YESNONAF.
   SSI             YESNONAF.
   UNEMP           YESNONAF.
   CHLDSUPP        YESNONAF.
   INTEREST        YESNONAF.
   DIVIDEND        YESNONAF.
   OTHINC          YESNONAF.
   TOINCWMY        INCWMYF.
   TOTINC          EARN.
   FMINCDK1        FMINCDK1F.
   FMINCDK2        YESNONAF.
   FMINCDK3        YESNONAF.
   FMINCDK4        YESNONAF.
   FMINCDK5        YESNONAF.
   PUBASST         YESNONAF.
   PUBASTYP1       P_ASTYP.
   FOODSTMP        YESNONAF.
   WIC             YESNONAF.
   HLPTRANS        YESNONAF.
   HLPCHLDC        YESNONAF.
   HLPJOB          YESNONAF.
   FREEFOOD        YESNONAF.
   HUNGRY          YESNONAF.
   MED_COST        YESNONAF.
   AGER            AGERFF.
   FMARITAL        FMARITAL.
   RMARITAL        RMARITAL.
   EDUCAT          EDUCAT.
   HIEDUC          HIEDUC.
   HISPANIC        HISPANIC.
   NUMRACE         NUMRACE.
   RACE            RACE.
   HISPRACE        HISPRACE.
   HISPRACE2       HISPRACE2F.
   NUMKDHH         NUMKDHH.
   NUMFMHH         NUMFMHH.
   HHFAMTYP        HHFAMTYP.
   HHPARTYP        HHPARTYP.
   NCHILDHH        NCHILDHH.
   HHKIDTYP        HHKIDTYP.
   CSPBBHH         CSPBIO.
   CSPBSHH         CSPNOT.
   CSPOKDHH        CSPNOT.
   INTCTFAM        INTCTFAM.
   PARAGE14        PARAGEF.
   EDUCMOM         EDUCMOM.
   AGEMOMB1        AGEMOMBF.
   AGER_I          IMPFLG.
   FMARITAL_I      IMPFLG.
   RMARITAL_I      IMPFLG.
   EDUCAT_I        IMPFLG.
   HIEDUC_I        IMPFLG.
   HISPANIC_I      IMPFLG.
   RACE_I          IMPFLG.
   HISPRACE_I      IMPFLG.
   HISPRACE2_I     IMPFLG.
   NUMKDHH_I       IMPFLG.
   NUMFMHH_I       IMPFLG.
   HHFAMTYP_I      IMPFLG.
   HHPARTYP_I      IMPFLG.
   NCHILDHH_I      IMPFLG.
   HHKIDTYP_I      IMPFLG.
   CSPBBHH_I       IMPFLG.
   CSPBSHH_I       IMPFLG.
   CSPOKDHH_I      IMPFLG.
   INTCTFAM_I      IMPFLG.
   PARAGE14_I      IMPFLG.
   EDUCMOM_I       IMPFLG.
   AGEMOMB1_I      IMPFLG.
   RCURPREG        RCURPREG.
   PREGNUM         PREGNUMF.
   COMPREG         PREGNUMF.
   LOSSNUM         TPRGOUTF.
   ABORTION        TPRGOUTF.
   LBPREGS         LBPREGS.
   PARITY          PARITY.
   BIRTHS5         BIRTHS5F.
   OUTCOM01        OUTCOMRF.
   OUTCOM02        OUTCOMRF.
   OUTCOM03        OUTCOMRF.
   OUTCOM04        OUTCOMRF.
   OUTCOM05        OUTCOMRF.
   OUTCOM06        OUTCOMRF.
   OUTCOM07        OUTCOMRF.
   OUTCOM08        OUTCOMRF.
   OUTCOM09        OUTCOMRF.
   OUTCOM10        OUTCOMRF.
   OUTCOM11        OUTCOMRF.
   OUTCOM12        OUTCOMRF.
   OUTCOM13        OUTCOMRF.
   OUTCOM14        OUTCOMRF.
   OUTCOM15        OUTCOMRF.
   OUTCOM16        OUTCOMRF.
   OUTCOM17        OUTCOMRF.
   OUTCOM18        OUTCOMRF.
   OUTCOM19        OUTCOMRF.
   OUTCOM20        OUTCOMRF.
   DATEND01        CMFMT.
   DATEND02        CMFMT.
   DATEND03        CMFMT.
   DATEND04        CMFMT.
   DATEND05        CMFMT.
   DATEND06        CMFMT.
   DATEND07        CMFMT.
   DATEND08        CMFMT.
   DATEND09        CMFMT.
   DATEND10        CMFMT.
   DATEND11        CMFMT.
   DATEND12        CMFMT.
   DATEND13        CMFMT.
   DATEND14        CMFMT.
   DATEND15        CMFMT.
   DATEND16        CMFMT.
   DATEND17        CMFMT.
   DATEND18        CMFMT.
   DATEND19        CMFMT.
   DATEND20        CMFMT.
   DATCON01        CMFMT.
   DATCON02        CMFMT.
   DATCON03        CMFMT.
   DATCON04        CMFMT.
   DATCON05        CMFMT.
   DATCON06        CMFMT.
   DATCON07        CMFMT.
   DATCON08        CMFMT.
   DATCON09        CMFMT.
   DATCON10        CMFMT.
   DATCON11        CMFMT.
   DATCON12        CMFMT.
   DATCON13        CMFMT.
   DATCON14        CMFMT.
   DATCON15        CMFMT.
   DATCON16        CMFMT.
   DATCON17        CMFMT.
   DATCON18        CMFMT.
   DATCON19        CMFMT.
   DATCON20        CMFMT.
   MAROUT01        MARPRGF.
   MAROUT02        MARPRGF.
   MAROUT03        MARPRGF.
   MAROUT04        MARPRGF.
   MAROUT05        MARPRGF.
   MAROUT06        MARPRGF.
   MAROUT07        MARPRGF.
   MAROUT08        MARPRGF.
   MAROUT09        MARPRGF.
   MAROUT10        MARPRGF.
   MAROUT11        MARPRGF.
   MAROUT12        MARPRGF.
   MAROUT13        MARPRGF.
   MAROUT14        MARPRGF.
   MAROUT15        MARPRGF.
   MAROUT16        MARPRGF.
   MAROUT17        MARPRGF.
   MAROUT18        MARPRGF.
   MAROUT19        MARPRGF.
   MAROUT20        MARPRGF.
   RMAROUT01       RMARFMT.
   RMAROUT02       RMARFMT.
   RMAROUT03       RMARFMT.
   RMAROUT04       RMARFMT.
   RMAROUT05       RMARFMT.
   RMAROUT06       RMARFMT.
   RMAROUT07       RMARFMT.
   RMAROUT08       RMARFMT.
   RMAROUT09       RMARFMT.
   RMAROUT10       RMARFMT.
   RMAROUT11       RMARFMT.
   RMAROUT12       RMARFMT.
   RMAROUT13       RMARFMT.
   RMAROUT14       RMARFMT.
   RMAROUT15       RMARFMT.
   RMAROUT16       RMARFMT.
   RMAROUT17       RMARFMT.
   RMAROUT18       RMARFMT.
   RMAROUT19       RMARFMT.
   RMAROUT20       RMARFMT.
   MARCON01        MARPRGF.
   MARCON02        MARPRGF.
   MARCON03        MARPRGF.
   MARCON04        MARPRGF.
   MARCON05        MARPRGF.
   MARCON06        MARPRGF.
   MARCON07        MARPRGF.
   MARCON08        MARPRGF.
   MARCON09        MARPRGF.
   MARCON10        MARPRGF.
   MARCON11        MARPRGF.
   MARCON12        MARPRGF.
   MARCON13        MARPRGF.
   MARCON14        MARPRGF.
   MARCON15        MARPRGF.
   MARCON16        MARPRGF.
   MARCON17        MARPRGF.
   MARCON18        MARPRGF.
   MARCON19        MARPRGF.
   MARCON20        MARPRGF.
   RMARCON01       RMARFMT.
   RMARCON02       RMARFMT.
   RMARCON03       RMARFMT.
   RMARCON04       RMARFMT.
   RMARCON05       RMARFMT.
   RMARCON06       RMARFMT.
   RMARCON07       RMARFMT.
   RMARCON08       RMARFMT.
   RMARCON09       RMARFMT.
   RMARCON10       RMARFMT.
   RMARCON11       RMARFMT.
   RMARCON12       RMARFMT.
   RMARCON13       RMARFMT.
   RMARCON14       RMARFMT.
   RMARCON15       RMARFMT.
   RMARCON16       RMARFMT.
   RMARCON17       RMARFMT.
   RMARCON18       RMARFMT.
   RMARCON19       RMARFMT.
   RMARCON20       RMARFMT.
   CEBOW           CEBOW.
   CEBOWC          CEBOW.
   DATBABY1        CMFMT.
   LIVCHILD01      LIVCHLDR.
   LIVCHILD02      LIVCHLDR.
   LIVCHILD03      LIVCHLDR.
   LIVCHILD04      LIVCHLDR.
   LIVCHILD05      LIVCHLDR.
   LIVCHILD06      LIVCHLDR.
   LIVCHILD07      LIVCHLDR.
   LIVCHILD08      LIVCHLDR.
   LIVCHILD09      LIVCHLDR.
   LIVCHILD10      LIVCHLDR.
   LIVCHILD11      LIVCHLDR.
   LIVCHILD12      LIVCHLDR.
   LIVCHILD13      LIVCHLDR.
   LIVCHILD14      LIVCHLDR.
   LIVCHILD15      LIVCHLDR.
   LIVCHILD16      LIVCHLDR.
   LIVCHILD17      LIVCHLDR.
   LIVCHILD18      LIVCHLDR.
   LIVCHILD19      LIVCHLDR.
   LIVCHILD20      LIVCHLDR.
   RCURPREG_I      IMPFLG.
   PREGNUM_I       IMPFLG.
   COMPREG_I       IMPFLG.
   LOSSNUM_I       IMPFLG.
   ABORTION_I      IMPFLG.
   LBPREGS_I       IMPFLG.
   PARITY_I        IMPFLG.
   BIRTHS5_I       IMPFLG.
   OUTCOM01_I      IMPFLG.
   OUTCOM02_I      IMPFLG.
   OUTCOM03_I      IMPFLG.
   OUTCOM04_I      IMPFLG.
   OUTCOM05_I      IMPFLG.
   OUTCOM06_I      IMPFLG.
   OUTCOM07_I      IMPFLG.
   OUTCOM08_I      IMPFLG.
   OUTCOM09_I      IMPFLG.
   OUTCOM10_I      IMPFLG.
   OUTCOM11_I      IMPFLG.
   OUTCOM12_I      IMPFLG.
   OUTCOM13_I      IMPFLG.
   OUTCOM14_I      IMPFLG.
   OUTCOM15_I      IMPFLG.
   OUTCOM16_I      IMPFLG.
   OUTCOM17_I      IMPFLG.
   OUTCOM18_I      IMPFLG.
   OUTCOM19_I      IMPFLG.
   OUTCOM20_I      IMPFLG.
   DATEND01_I      IMPFLG.
   DATEND02_I      IMPFLG.
   DATEND03_I      IMPFLG.
   DATEND04_I      IMPFLG.
   DATEND05_I      IMPFLG.
   DATEND06_I      IMPFLG.
   DATEND07_I      IMPFLG.
   DATEND08_I      IMPFLG.
   DATEND09_I      IMPFLG.
   DATEND10_I      IMPFLG.
   DATEND11_I      IMPFLG.
   DATEND12_I      IMPFLG.
   DATEND13_I      IMPFLG.
   DATEND14_I      IMPFLG.
   DATEND15_I      IMPFLG.
   DATEND16_I      IMPFLG.
   DATEND17_I      IMPFLG.
   DATEND18_I      IMPFLG.
   DATEND19_I      IMPFLG.
   DATEND20_I      IMPFLG.
   AGEPRG01_I      IMPFLG.
   AGEPRG02_I      IMPFLG.
   AGEPRG03_I      IMPFLG.
   AGEPRG04_I      IMPFLG.
   AGEPRG05_I      IMPFLG.
   AGEPRG06_I      IMPFLG.
   AGEPRG07_I      IMPFLG.
   AGEPRG08_I      IMPFLG.
   AGEPRG09_I      IMPFLG.
   AGEPRG10_I      IMPFLG.
   AGEPRG11_I      IMPFLG.
   AGEPRG12_I      IMPFLG.
   AGEPRG13_I      IMPFLG.
   AGEPRG14_I      IMPFLG.
   AGEPRG15_I      IMPFLG.
   AGEPRG16_I      IMPFLG.
   AGEPRG17_I      IMPFLG.
   AGEPRG18_I      IMPFLG.
   AGEPRG19_I      IMPFLG.
   AGEPRG20_I      IMPFLG.
   DATCON01_I      IMPFLG.
   DATCON02_I      IMPFLG.
   DATCON03_I      IMPFLG.
   DATCON04_I      IMPFLG.
   DATCON05_I      IMPFLG.
   DATCON06_I      IMPFLG.
   DATCON07_I      IMPFLG.
   DATCON08_I      IMPFLG.
   DATCON09_I      IMPFLG.
   DATCON10_I      IMPFLG.
   DATCON11_I      IMPFLG.
   DATCON12_I      IMPFLG.
   DATCON13_I      IMPFLG.
   DATCON14_I      IMPFLG.
   DATCON15_I      IMPFLG.
   DATCON16_I      IMPFLG.
   DATCON17_I      IMPFLG.
   DATCON18_I      IMPFLG.
   DATCON19_I      IMPFLG.
   DATCON20_I      IMPFLG.
   AGECON01_I      IMPFLG.
   AGECON02_I      IMPFLG.
   AGECON03_I      IMPFLG.
   AGECON04_I      IMPFLG.
   AGECON05_I      IMPFLG.
   AGECON06_I      IMPFLG.
   AGECON07_I      IMPFLG.
   AGECON08_I      IMPFLG.
   AGECON09_I      IMPFLG.
   AGECON10_I      IMPFLG.
   AGECON11_I      IMPFLG.
   AGECON12_I      IMPFLG.
   AGECON13_I      IMPFLG.
   AGECON14_I      IMPFLG.
   AGECON15_I      IMPFLG.
   AGECON16_I      IMPFLG.
   AGECON17_I      IMPFLG.
   AGECON18_I      IMPFLG.
   AGECON19_I      IMPFLG.
   AGECON20_I      IMPFLG.
   MAROUT01_I      IMPFLG.
   MAROUT02_I      IMPFLG.
   MAROUT03_I      IMPFLG.
   MAROUT04_I      IMPFLG.
   MAROUT05_I      IMPFLG.
   MAROUT06_I      IMPFLG.
   MAROUT07_I      IMPFLG.
   MAROUT08_I      IMPFLG.
   MAROUT09_I      IMPFLG.
   MAROUT10_I      IMPFLG.
   MAROUT11_I      IMPFLG.
   MAROUT12_I      IMPFLG.
   MAROUT13_I      IMPFLG.
   MAROUT14_I      IMPFLG.
   MAROUT15_I      IMPFLG.
   MAROUT16_I      IMPFLG.
   MAROUT17_I      IMPFLG.
   MAROUT18_I      IMPFLG.
   MAROUT19_I      IMPFLG.
   MAROUT20_I      IMPFLG.
   RMAROUT01_I     IMPFLG.
   RMAROUT02_I     IMPFLG.
   RMAROUT03_I     IMPFLG.
   RMAROUT04_I     IMPFLG.
   RMAROUT05_I     IMPFLG.
   RMAROUT06_I     IMPFLG.
   RMAROUT07_I     IMPFLG.
   RMAROUT08_I     IMPFLG.
   RMAROUT09_I     IMPFLG.
   RMAROUT10_I     IMPFLG.
   RMAROUT11_I     IMPFLG.
   RMAROUT12_I     IMPFLG.
   RMAROUT13_I     IMPFLG.
   RMAROUT14_I     IMPFLG.
   RMAROUT15_I     IMPFLG.
   RMAROUT16_I     IMPFLG.
   RMAROUT17_I     IMPFLG.
   RMAROUT18_I     IMPFLG.
   RMAROUT19_I     IMPFLG.
   RMAROUT20_I     IMPFLG.
   MARCON01_I      IMPFLG.
   MARCON02_I      IMPFLG.
   MARCON03_I      IMPFLG.
   MARCON04_I      IMPFLG.
   MARCON05_I      IMPFLG.
   MARCON06_I      IMPFLG.
   MARCON07_I      IMPFLG.
   MARCON08_I      IMPFLG.
   MARCON09_I      IMPFLG.
   MARCON10_I      IMPFLG.
   MARCON11_I      IMPFLG.
   MARCON12_I      IMPFLG.
   MARCON13_I      IMPFLG.
   MARCON14_I      IMPFLG.
   MARCON15_I      IMPFLG.
   MARCON16_I      IMPFLG.
   MARCON17_I      IMPFLG.
   MARCON18_I      IMPFLG.
   MARCON19_I      IMPFLG.
   MARCON20_I      IMPFLG.
   RMARCON01_I     IMPFLG.
   RMARCON02_I     IMPFLG.
   RMARCON03_I     IMPFLG.
   RMARCON04_I     IMPFLG.
   RMARCON05_I     IMPFLG.
   RMARCON06_I     IMPFLG.
   RMARCON07_I     IMPFLG.
   RMARCON08_I     IMPFLG.
   RMARCON09_I     IMPFLG.
   RMARCON10_I     IMPFLG.
   RMARCON11_I     IMPFLG.
   RMARCON12_I     IMPFLG.
   RMARCON13_I     IMPFLG.
   RMARCON14_I     IMPFLG.
   RMARCON15_I     IMPFLG.
   RMARCON16_I     IMPFLG.
   RMARCON17_I     IMPFLG.
   RMARCON18_I     IMPFLG.
   RMARCON19_I     IMPFLG.
   RMARCON20_I     IMPFLG.
   CEBOW_I         IMPFLG.
   CEBOWC_I        IMPFLG.
   DATBABY1_I      IMPFLG.
   AGEBABY1_I      IMPFLG.
   LIVCHILD01_I    IMPFLG.
   LIVCHILD02_I    IMPFLG.
   LIVCHILD03_I    IMPFLG.
   LIVCHILD04_I    IMPFLG.
   LIVCHILD05_I    IMPFLG.
   LIVCHILD06_I    IMPFLG.
   LIVCHILD07_I    IMPFLG.
   LIVCHILD08_I    IMPFLG.
   LIVCHILD09_I    IMPFLG.
   LIVCHILD10_I    IMPFLG.
   LIVCHILD11_I    IMPFLG.
   LIVCHILD12_I    IMPFLG.
   LIVCHILD13_I    IMPFLG.
   LIVCHILD14_I    IMPFLG.
   LIVCHILD15_I    IMPFLG.
   LIVCHILD16_I    IMPFLG.
   LIVCHILD17_I    IMPFLG.
   LIVCHILD18_I    IMPFLG.
   LIVCHILD19_I    IMPFLG.
   LIVCHILD20_I    IMPFLG.
   FMARNO          FMARNO.
   MARDAT01        CMFMT.
   MARDAT02        CMFMT.
   MARDAT03        CMFMT.
   MARDAT04        CMFMT.
   MARDAT05        CMFMT.
   MARDIS01        CMFMT.
   MARDIS02        CMFMT.
   MARDIS03        CMFMT.
   MARDIS04        CMFMT.
   MARDIS05        CMFMT.
   MAREND01        MARENDF.
   MAREND02        MARENDF.
   MAREND03        MARENDF.
   MAREND04        MARENDF.
   MAREND05        MARENDF.
   MAR1BIR1        MAR1BIRF.
   MAR1CON1        MAR1CONF.
   CON1MAR1        CON1MARF.
   B1PREMAR        Y1N2RECF.
   COHEVER         COHEVER.
   EVMARCOH        EVMARCOH.
   PMARRNO         COHNUM.
   NONMARR         COHNUM.
   TIMESCOH        COHNUM.
   COHAB1          CMFMT.
   COHSTAT         COHSTAT.
   COHOUT          COHOUT.
   HADSEX          HADSEX.
   SEXONCE         SEXONCE.
   SEXEVER         SEXEVER.
   VRY1STSX        VRY1STSX.
   DATESEX1        DATESEX1F.
   SEXMAR          SEXMAR.
   SEX1FOR         SEX1FOR.
   SEXUNION        SEXUNION.
   SEXOUT          SEXOUT.
   FPDUR           FPDUR.
   PARTS1YR        PARTS1YR.
   LSEXDATE        CMFMT.
   SEX3MO          Y1N2RECF.
   NUMP3MOS        NUMP3MOS.
   LSEXPAGE        LSEXPAGE.
   PARTDUR1        PARTDURF.
   PARTDUR2        PARTDURF.
   PARTDUR3        PARTDURF.
   RELATP1         RELATPF.
   RELATP2         RELATPF.
   RELATP3         RELATPF.
   LIFPRTNR        LIFPRTNR.
   FMARNO_I        IMPFLG.
   CSPBIOKD_I      IMPFLG.
   MARDAT01_I      IMPFLG.
   MARDAT02_I      IMPFLG.
   MARDAT03_I      IMPFLG.
   MARDAT04_I      IMPFLG.
   MARDAT05_I      IMPFLG.
   MARDIS01_I      IMPFLG.
   MARDIS02_I      IMPFLG.
   MARDIS03_I      IMPFLG.
   MARDIS04_I      IMPFLG.
   MARDIS05_I      IMPFLG.
   MAREND01_I      IMPFLG.
   MAREND02_I      IMPFLG.
   MAREND03_I      IMPFLG.
   MAREND04_I      IMPFLG.
   MAREND05_I      IMPFLG.
   FMAR1AGE_I      IMPFLG.
   AGEDISS1_I      IMPFLG.
   AGEDD1_I        IMPFLG.
   MAR1DISS_I      IMPFLG.
   DD1REMAR_I      IMPFLG.
   MAR1BIR1_I      IMPFLG.
   MAR1CON1_I      IMPFLG.
   CON1MAR1_I      IMPFLG.
   B1PREMAR_I      IMPFLG.
   COHEVER_I       IMPFLG.
   EVMARCOH_I      IMPFLG.
   PMARRNO_I       IMPFLG.
   NONMARR_I       IMPFLG.
   TIMESCOH_I      IMPFLG.
   COHAB1_I        IMPFLG.
   COHSTAT_I       IMPFLG.
   COHOUT_I        IMPFLG.
   COH1DUR_I       IMPFLG.
   HADSEX_I        IMPFLG.
   SEXEVER_I       IMPFLG.
   VRY1STAG_I      IMPFLG.
   SEX1AGE_I       IMPFLG.
   VRY1STSX_I      IMPFLG.
   DATESEX1_I      IMPFLG.
   SEXONCE_I       IMPFLG.
   FSEXPAGE_I      IMPFLG.
   SEXMAR_I        IMPFLG.
   SEX1FOR_I       IMPFLG.
   SEXUNION_I      IMPFLG.
   SEXOUT_I        IMPFLG.
   FPDUR_I         IMPFLG.
   PARTS1YR_I      IMPFLG.
   LSEXDATE_I      IMPFLG.
   SEXP3MO_I       IMPFLG.
   NUMP3MOS_I      IMPFLG.
   LSEXRAGE_I      IMPFLG.
   PARTDUR1_I      IMPFLG.
   PARTDUR2_I      IMPFLG.
   PARTDUR3_I      IMPFLG.
   RELATP1_I       IMPFLG.
   RELATP2_I       IMPFLG.
   RELATP3_I       IMPFLG.
   LIFPRTNR_I      IMPFLG.
   STRLOPER        STRLOPER.
   FECUND          FECUND.
   ANYBC36         ANYBCF.
   NOSEX36         NOSEX36F.
   INFERT          INFERT.
   ANYBC12         ANYBCF.
   ANYMTHD         Y1N2RECF.
   NOSEX12         NOSEX12F.
   SEXP3MO         Y1N2RECF.
   CONSTAT1        CONSTATF.
   CONSTAT2        CONSTATF.
   CONSTAT3        CONSTATF.
   CONSTAT4        CONSTATF.
   PILLR           Y1N2RECF.
   CONDOMR         Y1N2RECF.
   SEX1MTHD1       SEX1MTHDF.
   SEX1MTHD2       SEX1MTHDF.
   SEX1MTHD3       SEX1MTHDF.
   SEX1MTHD4       SEX1MTHDF.
   MTHUSE12        MTHUSE12F.
   METH12M1        METH12MF.
   METH12M2        METH12MF.
   METH12M3        METH12MF.
   METH12M4        METH12MF.
   MTHUSE3         MTHUSE3F.
   METH3M1         METH3MF.
   METH3M2         METH3MF.
   METH3M3         METH3MF.
   METH3M4         METH3MF.
   FMETHOD1        FMETHODF.
   FMETHOD2        FMETHODF.
   FMETHOD3        FMETHODF.
   FMETHOD4        FMETHODF.
   OLDWP01         OWWNTF.
   OLDWP02         OWWNTF.
   OLDWP03         OWWNTF.
   OLDWP04         OWWNTF.
   OLDWP05         OWWNTF.
   OLDWP06         OWWNTF.
   OLDWP07         OWWNTF.
   OLDWP08         OWWNTF.
   OLDWP09         OWWNTF.
   OLDWP10         OWWNTF.
   OLDWP11         OWWNTF.
   OLDWP12         OWWNTF.
   OLDWP13         OWWNTF.
   OLDWP14         OWWNTF.
   OLDWP15         OWWNTF.
   OLDWP16         OWWNTF.
   OLDWP17         OWWNTF.
   OLDWP18         OWWNTF.
   OLDWP19         OWWNTF.
   OLDWP20         OWWNTF.
   OLDWR01         OWWNTF.
   OLDWR02         OWWNTF.
   OLDWR03         OWWNTF.
   OLDWR04         OWWNTF.
   OLDWR05         OWWNTF.
   OLDWR06         OWWNTF.
   OLDWR07         OWWNTF.
   OLDWR08         OWWNTF.
   OLDWR09         OWWNTF.
   OLDWR10         OWWNTF.
   OLDWR11         OWWNTF.
   OLDWR12         OWWNTF.
   OLDWR13         OWWNTF.
   OLDWR14         OWWNTF.
   OLDWR15         OWWNTF.
   OLDWR16         OWWNTF.
   OLDWR17         OWWNTF.
   OLDWR18         OWWNTF.
   OLDWR19         OWWNTF.
   OLDWR20         OWWNTF.
   WANTRP01        OWWNTF.
   WANTRP02        OWWNTF.
   WANTRP03        OWWNTF.
   WANTRP04        OWWNTF.
   WANTRP05        OWWNTF.
   WANTRP06        OWWNTF.
   WANTRP07        OWWNTF.
   WANTRP08        OWWNTF.
   WANTRP09        OWWNTF.
   WANTRP10        OWWNTF.
   WANTRP11        OWWNTF.
   WANTRP12        OWWNTF.
   WANTRP13        OWWNTF.
   WANTRP14        OWWNTF.
   WANTRP15        OWWNTF.
   WANTRP16        OWWNTF.
   WANTRP17        OWWNTF.
   WANTRP18        OWWNTF.
   WANTRP19        OWWNTF.
   WANTRP20        OWWNTF.
   WANTP01         OWWNTF.
   WANTP02         OWWNTF.
   WANTP03         OWWNTF.
   WANTP04         OWWNTF.
   WANTP05         OWWNTF.
   WANTP06         OWWNTF.
   WANTP07         OWWNTF.
   WANTP08         OWWNTF.
   WANTP09         OWWNTF.
   WANTP10         OWWNTF.
   WANTP11         OWWNTF.
   WANTP12         OWWNTF.
   WANTP13         OWWNTF.
   WANTP14         OWWNTF.
   WANTP15         OWWNTF.
   WANTP16         OWWNTF.
   WANTP17         OWWNTF.
   WANTP18         OWWNTF.
   WANTP19         OWWNTF.
   WANTP20         OWWNTF.
   NWWANTRP01      NWWANTRPF.
   NWWANTRP02      NWWANTRPF.
   NWWANTRP03      NWWANTRPF.
   NWWANTRP04      NWWANTRPF.
   NWWANTRP05      NWWANTRPF.
   NWWANTRP06      NWWANTRPF.
   NWWANTRP07      NWWANTRPF.
   NWWANTRP08      NWWANTRPF.
   NWWANTRP09      NWWANTRPF.
   NWWANTRP10      NWWANTRPF.
   NWWANTRP11      NWWANTRPF.
   NWWANTRP12      NWWANTRPF.
   NWWANTRP13      NWWANTRPF.
   NWWANTRP14      NWWANTRPF.
   NWWANTRP15      NWWANTRPF.
   NWWANTRP16      NWWANTRPF.
   NWWANTRP17      NWWANTRPF.
   NWWANTRP18      NWWANTRPF.
   NWWANTRP19      NWWANTRPF.
   NWWANTRP20      NWWANTRPF.
   WANTP5          WANTP5F.
   STRLOPER_I      IMPFLG.
   FECUND_I        IMPFLG.
   INFERT_I        IMPFLG.
   ANYMTHD_I       IMPFLG.
   NOSEX12_I       IMPFLG.
   SEX3MO_I        IMPFLG.
   CONSTAT1_I      IMPFLG.
   CONSTAT2_I      IMPFLG.
   CONSTAT3_I      IMPFLG.
   CONSTAT4_I      IMPFLG.
   PILLR_I         IMPFLG.
   CONDOMR_I       IMPFLG.
   SEX1MTHD1_I     IMPFLG.
   SEX1MTHD2_I     IMPFLG.
   SEX1MTHD3_I     IMPFLG.
   SEX1MTHD4_I     IMPFLG.
   MTHUSE12_I      IMPFLG.
   METH12M1_I      IMPFLG.
   METH12M2_I      IMPFLG.
   METH12M3_I      IMPFLG.
   METH12M4_I      IMPFLG.
   MTHUSE3_I       IMPFLG.
   METH3M1_I       IMPFLG.
   METH3M2_I       IMPFLG.
   METH3M3_I       IMPFLG.
   METH3M4_I       IMPFLG.
   FMETHOD1_I      IMPFLG.
   FMETHOD2_I      IMPFLG.
   FMETHOD3_I      IMPFLG.
   FMETHOD4_I      IMPFLG.
   DATEUSE1_I      IMPFLG.
   OLDWP01_I       IMPFLG.
   OLDWP02_I       IMPFLG.
   OLDWP03_I       IMPFLG.
   OLDWP04_I       IMPFLG.
   OLDWP05_I       IMPFLG.
   OLDWP06_I       IMPFLG.
   OLDWP07_I       IMPFLG.
   OLDWP08_I       IMPFLG.
   OLDWP09_I       IMPFLG.
   OLDWP10_I       IMPFLG.
   OLDWP11_I       IMPFLG.
   OLDWP12_I       IMPFLG.
   OLDWP13_I       IMPFLG.
   OLDWP14_I       IMPFLG.
   OLDWP15_I       IMPFLG.
   OLDWP16_I       IMPFLG.
   OLDWP17_I       IMPFLG.
   OLDWP18_I       IMPFLG.
   OLDWP19_I       IMPFLG.
   OLDWP20_I       IMPFLG.
   OLDWR01_I       IMPFLG.
   OLDWR02_I       IMPFLG.
   OLDWR03_I       IMPFLG.
   OLDWR04_I       IMPFLG.
   OLDWR05_I       IMPFLG.
   OLDWR06_I       IMPFLG.
   OLDWR07_I       IMPFLG.
   OLDWR08_I       IMPFLG.
   OLDWR09_I       IMPFLG.
   OLDWR10_I       IMPFLG.
   OLDWR11_I       IMPFLG.
   OLDWR12_I       IMPFLG.
   OLDWR13_I       IMPFLG.
   OLDWR14_I       IMPFLG.
   OLDWR15_I       IMPFLG.
   OLDWR16_I       IMPFLG.
   OLDWR17_I       IMPFLG.
   OLDWR18_I       IMPFLG.
   OLDWR19_I       IMPFLG.
   OLDWR20_I       IMPFLG.
   WANTRP01_I      IMPFLG.
   WANTRP02_I      IMPFLG.
   WANTRP03_I      IMPFLG.
   WANTRP04_I      IMPFLG.
   WANTRP05_I      IMPFLG.
   WANTRP06_I      IMPFLG.
   WANTRP07_I      IMPFLG.
   WANTRP08_I      IMPFLG.
   WANTRP09_I      IMPFLG.
   WANTRP10_I      IMPFLG.
   WANTRP11_I      IMPFLG.
   WANTRP12_I      IMPFLG.
   WANTRP13_I      IMPFLG.
   WANTRP14_I      IMPFLG.
   WANTRP15_I      IMPFLG.
   WANTRP16_I      IMPFLG.
   WANTRP17_I      IMPFLG.
   WANTRP18_I      IMPFLG.
   WANTRP19_I      IMPFLG.
   WANTRP20_I      IMPFLG.
   WANTP01_I       IMPFLG.
   WANTP02_I       IMPFLG.
   WANTP03_I       IMPFLG.
   WANTP04_I       IMPFLG.
   WANTP05_I       IMPFLG.
   WANTP06_I       IMPFLG.
   WANTP07_I       IMPFLG.
   WANTP08_I       IMPFLG.
   WANTP09_I       IMPFLG.
   WANTP10_I       IMPFLG.
   WANTP11_I       IMPFLG.
   WANTP12_I       IMPFLG.
   WANTP13_I       IMPFLG.
   WANTP14_I       IMPFLG.
   WANTP15_I       IMPFLG.
   WANTP16_I       IMPFLG.
   WANTP17_I       IMPFLG.
   WANTP18_I       IMPFLG.
   WANTP19_I       IMPFLG.
   WANTP20_I       IMPFLG.
   NWWANTRP01_I    IMPFLG.
   NWWANTRP02_I    IMPFLG.
   NWWANTRP03_I    IMPFLG.
   NWWANTRP04_I    IMPFLG.
   NWWANTRP05_I    IMPFLG.
   NWWANTRP06_I    IMPFLG.
   NWWANTRP07_I    IMPFLG.
   NWWANTRP08_I    IMPFLG.
   NWWANTRP09_I    IMPFLG.
   NWWANTRP10_I    IMPFLG.
   NWWANTRP11_I    IMPFLG.
   NWWANTRP12_I    IMPFLG.
   NWWANTRP13_I    IMPFLG.
   NWWANTRP14_I    IMPFLG.
   NWWANTRP15_I    IMPFLG.
   NWWANTRP16_I    IMPFLG.
   NWWANTRP17_I    IMPFLG.
   NWWANTRP18_I    IMPFLG.
   NWWANTRP19_I    IMPFLG.
   NWWANTRP20_I    IMPFLG.
   WANTP5_I        IMPFLG.
   FPTIT12         FPTIT.
   FPTITMED        FPTIT.
   FPTITSTE        SRCSRV.
   FPTITBC         SRCSRV.
   FPTITCHK        SRCSRV.
   FPTITCBC        SRCSRV.
   FPTITCST        SRCSRV.
   FPTITEC         SRCSRV.
   FPTITCEC        SRCSRV.
   FPTITPRE        SRCSRV.
   FPTITABO        SRCSRV.
   FPTITPAP        SRCSRV.
   FPTITPEL        SRCSRV.
   FPTITPRN        SRCSRV.
   FPTITPPR        SRCSRV.
   FPTITSTD        SRCSRV.
   FPREGFP         Y1N2RECF.
   FPREGMED        Y1N2RECF.
   FPTIT12_I       IMPFLG.
   FPTITMED_I      IMPFLG.
   FPTITSTE_I      IMPFLG.
   FPTITBC_I       IMPFLG.
   FPTITCHK_I      IMPFLG.
   FPTITCBC_I      IMPFLG.
   FPTITCST_I      IMPFLG.
   FPTITEC_I       IMPFLG.
   FPTITCEC_I      IMPFLG.
   FPTITPRE_I      IMPFLG.
   FPTITABO_I      IMPFLG.
   FPTITPAP_I      IMPFLG.
   FPTITPEL_I      IMPFLG.
   FPTITPRN_I      IMPFLG.
   FPTITPPR_I      IMPFLG.
   FPTITSTD_I      IMPFLG.
   FPREGFP_I       IMPFLG.
   FPREGMED_I      IMPFLG.
   INTENT          INTENT.
   ADDEXP          ADDEXP.
   INTENT_I        IMPFLG.
   ADDEXP_I        IMPFLG.
   ANYPRGHP        Y1N2RECF.
   ANYMSCHP        Y1N2RECF.
   INFEVER         Y1N2RECF.
   OVULATE         REPORTF.
   TUBES           REPORTF.
   INFERTR         REPORTF.
   INFERTH         REPORTF.
   ADVICE          REPORTF.
   INSEM           REPORTF.
   INVITRO         REPORTF.
   ENDOMET         REPORTF.
   FIBROIDS        REPORTF.
   PIDTREAT        Y1N2RECF.
   EVHIVTST        EVHIVTST.
   FPTITHIV        FPTITHIV.
   ANYPRGHP_I      IMPFLG.
   ANYMSCHP_I      IMPFLG.
   INFEVER_I       IMPFLG.
   OVULATE_I       IMPFLG.
   TUBES_I         IMPFLG.
   INFERTR_I       IMPFLG.
   INFERTH_I       IMPFLG.
   ADVICE_I        IMPFLG.
   INSEM_I         IMPFLG.
   INVITRO_I       IMPFLG.
   ENDOMET_I       IMPFLG.
   FIBROIDS_I      IMPFLG.
   PIDTREAT_I      IMPFLG.
   EVHIVTST_I      IMPFLG.
   FPTITHIV_I      IMPFLG.
   CURR_INS        CURR_INS.
   METRO           METRO.
   RELIGION        RELIGION.
   LABORFOR        LABORFOR.
   CURR_INS_I      IMPFLG.
   METRO_I         IMPFLG.
   RELIGION_I      IMPFLG.
   LABORFOR_I      IMPFLG.
   POVERTY         POVERTY.
   TOTINCR         TOTINCR.
   PUBASSIS        PUBASSIS.
   POVERTY_I       IMPFLG.
   TOTINCR_I       IMPFLG.
   PUBASSIS_I      IMPFLG.
   CMINTVW         CMFMT.
   CMLSTYR         CMFMT.
   CMJAN3YR        CMFMT.
   CMJAN4YR        CMFMT.
   CMJAN5YR        CMFMT.
   QUARTER         $QUARTER.
   PHASE           $PHASE.
   INTVWYEAR       $YEARF. ;
*/


* SAS LENGTH STATEMENT;

LENGTH
   CASEID 6                 RSCRNINF 3               RSCRAGE 3             
   RSCRHISP 3               RSCRRACE 3               AGE_A 3               
   AGE_R 3                  CMBIRTH 4                AGESCRN 3             
   MARSTAT 3                FMARSTAT 3               FMARIT 3              
   EVRMARRY 3               HISP 3                   HISPGRP 3             
   PRIMLANG1 3              PRIMLANG2 3              PRIMLANG3 3           
   ROSCNT 3                 NUMCHILD 3               HHKIDS18 3            
   DAUGHT918 3              SON918 3                 NONBIOKIDS 3          
   HPLOCALE 3               MANREL 3                 GOSCHOL 3             
   VACA 3                   HIGRADE 3                COMPGRD 3             
   DIPGED 3                 EARNHS_M 3               EARNHS_Y 4            
   CMHSGRAD 4               HISCHGRD 3               LSTGRADE 3            
   MYSCHOL_M 3              MYSCHOL_Y 4              CMLSTSCH 4            
   HAVEDEG 3                DEGREES 3                EARNBA_M 3            
   EARNBA_Y 4               EXPSCHL 3                EXPGRADE 3            
   CMBAGRAD 4               WTHPARNW 3               ONOWN 3               
   ONOWN18 3                INTACT 3                 PARMARR 3             
   INTACT18 3               LVSIT14F 3               LVSIT14M 3            
   WOMRASDU 3               MOMDEGRE 3               MOMWORKD 3            
   MOMFSTCH 3               MOM18 3                  MANRASDU 3            
   R_FOSTER 3               EVRFSTER 3               MNYFSTER 3            
   DURFSTER 3               MENARCHE 3               PREGNOWQ 3            
   MAYBPREG 3               NUMPREGS 3               EVERPREG 3            
   CURRPREG 3               HOWPREG_N 3              HOWPREG_P 3           
   NOWPRGDK 3               MOSCURRP 3               NPREGS_S 3            
   HASBABES 3               NUMBABES 3               NBABES_S 3            
   CMLASTLB 4               CMLSTPRG 4               CMFSTPRG 4            
   CMPG1BEG 4               NPLACED 3                NDIED 3               
   NADOPTV 3                TOTPLACD 3               OTHERKID 3            
   NOTHRKID 3               SEXOTHKD 3               RELOTHKD 3            
   ADPTOTKD 3               TRYADOPT 3               TRYEITHR 3            
   STILHERE 3               DATKDCAM_M 3             DATKDCAM_Y 4          
   CMOKDCAM 4               OTHKDFOS 3               OKDDOB_M 3            
   OKDDOB_Y 4               CMOKDDOB 4               OTHKDSPN 3            
   OTHKDRAC1 3              OTHKDRAC2 3              KDBSTRAC 3            
   OKBORNUS 3               OKDISABL1 3              OKDISABL2 3           
   SEXOTHKD2 3              RELOTHKD2 3              ADPTOTKD2 3           
   TRYADOPT2 3              TRYEITHR2 3              STILHERE2 3           
   DATKDCAM_M2 3            DATKDCAM_Y2 4            CMOKDCAM2 4           
   OTHKDFOS2 3              OKDDOB_M2 3              OKDDOB_Y2 4           
   CMOKDDOB2 4              OTHKDSPN2 3              OTHKDRAC6 3           
   OTHKDRAC7 3              KDBSTRAC2 3              OKBORNUS2 3           
   OKDISABL5 3              OKDISABL6 3              SEXOTHKD3 3           
   RELOTHKD3 3              ADPTOTKD3 3              TRYADOPT3 3           
   TRYEITHR3 3              STILHERE3 3              DATKDCAM_M3 3         
   DATKDCAM_Y3 4            CMOKDCAM3 4              OTHKDFOS3 3           
   OKDDOB_M3 3              OKDDOB_Y3 4              CMOKDDOB3 4           
   OTHKDSPN3 3              OTHKDRAC11 3             OTHKDRAC12 3          
   KDBSTRAC3 3              OKBORNUS3 3              OKDISABL9 3           
   OKDISABL10 3             SEXOTHKD4 3              RELOTHKD4 3           
   ADPTOTKD4 3              TRYADOPT4 3              TRYEITHR4 3           
   STILHERE4 3              DATKDCAM_M4 3            DATKDCAM_Y4 4         
   CMOKDCAM4 4              OTHKDFOS4 3              OKDDOB_M4 3           
   OKDDOB_Y4 4              CMOKDDOB4 4              OTHKDSPN4 3           
   OTHKDRAC16 3             OTHKDRAC17 3             KDBSTRAC4 3           
   OKBORNUS4 3              OKDISABL13 3             OKDISABL14 3          
   SEXOTHKD5 3              RELOTHKD5 3              ADPTOTKD5 3           
   TRYADOPT5 3              TRYEITHR5 3              STILHERE5 3           
   DATKDCAM_M5 3            DATKDCAM_Y5 4            CMOKDCAM5 4           
   OTHKDFOS5 3              OKDDOB_M5 3              OKDDOB_Y5 4           
   CMOKDDOB5 4              OTHKDSPN5 3              OTHKDRAC21 3          
   OTHKDRAC22 3             KDBSTRAC5 3              OKBORNUS5 3           
   OKDISABL17 3             OKDISABL18 3             SEXOTHKD6 3           
   RELOTHKD6 3              ADPTOTKD6 3              TRYADOPT6 3           
   TRYEITHR6 3              STILHERE6 3              DATKDCAM_M6 3         
   DATKDCAM_Y6 3            CMOKDCAM6 3              OTHKDFOS6 3           
   OKDDOB_M6 3              OKDDOB_Y6 3              CMOKDDOB6 3           
   OTHKDSPN6 3              OTHKDRAC26 3             OTHKDRAC27 3          
   KDBSTRAC6 3              OKBORNUS6 3              OKDISABL21 3          
   OKDISABL22 3             SEXOTHKD7 3              RELOTHKD7 3           
   ADPTOTKD7 3              TRYADOPT7 3              TRYEITHR7 3           
   STILHERE7 3              DATKDCAM_M7 3            DATKDCAM_Y7 3         
   CMOKDCAM7 3              OTHKDFOS7 3              OKDDOB_M7 3           
   OKDDOB_Y7 3              CMOKDDOB7 3              OTHKDSPN7 3           
   OTHKDRAC31 3             OTHKDRAC32 3             KDBSTRAC7 3           
   OKBORNUS7 3              OKDISABL25 3             OKDISABL26 3          
   SEXOTHKD8 3              RELOTHKD8 3              ADPTOTKD8 3           
   TRYADOPT8 3              TRYEITHR8 3              STILHERE8 3           
   DATKDCAM_M8 3            DATKDCAM_Y8 3            CMOKDCAM8 3           
   OTHKDFOS8 3              OKDDOB_M8 3              OKDDOB_Y8 3           
   CMOKDDOB8 3              OTHKDSPN8 3              OTHKDRAC36 3          
   OTHKDRAC37 3             KDBSTRAC8 3              OKBORNUS8 3           
   OKDISABL29 3             OKDISABL30 3             SEXOTHKD9 3           
   RELOTHKD9 3              ADPTOTKD9 3              TRYADOPT9 3           
   TRYEITHR9 3              STILHERE9 3              DATKDCAM_M9 3         
   DATKDCAM_Y9 4            CMOKDCAM9 4              OTHKDFOS9 3           
   OKDDOB_M9 3              OKDDOB_Y9 4              CMOKDDOB9 4           
   OTHKDSPN9 3              OTHKDRAC41 3             OTHKDRAC42 3          
   KDBSTRAC9 3              OKBORNUS9 3              OKDISABL33 3          
   OKDISABL34 3             SEXOTHKD10 3             RELOTHKD10 3          
   ADPTOTKD10 3             TRYADOPT10 3             TRYEITHR10 3          
   STILHERE10 3             DATKDCAM_M10 3           DATKDCAM_Y10 3        
   CMOKDCAM10 3             OTHKDFOS10 3             OKDDOB_M10 3          
   OKDDOB_Y10 3             CMOKDDOB10 3             OTHKDSPN10 3          
   OTHKDRAC46 3             OTHKDRAC47 3             KDBSTRAC10 3          
   OKBORNUS10 3             OKDISABL37 3             OKDISABL38 3          
   SEXOTHKD11 3             RELOTHKD11 3             ADPTOTKD11 3          
   TRYADOPT11 3             TRYEITHR11 3             STILHERE11 3          
   DATKDCAM_M11 3           DATKDCAM_Y11 4           CMOKDCAM11 4          
   OTHKDFOS11 3             OKDDOB_M11 3             OKDDOB_Y11 4          
   CMOKDDOB11 4             OTHKDSPN11 3             OTHKDRAC51 3          
   OTHKDRAC52 3             KDBSTRAC11 3             OKBORNUS11 3          
   OKDISABL41 3             OKDISABL42 3             SEXOTHKD12 3          
   RELOTHKD12 3             ADPTOTKD12 3             TRYADOPT12 3          
   TRYEITHR12 3             STILHERE12 3             DATKDCAM_M12 3        
   DATKDCAM_Y12 3           CMOKDCAM12 3             OTHKDFOS12 3          
   OKDDOB_M12 3             OKDDOB_Y12 3             CMOKDDOB12 3          
   OTHKDSPN12 3             OTHKDRAC56 3             OTHKDRAC57 3          
   KDBSTRAC12 3             OKBORNUS12 3             OKDISABL45 3          
   OKDISABL46 3             SEXOTHKD13 3             RELOTHKD13 3          
   ADPTOTKD13 3             TRYADOPT13 3             TRYEITHR13 3          
   STILHERE13 3             DATKDCAM_M13 3           DATKDCAM_Y13 3        
   CMOKDCAM13 3             OTHKDFOS13 3             OKDDOB_M13 3          
   OKDDOB_Y13 3             CMOKDDOB13 3             OTHKDSPN13 3          
   OTHKDRAC61 3             OTHKDRAC62 3             KDBSTRAC13 3          
   OKBORNUS13 3             OKDISABL49 3             OKDISABL50 3          
   SEXOTHKD14 3             RELOTHKD14 3             ADPTOTKD14 3          
   TRYADOPT14 3             TRYEITHR14 3             STILHERE14 3          
   DATKDCAM_M14 3           DATKDCAM_Y14 4           CMOKDCAM14 4          
   OTHKDFOS14 3             OKDDOB_M14 3             OKDDOB_Y14 4          
   CMOKDDOB14 4             OTHKDSPN14 3             OTHKDRAC66 3          
   OTHKDRAC67 3             KDBSTRAC14 3             OKBORNUS14 3          
   OKDISABL53 3             OKDISABL54 3             SEXOTHKD15 3          
   RELOTHKD15 3             ADPTOTKD15 3             TRYADOPT15 3          
   TRYEITHR15 3             STILHERE15 3             DATKDCAM_M15 3        
   DATKDCAM_Y15 3           CMOKDCAM15 3             OTHKDFOS15 3          
   OKDDOB_M15 3             OKDDOB_Y15 3             CMOKDDOB15 3          
   OTHKDSPN15 3             OTHKDRAC71 3             OTHKDRAC72 3          
   KDBSTRAC15 3             OKBORNUS15 3             OKDISABL57 3          
   OKDISABL58 3             EVERADPT 3               SEEKADPT 3            
   CONTAGEM 3               TRYLONG 3                KNOWADPT 3            
   CHOSESEX 3               TYPESEXF 3               TYPESEXM 3            
   CHOSRACE 3               TYPRACBK 3               TYPRACWH 3            
   TYPRACOT 3               CHOSEAGE 3               TYPAGE2M 3            
   TYPAGE5M 3               TYPAG12M 3               TYPAG13M 3            
   CHOSDISB 3               TYPDISBN 3               TYPDISBM 3            
   TYPDISBS 3               CHOSENUM 3               TYPNUM1M 3            
   TYPNUM2M 3               EVWNTANO 3               EVCONTAG 3            
   TURNDOWN 3               YQUITTRY 3               APROCESS1 3           
   APROCESS2 3              HRDEMBRYO 3              TIMESMAR 3            
   HSBVERIF 3               WHMARHX_M 3              WHMARHX_Y 4           
   CMMARRHX 4               AGEMARHX 3               HXAGEMAR 3            
   DOBHUSBX_M 3             DOBHUSBX_Y 4             CMHSBDOBX 4           
   LVTOGHX 3                STRTOGHX_M 3             STRTOGHX_Y 4          
   CMPMCOHX 4               ENGAGHX 3                HSBMULT1 3            
   HSBRACE1 3               HSBHRACE1 3              HSBNRACE1 3           
   CHEDMARN 3               MARBEFHX 3               KIDSHX 3              
   NUMKDSHX 3               KIDLIVHX 3               CHKID18A 3            
   CHKID18B 3               WHRCHKDS1 3              WHRCHKDS2 3           
   WHRCHKDS3 3              WHRCHKDS4 3              SUPPORCH 3            
   BIOHUSBX 3               BIONUMHX 3               MARENDHX 3            
   WNDIEHX_M 3              WNDIEHX_Y 4              CMHSBDIEX 4           
   DIVDATHX_M 3             DIVDATHX_Y 4             CMDIVORCX 4           
   WNSTPHX_M 3              WNSTPHX_Y 4              CMSTPHSBX 4           
   WHMARHX_M2 3             WHMARHX_Y2 4             CMMARRHX2 4           
   AGEMARHX2 3              HXAGEMAR2 3              DOBHUSBX_M2 3         
   DOBHUSBX_Y2 4            CMHSBDOBX2 4             LVTOGHX2 3            
   STRTOGHX_M2 3            STRTOGHX_Y2 4            CMPMCOHX2 4           
   ENGAGHX2 3               HSBMULT2 3               HSBRACE2 3            
   HSBHRACE2 3              HSBNRACE2 3              CHEDMARN2 3           
   MARBEFHX2 3              KIDSHX2 3                NUMKDSHX2 3           
   KIDLIVHX2 3              CHKID18A2 3              CHKID18B2 3           
   WHRCHKDS5 3              WHRCHKDS6 3              WHRCHKDS7 3           
   WHRCHKDS8 3              SUPPORCH2 3              BIOHUSBX2 3           
   BIONUMHX2 3              MARENDHX2 3              WNDIEHX_M2 3          
   WNDIEHX_Y2 4             CMHSBDIEX2 4             DIVDATHX_M2 3         
   DIVDATHX_Y2 4            CMDIVORCX2 4             WNSTPHX_M2 3          
   WNSTPHX_Y2 4             CMSTPHSBX2 4             WHMARHX_M3 3          
   WHMARHX_Y3 4             CMMARRHX3 4              AGEMARHX3 3           
   HXAGEMAR3 3              DOBHUSBX_M3 3            DOBHUSBX_Y3 4         
   CMHSBDOBX3 4             LVTOGHX3 3               STRTOGHX_M3 3         
   STRTOGHX_Y3 4            CMPMCOHX3 4              ENGAGHX3 3            
   HSBMULT3 3               HSBRACE3 3               HSBHRACE3 3           
   HSBNRACE3 3              CHEDMARN3 3              MARBEFHX3 3           
   KIDSHX3 3                NUMKDSHX3 3              KIDLIVHX3 3           
   CHKID18A3 3              CHKID18B3 3              WHRCHKDS9 3           
   WHRCHKDS10 3             WHRCHKDS11 3             WHRCHKDS12 3          
   SUPPORCH3 3              BIOHUSBX3 3              BIONUMHX3 3           
   MARENDHX3 3              WNDIEHX_M3 3             WNDIEHX_Y3 4          
   CMHSBDIEX3 4             DIVDATHX_M3 3            DIVDATHX_Y3 4         
   CMDIVORCX3 4             WNSTPHX_M3 3             WNSTPHX_Y3 4          
   CMSTPHSBX3 4             WHMARHX_M4 3             WHMARHX_Y4 4          
   CMMARRHX4 4              AGEMARHX4 3              HXAGEMAR4 3           
   DOBHUSBX_M4 3            DOBHUSBX_Y4 4            CMHSBDOBX4 4          
   LVTOGHX4 3               STRTOGHX_M4 3            STRTOGHX_Y4 4         
   CMPMCOHX4 4              ENGAGHX4 3               HSBMULT4 3            
   HSBRACE4 3               HSBHRACE4 3              HSBNRACE4 3           
   CHEDMARN4 3              MARBEFHX4 3              KIDSHX4 3             
   NUMKDSHX4 3              KIDLIVHX4 3              CHKID18A4 3           
   CHKID18B4 3              WHRCHKDS13 3             WHRCHKDS14 3          
   WHRCHKDS15 3             WHRCHKDS16 3             SUPPORCH4 3           
   BIOHUSBX4 3              BIONUMHX4 3              MARENDHX4 3           
   WNDIEHX_M4 3             WNDIEHX_Y4 3             CMHSBDIEX4 3          
   DIVDATHX_M4 3            DIVDATHX_Y4 4            CMDIVORCX4 4          
   WNSTPHX_M4 3             WNSTPHX_Y4 4             CMSTPHSBX4 4          
   WHMARHX_M5 3             WHMARHX_Y5 4             CMMARRHX5 4           
   AGEMARHX5 3              HXAGEMAR5 3              DOBHUSBX_M5 3         
   DOBHUSBX_Y5 4            CMHSBDOBX5 4             LVTOGHX5 3            
   STRTOGHX_M5 3            STRTOGHX_Y5 4            CMPMCOHX5 4           
   ENGAGHX5 3               CHEDMARN5 3              MARBEFHX5 3           
   KIDSHX5 3                NUMKDSHX5 3              KIDLIVHX5 3           
   CHKID18A5 3              CHKID18B5 3              WHRCHKDS17 3          
   WHRCHKDS18 3             WHRCHKDS19 3             WHRCHKDS20 3          
   SUPPORCH5 3              BIOHUSBX5 3              BIONUMHX5 3           
   MARENDHX5 3              WNDIEHX_M5 3             WNDIEHX_Y5 3          
   CMHSBDIEX5 3             DIVDATHX_M5 3            DIVDATHX_Y5 3         
   CMDIVORCX5 3             WNSTPHX_M5 3             WNSTPHX_Y5 4          
   CMSTPHSBX5 4             CMMARRCH 4               CMDOBCH 4             
   PREVHUSB 3               WNSTRTCP_M 3             WNSTRTCP_Y 4          
   CMSTRTCP 4               CPHERAGE 3               CPHISAGE 3            
   WNCPBRN_M 3              WNCPBRN_Y 4              CMDOBCP 4             
   CPENGAG1 3               WILLMARR 3               CURCOHMULT 3          
   CURCOHRACE 3             CURCOHHRACE 3            CURCOHNRACE 3         
   CPEDUC 3                 CPMARBEF 3               CPKIDS 3              
   CPNUMKDS 3               CPKIDLIV 3               CPKID18A 3            
   CPKID18B 3               WHRCPKDS1 3              WHRCPKDS2 3           
   WHRCPKDS3 3              WHRCPKDS4 3              SUPPORCP 3            
   BIOCP 3                  BIONUMCP 3               CMSTRTHP 4            
   LIVEOTH 3                EVRCOHAB 3               HMOTHMEN 3            
   PREVCOHB 3               STRTOTHX_M 3             STRTOTHX_Y 4          
   CMCOHSTX 4               HERAGECX 3               HISAGECX 3            
   WNBRNCX_M 3              WNBRNCX_Y 4              CMDOBCX 4             
   ENGAG1CX 3               COH1MULT 3               COH1RACE 3            
   COH1HRACE 3              COH1NRACE 3              MAREVCX 3             
   CXKIDS 3                 BIOFCPX 3                BIONUMCX 3            
   STPTOGCX_M 3             STPTOGCX_Y 4             CMSTPCOHX 4           
   STRTOTHX_M2 3            STRTOTHX_Y2 4            CMCOHSTX2 4           
   HERAGECX2 3              HISAGECX2 3              WNBRNCX_M2 3          
   WNBRNCX_Y2 4             CMDOBCX2 4               ENGAG1CX2 3           
   MAREVCX2 3               CXKIDS2 3                BIOFCPX2 3            
   BIONUMCX2 3              STPTOGCX_M2 3            STPTOGCX_Y2 4         
   CMSTPCOHX2 4             STRTOTHX_M3 3            STRTOTHX_Y3 4         
   CMCOHSTX3 4              HERAGECX3 3              HISAGECX3 3           
   WNBRNCX_M3 3             WNBRNCX_Y3 4             CMDOBCX3 4            
   ENGAG1CX3 3              MAREVCX3 3               CXKIDS3 3             
   BIOFCPX3 3               BIONUMCX3 3              STPTOGCX_M3 3         
   STPTOGCX_Y3 4            CMSTPCOHX3 4             STRTOTHX_M4 3         
   STRTOTHX_Y4 4            CMCOHSTX4 4              HERAGECX4 3           
   HISAGECX4 3              WNBRNCX_M4 3             WNBRNCX_Y4 4          
   CMDOBCX4 4               ENGAG1CX4 3              MAREVCX4 3            
   CXKIDS4 3                BIOFCPX4 3               BIONUMCX4 3           
   STPTOGCX_M4 3            STPTOGCX_Y4 4            CMSTPCOHX4 4          
   COHCHANCE 3              MARRCHANCE 3             PMARCOH 3             
   EVERSEX 3                RHADSEX 3                YNOSEX 3              
   WNFSTSEX_M 3             WNFSTSEX_Y 4             CMFSTSEX 4            
   AGEFSTSX 3               C_SEX18 3                C_SEX15 3             
   C_SEX20 3                GRFSTSX 3                SXMTONCE 3            
   TALKPAR1 3               TALKPAR2 3               TALKPAR3 3            
   TALKPAR4 3               TALKPAR5 3               TALKPAR6 3            
   TALKPAR7 3               SEDNO 3                  SEDNOG 3              
   SEDNOSX 3                SEDBC 3                  SEDBCG 3              
   SEDBCSX 3                SEDWHBC 3                SEDWHBCG 3            
   SEDWBCSX 3               SEDCOND 3                SEDCONDG 3            
   SEDCONSX 3               SEDSTD 3                 SEDSTDG 3             
   SEDSTDSX 3               SEDHIV 3                 SEDHIVG 3             
   SEDHIVSX 3               SEDABST 3                SEDABSTG 3            
   SEDABSSX 3               SAMEMAN 3                WHOFSTPR 3            
   FPAGE 3                  FPRELAGE 3               FPRELYRS 3            
   KNOWFP 3                 STILFPSX 3               LSTSEXFP_M 3          
   LSTSEXFP_Y 4             CMLSEXFP 4               CMFPLAST 4            
   FPOTHREL 3               FPEDUC 3                 FSEXMULT 3            
   FSEXRACE 3               FSEXHRACE 3              FSEXNRACE 3           
   FPRN 3                   WHICH1ST 3               SEXAFMEN 3            
   WNSEXAFM_M 3             WNSEXAFM_Y 4             CMSEXAFM 4            
   AGESXAFM 3               AFMEN18 3                AFMEN15 3             
   AFMEN20 3                LIFEPRT 4                LIFEPRT_LO 4          
   LIFEPRT_HI 4             PTSB4MAR 4               PTSB4MAR_LO 4         
   PTSB4MAR_HI 4            MON12PRT 4               MON12PRT_LO 4         
   MON12PRT_HI 4            PARTS12 4                LIFEPRTS 3            
   WHOSNC1Y 3               MATCHFP 3                MATCHHP 3             
   P1YRELP 3                CMLSEX 4                 P1YLSEX_M 3           
   P1YLSEX_Y 4              P1YCURRP 3               PCURRNT 3             
   MATCHFP2 3               MATCHHP2 3               P1YRELP2 3            
   CMLSEX2 4                P1YLSEX_M2 3             P1YLSEX_Y2 4          
   P1YCURRP2 3              PCURRNT2 3               MATCHFP3 3            
   MATCHHP3 3               P1YRELP3 3               CMLSEX3 4             
   P1YLSEX_M3 3             P1YLSEX_Y3 4             P1YCURRP3 3           
   PCURRNT3 3               P1YOTHREL 3              P1YRAGE 3             
   P1YHSAGE 3               P1YRF 3                  P1YFSEX_M 3           
   P1YFSEX_Y 4              CMFSEX 4                 CMFSEXTOT 4           
   P1YEDUC 3                P1YMULT1 3               P1YRACE1 3            
   P1YHRACE1 3              P1YNRACE1 3              P1YRN 3               
   P1YOTHREL2 3             P1YRAGE2 3               P1YHSAGE2 3           
   P1YRF2 3                 P1YFSEX_M2 3             P1YFSEX_Y2 4          
   CMFSEX2 4                CMFSEXTOT2 4             P1YEDUC2 3            
   P1YMULT2 3               P1YRACE2 3               P1YHRACE2 3           
   P1YNRACE2 3              P1YRN2 3                 P1YOTHREL3 3          
   P1YRAGE3 3               P1YHSAGE3 3              P1YRF3 3              
   P1YFSEX_M3 3             P1YFSEX_Y3 4             CMFSEX3 4             
   CMFSEXTOT3 4             P1YEDUC3 3               P1YMULT3 3            
   P1YRACE3 3               P1YHRACE3 3              P1YNRACE3 3           
   P1YRN3 3                 CURRPRTT 3               CURRPRTS 3            
   CMCURRP1 4               CMCURRP2 4               CMCURRP3 3            
   EVERTUBS 3               ESSURE 3                 EVERHYST 3            
   EVEROVRS 3               EVEROTHR 3               WHTOOPRC 3            
   ONOTFUNC 3               DFNLSTRL 3               ANYTUBAL 3            
   HYST 3                   OVAREM 3                 OTHR 3                
   ANYFSTER 3               ANYOPSMN 3               WHATOPSM 3            
   DFNLSTRM 3               ANYMSTER 3               ANYVAS 3              
   OTHRM 3                  DATFEMOP_M 3             DATFEMOP_Y 4          
   CMTUBLIG 4               PLCFEMOP 3               INPATIEN 3            
   PAYRSTER1 3              PAYRSTER2 3              RHADALL 3             
   HHADALL 3                FMEDREAS1 3              FMEDREAS2 3           
   FMEDREAS3 3              FMEDREAS4 3              BCREAS 3              
   BCWHYF 3                 MINCDNNR 3               DATFEMOP_M2 3         
   DATFEMOP_Y2 4            CMHYST 4                 PLCFEMOP2 3           
   PAYRSTER6 3              PAYRSTER7 3              RHADALL2 3            
   HHADALL2 3               FMEDREAS7 3              FMEDREAS8 3           
   FMEDREAS9 3              FMEDREAS10 3             BCREAS2 3             
   BCWHYF2 3                MINCDNNR2 3              DATFEMOP_M3 3         
   DATFEMOP_Y3 4            CMOVAREM 4               PLCFEMOP3 3           
   PAYRSTER11 3             PAYRSTER12 3             RHADALL3 3            
   HHADALL3 3               FMEDREAS13 3             FMEDREAS14 3          
   FMEDREAS15 3             FMEDREAS16 3             BCREAS3 3             
   BCWHYF3 3                MINCDNNR3 3              DATFEMOP_M4 3         
   DATFEMOP_Y4 4            CMOTSURG 4               PLCFEMOP4 3           
   PAYRSTER16 3             PAYRSTER17 3             RHADALL4 3            
   HHADALL4 3               FMEDREAS19 3             FMEDREAS20 3          
   FMEDREAS21 3             FMEDREAS22 3             BCREAS4 3             
   BCWHYF4 3                MINCDNNR4 3              CMOPER1 4             
   OPERSAME1 3              OPERSAME2 3              OPERSAME3 3           
   OPERSAME4 3              OPERSAME5 3              OPERSAME6 3           
   DATEOPMN_M 3             DATEOPMN_Y 4             CMMALEOP 4            
   WITHIMOP 3               VASJAN4YR 3              PLACOPMN 3            
   PAYMSTER1 3              PAYMSTER2 3              RHADALLM 3            
   HHADALLM 3               MEDREAS1 3               MEDREAS2 3            
   BCREASM 3                BCWHYM 3                 MINCDNMN 3            
   REVSTUBL 3               DATRVSTB_M 3             DATRVSTB_Y 4          
   CMLIGREV 4               REVSVASX 3               DATRVVEX_M 3          
   DATRVVEX_Y 4             CMVASREV 4               TUBS 3                
   VASECT 3                 RSURGSTR 3               PSURGSTR 3            
   ONLYTBVS 3               RWANTRVT 3               MANWANTT 3            
   RWANTREV 3               MANWANTR 3               POSIBLPG 3            
   REASIMPR 3               POSIBLMN 3               REASIMPP 3            
   CANHAVER 3               REASDIFF1 3              REASDIFF2 3           
   REASDIFF3 3              REASDIFF4 3              REASDIFF5 3           
   CANHAVEM 3               PREGNONO 3               REASNONO1 3           
   REASNONO2 3              REASNONO3 3              RSTRSTAT 3            
   PSTRSTAT 3               PILL 3                   CONDOM 3              
   VASECTMY 3               DEPOPROV 3               WIDRAWAL 3            
   RHYTHM 3                 SDAYCBDS 3               TEMPSAFE 3            
   PATCH 3                  RING 3                   MORNPILL 3            
   ECTIMESX 3               ECREASON1 3              ECREASON2 3           
   ECREASON3 3              ECRX 3                   ECWHERE 3             
   ECWHEN 3                 OTHRMETH01 3             OTHRMETH02 3          
   OTHRMETH03 3             OTHRMETH04 3             OTHRMETH05 3          
   OTHRMETH06 3             OTHRMETH07 3             EVIUDTYP1 3           
   EVIUDTYP2 3              NEWMETH 3                EVERUSED 3            
   METHDISS 3               METHSTOP01 3             METHSTOP02 3          
   METHSTOP03 3             METHSTOP04 3             METHSTOP05 3          
   METHSTOP06 3             METHSTOP07 3             METHSTOP08 3          
   METHSTOP09 3             METHSTOP10 3             REASPILL01 3          
   REASPILL02 3             REASPILL03 3             REASPILL04 3          
   REASPILL05 3             REASPILL06 3             STOPPILL1 3           
   STOPPILL2 3              STOPPILL3 3              STOPPILL4 3           
   STOPPILL5 3              STOPPILL6 3              REASCOND01 3          
   REASCOND02 3             REASCOND03 3             REASCOND04 3          
   REASCOND05 3             REASCOND06 3             REASCOND07 3          
   STOPCOND1 3              STOPCOND2 3              REASDEPO01 3          
   REASDEPO02 3             REASDEPO03 3             REASDEPO04 3          
   REASDEPO05 3             REASDEPO06 3             REASDEPO07 3          
   REASDEPO08 3             STOPDEPO1 3              STOPDEPO2 3           
   STOPDEPO3 3              STOPDEPO4 3              STOPDEPO5 3           
   TYPEIUD_1 3              TYPEIUD_2 3              REASIUD01 3           
   REASIUD02 3              REASIUD03 3              REASIUD04 3           
   REASIUD05 3              STOPIUD1 3               STOPIUD2 3            
   STOPIUD3 3               STOPIUD4 3               STOPIUD5 3            
   FIRSMETH1 3              FIRSMETH2 3              FIRSMETH3 3           
   FIRSMETH4 3              NUMFIRSM 3               DRUGDEV 3             
   DRUGDEV2 3               DRUGDEV3 3               DRUGDEV4 3            
   FIRSTIME1 3              FIRSTIME2 3              USEFSTSX 3            
   CMFIRSM 4                MTHFSTSX1 3              MTHFSTSX2 3           
   MTHFSTSX3 3              MTHFSTSX4 3              WNFSTUSE_M 3          
   WNFSTUSE_Y 4             FMETHPRS 3               FMETHPRS2 3           
   FMETHPRS3 3              FMETHPRS4 3              CMFSTUSE 4            
   AGEFSTUS 3               PLACGOTF 3               PLACGOTF2 3           
   PLACGOTF3 3              PLACGOTF4 3              USEFRSTS 3            
   MTHFRSTS1 3              MTHFRSTS2 3              MTHFRSTS3 3           
   MTHFRSTS4 3              INTR_EC3 3               CMMONSX 4             
   MONSX 3                  CMMONSX2 4               MONSX2 3              
   CMMONSX3 4               MONSX3 3                 CMMONSX4 4            
   MONSX4 3                 CMMONSX5 4               MONSX5 3              
   CMMONSX6 4               MONSX6 3                 CMMONSX7 4            
   MONSX7 3                 CMMONSX8 4               MONSX8 3              
   CMMONSX9 4               MONSX9 3                 CMMONSX10 4           
   MONSX10 3                CMMONSX11 4              MONSX11 3             
   CMMONSX12 4              MONSX12 3                CMMONSX13 4           
   MONSX13 3                CMMONSX14 4              MONSX14 3             
   CMMONSX15 4              MONSX15 3                CMMONSX16 4           
   MONSX16 3                CMMONSX17 4              MONSX17 3             
   CMMONSX18 4              MONSX18 3                CMMONSX19 4           
   MONSX19 3                CMMONSX20 4              MONSX20 3             
   CMMONSX21 4              MONSX21 3                CMMONSX22 4           
   MONSX22 3                CMMONSX23 4              MONSX23 3             
   CMMONSX24 4              MONSX24 3                CMMONSX25 4           
   MONSX25 3                CMMONSX26 4              MONSX26 3             
   CMMONSX27 4              MONSX27 3                CMMONSX28 4           
   MONSX28 3                CMMONSX29 4              MONSX29 3             
   CMMONSX30 4              MONSX30 3                CMMONSX31 4           
   MONSX31 3                CMMONSX32 4              MONSX32 3             
   CMMONSX33 4              MONSX33 3                CMMONSX34 4           
   MONSX34 3                CMMONSX35 4              MONSX35 3             
   CMMONSX36 4              MONSX36 3                CMMONSX37 4           
   MONSX37 3                CMMONSX38 4              MONSX38 3             
   CMMONSX39 4              MONSX39 3                CMMONSX40 4           
   MONSX40 3                CMMONSX41 4              MONSX41 3             
   CMMONSX42 4              MONSX42 3                CMMONSX43 4           
   MONSX43 3                CMMONSX44 4              MONSX44 3             
   CMMONSX45 4              MONSX45 3                CMMONSX46 4           
   MONSX46 3                CMMONSX47 4              MONSX47 3             
   CMMONSX48 4              MONSX48 3                CMSTRTMC 4            
   CMENDMC 4                INTR_ED4A 3              NUMMCMON 3            
   MC1MONS1 4               MC1SIMSQ 3               MC1MONS2 4            
   MC1MONS3 4               DATBEGIN_M 3             DATBEGIN_Y 4          
   CMDATBEGIN 4             CURRMETH1 3              CURRMETH2 3           
   CURRMETH3 3              CURRMETH4 3              LSTMONMETH1 3         
   LSTMONMETH2 3            LSTMONMETH3 3            LSTMONMETH4 3         
   PILL_12 3                DIAPH_12 3               IUD_12 3              
   IMPLANT_12 3             DEPO_12 3                CERVC_12 3            
   MPILL_12 3               PATCH_12 3               RING_12 3             
   METHX1 3                 METHX2 3                 METHX3 3              
   METHX4 3                 METHX5 3                 METHX6 3              
   METHX7 3                 METHX8 3                 METHX9 3              
   METHX10 3                METHX11 3                METHX12 3             
   METHX13 3                METHX14 3                METHX15 3             
   METHX16 3                METHX17 3                METHX18 3             
   METHX19 3                METHX20 3                METHX21 3             
   METHX22 3                METHX23 3                METHX24 3             
   METHX25 3                METHX26 3                METHX27 3             
   METHX28 3                METHX29 3                METHX30 3             
   METHX31 3                METHX32 3                METHX33 3             
   METHX34 3                METHX35 3                METHX36 3             
   METHX37 3                METHX38 3                METHX39 3             
   METHX40 3                METHX41 3                METHX42 3             
   METHX43 3                METHX44 3                METHX45 3             
   METHX46 3                METHX47 3                METHX48 3             
   METHX49 3                METHX50 3                METHX51 3             
   METHX52 3                METHX53 3                METHX54 3             
   METHX55 3                METHX56 3                METHX57 3             
   METHX58 3                METHX59 3                METHX60 3             
   METHX61 3                METHX62 3                METHX63 3             
   METHX64 3                METHX65 3                METHX66 3             
   METHX67 3                METHX68 3                METHX69 3             
   METHX70 3                METHX71 3                METHX72 3             
   METHX73 3                METHX74 3                METHX75 3             
   METHX76 3                METHX77 3                METHX78 3             
   METHX79 3                METHX80 3                METHX81 3             
   METHX82 3                METHX83 3                METHX84 3             
   METHX85 3                METHX86 3                METHX87 3             
   METHX88 3                METHX89 3                METHX90 3             
   METHX91 3                METHX92 3                METHX93 3             
   METHX94 3                METHX95 3                METHX96 3             
   METHX97 3                METHX98 3                METHX99 3             
   METHX100 3               METHX101 3               METHX102 3            
   METHX103 3               METHX104 3               METHX105 3            
   METHX106 3               METHX107 3               METHX108 3            
   METHX109 3               METHX110 3               METHX111 3            
   METHX112 3               METHX113 3               METHX114 3            
   METHX115 3               METHX116 3               METHX117 3            
   METHX118 3               METHX119 3               METHX120 3            
   METHX121 3               METHX122 3               METHX123 3            
   METHX124 3               METHX125 3               METHX126 3            
   METHX127 3               METHX128 3               METHX129 3            
   METHX130 3               METHX131 3               METHX132 3            
   METHX133 3               METHX134 3               METHX135 3            
   METHX136 3               METHX137 3               METHX138 3            
   METHX139 3               METHX140 3               METHX141 3            
   METHX142 3               METHX143 3               METHX144 3            
   METHX145 3               METHX146 3               METHX147 3            
   METHX148 3               METHX149 3               METHX150 3            
   METHX151 3               METHX152 3               METHX153 3            
   METHX154 3               METHX155 3               METHX156 3            
   METHX157 3               METHX158 3               METHX159 3            
   METHX160 3               METHX161 3               METHX162 3            
   METHX163 3               METHX164 3               METHX165 3            
   METHX166 3               METHX167 3               METHX168 3            
   METHX169 3               METHX170 3               METHX171 3            
   METHX172 3               METHX173 3               METHX174 3            
   METHX175 3               METHX176 3               METHX177 3            
   METHX178 3               METHX179 3               METHX180 3            
   METHX181 3               METHX182 3               METHX183 3            
   METHX184 3               METHX185 3               METHX186 3            
   METHX187 3               METHX188 3               METHX189 3            
   METHX190 3               METHX191 3               METHX192 3            
   CMMHCALX1 4              CMMHCALX2 4              CMMHCALX3 4           
   CMMHCALX4 4              CMMHCALX5 4              CMMHCALX6 4           
   CMMHCALX7 4              CMMHCALX8 4              CMMHCALX9 4           
   CMMHCALX10 4             CMMHCALX11 4             CMMHCALX12 4          
   CMMHCALX13 4             CMMHCALX14 4             CMMHCALX15 4          
   CMMHCALX16 4             CMMHCALX17 4             CMMHCALX18 4          
   CMMHCALX19 4             CMMHCALX20 4             CMMHCALX21 4          
   CMMHCALX22 4             CMMHCALX23 4             CMMHCALX24 4          
   CMMHCALX25 4             CMMHCALX26 4             CMMHCALX27 4          
   CMMHCALX28 4             CMMHCALX29 4             CMMHCALX30 4          
   CMMHCALX31 4             CMMHCALX32 4             CMMHCALX33 4          
   CMMHCALX34 4             CMMHCALX35 4             CMMHCALX36 4          
   CMMHCALX37 4             CMMHCALX38 4             CMMHCALX39 4          
   CMMHCALX40 4             CMMHCALX41 4             CMMHCALX42 4          
   CMMHCALX43 4             CMMHCALX44 4             CMMHCALX45 4          
   CMMHCALX46 4             CMMHCALX47 4             CMMHCALX48 4          
   NUMMULTX1 3              NUMMULTX2 3              NUMMULTX3 3           
   NUMMULTX4 3              NUMMULTX5 3              NUMMULTX6 3           
   NUMMULTX7 3              NUMMULTX8 3              NUMMULTX9 3           
   NUMMULTX10 3             NUMMULTX11 3             NUMMULTX12 3          
   NUMMULTX13 3             NUMMULTX14 3             NUMMULTX15 3          
   NUMMULTX16 3             NUMMULTX17 3             NUMMULTX18 3          
   NUMMULTX19 3             NUMMULTX20 3             NUMMULTX21 3          
   NUMMULTX22 3             NUMMULTX23 3             NUMMULTX24 3          
   NUMMULTX25 3             NUMMULTX26 3             NUMMULTX27 3          
   NUMMULTX28 3             NUMMULTX29 3             NUMMULTX30 3          
   NUMMULTX31 3             NUMMULTX32 3             NUMMULTX33 3          
   NUMMULTX34 3             NUMMULTX35 3             NUMMULTX36 3          
   NUMMULTX37 3             NUMMULTX38 3             NUMMULTX39 3          
   NUMMULTX40 3             NUMMULTX41 3             NUMMULTX42 3          
   NUMMULTX43 3             NUMMULTX44 3             NUMMULTX45 3          
   NUMMULTX46 3             NUMMULTX47 3             NUMMULTX48 3          
   SALMX1 3                 SALMX2 3                 SALMX3 3              
   SALMX4 3                 SALMX5 3                 SALMX6 3              
   SALMX7 3                 SALMX8 3                 SALMX9 3              
   SALMX10 3                SALMX11 3                SALMX12 3             
   SALMX13 3                SALMX14 3                SALMX15 3             
   SALMX16 3                SALMX17 3                SALMX18 3             
   SALMX19 3                SALMX20 3                SALMX21 3             
   SALMX22 3                SALMX23 3                SALMX24 3             
   SALMX25 3                SALMX26 3                SALMX27 3             
   SALMX28 3                SALMX29 3                SALMX30 3             
   SALMX31 3                SALMX32 3                SALMX33 3             
   SALMX34 3                SALMX35 3                SALMX36 3             
   SALMX37 3                SALMX38 3                SALMX39 3             
   SALMX40 3                SALMX41 3                SALMX42 3             
   SALMX43 3                SALMX44 3                SALMX45 3             
   SALMX46 3                SALMX47 3                SALMX48 3             
   SAYX1 3                  SAYX2 3                  SAYX3 3               
   SAYX4 3                  SAYX5 3                  SAYX6 3               
   SAYX7 3                  SAYX8 3                  SAYX9 3               
   SAYX10 3                 SAYX11 3                 SAYX12 3              
   SAYX13 3                 SAYX14 3                 SAYX15 3              
   SAYX16 3                 SAYX17 3                 SAYX18 3              
   SAYX19 3                 SAYX20 3                 SAYX21 3              
   SAYX22 3                 SAYX23 3                 SAYX24 3              
   SAYX25 3                 SAYX26 3                 SAYX27 3              
   SAYX28 3                 SAYX29 3                 SAYX30 3              
   SAYX31 3                 SAYX32 3                 SAYX33 3              
   SAYX34 3                 SAYX35 3                 SAYX36 3              
   SAYX37 3                 SAYX38 3                 SAYX39 3              
   SAYX40 3                 SAYX41 3                 SAYX42 3              
   SAYX43 3                 SAYX44 3                 SAYX45 3              
   SAYX46 3                 SAYX47 3                 SAYX48 3              
   SIMSEQX1 3               SIMSEQX2 3               SIMSEQX3 3            
   SIMSEQX4 3               SIMSEQX5 3               SIMSEQX6 3            
   SIMSEQX7 3               SIMSEQX8 3               SIMSEQX9 3            
   SIMSEQX10 3              SIMSEQX11 3              SIMSEQX12 3           
   SIMSEQX13 3              SIMSEQX14 3              SIMSEQX15 3           
   SIMSEQX16 3              SIMSEQX17 3              SIMSEQX18 3           
   SIMSEQX19 3              SIMSEQX20 3              SIMSEQX21 3           
   SIMSEQX22 3              SIMSEQX23 3              SIMSEQX24 3           
   SIMSEQX25 3              SIMSEQX26 3              SIMSEQX27 3           
   SIMSEQX28 3              SIMSEQX29 3              SIMSEQX30 3           
   SIMSEQX31 3              SIMSEQX32 3              SIMSEQX33 3           
   SIMSEQX34 3              SIMSEQX35 3              SIMSEQX36 3           
   SIMSEQX37 3              SIMSEQX38 3              SIMSEQX39 3           
   SIMSEQX40 3              SIMSEQX41 3              SIMSEQX42 3           
   SIMSEQX43 3              SIMSEQX44 3              SIMSEQX45 3           
   SIMSEQX46 3              SIMSEQX47 3              SIMSEQX48 3           
   USELSTP 3                LSTMTHP1 3               LSTMTHP2 3            
   LSTMTHP3 3               LSTMTHP4 3               USEFSTP 3             
   FSTMTHP1 3               FSTMTHP2 3               FSTMTHP3 3            
   FSTMTHP4 3               USELSTP2 3               LSTMTHP5 3            
   LSTMTHP6 3               LSTMTHP7 3               LSTMTHP8 3            
   USEFSTP2 3               FSTMTHP5 3               FSTMTHP6 3            
   FSTMTHP7 3               FSTMTHP8 3               USELSTP3 3            
   LSTMTHP9 3               LSTMTHP10 3              LSTMTHP11 3           
   LSTMTHP12 3              USEFSTP3 3               FSTMTHP9 3            
   FSTMTHP10 3              FSTMTHP11 3              FSTMTHP12 3           
   WYNOTUSE 3               HPPREGQ 3                DURTRY_N 3            
   DURTRY_P 3               WHYNOUSING1 3            WHYNOUSING2 3         
   WHYNOUSING3 3            WHYNOUSING4 3            WHYNOUSING5 3         
   WHYNOTPG1 3              WHYNOTPG2 3              MAINNOUSE 3           
   YUSEPILL1 3              YUSEPILL2 3              YUSEPILL3 3           
   YUSEPILL4 3              YUSEPILL5 3              YUSEPILL6 3           
   YUSEPILL7 3              IUDTYPE 3                PST4WKSX 4            
   PSWKCOND1 3              PSWKCOND2 4              COND1BRK 3            
   COND1OFF 3               CONDBRFL 4               CONDOFF 4             
   MISSPILL 3               P12MOCON 3               PXNOFREQ 3            
   BTHCON12 3               MEDTST12 3               BCCNS12 3             
   STEROP12 3               STCNS12 3                EMCON12 3             
   ECCNS12 3                NUMMTH12 3               PRGTST12 3            
   ABORT12 3                PAP12 3                  PELVIC12 3            
   PRENAT12 3               PARTUM12 3               STDSVC12 3            
   BARRIER1 3               BARRIER2 3               BARRIER3 3            
   BARRIER4 3               NUMSVC12 3               NUMBCVIS 3            
   BC12PLCX 3               BC12PLCX2 3              BC12PLCX3 3           
   BC12PLCX4 3              BC12PLCX5 3              BC12PLCX6 3           
   BC12PLCX7 3              BC12PLCX8 3              BC12PLCX9 3           
   BC12PLCX10 3             BC12PLCX11 3             BC12PLCX12 3          
   BC12PLCX13 3             BC12PLCX14 3             BC12PLCX15 3          
   IDCLINIC 3               PGTSTBC2 3               PAPPLBC2 3            
   PAPPELEC 3               STDTSCON 3               WHYPSTD 3             
   BC12PAYX1 3              BC12PAYX2 3              BC12PAYX3 3           
   BC12PAYX4 3              BC12PAYX7 3              BC12PAYX8 3           
   BC12PAYX9 3              BC12PAYX10 3             BC12PAYX13 3          
   BC12PAYX14 3             BC12PAYX15 3             BC12PAYX16 3          
   BC12PAYX19 3             BC12PAYX20 3             BC12PAYX21 3          
   BC12PAYX22 3             BC12PAYX25 3             BC12PAYX26 3          
   BC12PAYX27 3             BC12PAYX28 3             BC12PAYX31 3          
   BC12PAYX32 3             BC12PAYX33 3             BC12PAYX34 3          
   BC12PAYX37 3             BC12PAYX38 3             BC12PAYX39 3          
   BC12PAYX40 3             BC12PAYX43 3             BC12PAYX44 3          
   BC12PAYX45 3             BC12PAYX46 3             BC12PAYX49 3          
   BC12PAYX50 3             BC12PAYX51 3             BC12PAYX52 3          
   BC12PAYX55 3             BC12PAYX56 3             BC12PAYX57 3          
   BC12PAYX58 3             BC12PAYX61 3             BC12PAYX62 3          
   BC12PAYX63 3             BC12PAYX64 3             BC12PAYX67 3          
   BC12PAYX68 3             BC12PAYX69 3             BC12PAYX70 3          
   BC12PAYX73 3             BC12PAYX74 3             BC12PAYX75 3          
   BC12PAYX76 3             BC12PAYX79 3             BC12PAYX80 3          
   BC12PAYX81 3             BC12PAYX82 3             BC12PAYX85 3          
   BC12PAYX86 3             BC12PAYX87 3             BC12PAYX88 3          
   REGCAR12_F_01 3          REGCAR12_F_02 3          REGCAR12_F_03 3       
   REGCAR12_F_04 3          REGCAR12_F_05 3          REGCAR12_F_06 3       
   REGCAR12_F_07 3          REGCAR12_F_08 3          REGCAR12_F_09 3       
   REGCAR12_F_10 3          REGCAR12_F_11 3          REGCAR12_F_12 3       
   REGCAR12_F_13 3          REGCAR12_F_14 3          REGCAR12_F_15 3       
   DRUGDEVE 3               FSTSVC12 3               WNFSTSVC_M 3          
   WNFSTSVC_Y 4             CMFSTSVC 4               B4AFSTIN 3            
   TMAFTIN 3                FSTSERV1 3               FSTSERV2 3            
   FSTSERV3 3               FSTSERV4 3               FSTSERV5 3            
   FSTSERV6 3               BCPLCFST 3               EVERFPC 3             
   KNDMDHLP01 3             KNDMDHLP02 3             KNDMDHLP03 3          
   KNDMDHLP04 3             KNDMDHLP05 3             KNDMDHLP06 3          
   KNDMDHLP07 3             KNDMDHLP08 3             LASTPAP 3             
   MREASPAP 3               AGEFPAP 3                AGEFPAP2 3            
   ABNPAP3 3                INTPAP 3                 PELWPAP 3             
   LASTPEL 3                MREASPEL 3               AGEFPEL 3             
   AGEPEL2 3                INTPEL 3                 EVHPVTST 3            
   HPVWPAP 3                LASTHPV 3                MREASHPV 3            
   AGEFHPV 3                AGEHPV2 3                INTHPV 3              
   RWANT 3                  PROBWANT 3               PWANT 3               
   JINTEND 3                JSUREINT 3               JINTENDN 3            
   JEXPECTL 3               JEXPECTS 3               JINTNEXT 3            
   INTEND 3                 SUREINT 3                INTENDN 3             
   EXPECTL 3                EXPECTS 3                INTNEXT 3             
   HLPPRG 3                 HOWMANYR 3               SEEKWHO1 3            
   SEEKWHO2 3               TYPALLPG1 3              TYPALLPG2 3           
   TYPALLPG3 3              TYPALLPG4 3              TYPALLPG5 3           
   TYPALLPG6 3              WHOTEST 3                WHARTIN 3             
   OTMEDHEP1 3              OTMEDHEP2 3              OTMEDHEP3 3           
   OTMEDHEP4 3              INSCOVPG 3               FSTHLPPG_M 3          
   FSTHLPPG_Y 4             CMPGVIS1 4               TRYLONG2 3            
   UNIT_TRYLONG 3           HLPPGNOW 3               RCNTPGH_M 3           
   RCNTPGH_Y 4              CMPGVISL 4               NUMVSTPG 3            
   PRGVISIT 3               HLPMC 3                  TYPALLMC1 3           
   TYPALLMC2 3              TYPALLMC3 3              TYPALLMC4 3           
   TYPALLMC5 3              TYPALLMC6 3              MISCNUM 3             
   INFRTPRB1 3              INFRTPRB2 3              INFRTPRB3 3           
   INFRTPRB4 3              INFRTPRB5 3              DUCHFREQ 3            
   PID 3                    PIDSYMPT 3               PIDTX 3               
   LSTPIDTX_M 3             LSTPIDTX_Y 4             CMPIDLST 4            
   DIABETES 3               GESTDIAB 3               UF 3                  
   ENDO 3                   OVUPROB 3                DEAF 3                
   BLIND 3                  DIFDECIDE 3              DIFWALK 3             
   DIFDRESS 3               DIFOUT 3                 EVRCANCER 3           
   AGECANCER 3              CANCTYPE 3               PRECANCER 3           
   MAMMOG 3                 AGEMAMM1 3               REASMAMM1 3           
   FAMHYST 3                FAMRISK 3                PILLRISK 3            
   ALCORISK 3               CANCFUTR 3               CANCWORRY 3           
   DONBLOOD 3               HIVTEST 3                NOHIVTST 3            
   WHENHIV_M 3              WHENHIV_Y 4              CMHIVTST 4            
   HIVTSTYR 3               HIVRESULT 3              WHYNOGET 3            
   PLCHIV 3                 RHHIVT1 3                RHHIVT21 3            
   RHHIVT22 3               HIVTST 3                 WHOSUGG 3             
   TALKDOCT 3               AIDSTALK01 3             AIDSTALK02 3          
   AIDSTALK03 3             AIDSTALK04 3             AIDSTALK05 3          
   AIDSTALK06 3             AIDSTALK07 3             AIDSTALK08 3          
   AIDSTALK09 3             AIDSTALK10 3             AIDSTALK11 3          
   RETROVIR 3               PREGHIV 3                EVERVACC 3            
   HPVSHOT1 3               HPVSEX1 3                VACCPROB 3            
   USUALCAR 3               USLPLACE 3               USL12MOS 3            
   COVER12 3                NUMNOCOV 3               COVERHOW01 3          
   COVERHOW02 3             COVERHOW03 3             COVERHOW04 3          
   NOWCOVER01 3             NOWCOVER02 3             NOWCOVER03 3          
   PARINSUR 3               SAMEADD 3                CNTRY10 3             
   BRNOUT 3                 YRSTRUS 4                RELRAISD 3            
   ATTND14 3                RELCURR 3                RELTRAD 3             
   FUNDAM1 3                FUNDAM2 3                FUNDAM3 3             
   FUNDAM4 3                RELDLIFE 3               ATTNDNOW 3            
   WRK12MOS 3               FPT12MOS 3               DOLASTWK1 3           
   DOLASTWK2 3              DOLASTWK3 3              DOLASTWK4 3           
   DOLASTWK5 3              RWRKST 3                 WORKP12 3             
   RPAYJOB 3                RNUMJOB 3                RFTPTX 3              
   REARNTY 3                SPLSTWK1 3               SPLSTWK2 3            
   SPLSTWK3 3               SPLSTWK4 3               SPLSTWK5 3            
   SPWRKST 3                SPPAYJOB 3               SPNUMJOB 3            
   SPFTPTX 3                SPEARNTY 3               STAYTOG 3             
   SAMESEX 3                SXOK18 3                 SXOK16 3              
   CHUNLESS 3               CHSUPPOR 3               GAYADOPT 3            
   OKCOHAB 3                REACTSLF 3               CHBOTHER 3            
   MARRFAIL 3               CHCOHAB 3                PRVNTDIV 3            
   LESSPLSR 3               EMBARRAS 3               ACASILANG 3           
   GENHEALT 3               INCHES 3                 RWEIGHT 4             
   BMI 3                    ENGSPEAK 3               CASIBIRTH 3           
   CASILOSS 3               CASIABOR 3               CASIADOP 3            
   EVSUSPEN 3               GRADSUSP 3               SMK100 3              
   AGESMK 3                 SMOKE12 3                DRINK12 3             
   UNIT30D 3                DRINK30D 3               DRINKDAY 3            
   BINGE30 3                DRNKMOST 3               BINGE12 3             
   POT12 3                  COC12 3                  CRACK12 3             
   CRYSTMTH12 3             INJECT12 3               VAGSEX 3              
   AGEVAGR 3                AGEVAGM 3                CONDVAG 3             
   WHYCONDL 3               GETORALM 3               GIVORALM 3            
   CONDFELL 3               ANYORAL 3                TIMING 3              
   ANALSEX 3                CONDANAL 3               OPPSEXANY 3           
   OPPSEXGEN 3              CONDSEXL 3               WANTSEX1 3            
   VOLSEX1 3                HOWOLD 3                 GIVNDRUG 3            
   HEBIGOLD 3               ENDRELAT 3               WORDPRES 3            
   THRTPHYS 3               PHYSHURT 3               HELDDOWN 3            
   EVRFORCD 3               AGEFORC1 3               GIVNDRG2 3            
   HEBIGOL2 3               ENDRELA2 3               WRDPRES2 3            
   THRTPHY2 3               PHYSHRT2 3               HELDDWN2 3            
   PARTSLIF_1 4             PARTSLFV 3               PARTSLIF_2 4          
   OPPLIFENUM 4             PARTS12M_1 4             PARTS12V 3            
   PARTS12M_2 4             OPPYEARNUM 4             NEWYEAR 4             
   NEWLIFE 4                VAGNUM12 4               ORALNUM12 4           
   ANALNUM12 4              CURRPAGE 3               RELAGE 3              
   HOWMUCH 3                CURRPAGE2 3              RELAGE2 3             
   HOWMUCH2 3               CURRPAGE3 3              RELAGE3 3             
   HOWMUCH3 3               BISEXPRT 3               NONMONOG 3            
   NNONMONOG1 3             NNONMONOG2 3             NNONMONOG3 3          
   MALSHT12 3               PROSTFRQ 3               JOHNFREQ 3            
   HIVMAL12 3               GIVORALF 3               GETORALF 3            
   FEMSEX 3                 SAMESEXANY 3             FEMPARTS_1 4          
   FEMLIFEV 3               FEMPARTS_2 4             SAMLIFENUM 4          
   FEMPRT12_1 4             FEM12V 3                 FEMPRT12_2 4          
   SAMYEARNUM 4             SAMESEX1 3               MFLASTP 3             
   ATTRACT 3                ORIENT 3                 CONFCONC 3            
   TIMALON 3                RISKCHEK1 3              RISKCHEK2 3           
   RISKCHEK3 3              RISKCHEK4 3              CHLAMTST 3            
   STDOTHR12 3              STDTRT12 3               GON 3                 
   CHLAM 3                  HERPES 3                 GENWARTS 3            
   SYPHILIS 3               EVRINJECT 3              EVRSHARE 3            
   EARNTYPE 3               EARN 3                   EARNDK1 3             
   EARNDK2 3                EARNDK3 3                EARNDK4 3             
   WAGE 3                   SELFINC 3                SOCSEC 3              
   DISABIL 3                RETIRE 3                 SSI 3                 
   UNEMP 3                  CHLDSUPP 3               INTEREST 3            
   DIVIDEND 3               OTHINC 3                 TOINCWMY 3            
   TOTINC 3                 FMINCDK1 3               FMINCDK2 3            
   FMINCDK3 3               FMINCDK4 3               FMINCDK5 3            
   PUBASST 3                PUBASTYP1 3              FOODSTMP 3            
   WIC 3                    HLPTRANS 3               HLPCHLDC 3            
   HLPJOB 3                 FREEFOOD 3               HUNGRY 3              
   MED_COST 3               AGER 3                   FMARITAL 3            
   RMARITAL 3               EDUCAT 3                 HIEDUC 3              
   HISPANIC 3               NUMRACE 3                RACE 3                
   HISPRACE 3               HISPRACE2 3              NUMKDHH 3             
   NUMFMHH 3                HHFAMTYP 3               HHPARTYP 3            
   NCHILDHH 3               HHKIDTYP 3               CSPBBHH 3             
   CSPBSHH 3                CSPOKDHH 3               INTCTFAM 3            
   PARAGE14 3               EDUCMOM 3                AGEMOMB1 3            
   AGER_I 3                 FMARITAL_I 3             RMARITAL_I 3          
   EDUCAT_I 3               HIEDUC_I 3               HISPANIC_I 3          
   RACE_I 3                 HISPRACE_I 3             HISPRACE2_I 3         
   NUMKDHH_I 3              NUMFMHH_I 3              HHFAMTYP_I 3          
   HHPARTYP_I 3             NCHILDHH_I 3             HHKIDTYP_I 3          
   CSPBBHH_I 3              CSPBSHH_I 3              CSPOKDHH_I 3          
   INTCTFAM_I 3             PARAGE14_I 3             EDUCMOM_I 3           
   AGEMOMB1_I 3             RCURPREG 3               PREGNUM 3             
   COMPREG 3                LOSSNUM 3                ABORTION 3            
   LBPREGS 3                PARITY 3                 BIRTHS5 3             
   OUTCOM01 3               OUTCOM02 3               OUTCOM03 3            
   OUTCOM04 3               OUTCOM05 3               OUTCOM06 3            
   OUTCOM07 3               OUTCOM08 3               OUTCOM09 3            
   OUTCOM10 3               OUTCOM11 3               OUTCOM12 3            
   OUTCOM13 3               OUTCOM14 3               OUTCOM15 3            
   OUTCOM16 3               OUTCOM17 3               OUTCOM18 3            
   OUTCOM19 3               OUTCOM20 3               DATEND01 4            
   DATEND02 4               DATEND03 4               DATEND04 4            
   DATEND05 4               DATEND06 4               DATEND07 4            
   DATEND08 4               DATEND09 4               DATEND10 4            
   DATEND11 4               DATEND12 4               DATEND13 4            
   DATEND14 4               DATEND15 4               DATEND16 4            
   DATEND17 4               DATEND18 4               DATEND19 4            
   DATEND20 4               AGEPRG01 4               AGEPRG02 4            
   AGEPRG03 4               AGEPRG04 4               AGEPRG05 4            
   AGEPRG06 4               AGEPRG07 4               AGEPRG08 4            
   AGEPRG09 4               AGEPRG10 4               AGEPRG11 4            
   AGEPRG12 4               AGEPRG13 4               AGEPRG14 4            
   AGEPRG15 4               AGEPRG16 4               AGEPRG17 4            
   AGEPRG18 4               AGEPRG19 4               AGEPRG20 4            
   DATCON01 4               DATCON02 4               DATCON03 4            
   DATCON04 4               DATCON05 4               DATCON06 4            
   DATCON07 4               DATCON08 4               DATCON09 4            
   DATCON10 4               DATCON11 4               DATCON12 4            
   DATCON13 4               DATCON14 4               DATCON15 4            
   DATCON16 4               DATCON17 4               DATCON18 4            
   DATCON19 4               DATCON20 4               AGECON01 4            
   AGECON02 4               AGECON03 4               AGECON04 4            
   AGECON05 4               AGECON06 4               AGECON07 4            
   AGECON08 4               AGECON09 4               AGECON10 4            
   AGECON11 4               AGECON12 4               AGECON13 4            
   AGECON14 4               AGECON15 4               AGECON16 4            
   AGECON17 4               AGECON18 4               AGECON19 4            
   AGECON20 4               MAROUT01 3               MAROUT02 3            
   MAROUT03 3               MAROUT04 3               MAROUT05 3            
   MAROUT06 3               MAROUT07 3               MAROUT08 3            
   MAROUT09 3               MAROUT10 3               MAROUT11 3            
   MAROUT12 3               MAROUT13 3               MAROUT14 3            
   MAROUT15 3               MAROUT16 3               MAROUT17 3            
   MAROUT18 3               MAROUT19 3               MAROUT20 3            
   RMAROUT01 3              RMAROUT02 3              RMAROUT03 3           
   RMAROUT04 3              RMAROUT05 3              RMAROUT06 3           
   RMAROUT07 3              RMAROUT08 3              RMAROUT09 3           
   RMAROUT10 3              RMAROUT11 3              RMAROUT12 3           
   RMAROUT13 3              RMAROUT14 3              RMAROUT15 3           
   RMAROUT16 3              RMAROUT17 3              RMAROUT18 3           
   RMAROUT19 3              RMAROUT20 3              MARCON01 3            
   MARCON02 3               MARCON03 3               MARCON04 3            
   MARCON05 3               MARCON06 3               MARCON07 3            
   MARCON08 3               MARCON09 3               MARCON10 3            
   MARCON11 3               MARCON12 3               MARCON13 3            
   MARCON14 3               MARCON15 3               MARCON16 3            
   MARCON17 3               MARCON18 3               MARCON19 3            
   MARCON20 3               RMARCON01 3              RMARCON02 3           
   RMARCON03 3              RMARCON04 3              RMARCON05 3           
   RMARCON06 3              RMARCON07 3              RMARCON08 3           
   RMARCON09 3              RMARCON10 3              RMARCON11 3           
   RMARCON12 3              RMARCON13 3              RMARCON14 3           
   RMARCON15 3              RMARCON16 3              RMARCON17 3           
   RMARCON18 3              RMARCON19 3              RMARCON20 3           
   CEBOW 3                  CEBOWC 3                 DATBABY1 4            
   AGEBABY1 4               LIVCHILD01 3             LIVCHILD02 3          
   LIVCHILD03 3             LIVCHILD04 3             LIVCHILD05 3          
   LIVCHILD06 3             LIVCHILD07 3             LIVCHILD08 3          
   LIVCHILD09 3             LIVCHILD10 3             LIVCHILD11 3          
   LIVCHILD12 3             LIVCHILD13 3             LIVCHILD14 3          
   LIVCHILD15 3             LIVCHILD16 3             LIVCHILD17 3          
   LIVCHILD18 3             LIVCHILD19 3             LIVCHILD20 3          
   RCURPREG_I 3             PREGNUM_I 3              COMPREG_I 3           
   LOSSNUM_I 3              ABORTION_I 3             LBPREGS_I 3           
   PARITY_I 3               BIRTHS5_I 3              OUTCOM01_I 3          
   OUTCOM02_I 3             OUTCOM03_I 3             OUTCOM04_I 3          
   OUTCOM05_I 3             OUTCOM06_I 3             OUTCOM07_I 3          
   OUTCOM08_I 3             OUTCOM09_I 3             OUTCOM10_I 3          
   OUTCOM11_I 3             OUTCOM12_I 3             OUTCOM13_I 3          
   OUTCOM14_I 3             OUTCOM15_I 3             OUTCOM16_I 3          
   OUTCOM17_I 3             OUTCOM18_I 3             OUTCOM19_I 3          
   OUTCOM20_I 3             DATEND01_I 3             DATEND02_I 3          
   DATEND03_I 3             DATEND04_I 3             DATEND05_I 3          
   DATEND06_I 3             DATEND07_I 3             DATEND08_I 3          
   DATEND09_I 3             DATEND10_I 3             DATEND11_I 3          
   DATEND12_I 3             DATEND13_I 3             DATEND14_I 3          
   DATEND15_I 3             DATEND16_I 3             DATEND17_I 3          
   DATEND18_I 3             DATEND19_I 3             DATEND20_I 3          
   AGEPRG01_I 3             AGEPRG02_I 3             AGEPRG03_I 3          
   AGEPRG04_I 3             AGEPRG05_I 3             AGEPRG06_I 3          
   AGEPRG07_I 3             AGEPRG08_I 3             AGEPRG09_I 3          
   AGEPRG10_I 3             AGEPRG11_I 3             AGEPRG12_I 3          
   AGEPRG13_I 3             AGEPRG14_I 3             AGEPRG15_I 3          
   AGEPRG16_I 3             AGEPRG17_I 3             AGEPRG18_I 3          
   AGEPRG19_I 3             AGEPRG20_I 3             DATCON01_I 3          
   DATCON02_I 3             DATCON03_I 3             DATCON04_I 3          
   DATCON05_I 3             DATCON06_I 3             DATCON07_I 3          
   DATCON08_I 3             DATCON09_I 3             DATCON10_I 3          
   DATCON11_I 3             DATCON12_I 3             DATCON13_I 3          
   DATCON14_I 3             DATCON15_I 3             DATCON16_I 3          
   DATCON17_I 3             DATCON18_I 3             DATCON19_I 3          
   DATCON20_I 3             AGECON01_I 3             AGECON02_I 3          
   AGECON03_I 3             AGECON04_I 3             AGECON05_I 3          
   AGECON06_I 3             AGECON07_I 3             AGECON08_I 3          
   AGECON09_I 3             AGECON10_I 3             AGECON11_I 3          
   AGECON12_I 3             AGECON13_I 3             AGECON14_I 3          
   AGECON15_I 3             AGECON16_I 3             AGECON17_I 3          
   AGECON18_I 3             AGECON19_I 3             AGECON20_I 3          
   MAROUT01_I 3             MAROUT02_I 3             MAROUT03_I 3          
   MAROUT04_I 3             MAROUT05_I 3             MAROUT06_I 3          
   MAROUT07_I 3             MAROUT08_I 3             MAROUT09_I 3          
   MAROUT10_I 3             MAROUT11_I 3             MAROUT12_I 3          
   MAROUT13_I 3             MAROUT14_I 3             MAROUT15_I 3          
   MAROUT16_I 3             MAROUT17_I 3             MAROUT18_I 3          
   MAROUT19_I 3             MAROUT20_I 3             RMAROUT01_I 3         
   RMAROUT02_I 3            RMAROUT03_I 3            RMAROUT04_I 3         
   RMAROUT05_I 3            RMAROUT06_I 3            RMAROUT07_I 3         
   RMAROUT08_I 3            RMAROUT09_I 3            RMAROUT10_I 3         
   RMAROUT11_I 3            RMAROUT12_I 3            RMAROUT13_I 3         
   RMAROUT14_I 3            RMAROUT15_I 3            RMAROUT16_I 3         
   RMAROUT17_I 3            RMAROUT18_I 3            RMAROUT19_I 3         
   RMAROUT20_I 3            MARCON01_I 3             MARCON02_I 3          
   MARCON03_I 3             MARCON04_I 3             MARCON05_I 3          
   MARCON06_I 3             MARCON07_I 3             MARCON08_I 3          
   MARCON09_I 3             MARCON10_I 3             MARCON11_I 3          
   MARCON12_I 3             MARCON13_I 3             MARCON14_I 3          
   MARCON15_I 3             MARCON16_I 3             MARCON17_I 3          
   MARCON18_I 3             MARCON19_I 3             MARCON20_I 3          
   RMARCON01_I 3            RMARCON02_I 3            RMARCON03_I 3         
   RMARCON04_I 3            RMARCON05_I 3            RMARCON06_I 3         
   RMARCON07_I 3            RMARCON08_I 3            RMARCON09_I 3         
   RMARCON10_I 3            RMARCON11_I 3            RMARCON12_I 3         
   RMARCON13_I 3            RMARCON14_I 3            RMARCON15_I 3         
   RMARCON16_I 3            RMARCON17_I 3            RMARCON18_I 3         
   RMARCON19_I 3            RMARCON20_I 3            CEBOW_I 3             
   CEBOWC_I 3               DATBABY1_I 3             AGEBABY1_I 3          
   LIVCHILD01_I 3           LIVCHILD02_I 3           LIVCHILD03_I 3        
   LIVCHILD04_I 3           LIVCHILD05_I 3           LIVCHILD06_I 3        
   LIVCHILD07_I 3           LIVCHILD08_I 3           LIVCHILD09_I 3        
   LIVCHILD10_I 3           LIVCHILD11_I 3           LIVCHILD12_I 3        
   LIVCHILD13_I 3           LIVCHILD14_I 3           LIVCHILD15_I 3        
   LIVCHILD16_I 3           LIVCHILD17_I 3           LIVCHILD18_I 3        
   LIVCHILD19_I 3           LIVCHILD20_I 3           FMARNO 3              
   CSPBIOKD 3               MARDAT01 4               MARDAT02 4            
   MARDAT03 4               MARDAT04 4               MARDAT05 4            
   MARDIS01 4               MARDIS02 4               MARDIS03 4            
   MARDIS04 4               MARDIS05 4               MAREND01 3            
   MAREND02 3               MAREND03 3               MAREND04 3            
   MAREND05 3               FMAR1AGE 3               AGEDISS1 3            
   AGEDD1 3                 MAR1DISS 4               DD1REMAR 4            
   MAR1BIR1 4               MAR1CON1 4               CON1MAR1 4            
   B1PREMAR 3               COHEVER 3                EVMARCOH 3            
   PMARRNO 3                NONMARR 3                TIMESCOH 3            
   COHAB1 4                 COHSTAT 3                COHOUT 3              
   COH1DUR 4                HADSEX 3                 SEXONCE 3             
   SEXEVER 3                VRY1STAG 3               SEX1AGE 3             
   VRY1STSX 4               DATESEX1 4               FSEXPAGE 4            
   SEXMAR 4                 SEX1FOR 4                SEXUNION 4            
   SEXOUT 3                 FPDUR 4                  PARTS1YR 3            
   LSEXDATE 4               SEX3MO 3                 NUMP3MOS 3            
   LSEXRAGE 3               LSEXPAGE 4               PARTDUR1 4            
   PARTDUR2 4               PARTDUR3 4               RELATP1 3             
   RELATP2 3                RELATP3 3                LIFPRTNR 3            
   FMARNO_I 3               CSPBIOKD_I 3             MARDAT01_I 3          
   MARDAT02_I 3             MARDAT03_I 3             MARDAT04_I 3          
   MARDAT05_I 3             MARDIS01_I 3             MARDIS02_I 3          
   MARDIS03_I 3             MARDIS04_I 3             MARDIS05_I 3          
   MAREND01_I 3             MAREND02_I 3             MAREND03_I 3          
   MAREND04_I 3             MAREND05_I 3             FMAR1AGE_I 3          
   AGEDISS1_I 3             AGEDD1_I 3               MAR1DISS_I 3          
   DD1REMAR_I 3             MAR1BIR1_I 3             MAR1CON1_I 3          
   CON1MAR1_I 3             B1PREMAR_I 3             COHEVER_I 3           
   EVMARCOH_I 3             PMARRNO_I 3              NONMARR_I 3           
   TIMESCOH_I 3             COHAB1_I 3               COHSTAT_I 3           
   COHOUT_I 3               COH1DUR_I 3              HADSEX_I 3            
   SEXEVER_I 3              VRY1STAG_I 3             SEX1AGE_I 3           
   VRY1STSX_I 3             DATESEX1_I 3             SEXONCE_I 3           
   FSEXPAGE_I 3             SEXMAR_I 3               SEX1FOR_I 3           
   SEXUNION_I 3             SEXOUT_I 3               FPDUR_I 3             
   PARTS1YR_I 3             LSEXDATE_I 3             SEXP3MO_I 3           
   NUMP3MOS_I 3             LSEXRAGE_I 3             PARTDUR1_I 3          
   PARTDUR2_I 3             PARTDUR3_I 3             RELATP1_I 3           
   RELATP2_I 3              RELATP3_I 3              LIFPRTNR_I 3          
   STRLOPER 3               FECUND 3                 ANYBC36 3             
   NOSEX36 3                INFERT 3                 ANYBC12 3             
   ANYMTHD 3                NOSEX12 3                SEXP3MO 3             
   CONSTAT1 3               CONSTAT2 3               CONSTAT3 3            
   CONSTAT4 3               PILLR 3                  CONDOMR 3             
   SEX1MTHD1 3              SEX1MTHD2 3              SEX1MTHD3 3           
   SEX1MTHD4 3              MTHUSE12 3               METH12M1 3            
   METH12M2 3               METH12M3 3               METH12M4 3            
   MTHUSE3 3                METH3M1 3                METH3M2 3             
   METH3M3 3                METH3M4 3                FMETHOD1 3            
   FMETHOD2 3               FMETHOD3 3               FMETHOD4 3            
   DATEUSE1 6               OLDWP01 3                OLDWP02 3             
   OLDWP03 3                OLDWP04 3                OLDWP05 3             
   OLDWP06 3                OLDWP07 3                OLDWP08 3             
   OLDWP09 3                OLDWP10 3                OLDWP11 3             
   OLDWP12 3                OLDWP13 3                OLDWP14 3             
   OLDWP15 3                OLDWP16 3                OLDWP17 3             
   OLDWP18 3                OLDWP19 3                OLDWP20 3             
   OLDWR01 3                OLDWR02 3                OLDWR03 3             
   OLDWR04 3                OLDWR05 3                OLDWR06 3             
   OLDWR07 3                OLDWR08 3                OLDWR09 3             
   OLDWR10 3                OLDWR11 3                OLDWR12 3             
   OLDWR13 3                OLDWR14 3                OLDWR15 3             
   OLDWR16 3                OLDWR17 3                OLDWR18 3             
   OLDWR19 3                OLDWR20 3                WANTRP01 3            
   WANTRP02 3               WANTRP03 3               WANTRP04 3            
   WANTRP05 3               WANTRP06 3               WANTRP07 3            
   WANTRP08 3               WANTRP09 3               WANTRP10 3            
   WANTRP11 3               WANTRP12 3               WANTRP13 3            
   WANTRP14 3               WANTRP15 3               WANTRP16 3            
   WANTRP17 3               WANTRP18 3               WANTRP19 3            
   WANTRP20 3               WANTP01 3                WANTP02 3             
   WANTP03 3                WANTP04 3                WANTP05 3             
   WANTP06 3                WANTP07 3                WANTP08 3             
   WANTP09 3                WANTP10 3                WANTP11 3             
   WANTP12 3                WANTP13 3                WANTP14 3             
   WANTP15 3                WANTP16 3                WANTP17 3             
   WANTP18 3                WANTP19 3                WANTP20 3             
   NWWANTRP01 3             NWWANTRP02 3             NWWANTRP03 3          
   NWWANTRP04 3             NWWANTRP05 3             NWWANTRP06 3          
   NWWANTRP07 3             NWWANTRP08 3             NWWANTRP09 3          
   NWWANTRP10 3             NWWANTRP11 3             NWWANTRP12 3          
   NWWANTRP13 3             NWWANTRP14 3             NWWANTRP15 3          
   NWWANTRP16 3             NWWANTRP17 3             NWWANTRP18 3          
   NWWANTRP19 3             NWWANTRP20 3             WANTP5 3              
   STRLOPER_I 3             FECUND_I 3               INFERT_I 3            
   ANYMTHD_I 3              NOSEX12_I 3              SEX3MO_I 3            
   CONSTAT1_I 3             CONSTAT2_I 3             CONSTAT3_I 3          
   CONSTAT4_I 3             PILLR_I 3                CONDOMR_I 3           
   SEX1MTHD1_I 3            SEX1MTHD2_I 3            SEX1MTHD3_I 3         
   SEX1MTHD4_I 3            MTHUSE12_I 3             METH12M1_I 3          
   METH12M2_I 3             METH12M3_I 3             METH12M4_I 3          
   MTHUSE3_I 3              METH3M1_I 3              METH3M2_I 3           
   METH3M3_I 3              METH3M4_I 3              FMETHOD1_I 3          
   FMETHOD2_I 3             FMETHOD3_I 3             FMETHOD4_I 3          
   DATEUSE1_I 3             OLDWP01_I 3              OLDWP02_I 3           
   OLDWP03_I 3              OLDWP04_I 3              OLDWP05_I 3           
   OLDWP06_I 3              OLDWP07_I 3              OLDWP08_I 3           
   OLDWP09_I 3              OLDWP10_I 3              OLDWP11_I 3           
   OLDWP12_I 3              OLDWP13_I 3              OLDWP14_I 3           
   OLDWP15_I 3              OLDWP16_I 3              OLDWP17_I 3           
   OLDWP18_I 3              OLDWP19_I 3              OLDWP20_I 3           
   OLDWR01_I 3              OLDWR02_I 3              OLDWR03_I 3           
   OLDWR04_I 3              OLDWR05_I 3              OLDWR06_I 3           
   OLDWR07_I 3              OLDWR08_I 3              OLDWR09_I 3           
   OLDWR10_I 3              OLDWR11_I 3              OLDWR12_I 3           
   OLDWR13_I 3              OLDWR14_I 3              OLDWR15_I 3           
   OLDWR16_I 3              OLDWR17_I 3              OLDWR18_I 3           
   OLDWR19_I 3              OLDWR20_I 3              WANTRP01_I 3          
   WANTRP02_I 3             WANTRP03_I 3             WANTRP04_I 3          
   WANTRP05_I 3             WANTRP06_I 3             WANTRP07_I 3          
   WANTRP08_I 3             WANTRP09_I 3             WANTRP10_I 3          
   WANTRP11_I 3             WANTRP12_I 3             WANTRP13_I 3          
   WANTRP14_I 3             WANTRP15_I 3             WANTRP16_I 3          
   WANTRP17_I 3             WANTRP18_I 3             WANTRP19_I 3          
   WANTRP20_I 3             WANTP01_I 3              WANTP02_I 3           
   WANTP03_I 3              WANTP04_I 3              WANTP05_I 3           
   WANTP06_I 3              WANTP07_I 3              WANTP08_I 3           
   WANTP09_I 3              WANTP10_I 3              WANTP11_I 3           
   WANTP12_I 3              WANTP13_I 3              WANTP14_I 3           
   WANTP15_I 3              WANTP16_I 3              WANTP17_I 3           
   WANTP18_I 3              WANTP19_I 3              WANTP20_I 3           
   NWWANTRP01_I 3           NWWANTRP02_I 3           NWWANTRP03_I 3        
   NWWANTRP04_I 3           NWWANTRP05_I 3           NWWANTRP06_I 3        
   NWWANTRP07_I 3           NWWANTRP08_I 3           NWWANTRP09_I 3        
   NWWANTRP10_I 3           NWWANTRP11_I 3           NWWANTRP12_I 3        
   NWWANTRP13_I 3           NWWANTRP14_I 3           NWWANTRP15_I 3        
   NWWANTRP16_I 3           NWWANTRP17_I 3           NWWANTRP18_I 3        
   NWWANTRP19_I 3           NWWANTRP20_I 3           WANTP5_I 3            
   FPTIT12 3                FPTITMED 3               FPTITSTE 3            
   FPTITBC 3                FPTITCHK 3               FPTITCBC 3            
   FPTITCST 3               FPTITEC 3                FPTITCEC 3            
   FPTITPRE 3               FPTITABO 3               FPTITPAP 3            
   FPTITPEL 3               FPTITPRN 3               FPTITPPR 3            
   FPTITSTD 3               FPREGFP 3                FPREGMED 3            
   FPTIT12_I 3              FPTITMED_I 3             FPTITSTE_I 3          
   FPTITBC_I 3              FPTITCHK_I 3             FPTITCBC_I 3          
   FPTITCST_I 3             FPTITEC_I 3              FPTITCEC_I 3          
   FPTITPRE_I 3             FPTITABO_I 3             FPTITPAP_I 3          
   FPTITPEL_I 3             FPTITPRN_I 3             FPTITPPR_I 3          
   FPTITSTD_I 3             FPREGFP_I 3              FPREGMED_I 3          
   INTENT 3                 ADDEXP 4                 INTENT_I 3            
   ADDEXP_I 3               ANYPRGHP 3               ANYMSCHP 3            
   INFEVER 3                OVULATE 3                TUBES 3               
   INFERTR 3                INFERTH 3                ADVICE 3              
   INSEM 3                  INVITRO 3                ENDOMET 3             
   FIBROIDS 3               PIDTREAT 3               EVHIVTST 3            
   FPTITHIV 3               ANYPRGHP_I 3             ANYMSCHP_I 3          
   INFEVER_I 3              OVULATE_I 3              TUBES_I 3             
   INFERTR_I 3              INFERTH_I 3              ADVICE_I 3            
   INSEM_I 3                INVITRO_I 3              ENDOMET_I 3           
   FIBROIDS_I 3             PIDTREAT_I 3             EVHIVTST_I 3          
   FPTITHIV_I 3             CURR_INS 3               METRO 3               
   RELIGION 3               LABORFOR 3               CURR_INS_I 3          
   METRO_I 3                RELIGION_I 3             LABORFOR_I 3          
   POVERTY 4                TOTINCR 3                PUBASSIS 3            
   POVERTY_I 3              TOTINCR_I 3              PUBASSIS_I 3          
   SECU 3                   SEST 4                   CMINTVW 4             
   CMLSTYR 4                CMJAN3YR 4               CMJAN4YR 4            
   CMJAN5YR 4 ;

RUN ;
