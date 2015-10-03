//GETTING MOUSE POS----------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
// Set Netscape up to run the "captureMousePosition" function whenever
// the mouse is moved. For Internet Explorer and Netscape 6, you can capture
// the movement a little easier.


if (document.layers) { // Netscape
    document.captureEvents(Event.MOUSEMOVE);
    document.onmousemove = captureMousePosition;
} else if (document.all) { // Internet Explorer
    document.onmousemove = captureMousePosition;
} else if (document.getElementById) { // Netcsape 6
    document.onmousemove = captureMousePosition;
}
// Global variables
xMousePos = 0; // Horizontal position of the mouse on the screen
yMousePos = 0; // Vertical position of the mouse on the screen
xMousePosMax = 0; // Width of the page
yMousePosMax = 0; // Height of the page

function captureMousePosition(e) {
    if (document.layers) {
        // When the page scrolls in Netscape, the event's mouse position
        // reflects the absolute position on the screen. innerHight/Width
        // is the position from the top/left of the screen that the user is
        // looking at. pageX/YOffset is the amount that the user has
        // scrolled into the page. So the values will be in relation to
        // each other as the total offsets into the page, no matter if
        // the user has scrolled or not.
        xMousePos = e.pageX;
        yMousePos = e.pageY;
        xMousePosMax = window.innerWidth + window.pageXOffset;
        yMousePosMax = window.innerHeight + window.pageYOffset;
    } else if (document.all) {
        // When the page scrolls in IE, the event's mouse position
        // reflects the position from the top/left of the screen the
        // user is looking at. scrollLeft/Top is the amount the user
        // has scrolled into the page. clientWidth/Height is the height/
        // width of the current page the user is looking at. So, to be
        // consistent with Netscape (above), add the scroll offsets to
        // both so we end up with an absolute value on the page, no
        // matter if the user has scrolled or not.
        xMousePos = window.event.x + document.body.scrollLeft;
        yMousePos = window.event.y + document.body.scrollTop;
        xMousePosMax = document.body.clientWidth + document.body.scrollLeft;
        yMousePosMax = document.body.clientHeight + document.body.scrollTop;
    } else if (document.getElementById) {
        // Netscape 6 behaves the same as Netscape 4 in this regard
        xMousePos = e.pageX;
        yMousePos = e.pageY;
        xMousePosMax = window.innerWidth + window.pageXOffset;
        yMousePosMax = window.innerHeight + window.pageYOffset;
    }
}
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
//-----------------------------------------------------------------------

//Ajax
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------

function loadCommand(CommandID) {

    ajaxpage("Handler.ashx?CommandID=" + CommandID.toString(), "FormDiv");
}




function InitXmlHttp() {
    // Attempt to initialize xmlhttp object
    try {
        xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }
    catch (e) {
        // Try to use different activex object
        try {
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        catch (E) {
            xmlhttp = false;
        }
    }

    // If not initialized, create XMLHttpRequest object
    if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
        xmlhttp = new XMLHttpRequest();
    }
    // Define function call for when Request obj state has changed
    xmlhttp.onreadystatechange = XMLHttpRequestCompleted;
}
var params;
function InvokeASHX(param) {
    //ChangeLoadingPanel(true);
    InitXmlHttp();
    params = param;

    xmlhttp.onreadystatechange = XMLHttpRequestCompleted;
    xmlhttp.open("GET", "" + param, true);
    xmlhttp.send(null);
    //ChangeLoadingPanel(false);
}

function XMLHttpRequestCompleted() {

    if (xmlhttp.readyState == 4) {
        try {
            ShowWindowDialog(params);
        }
        catch (e) {

        }

        $(".LastPosDialg").fadeIn();
    }

}

function ChangeLoadingPanel(visiblity) {

    var doc = document.getElementById("div_loading");
    if (visiblity == true) {
        doc.style.visibility = "visible";
    } else {
    doc.style.visibility = "hidden";
    }
    
}


function ShowPosition(PointID,Visible)
{
    //var doc = document.getElementById("div_position_detail");
    if (Visible == true) {


        //getposbyposid
             //ajaxpage("google.com","div");
           var _http = false;
           var resp = "";
           if(navigator.appName == "Microsoft Internet Explorer"){ _http = new ActiveXObject("Microsoft.XMLHTTP"); } else { _http = new XMLHttpRequest(); }
           _http.open("GET", "handler.ashx?getposbyposid="+PointID);
           _http.onreadystatechange=function()
           {
             if(_http.readyState == 4)
              {


                resp = _http.responseText;
                  var posarr=[];
                  posarr = resp.split(",");
                  //div_child_position_detail
                   //ID, UnitID, e, n, rep_type, dt, sped, inp, out
                  //var str = v+" | کد گزارش"+ " "+posarr[4]+" "+"|  "+posarr[5]+" ورودی و خروجی"+ posarr[6]+","+posarr[7];
                  //document.getElementById("div_child_position_detail").innerHTML = str;
                                
                  GetPosDialog(PointID);
                  map.setCenter(new GLatLng(parseFloat(posarr[3]),parseFloat(posarr[2])),17);



              }
           }
    _http.send(null);
        

       // $("#div_position_detail").fadeIn();
    } else {
    //$("#div_position_detail").fadeOut();
    }

}


function ShowWindowDialog(Params) {

    var x = xMousePos;
    var y = yMousePos;
    dialogString = xmlhttp.responseText;
    var doc = document.getElementById("LastPosDialg");
    doc.innerHTML = "";
    doc.innerHTML = dialogString;
    doc.style.top = y;
    doc.style.left = x;
}



function ShowLastPostStaticWin(Params) {
    var unitid;
    $(".LastPosDialg").fadeOut();

    //changeVisible(false, "div_commandWindows");
    if (Params != "")
    {   unitid =Params; 
        Params = "Handler.ashx?_UnitID=" + Params; }
    for (var i=0;i<GMarkers.length;i++)
    {
        if (GMarkers[i].UnitID.toString() == unitid.toString())
        {
            GetPosDialog(GMarkers[i].ID);
        }

    }


    InvokeASHX(Params);
    
}




// Again Ajax VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV


var _____bustcachevar = 1 //bust potential caching of external pages after initial request? (1=yes, 0=no)
var loadedobjects = ""
var rootdomain = "http://" + window.location.hostname
var bustcacheparameter = ""




function ajaxpage(url, containerid) {
    document.getElementById(containerid).innerHTML = "لطفا صبر کنید...";
    var page_request = false
    if (window.XMLHttpRequest) // if Mozilla, Safari etc
        page_request = new XMLHttpRequest()
    else if (window.ActiveXObject) { // if IE
        try {
            page_request = new ActiveXObject("Msxml2.XMLHTTP")
        }
        catch (e) {
            try {
                page_request = new ActiveXObject("Microsoft.XMLHTTP")
            }
            catch (e) { }
        }
    }
    else
        return false
    page_request.onreadystatechange = function() {
        loadpage(page_request, containerid)
    }
    //if (_____bustcachevar) bustcacheparameter = (url.indexOf("?") != -1) ? "&" + new Date().getTime() : "?" + new Date().getTime()
    page_request.open('GET', url, true)
    page_request.send(null)
}

function ajaxpageWithOutDIV(url) {





        var http = false;
        var resp = "";
        if (navigator.appName == "Microsoft Internet Explorer") {
            http = new ActiveXObject("Microsoft.XMLHTTP");
        } else {
            http = new XMLHttpRequest();
        }
        http.open("GET", url );

        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                resp = http.responseText;
                if (resp != " " && resp != "") {



                }
            }
        }
        http.send(null);


}


