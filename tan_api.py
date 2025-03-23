import requests

BASE_URL_PROD = "https://open.tan.fr/ewp"


def get_arrets_proches(latitude: str, longitude: str):
    url = f"{BASE_URL_PROD}/arrets.json/{latitude}/{longitude}"
    response = requests.get(url)
    return response.json()


def get_tous_arrets():
    url = f"{BASE_URL_PROD}/arrets.json"
    response = requests.get(url)
    return response.json()


def get_horaires_arret(code_arret: str, num_ligne: str, sens: int):
    url = f"{BASE_URL_PROD}/horairesarret.json/{code_arret}/{num_ligne}/{sens}"
    response = requests.get(url)
    return response.json()


def get_horaires_arret_date(code_arret: str, num_ligne: str, sens: int, date: str):
    url = f"{BASE_URL_PROD}/horairesarret.json/{code_arret}/{num_ligne}/{sens}/{date}"
    response = requests.get(url)
    return response.json()


def get_temps_attente(code_arret: str):
    url = f"{BASE_URL_PROD}/tempsattente.json/{code_arret}"
    response = requests.get(url)
    return response.json()


def get_temps_attente_passage(code_arret: str, nombre_passages: int):
    url = f"{BASE_URL_PROD}/tempsattentelieu.json/{code_arret}/{nombre_passages}"
    response = requests.get(url)
    return response.json()


def get_temps_attente_passage_ligne(code_arret: str, nombre_passages: int, num_ligne: str):
    url = f"{BASE_URL_PROD}/tempsattentelieu.json/{code_arret}/{nombre_passages}/{num_ligne}"
    response = requests.get(url)
    return response.json()


# Exemple d'utilisation
def main():
    latitude, longitude = "47.264", "-1.585"
    code_arret, num_ligne, sens = "HBLI2", "C5", 1
    date = "2025-03-23"
    nombre_passages = 2
    
    print("Arrets proches:", get_arrets_proches(latitude, longitude))
    print("Tous les arrets:", get_tous_arrets())
    #print("Horaires arrêt:", get_horaires_arret(code_arret, num_ligne, sens))
    #print("Horaires arrêt à une date:", get_horaires_arret_date(code_arret, num_ligne, sens, date))
    print("Temps attente:", get_temps_attente(code_arret))
    print("Temps attente (nombre de passages):", get_temps_attente_passage(code_arret, nombre_passages))
    print("Temps attente (nombre de passages et ligne):", get_temps_attente_passage_ligne(code_arret, nombre_passages, num_ligne))


if __name__ == "__main__":
    main()
