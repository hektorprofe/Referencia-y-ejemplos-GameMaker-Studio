globalvar display_w, display_h;
if os_type == os_android || os_type == os_ios {
    display_w = display_get_width();
    display_h = display_get_height();
    
    view_wview = display_w;
    view_hview = display_h;
    view_wport = display_w;
    view_hport = display_h;
}
else {
    display_w = view_wview;
    display_h = view_hview;
}
