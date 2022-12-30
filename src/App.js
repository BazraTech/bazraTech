import React , {Component} from 'react'
import {Routes, Route, Link, useNavigate, Navigate, Router} from "react-router-dom";
import {FaHome} from 'react-icons/fa';
import { IconName } from "react-icons/ai";
import SignIn from './components/Pages/Sign in page/SignIn';
import Company_registration from './components/Pages/Registration/Company_registration';
import Users from './components/Pages/Users/Users';
import Dashboard from './components/Pages/Dashboard/Dashboard';
import Total_number_of_vehile from './components/Pages/Total_number_of_vehicle/Total_number_of_vehile';
import Tracking_history from './components/Pages/Tracking/Tracking_history';
import Tracking from './components/Pages/Tracking/Tracking';
import Alert from './components/Pages/alert/Alert';
import Users_edit from './components/Pages/Users/Users_edit';
import Vehicle_detail from './components/Pages/Total_number_of_vehicle/Vehicle_detail';
import Message_overview from './components/Pages/Message/Message_overview';
import Settings from './components/Pages/Settings/Settings';
import Report from './components/Pages/Report/Report';
import Report_detail from './components/Pages/Report/Report_detail';
import PopUp from './components/Pages/Settings/PopUp';
import Add_vehicle from "./components/Pages/Users/Add_vehicle"
import Individual_registration from './components/Pages/Registration/Individual_registration';
import Set_Trip from './components/Pages/Trip Management/Set_Trip';
import Trip_history from './components/Pages/Trip Management/Trip_history';
import Avialable_trip from './components/Pages/Trip Management/Avialable_trip';




class App extends Component{
  render(){
  return (
    <div className="App">
      
      <Routes>
        <Route path='/' element={<SignIn />}></Route>
        <Route path="/dashboard" element={<Dashboard />}></Route>
        <Route path="/users" element={<Users />}></Route>
        <Route path="/vehicle_detail" element={<Vehicle_detail></Vehicle_detail>}></Route>
        <Route path="/User_edit" element={<Users_edit />}></Route>
        <Route path="/Company_registration" element={<Company_registration />}></Route>
        <Route path="/individual" element={<Individual_registration />}></Route>
        <Route path="/Total_number_of_vehicle" element={<Total_number_of_vehile />}></Route>
        <Route path="/tracking_hitory" element={<Tracking_history />}></Route>
        <Route path="/tracking" element={<Tracking />}></Route>
        <Route path="/alert" element={<Alert />}></Route>
        <Route path="/vehicle_detail" element={<Vehicle_detail />}></Route>
        <Route path="/message_overview" element={<Message_overview />}></Route>
        <Route path="/settings" element={<Settings />}></Route>
        <Route path="/report" element={<Report />}></Route>
        <Route path="/report_detail" element={<Report_detail />}></Route>
        <Route path="/popup" element={<PopUp />}></Route>
        <Route path="/Add_vehicle" element={<Add_vehicle />}></Route>
        <Route path="/set_trip" element={<Set_Trip />}></Route>
        <Route path="/trip_history" element={<Trip_history />}></Route>
        <Route path="/avialable_trip" element={<Avialable_trip />}></Route>
      </Routes>

    </div>
    
  );
}
}

export default App;
