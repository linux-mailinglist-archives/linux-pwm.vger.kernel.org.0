Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FD336F824
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 11:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhD3Jv7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Apr 2021 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhD3Jv6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Apr 2021 05:51:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C213FC06174A
        for <linux-pwm@vger.kernel.org>; Fri, 30 Apr 2021 02:51:10 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcPnd-0000lu-3v; Fri, 30 Apr 2021 11:51:05 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcPnZ-0002Mm-5c; Fri, 30 Apr 2021 11:51:01 +0200
Date:   Fri, 30 Apr 2021 11:51:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roman Beranek <roman.beranek@prusa3d.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
Message-ID: <20210430095101.rjkdukf67h2k4iea@pengutronix.de>
References: <20210430064145.nzlcw3lpayzapnbx@pengutronix.de>
 <CB0VI785HYEE.3PXPB7BDOUPFC@zen.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o5bio467nkbbcvez"
Content-Disposition: inline
In-Reply-To: <CB0VI785HYEE.3PXPB7BDOUPFC@zen.local>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--o5bio467nkbbcvez
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Roman,

On Fri, Apr 30, 2021 at 09:17:49AM +0200, Roman Beranek wrote:
> On Fri Apr 30, 2021 at 8:41 AM CEST, Uwe Kleine-K=F6nig wrote:
> > Consider the PWM is running with a period of 4s and the period just
> > started. Then you call
> >
> > pwm_apply_state(mypwm, &(struct pwm_state){
> > .period =3D 20,
> > .enabled =3D 1,
> > ...
> > })
> >
> > This doesn't result into the waiting code being run, because
> > .enabled =3D 1. Then immidiately after that call:
> >
> > pwm_apply_state(mypwm, &(struct pwm_state){
> > .period =3D 20,
> > .enabled =3D 0,
> > ...
> > })
> >
> > which triggers the waiting but only based on a period of 20 ns while the
> > 4s period is still active.
>=20
> OK, now I see what you mean. To remedy this, the delay shall occur
> regardless of state->enabled.
>=20
> In my view, this lies beneath the scope of the patch though and would be
> better served as a follow-up.

If you agree that dropping both delay and clk_disable completely is the
right thing, you address both problems and going forward with your patch
isn't sensible.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o5bio467nkbbcvez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCL0wIACgkQwfwUeK3K
7AkCSgf/dhj6g6iooQ9qQCmUfg5E4mF7y4wSO4mZuc3zXa/n3Gpi1Mmj3x5NRjc0
D0QuOD9IspwZgvwWsoqqN7Qaslu7v3icteVHzwVqTDUQbDlZwREWeybb3ASsf8fd
azN44fzWh9pdph2kCeE/nrYJ/DkFR55ihbSZZSU1ZCvqoYeB6ThJUsOo6YngwWuR
JTVuhxGVcMR6rvyvT5pjXK2FGphXrVJDtq3ypCHK9tx61IMFPfzJV0Q9id4CM6w3
QyTWu++3gClLgiGFqlJtE9bN/0agdtpQeA5fCfcU/jbddJuQwBNW20KO6Jm0E7qP
yBk73WOiyt0caHe/L/tac3q3khGeqA==
=T+lR
-----END PGP SIGNATURE-----

--o5bio467nkbbcvez--
