Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5266F264E80
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Sep 2020 21:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIJTRF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Sep 2020 15:17:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:48535 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgIJTQa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 10 Sep 2020 15:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599765228;
        bh=qeHl02+qNaZfS2zb3ool6auJUEybADfCqRcX+fplOTA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QUAkVEnxqvqyeCAt5nPfZVQETiNwOilqXMh0x9Ui2PmgaUP1bBMt4HCFaqskqJfMI
         Co5MMN8cFkDDZLmGTblSwoTvAa1W1ooLlGlahTlDS/QnsMCxtMjON0YxT22UvP7vXX
         +gC3eh3V3PRBaztZgt4pZrhM6MFK4RvPNR4rdVqM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSc1L-1k5cDl1x6H-00SyDK; Thu, 10
 Sep 2020 21:13:48 +0200
Date:   Thu, 10 Sep 2020 21:13:47 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20200910191347.GC3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-6-j.neuschaefer@gmx.net>
 <CAHp75VdUHoOyM3bObzhdfiqpne0AmSK_UakteTZxnjqJVrNV9A@mail.gmail.com>
 <20200908081445.GC4400@dell>
 <CAHp75Veb5nVasy28FSksf06eVVhC8N5hHsEPM-2YcFbMjZ5Rhw@mail.gmail.com>
 <20200908093538.GM4400@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20200908093538.GM4400@dell>
X-Provags-ID: V03:K1:8ZpIiqeMGiTole8f3GZbs/8J44fyaw8o4mnDZgvWfp6mfZoxaEt
 BdtfDOdyJK9E+rxiu7bTQywtxF4Augq8FOBZ5ouioXKMGq5h2DzrMJ82ln6p92Uz9bwIjP+
 WvPZ4gU1fqy3iEenraoawEBUJcjeNCcwgFAiSu22eKUWIFhA1QXqgrVSoGUYt2IoJZp03xy
 6X0bqHigi3TrjBpy9xDiQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DtwUwzvl8t0=:di1WMmdZW79JaiKn9/d+70
 LUcctiYT+4V7cyroNFBquwjr1BpBiDfXdo1KI1PzrGv8xFfTzw+uupv9U2uBw4e4RY/WZtCQ7
 8jM7korv/q7MzSC5MtOruOXB7FXABdyRvxaw6gquvWMyKgQnvfzp6TtUKh8FvxyOwl3z/YP0s
 4PpGlO4m+ou4BzPj2eWOesu1bbOsq6FAI/s8l9aRAs4qQTTz8xCJzH4xrrENviF2SbLZkLzl+
 X5TdbYUNCkdkyhIOca5w2EXpFNNhR5ARCkJyrebq36wodSU+HdF+dwzS7FQibN8GCZeZetKU8
 TRSclwIqQh9m0ctMIrTPSboDbsIltmYXzhciRsd+Do7z2+h/Ss57ih/0VAwTPYDN9jHvUStK0
 Oz5cqEBbe8GZzEEQT+eAzxA9ipD4tJ+lx+PWejS8mGUCTvyVF+o8vVgcDvVHvXeO3j2S95nOn
 YnBIg7cLtLEsdEf83kKMJddmfgU9MylGTGxo3D+p3a4eTkkBBSgrftJBxUGsI/z766SILO3fz
 jhVn5+KNf55Afi9zSKsGHm4xDHzV53WR4TQg9dgPCdvBDxgBTPcxxNdI9BLEUQCz1JUVi/1JQ
 Q+HSb/TRDBgcuw7K+JRmO4fOzSkbd8D9eh+vQpC6AeQpCKU/RAfYSy2SFyLzO68hZ9rrlQkXP
 pOx2qtmm8H13JogISs4+UvQo0r8I6KlQ//NkXr80A3+QTMJ+3hpJsehtFdwO15MS/UuiyNLKr
 zcdqgW4I7dLWUgKiagQB7HyJ5ZfcbDrHSnn+Il4WFZ2fRrB0PHLZNY7KSjfPlDR1kS0iFdZPG
 QL3L5IGdD4SPOb3W3vKoU/JzOcgMxmNof08uDAXSrYPNyG7ZLj+/mAc8uKZ39zcDJft1akhUa
 +qFt3hhYWzTPcjF/nVpAQgFKVn1ZI/TwVoYZz8QuEDI44W3fqli2/G0ohZkABYz+mhW1uRFEd
 rGwHSb45GFuvuFI3nc0KmAkgQSZEB7sbokJHcBs6YnxyfHVBsK0WoD+LPizKRNGorhcC6Y2ej
 aF/Yw90qMzTxrvuR1JZqhwXz2SSHMSy2fct8Y6MvH4ZgJ/mwGsAGT53Kdjc+ZvtXkWaNXXjeF
 QJPnu8HlbywPXWsnAzgMS3pKqYFgszIZZr778bWKl4tPzLRn5xOh8aM8S+P9nncdT1lUo1l3r
 DixBnrnSmdvTwZjePQV7QC+37eS+ICPhmDIAkvepJiM+RMjDFv2orSgRiZHM5iv6wXxU2MQp6
 QSoyrFBO6iRU4g/zefBg3KXri6sRnytEwpyCrxQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2020 at 10:35:38AM +0100, Lee Jones wrote:
