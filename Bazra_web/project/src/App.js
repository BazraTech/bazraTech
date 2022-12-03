import React , {Component} from 'react'
import {Routes, Route, Link, useNavigate, Navigate, Router} from "react-router-dom";
import {FaHome} from 'react-icons/fa';
import { IconName } from "react-icons/ai";
import SignIn from './components/Pages/Sign in page/SignIn';
import Vehicle_Registration from './components/Pages/Registration/Vehicle_Registration';
import Company_registration from './components/Pages/Registration/Company_registration';
import Users from './components/Pages/Users/Users';
import Dashboard from './components/Pages/Dashboard/Dashboard';
import Detail from './components/Pages/Users/Detail';
class App extends Component{
  render(){
  return (
    <div className="App">
      
      <Routes>
        <Route path='/' element={<SignIn />}></Route>
        <Route path="/dashboard" element={<Dashboard />}></Route>
        <Route path="/users" element={<Users />}></Route>
        <Route path="/Company_registration" element={<Company_registration />}></Route>
        <Route path="/vehicle_registration" element={<Vehicle_Registration />}></Route>
        <Route path="/user_detail" element={<Detail />}></Route>
      </Routes>

    </div>
    
  );
}
}

export default App;
