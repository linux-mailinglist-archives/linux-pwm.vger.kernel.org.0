Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E067120C6EB
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2020 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgF1IMO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Jun 2020 04:12:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:43445 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgF1IMO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 28 Jun 2020 04:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593331870;
        bh=ilAolY9zcROmAM6sLH3wHgyoKIg/P4EV0Jj9xLYeJrI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lUC5LBYL51s3TSX8918x/RPDDkLmLTczoISsjeRLVTUj6FK8FYhzmOFcfVUjT2jzL
         ieolblQcnnHrDtQR6IA2XM8QPJ0e+ZhuP4GFvLcitf4giwYQWKDUqLnB13lMrEW4Id
         c7HPG+t3yr8EYeRG/G8yA+TdV69vDlJcXLiF558g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpnm-1j1ZjD3xj0-00pOlZ; Sun, 28
 Jun 2020 10:11:10 +0200
Date:   Sun, 28 Jun 2020 10:11:06 +0200
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
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 04/10] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20200628081106.GA2561@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-3-j.neuschaefer@gmx.net>
 <20200622105544.GU954398@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20200622105544.GU954398@dell>
X-Provags-ID: V03:K1:RASC/LJEjYQJsnKkiQZwsgxxjmVhyduIE2PlRo0IHsfaYbHOCb4
 9Fhrjkzw0lB3dkMYb5IuBsxUzf3BXO5/POMffm3WQ9yosH2IudupCQ8YFHNah6E/F+VRkdd
 6kRX0X4tb7W6CX+Z7RIlmjOrn+YydrosPzESqBVTwFcdwDMuCoCt/27NnBjPsicLARymuri
 jhg2QJmVlfNGq8vhf7ayQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JOLAdVxuDio=:Ewnq/jZljOL6hUZ33fHcXz
 56T7M+SqycdjmFhJ5My8Ok1wzweq5sUUrl2mffz7ioZTcIqN6rr5L5y0Z+/9zOdfma9PRTacr
 njf9PiZHgLEqKoRQFDJ4iJmWZ7nvDNoo1XVMG+WHF1c+Dczc2rHGduvLV6nTidpXIHLFbtcev
 MJYw/DTkTZ5cjI/56LU6EFSxkQ+stYJm7LMMm0NPdFWFVkDG+vJT868cexCKnaoWK0ena/4IH
 aiuCvAuaBleL2urgk22ceIgpPwuuH7+2lC6R238B8/pPQaa5vH63fTNE7wFM0lI3LkNalNKu9
 wjypGNutp+bMMD48fdHhrhpQQfhklQ0h4Wn8w5VFmmT6DCAZ1NU0pMqZLprUMl3cFIA1tlqLG
 a/mAODvCW4Cp+w8xfRAI2fhBIp/O3sL6aT0xyyUua7aPGMiAT+MKcmlRcvHByJOn+IUABGJ0+
 sOjuoRWLWrn0G+v8SN33SMCRubjR8u5Ege23/KCNazEThPgtckwkDiPZtDlGRonRe8BJu+Czg
 OJR0rxn40SiBygNiW66xRSOEOWaFw7utYnXc4E94YYIUuODvJsmYIlq6jM1mtAd9F5tPXbRlB
 UVJLkZwdIlaWiDmQHkDYTxYO1uaWhsz73hxPb8pLt7Q9o12+9N7sYsX/wfZVgKnVxAOHgt2bh
 zRysst5xk0+0yu5QKIM9nvVD/lYVnzB/y82F+69WOYaAzxgzwEoezCZw8nvwPOfrpc4n+FsK6
 NTx4iRa5RHSFaCy5OIsyg+BiJEm5/R7NKNWZIgJAzpEsjOOqmGi8R/jDbXim4WdLr67/XYATA
 mys6OFyPwhv0KZVVI/VqBv9+1v7XS59d4zg/+wqKIshAnVZkLGLdZQNVzjaVI6I7IzSx0ERpU
 7y1yMQEcYlmfG9lYC4Mp3Gz9ffUJZf5wfASGmdabY4OoQe9hwpA/CnMszPoHM1QTpoOUSuzbV
 kaOjPiKUfbSkHF0gbdagRMpwAq5eQLDh3McaNmoIEwN9cw8PLuyOEQNfBtPkIkuEMoZWPQGNL
 TXASU3G0aroTTe+FqlAr3yx2CB4cxSFFxrisEH8EyteMe4e/dYYCpXjJKBucxS3IETqJOC4rp
 xiRRo4sAjdBzxFJ9Whdt4anvW1lGlYo+Vv1aOrYMCPUe4O74JRk8YhT7/iruMPgywNZgLtlHk
 wkCcP6IO458PM8qCudXKJcoffob4Va2eAg2FVv9NbnzCMeQ0nImdzN3c+m1IorbMQWvzmeTB5
 HmvdDG1IvGmN60BKA2Q1Z7UdHuuV8uEJ+q1d62A==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 11:55:44AM +0100, Lee Jones wrote:
