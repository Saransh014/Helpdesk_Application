# Flutter Helpdesk Application 

A simple Helpdesk application using Flutter that features two main sections: Tickets and Customers. The app will support three user roles: Customer, Support Agent, and Admin. The focus is on basic functionality, clean code and a intruitive UI.


## Features

- User role-based access (Customer, Support Agent, Admin)
- Ticket creation and management
- Real-time updates and notifications
- Dark mode support
- File attachment support

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Launch the app using `flutter run`

## User Roles and Functionalities

### Role Selection Screen

The app starts with a role selection screen where users can choose their role:

- Customer
- Admin
- Support Agent


![WhatsApp Image 2024-10-18 at 00 33 16 (2)](https://github.com/user-attachments/assets/62165d6a-d03b-43bb-92fd-6cb2fa7ae598)


![WhatsApp Image 2024-10-18 at 00 33 16 (1)](https://github.com/user-attachments/assets/bbf4ced7-242e-426b-8239-029d072d4aef)


### Customer

1. Login/Register


![WhatsApp Image 2024-10-18 at 00 33 16](https://github.com/user-attachments/assets/53b6b1cc-e328-4c7d-90fa-5da7e0759b11)


2. Dashboard
   - View active tickets
   - Create new tickets


![WhatsApp Image 2024-10-18 at 00 33 15](https://github.com/user-attachments/assets/538a5734-45dd-46cd-9808-c9c0911cf177)

3. Create Ticket
   - Add title and description
   - Attach files (jpg, pdf)


![WhatsApp Image 2024-10-18 at 00 33 15 (1)](https://github.com/user-attachments/assets/9b2f4106-4db7-4c0c-88f2-fbdf007b109c)


4. View Ticket Details
   - See ticket status, description, and attachments
   - Add notes to the ticket


![PHOTO-2024-10-18-00-56-05](https://github.com/user-attachments/assets/e9abdacf-a979-4d4a-bbdb-cee2106311b0)


5. View all tickets

![WhatsApp Image 2024-10-18 at 00 33 15](https://github.com/user-attachments/assets/db5d675c-ac49-4052-bb37-2e21f8974944)


### Support Agent

1. Login


![WhatsApp Image 2024-10-18 at 00 33 12 (2)](https://github.com/user-attachments/assets/5ef6f25f-4c30-4465-8685-f55bb937dc28)


2. Dashboard
   - View ticket statistics (Total, Active, Pending, Closed)
   - Quick access to all tickets


![WhatsApp Image 2024-10-18 at 00 33 12 (1)](https://github.com/user-attachments/assets/8b5b7761-34aa-4d2c-8477-2a1a9ba220b0)


3. View All Tickets
   - Filter tickets by status


![WhatsApp Image 2024-10-18 at 00 33 12](https://github.com/user-attachments/assets/a5f9b190-cc08-44df-b638-08bf1e487a51)


4. Ticket Details
   - View ticket information
   - Add notes/replies
   - Update ticket status


![WhatsApp Image 2024-10-18 at 00 33 13](https://github.com/user-attachments/assets/04b0b0c5-1f28-4921-a2fe-299c6c9c5784)


### Admin

1. Login


![WhatsApp Image 2024-10-18 at 00 33 15](https://github.com/user-attachments/assets/538a5734-45dd-46cd-9808-c9c0911cf177)

2. Dashboard
   - View overall statistics (Users, Tickets)
   - Quick access to user management and all tickets


![WhatsApp Image 2024-10-18 at 00 33 14](https://github.com/user-attachments/assets/75caa356-d7cd-4366-82ba-0a6308848cb6)


3. User Management
   - View all users
   - Add new support agents


![WhatsApp Image 2024-10-18 at 00 33 13 (1)](https://github.com/user-attachments/assets/90c810db-3975-4ea9-9f9d-e7003a36b67e)


4. View All Tickets
   - Similar to Support Agent view


![WhatsApp Image 2024-10-18 at 00 33 12](https://github.com/user-attachments/assets/d25b5dc0-efa5-4d72-afc5-60f0b718d214)


5. Ticket Details
   - Similar to Support Agent view, with additional administrative options


![WhatsApp Image 2024-10-18 at 00 33 13](https://github.com/user-attachments/assets/f8aa6c8f-d8fe-4888-ae9a-801a6a6d87d6)



## Key Components

1. Authentication Service (`AuthService`)
2. Ticket Service (`TicketService`)
3. Theme Service (`ThemeService`)

## Workflow

1. User selects role on the Role Selection Screen
2. User logs in or registers (for customers)
3. User is directed to their respective dashboard based on their role
4. Users can perform role-specific actions (create tickets, manage tickets, etc.)
5. Logout returns users to the Role Selection Screen

## Development

This app is built using Flutter and follows a provider-based state management approach. Key files include:

- `main.dart`: App entry point and provider setup
- `screens/`: Contains all the screen widgets
- `services/`: Contains the core logic for authentication, ticket management, and theming
- `models/`: Data models for users and tickets

