i;8;CPFont.ji;10;CPShadow.ji;8;CPView.jc;25045;
CPLeftTextAlignment = 0;
CPRightTextAlignment = 1;
CPCenterTextAlignment = 2;
CPJustifiedTextAlignment = 3;
CPNaturalTextAlignment = 4;
CPRegularControlSize = 0;
CPSmallControlSize = 1;
CPMiniControlSize = 2;
CPControlNormalBackgroundColor = "CPControlNormalBackgroundColor";
CPControlSelectedBackgroundColor = "CPControlSelectedBackgroundColor";
CPControlHighlightedBackgroundColor = "CPControlHighlightedBackgroundColor";
CPControlDisabledBackgroundColor = "CPControlDisabledBackgroundColor";
CPControlTextDidBeginEditingNotification = "CPControlTextDidBeginEditingNotification";
CPControlTextDidChangeNotification = "CPControlTextDidChangeNotification";
CPControlTextDidEndEditingNotification = "CPControlTextDidEndEditingNotification";
var CPControlBlackColor = objj_msgSend(CPColor, "blackColor");
{var the_class = objj_allocateClassPair(CPView, "CPControl"),
meta_class = the_class.isa;class_addIvars(the_class, [new objj_ivar("_value"), new objj_ivar("_target"), new objj_ivar("_action"), new objj_ivar("_sendActionOn"), new objj_ivar("_continuousTracking"), new objj_ivar("_trackingWasWithinFrame"), new objj_ivar("_trackingMouseDownFlags"), new objj_ivar("_previousTrackingLocation"), new objj_ivar("_ephemeralSubviewsForNames"), new objj_ivar("_ephereralSubviews"), new objj_ivar("_toolTip")]);
objj_registerClassPair(the_class);
objj_addClassForBundle(the_class, objj_getBundleWithPath(OBJJ_CURRENT_BUNDLE.path));
class_addMethods(the_class, [new objj_method(sel_getUid("initWithFrame:"), function $CPControl__initWithFrame_(self, _cmd, aFrame)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPView") }, "initWithFrame:", aFrame);
    if (self)
    {
        _sendActionOn = CPLeftMouseUpMask;
        _trackingMouseDownFlags = 0;
    }
    return self;
}
}), new objj_method(sel_getUid("setAction:"), function $CPControl__setAction_(self, _cmd, anAction)
{ with(self)
{
    _action = anAction;
}
}), new objj_method(sel_getUid("action"), function $CPControl__action(self, _cmd)
{ with(self)
{
    return _action;
}
}), new objj_method(sel_getUid("setTarget:"), function $CPControl__setTarget_(self, _cmd, aTarget)
{ with(self)
{
    _target = aTarget;
}
}), new objj_method(sel_getUid("target"), function $CPControl__target(self, _cmd)
{ with(self)
{
    return _target;
}
}), new objj_method(sel_getUid("sendAction:to:"), function $CPControl__sendAction_to_(self, _cmd, anAction, anObject)
{ with(self)
{
    objj_msgSend(CPApp, "sendAction:to:from:", anAction, anObject, self);
}
}), new objj_method(sel_getUid("sendActionOn:"), function $CPControl__sendActionOn_(self, _cmd, mask)
{ with(self)
{
    var previousMask = _sendActionOn;
    _sendActionOn = mask;
    return previousMask;
}
}), new objj_method(sel_getUid("isContinuous"), function $CPControl__isContinuous(self, _cmd)
{ with(self)
{
    return (_sendActionOn & CPPeriodicMask) !== 0;
}
}), new objj_method(sel_getUid("setContinuous:"), function $CPControl__setContinuous_(self, _cmd, flag)
{ with(self)
{
    if (flag)
        _sendActionOn |= CPPeriodicMask;
    else
        _sendActionOn &= ~CPPeriodicMask;
}
}), new objj_method(sel_getUid("tracksMouseOutsideOfFrame"), function $CPControl__tracksMouseOutsideOfFrame(self, _cmd)
{ with(self)
{
    return NO;
}
}), new objj_method(sel_getUid("trackMouse:"), function $CPControl__trackMouse_(self, _cmd, anEvent)
{ with(self)
{
    var type = objj_msgSend(anEvent, "type"),
        currentLocation = objj_msgSend(self, "convertPoint:fromView:", objj_msgSend(anEvent, "locationInWindow"), nil);
        isWithinFrame = objj_msgSend(self, "tracksMouseOutsideOfFrame") || CGRectContainsPoint(objj_msgSend(self, "bounds"), currentLocation);
    if (type === CPLeftMouseUp)
    {
        objj_msgSend(self, "stopTracking:at:mouseIsUp:", _previousTrackingLocation, currentLocation, YES);
        _trackingMouseDownFlags = 0;
    }
    else
    {
        if (type === CPLeftMouseDown)
        {
            _trackingMouseDownFlags = objj_msgSend(anEvent, "modifierFlags");
            _continuousTracking = objj_msgSend(self, "startTrackingAt:", currentLocation);
        }
        else if (type === CPLeftMouseDragged)
        {
            if (isWithinFrame)
            {
                if (!_trackingWasWithinFrame)
                    _continuousTracking = objj_msgSend(self, "startTrackingAt:", currentLocation);
                else if (_continuousTracking)
                    _continuousTracking = objj_msgSend(self, "continueTracking:at:", _previousTrackingLocation, currentLocation);
            }
            else
                objj_msgSend(self, "stopTracking:at:mouseIsUp:", _previousTrackingLocation, currentLocation, NO);
        }
        objj_msgSend(CPApp, "setTarget:selector:forNextEventMatchingMask:untilDate:inMode:dequeue:", self, sel_getUid("trackMouse:"), CPLeftMouseDraggedMask | CPLeftMouseUpMask, nil, nil, YES);
    }
    if ((_sendActionOn & (1 << type)) && isWithinFrame)
        objj_msgSend(self, "sendAction:to:", _action, _target);
    _trackingWasWithinFrame = isWithinFrame;
    _previousTrackingLocation = currentLocation;
}
}), new objj_method(sel_getUid("performClick:"), function $CPControl__performClick_(self, _cmd, sender)
{ with(self)
{
    objj_msgSend(self, "highlight:", YES);
    objj_msgSend(self, "setState:", objj_msgSend(self, "nextState"));
    objj_msgSend(self, "sendAction:to:", objj_msgSend(self, "action"), objj_msgSend(self, "target"));
    objj_msgSend(self, "highlight:", NO);
}
}), new objj_method(sel_getUid("mouseDownFlags"), function $CPControl__mouseDownFlags(self, _cmd)
{ with(self)
{
    return _trackingMouseDownFlags;
}
}), new objj_method(sel_getUid("startTrackingAt:"), function $CPControl__startTrackingAt_(self, _cmd, aPoint)
{ with(self)
{
    objj_msgSend(self, "highlight:", YES);
    return (_sendActionOn & CPPeriodicMask) || (_sendActionOn & CPLeftMouseDraggedMask);
}
}), new objj_method(sel_getUid("continueTracking:at:"), function $CPControl__continueTracking_at_(self, _cmd, lastPoint, aPoint)
{ with(self)
{
    return (_sendActionOn & CPPeriodicMask) || (_sendActionOn & CPLeftMouseDraggedMask);
}
}), new objj_method(sel_getUid("stopTracking:at:mouseIsUp:"), function $CPControl__stopTracking_at_mouseIsUp_(self, _cmd, lastPoint, aPoint, mouseIsUp)
{ with(self)
{
    objj_msgSend(self, "highlight:", NO);
}
}), new objj_method(sel_getUid("mouseDown:"), function $CPControl__mouseDown_(self, _cmd, anEvent)
{ with(self)
{
    if (!objj_msgSend(self, "isEnabled"))
        return;
    objj_msgSend(self, "trackMouse:", anEvent);
}
}), new objj_method(sel_getUid("objectValue"), function $CPControl__objectValue(self, _cmd)
{ with(self)
{
    return _value;
}
}), new objj_method(sel_getUid("setObjectValue:"), function $CPControl__setObjectValue_(self, _cmd, anObject)
{ with(self)
{
    _value = anObject;
    objj_msgSend(self, "setNeedsLayout");
    objj_msgSend(self, "setNeedsDisplay:", YES);
}
}), new objj_method(sel_getUid("floatValue"), function $CPControl__floatValue(self, _cmd)
{ with(self)
{
    var floatValue = parseFloat(_value, 10);
    return isNaN(floatValue) ? 0.0 : floatValue;
}
}), new objj_method(sel_getUid("setFloatValue:"), function $CPControl__setFloatValue_(self, _cmd, aValue)
{ with(self)
{
    objj_msgSend(self, "setObjectValue:", aValue);
}
}), new objj_method(sel_getUid("doubleValue"), function $CPControl__doubleValue(self, _cmd)
{ with(self)
{
    var doubleValue = parseFloat(_value, 10);
    return isNaN(doubleValue) ? 0.0 : doubleValue;
}
}), new objj_method(sel_getUid("setDoubleValue:"), function $CPControl__setDoubleValue_(self, _cmd, anObject)
{ with(self)
{
    objj_msgSend(self, "setObjectValue:", anObject);
}
}), new objj_method(sel_getUid("intValue"), function $CPControl__intValue(self, _cmd)
{ with(self)
{
    var intValue = parseInt(_value, 10);
    return isNaN(intValue) ? 0.0 : intValue;
}
}), new objj_method(sel_getUid("setIntValue:"), function $CPControl__setIntValue_(self, _cmd, anObject)
{ with(self)
{
    objj_msgSend(self, "setObjectValue:", anObject);
}
}), new objj_method(sel_getUid("integerValue"), function $CPControl__integerValue(self, _cmd)
{ with(self)
{
    var intValue = parseInt(_value, 10);
    return isNaN(intValue) ? 0.0 : intValue;
}
}), new objj_method(sel_getUid("setIntegerValue:"), function $CPControl__setIntegerValue_(self, _cmd, anObject)
{ with(self)
{
    objj_msgSend(self, "setObjectValue:", anObject);
}
}), new objj_method(sel_getUid("stringValue"), function $CPControl__stringValue(self, _cmd)
{ with(self)
{
    return (_value === undefined || _value === nil) ? "" : String(_value);
}
}), new objj_method(sel_getUid("setStringValue:"), function $CPControl__setStringValue_(self, _cmd, anObject)
{ with(self)
{
    objj_msgSend(self, "setObjectValue:", anObject);
}
}), new objj_method(sel_getUid("takeDoubleValueFrom:"), function $CPControl__takeDoubleValueFrom_(self, _cmd, sender)
{ with(self)
{
    if (objj_msgSend(sender, "respondsToSelector:", sel_getUid("doubleValue")))
        objj_msgSend(self, "setDoubleValue:", objj_msgSend(sender, "doubleValue"));
}
}), new objj_method(sel_getUid("takeFloatValueFrom:"), function $CPControl__takeFloatValueFrom_(self, _cmd, sender)
{ with(self)
{
    if (objj_msgSend(sender, "respondsToSelector:", sel_getUid("floatValue")))
        objj_msgSend(self, "setFloatValue:", objj_msgSend(sender, "floatValue"));
}
}), new objj_method(sel_getUid("takeIntegerValueFrom:"), function $CPControl__takeIntegerValueFrom_(self, _cmd, sender)
{ with(self)
{
    if (objj_msgSend(sender, "respondsToSelector:", sel_getUid("integerValue")))
        objj_msgSend(self, "setIntegerValue:", objj_msgSend(sender, "integerValue"));
}
}), new objj_method(sel_getUid("takeIntValueFrom:"), function $CPControl__takeIntValueFrom_(self, _cmd, sender)
{ with(self)
{
    if (objj_msgSend(sender, "respondsToSelector:", sel_getUid("intValue")))
        objj_msgSend(self, "setIntValue:", objj_msgSend(sender, "intValue"));
}
}), new objj_method(sel_getUid("takeObjectValueFrom:"), function $CPControl__takeObjectValueFrom_(self, _cmd, sender)
{ with(self)
{
    if (objj_msgSend(sender, "respondsToSelector:", sel_getUid("objectValue")))
        objj_msgSend(self, "setObjectValue:", objj_msgSend(sender, "objectValue"));
}
}), new objj_method(sel_getUid("takeStringValueFrom:"), function $CPControl__takeStringValueFrom_(self, _cmd, sender)
{ with(self)
{
    if (objj_msgSend(sender, "respondsToSelector:", sel_getUid("stringValue")))
        objj_msgSend(self, "setStringValue:", objj_msgSend(sender, "stringValue"));
}
}), new objj_method(sel_getUid("textDidBeginEditing:"), function $CPControl__textDidBeginEditing_(self, _cmd, note)
{ with(self)
{
    if(objj_msgSend(note, "object") != self)
        return;
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:userInfo:", CPControlTextDidBeginEditingNotification, self, objj_msgSend(CPDictionary, "dictionaryWithObject:forKey:", objj_msgSend(note, "object"), "CPFieldEditor"));
}
}), new objj_method(sel_getUid("textDidChange:"), function $CPControl__textDidChange_(self, _cmd, note)
{ with(self)
{
    if(objj_msgSend(note, "object") != self)
        return;
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:userInfo:", CPControlTextDidChangeNotification, self, objj_msgSend(CPDictionary, "dictionaryWithObject:forKey:", objj_msgSend(note, "object"), "CPFieldEditor"));
}
}), new objj_method(sel_getUid("textDidEndEditing:"), function $CPControl__textDidEndEditing_(self, _cmd, note)
{ with(self)
{
    if(objj_msgSend(note, "object") != self)
        return;
    objj_msgSend(objj_msgSend(CPNotificationCenter, "defaultCenter"), "postNotificationName:object:userInfo:", CPControlTextDidEndEditingNotification, self, objj_msgSend(CPDictionary, "dictionaryWithObject:forKey:", objj_msgSend(note, "object"), "CPFieldEditor"));
}
}), new objj_method(sel_getUid("setAlignment:"), function $CPControl__setAlignment_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "alignment");}
}), new objj_method(sel_getUid("alignment"), function $CPControl__alignment(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "alignment");}
}), new objj_method(sel_getUid("setVerticalAlignment:"), function $CPControl__setVerticalAlignment_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "vertical-alignment");}
}), new objj_method(sel_getUid("verticalAlignment"), function $CPControl__verticalAlignment(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "vertical-alignment");}
}), new objj_method(sel_getUid("setLineBreakMode:"), function $CPControl__setLineBreakMode_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "line-break-mode");}
}), new objj_method(sel_getUid("lineBreakMode"), function $CPControl__lineBreakMode(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "line-break-mode");}
}), new objj_method(sel_getUid("setTextColor:"), function $CPControl__setTextColor_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "text-color");}
}), new objj_method(sel_getUid("textColor"), function $CPControl__textColor(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "text-color");}
}), new objj_method(sel_getUid("setFont:"), function $CPControl__setFont_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "font");}
}), new objj_method(sel_getUid("font"), function $CPControl__font(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "font");}
}), new objj_method(sel_getUid("setTextShadowColor:"), function $CPControl__setTextShadowColor_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "text-shadow-color");}
}), new objj_method(sel_getUid("textShadowColor"), function $CPControl__textShadowColor(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "text-shadow-color");}
}), new objj_method(sel_getUid("setTextShadowOffset:"), function $CPControl__setTextShadowOffset_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "text-shadow-offset");}
}), new objj_method(sel_getUid("textShadowOffset"), function $CPControl__textShadowOffset(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "text-shadow-offset");}
}), new objj_method(sel_getUid("setImagePosition:"), function $CPControl__setImagePosition_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "image-position");}
}), new objj_method(sel_getUid("imagePosition"), function $CPControl__imagePosition(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "image-position");}
}), new objj_method(sel_getUid("setImageScaling:"), function $CPControl__setImageScaling_(self, _cmd, aValue)
{ with(self)
{objj_msgSend(self, "setValue:forThemeAttribute:", aValue, "image-scaling");}
}), new objj_method(sel_getUid("imageScaling"), function $CPControl__imageScaling(self, _cmd)
{ with(self)
{return objj_msgSend(self, "valueForThemeAttribute:", "image-scaling");}
}), new objj_method(sel_getUid("setEnabled:"), function $CPControl__setEnabled_(self, _cmd, isEnabled)
{ with(self)
{
    if (isEnabled)
        objj_msgSend(self, "unsetThemeState:", CPThemeStateDisabled);
    else
        objj_msgSend(self, "setThemeState:", CPThemeStateDisabled);
}
}), new objj_method(sel_getUid("isEnabled"), function $CPControl__isEnabled(self, _cmd)
{ with(self)
{
    return !objj_msgSend(self, "hasThemeState:", CPThemeStateDisabled);
}
}), new objj_method(sel_getUid("highlight:"), function $CPControl__highlight_(self, _cmd, shouldHighlight)
{ with(self)
{
    objj_msgSend(self, "setHighlighted:", shouldHighlight);
}
}), new objj_method(sel_getUid("setHighlighted:"), function $CPControl__setHighlighted_(self, _cmd, isHighlighted)
{ with(self)
{
    if (isHighlighted)
        objj_msgSend(self, "setThemeState:", CPThemeStateHighlighted);
    else
        objj_msgSend(self, "unsetThemeState:", CPThemeStateHighlighted);
}
}), new objj_method(sel_getUid("isHighlighted"), function $CPControl__isHighlighted(self, _cmd)
{ with(self)
{
    return objj_msgSend(self, "hasThemeState:", CPThemeStateHighlighted);
}
}), new objj_method(sel_getUid("createEphemeralSubviewNamed:"), function $CPControl__createEphemeralSubviewNamed_(self, _cmd, aViewName)
{ with(self)
{
    return nil;
}
}), new objj_method(sel_getUid("rectForEphemeralSubviewNamed:"), function $CPControl__rectForEphemeralSubviewNamed_(self, _cmd, aViewName)
{ with(self)
{
    return { origin: { x:0.0, y:0.0 }, size: { width:0.0, height:0.0 } };
}
}), new objj_method(sel_getUid("layoutEphemeralSubviewNamed:positioned:relativeToEphemeralSubviewNamed:"), function $CPControl__layoutEphemeralSubviewNamed_positioned_relativeToEphemeralSubviewNamed_(self, _cmd, aViewName, anOrderingMode, relativeToViewName)
{ with(self)
{
    if (!_ephemeralSubviewsForNames)
    {
        _ephemeralSubviewsForNames = {};
        _ephemeralSubviews = objj_msgSend(CPSet, "set");
    }
    var frame = objj_msgSend(self, "rectForEphemeralSubviewNamed:", aViewName);
    if (frame && !(frame.size.width <= 0.0 || frame.size.height <= 0.0))
    {
        if (!_ephemeralSubviewsForNames[aViewName])
        {
            _ephemeralSubviewsForNames[aViewName] = objj_msgSend(self, "createEphemeralSubviewNamed:", aViewName);
            objj_msgSend(_ephemeralSubviews, "addObject:", _ephemeralSubviewsForNames[aViewName]);
            if (_ephemeralSubviewsForNames[aViewName])
                objj_msgSend(self, "addSubview:positioned:relativeTo:", _ephemeralSubviewsForNames[aViewName], anOrderingMode, _ephemeralSubviewsForNames[relativeToViewName]);
        }
        if (_ephemeralSubviewsForNames[aViewName])
            objj_msgSend(_ephemeralSubviewsForNames[aViewName], "setFrame:", frame);
    }
    else if (_ephemeralSubviewsForNames[aViewName])
    {
        objj_msgSend(_ephemeralSubviewsForNames[aViewName], "removeFromSuperview");
        objj_msgSend(_ephemeralSubviews, "removeObject:", _ephemeralSubviewsForNames[aViewName]);
        delete _ephemeralSubviewsForNames[aViewName];
    }
    return _ephemeralSubviewsForNames[aViewName];
}
})]);
class_addMethods(meta_class, [new objj_method(sel_getUid("themeAttributes"), function $CPControl__themeAttributes(self, _cmd)
{ with(self)
{
    return objj_msgSend(CPDictionary, "dictionaryWithObjects:forKeys:", [CPLeftTextAlignment,
                                                CPTopVerticalTextAlignment,
                                                CPLineBreakByClipping,
                                                objj_msgSend(CPColor, "blackColor"),
                                                objj_msgSend(CPFont, "systemFontOfSize:", 12.0),
                                                nil,
                                                { width:0.0, height:0.0 },
                                                CPImageLeft,
                                                CPScaleToFit,
                                                { width:0.0, height:0.0 },
                                                { width:-1.0, height:-1.0 }], ["alignment",
                                                "vertical-alignment",
                                                "line-break-mode",
                                                "text-color",
                                                "font",
                                                "text-shadow-color",
                                                "text-shadow-offset",
                                                "image-position",
                                                "image-scaling",
                                                "min-size",
                                                "max-size"]);
}
})]);
}
var CPControlValueKey = "CPControlValueKey",
    CPControlControlStateKey = "CPControlControlStateKey",
    CPControlIsEnabledKey = "CPControlIsEnabledKey",
    CPControlTargetKey = "CPControlTargetKey",
    CPControlActionKey = "CPControlActionKey",
    CPControlSendActionOnKey = "CPControlSendActionOnKey";
