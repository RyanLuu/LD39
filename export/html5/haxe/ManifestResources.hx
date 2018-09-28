package;


import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Dynamic):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end
		
		var data, manifest, library;
		
		#if kha
		
		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);
		
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");
		
		#else
		
		data = '{"name":null,"assets":"aoy4:sizei4197y4:typey5:MUSICy2:idy30:assets%2Fdata%2FBlockBreak.mp3y9:pathGroupaR4y30:assets%2Fdata%2FBlockBreak.wavR4hy7:preloadtgoR0i41516R1y5:SOUNDR3R6R5aR4R6R4hgoy4:pathy31:assets%2Fdata%2FboulderTest.oelR0i7355R1y4:TEXTR3R10R7tgoR0i35614R1R8R3y33:assets%2Fdata%2FConsoleOutput.wavR5aR12hR7tgoR0i5614341R1R2R3y29:assets%2Fdata%2FConstance.mp3R5aR13R13hR7tgoR0i9443R1R2R3y27:assets%2Fdata%2FJetpack.mp3R5aR14y27:assets%2Fdata%2FJetpack.wavR14hR7tgoR0i65244R1R8R3R15R5aR14R15R14hgoR0i5478R1R2R3y24:assets%2Fdata%2FJump.mp3R5aR16y24:assets%2Fdata%2FJump.wavR16hR7tgoR0i26798R1R8R3R17R5aR16R17R16hgoR9y28:assets%2Fdata%2FjumpTest.oelR0i7469R1R11R3R18R7tgoR9y26:assets%2Fdata%2Flevel0.oelR0i6744R1R11R3R19R7tgoR9y26:assets%2Fdata%2Flevel1.oelR0i7676R1R11R3R20R7tgoR9y27:assets%2Fdata%2Flevel10.oelR0i4764R1R11R3R21R7tgoR9y26:assets%2Fdata%2Flevel2.oelR0i11128R1R11R3R22R7tgoR9y26:assets%2Fdata%2Flevel4.oelR0i7891R1R11R3R23R7tgoR9y26:assets%2Fdata%2Flevel5.oelR0i7973R1R11R3R24R7tgoR9y26:assets%2Fdata%2Flevel6.oelR0i7819R1R11R3R25R7tgoR9y26:assets%2Fdata%2Flevel7.oelR0i10937R1R11R3R26R7tgoR9y26:assets%2Fdata%2Flevel8.oelR0i10438R1R11R3R27R7tgoR9y26:assets%2Fdata%2Flevel9.oelR0i10422R1R11R3R28R7tgoR9y27:assets%2Fdata%2Fproject.oepR0i5678R1R11R3R29R7tgoR0i7355000R1R2R3y30:assets%2Fdata%2FSpellbound.mp3R5aR30R30hR7tgoR9y31:assets%2Fdata%2FTeleTesting.oelR0i2755R1R11R3R31R7tgoR9y24:assets%2Fdata%2Ftest.oelR0i7338R1R11R3R32R7tgoR9y34:assets%2Fdata%2FTestingGrounds.oelR0i3220R1R11R3R33R7tgoR9y25:assets%2Fdata%2Ftiles.pngR0i7004R1y5:IMAGER3R34R7tgoR9y24:assets%2Fimages%2Fbg.pngR0i4495R1R35R3R36R7tgoR9y25:assets%2Fimages%2Fbg1.pngR0i4707R1R35R3R37R7tgoR9y25:assets%2Fimages%2Fbg2.pngR0i4183R1R35R3R38R7tgoR9y25:assets%2Fimages%2Fboi.pngR0i2865R1R35R3R39R7tgoR9y31:assets%2Fimages%2Fboi_drill.pngR0i2858R1R35R3R40R7tgoR9y29:assets%2Fimages%2Fboulder.pngR0i3216R1R35R3R41R7tgoR9y27:assets%2Fimages%2Fflame.pngR0i480R1R35R3R42R7tgoR9y27:assets%2Fimages%2Frover.pngR0i3726R1R35R3R43R7tgoR9y35:assets%2Fimages%2Ftransition-in.pngR0i11071R1R35R3R44R7tgoR9y36:assets%2Fimages%2Ftransition-out.pngR0i11083R1R35R3R45R7tgoR0i2114R1R2R3y26:flixel%2Fsounds%2Fbeep.mp3R5aR46y26:flixel%2Fsounds%2Fbeep.ogghR7tgoR0i39706R1R2R3y28:flixel%2Fsounds%2Fflixel.mp3R5aR48y28:flixel%2Fsounds%2Fflixel.ogghR7tgoR0i5794R1R8R3R47R5aR46R47hgoR0i33629R1R8R3R49R5aR48R49hgoR0i15744R1y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR3y30:flixel%2Ffonts%2Fnokiafc22.ttfR7tgoR0i29724R1R50R51y36:__ASSET__flixel_fonts_monsterrat_ttfR3y31:flixel%2Ffonts%2Fmonsterrat.ttfR7tgoR9y33:flixel%2Fimages%2Fui%2Fbutton.pngR0i519R1R35R3R56R7tgoR9y36:flixel%2Fimages%2Flogo%2Fdefault.pngR0i3280R1R35R3R57R7tgoR9y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pngR0i912R1R35R3R58R7tgoR9y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pngR0i433R1R35R3R59R7tgoR9y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pngR0i446R1R35R3R60R7tgoR9y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pngR0i459R1R35R3R61R7tgoR9y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pngR0i511R1R35R3R62R7tgoR9y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pngR0i493R1R35R3R63R7tgoR9y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pngR0i247R1R35R3R64R7tgoR9y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pngR0i534R1R35R3R65R7tgoR9y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pngR0i922R1R35R3R66R7tgoR9y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pngR0i946R1R35R3R67R7tgoR9y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pngR0i253R1R35R3R68R7tgoR9y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pngR0i212R1R35R3R69R7tgoR9y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pngR0i192R1R35R3R70R7tgoR9y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pngR0i214R1R35R3R71R7tgoR9y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pngR0i156R1R35R3R72R7tgoR9y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pngR0i1724R1R35R3R73R7tgoR9y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pngR0i294R1R35R3R74R7tgoR9y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pngR0i129R1R35R3R75R7tgoR9y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pngR0i128R1R35R3R76R7tgoR9y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pngR0i136R1R35R3R77R7tgoR9y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pngR0i147R1R35R3R78R7tgoR9y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pngR0i191R1R35R3R79R7tgoR9y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pngR0i153R1R35R3R80R7tgoR9y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pngR0i185R1R35R3R81R7tgoR9y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pngR0i201R1R35R3R82R7tgoR9y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pngR0i210R1R35R3R83R7tgoR9y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pngR0i18509R1R35R3R84R7tgoR9y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlR0i1263R1R11R3R85R7tgoR9y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlR0i1953R1R11R3R86R7tgoR9y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlR0i1848R1R11R3R87R7tgoR0i7355000R1R2R3R30R5aR30R30hgoR0i5614341R1R2R3R13R5aR13R13hgoR0i5478R1R2R3R16R5aR16R17R16hgoR0i4197R1R2R3R4R5aR4R6R4hgoR0i9443R1R2R3R14R5aR14R15R14hgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
		#end
		
	}
	
	
}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_data_blockbreak_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_blockbreak_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_bouldertest_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_consoleoutput_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_constance_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_jetpack_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_jetpack_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_jump_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_jump_wav extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_jumptest_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level0_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level1_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level10_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level2_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level4_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level5_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level6_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level7_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level8_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_level9_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_project_oep extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_spellbound_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_teletesting_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_test_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_testinggrounds_oel extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bg1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_bg2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boi_drill_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_boulder_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_flame_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_rover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_transition_in_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_transition_out_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_spellbound_mp4 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_constance_mp4 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_jump_mp4 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_blockbreak_mp4 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_data_jetpack_mp4 extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/BlockBreak.mp3") #if display private #end class __ASSET__assets_data_blockbreak_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/data/BlockBreak.wav") #if display private #end class __ASSET__assets_data_blockbreak_wav extends haxe.io.Bytes {}
@:keep @:file("assets/data/boulderTest.oel") #if display private #end class __ASSET__assets_data_bouldertest_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/ConsoleOutput.wav") #if display private #end class __ASSET__assets_data_consoleoutput_wav extends haxe.io.Bytes {}
@:keep @:file("assets/data/Constance.mp3") #if display private #end class __ASSET__assets_data_constance_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/data/Jetpack.mp3") #if display private #end class __ASSET__assets_data_jetpack_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/data/Jetpack.wav") #if display private #end class __ASSET__assets_data_jetpack_wav extends haxe.io.Bytes {}
@:keep @:file("assets/data/Jump.mp3") #if display private #end class __ASSET__assets_data_jump_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/data/Jump.wav") #if display private #end class __ASSET__assets_data_jump_wav extends haxe.io.Bytes {}
@:keep @:file("assets/data/jumpTest.oel") #if display private #end class __ASSET__assets_data_jumptest_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level0.oel") #if display private #end class __ASSET__assets_data_level0_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level1.oel") #if display private #end class __ASSET__assets_data_level1_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level10.oel") #if display private #end class __ASSET__assets_data_level10_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level2.oel") #if display private #end class __ASSET__assets_data_level2_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level4.oel") #if display private #end class __ASSET__assets_data_level4_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level5.oel") #if display private #end class __ASSET__assets_data_level5_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level6.oel") #if display private #end class __ASSET__assets_data_level6_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level7.oel") #if display private #end class __ASSET__assets_data_level7_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level8.oel") #if display private #end class __ASSET__assets_data_level8_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/level9.oel") #if display private #end class __ASSET__assets_data_level9_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/project.oep") #if display private #end class __ASSET__assets_data_project_oep extends haxe.io.Bytes {}
@:keep @:file("assets/data/Spellbound.mp3") #if display private #end class __ASSET__assets_data_spellbound_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/data/TeleTesting.oel") #if display private #end class __ASSET__assets_data_teletesting_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/test.oel") #if display private #end class __ASSET__assets_data_test_oel extends haxe.io.Bytes {}
@:keep @:file("assets/data/TestingGrounds.oel") #if display private #end class __ASSET__assets_data_testinggrounds_oel extends haxe.io.Bytes {}
@:keep @:image("assets/data/tiles.png") #if display private #end class __ASSET__assets_data_tiles_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg.png") #if display private #end class __ASSET__assets_images_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg1.png") #if display private #end class __ASSET__assets_images_bg1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/bg2.png") #if display private #end class __ASSET__assets_images_bg2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boi.png") #if display private #end class __ASSET__assets_images_boi_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boi_drill.png") #if display private #end class __ASSET__assets_images_boi_drill_png extends lime.graphics.Image {}
@:keep @:image("assets/images/boulder.png") #if display private #end class __ASSET__assets_images_boulder_png extends lime.graphics.Image {}
@:keep @:image("assets/images/flame.png") #if display private #end class __ASSET__assets_images_flame_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rover.png") #if display private #end class __ASSET__assets_images_rover_png extends lime.graphics.Image {}
@:keep @:image("assets/images/transition-in.png") #if display private #end class __ASSET__assets_images_transition_in_png extends lime.graphics.Image {}
@:keep @:image("assets/images/transition-out.png") #if display private #end class __ASSET__assets_images_transition_out_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/beep.mp3") #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/flixel.mp3") #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/beep.ogg") #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/sounds/flixel.ogg") #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/images/ui/button.png") #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,5,1/assets/images/logo/default.png") #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_down.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_left.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_right.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_arrow_up.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_thin.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/button_toggle.png") #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/check_box.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/check_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome_flat.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome_inset.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/chrome_light.png") #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/dropdown_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/finger_big.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/finger_small.png") #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/hilight.png") #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/invis.png") #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/minus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/plus_mark.png") #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/radio.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/radio_dot.png") #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/swatch.png") #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/tab.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/tab_back.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/images/tooltip_arrow.png") #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/xml/defaults.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/xml/default_loading_screen.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,3,1/assets/xml/default_popup.xml") #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end