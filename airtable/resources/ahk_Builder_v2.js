var masterVal = {
	header : [ 
		{ "type" : "checkDisable", "label" : "Disable", "isMOS" : false},
		{ "type" : "checkShift", "label" : "SHIFT", "isMOS" : false},
		{ "type" : "checkCTRL", "label" : "CTRL", "isMOS" : false},
		{ "type" : "checkWin", "label" : "WIN", "isMOS" : false},
		{ "type" : "checkAlt", "label" : "ALT", "isMOS" : false},
		{ "type" : "inputKey", "label" : "Key", "isMOS" : false},
		{ "type" : "quickName", "label" : "quickName", "isMOS" : false},
		{ "type" : "image", "label" : "image", "isMOS" : true},
		//{ "type" : "label", "label" : "transition", "isMOS" : true},
		{ "type" : "label", "label" : "mosAbstract", "isMOS" : true},
		],

	plugin : {
		ip : "10.218.116.11",
		serverPath : "/server/rest/api/",
		//fields : ["masterTemplates","audioChannels","videoTransitions","crosspoints","keywords"],
		fields : ["masterTemplates","keywords"],
		keywords : {},
		keywordList : [],
		masterTemplates : {},

	},
	hotkeyList : [],
	isENPS : true,
	unicode : {
		rule : {
			min : "\u2796",
			max : "\u2795",
		}
	},
	colors : {
		disabled : "#757575",
		enabled : "#FFFFFF",
	},
	display : {
		transition : "none",
	},
};


function init(){

//http://10.218.116.11/server/rest/api/audioChannels


	var masterTable = document.getElementById("masterTable");

	if (masterTable.children.length > 2) {
		
		return;

	}

	document.body.addEventListener('dragover',ignore, false)
	document.body.addEventListener('drop',ignore, false)

	var header = masterTable.createTHead();
	header.style.background = "black"
	header.style.color = "white"

	var row = header.insertRow(0);

	for (var x in masterVal.header){
		if (masterVal.header[x].isMOS == false){
			var cell = row.insertCell(x);
			cell.innerHTML = masterVal.header[x].label
		}

	}//*** END Build initial header element


	console.log("Done Init");
	var rawRequestPath = window.location.href;
	

	addRow({action : "new"});

	//*** Handle iFrame if exists
	var iFrame = document.getElementById("pluginFolder");

	if (iFrame != null) {

		iFrame.addEventListener("dragstart", function(e){cl("drag Start IFrame")});			

	}//*** END handle iFrame

}//**** END init


