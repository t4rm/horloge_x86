;   +==========+================+==============+    ;
;   | SAE 2.03 | MECHKENE TAREK | DEBRA ALEXIS |    ;
;   +==========+================+==============+    ;

.model small
.stack 100h

;   +--------------------------+    ;
;     Définition des variables      ;
;   +--------------------------+    ;

.data
    menu db 0ah, 0dh, 'Menu:', 0ah, 0dh, '$'
    option1 db '1. Heure Mondiale', 0ah, 0dh, '$'
    option2 db '2. Chronometre', 0ah, 0dh, '$'
    option3 db '3. Compte a rebours', 0ah, 0dh, '$'
    option4 db '1. Heure LOCAL', 0ah, 0dh, '$'
    option5 db '2. Heure NEW YORK', 0ah, 0dh, '$'
    option6 db '3. Heure TOKYO', 0ah, 0dh, '$'
    option7 db '4. Heure LONDRES', 0ah, 0dh, '$'
    option8 db '5. Heure MOSCOU', 0ah, 0dh, '$'
	option9 db '6. Heure SHANGHAI/PEKIN', 0ah, 0dh, '$'
    message db 'Entrez votre choix: $'
    invalide db 'Choix invalide. Recommencez.', 0ah, 0dh, '$'
    hour_var db 0 
    min_var db 0
    sec_var db 0
    pos db 0
    fuseau db 0
    hours db 0
    minutes db 1
    seconds db 0
	L1 db " ______________________     __     __________   ________", 0ah, 0dh, '$'
	L2 db " |  |  ||______|      |_____||____/ |______| \  ||______", 0ah, 0dh, '$'
	L3 db " |  |  ||______|_____ |     ||    \_|______|  \_||______", 0ah, 0dh, '$'
	L4 db " ______ _____________  _____________                    ", 0ah, 0dh, '$'
	L5 db " |     \|______|_____]|_____/|_____|                    ", 0ah, 0dh, '$'
	L6 db " |_____/|______|_____]|    \_|     |                    ", 0ah, 0dh, '$'
	L7 db " _     _ _____  ______       _____  _____________       ", 0ah, 0dh, '$'
	L8 db " |_____||     ||_____/|     |     ||  ____|______       ", 0ah, 0dh, '$'
	L9 db " |     ||_____||    \_|_____|_____||_____||______       ", 0ah, 0dh, '$'
	L26 db 'SAE 2.03 ASSEMBLEUR : M. AILLERIE', 0ah, 0dh, '$'
	
	; 0ah -> Saut de ligne // 0dh -> Retour Chariot // $ -> Fin de chaine


;    +--------------------+  ;
;      Début du programme    ;
;    +--------------------+  ;

.code
    main proc
        mov ax, @data
        mov ds, ax
    ; Initialisation du registre de donnée
         
	
;   +----------------------------------------------------------------+  ;
;     Affichage d'un léger text ASCII lors du lancement du programme    ;
;   +----------------------------------------------------------------+  ;

	afficheascii:
		mov ax, 3
		int 10h ; Nettoyage de l'écran
		
		mov cx, 9 ; Nombre de variables à afficher
		mov di, offset L1 ; Adresse de départ de la première variable

		afficher_variable:
		lea dx, [di] 
		mov ah, 09h ; Affiche la variable
		int 21h
		add di, 59              ; Décalage pour accéder à la variable suivante (10 caractères + 0ah + 0dh + '$')

		cmp di, offset L9 + 59  ; Compare avec l'adresse de départ de la dernière variable + décalage
		jbe afficher_variable   ; Sauter à "afficher_variable" tant que di est inférieur ou égal à l'adresse de L3 + décalage

	
