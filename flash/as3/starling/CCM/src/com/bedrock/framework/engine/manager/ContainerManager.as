package com.bedrock.framework.engine.manager
{
	import com.bedrock.framework.core.base.StandardBase;
	import com.bedrock.framework.engine.api.IContainerManager;
	import com.bedrock.framework.engine.data.BedrockData;
	import com.bedrock.framework.plugin.storage.HashMap;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import com.bedrock.framework.plugin.util.XMLUtil2;

	public class ContainerManager extends StandardBase implements IContainerManager
	{
		/*
		Variable Declarations
		*/
		private var _containers:HashMap;
		/*
		Constructor
		*/
		public function ContainerManager()
		{
		}

		public function initialize( $data:XML, $root:DisplayObjectContainer ):void
		{
			this._containers = new HashMap  ;
			this._containers.saveValue( BedrockData.ROOT, $root );
			
			this._buildContainers( $data, this.root, true );
		}
		/*
		Layout Related
		*/
		private function _buildContainers( $data:*, $parent:DisplayObjectContainer, $root:Boolean = false ):void
		{
			var objContainer:DisplayObjectContainer;
			if ( !$root ) {
				objContainer = this.createContainer( $data.@id, null, $parent, $data );
			} else {
				objContainer = $parent;
			}
			
			for each (var xmlSubContainer:XML in $data.children() ) {
				this._buildContainers( xmlSubContainer, objContainer );
			}
		}
		/*
		Container Managment
		*/
		public function createContainer( $id:String, $child:DisplayObjectContainer=null, $parent:DisplayObjectContainer=null, $data:*=null, $depth:int=-1 ):*
		{
			if ( !this.hasContainer( $id ) ) {
				return this._getNewContainer( $id, $child, $parent, $data, $depth );
			}
		}
		public function replaceContainer( $id:String, $child:DisplayObjectContainer, $data:*=null, $depth:int=-1 ):*
		{
			if ( this.hasContainer( $id ) ) {
				return this._getNewContainer( $id, $child, this.getContainer( $id ).parent, $data, $depth );
			}
		}
		public function getContainer( $id:String):*
		{
			return this._containers.getValue( $id );
		}
		public function removeContainer( $id:String ):void
		{
			var objChild:* = this.getContainer($id);
			var objParent:* = objChild.parent;
			if (objChild && objParent) {
				objParent.removeChild(objChild);
			}
			this._containers.removeValue($id);
		}
		
		public function hasContainer( $id:String):Boolean
		{
			return this._containers.containsKey( $id );
		}
		
		public function getDepth( $id:String ):int
		{
			return this.getContainer( $id ).parent.getChildIndex( this.getContainer( $id ) );
		}
		/*
		Apply Property Object to container
		*/
		private function _applyProperties($target:DisplayObjectContainer, $data:*=null):void
		{
			var objData:Object = ( $data is XML ) ? XMLUtil2.getAttributesAsObject( $data ) : $data;
			for ( var a:String in objData ) {
				switch ( a ) {
					case "id" :
						break;
					default :
						$target[ a ] = objData[ a ];
						break;
				}
			}
		}
		
		/*
		Container Functions
		*/
		private function _addContainer($container:DisplayObjectContainer, $child:DisplayObjectContainer, $depth:int =-1 ):int
		{
			try {
				$container.addChildAt($child, $depth);
			} catch ($error:Error) {
				$container.addChild($child);
			}
			return $container.getChildIndex($child);
		}
		private function _getNewContainer($id:String, $child:DisplayObjectContainer, $parent:DisplayObjectContainer=null, $data:*=null, $depth:int=-1):*
		{
			var numDepth:int = -1;
			if ( this.hasContainer( $id ) ) {
				numDepth = this.getDepth( $id );
				this.removeContainer( $id );
			}
			numDepth = ( $depth > -1 ) ? $depth : numDepth;

			var objChild:DisplayObjectContainer = $child || new Sprite;
			objChild.name = $id;

			var numActualDepth:int = this._addContainer( $parent || this.root, objChild, numDepth );
			this._applyProperties( objChild, $data );

			this._containers.saveValue( $id, objChild );

			return objChild;
		}
		
		/*
		Property Definitions
		*/
		public function get root():DisplayObjectContainer
		{
			return this.getContainer( BedrockData.ROOT );
		}
	}
}