function addRow(input){
	//*** Adds new hotkey Base
	//*** This Row handles the hotkey input and the quickName
	var masterTable = document.getElementById("masterTable");
	var newRow = document.createElement("tr");
	newRow.className = "rowAHK";
	newRow.style.verticalAlign = "text-top";

	switch (input.action){

		case "import":

			newRow.hotkey = input.data;
			
		break;


		default:

			//*******************************************
			//**** Build new blank Hotkey Object
			//*******************************************
			newRow.hotkey  = {
				disabled : false,
				isShift : false,
				isCtrl : false,
				isWin : false,
				isAlt : false,
				key : "",
				quickName : "",
				MOSList : []
			}


		break;

	}//*** End hotkey action switch
		
	for (var x in masterVal.header){
		var newTD = document.createElement("td");

		var newElem = "";
		
		if (masterVal.header[x].isMOS == false){
			switch( masterVal.header[x].type )
			{
				case "check":
					newElem = document.createElement("input");
					newElem.type = "checkbox"
				break;
				case "checkShift":
					newElem = document.createElement("input");
					newElem.type = "checkbox"
					newElem.onclick = function(){ handleForm({ inputDOM : this, type : "SHIFT" })}
					newElem.checked = newRow.hotkey.isShift;
				break;

				case "checkCTRL":
					newElem = document.createElement("input");
					newElem.type = "checkbox"
					newElem.onclick = function(){ handleForm({ inputDOM : this, type : "CTRL" })}
					newElem.checked = newRow.hotkey.isCtrl;
					
				break;

				case "checkWin":
					newElem = document.createElement("input");
					newElem.type = "checkbox"
					newElem.onclick = function(){ handleForm({ inputDOM : this, type : "WIN" })}
					newElem.checked = newRow.hotkey.isWin;

				break;

				case "checkAlt":
					newElem = document.createElement("input");
					newElem.type = "checkbox"
					newElem.onclick = function(){ handleForm({ inputDOM : this, type : "ALT" })}
					newElem.value = newRow.hotkey.isAlt;
				break;

				case "checkDisable":
					newElem = document.createElement("input");
					newElem.type = "checkbox";
					//newElem.onclick = function(){ disableInput(this)}
					newElem.onclick = function(){ handleForm({ inputDOM : this, type : "DISABLE" })}
					newElem.checked = newRow.hotkey.disabled;

				break;


				case "inputKey": 
					newElem = document.createElement("input");
					newElem.type = "text";
					
					//*** Assign the ID to the type value
					newElem.id = masterVal.header[x].type;
					newElem.disabled = false;
					newElem.oninput = function(){ handleForm({"inputDOM" : this, "type" : "key"}) }
					newElem.value = newRow.hotkey.key;

					//*** Disable Field if disabled is true
					if (newRow.hotkey.disabled){
						newElem.disabled = newRow.hotkey.disabled;
						newElem.style.background = masterVal.colors.disabled;
					}
					
				break;

				case "quickName":

					newElem = document.createElement("input");
					newElem.type = "text";
					
					//*** Assign the ID to the type value
					newElem.id = masterVal.header[x].type;
					newElem.disabled = false;
					newElem.oninput = function(){ handleForm({"inputDOM" : this, "type" : "quickName"}) }
					newElem.value = newRow.hotkey.quickName;
					
				break;
				



				case "input":
					newElem = document.createElement("input");
					newElem.type = "text"
				break;

				case "label":
					newElem = document.createElement("div");
					newElem.innerHTML = ""
					
				break;
				case "image":
					newElem = document.createElement("div");
					//newElem.style.width = "80px"
					//newElem.style.fontSize = "1.5em"
					//newElem.style.height = "60px"
					//newElem.style.backgroundColor = "red"
					newElem.innerHTML = ""

				break;


				default:
					newElem = document.createElement("div");
					newElem.innerHTML = "Unhandled Header Type: " + masterVal.header[x].type;

			}

			newTD.id = masterVal.header[x].label;
			newRow.mosAttrib = {}
		

			newTD.appendChild(newElem);
			newRow.appendChild(newTD);
		}
	}

	//*** Add Minimize Button to newRow
	var minButton = document.createElement("td");
	minButton.innerHTML = "\u21D1";
	minButton.innerHTML = "\u22BC";
	minButton.innerHTML = masterVal.unicode.rule.min;
	minButton.style.background = "#a6a6a6";
	minButton.style.color = "black";
	minButton.style.width = "25px";
	minButton.style.textAlign = "center";
	minButton.style.verticalAlign = "middle";
	minButton.style.fontSize = "1em";
	
	minButton.onclick = function(){ ruleInteraction(this,{action : "minMax", type: "topRule"})}
	
	var upDownTable = document.createElement("table");

	
	var ruleUp = document.createElement("tr");
	ruleUp.innerHTML = "\u21D1";
	ruleUp.innerHTML = "\u22BC";
	ruleUp.innerHTML = "\u22C0";
	ruleUp.style.background = "#a6a6a6";
	ruleUp.style.color = "black";
	ruleUp.style.width = "25px";
	ruleUp.style.textAlign = "center";
	ruleUp.style.vertAlign = "middle";
	ruleUp.style.fontSize = "2em";
	ruleUp.className = "ruleMove";
	
	var ruleDown = document.createElement("tr");
	ruleDown.innerHTML = "  \u21D3  ";
	ruleDown.innerHTML = "  \u22BB  ";
	ruleDown.innerHTML = "  \u22C1";
	ruleDown.style.background = "#a6a6a6";
	ruleDown.style.color = "black";
	ruleDown.style.width = "25px";
	ruleDown.style.textAlign = "center";
	ruleDown.style.fontSize = "2em";
	ruleDown.onclick = function(){ ruleInteraction(this,{action : "down", type: "rule"})};
	ruleDown.className = "ruleMove";

	ruleUp.onclick = function(){ ruleInteraction(this,{action : "up", type: "rule"})}

	upDownTable.appendChild(ruleUp);
	upDownTable.appendChild(ruleDown);
	
	newRow.appendChild(upDownTable);
	
	newRow.appendChild(minButton);

	var newMOSTable= document.createElement("table");

	var header = newMOSTable.createTHead();
	header.style.background = "black"
	header.style.color = "white"

	//**** Build MOS Table, starting with Header Row
	var row = header.insertRow(0);


	for (var x in masterVal.header){
		if (masterVal.header[x].isMOS == true){
			var cell = document.createElement("td");
			cell.innerHTML = masterVal.header[x].label
			row.appendChild(cell);
		}

	}//*

	//*** Build Add Mos Button for adding new MOS Objects
	//var buttonCell = row.insertCell(counter);
	var buttonCell = document.createElement("td");
	buttonCell.innerHTML = "+addMOS";
	buttonCell.innerHTML = "\u2795";
	buttonCell.style.background = "gray";
	buttonCell.style.color = "black";
	buttonCell.onclick = function(){ addMOS(this,{action : "new"})  };
	row.appendChild(buttonCell);

	//var ruleUp = row.insertCell(counter+1);
	//row.appendChild(ruleUp);


	var blankTD = document.createElement("td");
	blankTD.style.background = "black";
	row.appendChild(blankTD);

	var blankTD = document.createElement("td");
	blankTD.style.background = "black";
	row.appendChild(blankTD);

	var ruleDel = document.createElement("td");
	ruleDel.innerHTML = "DEL";
	ruleDel.innerHTML = "\u2297";
	ruleDel.innerHTML = "\u2327";
	ruleDel.style.background = "gray";
	ruleDel.style.color = "black";
	ruleDel.style.width = "25px";
	ruleDel.style.textAlign = "center";
	ruleDel.style.fontSize = "2em";
	ruleDel.onclick = function(){ ruleInteraction(this,{action : "delete", type: "rule" })};
	row.appendChild(ruleDel);

	var newMOSTD = document.createElement("td");
	newMOSTD.id = "MOS";
	var newMOSTableRow = document.createElement("tr"); 


	newMOSTD.appendChild(newMOSTable);

	
	newRow.appendChild(newMOSTD);


//*** Handle New or Import Action
	switch (input.action){
		//*** Add Mos for each element in MOS List
		case "import":
			for ( var x in newRow.hotkey.MOSList){
				addMOS(buttonCell,{action:"import", data : newRow.hotkey.MOSList[x], img : newRow.hotkey.IMGList[x]});
			}
			//*** Imported Hotkeys Are minimized by default
			ruleInteraction(minButton,{action : "minMax", type: "topRule"})
			
		break;

		default:
	
			addMOS(buttonCell,{action:"new"});

	}//*** End


	masterTable.appendChild(newRow);

	
	//*******************************************
	//**** Add hotkey to MasterTable.hotkeyList
	//*******************************************
	
	//masterTable.appendChild(newMOSRow);

	//newMOSElem.addEventListener("click", addMOS(newMOSRow) );
	//newButtonElem.onclick = function(){ addMOS()  };

	//addMOS(this);

}//*** END addRow()

