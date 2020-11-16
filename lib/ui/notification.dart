
import 'package:Dcode/logic/notifications.dart';
import 'package:Dcode/ui/chatlist.dart';
import 'package:Dcode/ui/home.dart';
import 'package:Dcode/ui/privateChat.dart';
import 'package:flutter/material.dart';

import 'profile.dart';



class notify extends StatelessWidget {
  Color c1 = const Color.fromRGBO(110,204,234,1.0); // fully transparent white (invisible)
  final notifylogic Notification = notifylogic();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
appBar: new AppBar(
  backgroundColor: c1,
        title:Row(  children: <Widget>[
            Text('Notification'),
              Icon(
                Icons.notifications,
              color:Colors.yellow,
              ),
          ],
        ),
//          title: new Text("Login"),
       
      ),


        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          backgroundColor: c1,
        

        onTap: (value) {
          // Respond to item press.
          if(value == 0){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => home()),
            );
            
          }else if(value == 1){

//            Navigator.push(
//            context,
//            MaterialPageRoute(builder: (context) => notify()),
//             );
          }else if(value == 2){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => chatlist()),
            );
          }else if(value == 3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
       
          }

        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.home,color: Colors.black45,),
          ),
          BottomNavigationBarItem(
            title: Text('Notifications', style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.notifications,color: Colors.white,),
          ),
          BottomNavigationBarItem(
            title: Text('Recent Chats', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.chat,color: Colors.black45,),
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            title: Text('My Profile', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.account_circle,color: Colors.black45,),

          ),
        ],
      ),


  
      
       
       body : Center(
         child:    new ListView(
      children:<Widget>[
        Column(children: [
 Row(children: [


                Text(
          'New Conversation',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Futura',
            color: Colors.black,
            decoration: TextDecoration.underline,
            height: 3,
          ),
        ),
        ],),
        SizedBox(height: 20),
      Container(
        padding:EdgeInsets.all(16.0) ,
        decoration: BoxDecoration(
          
           border: Border(
             
              bottom: BorderSide(width: 0.5, color: Colors.black),
           ),
     ),
     child: Row(
         mainAxisAlignment:MainAxisAlignment.spaceAround,
         
         children: [
         
         Text(

           Notification.getmsgs().keys.toList()[0],
          style: TextStyle(
            
            fontSize: 20,
            fontFamily: 'Futura',
            color: Colors.black,
          ),

        ),
   Icon(
          Icons.qr_code,
          size: 40,
          color: Colors.black,
         
        ),
        Text( Notification.getmsgs().values.toList()[0],
         style: TextStyle(
           
            fontSize: 10,
            fontFamily: 'Futura',
            color: Colors.black,
          ),),
        Icon(
          Icons.circle,
          size: 15,
          color: Colors.red,
        ),
        ],), 
      ),
       

 Row(children: [


                Text(
          'New Purchaser',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Futura',
            color: Colors.black,
            decoration: TextDecoration.underline,
            height: 3,
          ),
        ),
        ],),


                SizedBox(height: 20),
      Container(
        padding:EdgeInsets.all(16.0) ,
        decoration: BoxDecoration(
          
           border: Border(
             
              bottom: BorderSide(width: 0.5, color: Colors.black),
           ),
     ),
     child: Row(
         mainAxisAlignment:MainAxisAlignment.spaceAround,
         
         children: [
         
         Text(

           Notification.getpurchasers().keys.toList()[0],
          style: TextStyle(
            
            fontSize: 20,
            fontFamily: 'Futura',
            color: Colors.black,
          ),

        ),
   Icon(
          Icons.qr_code,
          size: 40,
          color: Colors.black,
         
        ),
        Text(Notification.getpurchasers().values.toList()[0],
         style: TextStyle(
           
            fontSize: 10,
            fontFamily: 'Futura',
            color: Colors.black,
          ),),
        Icon(
          Icons.circle,
          size: 15,
          color: Colors.red,
        ),
        ],), 
      ),
      

        ],)
        
     
      ],
    ),
       ),

    
    );
  }
}

