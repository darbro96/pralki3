<nav class="navbar navbar-expand-md bg-dark navbar-dark">

        <a class="navbar-brand" href="/panel"> <img src="/resources/img/logo_w.png" alt="Logo" style="width:40px;"> Internetowa rezerwacja prania</a>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="collapsibleNavbar">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/panel">Start</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/reservations">Twoje rezerwacje</a>
                </li>
            </ul>

            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                        Zalogowany jako: <b>${loggedUser.name} ${loggedUser.lastName}</b>
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="/profil"><s:message code="menu.profil" /></a>
                        <a class="dropdown-item" href="/logout">Wyloguj</a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>