> On Sun, 21 Jun 2020, Jonathan Neusch=C3=A4fer wrote:
>=20
> Description of the device here please.
>=20
> > Third-party hardware documentation is available at
>=20
> '\n'
>=20
> > https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-cont=
roller
>=20
> Indent this with a couple of spaces.
>=20
[...]
> > +	help
> > +	  Say yes here if you want to support the embedded controller of
> > +	  certain e-book readers designed by the ODM Netronix.
>=20
> s/of certain/found in certain/.
[...]
> > +++ b/drivers/mfd/ntxec.c
> > @@ -0,0 +1,188 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +// Copyright 2020 Jonathan Neusch=C3=A4fer
> > +//
> > +// MFD driver for the usually MSP430-based embedded controller used in=
 certain
> > +// Netronix ebook reader board designs
>=20
> Only the SPDX line should contain C++ style comments.
>=20
> Description at the top, copyright after.
>=20
> An "MFD driver" isn't really a thing.  Please describe the device.
[...]
> > +#include <linux/types.h>
> > +
> > +
>=20
> No need for double line spacing.

Alright, I'll fix these.

> > +#define NTXEC_VERSION		0x00
> > +#define NTXEC_POWEROFF		0x50
> > +#define NTXEC_POWERKEEP		0x70
> > +#define NTXEC_RESET		0x90
>=20
> Are these registers?  Might be worth pre/post-fixing with _REG.

Yes, good idea.

