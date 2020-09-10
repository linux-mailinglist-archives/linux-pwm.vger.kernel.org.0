Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3939F2645BE
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 14:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgIJMKr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 08:10:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:44215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728350AbgIJMFy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 08:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599739483;
        bh=qzVY6yzsPrrf2h1jDkFWfRG1ddzeALKdqUvY8f8kxa0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=L5I+NtBQ4gZ/XaRxgukenzKpoKqHPEZpN2IFx04psb175gIZasjOoEKDhYR7RKWsM
         UVvVc1MqYmbY2N6StTu3oFTQEulC0QsY8hdw8hi2XpQwAIfVZTEQsY2U0vP1RhrNI9
         IIyg8IOPGtDPT16OLfLCR4nKBf2Fw71QrbN4ADdY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuUnA-1kXb1F1EZO-00rWJE; Thu, 10
 Sep 2020 14:04:43 +0200
Date:   Thu, 10 Sep 2020 14:04:28 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 03/10] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20200910120428.GA3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-4-j.neuschaefer@gmx.net>
 <20200908132934.GT4400@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200908132934.GT4400@dell>
X-Provags-ID: V03:K1:x4RJpktdT7JqtxxiLTo52FsNglQaWRz741nH+QILas+w8FVRcxR
 27KV3AYLrQ49I1+1TR+bS9tBtkWHrt+q8ONM5fw4l6U1A/Z3e4g4EHu58UuKkwp5JRwwl+O
 2zn7mGlCAtYpOxJJuGOChMvjvJeNk4XH6elgua7y9AbMuiNAGJv+Gpj2bqY/AhM1Ld4atm5
 0sSPE/ntwgudtH1KF9KQw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z4yHja/RVZA=:b//O0Nm5oZG2cmyxDslxPn
 hmBuwD0HrNXuKQMt9uqK4F7LHtaGl9rVKY08v5Yzs4Kmu7LL5aiUjVAPFyj0BJTq6r8m9T1k3
 YVIYsDNZGuu1u4FKSed17rS/HM4MviPvASOhMtHpbf3h4W77lHKVeWhK3z4S4UVxTe1bQGsg3
 p4w7y1atkbYVOp7iflZhCfJQT2mHOx8Mz1biSvsWVn3CXEbOsffLdV/tpZnjPoRTsMt8rRxVc
 qqHSUoPF9FCWyGDQazJ0Vzdy4AdxnO78Hu6O7qm80El55Z8KtIbiqUzrsTmqZIeNMDM41W/Gq
 JZsK4009+xLOYUPKRMWRl3984P0N//A5tBvYuCpTbUm0p9YspP9eT+jL9OBFWB2Owq6pCAkgV
 8lg2Gb5bsBXXduA+rNVfLvJsHWOvcSxH9B2HEREL5M5BqrbsxmvE7tSy4yhv360pW+2ldEXp9
 JTMWMR1JrgEm03bbYIXVYrDODP4s8SqcFDAPB4++2XZqlTmekeaBxsfr4WUecLsueSV0+0rFk
 gewoOOiQf8IPYKu8UJrssRHBh/p4NsNXk8zBAxVwdiCKWBPFgzgTS7E/oXfs5IyAhwvwq3NdB
 YrZIm1aCpQcmYLYbjRWzziZcKyptQ+GgoGkAom0hEUk/528D30070bCeYMt3V/7ap+de7XwvS
 UEmxghiJpmNKeaoxvYGW3Sl8EBwtZw/CdhlEAON5PSfJkvUyPBWvfiupNqhhLow/2gspq7zVi
 /VaqredhmPUjZJYwTru9L5LTuqWyfNBsMeajWae+tuWkGgiokja6Zmvr3pMASoYPMm91kY26P
 /k+wDXCiXlmLnE+/7gr+ApRnUQKUJmrF6DcUIDKJNPRVrZjBZpqsBIK2MFdwPEaKCNUKaC0ps
 t2HT0iRDVUsYHc9LVLJnj+5+SITUBVFlHyESItMegcof6FCycgUWkDoaJJOJ/Enrg6mffqhyC
 Gq8vu8rZa/rh0Z+TkXt5pqr9/CrIdjezoUvprhRbO4PK4r8aU6ZthJP7DWF2oS688d50i3eFO
 8JZfTrGzj6X7cFqajzIJcRZsGaCZSrIQKPGx7Y2JxJQ2w8GxAxxqBHSWOEYg9II1jPK8pAZ7+
 wk7kMg1NDLJ5OWN0TvAaMu/JchcU2P3NsU6YIikneTbwOjycTi84X7p/7ndhAjk+KYttjltz2
 icKLjgh2PJEjNhHkodas3whdkWo8WTbH4MQ1SH8g7nE+94TGgy/SqjOZivI/6DjEluHCtRm6t
 o9Zv+D5ye67W+TloUPhX9sievjMfqdCVS6k2ksQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 02:29:34PM +0100, Lee Jones wrote:
