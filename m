Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D75134D640
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhC2Rt7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 13:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbhC2Rtk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 13:49:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BBBC061574
        for <linux-pwm@vger.kernel.org>; Mon, 29 Mar 2021 10:49:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQw1C-0002b8-IN; Mon, 29 Mar 2021 19:49:38 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lQw1C-00006I-8d; Mon, 29 Mar 2021 19:49:38 +0200
Date:   Mon, 29 Mar 2021 19:49:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Sven Van Asbroeck <TheSven73@gmail.com>
Subject: Re: [PATCH v6 6/7] pwm: pca9685: Restrict period change for
 prescaler users
Message-ID: <20210329174938.rwosdunyh7oh2eus@pengutronix.de>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-6-clemens.gruber@pqgruber.com>
 <20210329171559.rfelpt42shlebct5@pengutronix.de>
 <YGIPhCqM32QrqcrL@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ieox3mgktdvdj4p"
Content-Disposition: inline
In-Reply-To: <YGIPhCqM32QrqcrL@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7ieox3mgktdvdj4p
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Clemens,

On Mon, Mar 29, 2021 at 07:33:56PM +0200, Clemens Gruber wrote:
> On Mon, Mar 29, 2021 at 07:15:59PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Mon, Mar 29, 2021 at 02:57:06PM +0200, Clemens Gruber wrote:
> > > @@ -330,14 +345,22 @@ static int pca9685_pwm_apply(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> > > =20
> > >  	if (!state->enabled || duty < 1) {
> > >  		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> > > +		clear_bit(pwm->hwpwm, pca->prescaler_users);
> >=20
> > Hmm, so if "my" channel runs at say
> >=20
> > 	.duty_cycle =3D 2539520 ns
> > 	.period =3D 5079040 ns
> >=20
> > and I call pwm_apply_state(mypwm, { .duty_cycle =3D 0, .period =3D 5079=
040,
> > enabled =3D true }); it might happen that another channel modifies the
> > period and I won't be able to return to the initial setting.
>=20
> Yes, that's correct.
>=20
> But that also applies to PWMs set to 100%:
>=20
> pwm_apply_state(mypwm, { .duty_cycle =3D 5079040, .period =3D 5079040,
> enabled =3D true });
>=20
> As this sets the full ON bit and does not use the prescaler, with the
> current code, another channel could modify the period and you wouldn't
> be able to return to the initial setting of 50%.
>=20
> > So I think it's sensible to only clear the user bit if the PWM is
> > disabled, but not if it is configured for duty_cycle =3D 0.
> >=20
> > Does this make sense?
>=20
> With both cases in mind, you are suggesting we block modifications of
> the prescaler if other PWMs are enabled and not if other PWMs are using
> the prescaler?

That sounds sensible, yes.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7ieox3mgktdvdj4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBiEy4ACgkQwfwUeK3K
7AmVqQgAnXHgi4x1oDNkU2hntC7XH6V44j7YbBK8XJdrPakCQxox87TyeN6FW2UU
MdMXB97BptkFFGGAoMXSW2FDVb4tveP+2Gx0fWktrFsBWv6PGirpYFb6Qce7et92
mC8xgMriptKvNjjyy28KQZ2twe9soa15pMaEaYdJr+brTDC2wumVitUKilZu5zA4
5evah2w8uVuq5lluAZSImdvc30pIGNw+jpAB0TBUrhdhbjsHLTaO4HUiPcBJx74P
4jsp/94ZKAcm2m4Lbl8jrziUUDLJlWYpo8H9aTrHI9WtvCwbdtEeYQA+Kvp3r/lA
To5DkGlRhkBJiyENEU1U78dXsmGWhA==
=WAJL
-----END PGP SIGNATURE-----

--7ieox3mgktdvdj4p--
