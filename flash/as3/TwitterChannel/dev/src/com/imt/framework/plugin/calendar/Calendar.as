package com.imt.framework.plugin.calendar
{
	
	import com.bedrock.framework.core.dispatcher.BedrockDispatcher;
	import com.bedrock.framework.plugin.util.ButtonUtil;
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.NumericStepper;
	import fl.controls.TextInput;
	import fl.data.DataProvider;
	
	
	public class Calendar extends Sprite {
		
		private var button:Sprite = new Sprite();
		
		//variables
		private var dateCellFormat:TextFormat;
		private var dayLabelTxtFmt:TextFormat;
		private var checkBoxTxtFmt:TextFormat;
		private var cellW:Number; //Width
		private var cellP:Number; //Padding
		private var allDatesCells:Array = new Array();
		private var weekDays:Array = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
		private var currDateTime:Date = new Date();
		private var firstDay:Date = new Date(currDateTime.fullYear, currDateTime.month, 1);
		private var firstDayColumn:uint = firstDay.day;
		private var daysOfMonths:Array = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
		private var maxDays:uint;
		private var yearPickerNS:NumericStepper; //stepper to pick years
		
		private var nameTi:TextInput = new TextInput(); 
		private var tf:TextFormat = new TextFormat(); 
		
		private var CheckBox1:CheckBox;
		private var boxBG:Sprite;
		
		private var scheduleXML:XML = new XML();
		
		private	var schedulerY:int=20;
		private	var displayHours:String;
		private	var displayMinutes:String;
		private	var nextTime:String;
		private	var occupant:String = "vacant";
		//			var timeScheduler:TextField= new TextField();
		
		//Flag to create XML instead of loading.
		private var xmlGO:Boolean = false;
		
		private var checkBoxArray: Array = new Array();
		private var checkBoxBGArray: Array = new Array();
		
		private var selectedDate:TextField = new TextField();
		private var timeSlots:Array = new Array();
		
		private var months:Array = [
			{label:"January", data:0},
			{label:"February",data:1},
			{label:"March", data:2},
			{label:"April", data:3},
			{label:"May", data:4},
			{label:"June", data:5},
			{label:"July", data:6},
			{label:"August", data:7},
			{label:"September", data:8},
			{label:"October", data:9},
			{label:"November", data:10},
			{label:"December", data:11},
		];
		
		private var mouseOverDay:String = currDateTime.date.toString();
		private var mouseOverMonth:String = months[currDateTime.month].label;
		private var monthWritten:String = months[currDateTime.month].label;
		private var monthIndex:int= currDateTime.month;
		private var mouseOverYear:String = currDateTime.fullYear.toString();
		private var mouseOverPreviousMonth:String;
		private var mouseOverWeekday:String;
		
		
		private var whichDay:int;
		
		private	var xmlMonthID:String = mouseOverMonth + mouseOverDay + mouseOverYear.substr(2,3);
		
		private var monthPickerCB:ComboBox; //pick a month
		
		
		//Constructor
		public function Calendar( fontFace:String = "Arial", fontSize:int = 15, cellWidth:Number=140, 
								  padding:Number = 3, originX:Number = 0, originY:Number=-235, 
								  cbX:Number = 0, cbY:Number = 15, nsX:Number = 14, nsY:Number = 15, monthsRange:int = 39){
			
			trace ("init")
		
			//This simply identifies which weekday it is today.
			switch (currDateTime.day)
			{
				case 0:
					trace ("Sunday")
					mouseOverWeekday="Sunday";
					break;
				case 1:
					trace ("Monday")
					mouseOverWeekday="Monday";
					break;
				case 2:
					trace ("Tuesday")
					mouseOverWeekday="Tuesday";
					break;
				case 3:
					trace ("Wednesday")
					mouseOverWeekday="Wednesday";
					break;
				case 4:
					trace ("Thursday")
					mouseOverWeekday="Thursday";
					break;
				case 5:
					trace ("Friday")
					mouseOverWeekday="Friday";
					break;
				case 6:
					trace ("Saturday")
					mouseOverWeekday="Saturday";
					break;
				
				default:
					trace("Something wrong with weekdays switch")
					
			}
			cellW = cellWidth;
			cellP = padding;
			monthPickerCB = new ComboBox();
			
			yearPickerNS = new NumericStepper();
			
			//Formats text
			setTextFormat( fontFace, fontSize);
		
			//Make the actual grid the calendar is overlayed on
			makeDatesCellGrid(originX, originY);
		
			//Labels "mon" "tue"...etc
			makeDaysLabels( originX, originY);
			
			originX= originX+650;
			//Sets up the calendar with dates appropriate to the month/year.
			monthSetup();

			//Serup of the ComboBox that allows month change
			monthPicker( cbX, cbY);

			//Setup of the stepper that allows year change
			yearPicker (nsX, nsY, monthsRange);

			// works on creating area to right of calendar for scheduling
			createDateFocus(originX, originY);

			//Same as dateFocus, but focuses on the times available
			createScheduler(originX, originY);

			for (var i:int = 0; i<checkBoxArray.length;i++){
				if (checkBoxArray[i].label.substring(8,checkBoxArray[i].label.length)!="vacant"){
					checkBoxBGArray[i].graphics.beginFill(0x000066, 1);
					checkBoxBGArray[i].graphics.drawRect(0, 0, 200, 40);
					checkBoxBGArray[i].graphics.endFill();
				}
			}
			
			
			createButton(originX+580, originY);
			createInput(originX, originY);
}
		
		private function setTextFormat (whichFont:String, size:int):void {
			
			//date text format
			dateCellFormat = new TextFormat();
			dateCellFormat.font = whichFont;
			dateCellFormat.color = 0xFFFFFF;
			dateCellFormat.size = size;
			dateCellFormat.align = "center";
			
			//day label text format
			dayLabelTxtFmt = new TextFormat();
			dayLabelTxtFmt.font = "_sans";
			dayLabelTxtFmt.color = 0x000000;
			dayLabelTxtFmt.size = size - 3;
			
			//CheckBox label text format
			checkBoxTxtFmt = new TextFormat();
			checkBoxTxtFmt.font = "_sans";
			checkBoxTxtFmt.color = 0xFFFFFF;
			checkBoxTxtFmt.size = size - 3;
			
		}
		
		
		//This method sets the display for the text field to the right of the calendar to whatever date the user has selected. By default it is today's date.
		private function createDateFocus(xSpacing:Number, ySpacing:Number):void {
			
			selectedDate.text = currDateTime.date.toString();
			
			addChild (selectedDate);
			
			selectedDate.x=xSpacing+350;
			selectedDate.height=50;
			selectedDate.text = mouseOverWeekday + " , " + monthWritten + " " + mouseOverDay;
			selectedDate.width=200;
			selectedDate.y = ySpacing-20;
			selectedDate.setTextFormat(dayLabelTxtFmt);
		}
		private function updateDateFocus():void {
			selectedDate.text = mouseOverWeekday + " , " + monthWritten + " " + mouseOverDay;
			selectedDate.setTextFormat(dayLabelTxtFmt);
		}
		
		
		private function makeDatesCellGrid(cellXPos:Number, cellYPos:Number):void {
			
			
			
			//create grid
			for (var i:int = 0; i<42; i++) {
				
				var dateCell:TextField= new TextField();
				
				/*	dateCell.addEventListener(MouseEvent.CLICK, myButtonClick);
				dateCell.addEventListener(MouseEvent.ROLL_OVER, myButtonRollover);
				dateCell.addEventListener(MouseEvent.ROLL_OUT, myButtonRollout);*/
				
				addChild(dateCell);
				
				//		dateCell.width = dateCell.height =cellW-cellP;
				
				
				
				//position cells to form a grid (7x6 = 42)
				dateCell.x = cellXPos + (cellW * (i-(Math.floor(i/7)*7)));
				dateCell.y = cellYPos + (cellW * Math.floor(i/7));
				
				
				dateCell.addEventListener(MouseEvent.CLICK, myButtonClick);
				dateCell.addEventListener(MouseEvent.ROLL_OVER, myButtonRollover);
				dateCell.addEventListener(MouseEvent.ROLL_OUT, myButtonRollout);
				
				
				//put all date cells into array for further access
				allDatesCells.push(dateCell);
			}
			
		}
		private function myButtonClick(ev:MouseEvent):void
		{
			//change date to whatever date the user clicked on
			focusDate(cellW);
			
			xmlMonthID = mouseOverMonth + mouseOverDay + mouseOverYear.substr(2,3);
			trace (xmlMonthID)
			
			trace("myButton has been clicked.");
			
			//Pull up the schedule for the selected date.
			loadScheduler();
		}
		
		private function focusDate(calendarDateSize:Number):void {
			
			
			
			//This loop takes the mouseX and mouseY variables and uses that to hone into which cell the user clicked on in the Calendar
			for (var i:int = 0; i<42; i++){
				
				if ((mouseX >= allDatesCells[i].x&&mouseX<=allDatesCells[i].x+calendarDateSize)&&
					(mouseY >= allDatesCells[i].y&&mouseY<= allDatesCells[i].y+calendarDateSize)){
					
					mouseOverDay = allDatesCells[i].text;
					whichDay=i;
					
					//The following is to allow the previous or next months to display properly if a user clicks on a corresponding cell.
					if (allDatesCells[i].alpha == .5) {
						if (monthIndex==0)
						{
							monthWritten= "December";
						}
						else{
							monthWritten = months[monthIndex-1].label;
						}					
					}
						
					else if (allDatesCells[i].alpha == 0.59765625){
						
						if (monthIndex==11)
						{
							monthWritten="January";
						}
						else {
							monthWritten = months[monthIndex+1].label;
						}
						
					}
						
					else {
						monthWritten = months[monthIndex].label;
					}
					
					mouseOverMonth = monthWritten;
				}
				
				
			}
			
			
			// This switch takes the position from 0 to 42 of days in the calendar and determines which day of the week it is
			switch (whichDay % 7)
			{
				case 0:
					trace ("Sunday")
					mouseOverWeekday="Sunday";
					break;
				case 1:
					trace ("Monday")
					mouseOverWeekday="Monday";
					break;
				case 2:
					trace ("Tuesday")
					mouseOverWeekday="Tuesday";
					break;
				case 3:
					trace ("Wednesday")
					mouseOverWeekday="Wednesday";
					break;
				case 4:
					trace ("Thursday")
					mouseOverWeekday="Thursday";
					break;
				case 5:
					trace ("Friday")
					mouseOverWeekday="Friday";
					break;
				case 6:
					trace ("Saturday")
					mouseOverWeekday="Saturday";
					break;
				
				default:
					trace("Something wrong with weekdays switch")
					
			}
			
			updateDateFocus();
			
			
		}
		
		
		private function myButtonRollover(ev:MouseEvent):void {
			//Put code you'd like to execute when the button is rolled over below
			//trace("myButton has been rolled over.");
		}
		private function myButtonRollout(ev:MouseEvent):void {
			//Put code you'd like to execute when the button is rolled out below
			//trace("myButton has been rolled out.");
		}
		
		private function createButton(xSpacing:Number, ySpacing:Number): void {
			
			//first we create the Sprite which will be our button
			var button:Sprite = new Sprite();
			// then we draw a green rectangle inside of it
			button.graphics.beginFill(0x000066, 1);
			button.graphics.drawRect(0, 0, 100, 50);
			button.graphics.endFill();
			button.x =xSpacing;
			button.y= ySpacing;
			// then we add the button to stage
			this.addChild(button);
			
			
			button.buttonMode  = true;
			button.mouseChildren = false;
			
			button.addEventListener(MouseEvent.CLICK, bClick, false, 0, true);
		}
		
		private function bClick(e:MouseEvent):void {
			// When user clicks will schedule the times and repopulate the list of times/reservations.
			trace (nameTi.text)
			reserveTimes();
			writeXML();
			saveXMLwithPHP();
		}
		
		private function boxClick(e:MouseEvent):void {
			
			//this identifies where the user clicked.
			var daNumber:int = Number(e.target.name);
			
			// If the box is already selected, deselect it.
			if (checkBoxArray[daNumber].selected == true && checkBoxArray[daNumber].label.substring(8,checkBoxArray[daNumber].label.length)== "vacant"){
				checkBoxBGArray[daNumber].graphics.beginFill(0x000000, 1);
				
				checkBoxBGArray[daNumber].graphics.drawRect(0, 0, 200, 40);
				
				checkBoxBGArray[daNumber].graphics.endFill();
				
				checkBoxArray[daNumber].selected = false;
			}
				
				//if not selected, select it.
			else {
				
				checkBoxBGArray[daNumber].graphics.beginFill(0x000066, 1);
				
				checkBoxBGArray[daNumber].graphics.drawRect(0, 0, 200, 40);
				
				checkBoxBGArray[daNumber].graphics.endFill();
				
				
				checkBoxArray[daNumber].selected = true;
			}
			
		}
		
		private function writeXML():void{
			
			
			scheduleXML = new XML(<month id= {xmlMonthID}/>);
			
			for (var i:int=0;i<checkBoxArray.length;i++){
				
				scheduleXML.appendChild(<time id= {checkBoxArray[i].label.substr(0,5)}>
				<occupant id = {checkBoxArray[i].label.substr(8,checkBoxArray[i].label.length)}/></time>);
			}
		}
		private function reserveTimes():void{
			
			for (var i:int=0;i<checkBoxArray.length;i++){
				
				if (checkBoxArray[i].selected==true) {
					
					//NOTE: Try to limit length so the text doesn't get cut off. An input of 14 chars is probably the maximum for the current length of the field.
					checkBoxArray[i].label = checkBoxArray[i].label.substr(0,8) + nameTi.text;
					checkBoxArray[i].selected=false;
				}
			}
			
			
			colorReservations();
		}
		
		//Creates the field the User will use to enter their name and reserve a time.
		private function createInput(xSpacing:Number, ySpacing:Number):void {
			
			
			addChild(nameTi); 
			
			nameTi.restrict = "A-Z .a-z"; 
			
			tf.font = "Georgia"; 
			tf.color = 0x000000; 
			tf.size = 16; 
			
			nameTi.x=xSpacing+580; 
			nameTi.y=ySpacing + 75; 
			nameTi.setStyle("textFormat", tf); 
		}
		
		private function createScheduler(xSpacing:Number, ySpacing:Number):void {
			
			
			//Setting up CheckBoxes
			for (var i:int=0;i<=1410;i+=30) {
				
				/*		var timeScheduler:TextField= new TextField();
				addChild(timeScheduler);*/
				
				CheckBox1 = new CheckBox();
				
				boxBG = new Sprite();
				// then we draw a green rectangle inside of it
				boxBG.graphics.beginFill(0x000000, 1);
				boxBG.graphics.drawRect(0, 0, 200, 40);
				boxBG.graphics.endFill();
				boxBG.name = (i/30).toString();
				boxBG.addEventListener(MouseEvent.CLICK, boxClick, false, 0, true);
				boxBG.x = xSpacing + 350;
				boxBG.y= schedulerY+ySpacing-15;
				addChild(boxBG);
				
				checkBoxBGArray.push(boxBG);
				
				
				displayHours = Math.floor(i/60).toString();
				displayMinutes= (i%60).toString();
				
				if (Math.floor(i/60)<10){
					displayHours ="0" + displayHours;
				}
				if (i<60) {
					displayHours= "00";
					displayMinutes=i.toString();
				}
				
				if (displayMinutes == "0") {
					displayMinutes="00";
				}
				
				CheckBox1.label = displayHours + ":" + displayMinutes + " - " +  occupant;
				
				//trace (CheckBox1.label)
				CheckBox1.y=schedulerY+ySpacing;
				schedulerY+=43;
				CheckBox1.x = xSpacing + 350;
				CheckBox1.name = (i/30).toString();
				CheckBox1.width=200;
				CheckBox1.addEventListener(Event.CHANGE, checkBSelected);
				CheckBox1.height=5;
				CheckBox1.setStyle("textFormat",checkBoxTxtFmt);
				
				addChild(CheckBox1);
				checkBoxArray.push(CheckBox1);
				
				occupant = "vacant";
				
				
			}
			loadScheduler();
			//Create a schedule that users can view and reserve time slots in. These time slots will be at 15 or 30 minute intervals depending on how i is incremented.
			
			
			
		}
		private function checkBSelected(e:Event):void{
			if (e.target.selected == true){
				
			}
		}
		
		private function loadScheduler():void{
			loadDayXML();
			for (var i:int = 0; i<checkBoxArray.length;i++){
				if (checkBoxArray[i].label.substring(8,checkBoxArray[i].label.length)!="vacant"){
					checkBoxBGArray[i].graphics.beginFill(0x000066, 1);
					checkBoxBGArray[i].graphics.drawRect(0, 0, 200, 40);
					checkBoxBGArray[i].graphics.endFill();
					
				}
				checkBoxArray[i].selected=false;
			}
			
			addEventListener(Event.COMPLETE, continueScheduler);
			
		}
		
		private function noFileFoundScheduler(e:Event):void {
			trace("FileNotFound")
			var iterator:int = 0;
			
			scheduleXML = new XML(<month id= {xmlMonthID}/>);
			// This adds the long list of times to the right of the calendar. 
			for (var i:int=0;i<=1410;i+=30) {
				
				/*		var timeScheduler:TextField= new TextField();
				addChild(timeScheduler);*/
				
				
				displayHours = Math.floor(i/60).toString();
				displayMinutes= (i%60).toString();
				
				if (Math.floor(i/60)<10){
					displayHours ="0" + displayHours;
				}
				if (i<60) {
					displayHours= "00";
					displayMinutes=i.toString();
				}
				
				if (displayMinutes == "0") {
					displayMinutes="00";
				}
				
				scheduleXML.appendChild(<time id= {displayHours + ":" + displayMinutes}><occupant id = {occupant}/></time>);
				
				
				//CheckBox1.label = displayHours + ":" + displayMinutes + " - " +  occupant;
				//trace (iterator)
				checkBoxArray[iterator].label = scheduleXML.time[iterator].@id + " : " + scheduleXML.time[iterator].occupant.@id;
				iterator++;
				
				occupant = "vacant";
				
				repaintCheckboxes();
				colorReservations();
			}
			
			//addChild(timeScheduler);
			//trace (scheduleXML)
			
			
		}
		
		private function colorReservations():void{
			
			for (var i:int = 0; i<checkBoxArray.length;i++){
				if (checkBoxArray[i].label.substring(8,checkBoxArray[i].label.length)!="vacant"){
					checkBoxBGArray[i].graphics.beginFill(0x000066, 1);
					checkBoxBGArray[i].graphics.drawRect(0, 0, 200, 40);
					checkBoxBGArray[i].graphics.endFill();
				}
			}
			
		}
		
		//Gets rid of blue checkbox areas when user switches dates.
		private function repaintCheckboxes():void{
			for (var i:int = 0; i<checkBoxBGArray.length;i++){
				checkBoxBGArray[i].graphics.beginFill(0x000000, 1);
				checkBoxBGArray[i].graphics.drawRect(0, 0, 200, 40);
				checkBoxBGArray[i].graphics.endFill();
			}
		}
		
		private function continueScheduler(e:Event):void {
			trace("CONTINUE")
			var iterator:int = 0;
			//trace (scheduleXML)
			// This adds the long list of times to the right of the calendar. 
			for (var i:int=0;i<=1410;i+=30) {
				
				checkBoxArray[iterator].label= scheduleXML.time[iterator].@id + " : " + scheduleXML.time[iterator].occupant.@id;
				iterator++;
				
			}
			repaintCheckboxes();
			colorReservations();
		}
		
		
		public function loadDayXML():Boolean
		{
			
			var _loader:URLLoader = new URLLoader();
			trace ("loading....")
			//If a file is found...onXMLLoaded
			_loader.addEventListener(Event.COMPLETE, onXMLLoaded);
			//Else if a file is not found...noFileFoundScheduler
			_loader.addEventListener(IOErrorEvent.IO_ERROR, noFileFoundScheduler);
			//THE URLRequest should be a path to the appropriate folder ending with +xmlMonthID+".xml"
			//_loader.load(new URLRequest("C:/Users/Admin/Documents/PROJECTS/GIT/MCH/Telemedicine_Wall_2.0/dev/deploy/assets/xml/"+xmlMonthID+".xml"));
			_loader.load(new URLRequest("http://localhost/assets/xml/"+xmlMonthID+".xml"));
		
			return true;
			
		}
		
		// XML has loaded.
		private function onXMLLoaded(e:Event):void
		{
			trace(this + " : onXMLLoaded");
			scheduleXML = new XML(e.target.data);
			//	trace (scheduleXML)
			dispatchEvent ( new Event ( Event.COMPLETE ) )
			
			/*	// Announce the XML is ready for use.
			BedrockDispatcher.dispatchEvent( new MapEvent( MapEvent.XML_READY, this, { xml:_xml } ) );
			*/
		}
		
		//Saving the XML file with the help of a PHP file
		public function saveXMLwithPHP():Calendar {
			
			trace(this + " : saveXMLwithPHP");
			// declaring var xmlcontents String.
			var xmlcontents:String = scheduleXML.toXMLString();
			
			// declaring var SERVER_PATH String. This is the path for the saving-xml.php.
			//var SERVER_PATH:String = "C:/";
			
			// declaring var foldername String. This is the folder container of the saved XML file
			var folderName:String = "../xml";
			
			// declaring var filename String. This is the filename of the XML file
			var fileName:String = xmlMonthID+".xml";
			
			// declaring var dataPass URLVariables
			var dataPass:URLVariables = new URLVariables();
			
			// declaring var urlLoader URLLoader
			var urlLoader:URLLoader = new URLLoader();
			
			// declaring var previewRequest URLRequest
			var previewRequest:URLRequest = new URLRequest("http://localhost/assets/scripts/savingxml.php");
			
			// i used method "post" in this sample. you can edit this
			previewRequest.method = URLRequestMethod.POST;
			
			// setting dataPass variables to be passed to PHP
			dataPass.filename = fileName;
			dataPass.xmlcontents = xmlcontents;
			dataPass.foldername = folderName;
			
			// passing dataPass data PHP
			previewRequest.data = dataPass;
			trace (folderName);
			//	trace (scheduleXML)
			// calling the PHP or loading the PHP
			urlLoader.load(previewRequest);
			
			
			nameTi.text = "";
			return this;
		}
		
		private function makeDaysLabels (cellXPos:Number, cellYPos:Number):void {
			
			//Add week day names
			for (var i:int = 0; i<7; i++) {
				
				var dayLabel:TextField = new TextField();
				addChild(dayLabel);
				
				dayLabel.selectable = false;
				dayLabel.text = weekDays[i];
				dayLabel.setTextFormat(dayLabelTxtFmt);
				dayLabel.x = cellXPos+ ((cellW/2)- 30) + (cellW * i);
				dayLabel.y = cellYPos - 30;
				dayLabel.height = 40;
				
			}
			
		}
		
		private function monthSetup():void {
			
			for (var i:int = 0; i<42; i++){
				
				allDatesCells[i].text = "";
				//	trace (allDatesCells[i].x)
				//decor all cells
				allDatesCells[i].background = true;
				allDatesCells[i].backgroundColor = 0x000000;
				allDatesCells[i].border = true;
				allDatesCells[i].borderColor = 0xCCCCCC;
				allDatesCells[i].selectable = false;
				allDatesCells[i].width = allDatesCells[i].height =cellW-cellP;
				allDatesCells[i].setTextFormat(dateCellFormat);
				/*allDatesCells[i].addEventListener(MouseEvent.CLICK, myButtonClick);
				allDatesCells[i].addEventListener(MouseEvent.ROLL_OVER, myButtonRollover);
				allDatesCells[i].addEventListener(MouseEvent.ROLL_OUT, myButtonRollout);*/
				
			}
			
			arrangeDates();
			prevMonthDates();
			nextMonthDates();
		}
		
		private function arrangeDates():void {
			
			//get column number for first day of the month
			if (firstDay.day ==0)
			{
				//when last date of previous month is on saturday then move to second row
				firstDayColumn = firstDay.day + 7;
			}
			else
			{
				firstDayColumn = firstDay.day;
			}
			
			//get max days for current month w.r.t leap year if any
			maxDays= (firstDay.getFullYear()%4 == 0 && firstDay.getMonth() == 1 ? 29 : daysOfMonths [firstDay.getMonth()]);
			
			// Possible note for later: actually, there’s a little more to it than that: years divisible by 100 are usually not leap years – unless they are also divisible by 400. 
			
			//put dates for current month
			for (var i:int = 0; i<maxDays; i++) {
				
				allDatesCells[firstDayColumn + i].text = i + 1;
				allDatesCells[firstDayColumn + i].setTextFormat(dateCellFormat);
				
				allDatesCells[firstDayColumn + i].alpha = 1;
				
				//Highlight today
				if (firstDay.fullYear == currDateTime.fullYear && firstDay.month == currDateTime.month)
				{
					if (allDatesCells[firstDayColumn + i].text == currDateTime.date)
					{
						allDatesCells[firstDayColumn + i].backgroundColor = 0x000066
					}
				}
				
			}
			
			
		}
		
		//Distinguishes dates from the previous month displayed on the calendar.
		private function prevMonthDates():void{
			
			var prevMonthFirstDay:Date = new Date(firstDay.fullYear, firstDay.month, firstDay.date - 1);
			
			for (var i:int = firstDayColumn-1; i>=0; i--) {
				
				allDatesCells[i].text = prevMonthFirstDay.date - ((firstDayColumn - 1) - i);
				allDatesCells[i].setTextFormat(dateCellFormat);
				allDatesCells[i].alpha = 0.5;
				
			}
		}
		
		//Distinguishes dates from the next month displayed on the calendar.
		private function nextMonthDates():void {
			
			for (var i:int = 1; i < (42 - maxDays - (firstDayColumn - 1)); i++) {
				
				allDatesCells[(firstDayColumn - 1) + i + maxDays].text = i;
				allDatesCells[(firstDayColumn - 1) + i + maxDays].setTextFormat(dateCellFormat);
				allDatesCells[(firstDayColumn - 1) + i + maxDays].alpha = 0.6;
				;
			}
		}
		
		private function monthPicker(cbX:Number, cbY:Number):void {
			
			monthPickerCB.dataProvider = new DataProvider(months);
			addChild(monthPickerCB);
			
			//position combobox
			monthPickerCB.x = cbX;
			//monthPickerCB.y = (cellW*6) + cbY;
			monthPickerCB.y= 600;
			monthPickerCB.width = 130;
			monthPickerCB.height=35;
			monthPickerCB.selectedIndex = currDateTime.month;
			monthPickerCB.textField.setStyle("textFormat",dayLabelTxtFmt);
			monthPickerCB.dropdown.setStyle("textFormat", dayLabelTxtFmt);
			
			monthPickerCB.addEventListener(Event.CHANGE, pickMonth);
		}
		
		private function pickMonth(e:Event):void {
			
			firstDay.month = ComboBox(e.target).selectedItem.data;
			
			mouseOverMonth= ComboBox(e.target).selectedItem.label;
			
			monthIndex = ComboBox(e.target).selectedIndex;
			
			//mouseOverPreviousMonth=ComboBox(ComboBox(e.target).selectedIndex - 1).selectedItem.label;
			
			trace (mouseOverMonth)
			monthSetup();
		}
		
		private function yearPicker(nsX:Number, nsY:Number, maxYrsRange:int):void {
			
			yearPickerNS.maximum = currDateTime.fullYear + maxYrsRange;
			yearPickerNS.minimum = currDateTime.fullYear - maxYrsRange;
			yearPickerNS.value = currDateTime.fullYear;
			addChild(yearPickerNS);
			
			//position numeric stepper
			yearPickerNS.x = monthPickerCB.width + nsX;
			yearPickerNS.y = (cellW*6) + nsY;
			
			yearPickerNS.addEventListener(Event.CHANGE, pickYear);
		}
		
		private function pickYear(e:Event):void {
			
			firstDay.fullYear = e.target.value;
			
			mouseOverYear = e.target.value;
			/*	
			trace (mouseOverYear)
			trace (mouseOverYear.substr(2,3))*/
			monthSetup();
		}
		
		
	}
}