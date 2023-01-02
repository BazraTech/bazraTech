import React, { useState, useEffect } from 'react'
import { FaUserAlt } from "react-icons/fa";
import { Link } from 'react-router-dom';
import { IoIosArrowDropdownCircle } from "react-icons/io";
import "./header.css"

export default function Header({title}) {

    const user = JSON.parse(localStorage.getItem("user"));
    const [logout, setLogout] = useState(false);
    const handleLogout = () => {
        setLogout(!logout);
    }
    useEffect(() => {
        if (!localStorage.getItem("jwt")) {
            window.location.href = "/";
        }
    }, [])
  return (
    <div>
         <div className="dashboard_headers" onClick={handleLogout}>
                <div className='dashboardTitle'>
                    <h2>Bazra Motors /</h2>
                    <h5>{title}</h5>
                </div>
                <div className='user_dashboard'>
                    <p className='displayUser'><FaUserAlt size="1.6rem" color='green'></FaUserAlt></p>
                    <p className='displayUser'>{user.role}</p>
                    <p onClick={handleLogout}><IoIosArrowDropdownCircle size="1rem" color='green'></IoIosArrowDropdownCircle></p>
                    {logout ?
                        <div className='user_logout'>
                            <div>
                                <p className='logicon1'>{user.role}</p>
                                <p className='logicon1'>{user.username}</p>
                                <Link to="/"><p onClick={() => {
                                    localStorage.removeItem("jwt")
                                }} className='logicon'>Log Out</p></Link>
                            </div>
                        </div> : ""}
                </div>
            </div>

    </div>
  )
}