var __Deprecated__CPImageViewImageKey = "CPImageViewImageKey";
{
var the_class = objj_getClass("CPControl")
if(!the_class) objj_exception_throw(new objj_exception(OBJJClassNotFoundException, "*** Could not find definition for class \"CPControl\""));
var meta_class = the_class.isa;class_addMethods(the_class, [new objj_method(sel_getUid("initWithCoder:"), function $CPControl__initWithCoder_(self, _cmd, aCoder)
{ with(self)
{
    self = objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPView") }, "initWithCoder:", aCoder);
    if (self)
    {
        objj_msgSend(self, "setObjectValue:", objj_msgSend(aCoder, "decodeObjectForKey:", CPControlValueKey));
        objj_msgSend(self, "setTarget:", objj_msgSend(aCoder, "decodeObjectForKey:", CPControlTargetKey));
        objj_msgSend(self, "setAction:", objj_msgSend(aCoder, "decodeObjectForKey:", CPControlActionKey));
        objj_msgSend(self, "sendActionOn:", objj_msgSend(aCoder, "decodeIntForKey:", CPControlSendActionOnKey));
    }
    return self;
}
}), new objj_method(sel_getUid("encodeWithCoder:"), function $CPControl__encodeWithCoder_(self, _cmd, aCoder)
{ with(self)
{
    var count = objj_msgSend(_subviews, "count"),
        ephemeral
        subviews = nil;
    if (count > 0 && objj_msgSend(_ephemeralSubviews, "count") > 0)
    {
        subviews = objj_msgSend(_subviews.slice(0), "copy");
        while (count--)
            if (objj_msgSend(_ephemeralSubviews, "containsObject:", _subviews[count]))
                _subviews.splice(count, 1);
    }
    objj_msgSendSuper({ receiver:self, super_class:objj_getClass("CPView") }, "encodeWithCoder:", aCoder);
    if (subviews)
        _subviews = subviews;
    if (_value !== nil)
        objj_msgSend(aCoder, "encodeObject:forKey:", _value, CPControlValueKey);
    if (_target !== nil)
        objj_msgSend(aCoder, "encodeConditionalObject:forKey:", _target, CPControlTargetKey);
    if (_action !== NULL)
        objj_msgSend(aCoder, "encodeObject:forKey:", _action, CPControlActionKey);
    objj_msgSend(aCoder, "encodeInt:forKey:", _sendActionOn, CPControlSendActionOnKey);
}
})]);
}
var _CPControlSizeIdentifiers = [],
    _CPControlCachedColorWithPatternImages = {},
    _CPControlCachedThreePartImagePattern = {};
