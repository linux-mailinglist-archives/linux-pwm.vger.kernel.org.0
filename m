Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1E6BC620
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Sep 2019 13:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405205AbfIXLCy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 24 Sep 2019 07:02:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33092 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389414AbfIXLCy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 24 Sep 2019 07:02:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so1451329wrs.0;
        Tue, 24 Sep 2019 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=39oBHhyT5LUKl72KBXNwxMjpwohyaM3Lf/IBs+S5VfM=;
        b=KRMMpwxRTvDUSCbPtoBKXH1+SEQMejphNnTSPDh7MUKKjN95H/di8OjcMIIvnvd5b7
         fLgJlJOJigGHVjPuhwDmBfJXqfko76wHPyWsNedgJgSzoUjcaT6yipBayzPjK8+ViiZn
         1SBl35K4GsWDH131gnW/edR54ZK1Wx3VuJmYXL+JZYU3zXe21XkZY4qY1fCRNbO/3Fai
         4LtVUXscWzHj8gfACXdKKX0rBBUFx143d9MuD9DCCslYnyGrhQ45ifTXRq6/QC9Z6iup
         4DuIuTGEAUCZBXKq2v3M8pt3A5GIJCAjEcb91AMqxJS3EcOTXe/EVpyvL+dbXEuYYi5Y
         cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=39oBHhyT5LUKl72KBXNwxMjpwohyaM3Lf/IBs+S5VfM=;
        b=Nq8m/jI31z/zt4MTkFLu7S0YGFwRpX3rS8qA/CQvl7z2KUOcaSJ87Ip6tdH7evlboI
         oOOAFiI9ZEK4fecMmUMw02GikTFeutA52VANRCyIF10I9TFWAoj5XjmEnfIYOdANa5P3
         Fm3x7AKakGTneqqT6jAzpsvxyQTvrCaQ1jep2mma1PJ6D6TKrs/KTN3waqiOXhXzdVxv
         VwruskBZvSoMnrbHUNBiJlWms+rPObIJntQJZZtzlaKsClx+e7/P5yhcu4K+XcZCfk8G
         7FzcvNDFC3dBUP525YFFN8FlcW1n0UEtbLuy07jChu2D2aF1WhJArM9J5Hv9rcHkagEY
         WMQA==
X-Gm-Message-State: APjAAAUFpeO3ESlgcY/FYotJRaUOPqtKpgd1TxIOZPXlGwuCjEp5Xs7n
        ePgL66oDv6W2vVP0qqzCocI=
X-Google-Smtp-Source: APXvYqyiabsF55sMwAHaoHbBYJyTJizQtfzpgpeT7+A/Pub6tNlghPfdwkrq6m06iZXyCjmzNOBpzg==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr1795532wrv.261.1569322971287;
        Tue, 24 Sep 2019 04:02:51 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id e6sm1733774wrp.91.2019.09.24.04.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 04:02:49 -0700 (PDT)
Date:   Tue, 24 Sep 2019 13:02:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] pwm: pwm-mxs: use devm_platform_ioremap_resource()
 to simplify code
Message-ID: <20190924110248.GF14924@ulmo>
References: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <1569318169-12327-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2019 at 05:42:48PM +0800, Anson Huang wrote:
> Use the new helper devm_platform_ioremap_resource() which wraps the
> platform_get_resource() and devm_ioremap_resource() together, to
> simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> 	- This is a resend version of patch: https://patchwork.kernel.org/patch/=
11048365/
> ---
>  drivers/pwm/pwm-mxs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

When you do resend patches, please make sure to include an Reviewed-by
or Acked-by tags that you get.

In this case that's not necessary since I had already applied the other
patch.

Thierry

>=20
> diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
> index 04c0f6b..b14376b 100644
> --- a/drivers/pwm/pwm-mxs.c
> +++ b/drivers/pwm/pwm-mxs.c
> @@ -126,15 +126,13 @@ static int mxs_pwm_probe(struct platform_device *pd=
ev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct mxs_pwm_chip *mxs;
> -	struct resource *res;
>  	int ret;
> =20
>  	mxs =3D devm_kzalloc(&pdev->dev, sizeof(*mxs), GFP_KERNEL);
>  	if (!mxs)
>  		return -ENOMEM;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mxs->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	mxs->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(mxs->base))
>  		return PTR_ERR(mxs->base);
> =20
> --=20
> 2.7.4
>=20

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2J99gACgkQ3SOs138+
s6GQAhAArhAUpmU0pjAl8qc9eLxwkVNYkfxSagID+AR2KE1BW29cp1kDA5Mkg2/s
dy4eDAwIjvNSh0l8rlFrUmZ2Mxa5kOkHwEcfnHxNf6sps28wd2TseR0oIs/Nka4p
F8PDHqh7ukLOuJpLCt4H2oC2BkmXLq18w7fneryX8TMfg/KgrOqLDyuUIxUP7OzW
HKfgz6u1IfDH6U/1ehn601t6MJBNjenqFIJsiEVqUbynIBRqE4Ss7+QAxGQ2jrAu
A4NnolWe05xJjLeRqXGmD71fkHZHjyyN1sRggpsOOXCWkqcAZP0/wWq25PI055jv
eFZ/WjvqMfEVXCvxqR1iLmr/cgIsCpTrW8kzbyVbIjcWaw6fQtKdPOnEx0TQIC4v
GgDmVIMnjxhG82CSr9LBQ1hpQL6hDQJKltYSkQPZ8WwO2ISY0xmjCcvm1+FMG2ak
QjROGJw7JGoKQ46sD5/iYlEnGaEQTqVKCsTwb8kWGbQswKMxMmdd9cBImxTJxrua
ta2PsGUDKC18XSbw+bzh4EDJ1wYr4kOca2rWYbO9ubKXTsEkM4iiDIN9zrEhbmIH
L+CIlM03DnQq++a3DQsTS3/XpLAHVynaID9sa7nzcadb0ex6Twno+WP7weo/xySH
Q6S0fwoqdI8yJgN2SMmI/xePpnp7CDmRJ0pmXRx1GbJnfbsZbrI=
=h/nA
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
