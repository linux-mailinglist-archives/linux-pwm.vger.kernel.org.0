Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3A4197E9B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2020 16:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgC3OhV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Mar 2020 10:37:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35247 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgC3OhV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Mar 2020 10:37:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id d5so21994280wrn.2;
        Mon, 30 Mar 2020 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=idGSNlS5foegWcbeejyLCNUnDarAVKTDXcWKaPEeNjY=;
        b=EfHxTcq91OwU4aGBf3mn/lXFRiymTz25QWi/lC+RlEazQjaizplkmUOMesFd5VwfNR
         jcRVvu74XNAd/D9DgB9myBaC4LnhqX81TlUg1VQnw1zUGPh8OM97YnnM4SrFPGbx2YsM
         wj0wzL3PrwqIc30cwNMT59QVxkLMQnty57ocUsXjzq04NZEI04oFvkr7DV9HSpOiqQ2b
         MvvhzdBDwrv2O66jjiP35L2sNRSVwhSqg2p0TIpTL7kwsi8f1/C6SNitfvKAMCiztbuW
         YA1VOM/2sMBAcUqQojBnF595rmTinbkNYUzpDWQB8+Cu0AFjkKotFRLEmYIDN435ivZj
         t5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=idGSNlS5foegWcbeejyLCNUnDarAVKTDXcWKaPEeNjY=;
        b=O3Q0wJOFLiMWcusEglv8kigN+Zv39M67qEFkA0DX3ClyrmLhTJf2LroUoOTe3zi4Fh
         wFbn02iB8HUvOxPJ9jSEgSvkde0ecSnFp9yk7V4pAFSe9hXMUe/b+JMWae8yL16LhKtq
         hil7Eu+Ca522k0iCbzBThSFOjuABFTmYCJUasRrjiwfH71EG8IFDzgd+yp0y9BmYxDYf
         Mz8kuZEdfo8lgXw12VSqWyI8rodt9cBkYWEegkaJfb9KKUQtLYT7HG1MDbSRo/MSsMcs
         eS40k7AaCdYhKuuT/+mig9xKRTwMDPKl3zWn8QH5LOVhJ3cukSC94dDfw58PMJm1cAVC
         6aXw==
X-Gm-Message-State: ANhLgQ2Ufhc4NLeDVpF/6qm/F7V97rpJvKDmLAL3sDlujSWSmF1fWt9a
        fkUQC6S2M31BAcvabt0mg9M=
X-Google-Smtp-Source: ADFU+vuGy0osZv8T/LTlZUt4uQO6ueplH8KLCZHQM7oEygq3//5A2Tt8k66SXvZguiDmrQK5CqcuGg==
X-Received: by 2002:a5d:6109:: with SMTP id v9mr15810962wrt.203.1585579038704;
        Mon, 30 Mar 2020 07:37:18 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id p10sm18043238wre.15.2020.03.30.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 07:37:17 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:37:16 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v4 3/4] pwm: jz4740: Obtain regmap from parent node
Message-ID: <20200330143716.GI2431644@ulmo>
References: <20200323142421.42817-1-paul@crapouillou.net>
 <20200323142421.42817-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5uO961YFyoDlzFnP"
Content-Disposition: inline
In-Reply-To: <20200323142421.42817-3-paul@crapouillou.net>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5uO961YFyoDlzFnP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2020 at 03:24:20PM +0100, Paul Cercueil wrote:
[...]
> diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
[...]
> @@ -196,12 +208,19 @@ static const struct pwm_ops jz4740_pwm_ops =3D {
>  static int jz4740_pwm_probe(struct platform_device *pdev)
>  {
>  	struct jz4740_pwm_chip *jz4740;
> +	struct device *dev =3D &pdev->dev;
> =20
> -	jz4740 =3D devm_kzalloc(&pdev->dev, sizeof(*jz4740), GFP_KERNEL);
> +	jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);
>  	if (!jz4740)
>  		return -ENOMEM;
> =20
> -	jz4740->chip.dev =3D &pdev->dev;
> +	jz4740->map =3D device_node_to_regmap(dev->parent->of_node);
> +	if (!jz4740->map) {

This seems wrong. According to the code, device_node_to_regmap() returns
an ERR_PTR()-encoded error code on failure, so I think this should be:

	if (IS_ERR(jz4740->map)) {
		...
		return PTR_ERR(jz4740->map);
	}

No need to resend for that, I can take care of that when applying. Let
me know if that doesn't work.

Thierry

--5uO961YFyoDlzFnP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6CBBkACgkQ3SOs138+
s6HtCw/+ObsrCeW3Qpro0kEkUAgc55EE8fppGxsicDBZs+p64q4N3XCH0iduAZuc
3yeXxtv5jLhz5x9/kwq+h61+UzAqrPbCOWBOBOTq5s2srhrr6WSi9zCYUR6AaTjv
Ooq6wm0rNJzuIvfWp/+EoLl/MTuJOD/WauAT01rvygN9b7i+fgSORlsDkoKptiJ2
C7KwuvhqGlHRcAoHtOfgLub6jca/kWwifSWQ1gBkc312IcKuW6ZLHfu7ijLf8+bc
oH8C/FNuC++mjT13lLJoqc1yIB1y0h1asX2VYUgsQPQGT1ioKjNsgUFqdEKIq49S
HVzvpIGMsQKiDyO9ka++tMItvLz/L8oMBCCYgHp0zNX8FiSqWqsK/RliMZSHiQFj
WMyYMbJZPp1Bbxjy4lz8bQz2pQQMbC9dSKlU4PI/hG9JVo/GsM/m1Eu7iUKW7+KB
P1yJKlG5PqOlPpumyb+vkNOysYbAV4hiSAQt440ga7+SkObdUK+sh6vv7zHMsa2T
ULjANwIcBiyFR4C0jicNqehIqCql4u/GvNpY2plagzm8kIt7woyTHkWNF12utnJO
rgAUY75J6QWWmXmzetmVMiqg2fVyzIyrJwhS8xt8SoJM/XWnSf4AuHAkpIBaXuGb
eQ/hGqkwSHcs+KHgVoyvN9Yu5uIUS2Vtq46NthNGHFMphaxR0fc=
=SgmS
-----END PGP SIGNATURE-----

--5uO961YFyoDlzFnP--
