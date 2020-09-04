Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD5D25E2B2
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Sep 2020 22:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIDU0b (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Sep 2020 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgIDU0a (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Sep 2020 16:26:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA7C061244
        for <linux-pwm@vger.kernel.org>; Fri,  4 Sep 2020 13:26:30 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kEIHs-0006ZU-BG; Fri, 04 Sep 2020 22:26:20 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kEIHq-0003uC-F4; Fri, 04 Sep 2020 22:26:18 +0200
Date:   Fri, 4 Sep 2020 22:26:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "G Jaya Kumaran, Vineetha" <vineetha.g.jaya.kumaran@intel.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Subject: Re: [PATCH v5 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200904202618.m72jkoco75zunabi@pengutronix.de>
References: <1598437559-25828-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598437559-25828-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <20200902062543.hf5resp6yci2zojc@pengutronix.de>
 <SN6PR11MB257504DDA3FA499D6740FD0FF62D0@SN6PR11MB2575.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jszovevqpqvewkzk"
Content-Disposition: inline
In-Reply-To: <SN6PR11MB257504DDA3FA499D6740FD0FF62D0@SN6PR11MB2575.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jszovevqpqvewkzk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 04, 2020 at 09:42:37AM +0000, G Jaya Kumaran, Vineetha wrote:
> > > +	clk_rate =3D clk_get_rate(priv->clk);
> >=20
> > clk_get_rate() must only be called when the clock is enabled. Unless I =
miss
> > something this isn't ensured here.
>=20
> My understanding is this would not be a problem, as according to
> databook, the GPIO block clock is auto-enabled, and also we are not
> doing any disabling in the driver for it.=20

It might not be a problem on your hardware today. But this is an API
requirement.

> > > +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
> > > +	 * the high time of the waveform, while the last 16 bits contain
> > > +	 * the low time of the waveform, in terms of clock cycles.
> > > +	 *
> > > +	 * high time =3D clock rate * duty cycle
> > > +	 * low time =3D  clock rate * (period - duty cycle)
> > > +	 *
> > > +	 * e.g. For period 50us, duty cycle 30us, and clock rate 500MHz:
> > > +	 * high time =3D 500MHz * 30us =3D 0x3A98
> > > +	 * low time =3D 500MHz * 20us =3D 0x2710
> > > +	 * Value written to KMB_PWM_HIGHLOW_OFFSET =3D 0x3A982710
> > > +	 */
> > > +
> > > +	clk_rate =3D clk_get_rate(priv->clk);
> > > +
> > > +	/* Configure waveform high time */
> > > +	div =3D clk_rate * state->duty_cycle;
> >=20
> > Since v5.9-rc1 (commit a9d887dc1c60ed67f2271d66560cdcf864c4a578)
> > state->duty_cycle is a 64 bit type. So div being unsigned long isn't
> > big enough on some platforms.
>=20
> div is 64-bit here, so I guess I can keep it as is?

unsigned long isn't 64 bits wide on all platforms.

> > > +	/* Ensure enable bit for each channel is cleared at boot */
> > > +	for (ch =3D 0; ch < KMB_TOTAL_PWM_CHANNELS; ch++)
> > > +		keembay_pwm_disable(priv, ch);
> >=20
> > .probe() is not supposed to change the state of the PWM.
> >=20
>=20
> Sorry, I think misunderstood one of your comments in V2 and added this.
> The reset value of the enable bit (and all other bits) in the LEADIN regi=
ster is 0, so this may not be needed.=20
> If it's ok, I'll remove it.

I think the right approach is to set the LEADIN register to 0 in
=2Eapply().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jszovevqpqvewkzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9SoucACgkQwfwUeK3K
7AntWwgAhOeMJs7mvcbn6ZZDIBuBPD9Y8wdR2y8jpfmLEwkJvNUjtsiq5oZSkwM1
ToJWsEx/aOV0TOv67Vm9BDAN+ts7TlHO8qrij5g3FurpOROVDB3bq7HXES5rteaK
W37XDECgdQpE4tt6W2QrGQMk5r6eyD2+KpekP610KOSu7fhYhQcT1VhbspsuLcha
qgQMHW/eWyfk84kNV6Zgb0XvjzBYARZVqe6SMNTIUvPyy1kuuRBGRK857O54hK9x
YH5KDaxVuB5fPK63t7nKA0YzLTDz1HRCBtNIFyaz8mCpmT49Xs0IZ+7YdZNrxKV2
M1EicEw5f1GmolpKnA0ieKatoiycRg==
=mACI
-----END PGP SIGNATURE-----

--jszovevqpqvewkzk--