> On Sat, 05 Sep 2020, Jonathan Neusch=C3=A4fer wrote:
[...]
> > +config MFD_NTXEC
> > +	tristate "Netronix embedded controller"
>=20
> Nit: "Embedded Controller (EC)"

I intentionally left it lowercase, because the term 'embedded
controller' is not used in code coming from Netronix. It's just a label
that I found fitting to assign to the device. (In the vendor kernels
it's either called 'msp430', named after the TI MSP430 microcontroller
family, or 'uc', presumably for 'microcontroller')

Adding '(EC)' seems somewhat useful.

>=20
> > +	depends on I2C && OF
>=20
> 	depends on (I2C && OF) || COMPILE_TEST

Okay

> > +++ b/drivers/mfd/ntxec.c
> > @@ -0,0 +1,217 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
>=20
> Why 2 only?

No particular reason. If you prefer 2-or-later, I'll change it.

> > +/*
> > + * The Netronix embedded controller is a microcontroller found in some
> > + * e-book readers designed by the ODM Netronix, Inc. It contains RTC,
> > + * battery monitoring, system power management, and PWM functionality.
> > + *
> > + * This driver implements register access, version detection, and syst=
em
> > + * power-off/reset.
> > + *
> > + * Copyright 2020 Jonathan Neusch=C3=A4fer
>=20
> Email?

Alright, I'll add it

> > +static void ntxec_poweroff(void)
> > +{
> > +	int res;
> > +
>=20
> Remove this line please.
>=20
> > +	u8 buf[] =3D {
> > +		NTXEC_REG_POWEROFF,
> > +		(NTXEC_POWEROFF_VALUE >> 8) & 0xff,
> > +		NTXEC_POWEROFF_VALUE & 0xff,
> > +	};
> > +
>=20
> And this one.
>=20
> > +	struct i2c_msg msgs[] =3D {
> > +		{
> > +			.addr =3D poweroff_restart_client->addr,
> > +			.flags =3D 0,
> > +			.len =3D sizeof(buf),
> > +			.buf =3D buf
> > +		}
> > +	};
> > +
> > +	res =3D i2c_transfer(poweroff_restart_client->adapter, msgs, ARRAY_SI=
ZE(msgs));
> > +
>=20
> And this one.

Okay

>=20
> > +	if (res < 0)
> > +		dev_alert(&poweroff_restart_client->dev, "Failed to power off (err =
=3D %d)\n", res);
>=20
> This looks way over 80 chars.

Okay, I'll break it up.

> Did you run checkpatch.pl?

Yes, but it didn't complain about this line. - propabably because the
line length threshold in checkpatch has recently been increased to 100.

> > +	/*
> > +	 * The time from the register write until the host CPU is powered off
> > +	 * has been observed to be about 2.5 to 3 seconds. Sleep long enough =
to
> > +	 * safely avoid returning from the poweroff handler.
> > +	 */
> > +	msleep(5000);
> > +}
> > +
> > +static int ntxec_restart(struct notifier_block *nb,
> > +			 unsigned long action, void *data)
[...]
>=20
> All as above for this function.

Alright

>=20
> > +static struct notifier_block ntxec_restart_handler =3D {
> > +	.notifier_call =3D ntxec_restart,
> > +	.priority =3D 128
> > +};
> > +
> > +static const struct regmap_config regmap_config =3D {
> > +	.name =3D "ntxec",
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 16,
> > +	.cache_type =3D REGCACHE_NONE,
> > +	.val_format_endian =3D REGMAP_ENDIAN_BIG,
> > +};
> > +
> > +static const struct ntxec_info ntxec_known_versions[] =3D {
> > +	{ 0xd726 }, /* found in Kobo Aura */
> > +};
> > +
> > +static const struct ntxec_info *ntxec_lookup_info(u16 version)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(ntxec_known_versions); i++) {
> > +		const struct ntxec_info *info =3D &ntxec_known_versions[i];
> > +
> > +		if (info->version =3D=3D version)
> > +			return info;
> > +	}
> > +
> > +	return NULL;
> > +}
>=20
> Wait, what?  This is over-engineered.

I thought it would be useful when we want to attach additional
information to specific versions.... okay, it is over-engineered.

> Just have a look-up table (switch) of supported devices.

Will do.

