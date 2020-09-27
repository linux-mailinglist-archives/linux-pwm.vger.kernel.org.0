Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD327A430
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Sep 2020 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI0VLs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 27 Sep 2020 17:11:48 -0400
Received: from mout.gmx.net ([212.227.15.19]:49497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgI0VLs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 27 Sep 2020 17:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601241051;
        bh=qVd4IBNRV8DN0dMqUdGypqqYYu8vUZdLxNcc0dQl9qg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=IJhFE/modoHQ2WBVha3Qbx9Tcua6m5oQF+vINcmuu1zuJy4tVwpZw96xFN2v3xvt7
         +TWVIiJYeFXTYzvhSlR5d7tyP5PDr02c67gg3U4DjxFYvnt9TvSKWVE2QK+2f6s4B7
         1UbmFgbzhW2ttX15Ay3a2KEplh8HllCWDjOj1E48=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Yv-1kaRKa1AmJ-00wDva; Sun, 27
 Sep 2020 23:10:51 +0200
Date:   Sun, 27 Sep 2020 23:10:44 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20200927211044.GC2510@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-5-j.neuschaefer@gmx.net>
 <20200925063037.fcrmqvpe5noi3ef4@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <20200925063037.fcrmqvpe5noi3ef4@pengutronix.de>
X-Provags-ID: V03:K1:00nuOkNowTQRCrCjdFKk5tV+lSRXoRV3Xt6XUa2nST9IL4fgThc
 VXjBJj3m1VTD0qkkgAo1TOFXZE6pQQ1qjelvnnGKZq1EP9dOhpcD7v7h5cjtEo2sFdYYIdc
 5UL6G9nI0REvXhr2+qv2LrhmebYL3yKlApm6xX3ljX9dD0FDVtAMKMbLVN8bynoRFV7GQBQ
 dZkxKsNepdzAkm6wlYjgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SQoj+zePzdM=:Z5VssEvwXj1u0kDjfgKFtE
 AgRhljRygNTYhIUAHhgWuzeRK6v0WtyxrtvzkYWHbGjL9AUT2axQ8eikiLPUrnoL33O5OoYl9
 iwn7V8YNKetV6OzGErHDY8E4/5KdPLhXIWV7xlJ6N1cePyboHpkDxSllH4vU5ujQddaDjpF25
 aCkZxhKFmXXdBXWQwB5V9jrnUobgaAdGBXs1LjKrSQdX03faxl/1LHGZCUxfbKbbuMSi2Uv1P
 yQmlKtTvEnKgnsiA0+akZJAD+rUKMg39GyU6vvF7Feqtj8w8eBSVHgN1LNyb46TJeGkx8tFAA
 6IRVk/wH7adyWP7n6vMgQig4OvmMmsLtfcBQsQRrhOFq/MejYKHhRNTgWz0IiUMFqTMgg4wJ9
 FestkvYe5BC7anktuvti3SCrUbHTWgBSLOfk/zola7xxWFFF6TxveGFmyi2YnTkq0f8T+Yojr
 utTpM0hEF5RIiezSnmC68clKkxsI3PuVfKfAmAUudCTOQV+Ttqf/tPxI4KWMUZehu9AXLusxy
 3rQSkq8yTFnH0pLdoCjtXH3R1aoqfp6MF1TVDuK1E3dW7lMT5x2X4lWi13ZOvXijVZquW2KEn
 K5hs3AHAyIE4DhLLIEfsViKnMMOBV+aKqzou1qUSsAePgJHwr8lZychaR7jh72ZKzCdppnnG3
 EpgjEDTJllF3qEUsF/Zt++kFU4umPWx8URmnakSVJDSIFMpGjuHgLf1l6RZnm6tHYPVh8OU8j
 VHRLzOGkwBs+lAzO4OtSJbseJQjCxZUhYPTZw8z2pMzjv8OzUefXe56aJUB9lZWVtX3xP19ez
 ArSRg1t5MsgD1FunvGTRUGaQXZNfKmHfYAoKi/9h7vdDNCM/se9wgmiKbwqSLXGKs/Jg2d31G
 j0KNLjZvFAcSGcKS/JFg8XqEMrzHWGxYfmQmf7m1wjr1nDE5C6XbaZiA5RgdmwUCvxgOzYH1/
 nqwHWmuJNXX0ar5NXsaIKLeJEPPmMEmpmygtjFHLJ4osdLSOl1Beikj55CxUGLCLwmk0jAASF
 ZpgsaEnFp+ggd2kAuBB8+5jjfv6AJL+UpBi0QuGSoY7rcehju9qA8hk+rqJEBc24guAcROU+b
 /LTJkEURNjH+jLDBu6sQ9deam2dpuHJq/WG1BWlKl+qpjRQqDC40fEB4WdL8JUKrFOjptFEDu
 nYXjZ5r5Z1wTH6ci15/BC2PWVkEZyxMSngTYfGq7FmYMRllgC4z0tytU7F9LF6dw6WGMMT/pD
 UzduXX708P8t6fiYqAK9qghVzGmrS0Gqx85Zwgw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 08:30:37AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jonathan,
[...]
> > +config PWM_NTXEC
> > +	tristate "Netronix embedded controller PWM support"
> > +	depends on MFD_NTXEC
> > +	help
> > +	  Say yes here if you want to support the PWM output of the embedded
> > +	  controller found in certain e-book readers designed by the ODM
> > +	  Netronix.
>=20
> Is it only me who had to look up what ODM means? If not, maybe spell it
> out?

I'm sure other readers will have the same problem. I'll spell it out.

> > +/*
> > + * The maximum input value (in nanoseconds) is determined by the time =
base and
> > + * the range of the hardware registers that hold the converted value.
> > + * It fits into 32 bits, so we can do our calculations in 32 bits as w=
ell.
> > + */
> > +#define MAX_PERIOD_NS (TIME_BASE_NS * 0x10000 - 1)
>=20
> The maximal configurable period length is 0xffff, so I would have
> expected MAX_PERIOD_NS to be 0xffff * TIME_BASE_NS?

Due to the division rounding down, TIME_BASE_NS * 0x10000 - 1 would be
the highest input that results in a representable value after the
division, but I'm not sure it otherwise makes sense.

>=20
> > +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm_dev,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(pwm_dev->chip);
> > +	unsigned int duty =3D state->duty_cycle;
> > +	unsigned int period =3D state->period;
> > +	int res =3D 0;
> > +
>=20
> I assume your device only supports normal polarity? If so, please check
> for it here and point out this limitation in the header (in the format
> that is for example used in pwm-sifive.c to make it easy to grep for
> that).

I haven't seen any indication that it supports inverted polarity. I'll
point it out in the header comment, and add a check.

>=20
> > +	if (period > MAX_PERIOD_NS) {
> > +		dev_warn(pwm->dev,
> > +			 "Period is not representable in 16 bits after division by %u: %u\n=
",
> > +			 TIME_BASE_NS, period);
>=20
> No error messages in .apply() please; this might spam the kernel log.
>
> Also the expectation when a too big period is requested is to configure
> for the biggest possible period. So just do:
>=20
> 	if (period > MAX_PERIOD_NS) {
> 		period =3D MAX_PERIOD_NS;
>=20
> 		if (duty > period)
> 			duty =3D period;
> 	}
>=20
> (or something equivalent).

Okay, I'll adjust it.

> > +	/*
> > +	 * Writing a duty cycle of zone puts the device into a state where
>=20
> What is "zone"? A mixture of zero and one and so approximately 0.5?

Oops, that's a typo. I just meant "zero".

> > +	 * writing a higher duty cycle doesn't result in the brightness that =
it
> > +	 * usually results in. This can be fixed by cycling the ENABLE regist=
er.
> > +	 *
> > +	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
> > +	 */
> > +	if (state->enabled && duty !=3D 0) {
> > +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1=
));
> > +		if (res)
> > +			return res;
> > +
> > +		/* Disable the auto-off timer */
> > +		res =3D regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_r=
eg8(0xff));
> > +		if (res)
> > +			return res;
> > +
> > +		return regmap_write(pwm->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_re=
g8(0xff));
> > +	} else {
> > +		return regmap_write(pwm->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0)=
);
> > +	}
>=20
> This code is wrong for state->enabled =3D false.