function addMOS(inputDOM,input){

	var mosOBJ = {}
	if (input.action == "import") {

		if (input.data == null) { cl("Whoops Forgot to pass some Data. Stopping");return;}

			cl(typeof input.data);

			thisMosAbstractRegex = new RegExp("<mosAbstract>.+?<\/mosAbstract>" ,"ig");
			thisMosTransitionRegex = new RegExp("<transition>.+?<\/transition>" ,"ig");
			thisMosTransitionNameRegex = new RegExp("<name>.+?<\/name>" ,"ig");

			//****Get the Transition
			mosOBJ.mosTransition = input.data.match(thisMosTransitionRegex)[0]

			//****Get the Transition Name
			mosOBJ.mosTransition = mosOBJ.mosTransition.match(thisMosTransitionNameRegex)[0];

			//*** Remove the Name Tag
			mosOBJ.mosTransition = mosOBJ.mosTransition.replace("<name>","").replace("</name>","");
			cl("Transition: " + mosOBJ.mosTransition);

			//****Get the Transition
			mosOBJ.mosAbstract = input.data.match(thisMosAbstractRegex)[0]
			cl("Abstract: " + mosOBJ.mosAbstract);


	}

	var newMOSRow = document.createElement("tr");
	newMOSRow.style.background = "white";
	newMOSRow.style.color = "black";
	newMOSRow.style.overflow = "hidden";
	newMOSRow.addEventListener("dragstart", function(e){handleDragStart(e,this)});

	for (var x in masterVal.header){
		var newMOSTD = document.createElement("td");
		//newMOSTD.style.maxWidth = "200px";
		//newMOSTD.style.whiteSpace = "nowrap";
		//newMOSTD.style.overflow = "hidden";

		var newMOSElem = "";

		if (masterVal.header[x].isMOS == true){

			///***** Force First Field to add Button
			switch( masterVal.header[x].type )
			{
				case "check": case "input":
					newMOSElem = document.createElement("div");
					newMOSElem.innerHTML = ""
				break;

		
				case "label":
					newMOSElem = document.createElement("div");
					newMOSElem.innerHTML = "Drag MOS";

					if (input.action == "import"){
						if (masterVal.header[x].label == "transition")
						{
							newMOSElem.innerHTML = mosOBJ.mosTransition;
						}

						if (masterVal.header[x].label == "mosAbstract")
						{
							newMOSElem.innerHTML = mosOBJ.mosAbstract;

						}
					}//*** END handle import action
					
				break;
				case "image":
					if ( input.action == "new"){
						newMOSElem = document.createElement("div");
						newMOSElem.style.width = "80px"
						newMOSElem.style.fontSize = "1.5em"
						newMOSElem.style.height = "60px"
						newMOSElem.style.backgroundColor = "red"
						newMOSElem.innerHTML = "Drag</br>Here"
					}

					if ( input.action == "import"){

					    newMOSElem = document.createElement("IMG");
					    newMOSElem.height = "60";
					    newMOSElem.width = "80";
					    newMOSElem.src = input.img;

					}


				break;


				default:
					newMOSElem = document.createElement("div");
					newMOSElem.innerHTML("Unhandled Header Type: " + masterVal.header[x].type);

			}


			newMOSTD.id = masterVal.header[x].label;
			newMOSRow.mosAttrib = {}
		

			newMOSTD.appendChild(newMOSElem);
			newMOSRow.appendChild(newMOSTD);

		}
	}

	var blankTD = document.createElement("td");
	newMOSRow.appendChild(blankTD);

	var upButton = document.createElement("td");
	upButton.innerHTML = "\u2934";
	upButton.innerHTML = "\u25B2";
	upButton.style.color = "black";
	upButton.style.verticalAlign = "center";
	upButton.style.textAlign = "center";
	upButton.style.fontSize = "2em";
	upButton.style.color = "red"
	upButton.style.backgroundColor =  "white";
	upButton.onclick = function(){ ruleInteraction(this,{action : "up", type: "MOS"}) }
	
	newMOSRow.appendChild(upButton);

	var downButton = document.createElement("td");
	downButton.innerHTML = "\u2935";
	downButton.innerHTML = "\u25BC";
	downButton.style.color = "black";
	downButton.style.verticalAlign = "center";
	downButton.style.textAlign = "center";
	downButton.style.fontSize = "2em";
	downButton.style.color = "red"
	downButton.style.backgroundColor =  "white";
	downButton.onclick = function(){ ruleInteraction(this,{action : "down", type: "MOS"}) }
	
	newMOSRow.appendChild(downButton);



	var delButton = document.createElement("td");
	delButton.innerHTML = "\u26D4";
	delButton.innerHTML = "\u274C";
	delButton.style.color = "black";
	delButton.style.verticalAlign = "center";
	delButton.style.textAlign = "center";
	delButton.style.fontSize = "2em";
	delButton.style.backgroundColor =  "white";
	delButton.onclick = function(){ ruleInteraction(this,{action : "delete", type: "MOS"}) }
	
	newMOSRow.appendChild(delButton);
	

	var parent = inputDOM.parentNode.parentNode;
	//var parentRow = inputDOM.parentNode.parentNode.parentNode.parentNode.parentNode;

	parent.appendChild(newMOSRow);

	//cl(parentRow.hotkey);
	//cl(parentRow.innerHTML);

	newMOSRow.addEventListener('dragover',handleDropStart, false)
	newMOSRow.addEventListener('drop',handleDrop, false)


}

