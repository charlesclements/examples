package com.bedrock.framework.plugin.gadget
{
	/**
	* Handles the positioning and resizing of targets relative to the stage
	*
	* @author Alex Toledo
	* @version 1.0.0
	* @created Wed May 21 2008 10:36:34 GMT-0400 (EDT)
	*/
	import com.bedrock.framework.core.base.StaticBase;
	import com.bedrock.framework.core.logging.LogLevel;
	import com.bedrock.framework.core.logging.Logger;
	import com.bedrock.framework.plugin.data.StageRelationData;
	import com.bedrock.framework.plugin.storage.HashMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;

	public class StageRelationManager extends StaticBase
	{
		/*
		Variable Declarations
		*/
		private static var __objStage:Stage;
		private static var __mapTargets:HashMap;
		/*
		Constructor
		*/
		Logger.log(StageRelationManager, LogLevel.CONSTRUCTOR, "Constructed");
		/*
		Initialize passing in an instance of stage
	 	*/
	 	public static function initialize($stage:Stage):void
		{
			StageRelationManager.__mapTargets = new HashMap;
			StageRelationManager.__objStage = $stage;
			StageRelationManager.__objStage.addEventListener(Event.RESIZE, StageRelationManager.onResize);
		}
		/*
		Add/ Remove targets from the hash map
	 	*/
	 	public static function add( $data:StageRelationData ):void
		{
			if (StageRelationManager.__objStage != null) {
				StageRelationManager.__mapTargets.saveValue( $data.id, $data );
				StageRelationManager.updateTarget( $data);
			} else {
				Logger.log( StageRelationManager, LogLevel.ERROR, "Stage value is null!" );
			}
		}
		public static function remove( $id:String ):void
		{
			StageRelationManager.__mapTargets.removeValue($id);
		}
		public static function update( $id:String ):void
		{
			StageRelationManager.updateTarget( StageRelationManager.__mapTargets.getValue( $id ) );
		}
		/*
		Resize single target relative to the stage
	 	*/
	 	private static function resizeTarget( $data:StageRelationData):void
		{
			if ( $data.widthResize ) $data.target.width = StageRelationManager.__objStage.stageWidth;
			if ( $data.heightResize ) $data.target.height = StageRelationManager.__objStage.stageHeight;
		}
		/*
		Align single target relative to the stage
	 	*/
	 	private static function alignTarget( $data:StageRelationData):void
		{
			$data.target.x = StageRelationManager.getHorzontalPosition($data.target, $data.horizontalAlignment, $data.horizontalOffset);
			if ( $data.positionBasedOnSize ) $data.target.x -= ( $data.target.width / 2 );
			$data.target.y = StageRelationManager.getVerticalPosition($data.target, $data.verticalAlignment, $data.verticalOffset);
			if ( $data.positionBasedOnSize ) $data.target.y -= ( $data.target.height / 2 );
		}
	 	/*
		Resize and align all available target relative to the stage
	 	*/
	 	public static function updateTargets():void
		{
			var arrTargets:Array = StageRelationManager.__mapTargets.getValues();
			var numLength:int = arrTargets.length;
			for (var i:int = 0 ; i < numLength; i++) {
				StageRelationManager.updateTarget( arrTargets[i] );
			}
		}
		/*
		Resize and align single target relative to the stage
	 	*/
		private static function updateTarget( $data:StageRelationData ):void
		{
			StageRelationManager.alignTarget( $data );
			StageRelationManager.resizeTarget( $data );
		}
		/*
		Position calculations
	 	*/
		private static function getHorzontalPosition($target:DisplayObjectContainer, $alignment:String, $offset:int):Number
		{
			var numPosition:Number = 0;
			var objPoint:Point = $target.parent.globalToLocal( new Point( 0, 0 ) );
			switch ( $alignment ) {
				case StageRelationData.LEFT :
					numPosition = objPoint.x + $offset;
					break;
				case StageRelationData.CENTER :
					numPosition = objPoint.x + ((StageRelationManager.__objStage.stageWidth/2) + $offset);
					break;
				case StageRelationData.RIGHT :
					numPosition = objPoint.x + (StageRelationManager.__objStage.stageWidth + $offset);
					break;
				case StageRelationData.NONE :
					numPosition = $target.x;
					break;
			}
			return numPosition;
		}
		private static function getVerticalPosition($target:DisplayObjectContainer, $alignment:String, $offset:int):Number
		{
			var numPosition:Number = 0;
			var objPoint:Point = $target.parent.globalToLocal( new Point( 0, 0 ) );
			switch ($alignment) {
				case StageRelationData.TOP :
					numPosition = objPoint.y + $offset;
					break;
				case StageRelationData.CENTER :
					numPosition = objPoint.y + ((StageRelationManager.__objStage.stageHeight/2) + $offset);
					break;
				case StageRelationData.BOTTOM :
					numPosition = objPoint.y + (StageRelationManager.__objStage.stageHeight + $offset);
					break;
				case StageRelationData.NONE :
					numPosition = $target.y;
					break;
			}
			return numPosition;
		}
		/*
		Event Handlers
	 	*/
	 	private static function onResize($event:Event):void
		{
			StageRelationManager.updateTargets();
		}
	}
}