_CPControlSizeIdentifiers[CPRegularControlSize] = "Regular";
_CPControlSizeIdentifiers[CPSmallControlSize] = "Small";
_CPControlSizeIdentifiers[CPMiniControlSize] = "Mini";
_CPControlIdentifierForControlSize= function(aControlSize)
{
    return _CPControlSizeIdentifiers[aControlSize];
}
_CPControlColorWithPatternImage= function(sizes, aClassName)
{
    var index = 1,
        count = arguments.length,
        identifier = "";
    for (; index < count; ++index)
        identifier += arguments[index];
    var color = _CPControlCachedColorWithPatternImages[identifier];
    if (!color)
    {
        var bundle = objj_msgSend(CPBundle, "bundleForClass:", objj_msgSend(CPControl, "class"));
        color = objj_msgSend(CPColor, "colorWithPatternImage:", objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(bundle, "pathForResource:", aClassName + "/" + identifier + ".png"), sizes[identifier]));
        _CPControlCachedColorWithPatternImages[identifier] = color;
    }
    return color;
}
_CPControlThreePartImagePattern= function(isVertical, sizes, aClassName)
{
    var index = 2,
        count = arguments.length,
        identifier = "";
    for (; index < count; ++index)
        identifier += arguments[index];
    var color = _CPControlCachedThreePartImagePattern[identifier];
    if (!color)
    {
        var bundle = objj_msgSend(CPBundle, "bundleForClass:", objj_msgSend(CPControl, "class")),
            path = aClassName + "/" + identifier;
        sizes = sizes[identifier];
        color = objj_msgSend(CPColor, "colorWithPatternImage:", objj_msgSend(objj_msgSend(CPThreePartImage, "alloc"), "initWithImageSlices:isVertical:", [
                    objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(bundle, "pathForResource:", path + "0.png"), sizes[0]),
                    objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(bundle, "pathForResource:", path + "1.png"), sizes[1]),
                    objj_msgSend(objj_msgSend(CPImage, "alloc"), "initWithContentsOfFile:size:", objj_msgSend(bundle, "pathForResource:", path + "2.png"), sizes[2])
                ], isVertical));
        _CPControlCachedThreePartImagePattern[identifier] = color;
    }
    return color;
}

