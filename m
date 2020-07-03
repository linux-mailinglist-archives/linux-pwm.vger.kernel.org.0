Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8A1213E0D
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 19:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGCRFC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 13:05:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:42757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGCRFB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593795846;
        bh=NMxA0rJFy0rgPJuKMcbgBgvAMyJ5bgpP3c57zR+1EpI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MCF4IFdKMFCojJq4ZQt8c2szo7O+SD/M9VdbeZ+xCNAFrTFYhBJ/wqpiACNjXieZd
         N3RyxZl2TQLAefGFp01449Vzq5IFShBTCUjEdDS1HEvjcNYgNG0jY8wwLHyHOd1rbJ
         siBfqOTiupMsu9aJVa5cX2s1AcZNoi6CwqXCstYw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.26]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1jOyUz0TSh-00SLjU; Fri, 03
 Jul 2020 19:04:06 +0200
Date:   Fri, 3 Jul 2020 19:04:03 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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
        Josua Mayer <josua.mayer@jm0.eu>
Subject: Re: [RFC PATCH 07/10] dt-bindings: rtc: Add bindings for Netronix
 embedded controller RTC
Message-ID: <20200703170403.GB2578@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-6-j.neuschaefer@gmx.net>
 <20200621000220.GB131826@piout.net>
 <20200626235552.7820a999@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
In-Reply-To: <20200626235552.7820a999@kemnade.info>
X-Provags-ID: V03:K1:yUnDfLRpDS22abzGxB+hDCIR+UHdBaMjHWuXpRTzDdgNKGHxkzg
 l+2k81U6Jf4ci3/NJvr7i796KsohxPuMHBHBfdcn0J1kaKxK7WB2LUEDBidnqhNpsPKfuUY
 52wlRVxtWYlb3FevDeVpF5NctvGTu6lBn7AqSH3EN4FsrFxBT84thv0I8EnQCxogkGTqORR
 OZ8EFCHcqDj08y0Ujt3FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7NQlwqM9iaY=:SrHdv6SDirD95++g6q8Ta3
 CCp32suYq1nkbW8ElBH4hjFAP33FsSTkwEGlmiGC4B/r4z2t77fHsQAFFMEFGfN7qwoopFIW0
 MfXfdtrMyNI9zAmjTZ9OtO02cYJcocRk4XNJaN8E0avhlLdFtLn3qv+Sfn4TdMdoaPf+W9m/8
 /4VZwamwy0lVlB59TfNuFe604bOueUVB2WTT+S7CPppJPtRqoKe5n4rflxn/KqY0IWS4nqulN
 6l5qOhv+CTDMcCzCHcvekxwHFn5bl/kxQiWKMVuUxiEHiuI+oHXD9m6wLoMzRfjsLnQhAxF3p
 xy+y3RweQ2D9RSKsuSdUcmzHNqGIEzsczSkEphNpbYTPZBGoURKPnOJ49NHGJ9NiN3lvIs0yr
 EjfKpWw90y2MifgDAQJDZ3kbSjd3kk9rDMd9tLQHQz/rhk6JGH/z1l186iypVFLI69sblDfbl
 AqEXqbzBuSzgT2N8Gyu7O/ISRRvj1ViB0ZWBiJ5B6JmkaGg+H5NL6lSX4PwXMmYNSoiZIIfDy
 gRiKRbnYKS5I/8vUUyh2AiB6ZFq2FpYCWYGJ28dn/SXBDrbDMxzf3Aalkg3XLmKwe7U9jDcqL
 +ZKy0sxXXZCguv7nFI3F39kf6oXlPuzheeWQQbdEytoM0FrhKzZprbMC6+0E61ystSfI0/Dzk
 VDdJN/dXM+Zz3K3YzvOB4A8k6+ONN5ziwB9LshIY7G9MDXKWxfbvrnFpMPZupE66UUYGHP4d2
 rfmvf1rO959nMDz6n4lU+Su9811GKdx99HeCsKZZqmBzkBNz0/Xzc8zOvKmMT8fw6IMwuz+Jr
 PDwbJPcCsVnA119v363Rp+lIwzJ5Bftjrq4p9dmpzG/CA8QSgLB3ZJ3J4u78ZLykZ32B5h8M9
 vU6De1aMgQCHHFyGV01ZwkSCoS7ZfdB42OTFiG7SCsEurDPBWcbTz4Dj4q+yBgah7K4Yv4OWy
 jCEWjthyalxG3fIf1Sw70w+NvqWcyoTe+n4GQZuBfY3KgCOivuOK/V7lWdotV+s8/cClwzGI9
 xRRafbn1M6hJQFDofHAZxGbdya0EumKpsY/SMlmHJkWMLxcMB/4wC3995Q/Mdm9mU6eCU5FS7
 BZ25kqyZYSaVc1bAkceZUJgoryAa0XkCZaN6jOuiBWpsTfXN9tVKcaV9gyW249WpOLTNV5gsF
 ddkhcnanHr/wSRNOmf2fxE8YxGgDpvHsrtyXSsnQJ7bQhLWLBQQ2VohtsLG32K7KGzwFAQV0o
 nl0d8CFS9ti3ZtP5CBxP6ryoKUgUaqjSoPTmrOA==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2020 at 11:55:52PM +0200, Andreas Kemnade wrote:
