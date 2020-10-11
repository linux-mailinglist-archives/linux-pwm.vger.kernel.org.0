Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07A128A9C4
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Oct 2020 21:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgJKTnn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Oct 2020 15:43:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:53013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgJKTnn (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 11 Oct 2020 15:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602445368;
        bh=IX/vFdROSTvDBI48dTw6a2ZRF/rMQ74xIWcc6kNdH84=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jwIrdzfiYQduz/+zIF36bBdfI9cCW6/SDJvsOTevfNlcODKCr6bH+OF55ZhYbTbfF
         U9CuDeXAfiNkgLSB1NHu0KiDGTVS9fiQSr2bbTrWw3cOSNUdFSUqnCNqOZ06/EPES8
         VRlvlVbp0GyNyENfGLYj/Ub3iGiLXu1m99ly/JLM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2E1M-1kLhGo1TQs-013hnb; Sun, 11
 Oct 2020 21:42:48 +0200
Date:   Sun, 11 Oct 2020 21:42:41 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
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
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 7/7] ARM: dts: imx50-kobo-aura: Add Netronix embedded
 controller
Message-ID: <20201011194241.GF500800@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200925050818.2512375-1-j.neuschaefer@gmx.net>
 <CAJKOXPfRh4vyJ21ACM3Bf5+HtWZUy+anV47VBAmtitfLuAeUjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <CAJKOXPfRh4vyJ21ACM3Bf5+HtWZUy+anV47VBAmtitfLuAeUjw@mail.gmail.com>
X-Provags-ID: V03:K1:8uBU2XblVeoVLjVuw2nVyWSoG0MatCsL9xXa3s67RioQG8LCerN
 G3cjXgjI+c1IhPfhQ8nbCAA73xeV6UWuEfUyjrLv1//EoUQM4TDRW2AUNizmtmmGrXrp+3z
 cpe9fVbO/Bwf4uavG9/19ZWLcXGumfOwy4hoylcUqO24X3zJ+EuvY8E0+EqpHzwyb97TJq8
 /BteoTMlknqPattvPSwSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rFhHjenenQY=:EJonwYSKnq432w+kmFsFQB
 no+f5JW1J1g7pNm9e1/fEFed0KoR4We1yM/PtyNR9LER88IDPs1waOBV72exdh3O3QWLz5WA4
 TeqeyiTm11xHCV9wg/UR8glOlcQuK4KaSUFOoNa7h6dmcygXUW4FTTHhODjc+hj05q9YRC8UL
 gvpOI0KZrt17WGx1ewTPR1HlrdD4DrmdVOeFvyVZ6o3OnLiInE961Yvn3tLyXs9GzbDg3+YEs
 zl1wqVK3ykjUkVM7iCK9L1mX7BfB/MCACwD4bB7uDcOzuIEMPySYfWznXVexHaVwscHZW0hXB
 HN94LELS/gO6+fmDiAjvopGq03+nBnqQhX6LENTIbX4Lg/zrfLse/9Mu6rwDMZ6Fr63Gy5WKb
 bxbQ1Pg1shar/gAGgUPwXRhJYJ+/JZaQXpJc8TdAsFjI573kEZ7WtwCmMyUXsZssfv90cY+3Z
 C6Gbt6i1DK9+SeQ6ClyItMo1JoIVXQ/AFxGNcN7Bh6kxc56/1VPe8NjYubyFMkxOJZguhILgm
 2qMErhdEZGvfhD+bI3BsRqOBEvxmi48jLYlZB76nR/KNYOMVgSqr6Ci8ID/3S9B/NWc6/iggn
 5CMR6my+bHQU9MOgblHVbA/7SrG93ZROPQ04utyC9suNO1HWDJPwJjYZ8AXwnHcoET8TAKzAI
 8gO/qWFdoUD/fwkuw/o6VR0Mfc9oYJufaYZxRlUCI/g4LkVOlIIO1KNeLSE2/RU7tAcxEkXIc
 B4gi3DXhNfo0ZGvFhme2FDEBDZeFu1RgATzgv3klUTgSM3hbfTkYz0rjtn1i74SKTx+mle+j+
 m3AIRlIkubTsUBg1e+ngHd0gFB8NTWCcTpfUnI2dpqodUTrGJcggeTS4ti7jXXCN+MUa5jF2z
 pp/Aynm3ISF0hAnNdn46KTpf/tlIte4RhapZhny/fqOiKdpeCfkvNQ4golrW8MkcSdAR2oQNy
 0/URJKZ62Nw2L7gQYuQIsqr/otHlc/aPjUBmU+4+b5SM3EZ30mWQqAont2J5X/UkoLpL9t8/K
 OaEZfFKAMeXrmFpDt0A5qtnfwa80Jw46Pi43nKubLvPW7Vr3CX9xTg3FFFEgo0vKCuXwc/qYy
 l5i1st5do1o+vJ8C9tVGkuIW7JIy4rXApkLzfwYsj92GP2u7fhJPPgHQfWsARVffJadA3PbMe
 q8W/4tpQBBT4J6cDcty27GWb7hsXOiP8afK778gbl4gYVkoe2NthwlUfL9vRQnwC/Y8Mjrqie
 IAz1hrGaKEVm1VANWaIgWH+3KOdnJXMbRcS9CRA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 07, 2020 at 09:46:30AM +0200, Krzysztof Kozlowski wrote:
> On Fri, 25 Sep 2020 at 07:10, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx=
=2Enet> wrote:
> >
> > Enable the Netronix EC on the Kobo Aura ebook reader.
=2E..
> >  &iomuxc {
> > +       pinctrl_ec: ec {
>=20
> This should fail on dtschema check - pinctrl groups should end with "grp".

I missed that requirement. I think it's only stated in the i.MX pinctrl
bindings that have been converted to YAML.

I'll fix the names.


Thanks,
Jonathan Neusch=C3=A4fer

--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl+DYCAACgkQCDBEmo7z
X9s8/A//ZXamPTUzHqAqGfLG3IETakiVj/jzL/ROS+aDhNMh5Ulg+6ijWGAml02V
EuG5G4x6ShKbe2XcBxTsJsE5DUs18gxGbJ0B/nzElExtyN3Lr1Nw7Byz/jYlzMJC
UbwwO9MBJ/kRGlQxqucJxpluLDWPZ7wB9TMvypRM6hEA/3KV3zpvIL1R5klDJRIm
JaY0DWXSeX1AHS+DEwHdexK8pytJoYoQEHOIuOeaaOrZGIBEmGk7+2CKUlQmQMTv
TOtOMx3NQ1cfey5akMKUrV3sdio0dd60zL+YLMVQrr6zljS4eqHD2duECqqG3LN8
cd/xin+qFJbyKJEwa3SAiI54VLBXM3Oj1ONQODwzg8tyZg0YoX2o4c9C0UJy1V+0
FauiU7eQfEvYlcwpalIe8GoM4kdcJXQMaJIeMrD2MDXyXixj5HWQm/4/7L1FEfjf
yxqcgAT4Lf7aJwu+ng1flsnarNEoctZNgfkc01HyZ8rNtKPH2VEJGhptVOhf3kT3
ggJT0aSBSL3wYV0wi56OxmyISgS2c7inbZaMNxNtFEFkJnYy2nCxsuAYyx4Eu1Lz
ZBOFWEdqr0opv1rrd/w+WTdyt1L0R2gcdTpb5cVJyzv3FZ/feaWSDennXjl967e2
zyuCm0sVbC+oE9C33iGmnVSO5fiXLAXe1xw2VNoM73vjdrUw8Y8=
=bucB
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