function loadpage(page_request, containerid) {
    if (page_request.readyState == 4 && (page_request.status == 200 || window.location.href.indexOf("http") == -1))
        if (document.getElementById(containerid) != null) {
            document.getElementById(containerid).innerHTML = "";

        document.getElementById(containerid).innerHTML = page_request.responseText
    }
}




// this is for command generator
function txt(xx) {
    var i = 1;
    var t1;
    var par = "";
    for (i = 1; i <= xx; i++) {
        t1 = document.getElementById("txt" + String(i));
        par = "frm_Commands.aspx" + "?ID1=" + String(i) + "&ID2=" + t1.value;

        ajaxpageWithOutDIV(par);
    }
    ajaxpageWithOutDIV("Handler.ashx?sc=1111111");
    
    alert("دستور مورد نظر ارسال گردید");
}

function CallCommandForm(param,GuidID) {
    if (param != "") {
    
        changeVisible(true, 'div_commandWindows');
        ajaxpage("frm_Commands.aspx?UnitID=" + param + '&guid=' + GuidID, "div_commandWindows");
        //document.getElementById("UnitIDCommand").innerTEXT = "xxxxxx";


    } else {
   
    changeVisible(true, 'div_commandWindows');
    ajaxpage("frm_Commands.aspx", "div_commandWindows");
    }


}

function CallPrevForm(UnitID) {
    if (UnitID != "") {

        changeVisible(true, 'div_commandWindows');
        ajaxpage("frm_Preview_Way.aspx?UnitID=" + UnitID, "div_commandWindows");
        //document.getElementById("UnitIDCommand").innerTEXT = "xxxxxx";


    } else {

        changeVisible(true, 'div_commandWindows');
        ajaxpage("frm_Preview_Way.aspx", "div_commandWindows");
    }


}

//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//----------------------------------------------------
//Handling Online Positions
//in this part i have to First Get Positions last Array then working with it so
//1:Getting All Cars Last Positions
//2:Making a timer
//3:Contrasting Positions ID ;)
//4:If New ID Found then return its position
//----------------------------------------------------
//----------------------------------------------------

var ArrayOfOnlinePosDBID = new Array();
var ArrayOfOnlinePosDBID2 = new Array();

// this adds to array :)
function atp(ID, UnitID, e, n, rep_type, dt, sped,inp,out) {
    var OnlinePosDBID = new Object();
    OnlinePosDBID.ID = ID;
    OnlinePosDBID.UnitID = UnitID;
    OnlinePosDBID.e = e;
    OnlinePosDBID.n = n;
    OnlinePosDBID.rep_type = rep_type;
    OnlinePosDBID.sped = sped;
    OnlinePosDBID.dt = dt;
    OnlinePosDBID.inp = inp; 
    OnlinePosDBID.out=out;
    ArrayOfOnlinePosDBID.push(OnlinePosDBID);
}

// this adds to compared array :)
function atp2(ID, UnitID, e, n, rep_type, dt, sped, inp, out) {
    var OnlinePosDBID = new Object();
    OnlinePosDBID.ID = ID;
    OnlinePosDBID.UnitID = UnitID;
    OnlinePosDBID.e = e;
    OnlinePosDBID.n = n;
    OnlinePosDBID.rep_type = rep_type;
    OnlinePosDBID.sped = sped;
    OnlinePosDBID.dt = dt;
    OnlinePosDBID.inp = inp;
    OnlinePosDBID.out = out;
    ArrayOfOnlinePosDBID2.push(OnlinePosDBID);
}
// comparing Arrays



function aca() 
{

try
{
    for (var i = 0; i < ArrayOfOnlinePosDBID2.length; i++) 
    {for (var x = 0; x < ArrayOfOnlinePosDBID.length; x++) 
        { if (ArrayOfOnlinePosDBID2[i].UnitID == ArrayOfOnlinePosDBID[x].UnitID) 
            { // Detected the same position 
                if ( ArrayOfOnlinePosDBID2[i].ID != ArrayOfOnlinePosDBID[x].ID) 
                {
                    // new position detected ...
                    ArrayOfOnlinePosDBID[x].ID = ArrayOfOnlinePosDBID2[i].ID;                    
                    ArrayOfOnlinePosDBID[x].UnitID = ArrayOfOnlinePosDBID2[i].UnitID;                    
                    ArrayOfOnlinePosDBID[x].e = ArrayOfOnlinePosDBID2[i].e;                    
                    ArrayOfOnlinePosDBID[x].n = ArrayOfOnlinePosDBID2[i].n;                    
                    ArrayOfOnlinePosDBID[x].rep_type = ArrayOfOnlinePosDBID2[i].rep_type;                    
                    ArrayOfOnlinePosDBID[x].sped = ArrayOfOnlinePosDBID2[i].sped;                    
                    ArrayOfOnlinePosDBID[x].dt = ArrayOfOnlinePosDBID2[i].dt;                    
                    ArrayOfOnlinePosDBID[x].inp = ArrayOfOnlinePosDBID2[i].inp;                    
                    ArrayOfOnlinePosDBID[x].out = ArrayOfOnlinePosDBID2[i].out;                    
                    document.getElementById("gd_car_id").innerHTML = ArrayOfOnlinePosDBID2[i].UnitID;                    
                    document.getElementById("gd_date").innerHTML = ArrayOfOnlinePosDBID2[i].dt;                    
                    document.getElementById("RepDifValue").innerHTML = ArrayOfOnlinePosDBID2[i].rep_type;
                    document.getElementById("gd_input_id").innerHTML = ArrayOfOnlinePosDBID2[i].inp;
                    document.getElementById("gd_output_id").innerHTML = ArrayOfOnlinePosDBID2[i].out; 
                    document.getElementById("gd_en").innerHTML = ArrayOfOnlinePosDBID2[i].e + " " + ArrayOfOnlinePosDBID2[i].n;
                    document.getElementById("gd_speed").innerHTML = ArrayOfOnlinePosDBID2[i].sped;
                    startTimer();

                    //ShowOnlineLatestPostion(1010001106);
                    ///////// THIS LINE WORKS WITH GOOGLEMAP ++++++++++
                }
            }
        }
    }
    } catch (e)
    {
    }
}




//timer-------======================8888888888888888888888


var running = false;
var endTime = null;
var timerID = null;
var _____value;
function startTimer() {
    running = true;
    now = new Date();
    now = now.getTime();
    endTime = now + (1000 * 7 * 1);
    showCountDown();
}
function showCountDown() {
    var now = new Date();
    now = now.getTime();
    if (endTime - now <= 0) {
        SendRequestPositionsToServer();
        startTimer();
    } else {
        var delta = new Date(endTime - now);
        var theMin = delta.getMinutes();
        var theSec = delta.getSeconds();
        var theTime = theMin;
        theTime += ((theSec < 10) ? ":0" : ":") + theSec;
        _____value = theTime;
        if (running) {
            timerID = setTimeout("showCountDown()", 6000);
        }
    }
}
function stopTimer() {

}

startTimer();
//88888888888888888888888888888888888888888888888

//////////// other procedures
function changeVisible(visible, divname) {
    if (visible == true) {

        document.getElementById(divname).style.visibility = "visible";
        $("#" + divname).fadeIn();
    } else {
    $(
    "#" + divname).fadeOut();
    
    //document.getElementById(divname).style.visibility = "hidden";
    
    }
}

/////// NOW WORKING WITH GOOGLE MAP
//--------------------------------------------------------------------
//ArrayOfOnlinePosDBID
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
var GMarkers = [];
var GMarkerLabels = [];




