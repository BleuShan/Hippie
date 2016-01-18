package com.pam.codenamehippie.modele;

import android.content.Context;
import android.util.Log;

import com.google.gson.reflect.TypeToken;
import com.squareup.okhttp.Callback;
import com.squareup.okhttp.HttpUrl;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.Response;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;

/**
 * Créé par Carl St-Louis le 23-11-2015.
 */

public class OrganismeModeleDepot extends BaseModeleDepot<OrganismeModele> {

    private static final String TAG = OrganismeModeleDepot.class.getSimpleName();


    private HttpUrl listeOrganismeDonneur;


    private volatile ArrayList<OrganismeModele> listeDonneur;

    /**
     * Construction du dépot pour modèle Organisme
     */
    public OrganismeModeleDepot(Context context, OkHttpClient httpClient) {
        super(context, httpClient);
        this.listeOrganismeDonneur = this.url.newBuilder().addPathSegment("carte").build();
        this.url = this.url.newBuilder().addPathSegment("organisme").build();

    }


    public void peuplerListeDonneur() {
        Request listeOrganismeDonneur = new Request.Builder().url(this.listeOrganismeDonneur).get().build();

        this.httpClient.newCall(listeOrganismeDonneur).enqueue(new Callback() {
            @Override
            public void onFailure(Request request, IOException e) {
                //TODO toast ou whatever

                Log.e(TAG, "Request failed: " + request.toString(), e);
            }

            @Override
            public void onResponse(Response response) throws IOException {
                if (!response.isSuccessful()) {
                    Log.e(TAG, "Request failed: " + response.toString());
                } else {
                    Type type = new TypeToken<ArrayList<OrganismeModele>>() { }.getType();

                    OrganismeModeleDepot.this.listeDonneur =
                            gson.fromJson(response.body().charStream(), type);

                    Log.d(TAG,
                            "Liste Donneur: " +
                                    OrganismeModeleDepot.this.listeDonneur.toString()
                    );
                }
            }
        });

    }

    //    /**
//     * Rechercher un OrganismeModele par ID dans le dépôt
//     *
//     * @param id
//     *   de l'objet OrganismeModele
//     *
//     * @return un OrganismeModele ou null si inexistant dans le dépôt
//     */
//    @Override
//    public OrganismeModele rechercherParId(Integer id) {
//        OrganismeModele modele = this.modeles.get(id);
//        if (modele != null) {
//            return this.modeles.get(id);
//        } else {
//            return null;
//        }
//    }

//    /**
//     * Ajouter un nouveau OrganismeModele dans le dépôt
//     *
//     * @param json
//     *   de l'objet OrganismeModele
//     *
//     * @return une nouvelle instance de OrganismeModele vide ou null si l'organisme existe déjà
//     */
//    @Override
//    public OrganismeModele ajouterModele(String json) {
//        OrganismeModele modele = this.gson.fromJson(json, OrganismeModele.class);
//        if (this.modeles.get(modele.getId()) == null) {
//            this.modeles.put(modele.getId(), modele);
//            // todo: requête au serveur pour ajouter un organisme
//            return modele;
//        } else {
//            return null;
//        }
//    }

//    /**
//     * Modifier un OrganismeModele présent dans le dépôt
//     *
//     * @param modele
//     *   de l'objet OrganismeModele
//     *
//     * @return un OrganismeModele ou null si inexistant dans le dépôt
//     */
//    @Override
//    public OrganismeModele modifierModele(OrganismeModele modele) {
//        OrganismeModele oldModele = this.modeles.get(modele.getId());
//
//        if (oldModele != null) {
//            // todo: requête au serveur pour modification sur l'organisme
//            return oldModele;
//        } else {
//            return null;
//        }
//    }

//    /**
//     * Supprimer un OrganismeModele présent dans le dépôt
//     *
//     * @param modele
//     *   de l'objet OrganismeModele
//     *
//     * @return un OrganismeModele ou null si inexistant dans le dépôt
//     */
//    @Override
//    public OrganismeModele supprimerModele(OrganismeModele modele) {
//        OrganismeModele oldModele = this.modeles.put(modele.getId(), null);
//        if (oldModele != null) {
//            // todo: requête au serveur pour suppression d'un organisme
//        }
//        return oldModele;
//    }
}