function ruleInteraction(inputDOM,input){
	var targetElem = null;
	var parentElem = null;
	
	//*** Target and Parent Elem vary by type, but rest is the Same.
	switch (input.type)	{
		case "rule":
			//*** TargetElem is the Row to be Moved
			//targetElem = inputDOM.parentNode.parentNode.parentNode.parentNode.parentNode;
			targetElem = inputDOM.parentNode.parentNode;

			//*** parentElem should be masterTable
			parentElem = targetElem.parentNode;

		break;

		case "MOS": 
			//*** TargetElem is the Row to be Moved
			targetElem = inputDOM.parentNode;
			//*** parentElem should be masterTable
			parentElem = targetElem.parentNode;
		break;

		case "topRule":

			targetElem = inputDOM.nextSibling;

		break;

		default:
			cl("OOPs Unkown rule TYPE. No Rule Action for you!");
			return;
	}
	
	var currentIndex = -1;

	if (parentElem != null) {
		//*** Find Target Index
		for (var x = 1; x < parentElem.children.length; x++){

			if (parentElem.children[x] == targetElem){

				cl("Element Found!");
				currentIndex = x;
				break

			}//*** END child Found

		}//*** END fin
	}//*** END valid parentElem

	var initialOffset = targetElem.offsetTop;

	switch (input.action){

		case "up":

			//*** If Elem is the second Item, it is at top of list (nothing will supersede the thead)
			if (parentElem.children[1] == targetElem) {
				cl("Already at the Top!");
				return;
			}
			
			//*** decrement Index to move down nodeLIst
			currentIndex--;

		break;

		case "down":
			//**** Check to see if we are at the end of the list
			if (parentElem.lastChild == targetElem){
				cl("Already at the End");
				return;
			}

			//*** Incrment Index to move down nodeLIst
			currentIndex++

		break;

		case "delete":

			targetElem = parentElem.parentNode.parentNode;
			targetElem.parentNode.removeChild(targetElem);
			return;

		break;

		case "minMax":

			if (targetElem.style.display == "none") {
				//*** Element Hidden, display it
				targetElem.style.display = "inherit";
				inputDOM.innerHTML = masterVal.unicode.rule.min;
			}
			else{
				//*** Element is displayed, hide it
				targetElem.style.display = "none";

				//*** Assign the Max symbol
				inputDOM.innerHTML = masterVal.unicode.rule.max;



			}

			return;

		break;

	}//*** END Switch Input.action

	//*** Delete target Element
	parentElem.removeChild(targetElem);

	//*** Insert targetElem at new Index
	parentElem.insertBefore(targetElem, parentElem.children[parseInt(currentIndex)])


	//*** Scroll Windown relative to the dfference in the targetElem offset Top from before and after move
	window.scrollTo(0,(window.scrollY + (targetElem.offsetTop - initialOffset) ) );

	


}//**** END Rule Interaction

