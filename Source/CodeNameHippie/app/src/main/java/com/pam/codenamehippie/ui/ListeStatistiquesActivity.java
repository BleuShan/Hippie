package com.pam.codenamehippie.ui;

import android.os.Bundle;
import android.util.Log;
import android.widget.ExpandableListView;

import com.pam.codenamehippie.HippieApplication;
import com.pam.codenamehippie.R;
import com.pam.codenamehippie.modele.AlimentaireModele;
import com.pam.codenamehippie.modele.TransactionModele;
import com.pam.codenamehippie.modele.depot.AlimentaireModeleDepot;
import com.pam.codenamehippie.modele.depot.ObservateurDeDepot;
import com.pam.codenamehippie.modele.depot.TransactionModeleDepot;
import com.pam.codenamehippie.ui.adapter.ListeStatistiquesAdapter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by Carl St-Louis le 2016-02-08.
 */
public class ListeStatistiquesActivity extends HippieActivity
    implements ObservateurDeDepot<TransactionModele>{

    private static final String TAG = ListeStatistiquesActivity.class.getSimpleName();
    private ExpandableListView listeStatistiques;
    private ListeStatistiquesAdapter statistiquesAdapter;
    private Integer orgId;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setContentView(R.layout.liste_statistiques);

        //TODO: Vérifier si AlimentaireModeleDepot ou TransactionModeleDepot
        TransactionModeleDepot transactionModeleDepot =
                ((HippieApplication) this.getApplication()).getTransactionModeleDepot();

        // On va chercher l'expendable listView
        listeStatistiques = (ExpandableListView)findViewById(R.id.list_statistiques_group);
        statistiquesAdapter = new ListeStatistiquesAdapter(this);
        listeStatistiques.setAdapter(statistiquesAdapter);
        this.orgId = this.sharedPreferences.getInt(this.getString(R.string.pref_org_id_key),
                -1
        );
    }


    @Override
    protected void onPause() {
        super.onPause();
       TransactionModeleDepot transactionModeleDepot =
                ((HippieApplication) this.getApplication()).getTransactionModeleDepot();
        transactionModeleDepot.setFiltreDeListe(null);
        transactionModeleDepot.supprimerTousLesObservateurs();
    }

    @Override
    protected void onResume() {
        super.onResume();
        TransactionModeleDepot transactionModeleDepot =
                ((HippieApplication) this.getApplication()).getTransactionModeleDepot();
        transactionModeleDepot.ajouterUnObservateur(this);
        this.sharedPreferences.getInt(this.getString(R.string.pref_org_id_key),
                -1
        );
        if (this.orgId != null && orgId != -1) {
            // TODO: Ajouter 2 DatePicker dans le layout list_statistique
            Calendar calendar = Calendar.getInstance();
            calendar.set(Calendar.YEAR, 2014);
            Date dateDebut = calendar.getTime();
            calendar = Calendar.getInstance();
            Date dateFin = calendar.getTime();
            transactionModeleDepot.peuplerTransactions(this.orgId, dateDebut, dateFin);
        }
    }

    @Override
    public void surDebutDeRequete() {
        this.afficherLaProgressBar();
    }

    @Override
    public void surChangementDeDonnees(ArrayList<TransactionModele> modeles) {
        this.statistiquesAdapter.setItems(modeles);

    }

    @Override
    public void surFinDeRequete() {
        this.cacherLaProgressbar();
    }

    @Override
    public void surErreur(IOException e) {
        //todo: snackbar
        Log.e(this.getClass().getSimpleName(), e.getMessage(), e);

    }
}