//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
//--------------------------------------------------------------------

    // ELabel.js 
    //
    //   This Javascript is provided by Mike Williams
    //   Community Church Javascript Team
    //   http://www.bisphamchurch.org.uk/   
    //   http://econym.org.uk/gmap/
    //
    //   This work is licenced under a Creative Commons Licence
    //   http://creativecommons.org/licenses/by/2.0/uk/
    //
    // Version 0.2      the .copy() parameters were wrong
    // version 1.0      added .show() .hide() .setContents() .setPoint() .setOpacity() .overlap
    // version 1.1      Works with GMarkerManager in v2.67, v2.68, v2.69, v2.70 and v2.71
    // version 1.2      Works with GMarkerManager in v2.72, v2.73, v2.74 and v2.75
    // version 1.3      add .isHidden()
    // version 1.4      permit .hide and .show to be used before addOverlay()
    // version 1.5      fix positioning bug while label is hidden
    // version 1.6      added .supportsHide()
    // version 1.7      fix .supportsHide()
    // version 1.8      remove the old GMarkerManager support due to clashes with v2.143


    function ELabel(id, point, html, classname, pixelOffset, percentOpacity, overlap) {
        // Mandatory parameters
        this.point = point;
        this.html = html;
        this.id = id;

        // Optional parameters
        this.classname = classname || "";
        this.pixelOffset = pixelOffset || new GSize(0, 0);
        if (percentOpacity) {
            if (percentOpacity < 0) { percentOpacity = 0; }
            if (percentOpacity > 100) { percentOpacity = 100; }
        }
        this.percentOpacity = percentOpacity;
        this.overlap = overlap || false;
        this.hidden = false;
    }

    ELabel.prototype = new GOverlay();

    ELabel.prototype.initialize = function(map) {
        var div = document.createElement("div");
        div.style.position = "absolute";

        div.innerHTML = '<div class="' + this.classname + '">' + this.html + '</div>';
        map.getPane(G_MAP_FLOAT_SHADOW_PANE).appendChild(div);
        this.map_ = map;
        this.div_ = div;
        if (this.percentOpacity) {
            if (typeof (div.style.filter) == 'string') { div.style.filter = 'alpha(opacity:' + this.percentOpacity + ')'; }
            if (typeof (div.style.KHTMLOpacity) == 'string') { div.style.KHTMLOpacity = this.percentOpacity / 100; }
            if (typeof (div.style.MozOpacity) == 'string') { div.style.MozOpacity = this.percentOpacity / 100; }
            if (typeof (div.style.opacity) == 'string') { div.style.opacity = this.percentOpacity / 100; }
        }
        if (this.overlap) {
            var z = GOverlay.getZIndex(this.point.lat());
            this.div_.style.zIndex = z;
        }
        if (this.hidden) {
            this.hide();
        }
    }

    ELabel.prototype.remove = function() {
        this.div_.parentNode.removeChild(this.div_);
    }

    ELabel.prototype.copy = function() {
        return new ELabel(this.point, this.html, this.classname, this.pixelOffset, this.percentOpacity, this.overlap);
    }

    ELabel.prototype.redraw = function(force) {
        var p = this.map_.fromLatLngToDivPixel(this.point);
        var h = parseInt(this.div_.clientHeight);
        this.div_.style.left = (p.x + this.pixelOffset.width) + "px";
        this.div_.style.top = (p.y + this.pixelOffset.height - h) + "px";
    }

    ELabel.prototype.show = function() {
        if (this.div_) {
            this.div_.style.display = "";
            this.redraw();
        }
        this.hidden = false;
    }

    ELabel.prototype.hide = function() {
        if (this.div_) {
            this.div_.style.display = "none";
        }
        this.hidden = true;
    }

    ELabel.prototype.isHidden = function() {
        return this.hidden;
    }

    ELabel.prototype.supportsHide = function() {
        return true;
    }

    ELabel.prototype.setContents = function(html) {
        this.html = html;
        this.div_.innerHTML = '<div class="' + this.classname + '">' + this.html + '</div>';
        this.redraw(true);
    }

    ELabel.prototype.setPoint = function(point) {
        this.point = point;
        if (this.overlap) {
            var z = GOverlay.getZIndex(this.point.lat());
            this.div_.style.zIndex = z;
        }
        this.redraw(true);
    }

    ELabel.prototype.setOpacity = function(percentOpacity) {
        if (percentOpacity) {
            if (percentOpacity < 0) { percentOpacity = 0; }
            if (percentOpacity > 100) { percentOpacity = 100; }
        }
        this.percentOpacity = percentOpacity;
        if (this.percentOpacity) {
            if (typeof (this.div_.style.filter) == 'string') { this.div_.style.filter = 'alpha(opacity:' + this.percentOpacity + ')'; }
            if (typeof (this.div_.style.KHTMLOpacity) == 'string') { this.div_.style.KHTMLOpacity = this.percentOpacity / 100; }
            if (typeof (this.div_.style.MozOpacity) == 'string') { this.div_.style.MozOpacity = this.percentOpacity / 100; }
            if (typeof (this.div_.style.opacity) == 'string') { this.div_.style.opacity = this.percentOpacity / 100; }
        }
    }

    ELabel.prototype.getPoint = function() {
        return this.point;
    }



    function gp(UnitID) //
    {
        ajaxpageWithOutDIV("handler.ashx?geposunid=" + UnitID);
        alert("درخواست شما جهت آخرین موقعیت درخواستی ارسال گردید");   


    }

        function autoRotate() {
  // Determine if we're showing aerial imagery
  if (map.isRotatable) {
    // start auto-rotating at 3 second intervals
    setTimeout('map.changeHeading(90)', 3000);
    setTimeout('map.changeHeading(180)',6000);
    setTimeout('map.changeHeading(270)',9000);
    setTimeout('map.changeHeading(0)',12000);
  }
} 
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    //-------------------------------------------------------------------------
    // GMap Codes :
var GMarkerPlay = new Array();
var GLabelPlay = new Array();
var GMrakerPlayName = new Array();

var GPlayLine = new GPolyline([],"#ff0000", 10);
function CreateMarker(n, e, speed, UnitID,ID) {
    var pnt = new GLatLng(n, e); // adding points
    var cafeIcon = new GIcon();
    if (speed == 0) { cafeIcon.image = "img/icons/icon47_003.png"; }
    if (speed != 0) { cafeIcon.image = "img/icons/icon62_002.png"; }
    if (speed > 100) { cafeIcon.image = "img/icons/icon15_004.png"; }
    cafeIcon.iconSize = new GSize(32, 32);
    cafeIcon.iconAnchor = new GPoint(6, 20);
    cafeIcon.infoWindowAnchor = new GPoint(5, 1);
    markerOptions = { icon: cafeIcon, title: UnitID.toString() };
    var mrk = new GMarker(pnt, markerOptions);
    mrk.ID = ID;
    mrk.UnitID = UnitID;
    GEvent.addListener(mrk,"click",function()
    {
       GetPosDialog(ID);
    }
            )
    GEvent.addListener(mrk,"infowindowopen",function()
    {

                            
                            geocoder.getLocations(pnt, function(answer)
                            {

                                getAddress(map,pnt);

                            });
    })


    return mrk;
}

function CreateLabel(_id, point, txt, pointID,name) {
    var stuff = '<div style="padding: 0px 0px 8px 8px; background: url(point_bottom_left.png) no-repeat bottom left;"><div style="background-color: #f2efe9; padding: 2px;"><b> <a href="javascript:ShowLastPostStaticWin(' + _id + ')">' + _id +' <br/>'+name+ '<\/a> <\/b><\/div><\/div>';
    var label = new ELabel(_id, point, stuff, null, null, 65);
    label.id =  pointID;
    return label;

}
function CreateLabelPoi(_id, point, txt, pointID,name) {
    if (_id != undefined)
    {
    var stuff = '<div style="padding: 0px 0px 8px 8px; background: url(point_bottom_left.png) no-repeat bottom left;"><div style="background-color: #f2efe9; padding: 2px;"><b>'+txt+'<\/b><\/div><\/div>';

    var label = new ELabel(_id, point, stuff, null, null, 65);
    label.ID =  _id;
    return label;
        }

}
function CreateLabelPlay(_id, point, txt, pointID) {
    var stuff = '<div style="padding: 0px 0px 8px 8px;"><div style="background-color: #f2efe9; padding: 2px;"><b> <a href="javascript:ShowPosition(' + pointID +','+'true'+ ')">' + _id + '<\/a> <\/b><\/div><\/div>';
    var label = new ELabel(_id, point, stuff, null, null, 65);
    return label;

}