function handleForm(inputOBJ) {
	var inputDOM = inputOBJ.inputDOM;

	var parent = inputDOM.parentNode.parentNode;

cl( "Type: "  + inputOBJ.type);
	//*** Assign Boolean to row hotkey Object
	switch (inputOBJ.type){

		case "SHIFT":

			parent.hotkey.isShift = inputDOM.checked;

		break;

		case "CTRL":

			parent.hotkey.isCtrl = inputDOM.checked;

		break;

		case "WIN":

			parent.hotkey.isWin = inputDOM.checked;

		break;

		case "ALT":

			parent.hotkey.isAlt = inputDOM.checked;

		break;

		case "DISABLE":

			parent.hotkey.disabled = inputDOM.checked;
			var children = parent.children;
			//*** Loop through this row to find the inputKey Object
			for (var x = 0; x < children.length-1;x++ ) {
				//cl(x + ":" + children[x].id + ":" + children[x].children[0].id)
				if (children[x].id == "Key") {
					cl(children[x].innerHTML);
					cl(children[x].firstChild.innerHTML);
					if (inputDOM.checked){
						children[x].firstChild.disabled = inputDOM.checked;
						children[x].firstChild.style.background = masterVal.colors.disabled;
						//children[x].firstChild.value = inputDOM.checked;
					} else{
						children[x].firstChild.disabled = inputDOM.checked;
						children[x].firstChild.style.background = masterVal.colors.enabled;
					}
				}
			}


		break;

		case "key": case "quickName":

			parent.hotkey[inputOBJ.type] = inputDOM.value;

		break;
	}//*** End handle individual Checks

	cl(parent.hotkey);


}//*** END toggle Check



function instructions(input,elem){
	var elem = document.getElementById("instructions")

	//******************************************
	//*** Show/Hide the Instructions Window
	//******************************************
	if (elem.style.display == "none") {elem.style.display = "inherit" }
	else {elem.style.display = "none" }

	out = "";

	
} //**** END Function instructions
function ignore(e){
	e.preventDefault();
}

function handleDropStart(e){
	e.preventDefault();
	e.dataTransfer.effectAllowed = "move";
}

function handleDragStart(e,inputDOM){

	//**** Get Row Hotkey Values
	var thisHotkey = inputDOM.parentNode.parentNode.parentNode.parentNode.hotkey;

	//**** Find this Child Index
	var parentElem = inputDOM.parentNode;

	for (var x = 1; x < parentElem.children.length; x++){
		if (inputDOM == parentElem.children[x]){
			e.dataTransfer.setData('text/type',"ruleBuilder");
			e.dataTransfer.setData('text/plain',thisHotkey.MOSList[x-1]);
			e.dataTransfer.setData('text/IMG',thisHotkey.IMGList[x-1]);
			e.dataTransfer.setData('text/innerHTML',inputDOM.innerHTML);
			e.dataTransfer.setData('text/outerHTML',inputDOM.outerHTML);
			e.dataTransfer.setData('text/DOM',inputDOM);
		}//*** DOM Found
	}//*** END Find the DOM
}//**** END handleDragStart

