Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7F281F22
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Oct 2020 01:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJBXh2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 19:37:28 -0400
Received: from mout.gmx.net ([212.227.15.18]:60275 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBXh2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Oct 2020 19:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601681797;
        bh=Cq9vTFcGgfGkaOlFARc7DhuLOmS2Z4JLueL5I7koNrA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=V8abCQ5unU5gd1wcIKVTOJdtrJS3dpCC+u5WhoRES1xI/MQ8yJGuC5RXXfkf7C/xq
         mIGc+xIhNsVMtY+8rObJrL5fF2916Ko0sLdBRjqydMplqEKbdRTp1fYu0BKu3yfbFl
         CCQEZ+bVnj7jQzhWVQFrO5fHFQNjzes1NTINgVY0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1k7mZ73Prh-00LDLt; Sat, 03
 Oct 2020 01:36:36 +0200
Date:   Sat, 3 Oct 2020 01:36:30 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20201002233630.GB500800@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-5-j.neuschaefer@gmx.net>
 <20200925063037.fcrmqvpe5noi3ef4@pengutronix.de>
 <20200927211044.GC2510@latitude>
 <20200928083546.gwu7ucx7os5yc5bn@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20200928083546.gwu7ucx7os5yc5bn@pengutronix.de>
X-Provags-ID: V03:K1:dvTLs4gl0RVuoU+bxxRCIQplXCfSxGcQyK9mb/ZEoLVMFRsuDEJ
 EFeYRGPU2z4JgRoyvzZ3Pw/4PRElwOBI29MRNPd7WmFOMarA9aigDG7VcBiKqj+pYlTSx2K
 iV5eDiCFI64Qbh5k02mzFOCLpCqxInMFarHswjAJfJ9PEnquW45LxE2t/JQ+UL4L1JVzgIn
 4EuQFI7NIxxRM/TMBRgrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oe3+ZF9lnas=:whIwE6g45FI7hh+PURV+Oi
 aeDFNsNAWVFgu+Js0UaTemhppUe3quKl+VltvDLL2OE3ogD0L/xw3aFh3RrUIiSKD8z7/WpqM
 RQz5dPrhmLINECEM9BrDjlc41a0RY10ofXvKnHwcOippBwUTSGtuI2KvCHvb+IkWQToMFzxhH
 +Fe+s6uGLEvf7fzGeantESZmtKNMmKzDuWqv8u9RHJ3wQjpS0+gzg/MPKt0Uf5/s5a5fNeWOZ
 efEwYwv/Ej0zdnCMz8+xiPwi7j5UMpvqN+Z2wt73G/vlkGGTGULqxnAqbFPG31bS2TlbOVBPf
 9747lefpsBLb+KTZ7/ghjS+/gw5HT/esPitXY6XKmySxKfFBuadHxjfiMvBaoJzc3R9Nc3pzz
 UOQnConK8K4T9916q7sEEHaEZBywSiEowvT8to08nudJAANJ46HHMTh/TfRcBrR63Vm0o6sXG
 paZNO249xesvYlN/Rbx+lV5nDE4OR2ckJhbppqKy6hP+Op6kCmP8RfQppenWIC1dMuXNI/fg0
 CY3JE74EBrnhCHq1GwGRxeo+XVXAgG7JseG5S4EQjRP2IRj1hvlM5Z+LtXgQ7W/gYqcLkq4zZ
 QpaRHiGKl4Ymen763Xtpb+qW7nnLIghdDQP2UnQlrS8GUBhKerGVAm3QAxIIVZoiJuaDclaLV
 JMU+tx7hl0HukJPR/5pL+0wdGW62HyZdXUTAJSKtltZaxcCHPHrn8x/IOxQIGZLvzZTE6knwf
 g5AzcQqaxnBVaJuGZBHORbb1fBKuDEa4yBMZu6ND7QkJnEMXRBa6ztMx1i+ooyqZ8NDBemJiC
 jy1t1TwrqK8WhTdBGekfV7CkI7gwBOoFWZE14ltLgKM8NXRbTtLgvCTouCHDciSGOrsrrquFK
 WrezQdLhWfGGLXKVq+p6fW5Y5w0U21uhBt1Z1jyyXJ29Tob0PO1OchqODDHFtjuGcEbtaeLfs
 j7URts3Dz01dqhOhMgemkTLTJpShxLEyJBCCkrECrDhjGK2Ez0yATMEWMF/UDl+kJbdqQhi3D
 K78kggoyV+LCn7kgVcofpp/PrVgKifTJXxEbxww2gQMSLKm7MWULbIOsvJlANSYNsXdTONHY3
 MZUAWN7lwmL8KMcsLq2wRXECz/0UZ8vHvq8BD/vJdZal0+o64T119HittD1EiitoB5ir9SxH8
 txJH3d0n4Z3LjZf/2lYJxwlFv5w3YUa2/fgWSh05K/job1WP45bf7sj51faeaodXf60R86h97
 VEBY4ZEiXCOJcCyLxckQhVsy1vsJc0wx/RrKDnw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2020 at 10:35:46AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jonathan,
>=20
> On Sun, Sep 27, 2020 at 11:10:44PM +0200, Jonathan Neusch=C3=A4fer wrote:
[...]
> > > > +	if (state->enabled && duty !=3D 0) {
> > > > +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_re=
g8(1));
> > > > +		if (res)
> > > > +			return res;
> > > > +
> > > > +		/* Disable the auto-off timer */
> > > > +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntx=
ec_reg8(0xff));
> > > > +		if (res)
> > > > +			return res;
> > > > +
> > > > +		return regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxe=
c_reg8(0xff));
> > > > +	} else {
> > > > +		return regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg=
8(0));
> > > > +	}
> > >=20
> > > This code is wrong for state->enabled =3D false.
> >=20
> > Why?
>=20
> Hm, I wonder the same. Probably I just misunderstood the code, sorry :-\
>=20
> > > How does the PWM behave when .apply is called? Does it complete the
> > > currently running period? Can it happen that when you switch from say
> > >=20
> > > 	.duty_cycle =3D 900 * TIME_BASE_NS (0x384)
> > > 	.period =3D 1800 * TIME_BASE_NS (0x708)
> > >=20
> > > to
> > >=20
> > > 	.duty_cycle =3D 300 * TIME_BASE_NS (0x12c)
> > > 	.period =3D 600 * TIME_BASE_NS (0x258)
> > >=20
> > > that a period with
> > >=20
> > > 	.duty_cycle =3D 388 * TIME_BASE_NS (0x184)
> > > 	.period =3D 1800 * TIME_BASE_NS (0x708)
> > > =09
> > > (because only NTXEC_REG_PERIOD_HIGH was written when the new period
> > > started) or something similar is emitted?
> >=20
> > Changes take effect after the low byte is written, so a result like 0x1=
84
> > in the above example should not happen.
> >=20
> > When the period and duty cycle are both changed, it temporarily results
> > in an inconsistent state:
> >=20
> >  - period =3D 1800ns, duty cycle =3D 900ns
> >  - period =3D  600ns, duty cycle =3D 900ns (!)
> >  - period =3D  600ns, duty cycle =3D 300ns
>=20
> Does this always happen, or only if a new cycle starts at an unlucky
> moment?

