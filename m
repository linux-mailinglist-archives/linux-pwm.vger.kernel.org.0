Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37EC2CBEF3
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 15:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgLBOCs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 09:02:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:55089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgLBOCs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Dec 2020 09:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606917621;
        bh=mkPrbK+yJuzfAhf/sO1iUgkIQXheUrt7++KNxongoyM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=O32K6VLkxNtdhWIzbLII3haODtWzmGPALzgvgG9EWa47XBK49a5QvVytI9xRaWmAw
         O7vlr7xahai/2MAWQXpevfuRpbbsAq0arW4vxkpVpjP/+FVnXOQqQbqicQ9ABvN93T
         wVY2GxYwgZArm4K7ZgCHP5Q2KyjmkJSYRRri2yWE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1kzJyZ0cuI-00Fyd1; Wed, 02
 Dec 2020 15:00:21 +0100
Date:   Wed, 2 Dec 2020 15:00:14 +0100
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <X8ed7stMOGhnZ18T@latitude>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-4-j.neuschaefer@gmx.net>
 <20201202130520.GL4801@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d33nqVJ+uUfH4DYP"
Content-Disposition: inline
In-Reply-To: <20201202130520.GL4801@dell>
X-Provags-ID: V03:K1:UpPvUQU7gK2MH8B05AwoyfhmqHQRzgHJFYfvGagPawWdg2hpRjX
 PBQ/nFild+nxLnXQVu78bet9XlT8AGxzvTRfGsdjMI28jB4b3opLJn/q4LE/Adpu1XHsdjH
 K89YJzYN96uuKFAsePp4LHacMPYzW1orC1lAyrHw2gIYT+65e+h4hmYWB2F7HVi5j864TBF
 2KN8K/ECir9vCid9Y7C3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NKoJD/ARNdY=:ZfjNf85eZFRrYVNC4Ne9nV
 TaG+UkHF466XjOkyqjjIkUNs6fquI9tE0VVnNJodWoasIvubrA6r4FtIzOk5AM+ZAcPJIkx6e
 gAnCCN6EtKRVTDcVQeSEpQ1t7ccNyrvIDykgoPPx1Os9mr0wanSHHePTUS2JtLtqKV9UG5aoy
 ZpC7vWI/yXumM/yFWsX3nntEeImwVK1b/NnzIVBi/vXdHAEgsDf0hpZWJWgCwvXyEeyfKCimA
 khssUUaTdHFK8ZtwaeF1NdLlcP2J8Jqygmrxbs3vqGNqGZur//u1prwMD6no5HPJYYSkf97sl
 +zwfApdwV7GSen9v0S3LuO3bdX8IaStCC9R2q34+gM1kp2BDRbGI1l3WzF6N3Pa5Hfk/nK+UG
 xz2Yx4PgfxfdnS0UrXs5iW0K/s8QHNarummmNHZWuIn1po/vYe5/24e6mg+wg8mAEiY5yrM0L
 yt2YWaomwXlwv0iBHQd+ihmkTD9gDEg9cEXD7up2bqAEmDbjyjMbb5grBRkf/GxP3IbZplj1/
 dW4Gw23nH9vAVVSAPkxmLhFTiUYO/C8tPVJR9lLQ/D2xEeH2rpOqgnlx4ZV4hz1tP3ITPyFEY
 Llt9FvTcaFkgZbWQ2R39Pu0xJynibpyxxY6PLuCsyd/5W6mUg2wI9yP0E53FLiAv9aSMdtLKm
 7VKMeEgUPSbvCEOrdohIaoqXhf3js3MpMfKSIlglvR7w78akaDZBhUrm+RZLkPKe9WGVz4Quz
 /ww8au5AwXi6N/QGICRBLxcX0+iizjnTli2hBVk94GCgkp5lYdGU2CjO+paHSFHxZ0ky6RNFp
 KTVt9tGow8ddJl1zW9h+nRP2jrvhH57r9o3K3GG++mnS3z/fcZ6+K5tfdM8NM6e+0if+LDUAH
 JyDmB7xlhHdV+wVscI+Q==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d33nqVJ+uUfH4DYP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 01:05:20PM +0000, Lee Jones wrote:
> On Sun, 22 Nov 2020, Jonathan Neusch=C3=A4fer wrote:
[...]
> > +	/* Bail out if we encounter an unknown firmware version */
> > +	switch (version) {
> > +	case 0xd726: /* found in Kobo Aura */
>=20
> No magic numbers.
>=20
> Please submit a subsequent patch to define this.

Will do.

But I don't think I'll be able to give it a more meaningful name than
NTXEC_VERSION_D726. I don't have a good overview of which versions
appear in which devices. "0xd726 found in Kobo Aura" only means that;
I don't know if it's the only version used in the Kobo Aura, and I don't
know if the Kobo Aura is the only device where it is used.


Thanks,
Jonathan Neusch=C3=A4fer

--d33nqVJ+uUfH4DYP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/HneQACgkQCDBEmo7z
X9tuSBAAqQPKxupxCAWq0KfRYS2QxQ7YnxsgIaSBtW7vVeY+rxYN4B2GFSoME5kb
SzwLz53agojMGPA71ArROS+dkWmS2fT9TIxMjEtgSrRcEDQ0hN6psPIbWGBaij92
HMi80iG/yDlNqVa7zklcuRkxLXtEroWwb0Lzr7jVyRcoJhETcuARefmQo4hsQ7gz
Kxnto0Ol4FRzJxgrKg1n2BJKAwEz5ntiaRCKfcferj44BNBch7smeUCtittku9eS
6Ij/6Ao7pZcU1Tupabj1yRhcP5KNcixvDCo79DlE5+9aDFkjOiXvJm8AKrSjES02
thOgBfGugqWu7/c/0flCEfQEKlH+BlHfzsZO7k+Zk2ehvDgy+clXO0jVGTT7joC8
uMaGhm1v0O78kDXnL1Dl4lbPljCIBOcKAWti2dXmvSsrXYY6Cfyd1ZnYIRK8iOwr
pE/G0pcwVD9XXLSwgN5Cqvr3wN5g5O/YO4fUqTPz6zRXzEUOYQrD+p0womDZzdaD
IWbGGwZbVQjr7trWsX3p8VR9YPXQnT+3U69O+1AetWnID8e/hhQ1rVe/4o+cqhen
rQLHB4VLFYU0hAO2FtnXc1/ew6xA7ejv58Nasq3swhgQKnRs4zqSZnYCQJaA7lU/
74vnuH3haXYM1K6QBYr78NOHXANOCnJBrS6GggnG5gS57SF/gsE=
=o2/u
-----END PGP SIGNATURE-----

--d33nqVJ+uUfH4DYP--
