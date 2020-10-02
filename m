Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B8281EAE
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Oct 2020 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJBWzP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 18:55:15 -0400
Received: from mout.gmx.net ([212.227.17.21]:38939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWzP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Oct 2020 18:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601679255;
        bh=ifmQtRuT3dg6xtz/3ou+lH+WAmOOUez1iX/REx8JnI0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=TWl5+Tnb6LW1l+v0w1mHFCjvwE1VhQiYviUzbZgOpskNa3W4wFZlHbfbNGlDi84qI
         WuxRTKOXFnal4yUlvlJ2uA1qlj5D7KIlW9v3bclP6qPcZ3clm554t9yf/icJNfgkSf
         JkQ0AzsOJPmGhuBrPQMe9zAL6XHk6MWNqtXoMt+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybGX-1kcRLv2znR-00z0WA; Sat, 03
 Oct 2020 00:54:14 +0200
Date:   Sat, 3 Oct 2020 00:54:08 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        devicetree <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v3 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20201002225408.GA500800@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-4-j.neuschaefer@gmx.net>
 <CAHp75VdUHPsuvDPLnfP9sM2p1FDiCsjkCf1SSM-y02ZsQxSDWQ@mail.gmail.com>
 <20200925213207.GA2510@latitude>
 <CAHp75VchfQ-djkK6u+fLjq6kfqpzb0nqSLJOe76cb5S3J_F9GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <CAHp75VchfQ-djkK6u+fLjq6kfqpzb0nqSLJOe76cb5S3J_F9GQ@mail.gmail.com>
X-Provags-ID: V03:K1:UrsUGltGIkJV85rtkpSSHNGZVa7KQScWf3gXtGHd+DtPWbCV7xL
 TV7J9pw2yhOV/5n9PO1RRNXvDO5RCJgYGCKVpnWL2/lbWJxRuFhhnRGvcu6DxlMyiIeVFjU
 rdohUZnQT1AQA9gqw3uOGPgUn8KPYRsfLjbwdtw6CGGDkdYFy+vy1Qx03rpiZdQ5x0Wlyfe
 LHzNGpsijNJRotmPwaVcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:M1EZiit1jLw=:pCdHzy8gSeY/pMntYMC+cL
 G05AVuGFzvoyXZ0ffU1uz9R53SOiFhWNKimeyP/m375sDSGkM8ovOpO2oPqCfnnb84Y+WQRGj
 ZRMkm9HQMO6qt2dsYq6CZYd2k+2PDM6D/d93dxULRkX6+7ol2d7f0Dh859ds87FR+omotuS2s
 6ClKvV4QbHkzQqZGNqUp4YHpbzI9IyfChqYx7gilHOQ21wMMyzgXn/nohob/d5Jce2CtXcBCY
 LLafngGp4Hm34Z3mznuanHWI3zUVdEg2fq4+NkEP7/4BPIpj5BNr3ejOSZlce6VEwRPJr8hH0
 fDI+j3EwOBOSKHY3iO2xaHl9uQ7A8jUjqSMU4p2dgr68sqdpOYqahxrkHXZYgAKGUF44GyScO
 +lKiY8ukubdUftM5VJLaL70LLDQuhPLzW1T9ibdvll70W+dD5tQTj1d2Z8E7GFeQwcNFUN2+H
 R4/UtvlA0TXPAZRWOH73TCf6i9u2bVvUklY2PQKVqzePGOoUwN9/jExRpkoAWY5CE1/cPq1g5
 ros+4k2HbJqzrRHS9zrNKSm8yEh9uWFYsEG/aYRp68g2uFUKurIycXJz6K+6gB08B05lAXFaj
 hr27u0bvQzcIBo73OqDoGvAo0WOvdGyl+Ysm6cIzFFrUWCQAmCUUSjGc7lsfOHJpu1Bf03ft6
 N1YKjFe6Xmu6UbJa1x1klgzW1Qw1RgsIpRUvYK7Mhu9Tx61ogbzFarjcL2wkwj4D9VPs5ZTim
 OTro+TKmojff+PaeBoZ2PBT6jDYxsoV/yJtVGSv/qv27Nh6AixRQK6wMH3tQ6HFKTLwqblF78
 7yowgD2/rxZ1eaN53dVQQRqJcqkScXvsxNPUr982W0XC4BobrbnTKKckZ4UE6ico2g/YATMIh
 jFrJaT03etyq6dOHjXbjodbl9uMw65ajQBIsObQqpl9iN7sWoKbRJ3ZAIgRjm5Ucdec7JK4FM
 osFiKGjsGKEWD0KzPCPSNQlLCAxKqFAbrnapKLdZRzbYrev63GCKHXkKY89CG4zaK8GHgPurm
 XgafGeD5vszcUC38uS26rLOYKyYNeK99hSym1S4EMgjPdzY9rO5wI7Ip6ET5lOJPCBJnEFMgy
 s2qsbbG8/QDy5cXSKrM2zgeHRnY4YGMBdiFejdD24naAbi8RobAovjY8j5AjBeW7UJQjPEafs
 UnFHfXSDnHScZPoSXwG6uHlSgHxSNRO0WOzOOQJhUYEwZisRtGzOv4FLAuxPRQTSmYM6idoVJ
 6oLZJN5Cq0VWa6VkJoYSpDN0c2ws2uEjuKnfzbQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2020 at 07:37:21PM +0300, Andy Shevchenko wrote:
> On Sat, Sep 26, 2020 at 12:32 AM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> > On Fri, Sep 25, 2020 at 12:29:45PM +0300, Andy Shevchenko wrote:
> > > On Thu, Sep 24, 2020 at 10:26 PM Jonathan Neusch=C3=A4fer
> > > <j.neuschaefer@gmx.net> wrote:
>=20
> ...
>=20
> > > > +               dev_alert(&poweroff_restart_client->dev,
> > > > +                         "Failed to power off (err =3D %d)\n", res=
);
> > >
> > > alert? This needs to be explained.
> >
> > I copied the dev_alert from drivers/mfd/rn5t618.c.
> >
> > Upon reconsideration, I'm not sure what the correct log level would be,
> > but _warn seems enough, or maybe _err is better
>=20
> It's up to you to decide, but crit/alert and similar has to be
> justified (commit message / comment in the code).

Alright, thanks for explaining.

> > > > +       /*
> > > > +        * NOTE: The lower half of the reset value is not sent, bec=
ause sending
> > > > +        * it causes an error
> > >
> > > Why? Any root cause? Perhaps you need to send 0xffff ?
> >
> > Unknown, because I don't have the EC firmware for analysis. The vendor
> > kernel sends 0xff00 and gets an error.
> >
> > Sending 0xffff doesn't help.
>=20
> Maybe a slightly elaborated comment that it's copied from the vendor
> kernel (which is?).

Good idea, I'll do that.

> ...
>=20
> > > > +       dev_info(ec->dev,
> > > > +                "Netronix embedded controller version %04x detecte=
d.\n",
> > > > +                version);
> > >
> > > This info level may confuse users if followed by an error path.
> >
> > Right. I suppose printing incompatible versions is still useful, so how
> > about something like the following?
> >
> >
> >        /* Bail out if we encounter an unknown firmware version */
> >        switch (version) {
> >        case 0xd726: /* found in Kobo Aura */
> >                dev_info(ec->dev,
> >                         "Netronix embedded controller version %04x dete=
cted.\n",
> >                         version);
> >                break;
> >        default:
> >                dev_err(ec->dev,
> >                         "Netronix embedded controller version %04x is n=
ot supported.\n",
> >                         version);
> >                return -ENODEV;
> >        }
>=20
> This is better.
>=20
> ...
>=20
> > > > +               WARN_ON(poweroff_restart_client);
> > >
> > > WARN_ON? All these alerts, WARNs, BUGs must be explained. Screaming to
> > > the user is not good if it wasn't justified.
> >
> > poweroff_restart_client being already set is not a situation that should
> > happen (and would indicate a bug in this driver, AFAICT), but I guess
> > the log message could be better in that case...
>=20
> As per above.

Okay, I'll rework the dev_alert/WARN_ON parts.



Thanks,
Jonathan Neusch=C3=A4fer

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl93r30ACgkQCDBEmo7z
X9sFyA/+PxkayxMmWS6aZriR35iArW9FwzoI/FTynPwp7rIU9mEWM5LrusnWLV/k
rgbasDHs6h2NLH7T7uDsc8ry8+rZ1TLSFvmfehJPCmKCnHBn6ffQqe9E1qXI5gQS
Ua/o/7rEZDyAsMcTpm4yW1ffjE00H1dmevY9dQVKkr01SHo/ImtJKyxaCa/QpMKA
4/UXEoHnKcGVd3CFEouiQG14KgWpzcodrqQLbfUNJfYLObMKs2ecZ1aYvjgCd0yR
lYL/JeMhKNXyA4mj/Tx6AdOqfDs7dr3jpEsRXNWzeqJ8bMi2N9BLUJcHvefwP00V
dxMqZF0sSTvXbthNs+Plr961rvzQYlI7HvfPPrWclBYvHNafaEZ//NIywX4drKUR
Kp6Xi8kFR3wpCYwnbxt7bWmDz1npI5ZrDfDHwID8lZQcCqcTZqKGzRqbMJNjL56H
n/CouOLei3LnY72vJaXTwzAT85/EBEOdx+VgKf3KLtEhMrXM3vtx7pYaAoOFDJ8a
CLBv67rmInGfjdCNusox9yqs/NPpV0kBOxSqJaiCeIHNLLqEi1DgQx/J4PeKAF3K
FqvtK7+XLx8lzhEykppPNWV57hzNJwZ6c2Vv/ucViTGlr19qvbd25YF4mEKMuAbp
ZxhVx7DwbHFIoBpiqQ33+lX1FucFmZUrYwWezVTciwWbEf9YzVE=
=1H3t
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
