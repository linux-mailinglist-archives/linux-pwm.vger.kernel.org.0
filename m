Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304FF20BD61
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jun 2020 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgF0AIz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Jun 2020 20:08:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:50603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgF0AIz (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 26 Jun 2020 20:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593216484;
        bh=4otcmsUcuNIHrWB18fGLT23iJsc5+XpSSQ0JeZZP6Zg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HTaDkR4TLueDwQwa+k8Nk8k2q0pKnY4Ma1CAZEE4qmOb/zK1GqpD4bD9XyaLRiBct
         ZyGQ2mM84Qge+E5mhQrGU//SK2gpdIp/BuedMicYSqbSkEI3T6wnxTNHWr0IAlJizT
         YapRz4BwOu/GQNecTMjc2C/RGQI3470aMre54r8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1jZuLV2EH3-00K8kO; Sat, 27
 Jun 2020 02:08:04 +0200
Date:   Sat, 27 Jun 2020 02:07:57 +0200
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
Subject: Re: [RFC PATCH 01/10] DT bindings in plain text format
Message-ID: <20200627000757.GA2699@latitude>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200620223915.1311485-2-j.neuschaefer@gmx.net>
 <20200622103243.GT954398@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200622103243.GT954398@dell>
X-Provags-ID: V03:K1:eMxhCUYGNR4xIz4Sxup0XWxxmE2BA6MUjV6y9nWg0dsf9ecoPNS
 lxhlxzKJ91a38+Xstg0rmg0QvGMBTMUXw7+mODQZa5hsY7rXVAnTegVmqFI+h+0KRtOjzDK
 RdXYKyjLsp2kNP5li/2ImKjJfU3KC38/6bL6iF1vJ3brlZjGrkDn+R/s3onxLSykyGlvCXQ
 PvLh7ovJrIPGhWLzr12Zw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yTY0aGX6+xA=:n1YGoNm1wZM8bRWdZQ5KWN
 2vmVtaa84gmspzZFGB6cgGfbHXkhUNaOwk49+bz1FSFH0O32RzLEEdFui+wxIW+L7mkxAtUyv
 stazEJyrBs5tBZ5HaPnZ0JvKs6GDDl7gDjglrRJXYBm/TxkSGsLJd/ycvDwek/Q1eN9NbA5YR
 7HsgO52xG3Wo44jiTR4T2wjiPlwNNgpC1ibiSakBCTdCrip2V41okqzfib9BajOx8hR/XsAnh
 O+2bFYWTmThzt1MFHSEbB/a1B+rBO7g7EF6tLMMxoAVpe4VVDzDfQKKOeKRzi+i4YCrHuJltD
 POAVNOVlJE1oWwEanBJacXd5DmHOe+oK5VzqfMYne9fBEI7auOe6J8B0Og6hlcn/GHX3UKUaG
 W1XAKN7JX/otVDpnxzv2WhgCFI09zlu7RNlPT0VgrJa35Hg6DSgF9Lp176YPixBEy32205WQx
 9HKpJ8ZBEz0/6K8/A+Xi3R24PXkLKtxT+LPyhmU1plVmdnnJPlynCCBQUJBLG/8RLk+0CCOCz
 qz9uYqqS7iLs1NR7djVDjR7TLTa3PvnheSsPZT1v3dcUGJFY081UzWHGgT6uM6d+rLKXKvKTX
 3vkiwfs87Zpxu7t2K+ChPapBrG+8oCxPtFKODAaNTNW50RYQU5lrjWoTLplLJMvWSZwuGnz2E
 Cl+s99vWylMu7bJOVreGeVZRXgKiAUXM8pTdUhYJWQoDdVgSSnl2x34jYqdSw7XGc4eSgMqYq
 OqLOnfPqgZcksh64OEU9sk18lRdhd9UAvqYjjZavW4wxkGLq7kLQ4fg74EvIqhZQV+FuMCVT3
 3UG6otqEnhOk3R0sXsqjbMJtVzGuw+msuLfixtoiiXyyZw8Wyz0ZNx2Gozh0c7+EoTiIAtlFg
 XS/y4CD/6HI5MkmjLSaN6ElotLylvrAmIQlQn/hHjNj42nQOp4DFw2UGIC+W7BxxT9nICBBso
 h9Kp+bikfQ2XILGPiRUUEnrL4+qBavuspMeTtBrCDkIr80QxqghF/ldNbnDTLDhPUfxg7F9mM
 Bsdmi5UGKQR2QCTtKxh36M4n6E8F3xUS+6IbQRph4Xe2DVpXJcoje3YnZWg0jbu7rfDspp4B4
 CYhmP6wN+GfhP4lThpzR2Ld6dESwNzKmMz0es6Z5yS9p0h4mC463elpnYg37G4Typv85Zr0CA
 NkTt9Bmmx2ThMbLqeAFkCWHx3utn01TSkShVZYWstL7lY3RUpxGvO5b+3aB76dNnBG8cMtHJA
 VLEmYDbiP22ZpOXaU
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 11:32:43AM +0100, Lee Jones wrote:
> On Sun, 21 Jun 2020, Jonathan Neusch=C3=A4fer wrote:
>=20
> > For reference, here are the devicetree bindings in plaintext format.
> > (Not for merge.)
>=20
> This would be better placed inside the relevant patch(es), rather than
> in a separate non-mergeable extra/superfluous patch.

Ok, I'll put it in the patch descriptions (as long as the plaintext DT
bindings are relevant for review).

Thanks,
Jonathan Neusch=C3=A4fer


> >  .../bindings/mfd/netronix,ntxec.txt           | 58 +++++++++++++++++++
> >  .../bindings/pwm/netronix,ntxec-pwm.txt       | 27 +++++++++
> >  .../bindings/rtc/netronix,ntxec-rtc.txt       | 17 ++++++

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl72jdUACgkQCDBEmo7z
X9sVSQ//dO2mmSQ8irQcGq+ghniFyM5T/oE/AuJByz+DeR8rIh6vaaPtz9ECq8If
BKOOwgL5IBJE2dUEYXjVwFy+jvW7dMUvPkOm7WOuzjGj1Rs3I4QvzcyhrPyeKinE
CAi8mxQsggvq0ntaevbtvbgOBU/FQVmv58DKpkUOW0JIMpplDyne2tSUCSYjjZro
czdeMhbA6Sd2UzK/2tuxgmF6n05KqgObgVQKUG7tiToAj9IuoS8OPn62MD9xm8Vv
M4EO57heoLmtUDQl08ObZJ0esnsC5RyjcZgNruEKXta8f6BSik25/Z7w9aZcVybm
8QqcX13GsM5DYJpmNZ6I/56BuxderNnrBsuLjaqnmBbXUgCugl6PYEAPPZ0MJKBK
GFFimgrzG/H8p3Cy/Vp6yY5d9+Yb0DGhpl+XQnZRzwabKV18LwCmlgeb/m0fm/aB
G09odAz3tZbMdeaU7aBRVIHctK/CAQb1O6LH/7IKLQNT0Lus+55amD4Fm6+gx+O4
g0U74dcxrm3dAGD+bp3IVjPV09ZoNm0l+1Vl+83Qq6P0NE+y0lXnoRAUM5xSHaye
srcAe6UJglI4qqu22unvkzv+uhMcZ0AqY65wGBA+LKazcCmZ6UnpwhcWdWrI5pva
PWf8gqk3BXCySDeN+fVpPDidwrYr/r9DI4MGxZf/dnWJStmbgl4=
=h4Re
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
