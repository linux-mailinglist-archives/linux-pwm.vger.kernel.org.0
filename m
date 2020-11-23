Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227372C17B5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Nov 2020 22:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKWVcC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Nov 2020 16:32:02 -0500
Received: from mout.gmx.net ([212.227.15.18]:35725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729668AbgKWVcB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 23 Nov 2020 16:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606167075;
        bh=sCkDsbnNYQ6Pz3/oXpsDLnfnKp/ckhQ+TZMQxjRgd3A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=SXALL6dkqlmI+G8wKpUobuPezQXOviKE/83S7qWtriuewgq+ufJ+kxT9ve4fjInvI
         GonNpTmd89Qvh1smmkHwXVIBRZtkr2pVH0IszY8YubSYztbvlkUdp6xgijeNdOk6YZ
         IFsEsSyuAPGAWEM8oG9sRS+qhDd6RwHi6DqjJnFA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1kfNcZ33P7-002WX6; Mon, 23
 Nov 2020 22:31:14 +0100
Date:   Mon, 23 Nov 2020 22:31:05 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20201123213105.GC456020@latitude>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-6-j.neuschaefer@gmx.net>
 <20201122231054.GH348979@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Content-Disposition: inline
In-Reply-To: <20201122231054.GH348979@piout.net>
X-Provags-ID: V03:K1:no2Gna2hTxM9N5hL6CMDIOPd7xqpgCHA1PYx+QzCYCYXmJO39aV
 eh7+fejXcNZipfhKMG4JqyZ/n52hEDbvWcp8GOh9WWLAVTxcSPWaY0uyyTIfkOYzsEBa2fN
 vzGT4ccpUzfKb1AZcm6jP/+dmiEo9t1b3E/6l2mASZjnAsCaN0oePm15gRfFyHzFc6bCzGX
 PzaZLnarMAtk6ofOIYwLw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xtB5ZZleEYM=:6oYlbp6ZnPxYRMENT5U0SS
 4J2O/eVE4/KL5m+Cda1SDfZXXmisRKcJs0HHlkREUhR5df04phBeO/+BG8Yybesk8i/uWEw0k
 l+HWrSz8OyE3/OvkUkzP3C///oqqX0ucMc3DR0b6g48fEwiL6HPDyLQ8i6XpBCqI8BQ98MsgT
 lB74HdiSpOWvj3EzDPNBxFbkpW2mKLxt39ZU77oMiPIOWkDpPhCcPkl1/aH8EtDCzWaZBCnmE
 QpYh0A79fNO5zf9Uf6wJppJMj2Jyht1lCtEZens4jfP5cJVkGZJLcZM48H4i6lAOP4G15rzJz
 +v+muE10se/Pz8Z7d5E0DS0NUoLrUQXKQjZIrbZI3R/5ln8xp7gnbLOnlWmF5ora4KYrq/7ZR
 iyMQN0VF+IOwGbo/CQdJRbGmWBt5bEonEL4aZPB6MXCNrYh4BrYCk+0FV5tTqba3wJr4SgreY
 OSClmWSsmL4B+kldZm9ZctIkhw7mtXR+vWuthkhv25BwObusoB4FbQjQnn4cLu+7edjtzMB6S
 2jEhEk72s7zQBVnXa9fX/gX8xGIx60uJ2YMFqVHd8n6jdiYrdn6nM8buTpZsuFJLRb9CuloWm
 3mS9CtS+czTdRcIosoFzZ3Zd/rlKn+dRTx3RhoyZj3HweS1xQ3SP7EoRURuJRIjbYuLzqPSn7
 e10uYatI6jjmSX8OvWyCV/vZfuLm9yuxyNH/rSdit0YL0bbcfXdM2RM1MjFjI00Clg2xNT9kX
 4p0RDASSbP6uEiDcQ4v+LYMkJ2Y8YiOn6KKcqGg3QF0KcKxi2Y4EkGd6vevxAo6aHfgxUKtml
 7f8PaEBwMg/VNOovqidzcbBofYpATnBsJgAMT6wd71BVTj2aqrmdP6aVctHUMGT15O67o4hCG
 c6ACLePStWn6+FJHfcXw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 12:10:54AM +0100, Alexandre Belloni wrote:
> Hi,
>=20
> On 22/11/2020 23:27:37+0100, Jonathan Neusch=C3=A4fer wrote:
> > With this driver, mainline Linux can keep its time and date in sync with
> > the vendor kernel.
> >=20
> > Advanced functionality like alarm and automatic power-on is not yet
> > supported.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> However, two comments below:
>=20
> > +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> > +	int res =3D 0;
> > +
> > +	/*
> > +	 * To avoid time overflows while we're writing the full date/time,
> > +	 * set the seconds field to zero before doing anything else. For the
> > +	 * next 59 seconds (plus however long it takes until the RTC's next
> > +	 * update of the second field), the seconds field will not overflow
> > +	 * into the other fields.
> > +	 */
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_r=
eg8(0));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, ntxec_reg=
8(tm->tm_year - 100));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, ntxec_re=
g8(tm->tm_mon + 1));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, ntxec_reg8=
(tm->tm_mday));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, ntxec_reg=
8(tm->tm_hour));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_r=
eg8(tm->tm_min));
> > +	if (res)
> > +		return res;
> > +
> > +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_re=
g8(tm->tm_sec));
>=20
> Couldn't you do a regmap_block_write or a regmap_multi_reg_write which
> would be more efficient as they would be locking the regmap only once.

I can't find regmap_block_write anywhere, but regmap_multi_reg_write
looks like a good approach to simplify the code here.


[...]
> Note that this won't compile after
> https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit=
/?id=3Dfdcfd854333be5b30377dc5daa9cd0fa1643a979
>=20
> We can solve that with immutable branches though.

Thanks for the heads-up. Please let me know if/when there is any action
that I need to take here.


Jonathan

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl+8KggACgkQCDBEmo7z
X9v/Ew//VyQzd+IM6WSdNJfdqhDWx4zMzJPjvhGl5YZsqC82CgOowqAy6GWPkRvN
4xkwP5r4kH5Do6rN92mpKEGzG9HyDOzS/162ZMCIF9KXUOdpHb7viqRB5+Jq9Tod
2mFgQT9/foVbge9Muad0H4u59kmRbxp52mbRjF2XohPmD/rPVF8r1VrDaHOSSkx/
GbBVkLz0YIE6T0Wz4umG6d0+TTlelOuz72zqHy6zE2DHwHR/8vyRKPbdsft6w6f4
DRjjQrEKwj2LT1yx48PIXu9bDI6g+0syC9bwbf2dc3Nvl/nQpxrxrbrnt0H5+h9R
OyoSTQunwN/s8ppkdopfcQJVf1H4NAMCxoUXSnIX7zkKoPAeckXqQhsWXoJid2rF
tVt3HG2ddEvV3xW5fMftLXQWeegx7Wy5wqpQvpQPBJx3hrxC2mv0lIYbVMPPGKyM
+vF6atGRir3Jv/AYEeVEojBFrM9dG1xQTIvJz3fVRlM0fLqbj73kMFN+eHNmO3gA
o4H9WZ76TeaGyGoAMZ7KBJbypFfy27GlzHaChw7yqpYKPsi57dy8zLB57PRATAJy
/0q6gnpkrSNlaTYKwO/TDgR9E7NY0h9ALE34bqalDR5wNy7ec6Fa7iAouAm5lZcX
HEcbLvr0895GsbLNX8Ep5zg4V4TrCevq0c3x0ur1ZS8LL7n988Q=
=BhsG
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
