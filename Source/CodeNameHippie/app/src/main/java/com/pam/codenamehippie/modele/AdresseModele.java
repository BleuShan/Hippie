package com.pam.codenamehippie.modele;

import com.google.gson.annotations.SerializedName;

/**
 * Créé par Carl St-Louis le 2015-12-01.
 */
public class AdresseModele extends BaseModele {

    @SerializedName("no_civique")
    private Integer noCivique;
    @SerializedName("type_rue")
    private String typeRue;
    @SerializedName("nom")
    private String nom;
    @SerializedName("app")
    private String app;
    @SerializedName("ville")
    private String ville;
    @SerializedName("province")
    private String province;
    @SerializedName("code_postal")
    private String codePostal;
    @SerializedName("pays")
    private String pays;

    public Integer getNoCivique() {
        return this.noCivique;
    }

    public AdresseModele setNoCivique(Integer noCivique) {
        this.noCivique = noCivique;
        return this;
    }

    public String getTypeRue() {
        return this.typeRue;
    }

    public AdresseModele setTypeRue(String typeRue) {
        this.typeRue = typeRue;
        return this;
    }

    public String getNom() {
        return this.nom;
    }

    public AdresseModele setNom(String nom) {
        this.nom = nom;
        return this;
    }

    public String getApp() {
        return this.app;
    }

    public AdresseModele setApp(String app) {
        this.app = app;
        return this;
    }

    public String getVille() {
        return this.ville;
    }

    public AdresseModele setVille(String ville) {
        this.ville = ville;
        return this;
    }

    public String getProvince() {
        return this.province;
    }

    public AdresseModele setProvince(String province) {
        this.province = province;
        return this;
    }

    public String getCodePostal() {
        return this.codePostal;
    }

    public AdresseModele setCodePostal(String codePostal) {
        this.codePostal = codePostal.replaceAll("\\s+", "");
        return this;
    }

    public String getFormattedCodePostal() {
        StringBuilder stringBuilder = new StringBuilder(this.codePostal);
        stringBuilder.insert(4, " ");
        return stringBuilder.toString();
    }

    public String getPays() {
        return this.pays;
    }

    public AdresseModele setPays(String pays) {
        this.pays = pays;
        return this;
    }

    public String toFormattedString() {
        StringBuilder stringBuilder = new StringBuilder(200);
        if (this.noCivique != null) {
            stringBuilder.append(this.noCivique).append(" ");
        }
        if (this.typeRue != null) {
            stringBuilder.append(this.typeRue).append(" ");
        }
        if (this.nom != null) {
            stringBuilder.append(this.nom).append(" ");
        }
        if (this.typeRue != null) {
            stringBuilder.append(this.typeRue).append(" ");
        }
        if (this.app != null) {
            stringBuilder.append("Appartement ").append(this.app).append(" ");
        }
        if (this.ville != null) {
            stringBuilder.append(this.ville).append(" ");
        }
        if (this.province != null) {
            stringBuilder.append(this.province).append(" ");
        }
        if (this.codePostal != null) {
            stringBuilder.append(this.getFormattedCodePostal()).append(" ");

        }
        if (this.pays != null) {
            stringBuilder.append(this.pays).append(" ");
        }
        return stringBuilder.toString();
    }
}