function SetAllCarsBound() {
    var bounds = new GLatLngBounds();
    for (var i = 0; i < GMarkers.length; i++) {
        //var gp = GMarkers[i].getLatLng()
        bounds.extend(
                      GMarkers[i].getLatLng()     );

}

return bounds;

}

function SetAllCarsBoundPoi() {
    var bounds = new GLatLngBounds();
    for (var i = 0; i < GMarkers.length; i++) {
        //var gp = GMarkers[i].getLatLng()
        bounds.extend(
                      GMarkers[i].getLatLng()     );

}

return bounds;

}
  
function requestFirstCallPositionsString()
{
	var http = false;
	var resp = "";
	if(navigator.appName == "Microsoft Internet Explorer") {
		http = new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		http = new XMLHttpRequest();
	}

	http.open("GET", "handler.ashx?gmonlcd=1");
	http.onreadystatechange=function() {
		if(http.readyState == 4) {
			resp=http.responseText;
			CreateMapObjects(resp);
		}
	}
	http.send(null);
}



    function CPW_Clear() {
        //GMarkerPlay.clear();
        for (var i = 0; i < GMarkerPlay.length; i++) {
                    map.removeOverlay(GMarkerPlay[i]);
                }
        GMarkerPlay.length = 0;


        for (var i = 0; i < GLabelPlay.length; i++) {
            map.removeOverlay(GLabelPlay[i]);
        }

        GLabelPlay.length = 0;
        GMrakerPlayName.length = 0;
        map.removeOverlay(GPlayLine);
        //hideWayPrevGrid();
    }
    function CPW(point, html) {  // CPV = Create Point Way
        var marker = new GMarker(point);
        //GEvent.addListener(marker, "click", function() {            marker.openInfoWindowHtml(html);        });

            marker.ID = ID;
    marker.UnitID = UnitID;
    GEvent.addListener(marker,"click",function()
    {
       GetPosDialog(ID);
    }
            )
    GEvent.addListener(marker,"infowindowopen",function()
    {


                            geocoder.getLocations(pnt, function(answer)
                            {

                                getAddress(map,pnt);

                            });
    });


        GMarkerPlay.push(marker);
    }
function CPW_ShowMarkers(gmp) {
    PrevBounds = new GLatLngBounds();
    for (var i = 0; i < gmp.length; i++) {
        map.addOverlay(gmp[i]);

        PrevBounds.extend(gmp[i].getLatLng());
    }
    map.setCenter( PrevBounds.getCenter(), map.getBoundsZoomLevel(PrevBounds) );
}
function CPW_ShowMarkersPOI(gmp) {
    PrevBounds = new GLatLngBounds();
    for (var i = 0; i < gmp.length; i++) {
        map.addOverlay(gmp[i]);

        PrevBounds.extend(gmp[i].getLatLng());
    }
    
    map.setCenter( PrevBounds.getCenter(), map.getBoundsZoomLevel(PrevBounds) );
}

    var preVisible;
    preVisible = false;


    function hideWayPrevGrid() {
        $("#PrevWayGridDiv").addClass("PrevWayGridHide");
        $("#PrevWayGridDiv").removeClass("PrevWayGridPlay");
                  
        $(".map_canvas_div").animate
              (
                { 'right': '175px' }
                 , {
                     duration: 'slow'
                     , easing: 'swing'
                     , complete: function() {
                     }
                     , queue: false
                 }
              );
        //


        preVisible = false;
  
    }
    function ShowWayPrevGrid() {
        // at first we have to change the position of Map Screen :) :
        if (!preVisible) {
            
            $(".map_canvas_div").animate
              (
                { 'right': '375px' }
                 , {
                       duration: 'slow'
                     , easing: 'swing'
                     , complete: function() {
                                              $("#PrevWayGridDiv").addClass("PrevWayGridPlay");
                                              $("#PrevWayGridDiv").removeClass("PrevWayGridHide");
                                            }
                     , queue: false
                                        }
              );
              
              
                                        preVisible = true;
        }
        else {
            $("#PrevWayGridDiv").addClass("PrevWayGridPlay");
            $("#PrevWayGridDiv").removeClass("PrevWayGridHide");
                                      
        //    $("#PrevWayGridDiv")
         //   .fadeOut()
         //   .removeClass("PrevWayGridHide")
         //   .addClass("PrevWayGridDiv")            
         //   .fadeIn();
            
                                
                                
      //      preVisible = false;
      //      $("#PrevWayGridDiv").addClass("PrevWayGridHide");
      //      $("#PrevWayGridDiv").removeClass("PrevWayGridDiv");
      //      
      //      $(".map_canvas_div").animate(
      //  { 'right': '175px' }
       // , {
      //      duration: 'slow'
      //      , easing: 'swing'
      //      , complete: function() {  }
      //      , queue: false
      //  });

        }

        

        //PrevWayGridPlay
        
        //addClass("map_canvas_div_with_Prev_Grid");

    }

    function CreateMapObjects(HashedPoints)
    {
        
         var MainArray = [];
        var childArray = [];
        var ID,UID,E,N,SP,NM;
        MainArray = HashedPoints.split("?");
        if (MainArray.length != 0)
        {
            for (var i=0;i < MainArray.length; i++)
            {
                if (MainArray[i] != " " && MainArray[i] != "" )
                {
                childArray.length = 0;
                childArray = MainArray[i].split(",");
                ID=childArray[0];
                UID=childArray[1];
                E=childArray[2];
                N=childArray[3];
                SP=childArray[4];
                NM=childArray[5];

                 var gm = CreateMarker(N,E,SP,UID,ID);
                 GMarkers.push(gm);
                 // creating map;

                 map.addOverlay(gm);
                 var lbl = CreateLabel(
                            UID,
                            new GLatLng(N, E),
                            "",
                            65,NM);
                   map.addOverlay(lbl);
                    lbl.UnitID =UID; 
                   GMarkerLabels.push(lbl);

                   //

                 }
            }
                    var AllCarBound = SetAllCarsBound();
                    var Poss =  AllCarBound.getCenter();
                    map.setCenter(AllCarBound.getCenter(), map.getBoundsZoomLevel(AllCarBound));
        }
        
        
    }





//  >>   handler.ashx?getlatestch=1&UID=1010000001&ID=2514511
//  <<   [UnitID,ID]
//  >> if Change Detected  handler.ashx?getlatestch=1&UID=1010000001
//  << [ID, UnitID, e, n, rep_type, dt, sped, inp, out]
//
//
//
//

var geocoder;
var address;
geocoder = new GClientGeocoder();
             
function GetPosDialog(PointID)
{
    var http = false;
    var resp = "";
    var ptid = PointID;
    var vi = false;
 	if(navigator.appName == "Microsoft Internet Explorer") {
		http = new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		http = new XMLHttpRequest();
	}
    http.open("GET", "handler.ashx?ptnid="+PointID);
    http.onreadystatechange = function()
    {
	    if (http.readyState == 4)
        {
            resp = http.responseText;
            if (resp != " " && resp != "") {
                for (var i=0;i<GMarkers.length;i++)
                {
                    if (GMarkers[i].ID == PointID)
                    {
                        //new infW = new GInfoWindow(GMarkers[i],resp);
                        //map.add(infW);
                        GMarkers[i].openInfoWindow(resp);
                        vi = true;
                        break;
                    }
                }

                if (vi == false){
                   for (var i=0;i<GMarkerPlay.length;i++)
                    {
                        if (GMarkerPlay.length != 0)
                        {


                       if (GMarkerPlay[i].ID.toString() == PointID.toString())
                        {
                            //new infW = new GInfoWindow(GMarkers[i],resp);
                            //map.add(infW);
                            GMarkerPlay[i].openInfoWindow(resp);
                            vi = true;
                        }
                            }
                    }
                }

            }
        }
    }
    http.send(null);
   }


