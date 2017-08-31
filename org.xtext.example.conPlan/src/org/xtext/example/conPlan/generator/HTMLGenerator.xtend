package org.xtext.example.conPlan.generator

import org.xtext.example.conPlan.conPlan.Conference
import org.xtext.example.conPlan.conPlan.ConferenceDay
import org.eclipse.xtext.EcoreUtil2
import java.text.SimpleDateFormat
import org.xtext.example.conPlan.conPlan.Slot
import java.util.Locale
import java.util.Calendar
import org.xtext.example.conPlan.conPlan.Model
import org.xtext.example.conPlan.conPlan.Rooms
import org.xtext.example.conPlan.conPlan.Room
import org.xtext.example.conPlan.conPlan.Talks
import org.xtext.example.conPlan.conPlan.Feature
import org.xtext.example.conPlan.conPlan.Speaker
import org.xtext.example.conPlan.conPlan.FeatureTypes
import org.xtext.example.conPlan.conPlan.Tracks
import org.xtext.example.conPlan.conPlan.RoomsTalks

class HTMLGenerator {
	
	def toHTML(Model it)'''
	«val allConferences = EcoreUtil2.eAllOfType(it,Conference)»
	«val allRooms = EcoreUtil2.eAllOfType(it,Room)»
	
	«FOR c : allConferences»
<!DOCTYPE html>
<html>
<head>
<style>
body {
«««    background-color:white;
}
h2 {
    color: black;
    text-align: left;
«««    background-color: white;
    font-size: 15px;
}
««« Title
h3 {
    color: white;
    text-align: left;
«««    background-color:red;
    font-size: 25px;
}
««« Slot's name & Talks
h4 {
    color: black;
    text-align: left;
«««    background-color: white;
    font-size: 20px;
}
««« Slots / Rooms
h5 {
    color: black;
    text-align: center;
«««    background-color:white;
    font-size: 20px;
}
th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
«««	border-collapse: collapse;
«««	padding: 0;
«««	border: none;
	background-color: lightblue;
    font-size: 30px;
}
table {
	padding: 0;
	border: none;
«««	border: 1px solid black;
	border-collapse: collapse;
    font-family: courier;
    width: 100%;
}
td{
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
«««	border-collapse: collapse;
«««	border: none;
«««	padding: 0;
«««	background-color: white;
    font-size: 25px;
}
</style>
<title>Conference«c.name»</title>
</head>
<body>
««««««<div class="static"><h1><u> EclipseCon 2017</u></h1></div>
<table>
  <tr bgcolor="NAVY"> 
  	<td COLSPAN="«allRooms.size»">
         <h3>«c.name» Schedule</h3>
    </td>
  </tr>
  <tr>
  «FOR r : allRooms»
  <th style="width:«100/(allRooms.size)»%"><h5>«r.name»</h5></th>
«ENDFOR»
  </tr> 
«FOR day : c.days»
«day.compile»
«ENDFOR»
  </table>
</body>
</html>
«ENDFOR»
	'''
	def compile (ConferenceDay it)'''
		«val slots= EcoreUtil2.eAllOfType(it, Slot)»
		«FOR s : slots»
<tr bgcolor="SILVER">
 	<td ALIGN="CENTER" COLSPAN="4">
		<h5>«s.startHour»:«s.startMin» - «s.endHour»:«s.endMin»</h5>	
	</td>
</tr>
	«IF (s.name!==null)»
<tr bgcolor="WHITE" ALIGN="CENTER">
	<td COLSPAN="4">
	 <a href="https://www.eclipsecon.org/france2017/schedule_item/«s.name.toLowerCase.replace(' ','-')»">
	 <h4 >«s.name»</h4>
	 </a> 	
	</td>
</tr>
	«ENDIF»
<tr bgcolor="WHITE">
	«FOR r : s.roomstalks»
	«r.compile»
	«ENDFOR»
</tr>
«««<tr bgcolor="WHITE">
«««	«FOR r : s.roomstalks»
«««	<td>
«««	<h4>«r.talk.name»</h4>
«««	<h4>«r.talk.getSpeakers»</h4>
«««	</td>
«««	«ENDFOR»
«««</tr>
	«ENDFOR»
	'''
	def compile(RoomsTalks it)'''
	<td>
«««	<h4>«talk.name»<br>«talk.getFeature»<br>«talk.getSpeakers»</h4>
	<a href="file:///C:/Users/aziat/runtime-EclipseXtext/conference/src-gen/«talk.name.replace(':','').replace('?','').replace(' ','').toLowerCase».html">
	<h4>«talk.name»</h4></a>
	<h2>«talk.getFeature»</h2>
	<h2>«talk.getSpeakers»</h2>
	</td>
	'''
	def getSpeakers(Talks it)'''
		«val allSpeakers = EcoreUtil2.eAllOfType(it,Speaker)»
		«FOR s : allSpeakers»«s.name»«IF s.company !==null» («s.company») «ENDIF»«ENDFOR»
	'''
	def getFeature(Talks it)'''
		«val allFeatures = EcoreUtil2.eAllOfType(it,Feature)»
		«FOR f : allFeatures»
		«IF f.name.equalsIgnoreCase("Track")»
		«f.type.name»
		«ENDIF»
		«ENDFOR»
	'''
}