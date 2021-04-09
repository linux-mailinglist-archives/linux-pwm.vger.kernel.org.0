Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE2359FF3
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Apr 2021 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDINgV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Apr 2021 09:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbhDINgV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Apr 2021 09:36:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE29C061760
        for <linux-pwm@vger.kernel.org>; Fri,  9 Apr 2021 06:36:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g5so2013560ejx.0
        for <linux-pwm@vger.kernel.org>; Fri, 09 Apr 2021 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vCe/pNS12vc+YtCmoXuItpiuYAtoxpZSWUNgKDBCn8Y=;
        b=hgH94TlL2Z4HgWusR0W8eARKE7+oisbUV2pMVxNzfbOYlNYcagxLAxiSCuPiVf6SmK
         cmxwt8038FprBupESj+IpltZlTvGRbsI078LZSzflDeO9gI13LcOLiDYlmQI1/KPwyn4
         cuyv8q2twhVjLxbLnGagVjRzRl3VLkEIZpPZJU22GjEK9wTIq8VJ+JKjdVfQdUKCk/2q
         frsSjqDbKS9XaXHgoC3QzsKlbAuo18RdXVV2r/GrmJ6trcpaaLyRsNxmw5tTyBRaQ/JW
         /LUmBDR6qrv512y9ENGy5zvENRE5KmiDETPv+cGRtgz5e/QNKjNbSj5pDbHDePjMNtEY
         zgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vCe/pNS12vc+YtCmoXuItpiuYAtoxpZSWUNgKDBCn8Y=;
        b=lM1V8qiVysGUgP++MIfY/1vMcMgrhoWR0U6q0YLcNOL7UxqC21swD6+MMRT0a6FAsV
         aG7Mut5QH07gZ0G5uqJuPC5kWcR8vb+BWIQionDxxlfo9KTrgHFGiGK9bJU2TUheQ1Ed
         IilNnJjRibS8d8SzHIpKrdBAEYuL00CXy9x4MQo2d5r1zlAb1p0KYFifiJCTg+v6fk5T
         fekOIuu+h5c2pdIaEc2228I6G9kkLvt3kVHUcjXLNnF0EGJiPZ25O2NpDBCqkkJmkt39
         EVWOTihSl3Ns6UM817TXu571bpmRuQjel9HIHhh2y9oIX2p0RiTNUecNXGkbnKpC750h
         6zkQ==
X-Gm-Message-State: AOAM533xeBGAXtW8hGnlACSS2zkj+/ae6nreq9caNPUoTG1bKG1y0ra/
        E0n8kGP5KiZliLWkMwm7kGk=
X-Google-Smtp-Source: ABdhPJziBUZ+tUjvvDD34QGJB2s35HCvcAgrnvoYDi7Neyz+ug033Xl/0gmQzgttreM7+AU8vJrYFQ==
X-Received: by 2002:a17:907:3f90:: with SMTP id hr16mr2019657ejc.362.1617975367406;
        Fri, 09 Apr 2021 06:36:07 -0700 (PDT)
Received: from localhost (pd9e51abe.dip0.t-ipconnect.de. [217.229.26.190])
        by smtp.gmail.com with ESMTPSA id h13sm1471143edz.71.2021.04.09.06.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 06:36:04 -0700 (PDT)
Date:   Fri, 9 Apr 2021 15:36:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: Make of_pwm_xlate_with_flags() work with
 #pwm-cells = <2>
Message-ID: <YHBYaCWUrEH6Lz27@orome.fritz.box>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
 <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e+NQ+kMzsRMTX6CC"
Content-Disposition: inline
In-Reply-To: <20210315111124.2475274-2-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--e+NQ+kMzsRMTX6CC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 15, 2021 at 12:11:21PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The two functions of_pwm_simple_xlate() and of_pwm_xlate_with_flags() are
> quite similar. of_pwm_simple_xlate() only supports two pwm-cells while
> of_pwm_xlate_with_flags() only support >=3D 3 pwm-cells. The latter can
> easily be modified to behave identically to of_pwm_simple_xlate for two
> pwm-cells. This is implemented here and allows to drop
> of_pwm_simple_xlate() in the next commit.
>=20
> There is a small detail that is different now between of_pwm_simple_xlate=
()
> and of_pwm_xlate_with_flags() with pwm-cells =3D <2>: pwm->args.polarity =
is
> unconditionally initialized to PWM_POLARITY_NORMAL in the latter. I didn't
> find a case where this matters and doing that explicitly is the more
> robust approach.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index b1adf3bb8508..39b0ad506bdd 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -126,8 +126,7 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const st=
ruct of_phandle_args *args)
>  {
>  	struct pwm_device *pwm;
> =20
> -	/* check, whether the driver supports a third cell for flags */
> -	if (pc->of_pwm_n_cells < 3)
> +	if (pc->of_pwm_n_cells < 2)
>  		return ERR_PTR(-EINVAL);
> =20
>  	/* flags in the third cell are optional */
> @@ -144,7 +143,8 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc, const st=
ruct of_phandle_args *args)
>  	pwm->args.period =3D args->args[1];
>  	pwm->args.polarity =3D PWM_POLARITY_NORMAL;
> =20
> -	if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
> +	if (pc->of_pwm_n_cells >=3D 3 && args->args_count > 2 &&
> +	    args->args[2] & PWM_POLARITY_INVERTED)

This might more clearly look like a superset of of_pwm_xlate_simple() if
you split up the conditional this way:

	if (pc->of_pwm_n_cells >=3D 3) {
		if (args->args_count > 2 && args->args[2] & PWM_POLARITY_INVERTED)
			...
	}

That'd also help if we ever end up extending the list of supported
flags.

Thierry

--e+NQ+kMzsRMTX6CC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBwWGgACgkQ3SOs138+
s6EslxAAu5B6b6qNSfbOsncYSegx8t71t5laxP0pjXbzBDrHPSRtTVF5+CyD9bff
oGSuswsYxEkPgGHP37Dp7sY0gF4aVsvuIOGETxC92je12NEH9quJV2nD+2zxeemV
tTxw8wmKC69W0rAvcTQR17jR0qnzWKB8cMhfMYDIfPn79buuIJ2xFlYRXc+ltkam
BCvAnbgPp9S70ynxao11m8B/d+DBoJOkefLKhhvQ9DY2Vd4uuhCAofAPs4Hxt/jr
zRQtLrLx4O2bp4yanzlaz+rvlAr7XB6GRakOi8g5bWwGubvpxsrgK/wScHbeSEPl
tlhKqoeeHSBPpohDYvrPQUY509+b2j4PLrsuDINqLcTfv1+gaCO+5XIWhNQdwT/O
lKkmE8X16FmNZadXiF5GLPVI8WYGGbXNRdfmSH0R4QHEzYFnpfd4K+iJRUnPeV9M
2usCJaUzWDvLSC9q+Q86JmQcX2fU65btMMjPgWQHBgBdVWQMgrjyKywfZSsfP085
NBxeezFgeEpbT0PyBkYnclZPimSe5HgQ7CkknhICU8R8Ue90xDi5Dkea6u3jdez/
AxztgNNaQkTIZlYm5RHeM2Ws5d4EswyyY+GLBLAnf486FPi8zm0XCOY0s4QbIZ1X
OSgfJKgWXO6ne0gPAtHOP2J3S8bWt9qmDOwwxlEln4GXOZwFGLo=
=5RWS
-----END PGP SIGNATURE-----

--e+NQ+kMzsRMTX6CC--
