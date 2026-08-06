
;#https://www.autohotkey.com/boards/viewtopic.php?p=488#p488

xmldata =<mos><mosID>xpn.kgo.abc.mos</mosID><objID>{C7070195-B3B8-44E7-BE20-75892A7900A7}</objID><storyID/><storyNum/><itemSlug>| G1 BL 31 |   | Line1 | Line2 |                                                            ...</itemSlug><objSlug>| G1 BL 31 |   | Line1 | Line2 |                                                            ...</objSlug><mosAbstract>| G1 BL 31 |   | Line1 | Line2 |                                                            ...</mosAbstract><itemID>0</itemID><objTB>60</objTB><objDur>0</objDur><itemChannel>31</itemChannel><itemTrigger>CHAINED</itemTrigger><itemComment/><mosItemBrowserProgID>XPression.MOSItemBrowser.1</mosItemBrowserProgID><mosItemEditorProgID>XPression.MOSItemEditor.1</mosItemEditorProgID><mosItemPlayerProgID>XPression.MOSItemPlayer.1</mosItemPlayerProgID><macroIn/><macroOut>TIMED</macroOut><mosPlugInID>XPression.MOSItemEditor.1</mosPlugInID><mosExternalMetadata><mosScope>PLAYLIST</mosScope><mosSchema/><mosPayload><version>1</version><type>CG</type><ispreset>0</ispreset><sceneid>10333</sceneid><index>0</index><scenename>BL</scenename><show>KGO ABC OTV NEWS GFX</show><category/><style/><forcestyle>0</forcestyle><revision>9</revision><description> | Line1 | Line2 |                                                                                </description><channel>31</channel><layer>1000001</layer><pvframe>0</pvframe><projectguid>{00000000-0000-0000-0000-000000000000}</projectguid><projectversion>0</projectversion><projectsubversion>0</projectsubversion><duration>125</duration><nleduration>125</nleduration><width>1280</width><height>720</height><framerate>60000</framerate><frameratediv>1001</frameratediv><gfxtype>OTHER</gfxtype><savedname/><itcObjTB>60</itcObjTB><itcTimeIn>0</itcTimeIn><itcTimeDur>0</itcTimeDur><iss>1252288</iss><itype/><content> | None | OFF |  | - | Big/Little |  |  |  |  | Line1 | Line2 |  |  | Off | none | Not Modu ...</content><datalinqkeys/><objects><object><name>Timing</name><color>1</color><properties><property type="1" name="Text"><value/></property></properties></object><object><name>&lt;&lt;Qualifier&gt;&gt;</name><color>5</color><properties><property type="1" name="Text"><value>None</value></property></properties></object><object><name>&lt;&lt;Voice Of ON/OFF&gt;&gt;</name><color>3</color><properties><property type="1" name="Text"><value>OFF</value></property></properties></object><object><name>&lt;&lt;Talent/Voice Of&gt;&gt;</name><color>5</color><properties><property type="1" name="Text"><value/></property></properties></object><object><name>Cutline/Description</name><color>5</color><visible>0</visible><properties><property type="1" name="Text"><value>-</value><assigned modified="0"/></property></properties></object><object><name>&lt;&lt;Layout&gt;&gt;</name><color>3</color><properties><property type="1" name="Text"><value>Big/Little</value></property></properties></object><object><name>&lt;&lt;Name Selector&gt;&gt;</name><color>3</color><properties><property type="1" name="Text"><value/></property></properties></object><object><name>Headline</name><color>5</color><visible>0</visible><properties><property type="1" name="Text"><value/></property></properties></object><object><name>Top Line</name><color>5</color><visible>0</visible><properties><property type="1" name="Text"><value/></property></properties></object><object><name>Bottom Line</name><color>5</color><visible>0</visible><properties><property type="1" name="Text"><value/></property></properties></object><object><name>Top Line - Big</name><color>5</color><properties><property type="1" name="Text"><value>Line1</value></property></properties></object><object><name>Bottom Line - Little</name><color>5</color><properties><property type="1" name="Text"><value>Line2</value></property></properties></object><object><name>Headline - Large</name><color>5</color><visible>0</visible><properties><property type="1" name="Text"><value/></property></properties></object><object><name>Headline - Extra Large</name><color>5</color><visible>0</visible><properties><property type="1" name="Text"><value/></property></properties></object><object><name>&lt;&lt;Image?&gt;&gt;</name><color>3</color><properties><property type="1" name="Text"><value>Off</value></property></properties></object><object><name>Image 16x9</name><color>6</color><visible>0</visible><properties><property type="32" name="Material"><face><mtype>0</mtype><name>Face</name><value/></face></property></properties></object><object><name>&lt;&lt;Modularity Preview&gt;&gt;</name><color>3</color><properties><property type="1" name="Text"><value>Not Modular</value></property></properties></object><object><name>Qualifier Display</name><color>2</color><visible>0</visible><properties><property type="1" name="Text"><value>None</value></property></properties></object></objects></mosPayload></mosExternalMetadata></mos>


doc :=	loadXML(xmldata)



; Manually retrieving nodes and values
msgbox %	DisplayNode(doc.childNodes)

DisplayNode(nodes, indent=0)
{
	for node in nodes
	{
		if	node.nodeName != "#text"
			text .=	spaces(indent) node.nodeName ": " node.nodeValue "`n"
		else	text .=	spaces(indent) node.nodeValue "`n"
		if	node.hasChildNodes
			text .=	DisplayNode(node.childNodes, indent+2)
	}
	return	text
}

spaces(n)
{
	Loop, %n%
		t .=	" "
	return	t
}

loadXML(ByRef data)
{
	o :=	ComObjCreate("MSXML2.DOMDocument.6.0")
	o.async :=	false
	o.loadXML(data)
	return	o
}


^#!r::
msgbox reloading!! hotkeys
reload

return