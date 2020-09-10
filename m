Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7FD264E60
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIJTMC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 15:12:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:43267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgIJTLG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 15:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599765003;
        bh=e/GjHdRDaBKeltHwO5EENqEZEm8NoRyfw4WXvri23to=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aLt0WaHp2K+27F8mFTyBRsEOuF3eHSIgFfbQfhSFJgr9Yffrr/ZRunmO2Bbat6tMx
         WtZn4odHoFdb4wJOURVOAr+tqg5Jh1yvULJgPpK7F/U+OY5hIG79BEL3z/AjA8LJ1T
         Oymy+kgmhcmsUTihUWDayy2ttFebbyhjolXg25ow=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1kRUd10zG4-00xe8D; Thu, 10
 Sep 2020 21:10:03 +0200
Date:   Thu, 10 Sep 2020 21:09:57 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 05/10] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20200910190957.GB3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-6-j.neuschaefer@gmx.net>
 <CAHp75VdUHoOyM3bObzhdfiqpne0AmSK_UakteTZxnjqJVrNV9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <CAHp75VdUHoOyM3bObzhdfiqpne0AmSK_UakteTZxnjqJVrNV9A@mail.gmail.com>
X-Provags-ID: V03:K1:2kulQix1IwHTgVYh/suxTjvDyKy9vES/+dG4cKEhMDL8fo3cwpx
 Ap8fmH3Xtn9sE0LmqdTVBm00y1TH3G+F5etIJE86d0XqwbeKveBHu/E0tCgmMRaKrU/5s4N
 kQBHyi5bHZdyFfVbKuTVZ1/KOtFUtCsIi7Rdszh5c+0OXRUMm0xHTbMx2b6zA4s3EnEFoFW
 QnrEy5D38+d/J881Yeyog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lYBiP+Z8Kk4=:chYqtZ+cZIbZ8Fq3mKK+xf
 0hsweLTA8hKYEdccbNZmU+tLUdqoXmCEzkPeGaHkwXhMKheaNSavaaU3j2QgXXKli/H5lWhQf
 mcgc50GPgkQ4CwY5LmRz7m+iUq7xwYgfUG9dq/+yk6PBHr/PVKVxTTRUpU/Gdtt7I0KYKcott
 6RZ1QGKvZjK5iA9Jl/nbkqDURaiPfve6C9inR8zm0F39IQEvzRMnU8tb6p5Y6FKiU63Jvabwc
 Z1pbYTyzVQAWdruLO2+XRyuBq5bvaT28mNqmA5oZN6v0Y2A06tXRYzVTA6pvG56gqEys1rYAA
 2Aw1DjBaW/DeQGzcMokboyUHGg+EsJDFyUMKEhCSlnZ30cfc1toZorH5HEY7zbWVINJZgMqRZ
 jLet36tfXyOOiF/rERI3vdeEMQ8oPTDXLB07rUOLF4PzkVShztLV9y3XDq6gjhAUWoVupLWD3
 xz5e8mFdXFg3wzgBfSdOj2331/a8dmuGta4fXlXVKj+j9TY3gtL59Yn/rXeLb+IW+snfZroKf
 9lpkYBYnMTYkQoNNxcMwAkPfvS4O4yk2D+gNp1mepW0SBtAUNL8TifSlqIgnuR08DWxPiHubW
 WgVjeqlmekr/mPhSCWYtOVsluN9rDhsX4pU5EY+T8rwVeav51ayElpncTZwPiP++nas3lkVt4
 grkYkU0lE1xpCvnNHqEvm7GKd1Xw7Xwz/ouUNA14+W4eV5zuXDFXtfewF8J/ftcKFX+a7R3gz
 hzbRygdytltvgyDUUWXTkjiZfxEDn1EimlprHBnOvpX/RLnInSpG6sDaJqnsKczkMUYLnxBp+
 G9tz5+Ke4AFSJll4+dWBAkAhdTc//sgxIuwpX/jaK6vLst9aHRJ32mpdfYeQRFau0PnKRpHMR
 fxkbu1WeI0AffX3hHq295RmXAggDrhxB1Crr6bGG4nn9jBA/prVkhSW1rJ/YQK4wV644/nMd7
 WItPBuxqqDJSUrErYiClR6rQRpbmkyMEV7zzkqbnY8GT92CPQyRuJUdE4tJquOHxoQ9IYUqNJ
 mbqRUfgso3i5PC5DOx9HsywTgH8/JIZwNy5i1W7E1E9ohbcQSTRxD24zkxqqVPgVdHQRd72Q1
 jreSPAVNEz/ekECmD6i9hp+05Jsp5gXGausBDvYB/laIDCmzglACJ9TM3mkA8/OGIQMYoI5ZE
 EHF9BtmZXGCJ3fsJc/Uhlh3IeRHNVawSWW8bAJxKm2BW8qhNxUbVrA4mNY4YuPYa0gBKzaPA2
 VoLjuDALpQNG98yZlblET1kpE6NEvHHJ3J+j9mg==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05, 2020 at 09:08:49PM +0300, Andy Shevchenko wrote:
