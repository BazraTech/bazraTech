import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    String _phoneNumber;
    String _fullName;
    String _email;
    String _password;
    String _confirmPassword;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    Widget _buildPnoneNumber() {
         margin:EdgeInsets.all(30.0);
      return Padding(
        padding: const EdgeInsets.all(14.0),
        child: TextFormField(
             decoration: InputDecoration(
            labelText: 'Phone Number',
            suffixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 4, color: Color.fromARGB(255, 233, 237, 235)),
        borderRadius: BorderRadius.circular(10.0),
    ),
        labelStyle: TextStyle(
        color: Color.fromARGB(255, 255, 235, 255), 
    ),
    border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
    ),
              // Based on passwordVisible state choose the ic
        ),style: TextStyle(fontSize: 25, color: Colors.white),
             // The validator receives the text that the user has entered.
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter Phone Number';
            }
            return null;
          },
        ),
      );
    }
    Widget _buildFullName() {
     
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.
 decoration: InputDecoration(
            labelText: 'Full Name',
            suffixIcon: Icon(Icons.person,
            color: Colors.blueAccent),
                      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 4, color: Color.fromARGB(255, 233, 237, 235)),
        borderRadius: BorderRadius.circular(10.0),
    ),
        labelStyle: TextStyle(
        color: Color.fromARGB(255, 255, 235, 255), 
    ),
    border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
    ),
              // Based on passwordVisible state choose the ic
        ),
          style: TextStyle(fontSize: 25, color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Full Name';
            }
            return null;
          },
        ),
      );
    }
   Widget _buildEmail() {
     
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.
 decoration: InputDecoration(
            labelText: 'Email',
            suffixIcon: Icon(Icons.email,
            color: Colors.blueAccent,),
                      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 4, color: Color.fromARGB(255, 233, 237, 235)),
        borderRadius: BorderRadius.circular(10.0),
    ),
        labelStyle: TextStyle(
        color: Color.fromARGB(255, 255, 235, 255), 
    ),
    border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
    ),
              // Based on passwordVisible state choose the ic
        ),
          style: TextStyle(fontSize: 35, color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter valid email';
            }
            return null;
          },
        ),
      );
    }
       Widget _buildPassword() {
     
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.

                     decoration: InputDecoration(
            labelText:'Password',
            suffixIcon: Icon(Icons.remove_red_eye,
            color:Colors.blueAccent),
                      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 4, color: Color.fromARGB(255, 233, 237, 235)),
        borderRadius: BorderRadius.circular(10.0),
    ),
        labelStyle: TextStyle(
        color: Color.fromARGB(255, 255, 235, 255), 
    ),
    border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
    ),
              // Based on passwordVisible state choose the ic
        ),
          style: TextStyle(fontSize: 25, color: Colors.white),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your Password';
            }
            return null;
          },
        ),
      );
    }
       Widget _buildConfirmPassword() {
     
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          // The validator receives the text that the user has entered.

          decoration: InputDecoration(
            labelText: 'Confirm Password',
            suffixIcon: Icon(Icons.remove_red_eye,
            color:Colors.blueAccent),
                      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(width: 4, color: Color.fromARGB(255, 233, 237, 235)),
        borderRadius: BorderRadius.circular(10.0),
    ),
        labelStyle: TextStyle(
        color: Color.fromARGB(255, 255, 235, 255), 
    ),
    border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(width: 1, style: BorderStyle.solid, color: Colors.white),
    ),
              // Based on passwordVisible state choose the ic
        ),
          ),
      
      );
    }
    return  
    Scaffold(
        
     
        body:
      
       SingleChildScrollView(
        
          child:Expanded(
            child: Container(
                      margin: const EdgeInsets.only(top: 100.0),
                alignment: Alignment.topCenter,
              height: (MediaQuery.of(context).size.height),
                    width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                   image: DecorationImage(
                    image: AssetImage('Asset/road.png'),
                    colorFilter: ColorFilter.mode(Color.fromARGB(255, 79, 78, 78).withOpacity(0.3), BlendMode.modulate,), // <-- BACKGROUND IMAGE
                    fit: BoxFit.fitHeight,
                    
                  ),
                
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200.0),),
                  color: Colors.grey,
                ),
                
                  
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      _buildPnoneNumber(),
                      _buildFullName(),
                      _buildEmail(),
                      _buildPassword(),
                      _buildConfirmPassword(),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ElevatedButton(
                          
                            child: Container(child:Text(
                              'Signup',
             
                                textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                             
                              ),
                            ),
                
                              width:double.infinity,
                            ),
                            onPressed: () => {}),
                               
                      ),
                         Text( 'Already have an account! ',
                           style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
                         ),
                    ],
                  ),
                ),
          ),
        ));


}
}