**Polity CFA

sem (Polity -> zEffectiveness zPol_Imp zPol_Int zActive_Pol zTurnout, ), method(mlmv) latent(Polity) cov(Polity@1) means(Polity@0) nocapslatent
predict Polity, latent(Polity)
