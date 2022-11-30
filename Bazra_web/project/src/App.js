import React , {Component} from 'react'
import {FaHome} from 'react-icons/fa'
import { IconName } from "react-icons/ai";
import SignIn from './components/Pages/Sign in page/SignIn';
import Comp from './components/Pages/Dashboard/Dashboard';
import Vehicle_Registration from './components/Pages/Registration/Vehicle_Registration';
import Company_registration from './components/Pages/Registration/Company_registration';
import Users from './components/Pages/Users/Users';
import Dashboard from './components/Pages/Dashboard/Dashboard';
class App extends Component{
  render(){
  return (
    <div className="App">
         {/* <SignIn></SignIn> */}
         <Dashboard></Dashboard>
         {/* <Company_registration></Company_registration> */}
         {/* <Vehicle_Registration></Vehicle_Registration> */}
         {/* <Users></Users> */}

    </div>
    
  );
}
}

export default App;