function handleDrop(e){
	
	e.preventDefault();
	e.dataTransfer.effectAllowed = "move";

	var dropType = 'overdrive';

	if ( e.dataTransfer.getData("text/type")  == "ruleBuilder") {
		//*** Improperly Handled Internal Drag and Drop 
		//*** Quit Here

		dropType = 'ruleBuilder';

	}//*** END Bad Drop

	var out = ""
	for (var x in e.dataTransfer.types){
		var val = e.dataTransfer.types[x];
		console.log("Val: " + val + ":" + e.dataTransfer.getData(val))
		//out += val + ":" + e.dataTransfer.getData(val) + "</br>";
	}
	this.mosAttrib = {};
	
	//this.mosAttrib.rawMOS=e.dataTransfer.getData("text/plain").replace(/</g,'&lt;').replace(/>/g,'&gt;');
	this.mosAttrib.rawMOS=e.dataTransfer.getData("text/plain");

	thisMosAbstractRegex = new RegExp("<mosAbstract>.+?<\/mosAbstract>" ,"ig");
	thisMosTransitionRegex = new RegExp("<transition>.+?<\/transition>" ,"ig");
	thisMosTransitionNameRegex = new RegExp("<name>.+?<\/name>" ,"ig");
	thisMosImageRegex = new RegExp("<imageURL>.+?<\/imageURL>" ,"ig");
	thisMosGetPluginIpRegex = new RegExp("http:\/\/.+?\/" ,"ig");


	var thisRawMos = e.dataTransfer.getData("text/plain");
	this.mosAttrib.wholeMOS = thisRawMos;
	try {
		this.mosAttrib.mosAbstract = thisRawMos.match(thisMosAbstractRegex)
	}
	catch(e){
		alert("Reload the Plugin page")
		return;
	}
	cl("Raw: " + e.dataTransfer.getData("text/plain") );
	//****Get the Transition
	this.mosAttrib.mosTransition = thisRawMos.match(thisMosTransitionRegex)[0]

	//****Get the Transition Name
	this.mosAttrib.mosTransition = this.mosAttrib.mosTransition.match(thisMosTransitionNameRegex)[0];

	//*** Remove the Name Tag
	this.mosAttrib.mosTransition = this.mosAttrib.mosTransition.replace("<name>","").replace("</name>","");
	//cl(this.mosAttrib.mosTransition)

	for ( var x in this.children){
		cl("id: " + this.children[x].id);
		switch(this.children[x].id){

			case "mosAbstract":

				var abstractOut = this.mosAttrib.mosAbstract;
				if (abstractOut != null){
					abstractOut = abstractOut[0];
					abstractOut = abstractOut.replace("Transition:","</br>Transition:");
					abstractOut = abstractOut.replace("- Audio AFV:","</br>Audio AFV:");
					abstractOut = abstractOut.replace("- Custom Controls:","</br>Custom Controls:</br>");
					abstractOut = abstractOut.replace("Clip:","</br>Clip:");
				}


				this.children[x].innerHTML = abstractOut;
				//this.children[x].style.overflow = "auto";
				//this.children[x].style.maxWidth = "";
				
			break;

			case "transition":
				this.children[x].innerHTML = this.mosAttrib.mosTransition;
				
			break;

			case "image":

			    var thisIMG = document.createElement("IMG");
			    thisIMG.height = "60";
			    thisIMG.width = "80";
			    //**** Set IMG to the promise URL. This works unless there is overlay. It's a default position
			    //**** In case of furture unknow error
			    thisIMG.src = e.dataTransfer.getData("application/x-moz-file-promise-url");
			    this.mosAttrib.imgMOS = e.dataTransfer.getData("application/x-moz-file-promise-url");
			    var thisImageURL = thisRawMos.match(thisMosImageRegex);

			    if (thisImageURL == null) {
			    	//*** Problem getting ImageURL, Go with what the icon sent
			    	thisImageURL = e.dataTransfer.getData("application/x-moz-file-promise-url");

			    } else {
			    	//*** Let's build and icon image URL

			    	//**** Get ImageURL, strip ImageURL tags and leading forward slash
			    	thisImageURL = thisImageURL[0].replace("<imageURL>/","").replace("<\/imageURL>","")
			    	
			    	//**** Get the plugin IP address from the promise Field
			    	var origPath = e.dataTransfer.getData("application/x-moz-file-promise-url");
			    	origPath = origPath.match(thisMosGetPluginIpRegex)[0];
			    	
			    	//**** Add the origPath to ImageURL to get a fully formed icon link
				    thisImageURL =  origPath + thisImageURL
				    thisIMG.src = thisImageURL
				    this.mosAttrib.imgMOS = thisImageURL;
			    }



			    //thisIMG.src = e.dataTransfer.getData("text/plain") ;
			    //thisIMG.src = "data:image/png;base64," + e.dataTransfer.getData("application/x-moz-nativeimage");
			    this.children[x].replaceChild(thisIMG, this.children[x].childNodes[0]);
			    //this.mosAttrib.imgMOS = e.dataTransfer.getData("application/x-moz-nativeimage");
			    

			break;

		}
	}

	//*** Update the RawMos values in the parent Row

	var MOSrows = this.parentNode;
	var parentRow = this.parentNode.parentNode.parentNode.parentNode;

	//*** Loop Through existing MOS rows starting at Index 1 to skip table head element
	//*** Rebuild parentRow.hotkey.MOSList on each drop

	//*** Init MOS List
	parentRow.hotkey.MOSList = [];
	parentRow.hotkey.IMGList = [];


	for ( var rowIndex = 1; rowIndex < MOSrows.childNodes.length; rowIndex++) {
		var thisElem = MOSrows.childNodes[rowIndex];

		//*** Add rawMOS
		parentRow.hotkey.MOSList.push(thisElem.mosAttrib.rawMOS)
		parentRow.hotkey.IMGList.push(thisElem.mosAttrib.imgMOS)
	}
	
} //*** END

