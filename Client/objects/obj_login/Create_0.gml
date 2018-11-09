/// @description Init

loggingin=false
registering=false

var xx,yy,ww,hh;
ww=200
hh=30
xx=15
yy=(global.gui_height/2)-hh*4
login_username=ui_textbox_create(xx,yy,ww,hh,"Username")

register_username=ui_textbox_create(xx+350,yy,ww,hh,"Username")


yy+=hh*2
login_password=ui_textbox_create(xx,yy,ww,hh,"Password")
ui_textbox_set_password(login_password,1)

register_password0=ui_textbox_create(xx+350,yy,ww,hh,"Password")
ui_textbox_set_password(register_password0,1)

yy+=hh*2
register_password1=ui_textbox_create(xx+350,yy,ww,hh,"Confirm")
ui_textbox_set_password(register_password1,1)


login_button=ui_button_create(xx,yy,ww,hh,"Login")

yy+=hh*2
register_button=ui_button_create(xx+350,yy,ww,hh,"Register")

register_warning=-1;