function Get_Cookie( check_name ) {
	// first we'll split this cookie up into name/value pairs
	// note: document.cookie only returns name=value, not the other components
	var a_all_cookies = document.cookie.split( ';' );
	var a_temp_cookie = '';
	var cookie_name = '';
	var cookie_value = '';
	var b_cookie_found = false; // set boolean t/f default f

	for ( i = 0; i < a_all_cookies.length; i++ )
	{
		// now we'll split apart each name=value pair
		a_temp_cookie = a_all_cookies[i].split( '=' );


		// and trim left/right whitespace while we're at it
		cookie_name = a_temp_cookie[0].replace(/^\s+|\s+$/g, '');

		// if the extracted name matches passed check_name
		if ( cookie_name == check_name )
		{
			b_cookie_found = true;
			// we need to handle case where cookie has no value but exists (no = sign, that is):
			if ( a_temp_cookie.length > 1 )
			{
				cookie_value = unescape( a_temp_cookie[1].replace(/^\s+|\s+$/g, '') );
			}
			// note that in cases where cookie is initialized but no value, null is returned
			return cookie_value;
			break;
		}
		a_temp_cookie = null;
		cookie_name = '';
	}
	if ( !b_cookie_found )
	{
		return null;
	}
}


function getAddress(overlay, latlng) {
  if (latlng != null) {
    address = latlng;
    geocoder.getLocations(latlng, showAddress);
  }
}

function showAddress(response) {
  //map.clearOverlays();
  if (!response || response.Status.code != 200) {
    alert("Status Code:" + response.Status.code);
  } else {

    place = response.Placemark[0];
    //point = new GLatLng(place.Point.coordinates[1],place.Point.coordinates[0]);
    document.getElementById("TranslatedPlace").innerHTML ="<b>"+ place.address+"</b>";

  }
}






function SendRequestPositionsToServer()
{
// the first thing which send to server .


    var imx =0;
 for (var i=0;i<GMarkers.length;i++)
 {
      if (imx < GMarkers[i].ID)
      {
          imx = GMarkers[i].ID;
      }
 }



     var http = false;
     var resp = "";
	if(navigator.appName == "Microsoft Internet Explorer") {
		http = new ActiveXObject("Microsoft.XMLHTTP");
	} else {
		http = new XMLHttpRequest();
	}
	http.open("GET", "handler.ashx?getlatestch=1&ID="+imx);
	//http.open("GET", "handler.ashx?getlatestch=1");
	http.onreadystatechange = function() {
                                if (http.readyState == 4) {
                                resp = http.responseText;
                                    if (resp != " " && resp != "") {
                                        compareUpdatedPOS(resp);
                                    }
                                }
	}
	http.send(null);

 }




function compareUpdatedPOS(NewMarker)
{

    var NewIcon = [];
    NewIcon =  NewMarker.split("?");
    for (var  i=0;i< NewIcon.length;i++)
    {
       UpdatePosition(NewIcon[i]);
    }

}





function sleep(milliseconds) {
    var start = new Date().getTime();
    while ((new Date().getTime() - start) < milliseconds) {
        // Do nothing
    }
}




function UpdatePosition(ArInf)
{
                var ArInf = ArInf.split(",");
                var MarkerIndex = 0;
                for (var i=0;i<GMarkers.length;i++)
                {
                    if (GMarkers[i].UnitID == ArInf[1])
                    {
                        MarkerIndex=i;
                    }
                }
                document.getElementById("gd_car_id").innerHTML = ArInf[1];
                document.getElementById("gd_date").innerHTML = ArInf[5];
                document.getElementById("RepDifValue").innerHTML = ArInf[4];
                document.getElementById("gd_input_id").innerHTML = ArInf[7];
                document.getElementById("gd_output_id").innerHTML = ArInf[8];
                document.getElementById("gd_en").innerHTML = ArInf[3] + " " + ArInf[2];
                document.getElementById("gd_speed").innerHTML = ArInf[6];

                GMarkers[MarkerIndex].setLatLng(new GLatLng(parseFloat(ArInf[3]),parseFloat(ArInf[2])));
                GMarkers[MarkerIndex].ID=ArInf[0];

                  for (var i = 0; i<GMarkerLabels.length;i++)
                  {
                      if (GMarkerLabels[i].UnitID == ArInf[1])
                      {
                          GMarkerLabels[i].setPoint(new GLatLng(parseFloat(ArInf[3]), parseFloat(ArInf[2])));
                      }
                  }


}


function AddNewPlayMarker(GL,ID,UnitID,SP,iID)
{
                       var blueIcon = new GIcon(G_DEFAULT_ICON);


                       if (SP =  0) {  blueIcon.image = "img/PlayGreen.png";}
                       if (SP > 0) {  blueIcon.image = "img/PlayRed.png";}
                       if (SP > 80) {  blueIcon.image = "img/PlayRed.png";}
                       markerOptions = { icon:blueIcon };
                       var gmrk = new GMarker(GL,markerOptions);
                       var gl = CreateLabelPlay(iID,GL,iID,ID);
                       gmrk.ID = ID;
                       gmrk.UnitID = ID;

                       GEvent.addListener(gmrk,"click",function()
                                {
                                    GetPosDialog(ID);
                                 });
                        GEvent.addListener(gmrk,"infowindowopen",function()
                                {
                                    geocoder.getLocations(GL, function(answer)
                                    {
                                         getAddress(map,GL);
                                     }
                                    );
                                });
                       GMarkerPlay.push(gmrk);
                       GLabelPlay.push(gl);
                       GPlayLine.insertVertex(GPlayLine.getLength,GL );
                       map.addOverlay(gmrk);
                       map.addOverlay(gl);    
}





function CreatePlayMarker(ServerResponse)
{
     {
                   var PrevMarkers = [];
                   var details = [];
                   PrevMarkers = ServerResponse.split("?");
                   CPW_Clear();
                   for (var i=0;i<PrevMarkers.length;i++)
                   {
                       details = PrevMarkers[i].split(",");
                       AddNewPlayMarker(new GLatLng(parseFloat(details[3]),parseFloat(details[2])),details[0],details[1],details[6],i);

                  }
                   if (GPlayLine.length != 0)
                   {
                       map.addOverlay(GPlayLine);
                       var bnd = SetPlayCarsBound();
                       map.setCenter(bnd.getCenter(), map.getBoundsZoomLevel(bnd));
                   }

               }

}


