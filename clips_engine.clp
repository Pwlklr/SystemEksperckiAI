
            (deftemplate answer-to-question
                (slot question (type STRING))
                (slot answer (type STRING))
            )
            (deftemplate back
                (slot question (type STRING))
            )
            (deftemplate set-unknown
                (slot question (type STRING))
            )
            (deftemplate to-modify
                (slot question (type STRING))
                (slot answer (type STRING))
            )
            (deftemplate ask
                (slot question (type STRING))
            )
            (defrule questions 
                =>
                (assert (answer-to-question (question "japan")(answer "unknown")))
                (assert (answer-to-question (question "unemployed")(answer "unknown")))
                (assert (answer-to-question (question "alaska")(answer "unknown")))
                (assert (answer-to-question (question "diet")(answer "unknown")))
                (assert (answer-to-question (question "vegetarian")(answer "unknown")))
                (assert (answer-to-question (question "vegan")(answer "unknown")))
                (assert (answer-to-question (question "pizza")(answer "unknown")))
                (assert (answer-to-question (question "with-parents")(answer "unknown")))
                (assert (answer-to-question (question "cleaning")(answer "unknown")))
                (assert (answer-to-question (question "who")(answer "unknown")))
                (assert (answer-to-question (question "impress")(answer "unknown")))
                (assert (answer-to-question (question "thirsty")(answer "unknown")))
                (assert (answer-to-question (question "breakfast")(answer "unknown")))
                (assert (answer-to-question (question "summer-2010")(answer "unknown")))
                (assert (answer-to-question (question "jewish")(answer "unknown")))
                (assert (answer-to-question (question "elaine-benes")(answer "unknown")))
                (assert (answer-to-question (question "wow")(answer "unknown")))
                (assert (answer-to-question (question "foreman")(answer "unknown")))
                (assert (answer-to-question (question "dessert")(answer "unknown")))
                (assert (answer-to-question (question "childhood")(answer "unknown")))
                (assert (answer-to-question (question "pie")(answer "unknown")))
                (assert (answer-to-question (question "school")(answer "unknown")))
                (assert (answer-to-question (question "drunk-high")(answer "unknown")))
                (assert (answer-to-question (question "ice-cream")(answer "unknown")))
                (assert (answer-to-question (question "lactose-intolerant")(answer "unknown")))
                (assert (answer-to-question (question "spoon")(answer "unknown")))
                (assert (answer-to-question (question "chain")(answer "unknown")))
                (assert (answer-to-question (question "ethnic")(answer "unknown")))
                (assert (answer-to-question (question "pre-heat")(answer "unknown")))
            )
            (defrule modify-fact
                
                ?g <- (to-modify (question ?x) (answer ?y))
                ?f <- (answer-to-question (question ?x))
                ?h <- (ask (question ?x))
                =>
                (modify ?f (answer ?y))
                (retract ?g)
                (retract ?h)
            )
            (defrule back-rule
                ?g <- (back (question ?x))
                ?f <- (ask (question ?x))
                ?h <- (set-unknown (question ?y))
                ?i <- (answer-to-question (question ?y))
                =>
                (retract ?f)
                (retract ?g)
                (retract ?h)
                (modify ?i (answer "unknown"))
            )
            (defrule japan
                (answer-to-question (question "japan") (answer "unknown"))
                =>
                (assert (ask (question "japan")))
            )
            (defrule suggest-food-japan
                (answer-to-question (question "japan") (answer "yes"))
                =>
                (assert (food-result micro-magic))
            )
            ;;;
            (defrule unemployed
                (answer-to-question (question "japan") (answer "no"))
                (answer-to-question (question "unemployed") (answer "unknown"))
                =>
                (assert (ask (question "unemployed")))
            )           
            (defrule suggest-food-unemployed
                (answer-to-question (question "unemployed") (answer "yes"))
                =>
                (assert (food-result cheddar-potato-bake))
                (assert (food-result country-rick))
                (assert (food-result burrito))
            )
            ;;;
            (defrule alaska
                (answer-to-question (question "unemployed") (answer "no"))
                (answer-to-question (question "alaska") (answer "unknown"))
                =>
                (assert (ask (question "alaska")))
            )
            (defrule suggest-food-alaska
                (answer-to-question (question "alaska") (answer "yes"))
                =>
                (assert (food-result stouffers-bear))
            )
            ;;;
            (defrule diet
                (answer-to-question (question "alaska") (answer "no"))
                (answer-to-question (question "diet") (answer "unknown"))
                =>
                (assert (ask (question "diet")))
            )
            (defrule suggest-food-diet
                (answer-to-question (question "diet") (answer "yes"))
                =>
                (assert (food-result smart-ones))
                (assert (food-result lean-cuisine))
            )
            ;;;
            (defrule vegetarian
                (answer-to-question (question "diet") (answer "no"))
                (answer-to-question (question "vegetarian") (answer "unknown"))
                =>
                (assert (ask (question "vegetarian")))
            )
            ;;;
            (defrule vegan
                (answer-to-question (question "vegetarian") (answer "yes"))
                (answer-to-question (question "vegan") (answer "unknown"))
                =>
                (assert (ask (question "vegan")))
            )
            (defrule suggest-food-vegan
                (answer-to-question (question "vegan") (answer "no"))
                =>
                (assert (food-result enchilada))
                (assert (food-result tamales))
            )
            (defrule suggest-food-vegan-2
                (answer-to-question (question "vegan") (answer "yes"))
                =>
                (assert (food-result tofurky))
                (assert (food-result boca))
            )
            ;;;
            (defrule pizza
                (answer-to-question (question "vegetarian") (answer "no"))
                (answer-to-question (question "pizza") (answer "unknown"))
                =>
                (assert (ask (question "pizza")))
            )
            ;;;
            (defrule living-with-parents
                (answer-to-question (question "pizza") (answer "yes"))
                (answer-to-question (question "with-parents") (answer "unknown"))
                =>
                (assert (ask (question "with-parents")))
            )
            (defrule suggest-food-living-with-parents
                (answer-to-question (question "with-parents") (answer "yes"))
                =>
                (assert (food-result tombstone-pizza))
                (assert (food-result crisp-crust))
                (assert (food-result tonys-original-crust))
                (assert (food-result celeste))
            )
            ;;;
            (defrule impress
                (answer-to-question (question "with-parents") (answer "no"))
                (answer-to-question (question "impress") (answer "unknown"))
                =>
                (assert (ask (question "impress")))
            )
            (defrule suggest-food-impress-yes
                (answer-to-question (question "impress") (answer "yes"))
                =>
                (assert (food-result crispy-thin-crust))
            )
            (defrule suggest-food-impress-no
                (answer-to-question (question "impress") (answer "no"))
                =>
                (assert (food-result stone-hearth))
                (assert (food-result for-one))
                (assert (food-result naturally-rising))
            )
            ;;;
            (defrule cleaning
                (answer-to-question (question "pizza") (answer "no"))
                (answer-to-question (question "cleaning") (answer "unknown"))
                =>
                (assert (ask (question "cleaning")))
            )
            (defrule suggest-food-cleaning
                (answer-to-question (question "cleaning") (answer "yes"))
                =>
                (assert (food-result banquet-meal))
                (assert (food-result swanson))
            )
            ;;;
            (defrule doctor-who
                (answer-to-question (question "cleaning") (answer "no"))
                (answer-to-question (question "who") (answer "unknown"))
                =>
                (assert (ask (question "who")))
            )
            (defrule suggest-food-doctor-who
                (answer-to-question (question "who") (answer "yes"))
                =>
                (assert (food-result ben-and-jerrys))
            )
            ;;;
            (defrule thirsty
                (answer-to-question (question "who") (answer "no"))
                (answer-to-question (question "thirsty") (answer "unknown"))
                =>
                (assert (ask (question "thirsty")))
            )
            (defrule suggest-food-thirsty-yes
                (answer-to-question (question "thirsty") (answer "yes"))
                =>
                (assert (food-result minute-maid))
            )
            ;;;
            (defrule breakfast
                (answer-to-question (question "thirsty") (answer "no"))
                (answer-to-question (question "breakfast") (answer "unknown"))
                =>
                (assert (ask (question "breakfast")))
            )
            ;;;
            (defrule jewish
                (answer-to-question (question "breakfast") (answer "no"))
                (answer-to-question (question "jewish") (answer "unknown"))
                =>
                (assert (ask (question "jewish")))
            )
            (defrule suggest-food-jewish-yes
                (answer-to-question (question "jewish") (answer "yes"))
                =>
                (assert (food-result gabilas))
            )
            ;;;
            (defrule summer-2010
                (answer-to-question (question "breakfast") (answer "yes"))
                (answer-to-question (question "summer-2010") (answer "unknown"))
                =>
                (assert (ask (question "summer-2010")))
            )
            (defrule suggest-food-summer-2010-no
                (answer-to-question (question "summer-2010") (answer "no"))
                =>
                (assert (food-result bob-evans-brunch-bowls))
                (assert (food-result croissant))
                (assert (food-result bagel-shoppe))
                (assert (food-result toaster-strudel))
            )
            ;;;
            (defrule elaine-benes
                (answer-to-question (question "summer-2010") (answer "yes"))
                (answer-to-question (question "elaine-benes") (answer "unknown"))
                =>
                (assert (ask (question "elaine-benes")))
            )
            (defrule suggest-food-elaine-benes-yes
                (answer-to-question (question "elaine-benes") (answer "yes"))
                =>
                (assert (food-result muffin-tops))
            )
            (defrule suggest-food-elaine-benes-no
                (answer-to-question (question "elaine-benes") (answer "no"))
                =>
                (assert (food-result eggo))
                (assert (food-result toaster-sticks))
            )
            ;;;
            (defrule wow
                (answer-to-question (question "jewish") (answer "no"))
                (answer-to-question (question "wow") (answer "unknown"))
                =>
                (assert (ask (question "wow")))
            )
            (defrule suggest-food-wow-yes
                (answer-to-question (question "wow") (answer "yes"))
                =>
                (assert (food-result hungry-man))
            )
            ;;;
            (defrule foreman
                (answer-to-question (question "wow") (answer "no"))
                (answer-to-question (question "foreman") (answer "unknown"))
                =>
                (assert (ask (question "foreman")))
            )
            (defrule suggest-food-foreman-yes
                (answer-to-question (question "foreman") (answer "yes"))
                =>
                (assert (food-result tyson-chicken-breasts))
            )
            ;;;
            (defrule dessert
                (answer-to-question (question "foreman") (answer "no"))
                (answer-to-question (question "dessert") (answer "unknown"))
                =>
                (assert (ask (question "dessert")))
            )
            ;;;
            (defrule childhood
                (answer-to-question (question "dessert") (answer "yes"))
                (answer-to-question (question "childhood") (answer "unknown"))
                =>
                (assert (ask (question "childhood")))
            )
            (defrule suggest-food-childhood-yes
                (answer-to-question (question "childhood") (answer "yes"))
                =>
                (assert (food-result orange-cherry-grape-popsicles))
                (assert (food-result 100-otter-pops))
                (assert (food-result strawberry-shortcake))
            )
            ;;;
            (defrule pie
                (answer-to-question (question "childhood") (answer "no"))
                (answer-to-question (question "pie") (answer "unknown"))
                =>
                (assert (ask (question "pie")))
            )
            (defrule suggest-food-pie-yes
                (answer-to-question (question "pie") (answer "yes"))
                =>
                (assert (food-result mrs-smiths-apple-pie))
                (assert (food-result oreo-cream-pie))
                (assert (food-result sara-lee-apple-pie))
                (assert (food-result marie-callenders-lattice-apple-pie))
            )
            ;;;
            (defrule school
                (answer-to-question (question "dessert") (answer "no"))
                (answer-to-question (question "school") (answer "unknown"))
                =>
                (assert (ask (question "school")))
            )
            (defrule suggest-food-school-yes
                (answer-to-question (question "school") (answer "yes"))
                =>
                (assert (food-result kid-cuisine))
                (assert (food-result french-bread-pizza))
                (assert (food-result super-pretzel))
            )
            ;;;
            (defrule drunk-high
                (answer-to-question (question "school") (answer "no"))
                (answer-to-question (question "drunk-high") (answer "unknown"))
                =>
                (assert (ask (question "drunk-high")))
            )
            (defrule suggest-food-drunk-high-yes
                (answer-to-question (question "drunk-high") (answer "yes"))
                =>
                (assert (food-result white-castle-hamburgers))
                (assert (food-result hot-pockets-four-cheese-pizza))
                (assert (food-result totinos-pizza-rolls))
                (assert (food-result kraft-bagelfuls-original))
                (assert (food-result bagel-bites-three-cheese))
                (assert (food-result corn-dogs))
                (assert (food-result gortons-crunchy-fish-sticks))
                (assert (food-result tgi-fridays-potato-skins))
                (assert (food-result tyson-anytizers))
                (assert (food-result jimmy-dean-pancakes-and-sausage-on-a-stick))
            )
            ;;;
            (defrule ice-cream
                (answer-to-question (question "pie") (answer "no"))
                (answer-to-question (question "ice-cream") (answer "unknown"))
                =>
                (assert (ask (question "ice-cream")))
            )
            (defrule suggest-food-ice-cream-no
                (answer-to-question (question "ice-cream") (answer "no"))
                =>
                (assert (food-result puff-pastry-turnovers))
                (assert (food-result sara-lee-cheeskake))
                (assert (food-result chocolate-fudge))
                (assert (food-result cool-whip))
            )
            ;;;
            (defrule lactose-intolerant
                (answer-to-question (question "ice-cream") (answer "yes"))
                (answer-to-question (question "lactose-intolerant") (answer "unknown"))
                =>
                (assert (ask (question "lactose-intolerant")))
            )
            (defrule suggest-food-lactose-intolerant-yes
                (answer-to-question (question "lactose-intolerant") (answer "yes"))
                =>
                (assert (food-result so-delicious-dairy-free))
            )
            ;;;
            (defrule spoon
                (answer-to-question (question "lactose-intolerant") (answer "yes"))
                (answer-to-question (question "spoon") (answer "unknown"))
                =>
                (assert (ask (question "spoon")))
            )
            (defrule suggest-food-spoon-yes
                (answer-to-question (question "spoon") (answer "yes"))
                =>
                   (assert (food-result ben-and-jerrys-phish-food))
                   (assert (food-result breyers-reeses-peanut-butter-cups))
                   (assert (food-result haagen-dazs-vanilla-bean))
                   (assert (food-result blue-bell-ice-cream))
                   (assert (food-result edys-slow-churned-chocolate-chip))
                   (assert (food-result turkey-hill-chocolate-peanut-butter-cup))
            )(defrule suggest-food-spoon-no
                (answer-to-question (question "spoon") (answer "no"))
                =>
                   (assert (food-result klondike-original))
                   (assert (food-result toll-house-chocolate-chip-cookie-sandwich))
                   (assert (food-result drumstick-cone))
                   (assert (food-result fat-boy))
            )
            ;;;
            (defrule ethnic
                (answer-to-question (question "drunk-high") (answer "no"))
                (answer-to-question (question "ethnic") (answer "unknown"))
                =>
                (assert (ask (question "ethnic")))
            )
            (defrule suggest-food-ethnic-yes
                (answer-to-question (question "ethnic") (answer "yes"))
                =>
                (assert (food-result tai-pei-teriyaki))
                (assert (food-result chicken-tikka-masala))
                (assert (food-result ling-ling-popstickers))
                (assert (food-result don-miguel-tacos))
            )
            ;;;
            (defrule chain
                (answer-to-question (question "ethnic") (answer "no"))
                (answer-to-question (question "chain") (answer "unknown"))
                =>
                (assert (ask (question "chain")))
            )
            (defrule suggest-food-chain-yes
                (answer-to-question (question "chain") (answer "yes"))
                =>
                (assert (food-result claim-jumper-spaghetti-and-meatballs))
                (assert (food-result marie-callenders-honey-roasted-turkey))
                (assert (food-result stouffers-macaroni-beef))
                (assert (food-result boston-turkey-breast-medalion))
            )
            ;;;
            (defrule pre-heat
                (answer-to-question (question "chain") (answer "no"))
                (answer-to-question (question "pre-heat") (answer "unknown"))
                =>
                (assert (ask (question "pre-heat")))
            )
            (defrule suggest-food-pre-heat-yes
                (answer-to-question (question "pre-heat") (answer "yes"))
                =>
                (assert (food-result ore-ida-steak-fries))
                (assert (food-result ore-ida-tater-tots))
                (assert (food-result original-poppers-cream-cheese))
                (assert (food-result michael-angelos-lasagna))
            )
            (defrule suggest-food-pre-heat-no
                (answer-to-question (question "pre-heat") (answer "no"))
                =>
                (assert (food-result smuckers-uncrustables))
            )
