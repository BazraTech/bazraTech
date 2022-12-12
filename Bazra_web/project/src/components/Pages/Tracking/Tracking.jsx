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
import './tracking.css';
import { Link } from 'react-router-dom';

export default function () {


  return (
    <div className="tacking_container">

      {/*---------------navigation---------------*/}

      <div className="tacking_navigation">
        <ul>
          <li>
            <Link to="/dashboard"> <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p></Link>
          </li>
          <li>
            <Link to="/Total_number_of_vehicle"><p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p></Link>
          </li>
          <li>
            <Link to="/tracking"><p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='#00cc44'></RiGpsFill></p></Link>
          </li>
          <li>
            <Link to="#"> <p class="hovertext" data-hover="Monitor Vehicles"><MdMonitor size="2rem" color='white'></MdMonitor></p></Link>
          </li>
          <li>
            <Link to="/users">  <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p></Link>
          </li>
          <li>
            <Link to="/alert"><p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p></Link>
          </li>
          <li>
            <Link to="#"><p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p></Link>
          </li>
          <li>
            <Link to="/Company_registration"> <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p></Link>
          </li>
          <li>
            <Link to="/message_overview"><p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p></Link>
          </li>
          <li>
            <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
          </li>
          <li>
            <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
          </li>
        </ul>
      </div>

      {/* ---------------end navigation--------------- */}


      {/* ---------------header--------------- */}

      <div className="tracking_header">
        <h2 className='header_title'>Bazra Motors / <h6>Tracking</h6></h2>
        <p className='menu_controler'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
        <p><FiLogOut size="2rem" color='black'></FiLogOut></p>

      </div>
      {/* ---------------end header--------------- */}

      {/*-----------------Search bar-------------- */}

      {/*-----------------Search bar rename-------------- */}

      <div className='map_search'>
        <p>
          <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
          <input type="text" id="myInput" placeholder="Search"></input>
          <button>Search</button>
        </p>
      </div>

      {/*----------------map clone------------------- */}

      <div className="m-mapclone">
        <iframe width="100%" height="100%" id="gmap_canvas" src="https://maps.google.com/maps?q=ethio&t=&z=11&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
      </div>

      <div className='historyview'>
        <Link to="/tracking_hitory"><button className='editt'>Show Full History</button></Link>
      </div>

    </div>



  )
}
