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
import Alert from './components/Pages/alert/Off_road';
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
import Table from './components/Pages/Report/Tables';
import On_route from './components/Pages/Total_number_of_vehicle/On_route';
import On_stock from './components/Pages/Total_number_of_vehicle/On_stock';
import Maintenance from './components/Pages/Total_number_of_vehicle/Maintenance';
import Company from './components/Pages/Users/Company';
import Individual from './components/Pages/Users/Individual';
import Accident from './components/Pages/alert/Accident';
import Driver from './components/Pages/alert/Driver';
import Off_road from './components/Pages/alert/Off_road';


import UserSignIn from './component 2/Pages/Sign in page/UserSignIn';
import UserCompany_registration from './component 2/Pages/Registration/UserCompany_registration';
import UserUsers from './component 2/Pages/Users/UserUsers';
import UserDashboard from './component 2/Pages/Dashboard/UserDashboard';
import UserTotal_number_of_vehile from './component 2/Pages/Total_number_of_vehicle/UserTotal_number_of_vehile';
import UserTracking_history from './component 2/Pages/Tracking/UserTracking_history';
import UserTracking from './component 2/Pages/Tracking/UserTracking';
import UserAlert from './component 2/Pages/alert/UserOff_road';
import UserUsers_edit from './component 2/Pages/Users/UserUsers_edit';
import UserVehicle_detail from './component 2/Pages/Total_number_of_vehicle/UserVehicle_detail';
import UserMessage_overview from './component 2/Pages/Message/UserMessage_overview';
import UserSettings from './component 2/Pages/Settings/UserSettings';
import UserReport from './component 2/Pages/Report/UserReport';
import UserReport_detail from './component 2/Pages/Report/UserReport_detail';
import UserPopUp from './component 2/Pages/Settings/UserPopUp';
import UserAdd_vehicle from "./component 2/Pages/Users/UserAdd_vehicle"
import UserIndividual_registration from './component 2/Pages/Registration/UserIndividual_registration';
import UserSet_Trip from './component 2/Pages/Trip Management/UserSet_Trip';
import UserTrip_history from './component 2/Pages/Trip Management/UserTrip_history';
import UserAvialable_trip from './component 2/Pages/Trip Management/UserAvialable_trip';
import UserTable from './component 2/Pages/Report/UserTables';
import UserOn_route from './component 2/Pages/Total_number_of_vehicle/UserOn_route';
import UserOn_stock from './component 2/Pages/Total_number_of_vehicle/UserOn_stock';
import UserMaintenance from './component 2/Pages/Total_number_of_vehicle/UserMaintenance';
import UserCompany from './component 2/Pages/Users/UserCompany';
import UserIndividual from './component 2/Pages/Users/UserIndividual';
import UserAccident from './component 2/Pages/alert/UserAccident';
import UserDriver from './component 2/Pages/alert/UserDriver';
import UserOff_road from './component 2/Pages/alert/UserOff_road';


class App extends Component{
  render(){
  return (
    <div className="App">
      
      <Routes>
        <Route path='/admin' element={<SignIn />}></Route>
        <Route path="/dashboard" element={<Dashboard />}></Route>
        <Route path="/users" element={<Users />}></Route>
        <Route path="/vehicle_detail" element={<Vehicle_detail></Vehicle_detail>}></Route> 
        <Route path="/User_edit" element={<Users_edit />}></Route>
        <Route path="/Company_registration" element={<Company_registration />}></Route>
        <Route path="/individual" element={<Individual_registration />}></Route>
        <Route path="/Total_number_of_vehicle" element={<Total_number_of_vehile />}></Route>
        <Route path="/tracking_hitory" element={<Tracking_history />}></Route>
        <Route path="/tracking" element={<Tracking />}></Route>
        <Route path="/off_road" element={<Off_road />}></Route>
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
        <Route path="/on_route" element={<On_route />}></Route>
        <Route path="/on_stock" element={<On_stock />}></Route>
        <Route path="/maintenance" element={<Maintenance />}></Route>
        <Route path="/company" element={<Company />}></Route>
        <Route path="/register_individual" element={<Individual />}></Route>
        <Route path="/accident" element={<Accident />}></Route>
        <Route path="/driver" element={<Driver />}></Route>


        <Route path='/' element={<UserSignIn />}></Route>
        <Route path="/Userdashboard" element={<UserDashboard />}></Route>
        <Route path="/Userusers" element={<UserUsers />}></Route>
        <Route path="/Uservehicle_detail" element={<UserVehicle_detail></UserVehicle_detail>}></Route> 
        <Route path="/UserUser_edit" element={<UserUsers_edit />}></Route>
        <Route path="/UserCompany_registration" element={<UserCompany_registration />}></Route>
        <Route path="/Userindividual" element={<UserIndividual_registration />}></Route>
        <Route path="/UserTotal_number_of_vehicle" element={<UserTotal_number_of_vehile />}></Route>
        <Route path="/Usertracking_hitory" element={<UserTracking_history />}></Route>
        <Route path="/Usertracking" element={<UserTracking />}></Route>
        <Route path="/Useroff_road" element={<UserOff_road />}></Route>
        <Route path="/Uservehicle_detail" element={<UserVehicle_detail />}></Route>
        <Route path="/Usermessage_overview" element={<UserMessage_overview />}></Route>
        <Route path="/Usersettings" element={<UserSettings />}></Route>
        <Route path="/Userreport" element={<UserReport />}></Route>
        <Route path="/Userreport_detail" element={<UserReport_detail />}></Route>
        <Route path="/Userpopup" element={<UserPopUp />}></Route>
        <Route path="/UserAdd_vehicle" element={<UserAdd_vehicle />}></Route>
        <Route path="/Userset_trip" element={<UserSet_Trip />}></Route>
        <Route path="/Usertrip_history" element={<UserTrip_history />}></Route> 
        <Route path="/Useravialable_trip" element={<UserAvialable_trip />}></Route>
        <Route path="/Useron_route" element={<UserOn_route />}></Route>
        <Route path="/von_stock" element={<UserOn_stock />}></Route>
        <Route path="/Usermaintenance" element={<UserMaintenance />}></Route>
        <Route path="/Usercompany" element={<UserCompany />}></Route>
        <Route path="/Userregister_individual" element={<UserIndividual />}></Route>
        <Route path="/Useraccident" element={<UserAccident />}></Route>
        <Route path="/Userdriver" element={<UserDriver />}></Route>
      </Routes>

    </div>
    
  );
}
}

export default App;