Why?

> How does the PWM behave when .apply is called? Does it complete the
> currently running period? Can it happen that when you switch from say
>=20
> 	.duty_cycle =3D 900 * TIME_BASE_NS (0x384)
> 	.period =3D 1800 * TIME_BASE_NS (0x708)
>=20
> to
>=20
> 	.duty_cycle =3D 300 * TIME_BASE_NS (0x12c)
> 	.period =3D 600 * TIME_BASE_NS (0x258)
>=20
> that a period with
>=20
> 	.duty_cycle =3D 388 * TIME_BASE_NS (0x184)
> 	.period =3D 1800 * TIME_BASE_NS (0x708)
> =09
> (because only NTXEC_REG_PERIOD_HIGH was written when the new period
> started) or something similar is emitted?

Changes take effect after the low byte is written, so a result like 0x184
in the above example should not happen.

When the period and duty cycle are both changed, it temporarily results
in an inconsistent state:

 - period =3D 1800ns, duty cycle =3D 900ns
 - period =3D  600ns, duty cycle =3D 900ns (!)
 - period =3D  600ns, duty cycle =3D 300ns

The inconsistent state of duty cycle > period is handled gracefully by
the EC and it outputs a 100% duty cycle, as far as I can tell.

I currently don't have a logic analyzer / oscilloscope to measure
whether we get full PWM periods, or some kind of glitch when the new
period starts in the middle of the last one.

