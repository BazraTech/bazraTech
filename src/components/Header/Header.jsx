import React, { useState, useEffect } from 'react'
import { FaUserAlt } from "react-icons/fa";
import { Link } from 'react-router-dom';
import { IoMdArrowDropdownCircle } from "react-icons/io";
import { IoMdArrowDropupCircle } from "react-icons/io";
import "./header.css"

export default function Header({ title }) {

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

    const [popup2, setPop2] = useState(false);
    const handleClickopen2 = () => {
        setPop2(!popup2);
    }
    const remove = () => {
        localStorage.removeItem("jwt");
        window.location.href = "/";
    }
    const [state, setState] = useState(false);
    const [state1, setState1] = useState(false);
    const toggle = () => {
        setState(!state);
    };
  
    return (
        <div>
            <div className="dashboard_headers">
                <div className='dashboardTitle'>
                    <h2>Bazra Motors /</h2>
                    <h5>{title}</h5>
                </div>
                <div className='user_dashboard'>
                    <p className='displayUser'><FaUserAlt size="1.6rem" color='green'></FaUserAlt></p>
                    <p className='displayUser'>{user.role}</p>
                    <p onClick={() => {
                        handleLogout()
                        toggle()
                    }}>{state ? <IoMdArrowDropupCircle size="1.2rem" color='green'></IoMdArrowDropupCircle> :
                        <IoMdArrowDropdownCircle size="1.2rem" color='green'></IoMdArrowDropdownCircle>}</p>
                    {logout ?
                        <div className='user_logout'>
                            <div>
                            <Link to="#" style={{ textDecoration: 'none', color:'white' }}><p className='logicon1'>{user.role}</p><hr className='hrr'/></Link>
                            <Link to="#" style={{ textDecoration: 'none', color:'white' }}><p className='logicon1'>{user.PhoneNumber}</p><hr className='hrr'/></Link>
                                <p onClick={handleClickopen2}>Log Out</p>
                            </div>
                        </div> : ""} 
                </div>
            </div>

            <div>
                {popup2 ?
                    <div> 
                        <div className='popup0'>
                            <div className='popup-innerq'>
                                <div onClick={handleClickopen2} className='close'>X</div>
                                {/* <div className='fgf1'>
                                        <h2>{active}</h2>
                                    </div> */}
                                {/* <button className='close-btn' onClick={handleClickopen2}>X</button> */}
                                <div className='fgf'>
                                    <h2 className='mnmn'>Are You Sure You want to want Log out</h2> 
                                    {/* <input placeholder={edit}></input> */}
                                    <div className='send_button'>
                                       <button onClick={() => {
                                            remove()
                                        }}  className='popup_add'>Ok</button>
                                        <button onClick={handleClickopen2} className='popup_cancle'>Cancle</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div> : ""}
            </div>


        </div>
    )
}
