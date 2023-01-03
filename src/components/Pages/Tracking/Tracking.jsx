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
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';


export default function () {

  const [popup, setPop1] = useState(false);
  const handleClickopen = () => {
    setPop1(!popup);
  }


  return (
    <div className="tacking_container">

      {/*---------------navigation---------------*/}

      <Navigation></Navigation>

      {/* --------------- tracking header --------------- */}

      <Header title="Tracking"></Header>

      <div className='main_content'>


        {/*-----------------Search bar-------------- */}

        {/*-----------------Search bar rename-------------- */}

        <div className='map_search'>
          <p>
            <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
            <input type="text" id="myInput" placeholder="Search"></input>
            <button>Search</button>
          </p>
        </div>

        {/*---------------- map clone ------------------- */}

        <div className="m-mapclone">
          <iframe width="100%" height="100%" id="gmap_canvas" src="https://maps.google.com/maps?q=ethio&t=&z=11&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe>
        </div>

        <div>
          <Link to="/tracking_hitory"><button className='track_history'>Show Full History</button></Link>
        </div>

      </div>
    </div>


  )
}