function getPrevWayString() {

    var UnitID = document.getElementById("txt_UnitID").value;
    var date_from = document.getElementById("ctl00_ContentPlaceHolder1_txt_from").value;
    var date_to = document.getElementById("ctl00_ContentPlaceHolder1_txt_to").value;
    var drp_value = document.getElementById("ctl00_ContentPlaceHolder1_drp_selectFilter").value;
    var drp_mass = document.getElementById("ctl00_ContentPlaceHolder1_drp_selectMass").value;
    var chk = document.getElementById("ctl00_ContentPlaceHolder1_chk_Filter").checked;
    var filterValue = document.getElementById("ctl00_ContentPlaceHolder1_txt_FilterValue").value;
        var dtf = [];
        var dtt = [];
        dtf = date_from.split(" ");
        dtt = date_to.split(" ");
        date_from = dtf[1]+" "+dtf[0];
        date_to = dtt[1]+" "+dtt[0];
    hideWayPrevGrid();

        var _http = false;
        var resp = "";
        if(navigator.appName == "Microsoft Internet Explorer"){ _http = new ActiveXObject("Microsoft.XMLHTTP"); } else { _http = new XMLHttpRequest(); }
        //@id,@gd_car_id,@gd_e,@gd_n,@gd_speed,@gd_rep_id,@gd_Input_id,@gd_Output_Id
        {
        _http.open("GET", "handler.ashx?getprvway="+UnitID+"&from="+date_from+"&_to="+date_to+"&isfilterActive="+chk+"&filter="+filterValue);
        _http.onreadystatechange=function()
        {
          if(_http.readyState == 4)    //ID, UnitID, e, n, rep_type, dt, sped, inp, out
             
           {
             resp = _http.responseText;
               if (resp!= "")
               {
                   CreatePlayMarker(resp);
                   getPrevWayStringForGrid();
               }


           }
        }
 
        _http.send(null);

        }
    }

function PointStreetNameAfterPlay()
{
    for (var i=0;i<GMarkerPlay.length;i++)
    {
        var lat = GMarkerPlay[i].getLatLng();
        geocoder.getLocations(lat,function(name)
        {
             document.getElementById("span"+i.toString()).innerHTML = name;
        })  ;
    }
}

function getPrevWayStringForGrid() {

        var UnitID = document.getElementById("txt_UnitID").value;
        var date_from = document.getElementById("ctl00_ContentPlaceHolder1_txt_from").value;
        var date_to = document.getElementById("ctl00_ContentPlaceHolder1_txt_to").value;
        var drp_value = document.getElementById("ctl00_ContentPlaceHolder1_drp_selectFilter").value;
        var drp_mass = document.getElementById("ctl00_ContentPlaceHolder1_drp_selectMass").value;
        var chk = document.getElementById("ctl00_ContentPlaceHolder1_chk_Filter").checked;
        var filterValue = document.getElementById("ctl00_ContentPlaceHolder1_txt_FilterValue").value;
        var dtf = [];
        var dtt = [];
        dtf = date_from.split(" ");
        dtt = date_to.split(" ");
        date_from = dtf[1]+" "+dtf[0];
        date_to = dtt[1]+" "+dtt[0];


        var _http = false;
        var resp = "";
        if(navigator.appName == "Microsoft Internet Explorer"){ _http = new ActiveXObject("Microsoft.XMLHTTP"); } else { _http = new XMLHttpRequest(); }
        //@id,@gd_car_id,@gd_e,@gd_n,@gd_speed,@gd_rep_id,@gd_Input_id,@gd_Output_Id
        {
        _http.open("GET", "handler.ashx?getprvway="+UnitID+"&from="+date_from+"&_to="+date_to+"&isfilterActive="+chk+"&filter="+filterValue);
        _http.onreadystatechange=function()
        {
          if(_http.readyState == 4)
           {
             resp = _http.responseText;
                //ID, UnitID, e, n, rep_type, dt, sped, inp, out
              if (resp!="")
              {
                  var PrevMarkers = [];
                  var posarr = [];
                  PrevMarkers = resp.split("?");
                  //CPW_Clear();
                  for (var i=0;i<PrevMarkers.length;i++)
                  {


                     posarr = PrevMarkers[i].split(",");
                   //   var str = posarr[2]+" "+posarr[3]+" | کد گزارش"+ " "+posarr[4]+" "+"|  "+posarr[5]+" ورودی و خروجی"+ posarr[6]+","+posarr[7];
                      var str = posarr[2]+"    "+posarr[3]+ "<span id=\"span"+i.toString()+"\" name=\"span"+i.toString()+"\" > </span><br/>  <b>"+posarr[4]+"</b>    "+posarr[5]+"<br/>"+ posarr[6]+"    "+posarr[7];
                                                            str = "<b>"+i.toString()+"</b><br/>"+str;
                     var astr = "<a href='javascript:ShowPosition("+posarr[0]+",true)'>...</a>";
                      var tstr =  tstr +
                             "<tr><td>"+str+astr+"<hr/></td></tr>";

                  }

                  if (GPlayLine.getLength != 0) { map.addOverlay(GPlayLine);}
                  if (str.length != 0)
                  {
                      tstr = "<table class=tbl_PrevWay width=100%>"+tstr+"</table>"
                      if (document.getElementById("PrevWayGridDivChild") != undefined)
                      document.getElementById("PrevWayGridDivChild").innerHTML=tstr;
                      ShowWayPrevGrid();
                  }

               } else {alert("موقعیتی یافت نشد لطفا تاریخ را اصلاح کنید")}

           }
        }
        _http.send(null);

        }



    }

function SetPlayCarsBound() {
    
    var bounds = new GLatLngBounds();
    
    for (var i = 0; i < GMarkerPlay.length; i++) {
        //var gp = GMarkers[i].getLatLng()
        bounds.extend(
                      GMarkerPlay[i].getLatLng()     );
}
return bounds;
}



// This is for Car Animated Icon
//----------------------------------------------
//-----------------------------------------------
// animated car :))






 Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};


var dirn = new GDirections();
      var step = 30; // metres
      var tick = 5; // milliseconds
      var poly;
      var poly2;
      var lastVertex = 0;
      var eol;
      var car = new GIcon();
          car.image="caricon.png"
          car.iconSize=new GSize(32,18);
          car.iconAnchor=new GPoint(16,9);
      var marker;
      var k=0;
      var stepnum=0;
      var speed = "";
      var PrevWayCount=0;
      var PrePassedWay = 0; // this variable is used for counting Directions Limitation .
      var PrePassedWayTempArray = new Array;


var prevMarkerCountPerSection = 20;

