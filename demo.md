# Movies ohne Token
curl http://localhost:3000/movies

# Login
curl --data "user[email]=andy@example.com&user[password]=test123" http://localhost:3000/sign_in

# Movies mit Token
curl -H "Authorization: <token>" http://localhost:3000/movies

# Search nach Batman
curl -H "Authorization: <token>" http://localhost:3000/search/batman

# Hinzufuegen zur eigener Liste
curl --data "id=66" -H "Authorization: <token>" http://localhost:3000/movies
