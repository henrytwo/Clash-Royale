package
//PROGRAMMED BY HENRY TU AND ANDREW GAO
//MUCH OF THE CODE IS REPEATED DOWNWARDS AND ARE NOT COMMENTED
//creates a package for all the different
//files you will work in this project
{
	import flash.display.MovieClip;//provides public function functionality for the Flash game
	import flash.events.*; //mouse click, keypress
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.*;	
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.media.SoundChannel;
	import flash.external.ExternalInterface;
	import flash.utils.getTimer;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
	import flash.ui.GameInput;
	import flash.display.Loader;
	import flash.filters.DropShadowFilter;

	public class MainRoyale extends MovieClip
	//the name MUST match the name of the .AS file
	{
		//Place for troop to goto
		var pvy:Array;
		var pvx:Array;
		var ppvy:Array;
		var ppvx:Array;
		
		//Shooting
		var bullet:Bullet;
		var bArray:Array=new Array();
		
		//Health Bar
		
		var currentEmotion:int=0;//resets current emotion
		var healthBarBack:HealthBarBack;//Back of health bar
		var healthBarHomeBack:HealthBarBack;//Back of health bar
		var healthBarEnemy:HealthBarEnemy;//Enemy's health bar
		var healthBarHome:HealthBarHome;//Home's health bar
		
		var healthBarArray:Array=new Array();//Array for back of bar
		var healthBarHomeArray:Array=new Array();//Array for back of bar
		var healthEnemyArray:Array=new Array();//Array for bar
		var healthHomeArray:Array=new Array();//Array for bar
		var cardLoopArray:Array=new Array();
		
		//Troops
		var wizard:Wizard;
		var archer:Archer;
		var barbarian:Barbarian;
		var palidan:Palidan;
		var necro:Necro;
		var storm:Storm;
		var andrew:Andrew;
		var bomber:Bomber;
		var henry:Henry;
		var knight:Knight;
		var health:Health;
		var rage:Rage;
		var lightning:Lightning;
		var god:God;
		
		//Array for AI
		var homeSpellArray:Array=new Array();//array for home spells
		var enemySpellArray:Array=new Array();//array for enemy spells
		var homeArray:Array=new Array();//array for home troops
		var dist:Number=9999;
		var distHome:Number=9999;
		var homeID:Array=new Array();//Array for the home's ID
		var homeHealth:Array=new Array();//array for home's health
		var homeOriginalHealth:Array=new Array();//array to keep track of home's original hea;th
		
		var enemyArray:Array=new Array();//array for enemy
		var enemyHealth:Array=new Array();//array for enemy's health
		var enemyOriginalHealth:Array=new Array();//array to keep track of enemy's original hea;th
		var enemyID:Array=new Array();//Array to identify enemy
		
		//Troop AI
		var angleRadians,angleDegrees:Number;//decimal values
		var angleRadiansHome,angleDegreesHome:Number;//decimal values
		var closestDistance:Number;
		var closestEnemy:int;
		var closestHome:int;
		var closestDistanceHome:Number;
		
		var selectedCard:int=-1;
		var enemyEmoTimer:Timer=new Timer(2000,1);//Timers for enemy emo response
		var enemyBubbleTimer:Timer=new Timer(1500,1);//Timer to dismiss response
		
		var spawnRate:int=1;
		var elixir:Number=2;//sets default amount of elixir
		var overTime:Boolean=false;//to show is timer is in ovetime
		var randomNameI:Array=new Array();//array with enemy names
		var randomNameII:Array=new Array();//array with enemy names
		var timer:Timer=new Timer(1000);//sets stopwatch
		var emoTimer:Timer=new Timer(1500,1);//timer for dismissing emo message
		var finishMatch:Timer=new Timer(1000,1);//sets timer to end match
		var spawnTimer:Timer;

		var explosionTroop:ExplosionTroop;
		
		var eElixir:Number=2;//sets enemy elixir level
		var eLevel:Number=0;//set enemy level
		var eEmotion:int=0;//sets how rude the enemy's emotions are
		
		var winner:int=0;//shows who won the round
		
		var currentSec:int=2;//sets default time
		var currentMin:int=2;//sets default time
		
		var eCrown:int=0;//counters for crown #
		var pCrown:int=0;
			
		var elixirMult:int=1;//sets elixi multiplier level
		
		var badDrop:Sound;//adds sounds
		var endingChime:Sound;
		var overTimeChime:Sound;
		var minWarn:Sound;
		var attackSound:Sound;
		
		var happy:Sound;//sounds for emotions
		var sad:Sound;
		var angry:Sound;
		var goodGame:Sound;
		var goodLuck:Sound;
		var youSuck:Sound;
		
		var explosionSound:Sound;
		var ten:Sound;//sounds fo countdown
		var nine:Sound;
		var eight:Sound;
		var seven:Sound;
		var six:Sound;
		var five:Sound;
		var four:Sound;
		var three:Sound;
		var two:Sound;
		var one:Sound;
		
		var eName:String;//enemy's name
		public function Royale1() //CONSTRUCTOR public function function
		{
			
			goodGame=new GoodGame();//sound for emotions
			goodLuck=new GoodLuck();
			youSuck=new YouSuck();
			sad=new SadS();
			happy=new HappyS();
			angry=new AngryS();
			
			
			badDrop=new BadDrop();//sounds for countdown
			endingChime=new EndingChime();
			explosionSound=new ExplosionSound();
			overTimeChime=new OverTimeChime();
			minWarn=new MinWarn();
			one=new One();
			two=new Two();
			three=new Three();
			four=new Four()
			five=new Five();
			six=new Six();
			seven=new Seven();
			eight=new Eight();
			nine=new Nine();
			ten=new Ten();
			attackSound=new AttackSound();
	
			

			//***Resets all variables***'
			declareAll();//clears emotions
			clearEmotions();
			clearEnemyEmotions();
			selectedCard=-1;
			elixir=5;
			eElixir=5;
			currentSec=2;
			elixirMult=1;
			currentMin=2;
			eCrown=0;
			pCrown=0;
			winner=0;//0=no one 1=tie 2=player 3=enemy
			overTime=false;
			eNameBan.visible=true;
			pNameBan.visible=true;
			banner.visible=true;

			if(Math.random()>0.5){//Determines level of enemy
				eLevel=Math.round(pLvl+((Math.random()*2)));
			}
			else{
				eLevel=Math.round(pLvl-((Math.random()*2)));
			}
			if(eLevel<=0){
				eLevel=pLvl;
			}
			spawnRate=8000*(1/eLevel)
			spawnTimer=new Timer(spawnRate);
			//trace(spawnRate);
			//trace(eLevel);
/*
ID TABLE
Archer-		1
Bomber-		2
Knight-		3
Wizard-		4
Barbarian-	5
Necro-		6
Storm-		7
Palidan-	8
Andrew-		9
HENRY-		A
Health-		B
Rage-		C
Lightning-	D
GOD SPELL-	E
*/
			cardLoopArray=[];
			if(cardArray.indexOf(1)!=-1){
				cardLoopArray.push(archerCard);
				//trace("1");
			}
			if(cardArray.indexOf(2)!=-1){
				cardLoopArray.push(bomberCard);
				//trace("2");
			}
			if(cardArray.indexOf(3)!=-1){
				cardLoopArray.push(knightCard);
				//trace("3");
			}
			if(cardArray.indexOf(4)!=-1){
				cardLoopArray.push(wizardCard);
				//trace("4");
			}
			if(cardArray.indexOf(5)!=-1){
				cardLoopArray.push(barbarianCard);
				//trace("5");
			}
			if(cardArray.indexOf(6)!=-1){
				cardLoopArray.push(necroCard);
				//trace("6");
			}
			if(cardArray.indexOf(7)!=-1){
				cardLoopArray.push(stormCard);
				//trace("7");
			}
			if(cardArray.indexOf(8)!=-1){
				cardLoopArray.push(palidanCard);
				//trace("8");
			}
			if(cardArray.indexOf(9)!=-1){
				cardLoopArray.push(andrewCard);
				//trace("9");
			}
			if(cardArray.indexOf("A")!=-1){
				cardLoopArray.push(henryCard);
			}
			if(cardArray.indexOf("B")!=-1){
				cardLoopArray.push(healthCard);
			}
			if(cardArray.indexOf("C")!=-1){
				cardLoopArray.push(rageCard);
			}
			if(cardArray.indexOf("D")!=-1){
				cardLoopArray.push(lightningCard);
			}
			if(cardArray.indexOf("E")!=-1){
				cardLoopArray.push(godCard);
			}
			////trace(cardLoopArray.length);
			//Gives array values to enemy towers

			enemyHealth=[1000*eLevel,1000*eLevel,1500*eLevel];//sets health
			enemyOriginalHealth=[1000*eLevel,1000*eLevel,1500*eLevel];//sets original health
			enemyArray=[eTower2,eTower1,eKingTower];//adds towers
			enemyID=["CC","BB","AA"];//sets id
			ppvx=[0,0,0];
			ppvy=[0,0,0];
			for (var ll:int=0;ll<enemyArray.length;ll++){
				healthBarBack= new HealthBarBack();//defines bar
				healthBarEnemy= new HealthBarEnemy();
				healthBarEnemy.scaleX=0.25;//scales bar
				healthBarBack.scaleX=0.25;
				healthBarEnemy.scaleY=0.5;//scales bar
				healthBarBack.scaleY=0.5;
				upPlatform.addChild(healthBarBack);//adds bar to platform (invisible layer)
				upPlatform.addChild(healthBarEnemy);
				
				healthBarArray.push(healthBarBack);//pushes to array
				healthEnemyArray.push(healthBarEnemy);
			}
			/*
			enemyHealth.push(1000*eLevel);
			enemyOriginalHealth.push(1000*eLevel);
			enemyArray.push(eTower2);//adds towers
			enemyID.push("CC");
			addHealthBar();
			
			enemyHealth.push(1000*eLevel);
			enemyOriginalHealth.push(1000*eLevel);
			enemyArray.push(eTower1);//adds towers
			enemyID.push("BB");
			addHealthBar();
			
			enemyHealth.push(1500*eLevel);
			enemyOriginalHealth.push(1500*eLevel);
			enemyArray.push(eKingTower);//adds towers
			enemyID.push("AA");
			addHealthBar();			
			
			
			homeHealth.push(1000*pLvl);
			homeOriginalHealth.push(1000*pLvl);
			homeArray.push(pTower2);//adds towers
			homeID.push("CC");
			addHealthBarHome();
			
			homeHealth.push(1000*pLvl);
			homeOriginalHealth.push(1000*pLvl);
			homeArray.push(pTower1);//adds towers
			homeID.push("BB");
			addHealthBarHome();
			
			homeHealth.push(1500*pLvl);
			homeOriginalHealth.push(1500*pLvl);
			homeArray.push(pKingTower);//adds towers
			homeID.push("AA");
			addHealthBarHome();
			*/

			homeHealth=[1000*pLvl,1000*pLvl,1500*pLvl];//sets health
			homeOriginalHealth=[1000*pLvl,1000*pLvl,1500*pLvl];//sets original health
			homeArray=[pTower2,pTower1,pKingTower];//adds towers
			pvx=[0,0,0];
			pvy=[0,0,0];
			homeID=["CC","BB","AA"];//sets id
			for (var llm:int=0;llm<homeArray.length;llm++){
				healthBarHomeBack= new HealthBarBack();//defines bar
				healthBarHome= new HealthBarHome();
				healthBarHome.scaleX=0.25;//scales bar
				healthBarHomeBack.scaleX=0.25;
				healthBarHome.scaleY=0.5;//scales bar
				healthBarHomeBack.scaleY=0.5;
				upPlatform.addChild(healthBarHomeBack);//adds bar to platform (invisible layer)
				upPlatform.addChild(healthBarHome);
				
				healthBarHomeArray.push(healthBarHomeBack);//pushes to array
				healthHomeArray.push(healthBarHome);
			}


			//Determine the "Niceness" of the enemy
			eEmotion=Math.ceil(Math.random()*3);
			if(eEmotion>=4){
				eEmotion=3;
			}
			//trace("eEmotion"+eEmotion);//1-Friendly 2-Neutral 3-Rude
			////trace(eLevel);
			
			//GENERATES RANDOM NAMES FOR ENEMY
			//NAMES ARE LARGELY NOT CREATED BY HENRY OR ANDREW AND ARE FROM THE INTERNET
			//NOTE NAMES ARE TAKEN VARIOUS WEBSITE AND ARE NOT FULLY REVIEWED FOR "Strange" MATERIAL
			randomNameI=['BeyondGood&Evil', 'BioShock', 'Borderlands', 'Br\xfctalLegend', 'Chrono', 'DarkSouls', 'DeadSpace', 'DeusEx', 'Diablo', 'DragonAge', 'DragonQuestVIII', 'EarthBound', 'EVEOnline', 'EverQuest', 'Fable', 'Fallout', 'Fez', 'FinalFantasyVI', 'FreedomForce', 'GearsofWar', 'GodofWar', 'GrandTheftAuto', 'GrimFandango', 'Half-Life', 'Halo', 'JadeEmpire', 'Journey', "King'sQuest", 'KingdomsofAmalur', 'L.A.Noire', 'MassEffect', 'MegaMan', 'MetalGear', 'Metroid', 'MonkeyIsland', 'Oddworld', 'OutofThisWorld', 'Pok\xe9mon', 'Psychonauts', 'RedDeadRedemption', 'ResidentEvil', 'SecretofMana','AdamStrange', 'Aquaman', 'BarbaraGordon', 'BarryAllen', 'Batman', 'Beast', 'BlackCanary', 'BlackLightning', 'BlackPanther', 'BlackWidow', 'Blade', 'BlueBeetle', 'BoosterGold', 'BuckyBarnes', 'CaptainAmerica', 'CaptainBritain', 'CaptainMarvel', 'Catwoman', 'Cerebus', 'Cyclops', 'Daredevil', 'DashiellBadHorse', 'Deadpool', 'DickGrayson(Robin)', 'DonnaTroy', 'Dr.Strange', 'DreamoftheEndless', 'ElijahSnow', "EricO'Grady(Ant-Man)", 'FoneBone', 'Gambit', 'GhostRider', 'GreenArrow', 'Groo', 'HalJordan(GreenLantern)', 'HankPym(Ant-Man)', 'Hawkeye', 'Hawkman', 'Hellboy', 'HumanTorch', 'InvisibleWoman', 'IronFist', 'IronMan', 'JamesGordon', 'JeanGrey', 'JesseCuster', 'JohnConstantine', 'JohnStewart(GreenLantern)', 'JonahHex', 'JudgeDredd', 'Ka-Zar', 'KittyPryde','Machamp', 'Meganium', 'Metagross', 'Mew', 'Mewtwo', 'Milotic', 'Moltres', 'Nidoking', 'Ninetales', 'Onix', 'Palkia', 'Pidgeot', 'Pikachu', 'Quilava', 'Raichu', 'Raikou', 'Rapidash', 'Rayquaza', 'Reshiram', 'Rhydon', 'Salamence', 'Samurott', 'Sceptile', 'Scizor', 'Scyther', 'Serperior', 'Snorlax', 'Squirtle', 'Steelix', 'Suicune', 'Swampert', 'Torterra', 'Typhlosion', 'Tyranitar', 'Umbreon', 'Vaporeon', 'Venusaur', 'Wartortle', 'Zapdos', 'Zekrom', 'Zoroark',"Emma","Test","Olivia","Meep","Trump","Vladimir","Melon","Karl","Peter","Sophia","Zoe","Emily","Avery","Isabella","Charlotte","Lily","Ava","Liam","Jackson","Logan","Lucas","Noah","Ethan","Jack","William","Jacob","James","John","Robert","Michael","William","David","Richard","Shayla","Alex","Charles","Henry","Andrew","Joseph","Thomas","Jenna","Peter","SNC","Unicorns"];
			randomNameII=['ShadowoftheColossus', 'SilentHill', 'Starcraft', 'SuperMario', 'TheElderScrolls', 'Warcraft', 'Zelda','LukeCage', 'MartianManhunter', 'Marv', 'Michonne', 'MitchellHundred', 'MoonKnight', 'NickFury', 'Nightcrawler', 'Nova', 'ProfessorX', 'Punisher', 'Raphael', 'ReedRichards', 'ReneeMontoya', 'RickGrimes', 'Rorschach', 'SavageDragon', 'ScottPilgrim', 'Sgt.Rock', 'She-Hulk', 'SilverSurfer', 'Spawn', 'Spider-Man', 'SpiderJerusalem', 'Storm', 'Sub-Mariner', 'Superboy', 'Supergirl', 'Superman', 'SwampThing', 'TheAtom', 'TheCrow', 'TheFalcon', 'TheHulk', 'TheRocketeer', 'TheSpectre', 'TheSpirit', 'TheThing', 'TheTick', 'Thor', 'TimDrake(Robin)', 'UsagiYojimbo', 'WallyWest', 'Wasp', 'Wildcat', 'Wolverine', 'WonderWoman', 'YorickBrown','Absol', 'Aerodactyl', 'Aggron', 'Alakazam', 'Arcanine', 'Arceus', 'Articuno', 'Blastoise', 'Blaziken', 'Braviary', 'Bulbasaur', 'Celebi', 'Charizard', 'Charmander', 'Charmeleon', 'Cubone', 'Cyndaquil', 'Darkrai', 'Deoxys', 'Dialga', 'Dragonair', 'Dragonite', 'Electabuzz', 'Electivire', 'Empoleon', 'Entei', 'Espeon', 'Feraligatr', 'Flareon', 'Flygon', 'Gabite', 'Garchomp', 'Gastly', 'Gengar', 'Giratina', 'Glaceon', 'Groudon', 'Growlithe', 'Gyarados', 'Haunter', 'Haxorus', 'Hitmonlee', 'Ho-Oh', 'Houndoom', 'Hydreigon', 'Infernape', 'Ivysaur', 'Jolteon', 'Kabutops', 'Kadabra', 'Kingdra', 'Kyogre', 'Kyurem', 'Lapras', 'Latias', 'Latios', 'Lucario', 'Lugia', 'Luxray',"PotatoeHead","Man","Human","Watermelon","Tomatoe","Banana","isAwesome","Clash","Illuminauti","Potato","Obama","17$awesome","iscool","likesRice","ninja","tacobell","#YOLO","mewp","cow","troll","PUTIN","pudding=yum","Computer","CATS","puppy","Pythagorean","TrigFTW","MLG","DUZZZZI","Hadded","BAGGS","water","Ulch","1DN","AreFluffy"];
			eName=(randomNameI[Math.round(Math.random()*(randomNameI.length-1))]+randomNameII[Math.round(Math.random()*(randomNameII.length-1))]+Math.round(Math.random()*100));//compile name from random numbers and arrays
			enemyName.text=eName;//sets all the text fields			
			eNameBan.text=eName;
			pNameBan.text=pName;
			playerName.text=pName;//sets namefield
			

			
			//***Warnings***
			//Makes all warnings invisible
			minWarnText.visible=false;
			overTimeText.visible=false;
			countDown.visible=false;
			matchFinished.visible=false;
			eCrownBanner.visible=false;//makes name banners invisible
			pCrownBanner.visible=false;
			overtimeWarning.visible=false;//makes overtime warning invisible
			
			//***Timers***
			emotionMenu.addEventListener(MouseEvent.CLICK,onClickAway);//event listener if player clicks away
			emoTimer.addEventListener(TimerEvent.TIMER,onEmoTimer);
			timer.start();//starts timer
			timerText.text="1:59";//sets defualt time
			enemyBubbleTimer.addEventListener(TimerEvent.TIMER,onEnemyBubble);//timer for dismissing response
			enemyEmoTimer.addEventListener(TimerEvent.TIMER,getEnemyEmotions);//timer for enemy response
			timer.addEventListener(TimerEvent.TIMER,onTime);//add eventlistener for stopwatch
			finishMatch.addEventListener(TimerEvent.TIMER,onMatchFinish);//adds event listener to end match
			spawnTimer.addEventListener(TimerEvent.TIMER,onSpawnTimer);
			spawnTimer.reset();
			spawnTimer.start();
			
			//Buttons
			spawnArea.addEventListener(MouseEvent.CLICK,onSpawn);//spawn area detector
			invalidArea.addEventListener(MouseEvent.CLICK,onInvalid);//invalid area detector
			btnSurrender.addEventListener(MouseEvent.CLICK,onSur);//surrender button
			stage.addEventListener(Event.ENTER_FRAME,gameLoop);//add event listener for gameloop
			
			archerCard.addEventListener(MouseEvent.CLICK,onArcher);
			bomberCard.addEventListener(MouseEvent.CLICK,onBomber);
			knightCard.addEventListener(MouseEvent.CLICK,onKnight);
			wizardCard.addEventListener(MouseEvent.CLICK,onWizard);
			barbarianCard.addEventListener(MouseEvent.CLICK,onBarbarian);
			necroCard.addEventListener(MouseEvent.CLICK,onNecro);
			stormCard.addEventListener(MouseEvent.CLICK,onStorm);
			palidanCard.addEventListener(MouseEvent.CLICK,onPalidan);
			andrewCard.addEventListener(MouseEvent.CLICK,onAndrew);
			henryCard.addEventListener(MouseEvent.CLICK,onHenry);
			healthCard.addEventListener(MouseEvent.CLICK,onHealth);
			rageCard.addEventListener(MouseEvent.CLICK,onRage);
			lightningCard.addEventListener(MouseEvent.CLICK,onLightning);
			godCard.addEventListener(MouseEvent.CLICK,onGod);
		} //end public function introProgram
		
		//Function to spawn troops for enemy
		public function onSpawnTimer(e:TimerEvent){
			//generates a randomnumber
			var randomNumberSpawn:Number=Math.random();
			//sets a variable for next phase
			var randomNumber:int;
			//Checks what troop type is selected
			//Continue downwards
			if(randomNumberSpawn>0.8){
				randomNumber=Math.ceil(Math.random()*50);//generates number for seconds stage
				if(randomNumber==1){//checks number
					/*
Archer-		1
Bomber-		2
Knight-		3
Wizard-		4
Barbarian-	5
Necro-		6
Storm-		7
Palidan-	8
Andrew-		9
HENRY-		A
Health-		B
Rage-		C
Lightning-	D
GOD SPELL-	E
*/
					if(eElixir>9 && cardUnlocked[10]!=0){//checks if there is enough elixir
						henry=new Henry();//creates new instance
						henry.x=80+Math.random()*200;//generates location
						henry.y=100+Math.random()*350;
						platform.addChild(henry);//adds troop to platform
						enemyArray.push(henry);//puses to array
						enemyID.push("A");//assigns the troop's ID
						pvx.push(0);//gives troop  unique pvx and pvy
						pvy.push(0);//to track enemy
						enemyOriginalHealth.push(5000*(1+(cardUnlocked["A"]/10)));//sets health bars
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=9;//deducts elixir
						addHealthBar();//function to generate bar
					}
				}
				else if(randomNumber>1 && randomNumber<25){
					if(eElixir>9 && cardUnlocked[9]!=0){
						andrew=new Andrew();
						andrew.x=80+Math.random()*200;
						andrew.y=40+80+Math.random()*200;
						platform.addChild(andrew);
						enemyArray.push(andrew);
						enemyID.push(9);
						pvx.push(0);
						pvy.push(0);
						enemyOriginalHealth.push(2000*(1+(cardUnlocked[9]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=9;
						addHealthBar();
					}
				}
				else if(randomNumber>24){
					if(eElixir>6  && cardUnlocked[8]!=0){
						palidan=new Palidan();
						palidan.x=80+Math.random()*200;
						palidan.y=100+Math.random()*350;
						platform.addChild(palidan);
						enemyArray.push(palidan);
						enemyID.push(8);
						pvx.push(0);
						pvy.push(0);
						enemyOriginalHealth.push(1500*(1+(cardUnlocked[8]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						addHealthBar();
						eElixir-=6;
					}
				}
			}
			else if(randomNumberSpawn>0.5){
				randomNumber=Math.ceil(Math.random()*3);
				if(randomNumber==3){
					if(eElixir>5  && cardUnlocked[5]!=0){
						barbarian=new Barbarian();
						barbarian.x=80+Math.random()*200;
						barbarian.y=100+Math.random()*350;
						platform.addChild(barbarian);
						enemyArray.push(barbarian);
						enemyID.push(5);
						pvx.push(0);
						pvy.push(0);						
						enemyOriginalHealth.push(400*(1+(cardUnlocked[5]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);					
						addHealthBar();
						eElixir-=5;
					}
				}
				else if(randomNumber==2){
					if(eElixir>3  && cardUnlocked[1]!=0){
						archer=new Archer();
						archer.x=80+Math.random()*200;
						archer.y=100+Math.random()*350;
						platform.addChild(archer);
						enemyArray.push(archer);
						enemyID.push(1);
						pvx.push(0);
						pvy.push(0);
						enemyOriginalHealth.push(150*(1+(cardUnlocked[1]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=3;
						addHealthBar();
					}
				}
	
				else if(randomNumber==3){
					if(eElixir>5  && cardUnlocked[7]!=0){
						storm=new Storm();
						storm.x=80+Math.random()*200;
						storm.y=100+Math.random()*350;
						platform.addChild(storm);
						enemyArray.push(storm);
						enemyID.push(7);
						pvx.push(0);
						pvy.push(0);
						enemyOriginalHealth.push(3000*(1+(cardUnlocked[7]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=5;
						addHealthBar();
					}
							
				}
			}
			else{
				randomNumber=Math.ceil(Math.random()*4);
				if(randomNumber==4){
					if(eElixir>3  && cardUnlocked[2]!=0){
						bomber=new Bomber();
						bomber.x=80+Math.random()*200;
						bomber.y=100+Math.random()*350;
						platform.addChild(bomber);
						enemyArray.push(bomber);
						enemyID.push(2);
						pvx.push(0);
						pvy.push(0);
						enemyOriginalHealth.push(200*(1+(cardUnlocked[2]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=3;
						addHealthBar();
					}
				}
				else if(randomNumber==3){
					if(eElixir>3  && cardUnlocked[3]!=0){
						knight=new Knight();
						knight.x=80+Math.random()*200;
						knight.y=100+Math.random()*350;
						platform.addChild(knight);
						enemyArray.push(knight);
						enemyID.push(3);
						pvx.push(0);
						pvy.push(0);
						enemyOriginalHealth.push(500*(1+(cardUnlocked[3]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=3;
						addHealthBar();
					}
				}
				else if(randomNumber==2){
					if(eElixir>4  && cardUnlocked[4]!=0){
						wizard=new Wizard();
						wizard.x=80+Math.random()*200;
						wizard.y=100+Math.random()*350;
						platform.addChild(wizard);
						enemyArray.push(wizard);
						enemyID.push(4);
						pvx.push(0);
						pvy.push(0);
						enemyOriginalHealth.push(400*(1+(cardUnlocked[4]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=4;
						addHealthBar();
					}
				}
				else if(randomNumber==1){
					if(eElixir>5  && cardUnlocked[6]!=0){
						necro=new Necro();
						necro.x=80+Math.random()*200;
						necro.y=100+Math.random()*350;
						platform.addChild(necro);
						enemyArray.push(necro);
						enemyID.push(6);
						pvx.push(0);
						pvy.push(0);
						addHealthBar();
						enemyOriginalHealth.push(700*(1+(cardUnlocked[6]/10)));
						enemyHealth.push(enemyOriginalHealth[enemyOriginalHealth.length-1]);
						eElixir-=5;
					}
				}
			}
		}
		
		//Function to generate healthbar for each troop (Enemy)
		function addHealthBar(){
			healthBarBack= new HealthBarBack();//defines bar
			healthBarEnemy= new HealthBarEnemy();
			
			healthBarEnemy.scaleX=0.25;//scales bar
			healthBarBack.scaleX=0.25;
			healthBarEnemy.scaleY=0.5;//scales bar
			healthBarBack.scaleY=0.5;
			
			upPlatform.addChild(healthBarBack);//adds bar to platform (invisible layer)
			upPlatform.addChild(healthBarEnemy);
			
			healthBarArray.push(healthBarBack);//pushes to array
			healthEnemyArray.push(healthBarEnemy);			
		}
		
		//Same function as above but made for home troops
		function addHealthBarHome(){
			healthBarHomeBack= new HealthBarBack();//defines bar
			healthBarHome= new HealthBarHome();
			
			healthBarHome.scaleX=0.25;//scales bar
			healthBarHomeBack.scaleX=0.25;
			healthBarHome.scaleY=0.5;//scales bar
			healthBarHomeBack.scaleY=0.5;
			upPlatform.addChild(healthBarHomeBack);//adds bar to platform (invisible layer)
			upPlatform.addChild(healthBarHome);
			
			healthBarHomeArray.push(healthBarHomeBack);//pushes to array
			healthHomeArray.push(healthBarHome);
		}
		public function declareAll(){//declares all buttons
			btnHappy.addEventListener(MouseEvent.CLICK,onHappy);
			btnAngry.addEventListener(MouseEvent.CLICK,onAngry);
			btnSad.addEventListener(MouseEvent.CLICK,onSad);
			btnGG.addEventListener(MouseEvent.CLICK,onGG);
			btnLuck.addEventListener(MouseEvent.CLICK,onLuck);
			btnSuck.addEventListener(MouseEvent.CLICK,onSuck);
			btnEmo.addEventListener(MouseEvent.CLICK,onEmo);
		}
		public function onEmo(e:MouseEvent){//event listener for emo button
			getEmotions();//Brings up menu
		}


		//public function to dismiss message
		public function onEmoTimer(e:TimerEvent){
			clearEmotions();
			btnEmo.alpha=1;
			btnEmo.addEventListener(MouseEvent.CLICK,onEmo);
		}

		//public function to clear enemy emotoins
		public function clearEnemyEmotions(){
			if(currentFrame>3 && currentFrame<9){
				enemyEmoText.text="";
				enemyEmoText.visible=false;
				eSpeechBubble.visible=false;
				eAngryEmo.visible=false;
				eHappyEmo.visible=false;
				eSadEmo.visible=false;
			}
		}

		//public function to clear emotions
		public function clearEmotions(){
			angryEmo.visible=false;
			happyEmo.visible=false;
			sadEmo.visible=false;
			speechText.visible=false;
			speechBubble.visible=false;
			emotionMenu.visible=false;
			btnSuck.visible=false;
			btnLuck.visible=false;
			btnGG.visible=false;
			btnSad.visible=false;
			btnAngry.visible=false;
			btnHappy.visible=false;
		}

		//fuction  to get emotion menu
		public function getEmotions(){
			emotionMenu.visible=true;
			btnSuck.visible=true;
			btnLuck.visible=true;
			btnGG.visible=true;
			btnSad.visible=true;
			btnAngry.visible=true;
			btnHappy.visible=true;	
		}

		//Function to close emotion menu
		public function onClickAway(e:MouseEvent){
			clearEmotions();//closes menu
		}

		//public function for emotion button
		//REPEATED DOWNWARDS
		public function onSuck(e:MouseEvent){
			currentEmotion=1;//sets current emotion
			enemyEmoTimer.start();//starts timer to dismiss
			youSuck.play();//plays sound
			clearEmotions();//clears all current emotions
			speechText.visible=true;//makes bubble appear
			speechBubble.visible=true;
			speechText.text="You Suck :(";//sets message
			
			btnEmo.alpha=0.5;//disables button
			btnEmo.removeEventListener(MouseEvent.CLICK,onEmo);
			emoTimer.start();//starts timer to dismiss
		}

		public function onLuck(e:MouseEvent){
			currentEmotion=2;
			enemyEmoTimer.start();
			goodLuck.play();
			clearEmotions();
			speechText.visible=true;
			speechBubble.visible=true;
			speechText.text="Good Luck!";
			btnEmo.alpha=0.5;
			btnEmo.removeEventListener(MouseEvent.CLICK,onEmo);	
			emoTimer.start();
		}

		public function onGG(e:MouseEvent){
			currentEmotion=3;
			enemyEmoTimer.start();
			goodGame.play();
			clearEmotions();
			speechText.visible=true;
			speechBubble.visible=true;
			speechText.text="Good Game!";
			btnEmo.alpha=0.5;
			btnEmo.removeEventListener(MouseEvent.CLICK,onEmo);	
			emoTimer.start();
		}

		public function onSad(e:MouseEvent){
			currentEmotion=4;
			enemyEmoTimer.start();
			sad.play();
			clearEmotions();
			speechBubble.visible=true;
			btnEmo.alpha=0.5;
			btnEmo.removeEventListener(MouseEvent.CLICK,onEmo);	
			emoTimer.start();
			sadEmo.visible=true;
		}

		public function onAngry(e:MouseEvent){
			currentEmotion=5;
			enemyEmoTimer.start();
			angry.play();
			clearEmotions();
			speechBubble.visible=true;
			btnEmo.alpha=0.5;
			btnEmo.removeEventListener(MouseEvent.CLICK,onEmo);	
			emoTimer.start();
			angryEmo.visible=true;
		}

		public function onHappy(e:MouseEvent){
			currentEmotion=6;
			enemyEmoTimer.start();
			happy.play();
			clearEmotions();
			speechBubble.visible=true;
			btnEmo.alpha=0.5;
			btnEmo.removeEventListener(MouseEvent.CLICK,onEmo);	
			emoTimer.start();
			happyEmo.visible=true;
		}		
		//function for surrendering attack
		function onSur(Event:MouseEvent){
			winner=3;//sets winner to enemy
			eCrown=3;//gives enemy 3 starts
			end();//ends game
		}
		
		
		//function for spawning troop
		function onSpawn(e:MouseEvent){
			//REPEATED DOWNWARDS
			if(cardLoopArray[selectedCard]==godCard){//Checks waht card is selected
				if(elixir<5){//checks if there is enough elixir
					badDrop.play();//if not play sound
					errorMessage.visible=true;//calls for message
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{//if there is sufficient elizir
					
					selectedCard=-1;//resets card selected
					
					god=new God();//creates new instance
					god.x=mouseX;
					god.y=mouseY;
					platform.addChild(god);//summons troop
					homeSpellArray.push(god);
					addHealthBarHome();
					elixir-=5;//removes elixir
				}
			}
			else if(cardLoopArray[selectedCard]==lightningCard){
				if(elixir<4){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					lightning=new Lightning();
					lightning.x=mouseX;
					lightning.y=mouseY;
					platform.addChild(lightning);
					homeSpellArray.push(lightning);
					addHealthBarHome();
					elixir-=4;
				}
			}
			else if(cardLoopArray[selectedCard]==rageCard){
				if(elixir<3){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
					}
				else{
					
					
					selectedCard=-1;
					
					rage=new Rage();
					rage.x=mouseX;
					rage.y=mouseY;
					platform.addChild(rage);
					homeSpellArray.push(rage);
					addHealthBarHome();
					elixir-=3;
				}
			}
			else if(cardLoopArray[selectedCard]==healthCard){
				if(elixir<3){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					health=new Health();
					health.x=mouseX;
					health.y=mouseY;
					platform.addChild(health);
					homeSpellArray.push(health);
					addHealthBarHome();
					elixir-=3;
				}
			}
			else if(cardLoopArray[selectedCard]==henryCard){
				if(elixir<9){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					henry=new Henry();
					henry.x=mouseX;
					henry.y=mouseY;
					platform.addChild(henry);
					homeArray.push(henry);
					homeID.push("A");
					homeOriginalHealth.push(5000*(1+(cardUnlocked["A"]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					addHealthBarHome();
					elixir-=9;
					
				}
			}
			else if(cardLoopArray[selectedCard]==andrewCard){
				if(elixir<9){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					andrew=new Andrew();
					andrew.x=mouseX;
					andrew.y=mouseY;
					platform.addChild(andrew);
					homeArray.push(andrew);
					homeID.push(9);
					homeOriginalHealth.push(2000*(1+(cardUnlocked[9]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					elixir-=9;
					addHealthBarHome();
				}
			}
			else if(cardLoopArray[selectedCard]==archerCard){
				if(elixir<3){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					archer=new Archer();
					archer.x=mouseX;
					archer.y=mouseY;
					platform.addChild(archer);
					homeArray.push(archer);
					homeID.push(1);
					homeOriginalHealth.push(150*(1+(cardUnlocked[1]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					elixir-=3;
					addHealthBarHome();
				}
			}
			else if(cardLoopArray[selectedCard]==bomberCard){
				if(elixir<3){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					bomber=new Bomber();
					bomber.x=mouseX;
					bomber.y=mouseY;
					platform.addChild(bomber);
					homeArray.push(bomber);
					homeID.push(2);
					homeOriginalHealth.push(200*(1+(cardUnlocked[2]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					elixir-=3;
					addHealthBarHome();
				}
			}
			else if(cardLoopArray[selectedCard]==knightCard){
				if(elixir<3){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					knight=new Knight();
					knight.x=mouseX;
					knight.y=mouseY;
					platform.addChild(knight);
					homeArray.push(knight);
					homeID.push(3);
					homeOriginalHealth.push(500*(1+(cardUnlocked[3]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					elixir-=3;
					addHealthBarHome();
				}
			}
			else if(cardLoopArray[selectedCard]==wizardCard){
				if(elixir<4){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					wizard=new Wizard();
					wizard.x=mouseX;
					wizard.y=mouseY;
					platform.addChild(wizard);
					homeArray.push(wizard);
					homeID.push(4);
					homeOriginalHealth.push(400*(1+(cardUnlocked[4]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					elixir-=4;
					addHealthBarHome();
				}
			}
			else if(cardLoopArray[selectedCard]==necroCard){
				if(elixir<5){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					necro=new Necro();
					necro.x=mouseX;
					necro.y=mouseY;
					platform.addChild(necro);
					homeArray.push(necro);
					homeID.push(6);
					addHealthBarHome();
					homeOriginalHealth.push(700*(1+(cardUnlocked[6]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					elixir-=5;
				}
			}
			else if(cardLoopArray[selectedCard]==barbarianCard){
				if(elixir<5){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					barbarian=new Barbarian();
					barbarian.x=mouseX;
					barbarian.y=mouseY;
					platform.addChild(barbarian);
					homeArray.push(barbarian);
					homeID.push(5);
					
					homeOriginalHealth.push(400*(1+(cardUnlocked[5]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);					
					addHealthBarHome();
					elixir-=5;
				}
			}
			else if(cardLoopArray[selectedCard]==palidanCard){
				if(elixir<6){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					palidan=new Palidan();
					palidan.x=mouseX;
					palidan.y=mouseY;
					platform.addChild(palidan);
					homeArray.push(palidan);
					homeID.push(8);
					
					homeOriginalHealth.push(1500*(1+(cardUnlocked[8]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					addHealthBarHome();
					elixir-=6;
				}
			}
			else if(cardLoopArray[selectedCard]==stormCard){
				if(elixir<5){
					badDrop.play();
					errorMessage.visible=true;
					errorMessage.text="Not enough elixir!";
					errorDismiss.start();
				}
				else{
					
					
					selectedCard=-1;
					
					storm=new Storm();
					storm.x=mouseX;
					storm.y=mouseY;
					platform.addChild(storm);
					homeArray.push(storm);
					homeID.push(7);
					homeOriginalHealth.push(3000*(1+(cardUnlocked[7]/10)));
					homeHealth.push(homeOriginalHealth[homeOriginalHealth.length-1]);
					elixir-=5;
					addHealthBarHome();
				}
			}
			else{
				badDrop.play();
				errorMessage.visible=true;
				errorMessage.text="No card selected!";
				errorDismiss.start();
			}
			
		}
		
		//function for dismissing enemy response
		function onEnemyBubble(e:TimerEvent){
			clearEnemyEmotions();//clears enemy response
		}
		
		//function for generating enemy reaction
		function getEnemyEmotions(e:TimerEvent){
			var randomNum:Number=Math.random();//makes random number
			enemyBubbleTimer.start();//starts timer to dismiss message
			eSpeechBubble.visible=true;//makes speech bubble visible
			enemyEmoText.visible=true;//makes text box visible
			
			//REPEATED DOWN
			if(eEmotion==1){//checks type of enemy emotion level
				if(randomNum<0.25){//generates random number
					goodGame.play();//plays sound
				}
				else if(randomNum<0.5){
					goodLuck.play();
				}
				else{
					happy.play();
				}
				
				if(currentEmotion==1){//checks emotion set by player
					if(Math.random()>0.5){//generates random number
						//trace("d:)d");//response-REPEAT DOWNWARDS
						eHappyEmo.visible=true;
					}
					else{
						//trace(":D");
						enemyEmoText.text=":D";
					}
				}
				else if(currentEmotion==2){
					if(Math.random()>0.5){
						//trace("Thanks");	
						enemyEmoText.text="Thanks!";
					}
					else{
						//trace("GLHV");
						enemyEmoText.text="Good Luck, Have fun!";
					}
				}
				else if(currentEmotion==3){
					if(Math.random()>0.5){
						//trace(":)");
						enemyEmoText.text=":)";
					}
					else{
						//trace("Good Job");
						enemyEmoText.text="Good Job";
					}					
				}
				else if(currentEmotion==4){
					if(Math.random()>0.5){
						//trace("Good Game!");
						enemyEmoText.text="Good Game!";
					}
					else{
						//trace("Well Played");
						enemyEmoText.text="Well Played";
					}
				}
				else if(currentEmotion==5){
					if(Math.random()>0.5){
						//trace("Good Game!");
						enemyEmoText.text="Good game!";
					}
					else{
						//trace("Nice Try");
						enemyEmoText.text="Nice Try";
					}
				}
				else if(currentEmotion==6){
					if(Math.random()>0.5){
						//trace("d:)d");	
						eHappyEmo.visible=true;
					}
					else{
						//trace("Well Played!");
						enemyEmoText.text="Well Played!";
					}
				}
			}
			else if(eEmotion==2){
				if(randomNum<0.25){
					youSuck.play();
				}
				else if(randomNum<0.5){
					sad.play();
				}
				else{
					angry.play();
				}
				if(currentEmotion==1){
					if(Math.random()>0.5){
						//trace("T~T");
						enemyEmoText.text="T~T";
					}
					else{
						//trace("x_x");
						enemyEmoText.text="X_x";
					}
				}
				else if(currentEmotion==2){
					if(Math.random()>0.5){
						//trace("Meh");		
						enemyEmoText.text="Meh";
					}
					else{
						//trace("Is that all you've got?");
						enemyEmoText.text="Seriously?";
					}
				}
				else if(currentEmotion==3){
					if(Math.random()>0.5){
						//trace("Clap, Clap T~T");
						enemyEmoText.text="Clap, clap T~T";
					}
					else{
						//trace("How amusing....");
						enemyEmoText.text="How amusing...";
					}
				}
				else if(currentEmotion==4){
					if(Math.random()>0.5){
						//trace("*gasp*");
						enemyEmoText.text="*gasp*";
					}
					else{
						//trace("This is entertaining");
						enemyEmoText.text="This is entertaining";
					}
				}
				else if(currentEmotion==5){
					if(Math.random()>0.5){
						//trace("Yawn");
						enemyEmoText.text="Yawn";
					}
					else{
						//trace("Really?");
						enemyEmoText.text="Really?";
					}
				}
				else if(currentEmotion==6){
					if(Math.random()>0.5){
						//trace("d:)d");	
						eHappyEmo.visible=true;
					}
					else{
						//trace("Lul, newb");
						enemyEmoText.text="Lul, newb";
					}
				}				
			}
			else if(eEmotion==3){
				if(randomNum<0.25){
					goodGame.play();
				}
				else if(randomNum<0.5){
					goodLuck.play();
				}
				else{
					happy.play();
				}
				if(currentEmotion==1){
					if(Math.random()>0.5){
						//trace(">:)");
						enemyEmoText.text=">:)";
					}
					else{
						//trace("Lel");
						enemyEmoText.text="Lel";
					}
				}
				else if(currentEmotion==2){
					if(Math.random()>0.5){
						//trace("*cries*");	
						eSadEmo.visible=true;
					}
					else{
						//trace("How unfortunate >:)");
						enemyEmoText.text="How unfortunate >:)";
					}
				}
				else if(currentEmotion==3){
					if(Math.random()>0.5){
						//trace("You Suck");		
						enemyEmoText.text="You Suck >:)";
					}
					else{
						//trace("This is amusing");
						enemyEmoText.text="This is amusing";
					}
				}
				else if(currentEmotion==4){
					if(Math.random()>0.5){
						//trace("*cries*");
						eSadEmo.visible=true;
					}
					else{
						//trace("sigh..");
						eHappyEmo.visible=true;
					}
				}
				else if(currentEmotion==5){
					if(Math.random()>0.5){
						//trace(":D");
						enemyEmoText.text=":D";
					}
					else{
						//trace("Thanks! :P");
						enemyEmoText.text="Thanks :P";
					}
				}
				else if(currentEmotion==6){
					if(Math.random()>0.5){
						//trace("*cries*");
						eSadEmo.visible=true;
					}
					else{
						enemyEmoText.text="Interesting Human...";
						//trace("o-O");
					}
				}				
			}
		}
		
		
		//function for when invalid spot is clicked
		function onInvalid(e:MouseEvent){
			badDrop.play();//plays sound effect
			errorMessage.visible=true;
			errorMessage.text="Invalid selection";
			errorDismiss.start();
		}
		
		//function to terminate game
		function end(){
			spawnTimer.reset();
			spawnTimer.stop();
			matchFinished.visible=true;//makes match finish message appear
			//REPEATED DOWN
			for(var nn:int=0;nn<homeArray.length;nn++){//Gets length of home Array
				explosionTroop=new ExplosionTroop();//New instance of explosion
				explosionTroop.x=homeArray[nn].x;//sets location
				explosionTroop.y=homeArray[nn].y;
				explosionTroop.scaleX=0.25;//scale
				explosionTroop.scaleY=0.25;
				platform.addChild(explosionTroop);//add chile
			}
			for(var n:int=0;n<enemyArray.length;n++){
				explosionTroop=new ExplosionTroop();
				explosionTroop.x=enemyArray[n].x;
				explosionTroop.y=enemyArray[n].y;
				explosionTroop.scaleX=0.25;
				explosionTroop.scaleY=0.25;
				platform.addChild(explosionTroop);
			}
			
			//REPEAT DOWN
			//If enemy still exist
			while(healthEnemyArray[0]!=null && healthEnemyArray.length>0){
				
					//Remove health bar
					healthBarArray[0].parent.removeChild(healthBarArray[0]);
					healthBarArray.splice(0,1);
					healthEnemyArray[0].parent.removeChild(healthEnemyArray[0]);
					healthEnemyArray.splice(0,1);
					
					//Remove properties
					enemyHealth.splice(0,1);
					enemyOriginalHealth.splice(0,1);
					enemyID.splice(0,1);
					ppvx.splice(0,1);
					ppvy.splice(0,1);
				
					//Remove enemy
					enemyArray[0].parent.removeChild(enemyArray[0]);
					enemyArray.splice(0,1);
				
			}
			while(healthHomeArray[0]!=null && healthHomeArray.length>0){
				
					healthBarHomeArray[0].parent.removeChild(healthBarHomeArray[0]);
					healthBarHomeArray.splice(0,1);
					healthHomeArray[0].parent.removeChild(healthHomeArray[0]);
					healthHomeArray.splice(0,1);
					homeHealth.splice(0,1);
					homeOriginalHealth.splice(0,1);
					homeID.splice(0,1);
					pvx.splice(0,1);
					pvy.splice(0,1);
					homeArray[0].parent.removeChild(homeArray[0]);
					homeArray.splice(0,1);
			}
			
			//Stop timers
			enemyEmoTimer.stop();//stops emotion timers
			enemyBubbleTimer.stop();
			emoTimer.stop();		


			stage.removeEventListener(Event.ENTER_FRAME,gameLoop);//removes event listener for gameloop
			
			endingChime.play();//plays ending chime
			timer.stop();//stops timer
			timer.reset();//resets timer

			finishMatch.start();//sets timer to end match
		}
		
		//function when ending delay is over
		public function onMatchFinish(e:TimerEvent){
			clearEmotions();//clears emotions
			clearEnemyEmotions();
			gotoAndStop(9);//goto game over screen
		}
		
		//function for stopwatch
		public function onTime(e:TimerEvent){//function for stopwatch

			currentSec--;//removes a second from the clock
			
			//minute warning
			if(currentSec==0 && currentMin==1){//checks if timer reached 1 minute
				minWarn.play();//plays minute warning
				elixirMult=2;//sets elixir multiplier
				minWarnText.visible=true;//makes warning text true
			}
			else if(currentSec==57 && currentMin==0){//dismisses minute warning
				minWarnText.visible=false;
			}
			
			if(currentSec==57 && currentMin==0 && overTime==true){
				overTimeText.visible=false;
			}
			
			
			//Dismisses name badges when match officially starts
			if(currentSec==0 && currentMin==2 && banner.visible==true){
				eNameBan.visible=false;
				pNameBan.visible=false;
				banner.visible=false;
			}
			
			//starts countdown
			if(currentSec==10 && currentMin==0){
				countDown.visible=true;
				countDown.gotoAndStop(1);
			}
			else if(currentSec==9 && currentMin==0){
				countDown.gotoAndStop(2);
			}
			else if(currentSec==8 && currentMin==0){
				countDown.gotoAndStop(3);
			}
			else if(currentSec==7 && currentMin==0){
				countDown.gotoAndStop(4);
			}
			else if(currentSec==6 && currentMin==0){
				countDown.gotoAndStop(5);
			}
			else if(currentSec==5 && currentMin==0){
				countDown.gotoAndStop(6);
			}
			else if(currentSec==4 && currentMin==0){
				countDown.gotoAndStop(7);
			}
			else if(currentSec==3 && currentMin==0){
				countDown.gotoAndStop(8);
			}
			else if(currentSec==2 && currentMin==0){
				countDown.gotoAndStop(9);
			}
			else if(currentSec==1 && currentMin==0){
				countDown.gotoAndStop(10);
			}
			else{
				countDown.visible=false;
			}
			
			//plays countown sound
			if(currentSec==10 && currentMin==0){
				ten.play();
			}
			else if(currentSec==9 && currentMin==0){
				nine.play();
			}
			else if(currentSec==8 && currentMin==0){
				eight.play();
			}
			else if(currentSec==7 && currentMin==0){
				seven.play();
			}
			else if(currentSec==6 && currentMin==0){
				six.play();
			}
			else if(currentSec==5 && currentMin==0){
				five.play();
			}
			else if(currentSec==4 && currentMin==0){
				four.play();
			}
			else if(currentSec==3 && currentMin==0){
				three.play();
			}
			else if(currentSec==2 && currentMin==0){
				two.play();
			}
			else if(currentSec==1 && currentMin==0){
				one.play();
			}
			if(currentSec==0 && currentMin==0){//check if timer reachs 0
				////trace("Timer end");
				if(overTime!=true){//if not in overtime when timer ends
					if(eCrown==pCrown){//checks for tie
						timerText.text="1:00"//resets timer
						currentSec=0;//resets timer
						currentMin=1;
						overTime=true;//flags overtime
						overTimeChime.play();//plays ovetime chime
						overtimeWarning.visible=true;//sets warning
						overTimeText.visible=true;//sets text
					}
					else{
						if(eCrown>pCrown){//checks jf enemy wins
							////trace("eWins");
							winner=3;//sets winner to enemy
						}
						else if(pCrown>eCrown){//checks if player wins
							////trace("pWins");
							winner=2;//sets winner to player
						}
						end();//ends game
					}
				}
				else{//if tie when ovetime ends
					winner=1;//sets winner to no one
					end();//ends game
				}
			}
			if(currentSec==0 && currentMin!=0){//checks if timer second reaches 0
				currentMin--;//deducts a minute
				currentSec=59;//resets seconds
			}
		}
/*
Archer-		1
Bomber-		2
Knight-		3
Wizard-		4
Barbarian-	5
Necro-		6
Storm-		7
Palidan-	8
Andrew-		9
HENRY-		A
Health-		B
Rage-		C
Lightning-	D
GOD SPELL-	E
*/
		//Function for each card selected
		//CONTINUE DOWN
		public function onArcher(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(archerCard);//Sets current card to index of card selected
		}
		public function onBomber(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(bomberCard);
		}
		public function onKnight(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(knightCard);
		}
		public function onWizard(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(wizardCard);
		}
		public function onBarbarian(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(barbarianCard);
		}
		public function onNecro(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(necroCard);
		}
		public function onStorm(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(stormCard);
		}
		public function onPalidan(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(palidanCard);
		}
		public function onAndrew(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(andrewCard);
		}
		public function onHenry(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(henryCard);
		}
		public function onHealth(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(healthCard);
		}
		public function onRage(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(rageCard);
		}
		public function onLightning(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(lightningCard);
		}
		public function onGod(e:MouseEvent){
			selectedCard=cardLoopArray.indexOf(godCard);
		}
		
		
		//Gameloop
		public function gameLoop(e:Event){
			//trace(homeID);
			if(currentFrame==4 || currentFrame==6 || currentFrame==8){//checks if in frame with water
				water.y+=0.5;	//moves water
			}
			else if(currentFrame==7){//checks if in frame with lava
				lava.y+=0.25;//moves lava
			}

			if(eCrown==3){//checks if enemy has reached 3 crowns
				winner=3;//sets winner as enemy
				end();//temrinates game
			}
			else if(pCrown==3){//check if player has reached 3 crowns
				winner=2;//sets winner as player
				end();//ends game
			}
			
			if(overTime==true){//checks if overtime is true and if any crown is increased
				//////trace("Overtime");
				if(eCrown>pCrown){//checks if enemyCrown is more than pkayer corwn
					winner=3;//sets winner
					////trace("enemy win");
					end();//ends game
				}
				else if(pCrown>eCrown){
					winner=2;
					end();
				}
			}
			
			
			if(currentFrame>3 && currentFrame<9){//ensures that still on game frames (incase force quit)	
				//trace(enemyArray,homeArray);
				//Resets all card lcations
				for(var ww:int=0;ww<cardLoopArray.length;ww++){
					cardLoopArray[ww].y=1000;//sets location off stage
					cardLoopArray[ww].x=684.3;//resets x
				}
				if(selectedCard!=-1){//Offsets selected card
					cardLoopArray[selectedCard].x=674.3;
				}
				
				//Sets the coordinates for all the cards
				cardLoopArray[0].y=51.95;
				cardLoopArray[1].y=111.45;
				cardLoopArray[2].y=170.95;
				cardLoopArray[3].y=230.45;	
				cardLoopArray[4].y=289.95;
				cardLoopArray[5].y=349.45;
				
				if(healthBarArray[il]!=null && healthEnemyArray[il]!=null){//checks if health bars exist
					for (var ila:int=0;ila<homeArray.length;ila++){
						
							//CONTINUE DOWN
							//Sets location for healthbar
							healthBarHomeArray[ila].x=homeArray[ila].x-40;//sets location to enemy locatoin
							healthBarHomeArray[ila].y=homeArray[ila].y-20;
							healthHomeArray[ila].x=healthBarHomeArray[ila].x;
							healthHomeArray[ila].y=healthBarHomeArray[ila].y;
							healthHomeArray[ila].width=healthBarHomeArray[ila].width*(homeHealth[ila]/homeOriginalHealth[ila]);//Updates the width of bar
						
					}
					for (var il:int=0;il<enemyArray.length;il++){
						
							//Sets location for healthbar
							healthBarArray[il].x=enemyArray[il].x-40;
							healthBarArray[il].y=enemyArray[il].y-20;
							healthEnemyArray[il].x=healthBarArray[il].x;
							healthEnemyArray[il].y=healthBarArray[il].y;
							healthEnemyArray[il].width=healthBarArray[il].width*(enemyHealth[il]/enemyOriginalHealth[il]);
					}
					
					//Checks if anything has health of 0
					for(var rr:int=0;rr<homeHealth.length;rr++){
						//CONTINUE DOWN
						if(homeHealth[rr]<=0){//if health is 0
							explosionSound.play();//plays sound
							if(homeID[rr]=="BB"){//checks ID
								eCrown++;//increases crown if needed
								explosionSound.play();//plays sound
								
							}
							if(homeID[rr]=="CC"){
								eCrown++;
								explosionSound.play();
								
							}
							if(homeID[rr]=="AA"){
								explosionSound.play();
								
								if(homeID.indexOf("CC")!=-1){
									homeArray[homeID.indexOf("CC")].visible=false;								
									homeHealth[homeID.indexOf("CC")]=0;
									
								}
								if(homeID.indexOf("BB")!=-1){
									homeArray[homeID.indexOf("BB")].visible=false;								
									homeHealth[homeID.indexOf("BB")]=0;
									
								}
								eCrown=3;
							}
							//CONTINUE DOWN

								healthBarHomeArray[rr].parent.removeChild(healthBarHomeArray[rr]);//Remove health bars
								healthBarHomeArray.splice(rr,1);
								healthHomeArray[rr].parent.removeChild(healthHomeArray[rr]);
								healthHomeArray.splice(rr,1);
							
								homeOriginalHealth.splice(rr,1);//Remove properties
								homeHealth.splice(rr,1);
								homeID.splice(rr,1);
								
								explosionTroop=new ExplosionTroop();//Adds explosion
								explosionTroop.x=homeArray[rr].x;
								explosionTroop.y=homeArray[rr].y;
								explosionTroop.scaleX=0.25;
								explosionTroop.scaleY=0.25;
								platform.addChild(explosionTroop);
								
								homeArray[rr].parent.removeChild(homeArray[rr]);//Remove object
								homeArray.splice(rr,1);
							
						}
					}
					//Checks if anything has health of 0
					for(var r:int=0;r<enemyHealth.length;r++){
						//CONTINUE DOWN
						if(enemyHealth[r]<=0){//if health is 0
							explosionSound.play();//plays sound
							if(enemyID[r]=="BB"){//checks ID
								pCrown++;//increases crown if needed
								explosionSound.play();//plays sound
								
							}
							if(enemyID[r]=="CC"){
								pCrown++;
								explosionSound.play();
								
							}
							if(enemyID[r]=="AA"){
								explosionSound.play();
							
								if(enemyID.indexOf("CC")!=-1){
									enemyArray[enemyID.indexOf("CC")].visible=false;								
									enemyHealth[enemyID.indexOf("CC")]=0;
								
								}
								if(enemyID.indexOf("BB")!=-1){
									enemyArray[enemyID.indexOf("BB")].visible=false;							
									enemyHealth[enemyID.indexOf("BB")]=0;
								
								}
								pCrown=3;
							}
							
							//GENERATES RANDOM EMOTION
							var randomNum:Number=Math.random();//makes random number
							enemyBubbleTimer.start();//starts timer to dismiss message
							eSpeechBubble.visible=true;//makes speech bubble visible
							enemyEmoText.visible=true;//makes text box visible
							
							if(Math.random()>0.5){
								//trace("Good Game!");
								enemyEmoText.text="Good Game!";
							}
							else{
								//trace("Well Played");
								enemyEmoText.text="Well Played";
							}
							
							
								healthBarArray[r].parent.removeChild(healthBarArray[r]);
								healthBarArray.splice(r,1);
								healthEnemyArray[r].parent.removeChild(healthEnemyArray[r]);
								healthEnemyArray.splice(r,1);
							
								enemyOriginalHealth.splice(r,1);
					
								enemyHealth.splice(r,1);
								enemyID.splice(r,1);
								explosionTroop=new ExplosionTroop();
								explosionTroop.x=enemyArray[r].x;
								explosionTroop.y=enemyArray[r].y;
								explosionTroop.scaleX=0.25;
								explosionTroop.scaleY=0.25;
								platform.addChild(explosionTroop);
								enemyArray[r].parent.removeChild(enemyArray[r]);
								enemyArray.splice(r,1);
							
						}
	
					}
				}
	
				
				//***HOME CODE TO CALCULATE DISTANCE***
				var xDistanceHome,yDistanceHome:int;//only integer values
				
				//we need to find the INDEX of the closest enemy
				//by finding the closest distance from the player
				////trace(homeArray.length,enemyArray.length);
				
				closestDistanceHome=9999;
				//Loop for enemy array
				for (var h:int=0;h<enemyArray.length;h++)
				{
					
					//loop for home array
					for(var hh:int=0;hh<homeArray.length;hh++){
						
						distHome=Math.sqrt(Math.pow((homeArray[hh].x-enemyArray[h].x),2)+Math.pow((homeArray[hh].y-enemyArray[h].y),2));
						
						if (distHome<closestDistanceHome)
						{
							closestDistanceHome=distHome;//new low
							closestHome=hh;//the index of the closest
						}

						xDistanceHome=enemyArray[h].x-homeArray[hh].x;//horizontal distance
						yDistanceHome=enemyArray[h].y-homeArray[hh].y;//vertical distance
						angleRadiansHome=Math.atan2(yDistanceHome,xDistanceHome);
						
						angleDegreesHome=angleRadiansHome*180/Math.PI;//angle for troop
						ppvy[h]=Math.sin(angleRadiansHome)*2;//Gets next location
						ppvx[h]=Math.cos(angleRadiansHome)*2;
						
						if(enemyArray[h].currentFrame==enemyArray[h].totalFrames-6){//Checks if troop is in attack phase
							if(matchFinished.visible==false && enemyHealth.length!=0 && currentFrame>3 && currentFrame<9){//checks if still in frame and game is still on
								//CONTINUE DOWN
								attackSound.play();
								
								//Code to deduct home health
								
								if(enemyID[h]=="A"){//Checks ID
									homeHealth[closestHome]-=500*(1+(cardUnlocked[10]/10));//deducts health
								}
								else if(enemyID[h]==9){
									homeHealth[closestHome]-=25*(1+(cardUnlocked[9]/10));//<-Gets card's level from unlocked array and removed proportional health
								}
								else if(enemyID[h]==8){
									homeHealth[closestHome]-=24*(1+(cardUnlocked[8]/10));
								}
								else if(enemyID[h]==7){
									homeHealth[closestHome]-=40*(1+(cardUnlocked[7]/10));
								}
								else if(enemyID[h]==6){
									homeHealth[closestHome]-=5*(1+(cardUnlocked[6]/10));
								}
								else if(enemyID[h]==5){
									homeHealth[closestHome]-=8*(1+(cardUnlocked[5]/10));
								}
								else if(enemyID[h]==4){
									homeHealth[closestHome]-=20*(1+(cardUnlocked[4]/10));
								}
								else if(enemyID[h]==3){
									homeHealth[closestHome]-=10*(1+(cardUnlocked[3]/10));
								}
								else if(enemyID[h]==2){
									homeHealth[closestHome]-=20*(1+(cardUnlocked[2]/10));
								}
								else if(enemyID[h]==1){
									homeHealth[closestHome]-=5*(1+(cardUnlocked[1]/10))
								}
								
							}
						}						
						
					}//INNER
				}//OUTER
								
				//***DISTANCE CODE FOR ENEMY***
				//SAME AS ABOVE
				
				trace(numChildren);
				var xDistance,yDistance:int;//only integer values
				
				//we need to find the INDEX of the closest enemy
				//by finding the closest distance from the player
				////trace(homeArray.length,enemyArray.length);
				closestDistance=9999;
				
				//Loop for home array
				for (var i:int=0;i<homeArray.length;i++)
				{
					//Loop for enemy array
					for(var ii:int=0;ii<enemyArray.length;ii++){
						
						dist=Math.sqrt(Math.pow((enemyArray[ii].x-homeArray[i].x),2)+Math.pow((enemyArray[ii].y-homeArray[i].y),2));
						//trace("dist"+dist);
						if (dist<closestDistance)
						{
							closestDistance=dist;//new low
							closestEnemy=ii;//the index of the closest
						}
						//trace(dist,closestEnemy,closestDistance);
						////trace(homeArray[i]+homeHealth[i]);

						xDistance=homeArray[i].x-enemyArray[ii].x;//horizontal distance
						yDistance=homeArray[i].y-enemyArray[ii].y;//vertical distance
						angleRadians=Math.atan2(yDistance,xDistance);
						
						angleDegrees=angleRadians*180/Math.PI;//angle for troop
						pvy[i]=Math.sin(angleRadians)*2;
						pvx[i]=Math.cos(angleRadians)*2;
						//trace(enemyArray[closestEnemy],enemyHealth[closestEnemy],pvx,pvy,closestDistance,dist);
						if(homeArray[i].currentFrame==homeArray[i].totalFrames-6){//Checks if troop is in attack phase
							if(matchFinished.visible==false && enemyHealth.length!=0 && currentFrame>3 && currentFrame<9){//checks if still in frame and game is still on
								attackSound.play();								
								//CONTINUE DOWN
								if(homeID[i]=="A"){//Checks ID
									enemyHealth[closestEnemy]-=500*(1+(cardUnlocked[10]/10));//deducts health
								}
								else if(homeID[i]==9){
									enemyHealth[closestEnemy]-=25*(1+(cardUnlocked[9]/10));
								}
								else if(homeID[i]==8){
									enemyHealth[closestEnemy]-=24*(1+(cardUnlocked[8]/10));
								}
								else if(homeID[i]==7){
									enemyHealth[closestEnemy]-=40*(1+(cardUnlocked[7]/10));
								}
								else if(homeID[i]==6){
									enemyHealth[closestEnemy]-=5*(1+(cardUnlocked[6]/10));
								}
								else if(homeID[i]==5){
									enemyHealth[closestEnemy]-=8*(1+(cardUnlocked[5]/10));
								}
								else if(homeID[i]==4){
									enemyHealth[closestEnemy]-=20*(1+(cardUnlocked[4]/10));
								}
								else if(homeID[i]==3){
									enemyHealth[closestEnemy]-=10*(1+(cardUnlocked[3]/10));
								}
								else if(homeID[i]==2){
									enemyHealth[closestEnemy]-=20*(1+(cardUnlocked[2]/10));
								}
								else if(homeID[i]==1){
									enemyHealth[closestEnemy]-=5*(1+(cardUnlocked[1]/10))
								}
								
							}
						}						
						
					}//INNER
				}//OUTER
				
				//***HOME ARRAY MOVING***
				//Loop to move troop toward tower
				for (var iii:int=0;iii<homeArray.length;iii++)
				{	
					//Flips object depending on direction heading
					if(pvx[iii]>=0 && homeID[iii]!="AA" && homeID[iii]!="BB" && homeID[iii]!="CC"){//Checks if object is tower via ID
						homeArray[iii].scaleX=1;//If not, allow "rotation"
					}
					else if(homeID[iii]!="AA" && homeID[iii]!="BB" && homeID[iii]!="CC"){
						homeArray[iii].scaleX=-1;
					}
					
					//Attacking
					if(enemyArray[closestEnemy]!=null && homeID[iii]!="AA" && homeID[iii]!="BB" && homeID[iii]!="CC" && homeArray[iii].hitTestObject(enemyArray[closestEnemy]) && homeArray[iii].currentFrame<45){ //Checks that is not a tower and that object still exists via ID
						homeArray[iii].gotoAndPlay(46);//Goto attack frame
					}
					else if(enemyArray[closestEnemy]!=null && homeID[iii]!="AA" && homeID[iii]!="BB" && homeID[iii]!="CC" && homeArray[iii].hitTestObject(enemyArray[closestEnemy])!=true && homeArray[iii].currentFrame>44){
						homeArray[iii].gotoAndPlay(1);
					}
					
					//***Avoid the water***
					//If troop hits water block
					
					if(homeArray[iii].hitTestObject(topWall) && homeID[iii]!="AA" && homeID[iii]!="BB" && homeID[iii]!="CC"){
						homeArray[iii].y++;//Go down
					}
					else if(homeArray[iii].hitTestObject(bottomWall) && homeID[iii]!="AA" && homeID[iii]!="BB" && homeID[iii]!="CC"){
						homeArray[iii].y--;
					}
					if(homeArray[iii].hitTestObject(waterBlock)){
						if(homeArray[iii].y>230){//Checks where troop is
							homeArray[iii].y++;//move troop
						}
						else{
							homeArray[iii].y--;
						}
					}
					
					else{//Code to move troop towards enemy tower
						if(homeArray[iii]!=null && enemyArray[closestEnemy]!=null && enemyArray[closestEnemy].stage && homeArray[iii].stage && homeArray[iii].hitTestObject(enemyArray[closestEnemy])!=true){
							if(homeID[iii]!="AA" && homeID[iii]!="BB" && homeID[iii]!="CC"){//Checks that is not tower
								homeArray[iii].x-=pvx[iii];//move to tower
								homeArray[iii].y-=pvy[iii];
							}
						}
					}
					
				}//OUTER	
				
				///***ENEMY ARRAY MOVING TO TOWER***
				//SAME AS ABOVE
				for (var iiii:int=0;iiii<enemyArray.length;iiii++)
				{
					if(ppvx[iiii]>=0 && enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC"){
						enemyArray[iiii].scaleX=1;
					}
					else if(enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC"){
						enemyArray[iiii].scaleX=-1;
					}
					if(homeArray[closestHome]!=null && enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC" && enemyArray[iiii].hitTestObject(homeArray[closestHome]) && enemyArray[iiii].currentFrame<45){
						enemyArray[iiii].gotoAndPlay(46);
					}
					else if(homeArray[closestHome]!=null && enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC" && enemyArray[iiii].hitTestObject(homeArray[closestHome])!=true && enemyArray[iiii].currentFrame>44){
						enemyArray[iiii].gotoAndPlay(1);
					}

					//If troop hits water block
					if(enemyArray[iiii].hitTestObject(topWall) && enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC"){
						enemyArray[iiii].y++;
					}
					else if(enemyArray[iiii].hitTestObject(bottomWall) && enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC"){
						enemyArray[iiii].y--;
					}
					if(enemyArray[iiii].hitTestObject(waterBlock)){
						if(enemyArray[iiii].y>230){//Checks where troop is
							enemyArray[iiii].y++;//move troop
						}
						else{
							enemyArray[iiii].y--;
						}
					}
					else{//Code to move troop towards enemy tower
						if(enemyArray[iiii]!=null && homeArray[closestHome]!=null && homeArray[closestHome].stage && enemyArray[iiii].stage && enemyArray[iiii].hitTestObject(homeArray[closestHome])!=true){
							if(enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC"){
						
								enemyArray[iiii].x-=ppvx[iiii];//move to tower
								enemyArray[iiii].y-=ppvy[iiii];
							}
						}
					}
					
					if(enemyArray[iiii].hitTestObject(edgeBarrier) && enemyID[iiii]!="AA" && enemyID[iiii]!="BB" && enemyID[iiii]!="CC"){
						enemyArray[iiii].x+=ppvx[iiii];//move to tower
						enemyArray[iiii].y+=ppvy[iiii];					
					}
				}//OUTER				
			
				
				//Adding elixir
				if(elixir<10.02){//checks if elixir for player reached max limit
					elixirText.text=(Math.floor(elixir)).toString();//Display count
					elixir+=0.02*elixirMult;//Add elixir
				}
				else{//When maxed
					errorMessage.visible=true;//Show warning
					errorMessage.text="Elixir Maxed!";
					errorDismiss.start();//Timer to show warning
				}
				
				//Adding enemy's elixir
				if(eElixir<10.02){//checks if enemy's elixit is maxed
					////trace(eElixir);
					eElixir+=0.04*elixirMult;//enemy elixir has a multiplie depending on level
				}
				
				//Updates elixir bar width
				elixirBarDecimal.width=190.15*(elixir/10);//sets small elixir bar length
				elixirBar.width=190.15*((Math.floor(elixir))/10);//sets bar length
				
				//Updates crown count
				eCrownText.text=eCrown.toString();//updates crown
				pCrownText.text=pCrown.toString();//updateupdates crown
				
				if(currentSec<10){//checks if 0 placehold is necessary for clock
					timerText.text=(currentMin+":0"+currentSec);//adds 0placeholder to seconds place
				}
				else{
					timerText.text=(currentMin+":"+currentSec);//sets timefield
				}
			
				//Makes archers on tower invisibke when tower is gone
				if(enemyID.indexOf("AA")==-1){
					redKing.visible=false;
				}
				if(enemyID.indexOf("BB")==-1){
					redTower1.visible=false;
				}
				if(enemyID.indexOf("CC")==-1){
					redTower2.visible=false;
				}
				
				if(homeID.indexOf("AA")==-1){
					blueKing.visible=false;
				}
				if(homeID.indexOf("BB")==-1){
					blueTower1.visible=false;
				}
				if(homeID.indexOf("CC")==-1){
					blueTower2.visible=false;
				}
				
			}
			else{//checks if still in frames, else removes gl
				stage.removeEventListener(Event.ENTER_FRAME,gameLoop);//removes event listener for gameloop
			}
		}
	} //end class introProgram
} //end package