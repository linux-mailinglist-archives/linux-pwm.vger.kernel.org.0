Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D1F2E0609
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 07:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgLVGbJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Dec 2020 01:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLVGbJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 01:31:09 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98DCC0613D3
        for <linux-pwm@vger.kernel.org>; Mon, 21 Dec 2020 22:30:28 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krbBg-00021e-C7; Tue, 22 Dec 2020 07:30:24 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krbBf-0005z5-C3; Tue, 22 Dec 2020 07:30:23 +0100
Date:   Tue, 22 Dec 2020 07:30:20 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Sean Young <sean@mess.org>, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: bcm2835: Improve period and duty cycle calculation
Message-ID: <20201222063020.654mz5zgj764mldc@pengutronix.de>
References: <20201221165501.717101-1-u.kleine-koenig@pengutronix.de>
 <6742ade7-8ed4-a778-38a8-4433d4854ba0@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cgelwwiosleq6j26"
Content-Disposition: inline
In-Reply-To: <6742ade7-8ed4-a778-38a8-4433d4854ba0@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cgelwwiosleq6j26
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Florian,

On Mon, Dec 21, 2020 at 03:04:25PM -0800, Florian Fainelli wrote:
> On 12/21/2020 8:55 AM, Uwe Kleine-K=F6nig wrote:
> > With an input clk rate bigger than 2000000000, scaler would have been
> > zero which then would have resulted in a division by zero.
> >=20
> > Also the originally implemented algorithm divided by the result of a
> > division. This nearly always looses precision. Consider a requested per=
iod
> > of 1000000 ns. With an input clock frequency of 32786885 Hz the hardware
> > was configured with an actual period of 983869.007 ns (PERIOD =3D 32258)
> > while the hardware can provide 1000003.508 ns (PERIOD =3D 32787).
> > And note if the input clock frequency was 32786886 Hz instead, the hard=
ware
> > was configured to 1016656.477 ns (PERIOD =3D 33333) while the optimal
> > setting results in 1000003.477 ns (PERIOD =3D 32787).
> >=20
> > This patch implements proper range checking and only divides once for
> > the calculation of period (and similar for duty_cycle).
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > during review of the bcm2835 driver I noticed this double division.
> >=20
> > I think the practical relevance is low however because the clock rate is
> > fixed to 10 MHz on this platform which doesn't result in these
> > deviations. (Is this right, what is the actual rate?)
>=20
> Currently this is correct but the PWM input clock can be configured from
> the divider of a PLL that runs at 500MHz so this change is potentially
> useful in that regard.

Thanks for your feedback; is this an Ack?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cgelwwiosleq6j26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/hknkACgkQwfwUeK3K
7Anr1wgAmtdw8hDFAwtBgCd+CznpPP5UwiWj+A8f1M5aDXnGGOfyFztdeskqJHnX
eDibfQ4jgk5b6fha2RokRQSBcDz785j5kWdohMuviP+RTY9FTXHDf/uNRyPnKM14
Y3wvjntB+pIfFe9hOYjJ4XxeTQIEeHi1V0Vfbocqj9JegxB5MHp0lQp7+k53Kl0y
r2YwiE2blLO3WhWSK5ItG/EzImBuvFX4QjwQ7e+ykD5FvPh2o7/p/olnSXzUuGJb
NXdrQ+3eH/sNeWLN8kfcK0ia1Q4ML3E7sPdYzt+uZlY/ZwRhkSRLKrDNO/6lSHYf
cK/Z8AxtFBGtdfhrqY3Z5nyytMQHJQ==
=HmFo
-----END PGP SIGNATURE-----

--cgelwwiosleq6j26--