> On Sun, 21 Jun 2020 02:02:20 +0200
> Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
[...]
> > Also, do you really need a compatible string to be able to proe the
> > driver? What are the chances that you'll get a similar EC without an
> > RTC?
> >=20
> Tolino Shine 2 HD has the mentioned EC but the vendor kernel does not use
> its RTC (not checked whether it is present or functional).
> As a key for grepping in the vendor sources:=20
> gptNtxHwCfg->m_val.bPCB =3D 0x50

Thanks for checking.

(In the MMC dump from my Shine 2 HD, it's decimal 50 rather than hex)

> Tolino Shine 3  and Kobo Clara HD do not have that EC.

Fortunately, this set of drivers isn't needed at all in that case.


Thanks,
Jonathan

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl7/ZPoACgkQCDBEmo7z
X9u0KRAAi+x9zdV1G7QAjFMdps8yowNKZqvPUG67nQfu12vy08hIG/kmkkp4Hegw
Ca2Byi/d7zXOrFzhmzK9gCdb05mFOEsAOtVCDsd9hgx/02Asj8Xk6zc5x+VwxVAk
bLNcwERwIU/nQuxqca1otbava3hzCysevndTcySDdsb+YzhRyYIkcolik006kD5d
DpWFolL8t38dbmalTIxWLz+3YBpnCeNzdyh6i79awbxtzC7E1PgeMwukIxv3uF3B
WeyGN0NAF3YMJxJkRRXtPwGK7htJznbViBkRurN2BAs2Dnmbizy6YO3OhH7J1JsJ
HjmURgE++Io1JCM7U3uCubrkamzj/mkdfR2oD2CKuY8MYFf1HEKmGZryBaO8vL2W
9HwhdkPgQiDZh5hKrFu15yD1Moww2yUKrwhKjXwbMm2qernQWqZilq/AV40UdPJU
7gcUoICqUasE97OlAKCCJHc9lzzOLfwZfv4bZfGMNgDjww/heNGX7MXByrPp0lin
u626AekNKTmDrdyxpWXVzdybtrB9dzv4lR7cv3SY0VPqiA3jAgd5dSSRqdVGMFs/
nUYJDUA1UuSt6ZHnODMxg5dkntQ08mXETVS9aAjLIIJZID/73BLqOVRHn7R8zZwB
vwTIWBBVaSJOD+Ew1V0kr3Vc0o1yI+Io45kHfUAavwW3SZJaaIs=
=9VB3
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
