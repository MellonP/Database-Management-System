Question 1

USE library_management;

CREATE TABLE members (
     member_id INT AUTO_INCREMENT PRIMARY KEY,
     first_name VARCHAR(50) NOT NULL,
     last_name VARCHAR(50) NOT NULL,
     email VARCHAR(100) NOT NULL UNIQUE,
     phone_number VARCHAR(15),
     address VARCHAR(200),
     date_joined DATE NOT NULL,
     membership_status ENUM('Active', 'Expired', 'Suspended') DEFAULT 'Active',
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
    
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50),
    biography TEXT);

CREATE TABLE publishers (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    website VARCHAR(100));
    
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(200) NOT NULL,
    publisher_id INT,
    publication_date DATE,
    edition VARCHAR(20),
    available_copies INT NOT NULL DEFAULT 0,
    total_copies INT NOT NULL DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id) ON DELETE SET NULL);

CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE);
    
CREATE TABLE book_categories (
	book_id INT,
	category_id INT,
    PRIMARY KEY (book_id, category_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE CASCADE);
        
CREATE TABLE loans (
	loan_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine_amount DECIMAL(10, 2) DEFAULT 0.00,
    status ENUM('Borrowed', 'Returned', 'Overdue') DEFAULT 'Borrowed',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE);

CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    reservation_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    status ENUM('Pending', 'Fulfilled', 'Cancelled', 'Expired') DEFAULT 'Pending',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE);
    
CREATE TABLE fines (
    fine_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    issued_date DATE NOT NULL,
    payment_date DATE,
    status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (loan_id) REFERENCES loans(loan_id) ON DELETE CASCADE);
    
CREATE TABLE library_staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15),
    role ENUM('Librarian', 'Assistant', 'Admin') NOT NULL,
    hire_date DATE NOT NULL);
    
INSERT INTO members (first_name, last_name, email, phone_number, address, date_joined, membership_status) VALUES
   ('Sipho', 'Nkosi', 'sipho.nkosi@email.com', '082-456-7890', '123 Vilakazi St, Soweto', '2023-01-15', 'Active'),
   ('Thandi', 'Mokoena', 'thandi.mokoena@email.com', '083-567-8901', '456 Protea Rd, Pretoria', '2023-02-20', 'Active'),
   ('Lungile', 'Khumalo', 'lungile.k@email.com', '084-678-9012', '789 Ubunye Cres, Durban', '2023-03-10', 'Suspended'),
   ('Nomsa', 'Dlamini', 'nomsa.d@email.com', '081-789-0123', '321 Ubuntu Ave, Johannesburg', '2023-04-05', 'Active'),
   ('Bongani', 'Zuma', 'bongani.z@email.com', '079-890-1234', '654 Freedom Dr, Cape Town', '2023-05-12', 'Expired');

INSERT INTO authors (first_name, last_name, birth_date, nationality, biography) VALUES
   ('Sindi', 'Mnguni', '1978-04-12', 'South African', 'Renowned writer of contemporary African literature'),
   ('Dumisani', 'Cele', '1985-09-30', 'South African', 'Author of political commentary and historical analysis'),
   ('Palesa', 'Mahlangu', '1990-11-21', 'South African', 'Poet and novelist focusing on African identity'),
   ('Themba', 'Maseko', '1963-07-05', 'South African', 'Award-winning author known for his crime thrillers'),
   ('Zanele', 'Ndlovu', '1980-06-17', 'South African', 'Writer of folklore and cultural heritage books');


INSERT INTO publishers (name, address, phone_number, email, website) VALUES
   ('Maskew Miller Longman', '123 Book St, Cape Town', '021-456-7890', 'info@maskewmiller.co.za', 'www.maskewmiller.co.za'),
   ('Penguin South Africa', '456 Ink Ave, Johannesburg', '011-567-8901', 'contact@penguin1.co.za', 'www.penguin.co.za'),
   ('Kwela Books', '789 Literary Rd, Pretoria', '012-678-9012', 'support@kwelaabooks.co.za', 'www.kwelabooks.co.za'),
   ('Jacana Media', '321 Story Blvd, Durban', '031-789-0123', 'queries@jacana3.co.za', 'www.jacana.co.za'),
   ('Oxford University Press SA', '654 Knowledge Ct, Stellenbosch', '021-890-1234', 'admin@oup.co.za', 'www.oup.co.za');

INSERT INTO categories (name, description) VALUES
   ('Fiction', 'Imaginative storytelling not based on real events'),
   ('Non-Fiction', 'Based on facts and real events'),
   ('Science Fiction', 'Speculative fiction often based on scientific concepts'),
   ('Mystery', 'Fiction dealing with the solution of a crime or puzzle'),
   ('Biography', 'An account of someone’s life written by someone else');

INSERT INTO books (isbn, title, publisher_id, publication_date, edition, available_copies, total_copies) VALUES
   ('978-0-7475-3269-6', 'Harry Potter and the Philosopher’s Stone', 1, '1997-06-26', '1st Edition', 5, 10),
   ('978-0-452-28423-4', '1984', 2, '1949-06-08', 'Reprint', 3, 7),
   ('978-0-14-143951-8', 'Pride and Prejudice', 3, '1813-01-28', 'Classic Edition', 2, 5),
   ('978-0-684-80122-3', 'The Old Man and the Sea', 4, '1952-09-01', '2nd Edition', 4, 6),
   ('978-0-06-207348-6', 'Murder on the Orient Express', 5, '1934-01-01', 'Remastered', 1, 4);

INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date, fine_amount, status) VALUES
   (1, 1, '2023-06-01', '2023-06-15', '2023-06-12', 0.00, 'Returned'),
   (2, 2, '2023-06-05', '2023-06-19', NULL, 0.00, 'Borrowed'),
   (4, 4, '2023-06-15', '2023-06-29', '2023-06-28', 0.00, 'Returned'),
   (5, 5, '2023-06-20', '2023-07-04', NULL, 0.00, 'Borrowed');

INSERT INTO reservations (book_id, member_id, reservation_date, expiry_date, status) VALUES
   (1, 2, '2023-06-25', '2023-07-02', 'Pending'),
   (2, 3, '2023-06-26', '2023-07-03', 'Cancelled'),
   (3, 4, '2023-06-27', '2023-07-04', 'Pending'),
   (4, 5, '2023-06-28', '2023-07-05', 'Fulfilled'),
   (5, 1, '2023-06-29', '2023-07-06', 'Expired');

INSERT INTO fines (loan_id, amount, issued_date, payment_date, status) VALUES
  (3, 5.00, '2023-06-25', NULL, 'Unpaid'),
  (1, 2.50, '2023-06-13', '2023-06-14', 'Paid'),
  (4, 1.00, '2023-06-29', '2023-06-30', 'Paid');

INSERT INTO library_staff (first_name, last_name, email, phone_number, role, hire_date) VALUES
  ('Robert', 'Clarke', 'robert.c@library.org', '123-456-7890', 'Librarian', '2020-01-15'),
  ('Emily', 'Morgan', 'emily.m@library.org', '234-567-8901', 'Assistant', '2021-03-20'),
  ('Michael', 'Taylor', 'michael.t@library.org', '345-678-9012', 'Admin', '2019-06-10');