>=20
> > +/* Register access */
> > +
> > +int ntxec_read16(struct ntxec *ec, u8 addr)
> > +{
> > +	u8 request[1] =3D { addr };
> > +	u8 response[2];
> > +	int res;
> > +
> > +	struct i2c_msg msgs[] =3D {
> > +		{
> > +			.addr =3D ec->client->addr,
> > +			.flags =3D ec->client->flags,
> > +			.len =3D sizeof(request),
> > +			.buf =3D request
> > +		}, {
> > +			.addr =3D ec->client->addr,
> > +			.flags =3D ec->client->flags | I2C_M_RD,
> > +			.len =3D sizeof(response),
> > +			.buf =3D response
> > +		}
> > +	};
> > +
> > +	res =3D i2c_transfer(ec->client->adapter, msgs, ARRAY_SIZE(msgs));
> > +	if (res < 0)
> > +		return res;
> > +	if (res !=3D ARRAY_SIZE(msgs))
> > +		return -EIO;
> > +
> > +	return get_unaligned_be16(response);
> > +}
> > +EXPORT_SYMBOL(ntxec_read16);
> > +
> > +int ntxec_write16(struct ntxec *ec, u8 addr, u16 value)
> > +{
> > +	u8 request[3] =3D { addr, };
> > +	int res;
> > +
> > +	put_unaligned_be16(value, request + 1);
> > +
> > +	res =3D i2c_transfer_buffer_flags(ec->client, request, sizeof(request=
),
> > +					ec->client->flags);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(ntxec_write16);
> > +
> > +int ntxec_read8(struct ntxec *ec, u8 addr)
> > +{
> > +	int res =3D ntxec_read16(ec, addr);
> > +
> > +	if (res < 0)
> > +		return res;
> > +
> > +	return (res >> 8) & 0xff;
> > +}
> > +EXPORT_SYMBOL(ntxec_read8);
> > +
> > +int ntxec_write8(struct ntxec *ec, u8 addr, u8 value)
> > +{
> > +	return ntxec_write16(ec, addr, value << 8);
> > +}
> > +EXPORT_SYMBOL(ntxec_write8);
>=20
> Why are you hand-rolling your own accessors?

There are registers which only require one byte of data and others which
require two. This didn't quite seem to fit into the regmap API.

It is possible to always use 16-bit accessors directly but that would
push shifts into call sites that only use 8 bits.
(If the 16 bits are interpreted as big endian)

I'm not sure what's ideal here.


> > +/* Reboot/poweroff handling */
>=20
> These comments seem to be stating the obvious.
>=20
> Please remove them.

Ok.


> > +	ntxec_write8(poweroff_restart_instance, NTXEC_POWEROFF, 0x01);
>=20
> All magic numbers should be defined?

Alright, I'll move them to the register definitions.

> > +	msleep(5000);
>=20
> Why 5000?

The idea was to avoid returning from the poweroff handler by allowing
enough time until the power is actually off. However:

 - I just tested it and the board I have turns off about 80ms after the
   I2C command.

 - I'm not sure if returning from the poweroff handler is actually bad.
   It does seem to be wrong, because I get a lockdep report when I
   remove the msleep and the kernel reaches do_exit in the reboot
   syscall handler:

	Requesting system poweroff
	[   14.465312] cfg80211: failed to load regulatory.db
	[   14.471171] imx-sdma 63fb0000.sdma: external firmware not found, using =
ROM firmware
	[   14.541097] reboot: Power down
	[   14.547296]
	[   14.548840] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[   14.553477] WARNING: init/156 still has locks held!
	[   14.558521] 5.8.0-rc1-00011-g65740c2d29bee-dirty #329 Not tainted
	[   14.564647] ------------------------------------
	[   14.569399] 1 lock held by init/156:
	[   14.573004]  #0: c17278a8 (system_transition_mutex){+.+.}-{3:3}, at: __=
do_sys_reboot+0x13c/0x1fc
	[   14.581978]
	[   14.581978] stack backtrace:
	[   14.586378] CPU: 0 PID: 156 Comm: init Not tainted 5.8.0-rc1-00011-g657=
40c2d29bee-dirty #329
	[   14.594834] Hardware name: Freescale i.MX50 (Device Tree Support)
	[   14.600979] [<c01121c8>] (unwind_backtrace) from [<c010cf3c>] (show_sta=
ck+0x10/0x14)
	[   14.608763] [<c010cf3c>] (show_stack) from [<c05e54ec>] (dump_stack+0xe=
4/0x118)
	[   14.616115] [<c05e54ec>] (dump_stack) from [<c0130d54>] (do_exit+0x6ec/=
0xc04)
	[   14.623291] [<c0130d54>] (do_exit) from [<c01582f0>] (__do_sys_reboot+0=
x148/0x1fc)
	[   14.630892] [<c01582f0>] (__do_sys_reboot) from [<c0100080>] (ret_fast_=
syscall+0x0/0x28)
	[   14.639000] Exception stack(0xc8c6dfa8 to 0xc8c6dff0)
	[   14.644071] dfa0:                   00000000 00000000 fee1dead 28121969=
 4321fedc 00000000
	[   14.652266] dfc0: 00000000 00000000 00000001 00000058 00000001 00000000=
 00000000 00000000
	[   14.660458] dfe0: 000a2290 bef21db4 0006db1f b6f02a0c


I'll adjust the number a bit and add a comment to explain the msleep
call.


> > +static int ntxec_restart(struct notifier_block *nb,
> > +		unsigned long action, void *data)
> > +{
> > +	/* FIXME: The I2C driver sleeps, but restart handlers may not sleep */
>=20
> Then this is not allowed.
>=20
> You need to fix this *before* submitting upstream.
>=20
> > +	ntxec_write8(poweroff_restart_instance, NTXEC_RESET, 0xff);
> > +	/* TODO: delay? */
>=20
> TODO *before* submitting upstream.  This is not a development branch.

Sorry. I'll research how other drivers deal with the issue of sleeping
I/O in the reset path.


> > +/* Driver setup */
> > +
> > +static int ntxec_probe(struct i2c_client *client,
> > +			    const struct i2c_device_id *ids)
> > +{
> > +	struct ntxec *ec;
> > +	int res;
>=20
> What does 'res' mean?

Result

> > +	ec =3D devm_kmalloc(&client->dev, sizeof(*ec), GFP_KERNEL);
> > +	if (!ec)
> > +		return -ENOMEM;
> > +
> > +	ec->dev =3D &client->dev;
> > +	ec->client =3D client;
>=20
> You don't need both (if any).

Ok, I'll drop ec->client.

>=20
> > +	/* Determine the firmware version */
> > +	res =3D ntxec_read16(ec, NTXEC_VERSION);
> > +	if (res < 0) {
> > +		dev_dbg(ec->dev, "Failed to read firmware version number\n");
>=20
> Why dbg?

I'm not sure anymore, but I agree that it seems more significant than
debug level.


> > +	/* For now, we don't support the new register layout. */
> > +	if (ntxec_has_new_layout(ec))
> > +		return -EOPNOTSUPP;
>=20
> What is the new layout?

It's a significantly different command set, see 'if (NEWMSP) ...' in:

  https://github.com/neuschaefer/linux/blob/vendor/kobo-aura/drivers/mxc/pm=
ic/core/pmic_core_i2c.c


> Why don't you support it?

I don't have any hardware that uses it. The downstream driver supports
both layouts so I wanted to ensure that this driver doesn't use the
wrong one.

> > +	if (of_device_is_system_power_controller(ec->dev->of_node)) {
> > +		/*
> > +		 * Set the 'powerkeep' bit. This is necessary on some boards
> > +		 * in order to keep the system running.
> > +		 */
> > +		res =3D ntxec_write8(ec, NTXEC_POWERKEEP, 0x08);
> > +		if (res < 0)
> > +			return res;
> > +
> > +		/* Install poweroff handler */
> > +		WARN_ON(poweroff_restart_instance);
>=20
> Why WARN?

Two instances of this driver where both try to be the poweroff/restart
instance seemed like a situation that is always unintended and a bug in
the devicetree (or somewhere else).

>=20
> > +		poweroff_restart_instance =3D ec;
> > +		if (pm_power_off !=3D NULL)
>=20
> if (pm_power_off)

Ok

>=20
> > +			/* TODO: Refactor among all poweroff drivers */
>=20
> Nope.

Alright.

>=20
> > +			dev_err(ec->dev, "pm_power_off already assigned\n");
>=20
> Error, but execution carries on anyway?

Hmm, I guess if the poweroff handler can't be installed there also isn't
much point in installing a restart handler...

> > +		/* Install board reset handler */
> > +		res =3D register_restart_handler(&ntxec_restart_handler);
> > +		if (res < 0)
>=20
> Is >0 valid?

"Currently always returns zero"

However, other callers tend to do "if (res)".

> > +			dev_err(ec->dev,
> > +				"Failed to register restart handler: %d\n", res);
> > +	}
> > +
> > +	i2c_set_clientdata(client, ec);
>=20
> Where do you use this?

The sub-devices drivers (RTC, PWM) call `dev_get_drvdata(pdev->dev.parent)`
to get a pointer to the ntxec struct, which is then passed to the
register accessors.

> > +static const struct of_device_id of_ntxec_match_table[] =3D {
> > +	{ .compatible =3D "netronix,ntxec", },
> > +	{}
> > +};
>=20
> Use .probe_new() and drop this.

Ok, I'll switch to .probe_new()

Should I really drop the OF match table, though?

> > +static struct i2c_driver ntxec_driver =3D {
> > +	.driver	=3D {
> > +		.name	=3D "ntxec",
> > +		.of_match_table =3D of_ntxec_match_table,
> > +	},
> > +	.probe		=3D ntxec_probe,
>=20
> Nothing to .remove()?

Good point, I'll add a remove method.

> > +};
> > +builtin_i2c_driver(ntxec_driver);
>=20
> Only built-in?

Currently, this is consistent with the Kconfig entry, but I'll look into
making the driver buildable as a module.

> > diff --git a/include/linux/mfd/ntxec.h b/include/linux/mfd/ntxec.h
> > new file mode 100644
> > index 0000000000000..9f9d6f2141751
> > --- /dev/null
> > +++ b/include/linux/mfd/ntxec.h
> > @@ -0,0 +1,30 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright 2020 Jonathan Neusch=C3=A4fer
> > + *
> > + * MFD access functions for the Netronix embedded controller.
>=20
> No such thing as an MFD.
>=20
> "Embedded Controller"

Ok, I'll rephrase the comment.

> > +struct ntxec {
> > +	struct device *dev;
> > +	struct i2c_client *client;
> > +	u16 version;
> > +	/* TODO: Add a mutex to protect actions consisting of multiple access=
es? */
>=20
> No TODOs.  Please fix before upstreaming.

Sorry, I'll clean them up.

> > +static inline bool ntxec_has_new_layout(struct ntxec *ec)
> > +{
> > +	return ec->version =3D=3D 0xe916;
>=20
> Why don't you just check for the devices you *do* support?

Good point. This would be the most conservative approach. If someone
then shows up with a different version, it can be added as tested and
known working.


Thanks for the review,
Jonathan Neusch=C3=A4fer

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl74UJMACgkQCDBEmo7z
X9vJ0RAAsmlSjItyptx9DfFrpDELUABKv6n8a2HLNbXSuI7i9RK3bPzd+1Y7kr0R
fUVSn2J/AClZi8Kn85EXeuTJNjZutpKLtyHvkDeUGUzR0vL7UV8pi6/R3bMm2V7y
hmAEmjnJcn48AzsX8Cd75WQFjFN/ngBXoaM+VJvqkLzMQv0HMA18ikNYvf65GsKR
8DYvlOrgZq/Q+5G6DhUVKbdiuQlurrUUWaco37pcQCy84rLoKkwvwxBVGAUa7Ir3
GEUXv5DoDNXh0K9U5axSEI/wbYUI4gVIy71ro0z1W4JlOCTdejRt4oT6DY75g+hW
DmCsakS2N+r7lPDi2tlvKg+qaOoM2QEX/9P7S9U2aQCSwpf2+5YvitDOHP9J3jsx
tQwmhdUh0A16PTJr0bhj+q31g8LGMNW6dZ9NjObJk/L6M03QJm24liqubaFY+5Rm
VBSLeptSeKNizMz1ok6yv/g/2AdmBLJzYPr2XSHOUiaWQxZnYxjtq6b4nR9WrzG2
YpfM/8IKVQaUXCo9U7OQU3anGj52eXmq4TKOyE/4uCNqVQ/tmgvj2xv9oUlCTL7Z
sImrY2ttDJ4B5/4ntaCo8/eg9T3hGiVs7NUmg/gahlfxQ/i+FnAOjjSmt57S56Ng
fe2xnm1GEEk+JYkfhShHtPbFkd/eN0K8mL9N8gEnf/TBg2ISmwY=
=bkUA
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