;    +--------------------------------------------+  ;
;      Menu principal utilisé en quasi-permanence    ;
;    +--------------------------------------------+  ;
	
    menu_loop:
    
        mov hour_var, 0    ; Initialiser les heures à zéro
        mov min_var, 0     ; Initialiser les minutes à zéro
        mov sec_var, 0     ; Initialiser les secondes à zéro

        mov hours, 0    ; Initialiser les heures à zéro
        mov minutes, 10     ; Initialiser le compte à rebours pour durer toute la soutenance ;)
        mov seconds, 0     ; Initialiser les secondes à zéro

        mov ah, 09h         ; Affiche le titre du menu
        lea dx, menu
        int 21h
        
        mov ah, 09h         ; Affiche les options du menu
        lea dx, option1
        int 21h

        mov ah, 09h
        lea dx, option2
        int 21h

        mov ah, 09h
        lea dx, option3
        int 21h

        mov ah, 09h         ; Affiche le message pour la saisie
        lea dx, message
        int 21h

        mov ah, 01h         ; Lit le caractère entré par l'utilisateur
        int 21h

        cmp al, '1'         ; Vérifie le choix de l'utilisateur
        je option1_selected
        cmp al, '2'
        je option2_selected
        cmp al, '3'
        je option3_selected

        mov ah, 09h         ; Affiche un message d'erreur pour un choix invalide
        lea dx, invalide
        int 21h

        mov ax, 3
        int 10h ; nettoie écran

        jmp menu_loop
        
;   +-----------------------------------------------------------------------------------+   ;
;     Sous-menu pour l'affichage de différentes heures après la sélection de l'option 1     ;
;   +-----------------------------------------------------------------------------------+   ;

	option1_selected:
        mov ax, 3
        int 10h ; nettoie écran

        mov ah, 09h         ; Affiche les options du menu
        lea dx, option4
        int 21h

        mov ah, 09h
        lea dx, option5
        int 21h

        mov ah, 09h
        lea dx, option6
        int 21h
        
        mov ah, 09h
        lea dx, option7
        int 21h

        mov ah, 09h
        lea dx, option8
        int 21h
        
        mov ah, 09h
        lea dx, option9
        int 21h

        mov ah, 01h         ; Lit le caractère entré par l'utilisateur
        int 21h

        cmp al, '1'         ; Vérifie le choix de l'utilisateur
        je option4_selected
        cmp al, '2'
        je option5_selected
        cmp al, '3'
        je option6_selected 
        cmp al, '4'
        je option7_selected
        cmp al, '5'
        je option8_selected
        cmp al, '6'
        je option9_selected
        
        jmp menu_loop
    
;   +---------------------------------+ ;
;     Sélection de l'option 2 du menu   ;
;   +---------------------------------+ ;

    option2_selected:
        ; ---
        mov ah, 01h         ; Lit le caractère entré par l'utilisateur
        int 16h
        jz chrono ; Si aucune touche n'est pressée on loop

        cmp al, '0'         ; Si une touche est pressée : Vérifie si le bouton 0 est pressé pour revenir au menu principal
        je menu_loop
        
        cmp al, '1'
        je stop_chrono
        
        jmp chrono ; On retourne au menu dcp
        ; ---
            
;   +---------------------------------+ ;
;     Sélection de l'option 3 du menu   ;
;   +---------------------------------+ ;

    option3_selected:
        ; ---
        mov ah, 01h         ; Lit le caractère entré par l'utilisateur
        int 16h
        jz opt3 ; Si aucune touche n'est pressée on loop

        cmp al, '0'         ; Si une touche est pressée : Vérifie si le bouton 0 est pressé pour revenir au menu principal
        je menu_loop ; Pas le cas ? on loop

        cmp al, '1'
        je stop_countdown

        jmp opt3 ; On retourne au menu dcp
        ; ---       
        
;   +--------------------------------------+    ;
;     Sélection de l'option 1 du sous-menu      ;
;   +--------------------------------------+    ;     

        option4_selected: ; Locale
            mov pos, 0
            mov fuseau, 0
            jmp hour
            
;   +--------------------------------------+    ;
;     Sélection de l'option 2 du sous-menu      ;
;   +--------------------------------------+    ; 
  
        option5_selected: ; New York
            mov pos, 2
            mov fuseau, 6
            jmp hour

;   +--------------------------------------+    ;
;     Sélection de l'option 3 du sous-menu      ;
;   +--------------------------------------+    ;   

        option6_selected: ; Tokyo
            mov pos, 1 ; Active le booléen en mode positif
            mov fuseau, 7
            jmp hour
            
;   +--------------------------------------+    ;
;     Sélection de l'option 4 du sous-menu      ;
;   +--------------------------------------+    ;   
            
        option7_selected: ; Londre
            mov pos, 2
            mov fuseau, 1
            jmp hour

