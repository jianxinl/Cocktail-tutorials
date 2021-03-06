/*
 * Cocktail, HTML rendering engine
 * http://haxe.org/com/libs/cocktail
 *
 * Copyright (c) Silex Labs
 * Cocktail is available under the MIT license
 * http://www.silexlabs.org/labs/cocktail-licensing/
*/
import cocktail.api.CocktailView;
import flash.text.TextField;
import js.Lib;
import js.Dom;

/**
 * Show how to include a cocktail view into a flash/NME app.
 * 
 * Copies the content of a text area generated by cocktail into
 * a flash textfield when the form containing the text area is
 * submitted
 */
class Main
{
	static function main()
	{
		new Main();
	}
	
	/**
	 * flash text field
	 */
	var tf:TextField;
	
	/**
	 * cocktail web view
	 */
	var cv:CocktailView;
	
	public function new()
	{
		initFlash();
		initCocktail();
	}
	
	/**
	 * attach a flash text field
	 * to the stage
	 */
	function initFlash()
	{
		tf = new TextField();
		tf.width = 200;
		tf.height = 100;
		tf.text = "this is a flash text field,\n the content of the text area\n will be copied here";
		
		flash.Lib.current.addChild(tf);
	}
	
	/**
	 * create and attach a cocktail view to the stage
	 */
	function initCocktail()
	{
		cv = new CocktailView();
		
		//position and size the view relative to the stage
		cv.viewport = { x:0, y:100, width:400, height:400 };
		
		//load html document
		cv.loadURL("index.html");
		
		//when document ready
		cv.window.onload = function(e) {
			
			//attach cocktail view to the stage
			flash.Lib.current.addChild(cv.root);
			
			//listen for submission of the form defined in the html
			var form = cv.document.getElementById("frm");
			form.onsubmit = onFormSubmit;
		}
	}
	
	/**
	 * when form submitted, copy content
	 * of text area to flash text field
	 */
	function onFormSubmit(e)
	{
		//prevent form submission
		e.preventDefault();
		
		var form = e.target;
		var ta:TextArea = cast cv.document.getElementById("ta");
		tf.text = ta.value;
	}
}
