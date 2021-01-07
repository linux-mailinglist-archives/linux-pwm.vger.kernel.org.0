Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF292ED142
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Jan 2021 15:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbhAGOBO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 7 Jan 2021 09:01:14 -0500
Received: from mout.gmx.net ([212.227.17.20]:33799 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGOBN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 7 Jan 2021 09:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610027932;
        bh=6KXvHFS8hjQxWet0mQrTitxB9mKD6lKq0Lt0NXoM9Lg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Fv1GeYCQhSu8Gk+NvxEmHyo5N62BNUEHSJep6q0+8P9KpA+Frw6CjTmRriCsRaYKG
         o+zyJWyY+ncxGuVHI8XOJD4/Cd1b+5wrxMvKLEOXGweFQY3FwUoWmDLH3mnM78Xawd
         sC7Y5OLx1i1SrvVDtFpVJoFv+ZQQ1XnamtUjsT58=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1kSngS11lI-00UoHB; Thu, 07
 Jan 2021 14:58:52 +0100
Date:   Thu, 7 Jan 2021 14:58:47 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
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
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <X/cTlwKdCfxACNNu@latitude>
References: <20201208011000.3060239-1-j.neuschaefer@gmx.net>
 <20201208011000.3060239-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zzyZ2qKAXKy5e0zx"
Content-Disposition: inline
In-Reply-To: <20201208011000.3060239-6-j.neuschaefer@gmx.net>
X-Provags-ID: V03:K1:UzPsK+dffc9afKCvS0F9+Hgj9JGWVZOPCSnrUgq9ozQMGwBrOn1
 WpvWYWzAMBorKL9zzEgCb5IoWtqOzmQarM8aXJl7ONkaYKxJnxMGaINMLTqfkztZZFjHHGf
 G7uj1LzDxwKbVNXSqsL+vEXoiOHffRuz/jW/ittEr9b/gxsSoXJu6L4O4wDd9Es0lbplasv
 SPVjkESPUz2ZJA32ai6sw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HiAjBn2kIT8=:6XgsBIHMs1aXbi3nmJSBWb
 9xhs9idVrnn/CDpuIA3t3IJB7A6hI9b1k1+w7e7IgZ3IPaWkYUgLkNk7/FGd1wKb6rXNoUJvr
 Q0uM4nJvsIatHSI4tRYZ3aNSa98nmEOx5PbLnF4CBF7QkmnyrVmbZGv38hoIulGNxkjZZVzWr
 /ZJIROMNcIjuvgxzmf0lUZxV58yab5WxKk3KbHH+qOM0dcWl3g2Es+2pHxonVeIztW1IJggAs
 hKiy3fwGh5Gfjh99jS9T1NE5HYXoMxE38q5Z/pcmGlOxXJ+7s2VGfx8JUHCUoW8KboanGytFr
 Q01dumxcWnDU+6Eu44Z1VhDervoMa+C8SiuqK49SIygHB1NwEJ0NeAAnigUS/8L2UhjZoRn4B
 GBhkeonIkjPT7MylGqmSesS7Hat6FXEgDtG8kgTHTL7C/uMwiBBCKm6qztkgW96St7xhz6w/k
 WQvfk0b7WRu1cE3Pt+rfmk6JWfkmkUt5Gt4+1csKqPBIl4Bfo4yD/dqVS7qdtAD2x7qrCL1Xl
 0oNNohAVxByzz/KuOmQ5RuCkpyp8MPXjywj6DwkNdtHGagUnCKtstpNUTqLxdiZlq/WAwC6n8
 hHQd/9inTiQjwC3xYB88qELKlcBZkIWMQS975cE2kIRh3vrAmoBLKAiBGf2DZY6Ad+1MwcwiT
 SXmiRQWIMIb8pZZ1WlxO7Vg/9531gNIeb8oQrViBcT0tRFkIXXsY7tVD/cEw2W48H+GszD9yn
 1RCINyUfKOGVBdPAtnb7BrqY8cAMK0MC7WBU55+/+gEWFqO3FOA/Xdo+aLmMLUP3R8E/HMUc9
 U9WCczp85cJoOpVlZaAB7spZov6fHXft9mG1XEmRMboap7W5Mnu2cr6tU85YHxAHqwgqv8xYO
 uGMHsrt7/CerOCOlkd/w==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zzyZ2qKAXKy5e0zx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 08, 2020 at 02:09:58AM +0100, Jonathan Neusch=C3=A4fer wrote:
> With this driver, mainline Linux can keep its time and date in sync with
> the vendor kernel.
>=20
> Advanced functionality like alarm and automatic power-on is not yet
> supported.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
[...]
> +	return rtc_register_device(dev);

This needs a respin due to the RTC API change (devm_ prefixed was added).
Unless someone objects, I'll respin the whole series in a few days.


Best regards,
Jonathan Neusch=C3=A4fer

--zzyZ2qKAXKy5e0zx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/3E4oACgkQCDBEmo7z
X9vCCxAAnyHyLRWimfwTpump145Yv/rZQxqVkc0KK1+bi2EhJddi3IC/n3VWoog0
XgXDYKkxINCn/uUb3JSOJ41GTVEcOdgXhNh5Sz1J8Xu4Xavr2qvWHhuh5Uobo6A9
Ursp17xJxIedZnSZeYJZhLI1+uDASZoEp55FSZpdr/dBE/duI62r7A7xKC7NGuQ5
FfVuGlSvsJpgEZqVo1mw3A0R2uOhHu20t8zZmXVnirXHs7PoZuIirnPys2Q2YvPX
j71Xy27WvGJGXfKa8GhN3FRzqcYTQ8D5dWqvCyb9RYuYDFFjQmFC9aDRellR6oKV
QZQqS6mDzwa6CsQ7WTQtzNE/oDSEaB1JRrhsyfUDdHDnMg6DRVyzNELjMsq0fzbQ
b4SNv82HjK1OSTNk7nYWEFr8zFh8dHYaydXqw9ok5iAxpjol9FJDeiz3ee/jMr2+
LlwUGHdptjSh6XubB1jlBCJITWKsoZKKQz8MMzGt5vgJBLQ7g8FoUXfIfJ1SyDuh
QgsrxpPgdDTRxVFG1V5V6YliJNzm7BEUffrtBeFCgCVQCq8RAzzyMXZ4UlEoazqK
22LrEAkfadOWJFbwGTcTvgbvpCmFSJr6e7E61dP/WLhh5RGcB8EndK85rFskaOqX
KUAYnvYDbth0rRZcdy0L+QF2Awe0FRnXCCSQ+Qe7FBzsWQRX32Q=
=v+1m
-----END PGP SIGNATURE-----

--zzyZ2qKAXKy5e0zx--
