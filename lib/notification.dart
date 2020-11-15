
import 'package:flutter/material.dart';



class notify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
appBar: new AppBar(
        title:Row(  children: <Widget>[
            Text('Notification'),
              Icon(
                Icons.notifications,
              color: Colors.yellow,
              ),
          ],
        ),
//          title: new Text("Login"),
       
      ),


        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        

        onTap: (value) {
          // Respond to item press.
          if(value == 0){
           
            
          }else if(value == 1){

            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => notifications()),
            // );
          }else if(value == 2){

//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => chats()),
//            );
          }else if(value == 3){

       
          }

        },
        items: [
          BottomNavigationBarItem(
            title: Text('Home', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.home,color: Colors.black45,),
          ),
          BottomNavigationBarItem(
            title: Text('Notifications', style: TextStyle(color: Colors.black45),),
            icon: Icon(Icons.notifications,color: Colors.black45,),
          ),
          BottomNavigationBarItem(
            title: Text('Recent Chats', style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.chat,color: Colors.white,),
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
           
    'KaledLoay',
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
        Text('Hello Friend...',
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
           
    'Ahmed Elbanna',
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
        Text('New Purchaser is intersting',
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

