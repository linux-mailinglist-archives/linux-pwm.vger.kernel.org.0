Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B332074B4
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2020 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbgFXNhn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 Jun 2020 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389611AbgFXNhm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 Jun 2020 09:37:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4063CC061573
        for <linux-pwm@vger.kernel.org>; Wed, 24 Jun 2020 06:37:42 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jo5aj-00021q-9E; Wed, 24 Jun 2020 15:37:29 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jo5ag-0000Qt-Lx; Wed, 24 Jun 2020 15:37:26 +0200
Date:   Wed, 24 Jun 2020 15:37:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roy Im <roy.im.opensource@diasemi.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [RESEND PATCH V13 3/3] Input: new da7280 haptic driver
Message-ID: <20200624133726.en7q52rpdtzvhajz@taurus.defre.kleine-koenig.org>
References: <cover.1592221223.git.Roy.Im@diasemi.com>
 <135761fd309eb9424faeb631b6e6c66147b57666.1592221223.git.Roy.Im@diasemi.com>
 <20200623144105.mxhcrtezbghjb2vb@taurus.defre.kleine-koenig.org>
 <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhqythlia4hm7njs"
Content-Disposition: inline
In-Reply-To: <DB8PR10MB3356697B41C0FB97F5FD330185950@DB8PR10MB3356.EURPRD10.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zhqythlia4hm7njs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 12:04:24PM +0000, Roy Im wrote:
> Hello Uwe,
>=20
> On Tue, June 23, 2020 11:41 PM, Uwe Kleine-K=F6nig wrote:
> >=20
> > Hello,
> >=20
> > On Mon, Jun 15, 2020 at 08:40:23PM +0900, Roy Im wrote:
> > > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > > mode and integrated waveform memory and wideband support.
> > > It communicates via an I2C bus to the device.
> > >
> > > Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> >=20
> > Just some picky comments below.
> >=20
> > > +	error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > > +	if (error)
> > > +		dev_err(haptics->dev,
> > > +			"failed to apply pwm state: %pE\n",
> > > +			ERR_PTR(error));
> >=20
> > You can save some horizontal space here by dropping the \n after the fi=
rst comma. (There are a few more occurences.)
> >=20
> Ok, is this what you want?
> 	error =3D pwm_apply_state(haptics->pwm_dev, &state);
> 	if (error)
> 		dev_err(haptics->dev, "failed to apply pwm state: %pE\n",
> 			ERR_PTR(error));

Yes, that's what I meant.

> > > +	return error;
> > > +}
> > > +[...]
> > > +
> > > +		/* Sync up PWM state and ensure it is off. */
> > > +		pwm_init_state(haptics->pwm_dev, &state);
> > > +		state.enabled =3D false;
> > > +		error =3D pwm_apply_state(haptics->pwm_dev, &state);
> > > +		if (error) {
> > > +			dev_err(dev,
> > > +				"failed to apply initial PWM state: %pE\n",
> > > +				ERR_PTR(error));
> > > +			return error;
> > > +		}
> > > +
> > > +		/* Check PWM Period, it must be in 10k ~ 250kHz */
> >=20
> > The unit of a PWM period is in (nano)seconds, to it cannot be in the ra=
nge [10kHz, 250kHz]. (Is this too picky?)
>=20
> No, it isn't. The 'Period' should be changed to 'frequency', I will fix t=
his as below.
>=20
> 		/* Check PWM frequency, valid range: 10k ~ 250kHz */

Much better.

> >=20
> > > +		period2freq =3D 1000000 / state.period;
> > > +		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> > > +		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> > > +			dev_err(dev, "Not supported PWM frequency(%d)\n",
> > > +				period2freq);
> >=20
> > Doesn't the compiler warn here about period2freq being unsigned and %d =
being for signed int values?
> >=20
> > For my (non-native) English ear s/Not supported/Unsupported/ sounds bet=
ter. Also my eyes would be pleases by a space
> > before the opening brace.
>=20
> I didn't see any warning message, but I will change/improve them to prope=
r one and the log as below.
>=20
> 		period2freq =3D 1000000 / state.period;
> 		if (period2freq < DA7280_MIN_PWM_FREQ_KHZ ||
> 		    period2freq > DA7280_MAX_PWM_FREQ_KHZ) {
> 			dev_err(dev, "Unsupported PWM frequency (%u)\n",
> 				period2freq);
> 			return -EINVAL;
> 		}
> If you look ok, let me update this so.

looks fine.

Note that you don't need the division if you check for:

	if (state.period > 100000 || state.period < 4000) {
		...

(maybe the compiler is already clever enough to get rid of the division
for you, but then the check is:

	if (state.period > 100000 || state.period < 3985) {
=09
because of rounding errors.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zhqythlia4hm7njs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7zVxMACgkQwfwUeK3K
7AlXVAf9HRzkCDGGcPRgZ80akVQUHlZiEjxERV6vqcfovSDtb9k4JAaroFBySDps
yaRZycXC3uMsMd/LkLsMj1j2W6pCAiGAQPDlQdg4J0yorMCisBk2i8CGl8D5MZ1L
enTj1rLH+yqsrhDOS5Aixmr2qRy5rtA/h2naqLco3FLC9FWglCA/S1CIud6xRK7W
KJJvZIyKYNaJSMYTpZIg5Gqn7INIrHNqRkfRM+sCf7GJ+vRucpsBo+i1BNY/RNo9
fP4CJJWQMVIx1V8/3HLNFUCH1+GemarDFdoBtZBpojctWNOnPq17p0N03lW0m5UD
hmy4RP8pr6e3LZMzluQQOoKCtVWEeQ==
=t7qH
-----END PGP SIGNATURE-----

--zhqythlia4hm7njs--
