package com.bedrock.framework.plugin.pagination
{
	import com.bedrock.framework.core.base.DispatcherBase;

	public class Pagination extends DispatcherBase implements IPageable
	{
		/*
		Variable Decarations
		*/
		private var _totalItems:uint;
		private var _totalPages:uint;
		private var _itemsPerPage:uint;
		private var _selectedPage:uint;
		public var wrap:Boolean;
		/*
		Constructor
		*/
		public function Pagination()
		{
			this.reset();
		}
		/*
		Public Functions
		*/
		public function update($total:uint = 0, $itemsPerPage:uint = 0):void
		{
			this._selectedPage = 0;
			this._totalItems =  $total;
			this._itemsPerPage = $itemsPerPage;
			this._totalPages = Math.ceil(this._totalItems / this._itemsPerPage) || 0;
			this.status("Total Records - " + this._totalItems);
			this.status("Total Pages - " + this._totalPages);
			this._checkBounds();
			this.dispatchEvent(new PaginationEvent(PaginationEvent.UPDATE, this, {total:this._totalPages, selected:this._selectedPage}));
			this.selectPage( 0 );
		}
		public function reset():void
		{
			this._totalItems = 0;
			this._itemsPerPage = 0;
			this._totalPages = 0;
			this._selectedPage = 0;
			this.dispatchEvent( new PaginationEvent(PaginationEvent.RESET, this ) );
		}
		/*
		Page Selection Functions
		*/
		public function selectPage($index:uint):uint
		{
			if ( $index >= this._totalPages ) {
				this._selectedPage = ( this._totalPages - 1 );
			} else if ( $index < 0  ) {
				this._selectedPage = 0;
			} else {
				this._selectedPage = $index;
				this.status("Selected Page - " + this._selectedPage);
				this.dispatchEvent(new PaginationEvent(PaginationEvent.SELECT_PAGE, this, {selected:this._selectedPage, total:this._totalPages}));
			}
			return this._selectedPage;
		}
		 /* 
		Check Bounds 
		*/ 
		private function _checkBounds():void 
		{ 
			if ( this._selectedPage >= this._totalPages ) {
				this._selectedPage = ( this._totalPages - 1 );
			}
		}
		/*
		Navigate Pages
		*/
		public function nextPage():uint
		{
			if ( this.hasNextPage() ) {
				return this.selectPage( this._selectedPage + 1);
			} else {
				return this._selectedPage;
			}
		}
		public function previousPage():uint
		{
			if ( this.hasPreviousPage() ) {
				return this.selectPage(this._selectedPage - 1);
			} else {
				return this._selectedPage;
			}
		}
		/*
		Has Pages
		*/
		public function hasNextPage():Boolean
		{
			return this.hasPage( this._selectedPage + 1 );
		}
		public function hasPreviousPage():Boolean
		{
			return this.hasPage( this._selectedPage - 1 );
		}
		public function hasPage( $page:uint ):Boolean
		{
			return ( ( $page  >= 0 ) && ( $page < this._totalPages ) );
		}
		/*
		Property Definitions
		*/
		public function get totalItems():uint
		{
			return this._totalItems;
		}
		public function get selectedPage():uint
		{
			return this._selectedPage;
		}
		public function get itemsPerPage():uint
		{
			return this._itemsPerPage;
		}
		public function get totalPages():uint
		{
			return this._totalPages;
		}
	}
}