> On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer <j.neuschaefer@g=
mx.net>
> wrote:
>=20
> > The Netronix EC provides a PWM output which is used for the backlight
> > on some ebook readers. This patches adds a driver for the PWM output.
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
[...]
> > +#include <linux/of_device.h>
>=20
>=20
> mod_devicetable.h

Okay

> > +/* Convert an 8-bit value into the correct format for writing into a
> > register */
> > +#define u8_to_reg(x) (((x) & 0xff) << 8)
>=20
>=20
> You spread this macro among the drivers w/o explanation what=E2=80=99s go=
ing on. I
> think there will be better approach.

Okay, I'll move it to ntxec.h and expand on the explanation. I think
what's missing is the following part:

  Some registers, such as the battery status register (0x41), are in
  big-endian, but others only have eight significant bits, which are in
  the first byte transmitted over I2C (the MSB of the big-endian value).
  This convenience macro/function converts an 8-bit value to 16-bit for
  use in the second kind of register.

> > +
> > +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_HIGH,
> > u8_to_reg(period >> 8));
> > +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_PERIOD_LOW,
> > u8_to_reg(period));
> > +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_HIGH,
> > u8_to_reg(duty >> 8));
> > +       res |=3D regmap_write(pwm->ec->regmap, NTXEC_REG_DUTY_LOW,
> > u8_to_reg(duty));
>=20
>=20
> These funny res |=3D is unusual pattern for returned error codes. Moreover
> you are shadowing the real ones. Same go the rest drovers. Please fix by
> checking each separately.

Okay

> > +       platform_set_drvdata(pdev, pwm);
> > +
> > +       return (res < 0) ? -EIO : 0;
>=20
>=20
> What?!

That's an editing error, sorry.

> > +static const struct of_device_id ntxec_pwm_of_match[] =3D {
> > +       { .compatible =3D "netronix,ntxec-pwm" },
> >
> >
>=20
> > +       { },
>=20
>=20
> No comma.

Okay


Thanks for the review,
Jonathan Neusch=C3=A4fer

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9aefUACgkQCDBEmo7z
X9s28xAAnaOJ911XlEgMRmp99aYqJpEdZgZvH/LVKEQBPLYT/XeUf/t2X5MqVTSG
VjhU4kbYvnUWrVL3Ud63qNe2TV73lI2mUOsz9wFu7coD/+QVmNv5Y2+/SsHBxNcr
sf6mOX5TTKkwe0bS6bChJZmpZ19fottJ6STYPgeTMJK7zxn299D4gEuO3KNjK8I2
k0PoE/U/CMAGb4lwzOQ55qXK9u/rmrPp15ME09TSePU0Mqip1ki/jg2qagSuxyfC
mvsUWZJlHSnx412cJucSpZmT/2IzlVgqn3YDuWOT+gvF0XrUXbKcGYsU4hkCeyb5
TFostixxqKy7YPXbgNJDQ9AXUXmAOBAMjy+knnR1EFgt8SLNITeiFgqoubIe1vJj
RA6V9ZNRCsBzRboplVeyjQYqmAWul4mlzezhVp6P9A5S/GfgziKOD5zrDMaGorUP
qA9Q00SbQuo2WMasehHeo0x1vDan2kzMNBm2F54VZn1awDP/UwI/0s6bDxKK8Bsl
djXY509LfGcc5phgl199m8rE7PUIaHQQHsEw1T+Z867vPES7pjL0OFnsG4NiiX5o
QecSeK7xp8BK6c3wAebX3VqMISPfj+R66lhspCtfsbJ1yeVX/nwh8V4OouZtTQJJ
WF1FS5izzOQO/QaajIE3gH0+ZPfkC9QoH8vEBBtL0mzEbljNq+E=
=P/2J
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
