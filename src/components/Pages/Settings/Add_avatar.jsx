import React, { useState } from 'react';
import axios from 'axios';
import swal from "sweetalert";

const Add_avatar = () => {
  const [selectedImage1, setSelectedImage1] = useState(null);
  const [selectedImage2, setSelectedImage2] = useState(null);

  const jwt = JSON.parse(localStorage.getItem('jwt'));

  const handleImageUpload = async () => {
    if (!selectedImage1 || !selectedImage2) {
      swal('Error', 'Please select both images.', 'error');
      return;
    }

    const formData = new FormData();
    formData.append("logo", selectedImage1);
    formData.append("avatar", selectedImage2);

    try {
      const response = await axios.post(
        'http://64.226.104.50:9090/Api/Admin/AddLogoAvatar',
        formData,
        {
          headers: {
            'Content-Type': 'multipart/form-data',
            "Authorization": `Bearer ${jwt}`,
          },
        }
      );

      localStorage.setItem("message", JSON.stringify(response.data["message"]));
      const mess = localStorage.getItem("message");
      console.log(response);
      swal("Successfully Registered", `${mess}`, "success", {
        button: true,
      });

      setSelectedImage1(null);
      setSelectedImage2(null);
    } catch (error) {
      if (error.response) {
        localStorage.setItem('message', JSON.stringify(error.response.data['message']));
        const messx = localStorage.getItem('message');
        console.log('message', messx);
        console.log(error.response.data);
        swal("Error", `${messx}`, "error", {
          button: true,
        });
        console.log(error.response.status);
        console.log(error.response.headers);
      } else if (error.request) {
        console.log(error.request);
      } else {
        console.log('Error', error.message);
      }
    }
  };

  const handleImageChange1 = (event) => {
    console.log(event.target.files[0]);
    const file = event.target.files[0];
    setSelectedImage1(file);
  };

  const handleImageChange2 = (event) => {
    console.log(event.target.files[0]);
    const file = event.target.files[0];
    setSelectedImage2(file);
  };

  return (
    <div>
      <input type="file" name="avatar" onChange={handleImageChange1} />
      <input type="file" name="logo" onChange={handleImageChange2} />
      <button onClick={handleImageUpload}>Upload</button>
    </div>
  );
};

export default Add_avatar;
