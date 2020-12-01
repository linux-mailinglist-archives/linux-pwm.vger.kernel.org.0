Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE372CA3BC
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Dec 2020 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgLANYv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Dec 2020 08:24:51 -0500
Received: from mout.gmx.net ([212.227.15.15]:39937 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgLANYu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 1 Dec 2020 08:24:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606828950;
        bh=i99VwzJVGDFj3yDrUcbTJd0SNy2PldxWlO3kTHGKLXw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Zwd0VIYYnGXiDuOA6FLSux2St/gVHc1ZCYSj+oXFYP+92QdH/VOHnd2luK+POgYee
         I7P1tEsKF4VIfntD3Synfo54JVpV7XV5EBDlFZa5T+R9LtTfRudySMYUIWvjdIQlGY
         N/D6qOQeCOso+G9rZSALz8OvtwQyRuCIOYF/Njrg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1kZslF2XSh-00SSVC; Tue, 01
 Dec 2020 14:22:30 +0100
Date:   Tue, 1 Dec 2020 14:22:14 +0100
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
Subject: Re: [PATCH v5 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20201201132214.GI456020@latitude>
References: <20201201011513.1627028-1-j.neuschaefer@gmx.net>
 <20201201011513.1627028-5-j.neuschaefer@gmx.net>
 <20201201072026.a736ikf3k4udpvfv@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
In-Reply-To: <20201201072026.a736ikf3k4udpvfv@pengutronix.de>
X-Provags-ID: V03:K1:3pVRVbCHusToiK9w2c2SDTiGjXj/Tj+6gQjSAUb5JekWayHQDXA
 wcasTbzJCVBBO6njymdHIgFtmDPU9chbDh/Fk4bLj603l8LoqWDSRe0YcVWwsO+jOukabGF
 SPAFK4ww4JnVLbrgbngHLgOghkISvExEATUY812ilwdf2Sjob/lVTbr4wuPg7f4mdT+gHrH
 WW/jExP5U7+1QU/m8xRyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ytFrjKioSvE=:Fjb5K17JJr1g923oMgTnwP
 A1lRewsRZFpkZjcrv8VFhEWOLp6I0HiUNB4sKlaY7LMB58CWwYViIzm0K7Xd7UgQto6d/lpiS
 TqVCNKBWOXIEPQP5dzh+xptE2+DAmLZY0tgMt+MEx93EpxZnQV+gBpS01ynwf7WxU0muW6VlJ
 HqqixcFNMx24hPcST4jjQE1EPdVqEle8j2iZo5j/acZLbdJOt3lNCLfoYPO6fJe+AqhapxSFE
 fS2giEKcPSMqm7W22ToJJ4rLTJVMdLIQcRGRQQPGn85ZSDgr2hv8PebQXGv6PHNgCS+ZXtR73
 qYI1seXN+BzOHIMqqFzXYjVwwMAmbT34y8uVYYMQdrywBS2fwHXyg7Xyl+QVDdN8hrq5YHkTi
 UgUvGVDPlLMOloJ2/9GmnBdkTHTPgHwcXyiY9Cn5xwVUKaY/GnNoS+kNVXT7whknGXtYXbh4Y
 hcI5lGP/UzqnmhDFn4uz6MNohvaQMv8owXUxPWJeHy5N5BVxba63UemBBUp4g19skMYVKj8k7
 rhUodmxLhXyoBTBBmqy8VElxbnOGJyTAj5XIk6aJqU5JKx14sA15tVDUg9I8mkgvvLnL7aPvc
 x9GdQTwhrK6TPeYWEx2j0IFegHGMwFZZCkpl4KgxUWU+veFyFms/BMZy8UtMCNGeCEN0hAzp6
 bmboyAlV8RmSK0pYEiPg0ujdzfPyNjl0+4BTAPVwERqPhm5r9uMNrNMubDsw7KmmV8DCtbQG3
 p7qqQjPJoWrxfyDjdmMsqOnSXhhdexPO61lb9gsuamLArYZLX3awTuzZiq1z7vB2eSu6tlkg6
 f4OBUamJNYwrBEU6ezr61I9ez2fFhqj6eRk0C6S5h5fe8ZAARXS+9Tf3hdVi2RcRDLbJLrZYw
 bp31UxZ6+nFm5SjOBOzw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2020 at 08:20:26AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jonathan,
>=20
> very nice driver, just a few minor comments below.
>=20
> On Tue, Dec 01, 2020 at 02:15:10AM +0100, Jonathan Neusch=C3=A4fer wrote:
> > +static struct ntxec_pwm *pwmchip_to_priv(struct pwm_chip *chip)
>=20
> a function prefix would be great here, I'd pick ntxec_pwm_from_chip as
> name.

Good point, will do.

>=20
> > +{
> > +	return container_of(chip, struct ntxec_pwm, chip);
> > +}
> > +
> > +[...]
> > +static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *p=
wm_dev,
> > +			   const struct pwm_state *state)
> > +{
> > +	struct ntxec_pwm *priv =3D pwmchip_to_priv(pwm_dev->chip);
> > +	unsigned int period, duty;
> > +	struct reg_sequence regs[] =3D {
> > +		{ NTXEC_REG_PERIOD_HIGH },
> > +		{ NTXEC_REG_PERIOD_LOW },
> > +		{ NTXEC_REG_DUTY_HIGH },
> > +		{ NTXEC_REG_DUTY_LOW }
> > +	};
> > +	int res;
> > +
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	period =3D min_t(u64, state->period, MAX_PERIOD_NS);
> > +	duty   =3D min_t(u64, state->duty_cycle, period);
>=20
> I'm not a big fan of aligning =3D. (As if you have to add a longer
> variable you have to realign all otherwise unrelated lines.) But that's
> subjective and it's up to you if you want to change this.

In this case, I thought it helps the readability, because the lines are
quite similar.

> > +	period /=3D TIME_BASE_NS;
> > +	duty   /=3D TIME_BASE_NS;

Here, I did it because I had already aligned the previous two lines.

> > +
> > +	/*
> > +	 * Changes to the period and duty cycle take effect as soon as the
> > +	 * corresponding low byte is written, so the hardware may be configur=
ed
> > +	 * to an inconsistent state after the period is written and before the
> > +	 * duty cycle is fully written. If, in such a case, the old duty cycle
> > +	 * is longer than the new period, the EC may output 100% for a moment.
> > +	 */
> > +
> > +	regs[0].def =3D ntxec_reg8(period >> 8);
> > +	regs[1].def =3D ntxec_reg8(period);
> > +	regs[2].def =3D ntxec_reg8(duty >> 8);
> > +	regs[3].def =3D ntxec_reg8(duty);
>=20
> You could even minimize the window by changing the order here to
>=20
> 	NTXEC_REG_PERIOD_HIGH
> 	NTXEC_REG_DUTY_HIGH
> 	NTXEC_REG_PERIOD_LOW
> 	NTXEC_REG_DUTY_LOW

Good idea, but I'm not sure if the EC handles this kind of interleaving
correctly.

> but it gets less readable. Maybe move that to a function to have the
> reg_sequence and the actual write nearer together?

Indeed, a separate function would keep register names and values
together (without resorting to declarations-after-statements).

> Or somehow name the indexes to make it more obvious?

Too much unnecessary complexity, IMHO.

> > +	res =3D regmap_multi_reg_write(priv->ec->regmap, regs, ARRAY_SIZE(reg=
s));
> > +	if (res)
> > +		return res;
> > +
> > +	/*
> > +	 * Writing a duty cycle of zero puts the device into a state where
> > +	 * writing a higher duty cycle doesn't result in the brightness that =
it
> > +	 * usually results in. This can be fixed by cycling the ENABLE regist=
er.
> > +	 *
> > +	 * As a workaround, write ENABLE=3D0 when the duty cycle is zero.
>=20
> If the device already has duty_cycle =3D 0 but ENABLE =3D 1, you might get
> a failure. But I guess this doesn't need addressing in the code. But
> maybe point it out in a comment?

Good point. I'll add something to the comment.

> > +	 */
> > +	if (state->enabled && duty !=3D 0) {
> > +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(=
1));
> > +		if (res)
> > +			return res;
> > +
> > +		/* Disable the auto-off timer */
> > +		res =3D regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_=
reg8(0xff));
> > +		if (res)
> > +			return res;
> > +
> > +		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_r=
eg8(0xff));
>=20
> Given that you cannot read back period and duty anyhow: Does it make
> sense to write these only if (state->enabled && duty !=3D 0)?

