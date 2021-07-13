Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCF03C6A9A
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Jul 2021 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhGMGdx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Jul 2021 02:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhGMGdw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Jul 2021 02:33:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B48C0613DD
        for <linux-pwm@vger.kernel.org>; Mon, 12 Jul 2021 23:31:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3BwY-0005bt-Jb; Tue, 13 Jul 2021 08:30:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3BwW-0006OT-Hw; Tue, 13 Jul 2021 08:30:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m3BwW-0000mq-Gu; Tue, 13 Jul 2021 08:30:56 +0200
Date:   Tue, 13 Jul 2021 08:30:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Salah Triki <salah.triki@gmail.com>
Cc:     fabrice.gasnier@foss.st.com, thierry.reding@gmail.com,
        lee.jones@linaro.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] divide by 3*sizeof(u32) when computing array_size
Message-ID: <20210713063053.qqttzxlopvpnadj3@pengutronix.de>
References: <20210712231910.GA1831270@pc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ez7arkdudmeg6ooh"
Content-Disposition: inline
In-Reply-To: <20210712231910.GA1831270@pc>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ez7arkdudmeg6ooh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Salah,

On Tue, Jul 13, 2021 at 12:19:10AM +0100, Salah Triki wrote:
> Divide by 3*sizeof(u32) when computing array_size, since stm32_breakinput
> has 3 fields of type u32.
>=20
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 794ca5b02968..fb21bc2b2dd6 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -544,7 +544,7 @@ static int stm32_pwm_probe_breakinputs(struct stm32_p=
wm *priv,
>  		return -EINVAL;
> =20
>  	priv->num_breakinputs =3D nb;
> -	array_size =3D nb * sizeof(struct stm32_breakinput) / sizeof(u32);
> +	array_size =3D nb * sizeof(struct stm32_breakinput) / (3 * sizeof(u32));
>  	ret =3D of_property_read_u32_array(np, "st,breakinput",
>  					 (u32 *)priv->breakinputs, array_size);
>  	if (ret)

I agree with Philipp here; this looks strange and needs a better
description.

Looking a bit more in details:

 - priv->breakinputs has type struct stm32_breakinput[MAX_BREAKINPUT]
 - nb is in [0 .. MAX_BREAKINPUT]
 - sizeof(struct stm32_breakinput) =3D=3D 3 * sizeof(u32)
 - of_property_read_u32_array reads $array_size u32 quantities

so to read $nb members of type stm32_breakinput array_size must be a
multiple of 3 which isn't given any more after your patch. This makes me
believe your suggested change to be wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ez7arkdudmeg6ooh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDtMxoACgkQwfwUeK3K
7AmuxAf/TJUx15z8hdmnrrErJ3Hlc4gXAA+lr7K0fa/zANbA22QYZ4mhmLiNcsca
8XRosInmiaz3M7bEBslrYIMl+vbuLclNt+lTPMeL9V0OcdWtnvZoDnDPpHdE77v1
K10wsl5Uj6HJR27TnXm8VTolsTA5a4VEu4ocU3Ytnx6897ySGKG6wGxpQltn8ulN
NtLZ0lIEmB93kF3UpGv2OHqElh1K8FQ6v4a9eREqlXytznMVdiqxQdfygPWZcYvY
sY5V3UXdaKuP05bJK6qsmt3hZKT9tZ+4/z7UurgD2FwFe271rGk3+sJ38pyV6vPB
AP9WncikXpljRtU/mIEpp/Fu2O4uwA==
=OfoS
-----END PGP SIGNATURE-----

--ez7arkdudmeg6ooh--