Just based on thinking about the code, the register writes setting this
intermediate state would always happen, but I don't know if the state
changes are applied in the middle of a running period, or when the new
period starts, because I can't measure the signal in good enough detail
at the moment.

> > The inconsistent state of duty cycle > period is handled gracefully by
> > the EC and it outputs a 100% duty cycle, as far as I can tell.
>=20
> OK.
>=20
> > I currently don't have a logic analyzer / oscilloscope to measure
> > whether we get full PWM periods, or some kind of glitch when the new
> > period starts in the middle of the last one.
>=20
> You can even check this with an LED using something like:
>=20
> 	pwm_apply(mypwm, {.enabled =3D true, .duty_cycle =3D $big, .period =3D $=
big});
> 	pwm_apply(mypwm, {.enabled =3D false, ... });
>=20
> . If the period is completed the LED is on for $big ns, if not the LED
> is on for a timespan that is probably hardly noticable with the human
> eye.

The longest configurable period is about 8ms, so it's not long enough to
see anything. However, after writing enable=3D0, it can take about a
second for the PWM signal to turn off... this hardware is a bit weird.

> > > > +}
> > > > +
> > > > +static struct pwm_ops ntxec_pwm_ops =3D {
> > > > +	.apply =3D ntxec_pwm_apply,
> > >=20
> > > Please implement a .get_state() callback. And enable PWM_DEBUG during
> > > your tests.
> >=20
> > The device doesn't support reading back the PWM state. What should a
> > driver do in this case?
>=20
> Document it as a limitation, please.

Okay.


Thanks,
Jonathan Neusch=C3=A4fer

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl93uXQACgkQCDBEmo7z
X9ve+g/+K0GCAhYvwJtyogWj5zcm0jk75cUamD1ZaLEOHpZc1fHsYd9rVXV9lduC
QfJF+fPnwxX+8pEKrRgcEOJoifdUiM9er+I01c8FCldIhbkAgY3SGJ5BCDJpCIk3
xle6TKhe2VNN4nJZQ8w+HljSJK368B2w/XGPBL98k7LoIbtj+c/20dMiGm1UmJuK
00UrnfrddgtoIs+6HKY1xAErMIGGzJkxxa61QXwdZ/0Wz6VKMWUCLpLmgw9UWqzR
t+77KWaiO9dL6fAny7xTlo069Uix7VWSmhaSV4fysvgdAdH2itu/BxJskq7ZrDbt
x6Vq0CZAw8hJCpvzbhjUdPxzr/Rr5mHO3OH4jtuLaRSSV5Yvcxwb+Cil9WNXJ56y
zrnVv8wy6RT5IJrjsdz9KFbXjmLg/NLQU4WSy9wkKLO4x/QuUMkf8XPn6hQzi/xS
oRVaN1JaFwfvzeWRlh8Xh4gUvBEu5Coy6/aM7/X+1fuSJtOB7sbr3J55Lsqnixhx
bSGdKeU94kJPnNGyL7w8aoaDP0GaUf5ofKY6iGGDtrRAWcvUfI8BMWDPLiSAvEic
BFUY51R6ICNAs8dm32pxTHab8kaRsikIbTc8eWar6vwAB0X9VP26gltXPkUrUdyc
xpzIrwYpTlNCAyKrxWYD0piqwrVczBSrHn8hwPkuXawU+FEPU/Q=
=1O2M
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