//  This function is used for drawing the necessary lines in prevuewing a way .
function updatePoly(d) {
  // Spawn a new polyline every 20 vertices, because updating a 100-vertex poly is too slow
  if (poly2.getVertexCount() > 20) {
    poly2=new GPolyline([poly.getVertex(lastVertex-1)]);
    map.addOverlay(poly2)
  }

  if (poly.GetIndexAtDistance(d) < lastVertex+2) {
     if (poly2.getVertexCount()>1) {
       poly2.deleteVertex(poly2.getVertexCount()-1)
     }
     poly2.insertVertex(poly2.getVertexCount(),poly.GetPointAtDistance(d));
  } else {
    poly2.insertVertex(poly2.getVertexCount(),poly.getVertex(lastVertex++));
  }
}
var stop = false;
function animate(d) {


  if (d>eol) {
      // here trip gets completed ;)
      //PrePassedWay+=1;
      //PrePassedWay must by ZERO when play gets completed
      if (PrePassedWay < PrevWayCount)
      {

          PrePassedWayTempArray.remove(0,prevMarkerCountPerSection-3);

          //map.removeOverlay(poly2);
          //map.removeOverlay(poly);

          if (PrePassedWay+1 < PrevWayCount)
          {
          map.removeOverlay(marker);
           }
          lastVertex = 0;
          k=0;
          stepnum=0;
          start();

      }


    //document.getElementById("step").innerHTML = "<b>Trip completed<\/b>";
    //document.getElementById("distance").innerHTML =  "Miles: "+(d/1609.344).toFixed(2);
    return;
  }



    step = parseInt( document.getElementById("ctl00_ContentPlaceHolder1_txt_play_speed").value );

  var p = poly.GetPointAtDistance(d);
  if (k++>=180/step) {
    map.panTo(p);
    k=0;
  }
  marker.setPoint(p);
  //document.getElementById("distance").innerHTML =  "Miles: "+(d/1609.344).toFixed(2)+speed;
  if (stepnum+1 < dirn.getRoute(0).getNumSteps()) {
    if (dirn.getRoute(0).getStep(stepnum).getPolylineIndex() < poly.GetIndexAtDistance(d)) {
      stepnum++;
      var steptext = dirn.getRoute(0).getStep(stepnum).getDescriptionHtml();
//      document.getElementById("step").innerHTML = "<b>Next:<\/b> "+steptext;
      var stepdist = dirn.getRoute(0).getStep(stepnum-1).getDistance().meters;
      var steptime = dirn.getRoute(0).getStep(stepnum-1).getDuration().seconds;
      var stepspeed = ((stepdist/steptime) * 2.24).toFixed(0);
      step = stepspeed/2.5;
      speed = "<br>Current speed: " + stepspeed +" mph";
    }
  } else {
    if (dirn.getRoute(0).getStep(stepnum).getPolylineIndex() < poly.GetIndexAtDistance(d)) {
    //  document.getElementById("step").innerHTML = "<b>Next: Arrive at your destination<\/b>";
       
    }
  }
  updatePoly(d);
    preAnimatedD = d+step;
  setTimeout("animate("+(d+step)+")", tick);

  
}
GEvent.addListener(dirn,"load", function() {
  //document.getElementById("controls").style.display="none";
  poly=dirn.getPolyline();
  eol=poly.Distance();
  //map.setCenter(poly.getVertex(0),17);
  map.addOverlay(new GMarker(poly.getVertex(0),G_START_ICON));
  map.addOverlay(new GMarker(poly.getVertex(poly.getVertexCount()-1),G_END_ICON));
  marker = new GMarker(poly.getVertex(0),{icon:car});
  map.addOverlay(marker);
  var steptext = dirn.getRoute(0).getStep(stepnum).getDescriptionHtml();
  //document.getElementById("step").innerHTML = steptext;
  poly2 = new GPolyline([poly.getVertex(0)]);
  map.addOverlay(poly2);
  setTimeout("animate(0)",10);  // Allow time for the initial map display
});
function start() {

    //PrevWayCount = 0;
    PrevWayCount = GMarkerPlay.length / prevMarkerCountPerSection;
    PrevWayCount +=1;
    var waysStrPoints = new Array();

    if (PrePassedWay == 0)
    {
        PrePassedWayTempArray.length=0;
        for (var i=0;i<GMarkerPlay.length;i++)
       {
               PrePassedWayTempArray.push(GMarkerPlay[i].getLatLng().lat().toString()+","+GMarkerPlay[i].getLatLng().lng().toString());
       }
     }

    for (var i=0;i<prevMarkerCountPerSection;i++)
    {
        if (i<PrePassedWayTempArray.length)
        {
            waysStrPoints.push(PrePassedWayTempArray[i]);
        }
    }



 PrePassedWay += 1;
dirn.loadFromWaypoints(waysStrPoints,{getPolyline:true,getSteps:true});
}




var prevTick;
var preAnimatedD;
var elat = 0.0;
var elng = 0.0;
var NodeName = "Tttt";
var layerID = 1;
var __lat=0.0;
var __lng = 0.0;




function __stop(_ok)
{
    if (_ok == 1)
        {
            prevTick = tick;
            tick=9999999;
        }
    if (_ok == 0)
        {
             tick= prevTick;
             animate(preAnimatedD);
                    
         }

}
//  functions if reports
function checkAllReportIDChecks()
{
   var chks = new Array();
   chks = document.getElementsByClassName("CheckBoxRepID");
    var bl = document.getElementById("chk_all_repid");
    for (var i=0;i<chks.length;i++)
    {
        chks[i].checked = bl.checked;
    }
}






function getNecInfoForReport()
{
    var chk_filter_reportID = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_filter_io").checked;
    var dtFrom = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_from").value;
    var dtTo = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_to").value;
    var chk_ibit0 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit0_ignition").checked;
    var chk_ibit1 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit1_input1").checked;
    var chk_ibit2 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit2_input2").checked;
    var chk_ibit3 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit3_input3").checked;
    var chk_ibit4 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit4_input4").checked;
    var chk_obit1 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit1_output1").checked;
    var chk_obit2 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit2_output2").checked;
    var chk_obit3 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit3_output3").checked;
    var chk_obit4 = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_bit4_output4").checked;
    var chk_chk_filter_speed = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_filter_speed").checked;
    var drp_speed_select_arrows = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_drp_speed_select_arrows").value;
    var txt_speed_km = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_speed_km").value;
    var chk_filter_geo = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_chk_filter_geo").checked;
    var txt_geo_center_name = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_geo_center_name").value;
    var txt_geo_center_km = document.getElementById("ctl00_ContentPlaceHolder1_ctl00_txt_geo_center_km").value;
    var txt_selectedTree = "";



    var chks = new Array();
    chks = document.getElementsByClassName("CheckBoxRepID");
     var bl = document.getElementById("chk_all_repid");
    var chkRepIdLists = "";
     for (var i=0;i<chks.length;i++)
     {
         if (chks[i].checked)
         {
             if (chkRepIdLists!="")
             {
                 chkRepIdLists=chkRepIdLists+'-'+chks[i].id;
             }   else
             {
                 chkRepIdLists=chks[i].id;
             }
         }
     }


    // pay attention do not use 'x' in naming groups . 
    for (var x=0;x<selectedCars.length;x++)
    {
       txt_selectedTree+= "x"+selectedCars[x];
    }



    // now creating the query strings
    var stringQuery = "tp=prvw&chksen="+chkRepIdLists+"&cfr="+chk_filter_reportID+"&df="+dtFrom+"&dt="+dtTo+"&ci0="+chk_ibit0+"&ci1="+chk_ibit1+"&ci2="+chk_ibit2+
    "&ci3="+chk_ibit3+"&ci4="+chk_ibit4+"&co1="+chk_obit1+"&co2="+chk_obit2+"&co3="+
            chk_obit3+"&co4="+chk_obit4+"&cfs="+chk_chk_filter_speed+"&cssg="+drp_speed_select_arrows+
            "&tsk="+txt_speed_km+"&cfgeo="+chk_filter_geo+"&cgcn="+txt_geo_center_name+
            "&gck="+txt_geo_center_km+"&selcar="+txt_selectedTree;
    
    //alert(stringQuery);
    if (txt_selectedTree.length == 0) {
        alert("لطفا حداقل یکی از وسائط نقلیه رو انتخاب کنید");
        return;

    }
    //document.getElementById("div_ReportRepresentor").innerHTML = "<img src=''></img>";
    ajaxpage("loader.aspx?pid=15&" + stringQuery, "div_ReportRepresentor");


    

    //chk_filter_reportID = document.getElementById()
}

var POI_ID = 0;
function SetActiveNodeID(PointID,nodename)
{

var NodeName =nodename;
 POI_ID = PointID;
    layerID = POI_ID;

           var http = false;
        var resp = "";
        if (navigator.appName == "Microsoft Internet Explorer") {
            http = new ActiveXObject("Microsoft.XMLHTTP");
        } else {
            http = new XMLHttpRequest();
        }
        http.open("GET", "Handler.ashx?getfrmunderpoidiv=" + layerID.toString()+"&oi="+Get_Cookie("OwnerID") );
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                resp = http.responseText;
                if (resp != " " && resp != "") {
                   document.getElementById("div_poi_list").innerHTML = resp;
                    CallPointOfIntr(layerID);
                }
            }
        }
        http.send(null);
}

