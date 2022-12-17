import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { FiLogOut } from "react-icons/fi";
import { FaStarOfLife } from 'react-icons/fa';
import { BsSearch } from "react-icons/bs";
import { HiMenuAlt1 } from "react-icons/hi";
import './tracking_history.css';
import { Link } from 'react-router-dom';

export default function () {


  return (
    <div className="containerr">

      {/*---------------navigation---------------*/}

      <div className="navigation">
        <ul>
          <li>
            <Link to="/dashboard">
              <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p>
            </Link>
          </li>
          <li>
            <Link to="/Total_number_of_vehicle">
              <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p>
            </Link>
          </li>
          <li>
            <Link to="/tracking">
              <p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='#00cc44'></RiGpsFill></p>
            </Link>
          </li>
          <li>
            <Link to="#">
              <p class="hovertext" data-hover="Monitor Vehicles"><MdMonitor size="2rem" color='white'></MdMonitor></p>
            </Link>
          </li>
          <li>
            <Link to="/users">
              <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p>
            </Link>
          </li>
          <li>
            <Link to="/alert">
              <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
            </Link>
          </li>
          <li>
            <Link to="/report">
              <p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p>
            </Link>
          </li>
          <li>
            <Link to="/Company_registration">
              <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p>
            </Link>
          </li>
          <li>
            <Link to="/message_overview">
              <p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
            </Link>
          </li>
          <li>
            <Link to="#">
              <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
            </Link>
          </li>
          <li>
            <Link to="/settings">
              <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
            </Link>
          </li>
        </ul>
      </div>

      {/* ---------------end navigation--------------- */}


      {/* ---------------header--------------- */}

      <div className="header">
        <h2 className='header_title'>Bazra Motors / <h6>History</h6></h2>
        <p className='menu_controler'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
        <p><FiLogOut size="2rem" color='black'></FiLogOut></p>

      </div>
      {/* ---------------end header--------------- */}

      {/*-----------------Search bar-------------- */}

      <div className="sssearch">
        <p>
          <BsSearch className='iiicn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
          <input type="text" placeholder="Search"></input>
          <button>Search</button>
        </p>
      </div>
      <div className='colomnnn'>
        <div className='user-11'>
          <b><p className='makeCenter'>Description</p></b>
          <div className="table11">
            <table class="table22" >
              <tbody>
                <tr className='row-table'>
                  <td>Vehicle ID</td>
                  <td>BA 000002</td>
                </tr>
                <tr className='row-table'>
                  <td>Vehicle owner</td>
                  <td>Bazra motors</td>
                </tr>
                <tr className='row-table'>
                  <td>Vehicle Type</td>
                  <td>Log carrier</td>
                </tr>
                <tr className='row-table'>
                  <td>Plate number</td>
                  <td>ET 3-A12345</td>
                </tr>
              </tbody>

            </table>

          </div>
        </div>
        <div className='user-12'>
          <b><p className='makeCenter' >Current Status</p></b>
          <p className="for-route">On route</p>
          <b><p className='makeCenter'>History</p></b>
          <table class="table22" >
            <tbody>
              <tr className='active_roww'>
                <td>Start Date</td>
                <td>02/12/2022 04:30 am</td>
              </tr>
              <tr>
                <td>Start From</td>
                <td>Addis Ababa</td>
              </tr>
              <tr className='activeroww'>
                <td>Total travel time</td>
                <td>34:30:15</td>
              </tr>
              <tr>
                <td>Total kilometer</td>
                <td>1021km</td>
              </tr>
              <tr>
                <td>Current location</td>
                <td>Jijiga</td>
              </tr>
            </tbody>

          </table>
        </div>
      </div>
      <div className="mapclone">
        <iframe width="100%" height="100%" id="gmap_canvas" src="https://maps.google.com/maps?q=ethio&t=&z=11&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
      </div>
    </div>


  )
}
