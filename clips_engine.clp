            (defrule ask-food-preference
                =>
                (assert (food-preference pizza))
                (assert (food-preference salad))
            )

            (defrule suggest-food
                (food-preference pizza)
                =>
                (printout t "You should eat pizza! ")
                (assert (food-result pizza))
            )

            (defrule suggest-food-2
                (food-preference salad)
                =>
                (printout t "You should eat salad! ")
                (assert (food-result salad))
            )