function saveLoadJSON(input){

	switch (input.action)
	{
		case "save":

			//*********************************************************************************
			//*** Build a FileName based on Date and Time, because we can't do overwrites
			//*********************************************************************************
			var d = new Date();

			var thisYear = d.getUTCFullYear();

			thisYear = thisYear.toString().substring(2);

			var thisMonth = d.getUTCMonth();

			var thisDay = d.getDay();

			var thisHour = d.getHours();

			var thisMinute = d.getMinutes();

			var thisSecond = d.getSeconds();

			var fixTimes = [ thisMonth, thisDay, thisHour, thisMinute, thisSecond]

			for (var x in fixTimes){
				if (fixTimes[x] < 10){
					fixTimes[x] = "0" + fixTimes[x].toString();
				}
			}

			var fileTime = thisYear + "_" + fixTimes[0] + "_" + fixTimes[1] +"-" + fixTimes[2] + "_" + fixTimes[3] + "_" + fixTimes[4] + "__";

			//*********************************************************************************
			//*********************************************************************************
			//*********************************************************************************
			var outOBJ = []

			var allRows = document.getElementsByClassName("rowAHK");

			//*** Add each Row hotkey to outOBJ
			for (var x = 0; x < allRows.length; x++){

				outOBJ.push(allRows.item(x).hotkey)

			}//*** END for each Row

			//*** Convert Object to String
			var out = JSON.stringify(outOBJ);



			//*** Save to a file
			var element = document.createElement('a');
			element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(out));
			element.setAttribute('download', fileTime + "hotkeys.json");

			element.style.display = 'none';
			document.body.appendChild(element);

			element.click();

			document.body.removeChild(element);

		break;

		case "load":

			cl("Let's get JSON LOADED ")
			var input = document.createElement('input');
			input.type = 'file';

			input.onchange = e => { 
			   // getting a hold of the file reference
			   var file = e.target.files[0]; 

			   // setting up the reader
			   var reader = new FileReader();
			   reader.readAsText(file,'UTF-8');

			   // here we tell the reader what to do when it's done reading...
			   reader.onload = readerEvent => {
			      var importOBJ = readerEvent.target.result; // this is the content!
			      
			      try
			      {
			      	importOBJ = JSON.parse(importOBJ);
	      	
			      }//*** END import Parse Try
			      catch(e)
			      {
			      	alert("Unable to parse file: " + file.name + "\nPlease select a valid Hotkey JSON File");
			      	return;
			      }//**** END Main Import 
			      
			      	//*** Remove all Existing rows with a fucking While Loop because it works!!!
			      	
			      	var elems = document.getElementsByClassName("rowAHK");
			      	while (elems.length > 0) {

			      		elems[0].parentNode.removeChild(elems[0])

			      		elems = document.getElementsByClassName("rowAHK");

			      	}

			      	//************************
			      	//*** Build Each Row
			      	//************************
			      	for ( var ruleDex = 0; ruleDex < importOBJ.length; ruleDex++){
			      		addRow({ action : "import","data" : importOBJ[ruleDex]});
			      					      		
			      		//var newRow = masterTable.lastChild;
			      		
			      		//*** Assign 
			      		//newRow.hotkey = importOBJ[ruleDex];



			      	}//*** End Each Row			      
			      

			   }
			}//*** Handle Input OnChange

			input.click();

		break;

	}//*** End Main Switch

}//*** END saveLoadJSON


