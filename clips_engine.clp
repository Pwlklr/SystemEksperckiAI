
            (deftemplate answer-to-question
                (slot question (type STRING))
                (slot answer (type STRING))
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

            (defrule living-with-parents
                (answer-to-question (question "diet") (answer "no"))
                (answer-to-question (question "with-parents") (answer "unknown"))
                =>
                (assert (ask (question "with-parents")))
            )
            (defrule suggest-food-living-with-parents
                (answer-to-question (question "with-parents") (answer "yes"))
                =>
                (assert (food-result tombstone-pizza))
            )



