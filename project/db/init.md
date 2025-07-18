## _STUDENT_ Scenario

1. Sign in into the platform.
2. View _Visible_ challenges.
3. Submit challenge solution using flag format `flag{...}`:
    - If the solution is correct:
        1. The challenge will be marked as solved only for the student who submitted the solution;
        2. The user score will be increased with points from the solved challenge.
    - Otherwise:
        1. The platform returns an error message indicating the solution is incorrect.

### Implementation

To implement the _STUDENT_ scenario, we need to ensure that the database schema supports _User Authentication_, _Challenges Visibility_, and _Solution Submission_. The following steps outline the implementation:

1. **User Authentication:** To access the platform, users must log in using their credentials. This needs a `users` table.
2. **Challenge Visibility:** To see only visible challenges, the platform should filter challenges based on their visibility setting. This requires a `challenges` table with a `is_visible` field.
3. **Flag Submission:** The backend validates the submitted flag against the `flag` field into `challenges` table:
    - If the solution is correct:
        1. Will be created a new row in the `solved` table, linking the student using their `id` with the challenge `code`.
        2. The user `score` will be increased with `points` from the solved challenge.
    - Otherwise:
        1. The platform response is completely a frontend/backend job.

\vspace{0.5cm}

To get started, we need to create the following database schema:

\vspace{0.5cm}

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('Student', 'Tutor', 'Admin')),
    score INTEGER DEFAULT 0
);

CREATE TABLE challenges (
    code SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    flag VARCHAR(255) NOT NULL,
    is_visible BOOLEAN DEFAULT TRUE,
    points INTEGER DEFAULT 0
);

CREATE TABLE solved (
    id SERIAL PRIMARY KEY,
    solved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    -- -------------------------
    user_id INTEGER REFERENCES users(id),
    challenge_code INTEGER REFERENCES challenges(code)
);
```

## _TUTOR_ Scenario

1. Sign in into the platform.
2. View _Available_ challenges.
3. Update challenges _Visibility_ setting.

### Implementation

1. **User Authentication**: Similar to the previous scenario, users must log in to access the platform.
2. **Challenge Availability:** To see all available challenges, the platform should filter challenges based on their availability setting. This requires a `is_available` field in the `challenges` table.
3. **Challenge Management:** This role can update the `is_visible` field in the `challenges` table, allowing tutors to control which challenges are visible to students.

\vspace{0.5cm}

To continue, it is necessary to update the `challenges` table schema to include the `is_available` field:

\vspace{0.5cm}

```sql
CREATE TABLE challenges (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    flag VARCHAR(255) NOT NULL,
    is_visible BOOLEAN DEFAULT TRUE,
    is_available BOOLEAN DEFAULT TRUE,
    solved_by INTEGER[] DEFAULT '{}',
    points INTEGER DEFAULT 0
);
```

## _ADMIN_ Scenario

1. Sign in into the platform.
2. Update challenges _Visibility_ setting.
3. Create/update/remove challenges.

### Implementation

1. **User Authentication**: Similar to the previous scenario.
2. **Availability Management:** The ADMIN role should have the permission to update the `is_visible` field in the `challenges` table, allowing them to control which challenges are visible to students.
3. **Challenge Management:** This role has the permission to add a new row in the `challenges` table, update existing challenges, or delete them. _ADMIN_ can update the `is_available` field in the `challenges` table, allowing tutors to control which challenges are available to students.