# Bosloh App

**Bosloh App** is a Flutter application developed as a graduation project for the **Digital Egypt Pioneers Initiative (DEPI)**.  
The app helps travelers and tourists discover nearby important places such as hotels, restaurants, cafes, tourist spots, commercial areas, airports, and religious sites, with an **offline-first experience**.  
It also includes a **smart Chatbot** that suggests places and answers user questions about locations.

---

## 💡 Core Idea

The app allows users to:

- Using the user’s current location to see nearby places.
- Filter places by category.
- Search for any place by name, even if far away.
- Use the app offline when there is no internet connection.
- Interact with a Chatbot to get suggestions or information about any place.

---

## App Flow

1. User logs in on app launch.  
2. Home screen fetches nearby places from APIs.  
3. Results are displayed and cached locally with user’s location.  
4. User can:
   - Refresh data using local cache if in the same area.  
   - Open place details and view distance on Google Maps.  
   - Add places to Favorites.  
   - Schedule trips with notifications.  
   - Interact with Chatbot for suggestions or information.

---

## 📱 App Overview

| Auth Experience | Home & Main Features |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/cf15557e-ecac-47fd-a46e-7e9e0ef2b1dd" width="450"> | <img src="https://github.com/user-attachments/assets/413fb4ab-a5c9-4693-8d69-760f119e1aa8" width="450"> |
| *Secure Authentication* | *Discover Nearby Places* |

| Exploration & Intelligence | User Personalization |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/666f0a57-1889-45f8-9f8d-102c1db2a6da" width="450"> | <img src="https://github.com/user-attachments/assets/17cd5b4d-2ca8-45f2-a716-4cceff80ec3c" width="450"> |
| *Detailed Place Info* | *AI Smart Chatbot* |

| Favorites & Planning | Profile & Customization |
|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/1e102380-dfb5-42da-ae40-49f0ffb350ea" width="450"> | <img src="https://github.com/user-attachments/assets/fa1c4e49-1fa0-4d7e-a6b3-66a3dd2ef19f" width="450"> |
| *Favorite Places List* | *Trip Scheduling* |

<p align="center">
  <img src="https://github.com/user-attachments/assets/3e520ddd-c9f7-4859-a565-588a0b832541" width="600">
  <br>
  <em>Profile & Dark Mode Support</em>
</p>


---

## ✨ Key Features

### 1. Nearby Places
- Displays the closest places based on the user’s current location.
- Filter by categories: Tourism, Hotels, Restaurants, Cafes, Commercial, Airports, Religious.
- Optimized to reduce API calls by caching responses locally for repeated requests within ~500 meters.

### 2. Offline-First
- All API responses are stored **locally** using **SQLite** for offline access.
- Ensures smooth app experience even without an internet connection.
- Combines local caching with Supabase sync to keep user data updated when back online.

### 3. Navigate to place in Google maps
- Place details link directly to **Google Maps** to check distance and navigate.
- Allows users to easily plan routes and trips to selected locations.

### 4. Chatbot
- A smart assistant that can suggest new places to visit.
- Answers user questions about any location (e.g., distance, type of place, operating hours).
- Enhances the user experience by giving personalized recommendations.

### 5. Favorites
- Users can save preferred places to a **Favorites list**.
- Stored both locally (**SQLite**) and online (**Supabase**) for offline access.
- Helps users quickly access their favorite locations anytime.

### 6. Trip Scheduling
- Allows users to plan trips and schedule visits to multiple locations.
- Sends **notifications** at scheduled times using **Awesome Notifications**.
- Works even if the device is offline.

### 7. Light & Dark Theme
- Supports both light and dark modes.
- Improves accessibility and provides better UX for different lighting conditions.

---

## Tech Stack

- **Flutter + GetX**: State management and navigation.  
- **Supabase**: Authentication and online storage.  
- **SQLite**: Local storage for offline-first experience.  
- **Dio**: API handling.  
- **Geolocator**: Access user location.  
- **Awesome Notifications**: Scheduled notifications.  
- **APIs**: Wikipedia API + Geoapify API for place data.
---

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps:

1. **Clone the repo:**
   ```bash
   git clone https://github.com/yousefa7med/Boslah_app.git
---



## 👥 Contributors

<div align="center">
  <table>
    <tr>
      <td align="center">
        <a href="https://github.com/yousefa7med">
          <img src="https://github.com/yousefa7med.png" width="80px" style="border-radius:50%;" alt="Youssef Ahmed"/>
        </a>
        <br />
        <b>Youssef Ahmed</b>
      </td>
      <td align="center">
        <a href="https://github.com/ziad-esmaiel">
          <img src="https://github.com/ziad-esmaiel.png" width="80px" style="border-radius:50%;" alt="Ziad Esmaiel"/>
        </a>
        <br />
        <b>Ziad Esmaiel</b>
      </td>
      <td align="center">
        <a href="https://github.com/mohamed-hossny">
          <img src="https://github.com/mohamed-hossny.png" width="80px" style="border-radius:50%;" alt="Mohamed Hossny"/>
        </a>
        <br />
        <b>Mohamed Hossny</b>
      </td>
      <td align="center">
        <a href="https://github.com/Bassam-Yasser1">
          <img src="https://github.com/Bassam-Yasser1.png" width="80px" style="border-radius:50%;" alt="Bassam Yasser"/>
        </a>
        <br />
        <b>Bassam Yasser</b>
      </td>
      <td align="center">
        <a href="https://github.com/mhmdashraf11">
          <img src="https://github.com/mhmdashraf11.png" width="80px" style="border-radius:50%;" alt="Mohamed Ashraf"/>
        </a>
        <br />
        <b>Mohamed Ashraf</b>
      </td>
    </tr>
  </table>
</div>
---

## 📬 Let's Connect!

<div align="center">


**Always learning. Always building.**
*Don’t hesitate to contact me:*

<br>

<a href="https://www.linkedin.com/in/1youssef-ahmed/" target="_blank">
  <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
</a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="mailto:youssefahmedserag@gmail.com">
  <img src="https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Gmail">
</a>

</div>
