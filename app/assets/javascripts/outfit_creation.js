/*
	Copyright Style du Jour
*/

var outfit_canvas = {

	/* 
		Variables 
	*/
	
	canvas: undefined,
	ctx: undefined,
		
	width: 800,
	height: 600,
	
	// Layer Storage
	layers: [],
	
	// Sidebar
	side: {
		width: 150, // Sidebar Width px
		
		
		height: undefined, // Used to set the height of the sidebar
		pos: 1,
		
		imgWidth: 70, // Image Width px
		imgHeight: 70, // Image Height px
		imgGap: 5, // Gap between images px
		
		moveIconUp: '/assets/icons/moveup.png',
		moveIconDown: '/assets/icons/movedown.png',
		moveIconWidth: 150,
		moveIconHeight: 40,
		
		// Script Dependant Vars
		offset: 0, // Used for scrolling offsetting images at top
		offsetMove: 0,
		
		total: 0, // Holds the total number of items in sidebar
		loaded: 0, // Number loaded
		items: [], // Stores all items in the sidebar
		
		dx: 0, // Layout Position X
		dy: 0, // Layout Position Y
		
		dxCurrent: 0,
		dxMax: 0,
		
		dyCurrent: 0
	},
	
	drag: {
		x: undefined,
		y: undefined,
		
		xoff: undefined, // Offset From image item side
		yoff: undefined,
		
		item: undefined
	},
	
	selected: undefined, // Which element is currently selected
	
	// Scale Options
	scaleDrag: false,
	scaleIcon: '/assets/icons/scale.png',
	scaleIconSize: [20, 40], // First value is size on browser, second mobile
	
	/* 
		Main Functions
	*/
	
	init: function(id)
	{
		var that = this;
	
		this.canvas = document.getElementById(id);
		this.ctx = this.canvas.getContext('2d');
		
		this.canvas.width = this.width;
		this.canvas.height = this.height;
		
		/*
			Scale Set-up
		*/
		if(this.scaleIcon != undefined)
		{
			var scaleIconTemp = this.scaleIcon;
			
			this.scaleIcon = new Image();
			this.scaleIcon.src = scaleIconTemp;			
		}
		
		// Set size based on device
		this.scaleIconSize = (this.isMobile()) ? this.scaleIconSize[1] : this.scaleIconSize[0];
		
		
		/*
			Move Set-up
		*/
		if(this.side.moveIconUp != undefined && this.side.moveIconDown != undefined)
		{
			var moveIconTemp = this.side.moveIconUp;
			this.side.moveIconUp = new Image();
			this.side.moveIconUp.src = moveIconTemp;
			
			moveIconTemp = this.side.moveIconDown;
			this.side.moveIconDown = new Image();
			this.side.moveIconDown.src = moveIconTemp;
		}
		//this.side.height = this.height - (this.side.moveIconHeight * 2); // Set Side Height
		//this.side.offset = this.side.moveIconHeight; // Adjust by icon height
		//this.side.offsetMove = this.side.offset;
		this.side.height = this.height; // Uncomment above to do offset
		
		/* 
			Set-up Events, based on device
		*/
		if(this.isMobile())
		{
			this.bindEvent(this.canvas, 'touchstart', function(e){ that.ondown(e) });
			this.bindEvent(this.canvas, 'touchend', function(e){ that.onup(e) });
			this.bindEvent(this.canvas, 'touchmove', function(e){ that.onmove(e) });
		}
		else
		{
			this.bindEvent(this.canvas, 'mousedown', function(e){ that.ondown(e) });
			this.bindEvent(this.canvas, 'mouseup', function(e){ that.onup(e) });
			this.bindEvent(this.canvas, 'mousemove', function(e){ that.onmove(e) });		
		}
		
		/*
			Set-up Sidebar Values
		*/
		if(this.side.pos == 1)
		{
			this.side.dx = ((this.canvas.width - this.side.width) + this.side.imgGap);
		}
		else
		{
			this.side.dx = this.side.imgGap;
		}
				
		this.side.dy = this.side.imgGap;
		
		this.side.dxMax = Math.floor(this.side.width/(this.side.imgWidth + this.side.imgGap));
		window.addEventListener('goLoadSide', this.loadSideLoaded, false);
	},

	loadSide: function(imgs, clear)
	{
		var items = [];
		var loaded = 0;
	
		// Clear Current Items
		if(clear != undefined)
		{ 
			this.side.items = [];
			this.side.total = 0;
			this.side.loaded = 0;
			this.side.dxCurrent = 0;
			this.side.dyCurrent = 0;		
		}
		
		this.side.total += imgs.length;
		
		// Loop through Images
		for(var i = 0; i < imgs.length; i++)
		{
			items[i] = new Image();
			
			items[i].onload = (function(img, that, info)
			{	
				var item = {
					img: img,
				
					name: info.name,
					src: info.photo_url,
					
					sx: info.sx || 0,
					sy: info.sy || 0,
					swidth: info.swidth || img.width,
					sheight: info.sheight || img.height,
					
					width: info.width || that.side.imgWidth,
					height: info.height || that.side.imgHeight,

					clothing_item: info.id
					
				};
				
				that.side.items.push(item);
				that.side.loaded++;
				//that.loadSideLoaded();
				
			})(items[i], this, imgs[i]);
			
			items[i].src = imgs[i].photo_url;
			$([items[i]]).s3ImageProxy();
		}
	},
	
	loadSideLoaded: function()
	{	
		var that = this;
		var side = this.side;
	
		if(side.loaded == side.total)
		{		
			// Loop through items
			for(var i = 0; i < side.items.length; i++)
			{
				var item = side.items[i];
				
				// Set Position if not set
				if(item.dx == undefined)
				{
					item.dx = side.dx + side.dxCurrent * (side.imgWidth + side.imgGap);
					item.dy = side.dy + side.dyCurrent * (side.imgHeight + side.imgGap);
					
					// Adjust position
					side.dxCurrent++;
					
					if(side.dxCurrent == side.dxMax)
					{
						side.dxCurrent = 0;
						side.dyCurrent++;
					}
				}			
			}			
		}
	},
	
	
	/* 
		Offset Move
	*/
	offsetMove: function()
	{
		if(this.side.offset != this.side.offsetMove)
		{
			if(this.side.offset < this.side.offsetMove)
			{
				this.side.offset += 5;
			}
			else
			{
				this.side.offset -= 5;
			}
		}	
	},
	
	moveOffsetUp: function()
	{
		if((this.side.offsetMove - this.side.height) > (0 - this.side.moveIconHeight -(this.side.dyCurrent * (this.side.imgHeight + this.side.imgGap))))
		{
			this.side.offsetMove -= this.side.height;
		}	
	},
	
	moveOffsetDown: function()
	{
		if((this.side.offsetMove + this.side.height) <= this.side.moveIconHeight)
		{
			this.side.offsetMove += this.side.height;
		}
		
	},
	
	/*
		Drawing
	*/
	
	draw: function()
	{
		// Check if offset movement is required
		this.offsetMove(); 
	
		// Clear Canvas + Show Layers
		this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
		this.drawLayers();
		
		// Clear Sidebar + Draw Sidebar
		if(this.side.pos == 0)
		{
			this.ctx.clearRect(0, 0, this.side.width, this.canvas.height);
		}
		else
		{
			this.ctx.clearRect((this.canvas.width - this.side.width), 0, this.side.width, this.canvas.height);
		}
		
		this.drawSide();
		this.drawSideImages();
		this.drawSideButtons();
				
		// Draw Dragging Element
		this.drawDrag();
		
		this.drawSelected();
	},

		drawSide: function()
		{
			var ctx = this.ctx;
		
			// Apply Style
			ctx.lineWidth = 1;
			ctx.strokeStyle = '#999';
			
			// Draw Line
			ctx.beginPath();
		
			if(this.side.pos == 0)
			{
				ctx.moveTo(this.side.width, 0);
				ctx.lineTo(this.side.width, this.canvas.height);
			}
			else
			{			
				ctx.moveTo((this.canvas.width - this.side.width), 0);
				ctx.lineTo((this.canvas.width - this.side.width), this.canvas.height);
			}
			
			ctx.closePath();
			ctx.stroke();
		},
		
		drawSideImages: function()
		{
			var items = this.side.items;
		
			// Draw Images
			for(var i = 0; i < items.length; i++)
			{
				// Add In Dimensions if not present
				if(items[i].swidth == 0)
				{
					items[i].swidth = items[i].img.width;
				}
				if(items[i].sheight == 0)
				{
					items[i].sheight = items[i].img.height;
				}
				
				this.ctx.drawImage(items[i].img, items[i].sx, items[i].sy, items[i].swidth, items[i].sheight, items[i].dx, (items[i].dy + this.side.offset), this.side.imgWidth, this.side.imgHeight);
			}
		},
		
		drawSideButtons: function()
		{
			// Clear the areas where button is going to go!
			var ctx = this.ctx;
			var side = this.side;
			
			var drawUp = ((this.side.offsetMove - this.side.height) > (0 - this.side.moveIconHeight -(this.side.dyCurrent * (this.side.imgHeight + this.side.imgGap)))) ? true : false;
			var drawDown = ((this.side.offsetMove + this.side.height) <= this.side.moveIconHeight) ? true : false;
			
			if(side.pos == 0)
			{
				if(drawDown)
				{
					//ctx.clearRect(0, 0, side.moveIconWidth, side.moveIconHeight);
					ctx.drawImage(side.moveIconUp, 0, 0, side.moveIconWidth, side.moveIconHeight);
				}
				
				if(drawUp)
				{
					//ctx.clearRect(0, (this.height-side.moveIconHeight), side.moveIconWidth, side.moveIconHeight);
			
					ctx.drawImage(side.moveIconDown, 0, (this.height-side.moveIconHeight), side.moveIconWidth, side.moveIconHeight);					
				}
			}
			else
			{	
				if(drawDown)
				{
					//ctx.clearRect((this.canvas.width - side.width+1), 0, side.moveIconWidth, side.moveIconHeight);	
					ctx.drawImage(side.moveIconUp, (this.canvas.width - side.width), 0, side.moveIconWidth, side.moveIconHeight);
				}	
				
				if(drawUp)
				{
					//ctx.clearRect((this.canvas.width - side.width+1), (this.height-side.moveIconHeight), side.moveIconWidth, side.moveIconHeight);
				
					ctx.drawImage(side.moveIconDown, (this.canvas.width - side.width), (this.height-side.moveIconHeight), side.moveIconWidth, side.moveIconHeight);					
				}

			}			
			
		},

		drawLayers: function()
		{
			var layers = this.layers;
				
			for(var i = 0; i < layers.length; i++)
			{
				this.ctx.drawImage(layers[i].img, layers[i].sx, layers[i].sy, layers[i].swidth, layers[i].sheight, layers[i].dx, layers[i].dy, layers[i].width, layers[i].height);
			}
			
		},
		
		drawDrag: function()
		{
			var item = this.drag.item;
		
			if(this.drag.x != undefined)
			{
				this.ctx.drawImage(item.img, item.sx, item.sy, item.swidth, item.sheight, (this.drag.x - this.drag.xoff), (this.drag.y - this.drag.yoff), item.width, item.height);			
			}
		},
		
		drawSelected: function()
		{			
			if(this.selected != undefined)
			{
				var selected = this.layers[this.selected];
				var iconSize = this.scaleIconSize;

				if(this.scaleIcon != undefined)
				{
					this.ctx.drawImage(this.scaleIcon, (selected.dx + selected.width - (iconSize/2)), (selected.dy - iconSize/2), iconSize, iconSize);	
				}
				else
				{
					if(this.scaleDrag)
					{
						this.ctx.strokeStyle = 'blue';
						this.ctx.fillStyle = 'grey';
					}
					else
					{
						this.ctx.strokeStyle = 'black';
						this.ctx.fillStyle = 'yellow';
					}				
					
					this.ctx.beginPath();
					this.ctx.arc((selected.dx + selected.width), selected.dy,iconSize,0,Math.PI*2,true);  // Draw Circle
					this.ctx.fill();
					
	
					this.ctx.beginPath();
					this.ctx.arc((selected.dx + selected.width), selected.dy,(iconSize+1),0,Math.PI*2,true);  // Draw outer Ring
					this.ctx.stroke();					
				}
				
			}		
		},


	/*
		Events
	*/
	
	ondown: function(e)
	{	
		var pos = this.onpos(e);
		
		this.selected = undefined;
		
		if((this.side.pos == 0 && pos.x < this.side.width) || (this.side.pos == 1 && pos.x > (this.canvas.width - this.side.width)))
		{
			this.ondownSide(pos);
		}
		else
		{
			this.ondownMain(pos);
		}
			
	},
		ondownSide: function(pos)
		{
			var side = this.side;
			
			// Check if it was a move button click
			if((side.pos == 0 && pox.x > 0 && pos.x < side.moveIconWidth && pos.y > 0 && pos.y < side.moveIconHeight) || (side.pos == 1 && pos.x > (this.width - side.width) && pos.x < this.width && pos.y > 0 && pos.y < side.moveIconHeight))
			{
				this.moveOffsetDown();
			}
			else if((side.pos == 0 && pox.x > 0 && pos.x < side.moveIconWidth && pos.y > (this.height - side.moveIconHeight) && pos.y < this.height) || (side.pos == 1 && pos.x > (this.width - side.width) && pos.x < this.width && pos.y > (this.height - side.moveIconHeight) && pos.y < this.height))
			{
				this.moveOffsetUp();
				
			}
			else
			{
				var items = this.side.items;
				
				for(var i = 0; i < items.length; i++)
				{
					var item = items[i];
					
					// If click was inside element
					if(pos.x > item.dx && pos.y > (item.dy+this.side.offset) && pos.x < (item.dx + this.side.imgWidth) && pos.y < (item.dy+this.side.offset + this.side.imgHeight))
					{			
						// Create Drag Element
						this.drag.x = pos.x;
						this.drag.y = pos.y;				
					
						// Create Drag Item
						this.drag.xoff = pos.x - item.dx;
						this.drag.yoff = pos.y - (item.dy + this.side.offset);
						
						this.drag.item = {
							clothing_item: item.clothing_item,
							name: item.name,
							
							img: item.img,
							
							sx: item.sx,
							sy: item.sy,
							swidth: item.swidth,
							sheight: item.sheight,
							
							width: this.side.imgWidth,
							height: this.side.imgHeight,
							
							info: item	
						}	
						
						break;
					}
				}
			}
		},
		

		ondownMain: function(pos)
		{
			var layers = this.layers;
			
			for(var i = layers.length - 1; i >= 0; i--)
			{
				var layer = layers[i];
				
				// Check if this layer is selected
				if(i == (layers.length - 1))
				{
					var iconSize = this.scaleIconSize;
				
					// Moving the scale element
					if(pos.x > (layer.dx + layer.width - (iconSize/2)) && pos.y > (layer.dy - (iconSize/2)) && pos.x < (layer.dx + layer.width + (iconSize/2)) && pos.y < (layer.dy + (iconSize/2)))
					{
						this.selected = i;
						this.scaleDrag = true;
						break;
					} 
					
				}

				// If click was on an element
				if(pos.x > layer.dx && pos.y > layer.dy && pos.x < (layer.dx + layer.width) && pos.y < (layer.dy + layer.height))
				{	
					
					// Create Drag Element
					this.drag.x = pos.x;
					this.drag.y = pos.y;				
				
					// Create Drag Item
					this.drag.xoff = pos.x - layer.dx;
					this.drag.yoff = pos.y - layer.dy;
					
					this.drag.item = {
						clothing_item: layer.clothing_item,
						name: layer.name,
						
						img: layer.img,
						
						sx: layer.sx,
						sy: layer.sy,
						swidth: layer.swidth,
						sheight: layer.sheight,
						
						width: layer.width,
						height: layer.height,
						
						info: layer	
					}					
					
					
					// Remove Item From Layer
					this.layers.splice(i, 1);
					
					// Redraw Scene (Putting this one on top)
					this.draw();
					
					break;
				}
				
				
			}
		},
	
	onup: function(e)
	{	
		var pos = this.onpos(e);
		
		if(this.drag.x != undefined)
		{
			if((this.side.pos == 0 && pos.x < this.side.width) || (this.side.pos == 1 && pos.x > (this.canvas.width - this.side.width)))
			{
				this.onupSide();
			}
			else
			{
				this.onupMain();
			}
	
			// Reset Drag
			this.drag = {
				x: undefined,
				y: undefined,
				
				xoff: undefined, 
				yoff: undefined,
				
				item: undefined
			};		
			
			// Redraw Scene
			this.draw();	
		}
		
		this.scaleDrag = false;
	},
		onupSide: function()
		{
			// Do nothing here for now!
		},
		
		onupMain: function()
		{
			// Create Elemet + Set as Selected + Z Index Top
			var dragInfo = this.drag.item;
			var item = {
				clothing_item: dragInfo.clothing_item,
				name: dragInfo.name,
				
				img: dragInfo.img,
				
				sx: dragInfo.sx,
				sy: dragInfo.sy,
				swidth: dragInfo.swidth,
				sheight: dragInfo.sheight,
				
				dx: (this.drag.x - this.drag.xoff),
				dy: (this.drag.y - this.drag.yoff),
				
				width: dragInfo.width,
				height: dragInfo.height
			};			
			
			this.layers.push(item);
			
			this.selected = this.layers.length-1;
		},
	
	onmove: function(e)
	{
		e.preventDefault(); // Stop default actions
	
		var pos = this.onpos(e);

		if(this.drag.x != undefined)
		{
			if((this.side.pos == 0 && pos.x < this.side.width) || (this.side.pos == 1 && pos.x > (this.canvas.width - this.side.width)))
			{
				this.onmoveSide(pos);
			}
			else
			{
				this.onmoveMain(pos);
			}
		
			this.draw(); // Redraw Scene
		}
		else if(this.selected != undefined && this.scaleDrag)
		{
			// Move Selected
			var selectedLayer = this.layers[this.selected];
			
			if(pos.x > (selectedLayer.dx + 10))
			{
				selectedLayer.width = pos.x - selectedLayer.dx;
			}
			
			if(pos.y < (selectedLayer.dy + selectedLayer.height - 10))
			{
				selectedLayer.height += selectedLayer.dy - pos.y;
				selectedLayer.dy = pos.y;				
			}						
		}	
	},
		onmoveSide: function(pos)
		{
			// Check if just moved into sidebar
			if((this.side.pos == 0 && this.drag.x > this.side.width) || (this.side.pos == 1 && this.drag.x < (this.canvas.width - this.side.width)))
			{
				this.drag.item.width = this.side.imgWidth;
				this.drag.item.height = this.side.imgHeight;
			}
		
			// Update Drag Position
			this.drag.x = pos.x;
			this.drag.y = pos.y;		
		},
		
		onmoveMain: function(pos)
		{

			// Check if just moved into main
			if((this.side.pos == 0 && this.drag.x < this.side.width) || (this.side.pos == 1 && this.drag.x > (this.canvas.width - this.side.width)))
			{
				this.drag.item.width = this.drag.item.info.width;
				this.drag.item.height = this.drag.item.info.height;
			}
		
			// Update Drag Position
			this.drag.x = pos.x;
			this.drag.y = pos.y;							
		},	
		
	onpos: function(e)
	{	
		var x, y;
		if(this.isMobile())
		{
			if(e.touches[0] != undefined)
			{
				e = e.touches[0];
			}
			else
			{
				e = e.changedTouches[0];
			}					
		
			x = e.clientX + document.body.scrollLeft - this.canvas.offsetLeft;
			y = e.clientY + document.body.scrollTop - this.canvas.offsetTop;				
		}
		else
		{
			x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft - this.canvas.offsetLeft;
			y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop - this.canvas.offsetTop;
		}

	
		return {x: x, y: y};
	},
	
	
	/*
		Other Functions
	*/
	
	bindEvent: function(element, type, handler) 
	{
   		if(element.addEventListener) 
   		{
      		element.addEventListener(type, handler, false);
   		} 
   		else 
   		{
      		element.attachEvent('on'+type, handler);
   		}
	},
	
	isMobile: function()
	{
    	var mobile = (/iphone|ipad|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()));  
    	return (mobile) ? true : false;  
	},
	
	save: function()
	{
		// Clear Canvas and Draw Layers
		this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
		this.drawLayers();	
	
		// Save Data
		var data = this.canvas.toDataURL("image/png");
		
		var layers = $.map(this.layers, function(o,i) {
			return JSON.parse(JSON.stringify(o, function(k,v) { return (k === 'img') ? undefined : v; }));
		});

		var saveData = {img: data, info: layers}
		// Redraw Scene
		this.draw();
		
		return saveData;
	}
}