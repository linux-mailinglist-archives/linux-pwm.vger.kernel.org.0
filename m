Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E686B20EF1D
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 09:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgF3HQg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jun 2020 03:16:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:50185 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730638AbgF3HQd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 30 Jun 2020 03:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593501329;
        bh=DMx+oQpNcXunG3rnxv/9UJLjUv+PeETp9dEOfqk1CC0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=darJd5wZTWZIBy2/iRBMnjyoQJa5Lmpxme/6fnlyBAyVDJPsoTc+2Z2vrNGx9EX67
         ovWQmZA3GBoMMdzCpCCrVtNXzoNJn9okgsG+yXFRiBMjnRicqW6t5dcs75gwP8ujup
         xWiGO1eQ955HoOO07hp1kuwU4B0yV9sUMFKQMq/I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1jX84U2Prb-00Lmdl; Tue, 30
 Jun 2020 09:15:29 +0200
Date:   Tue, 30 Jun 2020 09:15:23 +0200
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
        Josua Mayer <josua.mayer@jm0.eu>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Message-ID: <20200630071523.GA2983@latitude>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200630084051.66feadea@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
In-Reply-To: <20200630084051.66feadea@aktux>
X-Provags-ID: V03:K1:EwmzfFLtGFe1eqxLKUj9sjr5ZZtJsSCdjqSaDB0tyhtqH7FwpJv
 7MVE1OKWKCnqZMPT6pGEvsz8akyhZYYCYnmiiZ5FwHG9d4xA0ltAhZvDqFSBwzYIfPpYbpF
 waJrR9Qb9frn8+QOYWZ5ovmF+CDER4IR4D8JXq2qDvnNfR610NTJmCH1KerOwHKD4sGJLHz
 7IA8L3TobYxZZX5hae1KQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kT8thK8dv4Q=:LOf/PXUjfBAyMTShPsI3sJ
 USZN/2Sg2cNPMZNyTgjv6qThDGkV6dbtgya5ouwRENdJNQbHQ/ktXYHSKzo4t7+ygHh8vLUl5
 dGGXv4wGJdilkBvLhkq7Es4Lj5mP1LdbyRzbnWMHEqgSPlv+9pJpXIrp5tARsboyDISx9Gn+k
 y8nbFJb6sT/s3MFFsO0sigKUf+StVofU/HvbSylz0+g2+pzouN6isCxPvLSFsj3VYPigVsOwP
 DZubGR7ze1Mk8Df/xa3uL1WbXC1F5WbEUzh2HQZOk07x0b237tmzkh9Ivqcb/cGma2vQAK5sU
 LqIjuZMlA/3/VGK+XZ7bTvNldMpxwGGgMNS5Uf5SJswBDyOUuIDQmAtIRiAoiFUMyaSm96x6v
 0nTGrXHZcQ3LYgnYtwxsbR3fbU/Cs8kKcx+XxLUr8N8AUT2xTlLbPen74BUHXZsEtw3a3SCYN
 C2b1rvtTXiTQYSORmNDpP3xxS7cZz/ueeBmuDx91aQDTxluWWgc3Fd6Ud/ABinh0Kuq9g7FPF
 8wGoHa++MGBFFfpchAwO/FmZHQakfeURgR2wJd/3AwIHD8kGIdhgIaRbqkmuBQV3FEc6aA0b5
 vtkaNGIGs+lhrB7s0LfVvtn/X7b1IiIQ14oJ0wXNtnmFsmExgH22pCHPNTFy1tmIYMiB+OJtG
 x2zJnMaMQumCQIobGELdugFx27aMAo3Pe2RLDB4/BdUqIc/6M8BOQkOizBS+cm5Se/yK9DpXs
 nRFeErXQRNSp0MKP65cKPkRfgSTnOlTpyRmVeKNXXorwOjjW+HA3ePNTJo8cy12vJGl1JqBPb
 +xR+gJJ62DTnoJeJopctG/Iny4yr3+E50cqjAGjmNm8vtrVlI47SZERWFiOuRQv6/V34VNxbK
 O8x9Tepaw+ybVLPhlAKwI+tFeWVYj+50tKycEJ8pA6xhSGAY9PxxOeI/06Twt6Va82A4WPTjI
 EbiptFO8xCCXhEHhx8cnitCvxGJck6U9d1wTQojXZzlFKMEmiDDSweTa3q2xk0rjkxdobcLVV
 kjttx8xH0DP+shj9pFMMH+7aJUfvjhTmXp14BLTrmzAoUP0mT1BeiICdO7kvgjZ22Sf6NWULx
 1rJNraibYPXAagc4e3ZZzWM9JWJsXztOdp5DMUDjnkCBc94K6NX1NEeUhbvRW+554y+058a/P
 2SauELZKxGhv+X79EkULbex1nXPLYXFlMTs9mZzfle35FqTtccaDACiT9/boQF62DMZWIFKsf
 2Jz7veqU9tVqKaVKu
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
[...]
> got a chance to test it on a Tolino Shine 2 HD.
> It uses the RTC from the RC5T619 but backlight seems to go via MSP430
> EC.
>=20
> I got this.
>=20
> [    1.453603] ntxec 0-0043: Netronix embedded controller version f110 de=
tected.
> [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: register=
ed as rtc0
> [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43:pwm=
 failed with error -5

Hmm, -EIO from the PWM driver.

> [   10.850597] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: hctosys:=
 unable to read the hardware clock
>=20
> version number matchess with what the vendor kernel reports. Maybe we
> should document which version is running on which devices?

Good idea, I've added a table to the wiki page:

  https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-contro=
ller



Jonathan

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl765oMACgkQCDBEmo7z
X9t4uQ//adw6WbhVY/ljNdI6evIOpehnVPm4JcX+Cq+FRgwzpcWAMvdXvmonOM86
Gjy7liAoNDczuxg7kdDhCRwIVANhi3jHJeeeHqzUnki8TSvnWS1iu5xGWOx1RRWj
YbwARZIU2L37uPys5ByF4RoqKp1tngfhL9B9o+e93x8RB16dxACG2qEb7Hdr55qI
/lwk2zuuHwqdxOOGSVFrD40GA52Xc/nn3wr1orqxOIE0k8pOEslBiXq7MW+nKROZ
Cdc1zGpqWnSlRc04jm1da1oJmmqZPCtiK7rMZcY98sbJgmdSflP2R5raXNggdBNQ
jNmRTSsBIxYkdK6+3W3Fl/m8RMJe6gwKaQIqYu69gZbsrm8Ap826po3CkCve4kCJ
w4mYJAxQfI34OrIga4mHru+qnFJEgMPkHwTI98LK7YHJT1ecWn8Ucblxd2dUQlGO
TCcQL//WWRiD73DJ+vd0NstsmvgMSlnUGgmWcCGjEIR0sM3e7DquHbfeDoaSeV58
ALjTBcTcoSyWKFMSO+3iws/kqmW3VlpHRqQrzRaiU9LqluBgK8PKXOopityTqG8K
Mu7yTDOrFwJO2q1kNJP45cpl/2JBpK23MAMFo2U78IvhhjMeKe15m2P79z+fbUAZ
ASFT4XWCVS+Ovv5HwrLoWdrTzNUYi50bl9vFimShNFr5qC9xCWM=
=ozP0
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