> > +}
> > +
> > +static struct pwm_ops ntxec_pwm_ops =3D {
> > +	.apply =3D ntxec_pwm_apply,
>=20
> Please implement a .get_state() callback. And enable PWM_DEBUG during
> your tests.

The device doesn't support reading back the PWM state. What should a
driver do in this case?

> > +	.owner =3D THIS_MODULE,
> > +};
> > +
> > +static int ntxec_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct ntxec_pwm *pwm;
>=20
> Please don't call this variable pwm. I would expect that a variable with
> this name is of type pwm_device. I would have called it "ddata" (and the
> type would be named ntxec_pwm_ddata for me); another usual name is "priv".

Ok, I'll rename it.

> > +	chip->npwm =3D 1;
> > +
> > +	res =3D pwmchip_add(chip);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	platform_set_drvdata(pdev, pwm);
>=20
> If you do the platform_set_drvdata earlier you can just do
>=20
> 	return pwmchip_add(chip);

Good idea, I'll do that.


Thanks,
Jonathan Neusch=C3=A4fer

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9w/8UACgkQCDBEmo7z
X9v+uBAAn25NpiHhNJtO6YKlwketM5qW1G37xao76/fwdBuKMc11FECDeyH6jd7/
G/OSggdKa5hom2VNhTVMQ1UvRcTdZxuoJi9a/UMBFZo1HHfP/zWejuWZw5TeA2X9
ubB+5qJTVbTTAoxzf8gu8nx4tYUBUqFhSGsKI+lqlJyGgHMD73P9/VBT4JobxjOA
w4dKyUYcjfN2eVNqnuiSa/hYO11uugv+hqOjgiWAGcafBVUUzcWgpn6QG406v/1X
MCm5tTLwkUOEPNsJmPQsbNmVXVIRJjppNq/jlPHIeGsm+JofkxQymk7VlzquGW64
adnPIhAo/A0RrrKDV18p7/twuRVHvvxIoAPSIrOWZRE7vNQ9TqN2kwebvS/qSLbO
/6RAwZW8bgPepQq0HSVjwOTwaP1XGutcSI/yNCF2VoAjEsKPWP7Qk9M8BZEnpz7D
+bfM1Yfyeo8s0BFZ/MZIx+sfi1PeCpXKk2l7RV+E3W0hfdWIBoqjvonxth2kjU2T
zvtv9kRXJA9yz2UEXo0jQWwO4AifcX6HK/xsmIiPXlI90cerAAKYeYV3atyTqjvr
t5+/9IZxfQfspdOQBZ8k81OI/X2f2fiUXrsWfzMjTUjTRNkeNAm8MI8ARIf5QvPW
pUtEJWd5PBGgn6QbG0dnGlNEQIV+YGZv0BlpOZ/xfPg1+VHWuaw=
=IRtw
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