>=20
> > +static int ntxec_probe(struct i2c_client *client)
> > +{
> > +	struct ntxec *ec;
> > +	unsigned int version;
> > +	int res;
> > +
> > +	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> > +	if (!ec)
> > +		return -ENOMEM;
> > +
> > +	ec->dev =3D &client->dev;
> > +
> > +	ec->regmap =3D devm_regmap_init_i2c(client, &regmap_config);
> > +	if (IS_ERR(ec->regmap)) {
> > +		dev_err(ec->dev, "Failed to set up regmap for device\n");
> > +		return res;
> > +	}
> > +
> > +	/* Determine the firmware version */
> > +	res =3D regmap_read(ec->regmap, NTXEC_REG_VERSION, &version);
> > +	if (res < 0) {
> > +		dev_err(ec->dev, "Failed to read firmware version number\n");
> > +		return res;
> > +	}
> > +	dev_info(ec->dev,
> > +		 "Netronix embedded controller version %04x detected.\n",
> > +		 version);
> > +
> > +	/* Bail out if we encounter an unknown firmware version */
> > +	ec->info =3D ntxec_lookup_info(version);
> > +	if (!ec->info)
> > +		return -EOPNOTSUPP;
>=20
> #define EOPNOTSUPP      95      /* Operation not supported on transport e=
ndpoint */
>=20
> I think you want:
>=20
> #define ENODEV          19      /* No such device */

Indeed, EOPNOTSUPP seems quite wrong here. I think I used ENOTSUPP at
some earlier point but moved away from it because it's one of the
internal error codes (=E2=89=A5512).

ENODEV makes sense when I read it as "Not a device that this driver can
deal with".

>=20
> > +	if (of_device_is_system_power_controller(ec->dev->of_node)) {
> > +		/*
> > +		 * Set the 'powerkeep' bit. This is necessary on some boards
> > +		 * in order to keep the system running.
> > +		 */
> > +		res =3D regmap_write(ec->regmap, NTXEC_REG_POWERKEEP,
> > +				   NTXEC_POWERKEEP_VALUE);
> > +		if (res < 0)
> > +			return res;
> > +
> > +		/* Install poweroff handler */
>=20
> Don't think this comment is required.
>=20
> > +		WARN_ON(poweroff_restart_client);
> > +		poweroff_restart_client =3D client;
> > +		if (pm_power_off)
> > +			dev_err(ec->dev, "pm_power_off already assigned\n");
> > +		else
> > +			pm_power_off =3D ntxec_poweroff;
> > +
> > +		/* Install board reset handler */
>=20
> Nor this.

Alright, I'll remove them.

> > +		res =3D register_restart_handler(&ntxec_restart_handler);
> > +		if (res)
> > +			dev_err(ec->dev,
> > +				"Failed to register restart handler: %d\n", res);
> > +	}
> > +
> > +	i2c_set_clientdata(client, ec);
> > +
> > +	return devm_of_platform_populate(ec->dev);
> > +}
> > +
> > +static int ntxec_remove(struct i2c_client *i2c)
>=20
> Why do you call it 'client' in .probe, but 'i2c' in .remove?

No particular reason. I'll make them consistent.

> > +struct ntxec_info {
> > +	u16 version;
> > +};
> > +
> > +struct ntxec {
> > +	struct device *dev;
> > +	struct regmap *regmap;
>=20
> > +	const struct ntxec_info *info;
>=20
> What is this used for?

At this point, nothing. I'll remove it.


Thanks,
Jonathan Neusch=C3=A4fer

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9aFjsACgkQCDBEmo7z
X9tAGQ//SrW5PtjGv5XZfjK/Y51oKvi2VtoRlg6p03T3vUyB9j7OPeoadeFgsJae
RFlyDcecCt3TFA8hG9L16YBQ34+xA/W0Sa+fN9QM9JBtGpCitFNHYEyar6ONOmAl
tfWwjnj6s5ddT9/7+Vq8I0PN5hU5IlpsNSmQQr1W/NtcWrywctorAn4S4RVyMKPs
9invE5HDBx7DZEOOHf0F0zOnIw3ilayCe5aAAhjMo0Q/rbDtrX54M1yr7KkyZxyh
6Kn4gQPLvw3rneXDKmsvMj4bPi/NNrs4WWqwLFsaLkCX9sXwdOssKoLRNO2zj6AJ
wUJB2BEZa/DCbCP/oOGrZzpf80sOW+ELpCc4lKkasywI3FEOOC0DhythD342SYwz
GBC7MOiwHd3fXn2owynnyj+3QUWd3hg+Rbl6ueaLMXY0Mb1ojmi8GfYHZTORlcpZ
3iXS9CazhgPD2ZTDka3B0H8C2IzpUV5ku7r8jVNxeUHCrV200asvpwZNojewXF//
lCGucwAB8tSwVNPlPLuVUnqQLSm1RJoY0zsWb9YGJj4WtQK9crmK2GEfFPTSEetK
n0JfMJYlbO1oa69tVDnw1guPNFPYRiKzpE3rS8KVVgaF7LtjouAJX+Fj+0414/Z6
iQiwfoMawFirtow8DvdHt0Y+OSazNz4Y3wn1UkI1V1ikYTRi86c=
=ckCY
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
