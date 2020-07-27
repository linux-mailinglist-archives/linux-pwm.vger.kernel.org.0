Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ADA22E631
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgG0HBc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0HBc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:01:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419F0C0619D2
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 00:01:32 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzx8a-0006aD-Qt; Mon, 27 Jul 2020 09:01:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzx8Y-0006Jq-RX; Mon, 27 Jul 2020 09:01:26 +0200
Date:   Mon, 27 Jul 2020 09:01:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v5 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200727070126.2juwfmra3i67lxfw@pengutronix.de>
References: <cover.1595489518.git.rahul.tanwar@linux.intel.com>
 <0f47648107ec23f72868ca37f29ea43e15c08e08.1595489518.git.rahul.tanwar@linux.intel.com>
 <20200723161553.ey47oijnwitf4hvu@pengutronix.de>
 <c2ef8f5c-af23-a63d-5f72-de0c307be8eb@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ddzwp66u6avxreag"
Content-Disposition: inline
In-Reply-To: <c2ef8f5c-af23-a63d-5f72-de0c307be8eb@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ddzwp66u6avxreag
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2020 at 02:04:56PM +0800, Tanwar, Rahul wrote:
>=20
> Hi Uwe,
>=20
> On 24/7/2020 12:15 am, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >
> > On Thu, Jul 23, 2020 at 03:44:18PM +0800, Rahul Tanwar wrote:
> >> +static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> >> +			 const struct pwm_state *state)
> >> +{
> >> +	struct lgm_pwm_chip *pc =3D to_lgm_pwm_chip(chip);
> >> +	u32 duty_cycle, val;
> >> +	int ret;
> >> +
> >> +	if (!state->enabled) {
> >> +		ret =3D lgm_pwm_enable(chip, 0);
> >> +		return ret;
> >> +	}
> >> +
> >> +	/*
> >> +	 * HW only supports NORMAL polarity
> >> +	 * HW supports fixed period which can not be changed/configured by u=
ser
> >> +	 */
> >> +	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
> >> +	    state->period !=3D pc->period)
> >> +		return -EINVAL;
> > At least for state->polarity you have to check before state->enabled, as
> > the expectation on
> >
> >         .enabled =3D false
> >         .polarity =3D PWM_POLARITY_INVERSED
> >
> > is that the output becomes constant high. Also as confirmed at the end
> > of v4, state->period < pc->period was the right check to do.
>=20
> For below case:
>=20
> .enabled =3D false
> .polarity =3D PWM_POLARITY_INVERSED
>=20
> Since our HW does not support inversed polarity, the output for above case
> is expected to be constant low. And if we disable PWM before checking for
> polarity, the output becomes constant low. The code just does that. Sorry,
> i could not understand what is wrong with the code. It looks correct to m=
e.

As your hardware can only support normal polarity, the code must have:

	if (state->polarity !=3D PWM_POLARITY_NORMAL)
		return -EINVAL;

	if (!state->enabled) {
		ret =3D lgm_pwm_enable(chip, 0);
		return ret;
	}

That's what I meant writing: "At least for state->polarity you have to
check before state->enabled".

> Given the fact that we support fixed period, if we allow
> state->period < pc->period case then the duty cycle will be evaluated as
> higher than the requested one because the state->period is lesser than
> the actual fixed period supported by the HW. Can you please elaborate
> on why you think we should allow state->period < pc->period case?

You should not allow it. In v4 you had:

	if (state->polarity !=3D PWM_POLARITY_NORMAL ||
	    state->period < pc->period)
		return -EINVAL;

That's the right thing to do (even though I was unsettled at one point
and wrote it was wrong). The check in v5 with state->period !=3D
pc->period is wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ddzwp66u6avxreag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8ee8MACgkQwfwUeK3K
7AkRDAgAiUnatkQl/KD0wuhWITucTaiQM4Qo2QZDKhy/JLydo0U0VKR3+A/uN3QN
W3gcMAu9xeocUFMKtbrWAgCVczK+k1yfI9w5EB6fHRl65MlH5J3MwfDvib1EAIcm
H0kA9zCdlD5UujmGB6cJhgs+mnpJobdM/EV1OMGon8FlZ7AvopWJ34HZFFsUvA6P
FCme/aqyHZ92V6dAfemLY9J2yy7bjMiZUOhFAp13/3kwCWKaPL/IIL3Z5ShLCWMO
ASO/dZjP3PT5oDryiKq43XR2zftEVzgw+gKroVhvuN8Vo1n3MHVeNvdvq52m2C7C
KCKTd+qGQy0VWGG+M2xuI/7n8xHZZg==
=NaYd
-----END PGP SIGNATURE-----

--ddzwp66u6avxreag--