;   +--------------------------------------+    ;
;     Sélection de l'option 5 du sous-menu      ;
;   +--------------------------------------+    ;   

        option8_selected: ; Moscou
            mov pos, 1 ; Active le booléen 
            mov fuseau, 1
            jmp hour

;   +--------------------------------------+    ;
;     Sélection de l'option 6 du sous-menu      ;
;   +--------------------------------------+    ;   
        
        option9_selected: ; Shanghai 
            mov pos, 1 ; Active le booléen 
            mov fuseau, 6
            jmp hour


;	+=====================================================+		;
;	| Étiquettes utilisées par l'Option 1 (Heure Mondial) |		;
;	+=====================================================+		;
   
        hour: ; Obtient l'heure locale
			mov ax, 3
			int 10h

			mov ah, 2ch    ; Obtenir l'heure système [HH dans ch, MM dans cl, SS dans dh]
			int 21h        ; Interruption DOS pour obtenir l'heure

			cmp pos, 1
			je hourfuse

			cmp pos, 2
			je hourdefu

        boucle:
            mov al, ch     ; Heures dans ch
            call afficheur      ; Appeler la procédure afficheur pour afficher les heures

            mov dl, ':'    ; Copier ':' dans dl pour l'afficher
            mov ah, 02h    ; Copier 02 dans ah
            int 21h        ; Interruption DOS pour afficher le contenu de dl, c'est-à-dire :

            mov al, cl     ; Minutes dans cl
            call afficheur      ; Appeler la procédure afficheur pour afficher les minutes

            mov dl, ':'    ; Afficher ':' comme ci-dessus
            mov ah, 02h
            int 21h

            mov al, dh     ; Secondes dans dh comme SS
            call afficheur      ; Appeler la procédure afficheur pour afficher les secondes

            mov dl, 0Dh    ; Afficher 0D [0D représente \r]
            mov ah, 02h
            int 21h

            mov dl, 0Ah    ; Afficher 0A [0A représente \n]
            mov ah, 02h
            int 21h

            mov ah, 2Ah    ; Obtenir la date système [JJ dans dl, MM dans dh, AAAA dans cx]
            int 21h        ; Interruption DOS pour obtenir la date

			; Amélioration possible : Enregistrer un boolean et vérifier si celui-ci vaut 0, 1 ou 2. S'il vaut 1 on effectue un ajout de 1 jour tout en vérifiant que le mois et l'année n'ont pas changé. S'il vaut 2 on effectue la même opération en régréssant d'1 jour.

            mov al, dl     ; Jour dans dl
            call afficheur      ; Appeler la procédure afficheur pour afficher le jour
            mov dl, '/'    ; Afficher '/'
            mov ah, 02h
            int 21h

            mov al, dh     ; Mois dans dh
            call afficheur      ; Appeler la procédure afficheur pour afficher le mois
            mov dl, '/'    ; Afficher '/'
            mov ah, 02h
            int 21h

            add cx, 0F830h ; Ajouter 0F830 pour ajuster les effets hexadécimaux sur l'année
            mov ax, cx     ; Année dans ax
            call afficheur      ; Appeler la procédure afficheur pour afficher l'année

            mov dl, 0Dh    ; Afficher 0D [\r]
            mov ah, 02h
            int 21h

            mov dl, 0Ah    ; Afficher 0A [\n]
            mov ah, 02h
            int 21h

            call delai_seconde
                
            mov ah, 01h         ; Lit le caractère entré par l'utilisateur
            int 16h
            jz hour ; Si aucune touche n'est pressée on loop

            cmp al, '0'         ; Si une touche est pressée : Vérifie si le bouton 0 est pressé pour revenir au menu principal
            jne hour ; Pas le cas ? on loop
            jmp menu_loop ; On retourne au menu dcp


        skip_ajustement:
            jmp boucle ; Revenir à la boucle principale

        hourfuse:
                add ch, fuseau
                cmp ch, 24
                jl skip_ajustement  ; Si les heures sont supérieures ou égales à 24, sauter l'ajustement
                sub ch, 24 ; Soustraire 24 pour revenir à une heure valide (après minuit)
                jmp boucle
        
        hourdefu:
                sub ch, fuseau
                cmp ch, 0
                jge skip_ajustement  ; Si les heures sont supérieures ou égales à 0, sauter l'ajustement
                add ch, 24 ; Ajouter 24 pour revenir à une heure valide (avant minuit)
                jmp boucle