> On Tue, 08 Sep 2020, Andy Shevchenko wrote:
>=20
> > On Tue, Sep 8, 2020 at 11:14 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Sat, 05 Sep 2020, Andy Shevchenko wrote:
> > > > On Saturday, September 5, 2020, Jonathan Neusch=C3=A4fer <j.neuscha=
efer@gmx.net>
[...]
> > > > > +       depends on MFD_NTXEC && OF
> > > >
> > > >
> > > > I don=E2=80=99t see need to reduce test coverage and use of the dri=
ver by sticking
> > > > with OF. Actually it=E2=80=99s not used.
> > >
> > > If the device is only known to boot with OF, then it's pointless
> > > building it when !OF.
> >=20
> > No, it's not. As I pointed out the (compilation) test coverage is bette=
r.
>=20
> No, it's a waste of disk space.
>=20
> Why would you knowingly compile something you know you can't use?
>=20
> That's the whole point of COMPILE_TEST.
>=20
> Note that when you want real coverage and you use `allyesconfig`
> and/or `allmodconfig` then CONFIG_OF is also enabled on platforms
> which support it.
>=20
> > > If you want to increase test coverage enable
> > > COMPILE_TEST instead.
> >=20
> > It is one way to achieve that, yes;
> >=20
> >        depends on OF || COMPILE_TEST
> >        depends on MFD_NTXEC
>=20
> This is better.

Ok, I'll go with this variant.


Thanks

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9aeuoACgkQCDBEmo7z
X9vkeQ//Z6VkR7LUMRr15RrcOim2rTLOTurj8YLz+0euJs2UiKbWB1g1sq0EUbl4
oF0lpeQ7r32jaBtYOaMbJnl+seUEeBb8UQGXtS0QTdpOiQO2l0aRWJUpGOWmFjoy
sNPF0FJOKsJ7hE0hgHrplJcVUMaWI6RcICTpEFWXaXBjsOi0JyWVYXPmHcSXewDm
OBWmV+AHu6xnVAnsf/d38DJSGMGGlmTqyfwy5f1Hex0k84lC8/UnZZncG0eSqEEj
nnTb8qWCsmAuyA9VXniUsdw8czkVLXHH9Nb2gZkxC4rACWHGdx5zJQgOMl57GR3Z
P4Be4YaCVUGrRSyxzwdZAESOR/SXyX807Vienx2oPud1EVW0WanG0E0oo51MmItm
sy3ztPgb3KWEcB03EwNKNIyECn41sxkQYnj2hvZMDdjIwcX+zBerlkMib5FIHygk
IvDE46MfLDxkbcWL1Rf+YsTUYfkGfg5LRaEjlIfhW+xErcW2WDjCoA9DfnZLMJUS
tFqIYmUous2y2g8JYXUYlFLD1OhaKSjbmDFGbSzQWURynxz6pSejboqIb+FM7TNA
f6hmHZH+O7d0uOGCzsbKszzz4haHdSzxnuMhV3ZsSxB4r/bKCBWlyGsdBqcx9eDw
AKWxNJZlp5Mj7j5Gow94BY9+8UZMjGk+mSUh/aCHok6Ll5+Zdx4=
=lXFL
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