function CallPointOfIntr(LayerID) {      

ClearPOI();
    var str = "";
     var http = false;
        var resp = "";
        if (navigator.appName == "Microsoft Internet Explorer") {
            http = new ActiveXObject("Microsoft.XMLHTTP");
        } else {
            http = new XMLHttpRequest();
        }
        http.open("GET", "Handler.ashx?gvmepoimrklist=" + layerID.toString() );
        http.onreadystatechange = function() {
            if (http.readyState == 4) {
                resp = http.responseText;
                if (resp != " " && resp != "") {

                   CreatePOIMarkerAccordingToLayerID(resp);






                }
            }
        }
        http.send(null);

    return str;
}

var POIMarker = new Array();
var POIELable = new Array();
function mapSingleRightClick(point, src, overlay) {

    var latlng = _map.fromContainerPixelToLatLng(point);
    var marker = new GMarker(latlng, { draggable: true });
    marker.id="";
//        GEvent.addListener(marker, "click", POIClick);
    GEvent.addListener(marker, "click",POIClick);
    GEvent.addListener(marker , "dragstart", function() {
  _map.closeInfoWindow();
  });

GEvent.addListener(marker , "dragend", MarkerPOIDragEnd);   

    gmrk = marker;
    _map.addOverlay(marker);

}

function POIClick(latlng) {

    gmrk = this;
    POICurrentSelectedPointID = gmrk.ID;

    if (POICurrentSelectedPointID== undefined)
    {
        POICurrentSelectedPointID = -1;
    }


if (layerID != 0)
{
    __lat = latlng.lat();
    __lng = latlng.lng();
    elat = __lat;
    elng = __lng;

    // Requesting the page

    var http = false;
    var resp = "";
    if (navigator.appName == "Microsoft Internet Explorer") {
        http = new ActiveXObject("Microsoft.XMLHTTP");
    } else {
        http = new XMLHttpRequest();
    }
    http.open("GET", "Handler.ashx?getfrmunderpoi=" + layerID.toString() + "&pid="+POICurrentSelectedPointID+"&lat=" + gmrk.getLatLng().lat() + "&lng="+gmrk.getLatLng().lng());
    http.onreadystatechange = function() {
        if (http.readyState == 4) {
            resp = http.responseText;
            if (resp != " " && resp != "") {
                gmrk.openInfoWindowHtml(resp);

            }
        }
    }
    http.send(null);
}
else {
alert("لطفا لایه مورد را انتخاب کرده سپس اقدام به ایجاد نقطه نمایید");
}


    try
  {
    POICurrentSelectedPointID = gmrk.ID;
  }
catch(err)
  {
   POICurrentSelectedPointID = -1;
  }

    if (POICurrentSelectedPointID == undefined)
    {
       POICurrentSelectedPointID = -1; 
    }


    

}

function ClearPOI()
{
                    for (var i = 0; i < POIMarker.length; i++) {
                    _map.removeOverlay(POIMarker[i]);
                }
                POIMarker.length = 0;
    POIELable.length=0;
    _map.clearOverlays();
}


function CreatePOIMarkerAccordingToLayerID(hasedstr)
{
                if (hasedstr != " " && hasedstr != "") {
                    var arr = new Array();
                    var are = new Array();
                    arr = hasedstr.split("?");
                    for (var i = 0; i < arr.length; i++) {
                        are = arr[i].split(",");
                        CreatePOIMarker(are[0], are[1], are[2], are[3], are[4], are[5], are[6])
                        //"p_e""p_n""p_nf_name""poi_layer_link""p_color"
                    }
                }
}

function CreatePOIMarker(p_e,p_n,p_nf_name,poi_layer_link,p_color,p_id,p_shopname)
{
    var pnt = new GLatLng(parseFloat(p_n),parseFloat(p_e));
    var mrk = new GMarker(pnt,{draggable: true});
    mrk.ID = p_id;
    
    //mrk.PointID = UnitID;
    GEvent.addListener(mrk,"click",POIClick);


GEvent.addListener(mrk , "dragstart", function() {
  _map.closeInfoWindow();
  });

GEvent.addListener(mrk , "dragend", MarkerPOIDragEnd);
    

    POIMarker.push(mrk);

    CreatePOILabel(mrk.getLatLng(),p_nf_name,p_shopname,p_id);
    _map.addOverlay(POIMarker[POIMarker.length - 1]);
}



function SendStrToServer(str)
{
    var http = false;
       var resp = "";
       if (navigator.appName == "Microsoft Internet Explorer") {
           http = new ActiveXObject("Microsoft.XMLHTTP");
       } else {
           http = new XMLHttpRequest();
       }
       http.open("GET", str );
       http.onreadystatechange = function() {
           if (http.readyState == 4) {
               resp = http.responseText;
               if (resp != " " && resp != "") {
               
               
              }
           }
       }
       http.send(null);

}

function DetectPOIMarkerID(mrk)
{
     try
        {
          POICurrentSelectedPointID = gmrk.ID;
        }
     catch(err)
        {
         POICurrentSelectedPointID = -1;
        }

      if (POICurrentSelectedPointID == undefined)
          {
             POICurrentSelectedPointID = -1;
          }

   return POICurrentSelectedPointID;
}

function UpdatePositionOnELabelOfPOI(LabelPointID,latlng)
{
    if (POIELable.length!= 0)
    {
        for (var i=0;i<POIELable.length;i++)
        {
            if (POIELable[i].ID == LabelPointID)
            {
                 POIELable[i].setPoint(latlng);
            }
        }
    }

}

function MarkerPOIDragEnd(latlng)
{
   // first i must to handle the label to move with icon
    gmrk = this;
   POICurrentSelectedPointID = DetectPOIMarkerID(gmrk);

    if (POICurrentSelectedPointID != -1)
    {
        var _e = latlng.lng();
        var _n = latlng.lat();
        SendStrToServer("handler.ashx?updpoi="+POICurrentSelectedPointID+"&e="+_e+"&n="+_n);
        UpdatePositionOnELabelOfPOI(POICurrentSelectedPointID,latlng);
        
    }

}
var POICurrentSelectedPointID = -1;

function CreatePOILabel(latlngpoi,name,shopname,p_id)
{
    if (p_id != undefined)
    {

       var lbl = CreateLabelPoi(p_id,latlngpoi,name+" "+shopname,POIELable.length,name);
       POIELable.push(lbl);
      _map.addOverlay(lbl);

    }

}


function UpdateELabelPOICaption(poiID,NewCaption)
{
       if (POIELable.length!= 0)
    {
        for (var i=0;i<POIELable.length;i++)
        {
            if (POIELable[i].ID == poiID)
            {
                 POIELable[i].setContents(NewCaption);
            }
        }
    }
    if (poiID == -1 )
    {
        CreateLabelPoi(gmrk.ID,gmrk.getLatLng(),NewCaption,gmrk.ID,NewCaption);
    }
}









//--------------------------------------------------------------------------
// best way detector :

function DetectedTheBestayBetweenPOIs()
{
    var POIMarkersCount = POIMarker.length;
    var whichPOItoStart = 60;
    var firstMarker;
    // selecting current poi
    for (var i =0;i<POIMarkersCount;i++)
    {
       if (POIMarker[i].ID == whichPOItoStart)
       {
           firstMarker = POIMarker[i];
          // break;
       }
    }
    // the first poi was selected
    POITempTwoLatLngArray = new Array();
    var drn = new GDirections();

    GEvent.addListener(drn , "load", function(){
        
       var ds =drn.getDistance().meters;
       alert(ds.toString());
        
    });


   // for (var i =0;i<POIMarkersCount;i++)
     for (var i =0;i<2;i++)
          {
      //  POITempTwoLatLngArray.length = 0;
       
       // if (POIMarker[i].ID != whichPOItoStart)  // it means plz do not check ur self .
        {
            POITempTwoLatLngArray.push(POIMarker[i].getLatLng().lat().toString()+","+POIMarker[i].getLatLng().lng().toString());
        }
    }

    drn.loadFromWaypoints(POITempTwoLatLngArray);


}