;	+=====================================+	;
;	| Étiquettes utilisées par l'Option 2 |	;
;	+=====================================+	;

        chrono:
            call delai_seconde

            mov ax, 3
            int 10h

            mov al, hour_var
            call afficheur ; Afficher heures

            mov dl, ':'    ; Afficher ':'
            mov ah, 02h
            int 21h

            mov al, min_var ; Afficher les minutes
            call afficheur

            mov dl, ':'    ; Afficher ':'
            mov ah, 02h
            int 21h

            mov al, sec_var ; Afficher les secondes
            call afficheur

            mov dl, 0Dh    ; Afficher '\r'
            mov ah, 02h
            int 21h

            mov dl, 0Ah    ; Afficher '\n'
            mov ah, 02h
            int 21h

            inc sec_var    ; Augmenter les secondes de 1

            cmp sec_var, 60         ; Vérifier si les secondes ont atteint 60
            jne option2_selected            ; Si non, passer à l'étape suivante

            mov sec_var, 0          ; Réinitialiser les secondes à zéro
            inc min_var             ; Augmenter les minutes de 1

            cmp min_var, 60         ; Vérifier si les minutes ont atteint 60
            jne option2_selected            ; Si non, passer à l'étape suivante

            mov min_var, 0          ; Réinitialiser les minutes à zéro
            inc hour_var            ; Augmenter les heures de 1

            cmp hour_var, 24        ; Vérifier si les heures ont atteint 24
            jne option2_selected            ; Si non, passer à l'étape suivante

            mov hour_var, 0         ; Réinitialiser les heures à zéro
            jmp chrono
            
            
		stop_chrono:
			jmp check_key2
					
		check_key2:
			mov ah, 07h         ; Lit le caractère entré par l'utilisateur
			int 21h

			cmp al, '2'
			je chrono       ; Si la touche pressée n'est pas 'p', retourne à check_key pour lire un autre caractère

			cmp al, '0'
			je menu_loop

			jmp check_key2 

;	+=====================================+	;
;	| Étiquettes utilisées par l'Option 3 |	;
;	+=====================================+	;

		countdown:
			call delai_seconde

			cmp seconds, 0
			jne decrement_second

			cmp minutes, 0
			jne decrement_minutes

			cmp hours, 0
			jne decrement_hours

			jmp option3_selected

		stop_countdown:
			jmp check_key

		check_key:
			mov ah, 07h         ; Lit le caractère entré par l'utilisateur
			int 21h

			cmp al, '2'
			je opt3       ; Si la touche pressée n'est pas 'p', retourne à check_key pour lire un autre caractère

			cmp al, '0'
			je menu_loop

			jmp check_key 
			    

		decrement_second:
			dec seconds
			jmp option3_selected

		decrement_minutes:
			dec minutes
			mov seconds, 59
			cmp minutes, 0
			jge option3_selected
			mov minutes, 59
			dec hours
			jmp option3_selected


		decrement_hours:
			dec hours
			mov minutes, 59
			mov seconds, 59
			jmp option3_selected

		opt3:
			mov ax, 3
			int 10h

			mov al, hours
			call afficheur
			mov dl, ':'
			mov ah, 02h
			int 21h

			mov al, minutes
			call afficheur
			mov dl, ':'
			mov ah, 02h
			int 21h

			mov al, seconds
			call afficheur
			mov dl, ' '
			mov ah, 02h
			int 21h

			jmp countdown

    
;	+===================================+	;
;	| Étiquettes et procédures globales |	;
;	+===================================+	;

	delai_seconde:
		MOV cx, 0FH
		MOV dx, 4240H
		MOV ah, 86H
		INT 15H ; Attente d'1 million de microseconde (1 seconde)
		ret
    
    afficheur proc          ; Début de la procédure afficheur
        aam            ; Ajustement ASCII après multiplication [registre ax]
        mov bx, ax     ; Chargement de la valeur ajustée dans bx
        add bx, 3030h  ; Ajouter 3030 pour afficher correctement les données

        mov dl, bh     ; Afficher le premier chiffre des données
        mov ah, 02h
        int 21h
        mov dl, bl     ; Afficher le deuxième chiffre des données
        mov ah, 02h
        int 21h
        ret            ; Retour de la procédure

    afficheur endp          ; Fin de la procédure afficheur

    main endp
end main

