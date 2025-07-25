### Câu 1: How does `form_for` build an HTML form with PUT/PATCH method?

When using `form_for` (or `form_with model: @user`), if the object already exists in the database (e.g., `@user` is not a new record), Rails treats the form as an update action.  
Since HTML forms only support GET and POST, Rails simulates PUT or PATCH by:

- Creating a `<form>` tag with `method="post"`.
- Adding a hidden input: `<input type="hidden" name="_method" value="patch">`.

When submitted, Rails reads the `_method` field and processes the request as PATCH (or PUT), routing it to the update action.

---

### Câu 2: Why use `allow_nil: true`?

Adding `allow_nil: true` to password validation (e.g., `validates :password, ..., allow_nil: true`) lets users update other attributes (like name or email) without re-entering their password.  
Without `allow_nil: true`, every update would require the password field to be filled, causing "Password can't be blank" errors if left empty.  
`allow_nil: true` skips password validation only when the password field is nil (not sent from the form).

---

### Câu 3: Why define `redirect_back_or` and `store_location` methods?

These methods implement Friendly Forwarding:

- `store_location`: Saves the intended URL (`request.original_url`) in `session[:forwarding_url]` when a non-logged-in user tries to access a protected page.
- `redirect_back_or(default_url)`: After login, checks for `session[:forwarding_url]`:
    - If present, redirects to that URL.
    - If absent, redirects to a default URL (e.g., user profile).

**Purpose:** Improves user experience by ensuring users return to their intended page after logging in.
