package org.xtext.example.conPlan.generator

import org.xtext.example.conPlan.conPlan.Model
import org.xtext.example.conPlan.conPlan.Conference
import org.xtext.example.conPlan.conPlan.ConferenceDay
import java.util.GregorianCalendar
import java.text.SimpleDateFormat
import org.eclipse.xtext.EcoreUtil2
import org.xtext.example.conPlan.conPlan.Slot
import java.util.Calendar
import org.xtext.example.conPlan.conPlan.RoomsTalks
import org.xtext.example.conPlan.conPlan.Talks
import java.util.Date
import java.util.Locale
import org.xtext.example.conPlan.conPlan.Feature
import org.xtext.example.conPlan.conPlan.Speaker

class ICalGenerator {
	
	def toICal(Conference con)'''
		BEGIN:VCALENDAR
		«FOR day: con.days»
			«day.compile»
		«ENDFOR»		
		END:VCALENDAR
	'''
	
	def compile(ConferenceDay it)'''
		«val slots= EcoreUtil2.eAllOfType(it, Slot)»
		«var sf = new SimpleDateFormat("yyyyMMdd")»
«««		«var sdf = new SimpleDateFormat("HH:mm")»
«««		«val date = new Date()»
		«var fs = new SimpleDateFormat("HHmmss")»
		«FOR s : slots»
		«var start = new GregorianCalendar»
		«start.set(GregorianCalendar.DATE,Integer.parseInt(day))»
		«start.set(GregorianCalendar.MONTH,Integer.parseInt(monthParsing.toString))»
		«start.set(GregorianCalendar.YEAR, Integer.parseInt(year))»
		«start.set(GregorianCalendar.HOUR_OF_DAY,Integer.parseInt(s.startHour))»
		«start.set(GregorianCalendar.MINUTE,Integer.parseInt(s.startMin))»
«««
		«var end = new GregorianCalendar»
		«end.set(GregorianCalendar.DATE,Integer.parseInt(day))»
		«end.set(GregorianCalendar.MONTH,Integer.parseInt(monthParsing.toString))»
		«end.set(GregorianCalendar.YEAR, Integer.parseInt(year))»
		«end.set(GregorianCalendar.HOUR_OF_DAY,Integer.parseInt(s.endHour))»
		«end.set(GregorianCalendar.MINUTE,Integer.parseInt(s.endMin))»
		«IF s.name!==null»
		BEGIN:VEVENT
«««		DTSTART:«dateFormat(date)»
		DTSTART:«sf.format(start.time)»T«fs.format(start.time)»
		DTEND: «sf.format(end.time)»T«fs.format(end.time)»
«««		DURATION: PT20M
		SUMMARY: «s.name»
		DESCRIPTION: 
		«s.getRoom»
		END:VEVENT
		«ENDIF»
		«FOR r : s.roomstalks»		
		BEGIN:VEVENT
		DTSTART:«sf.format(start.time)»T«fs.format(start.time)»
		DTEND: «sf.format(end.time)»T«fs.format(end.time)»
«««		DTSTART:«dateFormat(date)»
«««		DURATION:PT45M
		«r.compile»
		END:VEVENT
		«ENDFOR»
		«ENDFOR»		
	'''
	def monthParsing(ConferenceDay it)'''
		«var itDate = new SimpleDateFormat("MMMM", Locale.ENGLISH).parse(month) »
		«var cal = Calendar.getInstance()»
		«cal.time = itDate»
		«if (month !==null){
			var iM = cal.get(Calendar.MONTH)
			return iM
		}»
	'''
	def getRoom(Slot it)'''
		«var allRooms= EcoreUtil2.eAllOfType(it,RoomsTalks)»
		«FOR r: allRooms»
		«IF r.room.name!==null»
		LOCATION: «r.room.name»
		«ENDIF»
		«ENDFOR»
«««		«for ( r:allRooms){
«««			return r.room.name
«««		}»
	'''
	def compile(RoomsTalks it)'''
		«var allTalks = EcoreUtil2.eAllOfType(it,Talks)»
«««		«IF (allTalks.add(it.talk))»
		«IF (allTalks.add(it.talk))»
		LOCATION: «room.name»
		SUMMARY: «talk.name»
		DESCRIPTION:«talk.description.name.toString»| «talk.getFeature»
		«ENDIF»
	'''
	def dateFormat(Date date)'''
		«var df = new SimpleDateFormat("yyyyMMdd")»
		«var hf = new SimpleDateFormat("HHmmss")»
		«if(date !=0){
			df.format(date)+'T'+hf.format(date)
		}»
	'''
	def getFeature(Talks it)'''
		«var allFeatures = EcoreUtil2.eAllOfType(it,Feature)»
		«var allSpeakers = EcoreUtil2.eAllOfType(it,Speaker)»
		FEATURES: «FOR f : allFeatures»«f.name.toUpperCase»_«f.type.name» «ENDFOR»| SPEAKERS: «FOR s : allSpeakers»«s.name»«IF s.company !==null» (COMPANY: «s.company») «ENDIF»«ENDFOR»
	'''
}