function buildAHK(input){

	cl("Begin AHK")
	var outDefine = "";
	var outKeys = "";
	var outChoices = "masterChoices = ";
	var outArrayList = "";
	var out = "";

	//var out += "MASTER_ARY := []\r\n";

	var allRows = document.getElementsByClassName("rowAHK");

	for (var rowIndex in allRows) {

		var thisRow = allRows[rowIndex];
		if (typeof thisRow == 'object')	{


			var thisHotkey = allRows[rowIndex].hotkey;
			
			//***************************************
			//*** Build Definitions *****************
			//***************************************
			//*** QuickName = series of MOS commands
			//***************************************
			var thisQuickName = "x_" + thisHotkey.quickName;
			var thisDefine = "";
			

			
			var thisWholeMOS = ""
			for ( var countMOS = 0; countMOS < thisHotkey.MOSList.length; countMOS++){

				//******************************************************************************
				//*** We are getting NULL values, not sure why. Should fix it upstream.
				//*** Instead we will stop on ivalid data.
				//******************************************************************************
				if (thisHotkey.MOSList[countMOS] == null){ continue; }

				var thisMOS = thisHotkey.MOSList[countMOS];

				//**** Add Brackets for ENPS. Because....ENPS
				if (masterVal.isENPS == true) {
					thisMOS = "[" + thisHotkey.MOSList[countMOS] + "]";
				}

				//outDefine += thisQuickName + " =%"+thisQuickName+"%" + thisMOS + "\r\n";
				//outDefine += thisQuickName + " =%" + thisQuickName + "%`n\r\n"
				//*** Each MOS element is treated as a Hotkey String Literal and is wrapped in Quotes. 
				//*** The Newline is a separated String Literal that is cautiously separated
				thisWholeMOS += '\"' + thisMOS + '\" \"`n\"  '
			}
			outDefine += thisQuickName + " :=" + thisWholeMOS + "\r\n\r\n"
			//outDefine += "x_" + thisHotkey.quickName + " =" + thisDefine + "\r\n\r\n";
			outArrayList += "MASTER_ARY." + thisHotkey.quickName + " := " + thisQuickName + "\r\n";
			
			//***************************************
			//*** Build Hotkeys Macros
			//***************************************

			var thisKey = "";
			//*** Skip building Key macro if disabled = true
			if (thisHotkey.disabled == false) {

				//*** Add Modifiers
				if (thisHotkey.isShift) { thisKey += "+"}
				if (thisHotkey.isCtrl) { thisKey += "^"}
				if (thisHotkey.isWin) { thisKey += "#"}
				if (thisHotkey.isAlt) { thisKey += "!"}

				//*** Add Key
				thisKey += thisHotkey.key + "::\r\n";
				thisKey += "\tactionKey=%x_"+thisHotkey.quickName+"%\r\n"
				thisKey += "\tgosub,sendAction\r\n"
				thisKey += "return\r\n\r\n"
				outKeys += thisKey;
		
			}//*** End Build Hotkey Macro

			//**** Add to MasterChoices
			outChoices += thisHotkey.quickName + "|";

		}//*** END This row is an Object


	}//*** END Each Row

	//*** Trim last | from outChoices
	outChoices = outChoices.substr(0, outChoices.length - 1)
	
	out += outChoices + "\r\n\r\n";
	out += "MASTER_ARY := []\r\n\r\n"
	out += outDefine + "\r\n\r\n";
	out += outArrayList + "\r\n\r\n";
	out += outKeys + "\r\n\r\n";
	
	//*** Output to File
	switch(input.action){
		case "clipboard":

		   var el = document.createElement('textarea');
		   // Set value (string to be copied)
		   var outBox = document.getElementById("outBox");
		   el.value = out;
		   // Set non-editable to avoid focus and move outside of view
		   el.setAttribute('readonly', '');
		   el.style = {position: 'absolute', left: '-9999px'};
		   document.body.appendChild(el);
		   // Select text inside element
		   el.select();
		   // Copy text to clipboard
		   document.execCommand('copy');
		   // Remove temporary element
		   document.body.removeChild(el);

		break;

		case "export":

			var element = document.createElement('a');
			element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(out));
			element.setAttribute('download', "macros.ahk");

			element.style.display = 'none';
			document.body.appendChild(element);

			element.click();

			document.body.removeChild(element);
	
		break;

	}	

	function copyClipboard(input){
	   // Create new element
	
	}
		

}//*** END Build Autohotkey File!!!!
function cl(input){
	console.log(input);
}

/*
//http://10.218.116.11/newsroomplugin/	
//http://10.218.116.11/server/rest/api/masterTemplates
//http://10.218.116.11/server/rest/api/audioChannels
//http://10.218.116.11/server/rest/api/videoTransitions
//http://10.218.116.11/server/rest/api/crosspoints
//http://10.218.116.11/server/rest/api/keywords
//http://10.218.116.11/server/rest/api/masterTemplates/28474
*/