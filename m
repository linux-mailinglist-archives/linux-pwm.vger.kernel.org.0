Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5509236F5C8
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 08:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhD3Gmp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Apr 2021 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhD3Gmp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Apr 2021 02:42:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07E0C06174A
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 23:41:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcMqT-0005T7-KO; Fri, 30 Apr 2021 08:41:49 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcMqP-00071S-Hz; Fri, 30 Apr 2021 08:41:45 +0200
Date:   Fri, 30 Apr 2021 08:41:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roman =?utf-8?Q?Ber=C3=A1nek?= <roman.beranek@prusa3d.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Round delay time up to a nearest jiffy
Message-ID: <20210430064145.nzlcw3lpayzapnbx@pengutronix.de>
References: <20210428001946.1059426-1-roman.beranek@prusa3d.com>
 <20210428061357.725m72aikc52n4gg@pengutronix.de>
 <CAL8eAtpuAQUiesC-gxSQENDXrw44qQQvp5UqEjdfz1hX5CLHnQ@mail.gmail.com>
 <20210429120416.5ba7rq5fvhcfebzz@pengutronix.de>
 <CAL8eAtqBzUt6fP2nr-Ppg+qwhvKWk13A0P3+hoe07F+9VXCvmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yxa6ptwfjk2wclhb"
Content-Disposition: inline
In-Reply-To: <CAL8eAtqBzUt6fP2nr-Ppg+qwhvKWk13A0P3+hoe07F+9VXCvmA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yxa6ptwfjk2wclhb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Roman,

On Fri, Apr 30, 2021 at 04:19:32AM +0200, Roman Ber=E1nek wrote:
> On Thu, Apr 29, 2021 at 2:04 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Wed, Apr 28, 2021 at 02:14:31PM +0200, Roman Ber=E1nek wrote:
> > > Correct, the output may stay in an active state. I only discovered th=
is
> > > bug as I investigated a report of unreliable screen timeout. The peri=
od
> > > we use the PWM with is 50 us.
> >
> > What I don't like here is that the delay is quite coarse and might still
> > be too short. (Maybe I miss something, but consider the current period
> > is quite long, then you configure a short one and then disable. In this
> > case the inital long setting might still be active.)
>=20
> The delay is calculated from the original period (cstate.period),
> not the one that was just written into PWM_CHx_PRD 2 lines above.

Yes, but that's not good enough. Consider the PWM is running with a
period of 4s and the period just started. Then you call

	pwm_apply_state(mypwm, &(struct pwm_state){
			.period =3D 20,
			.enabled =3D 1,
			...
			})

This doesn't result into the waiting code being run, because
=2Eenabled =3D 1. Then immidiately after that call:

	pwm_apply_state(mypwm, &(struct pwm_state){
			.period =3D 20,
			.enabled =3D 0,
			...
			})

which triggers the waiting but only based on a period of 20 ns while the
4s period is still active.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yxa6ptwfjk2wclhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCLpqYACgkQwfwUeK3K
7AmOsQf+JsU96ozQWt9+ARbvwEkf11Xzb7acpSk+79uogD6d9jgwJJxyqnH2aSRH
6dLGUirs11Z1yuKG+iMAZrlMy+BJR4EfmrYhVH2iLhdtyeYK5rJaQ9unauorNnNs
42fIbuz3DUP9ZMKr5n8IcclLNtFFX0LoVxrX9wp+JoiMJa0zmu8bZMi8YyLtqwYy
tnloz9XQ8t98+Io2f0tj9iIcgsTDVLNvgnB8NUWRnSEc9t33GA62PYTRK0jyxbEu
KA3kJIYBpmsvMSj5778ET7dCa09+M3Q2Tqv2aG5sSHp/1OmTA28vCc45V70iKSoY
Q5RpWdLOnfiiSsb282NNIRdmoqK7xA==
=t5e1
-----END PGP SIGNATURE-----

--yxa6ptwfjk2wclhb--
