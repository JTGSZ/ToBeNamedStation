/*
	Macros tied to our universal spansheet to help slop this shit out faster
	TIED CSS STYLESHEET FILENAME: __universal_stylesheet.css
*/
#define span_redtext(msg) "<span class='test_redtext'>" + msg + "</span>"

#define span_purple(msg) "<span class='purpletext'>" + msg + "</span>"
#define span_midblue(msg) "<span class='midblue'>" + msg + "</span>"
#define span_neongreen(msg) "<span class='neongreen'>" + msg + "</span>"


// these are kinda shit but im tired of pasting the span stuff in these same fucking patterns
#define span_IC_color(msg) "<span style=\"color:[client.persist_data.IC_text_color]\">" + msg + "</span>"
#define span_EMOTE_color(msg) "<span style=\"color:[client.persist_data.EMOTE_text_color]\">" + msg + "</span>"
#define span_OOC_color(msg) "<span style=\"color:[persist_data.OOC_text_color]\">" + msg + "</span>"