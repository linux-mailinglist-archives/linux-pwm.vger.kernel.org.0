Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83152F6E45
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 23:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbhANWeD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 17:34:03 -0500
Received: from mout.gmx.net ([212.227.17.21]:49037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbhANWeD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 14 Jan 2021 17:34:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610663503;
        bh=/PW0bQDf3ENMIRfvCNeNzBCuWtMlwg2PEDP2yhFy+tg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hi5t2o4KYhobW4KmG6dacTTgWlpORIaLpm/lQd5UB+dKQNgCwfqlFjw/NN/aduFg/
         zzO2oQO4ck8iE7mQaifDTOBFm5HC8sy6DiFchOlljFz25OVR+3tPkJTouYBM+ltw0G
         QvJGkIZNhRs3wGL9/NjV1UxTG2PXhuqm8ohE6PQk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.208]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1lOKmN0VWS-00OK6E; Thu, 14
 Jan 2021 23:31:43 +0100
Date:   Thu, 14 Jan 2021 23:31:33 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 4/7] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <YADGRft4AWwnkA33@latitude>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
 <20210109180220.121511-5-j.neuschaefer@gmx.net>
 <20210112203902.4e196d11@aktux>
 <20210113234645.52fcf73c@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HDuVcb6jseGv59n6"
Content-Disposition: inline
In-Reply-To: <20210113234645.52fcf73c@aktux>
X-Provags-ID: V03:K1:9XjKrmV/1AFahXgaUITwWleebD3JkCgxOwFo/LhmBY4OVONqQHZ
 uYT0J0ulcHTVOriPK3GY+jx3rfu5Nnh6lFe25hEFFdWEckiuKw6+E/YS9TVmIgn5M28oAGh
 OLGogc34a6xE+z+sT+NoXc+hNKQ9ql8Pjn2yWb0whClV0pnDVKMgjbMWYjE47XGS9Pz4t+W
 9d4bbCnzd2tcuQuLMFv4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6pzA9SSkmQ4=:t+i4DMIeD6qT3XcNUBW3ep
 zSDPfettqbJ7gQhSVyQcrGZAnuC+KhC6Woi+AxD+wWuhrNQYP/38tez84+5GCvhCjmE+iBzhs
 8uTBrUTkHJNTsIuYdQPpWzMiAhy9yWVY+Dscb9FidwfyxYKhshrmeDm3e64Vf8ZFD4paF6N4z
 C7lwmNugP8PsuX9Z0p5IYvGFyFPJRlt9hEvdwel64m9RxIhaDq82whqyCECJZKR5M1jh7UP1f
 CM3sluTYtDYUUPFsId9IBXR+yHZwQDvDZt5hkI6p1Q2h3blD7Iua0U9eTk0JzJJKUCDbpCxVc
 b6larzuZqYZf2hHvl6iMNCuvwO1K+yLvqYlfhuV7I78An8AIT1/Z23/bFq/xNjhDiWXZHQ0eA
 SiYMyFlWEBm08aX834kNbA6U7IEpJqmAZDI0PxmMeJKXUSimropjGW0TqSVpTHEyYjCK2Gdsm
 xb13XhOD6a9OND7/o119kRJM6avj0ihDnosVq0HQD0FkfM2hWNpExwqRUsEqEKCUtkr4A1u8/
 Y1ZWLoDQo9fnu4+ulWJbRcjxMOEVjtE/Z8oUZK8vtoXFNbyLpoaHQOVkPG+G9tirkY1NAW5fV
 8x+VLTr4iisdPFj8ienYe+WixOyxMIYIdeZDRxgbgidy/xnP527r36g5nt/be30QlqceQp4Fo
 Yy125H172Wv4hi8q+aWyo6AOjVRw6ANBThY0bcMpLImEx95S3w3wBufTFE+IXbOVbt9EsbN7E
 UfMD6epBmjiEgFL8tw+JAVKlU5vt+tiy+n0h9Gtj48D3Bclu7xI/rZTOdx/HPZdEXjpRuX93r
 ss6WdCyKWHwEws9nnp9NQAJTX4AsSBGqS8FLvkqcW5znevIi9qZRTPBJobkI775A6azTu2Qb6
 5GTGQ12YsLXiFS+u6D6g==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--HDuVcb6jseGv59n6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 13, 2021 at 11:46:45PM +0100, Andreas Kemnade wrote:
> On Tue, 12 Jan 2021 20:39:02 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
>=20
> [...]
> > > +static int ntxec_pwm_probe(struct platform_device *pdev)
[...]
> > Hmm, I needed
> > chip->dev =3D &pdev->dev.parent to use the backlight example
> > in patch 2/7.
> > Not sure what the correct solution is. Maybe the pwm deserves its own
> > devicetree node.
> >=20
> probably just assigning the node from the parent.
>=20
>    pdev->dev.of_node =3D pdev->dev.parent->of_node;

Ah, good catch, thanks. This works, I'll add it to the next version.


Jonathan

--HDuVcb6jseGv59n6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmAAxj0ACgkQCDBEmo7z
X9tuAQ/+I/fgq/4KiZ/hxst2Kdd7r5iiqyVHUXajGHBX1h6S/divbTF05YEipq5z
5PSrq+RBEc6dBbNk7F5GTzE05MtmMAFk7l5fB+pA3U0zF6C8+CfAyoA47UdCFuPp
LtHhKT1GKs1DcfK9E/k05UJMscXCEj5+gDhDf3a5yQ4our++LEcwepUBHf3Tb3Yo
QI7e0wRMTYDkmo/98Krrmei96oWav/Zu0HBy6U9WlEWdKz7mNF7CbrWNMdLoj56i
NaOaJgRUGIAEd6v2PDmG1zLUOnyRPd9yFVGP/acj1t9bwQx2soxB0gdV03/n81rI
/0A+xXvMNwPfK43G7s7pkVmqr6/9U4F9EIW43hX3HNDPfm+WRPBbxeddhsT9RAtM
MJuluSgEaSRT5vSfK74ZUnpbEGvrfAxPqkuG5Z5ssS2DC57R5njD+fNbfimovzXz
IOJjax1NzXMQ9DM5hb6JQQfR/Q0TumCmTw+gGAYWa39ywv/du2aiAmg/5ZgCILjG
zZL3L85WiGJT3roV2FoFUDwLuAm8bwfGR7l2c/gwO8/qWqXbNjnibVEUJTZ5OOEP
ha7AKdyDYsEiRbcS79xKeU2GBNheMmKZDif66X/0DYbU7aSyGjE/c5z1EZFQr7Ao
WAOgoHbr1BE599wWNAbrHKCm9QN9dPZJDYKQc+WJw7EZuwMQ5Gc=
=Fe0t
-----END PGP SIGNATURE-----

--HDuVcb6jseGv59n6--