I think it does.


Thanks,
Jonathan

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/GQ3EACgkQCDBEmo7z
X9usHg/9FsmfCpoU+cy2Zt6dY0RcesbvapgYo5C8a/EuXIF22fNiiOlU+ONMCdjG
FDKzKhXmkstFv2VaBM41mUYHPiic4Yf58OS96UJdb7r+fhrFsQajX4h96ILbUkhH
bhGOzgHwwc3HRKb2YYlTGLcVhT6a5BFLIZW5bjfgs5x+ucKjD5VjInHU56WNHzO2
1QH3Qrg/essPZ5+ftewe0aFDKinyby4b1sd3gEA6n4NlUIi2COH84Mn5C8vJY6cG
uts9NJD80+DqpKyaLNh9a0IDwNWRX1cueizPLF9OghbyFhR7pFNxCDPkC5PkxkvW
0namUmrwk/SyZ5KM77xGCKwqZql6KvIBHtPtszuHXiaqd89tNM/CpxEoF9VQkY5g
BZdo0lCR1tEVBzy5ZsM6bQ/0uUB5+0N2hmkjcZ/W08HYUKa47jqNBCtV2dbYsF4m
3O4spfB6F7jM5+UBIfeslyXDnixDhegAAblkCYs8k9AQ/VlMVHtHaXikbi+Dx3d3
i+7AT+lfODFxSmvqWoYK6r0fjoLClTHDgoYC3huLFomaAKDeG1LAxDWosESJz5Lx
FGRjFN2kSCI/26KJ6FcLzF6viBC2yd/W7ht0x8+pMMU+L16mGB3bJGZSIAHvSPPh
CsVIC2HZIlMdpt57QCMq2Ocw0at9xwbhyFP3xr9kWKKMLjpQSxc=
=qsyh
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
