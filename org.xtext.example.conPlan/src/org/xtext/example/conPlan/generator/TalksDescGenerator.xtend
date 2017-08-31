package org.xtext.example.conPlan.generator

import org.xtext.example.conPlan.conPlan.RoomsTalks
import org.xtext.example.conPlan.conPlan.Talks
import org.xtext.example.conPlan.conPlan.Model
import org.eclipse.xtext.EcoreUtil2
import org.xtext.example.conPlan.conPlan.Feature
import org.xtext.example.conPlan.conPlan.Speaker

class TalksDescGenerator {
	
	def toDescHTML(Talks it)'''
	«val allTalks = EcoreUtil2.eAllOfType(it,Talks)»
	
«««	«FOR t : allTalks»
«««	«var allFeatures = EcoreUtil2.eAllOfType(t,Feature)»
«««	«var allSpeakers = EcoreUtil2.eAllOfType(t,Speaker)»
<!DOCTYPE html>
<html>
<head>
<style>
h3 {
    color: black;
    text-align: center;
    font-size: 15px;
«««    font-family: courier;
}
h4 {
    color: black;
    text-align: left;
    font-size: 15px;
«««   font-family: courier;
}
li
{
    list-style-image : url(puce.gif);
}
table{
	font-family: courier;
}

</style>
<title>Talk HTML</title>
</head>
<body>
<table style="width:100%">
	<tr bgcolor="OLIVE">
		<td COLSPAN="2">
			<h1>«name»</h1>
		</td>
	</tr>
	<tr>
		<th style="width:30%"><h2>Session Details:</h2>
		</th>
		<th style="width:70%">
			<h2>Description<br></h2>
		</th>
	</tr>
	<tr>
		<td>
		<h3>Speaker(s):<br>
		«FOR s : speaker»
		«s.name»«IF s.company !==null» («s.company») «ENDIF»
		«ENDFOR»
		</h3>
		«FOR f : features»
		«IF f.name.equalsIgnoreCase("Type")»
		<h3>Session Type:<br>«f.type.name»</h3>
		«ELSEIF f.name.equalsIgnoreCase("Track")»
		<h3>Track:<br>«f.type.name»</h3>
		«ELSEIF f.name.equalsIgnoreCase("Level")»
		<h3>Experience level:<br>«f.type.name»</h3>
		«ENDIF»
		«ENDFOR»
		</td>
		<td><h4>«description.name.toString»</h4></td>
	</tr>
</table>
</body>
</html>
«««	«ENDFOR»
	'''
}