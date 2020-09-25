Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746532793E2
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Sep 2020 00:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIYWBv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 18:01:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:54995 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbgIYWBu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 25 Sep 2020 18:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601071245;
        bh=ztxbMcMpavSGlbVmgt0d84+xXgIqro2ItnQZq/Y9qY0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=PCdaXY5rnW1fTrNQ00KUO709FxO/s324Z9VSduWfHoJDbDNDkUmH/t/Miypu034nB
         SubvKInVRtSQlFKA79001MT8i5IYKm4w5ceScoFniGLFJcx+MZ64TATpcIX9jn3dkh
         db/NUAdwpEQKiKKcHi377XHMuycs7RutNNjGU/SA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mi2O1-1kzxUL45RJ-00e22R; Sat, 26
 Sep 2020 00:00:45 +0200
Date:   Sat, 26 Sep 2020 00:00:33 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
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
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20200925220033.GB2510@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
 <20200925093614.GZ9675@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <20200925093614.GZ9675@piout.net>
X-Provags-ID: V03:K1:VQy9eNdUYXIIZDE382DMLCtuHkN2mfcSziIHnQhqgWJZIR+IF0X
 oZhufLqAmhdf8JvnJff9j9IqPGiz9cf8tqjk3smwk2hfOwj4xlYuutjQP6sOQJwRIsQLKbe
 WkKgrjJM5KOEhtqqhHo9t3YKj1MOmWB9rFcC97NWGwmD5ODxrzgiguui+brDl94yGXk+cXu
 LDdstcfVJMzW2LypUFIZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q80hw9ErrqA=:MR3z7DEezfZXHgjrczDTGr
 KcFIZm59Yy0hP65r2xcCIEN6M8cVfBz5hdhmymgQcKPEuB+CqVbGl8ezwmKPeBFbmjwXxmhbA
 bQrs2l0SvzB4QeHOAJeuy9ZZq7LI2NWQ4WYk858Zn4vVgZhDl37EXpITMKMpZWvwouWpYrmY1
 iZV+igo4Yyinsy/W/u0pFCrUf64MAlcQnL0ZH10a9P4qR4MVnMIHMTR5p6idA+nRJW8QjyT0I
 wk/HAKvBDGdBBBysCS0KquuzBTZktyTbpvCtFc8+Hf/Z+M+izS9xMZVGiFrtaHZAh+dHaoVru
 ogsnZQciXudhL2+SMQOKKIxb9oyJnjfnVpMTG4ocBxSAfI0MYoctUCiW1HAQ1n/Nhu+LvV0Pj
 mPC3niwDJAZJ8UMLCpIXE55tCDIW79TLyxKh6X3kkdx0QGgMnh00xt/M1dK1csTYUvQChRkhk
 rwZ7KOZK0jdyoaCMY98RxtjQErZxsgGpm1vg+YDULfwtJDOwuuRhZaJjJhx87e814nS+1rQ1H
 un0W8wVNWY7xQIWVFPRUMflcbrjQgoaRlfqToRMYu8WwDvtG8KdDj9YNv+f2Q8lsmrXMy/7xg
 T4G8sne8eVyAPdgv948dF3ew+sLFw1c3d+yHxUo0xxol9AoXtekiqv+yJJ46AFt5wsSQ739fI
 eM3XAFQ91JT2EqRdz0hlurw7nMKtFJLAqdysbuf/3lgAeEFXgpxrmk6zZ+jBLVCkY27cmkpyJ
 ixr2InTWnWvfVuGR6GLFTBApzAO5GjxFxo3asIFpyr58DNYILiaUeJkNZPNYio1UGuLSCT3kb
 r8YgWEG84Kkb/24/7aB7eZnkzxOZX6lLF2HXzQKLMAE1M3590HcbvTZ2x1gxrkHXkPFfC9ZQ0
 ThZZbOGaW6qNF/Ohj4Wbevy1hErmMW66ApFySPa4acN2ZJnY4MDTC1UNEesVfKCJmQD/K/VkU
 KQZuwPPMtm/V4qW6g1zOPnIZ9R1VOr61Exfdbal0sgULdUetQv3FU1O+XWwUtIzxYcYi9FEw3
 oA6nUWQc40bkggbIxtXwi2lioJx/U02eiJ3n9IHRKXVMBUmDJi/OG4i69zXphevsd8Nkfld2F
 TYGsK3B9xodL6Usi1lfQKlD0Bv9i/m8dvDnMwJeJw30nlPWEtNdE70k6R7SGWS8yOjy0HwMB/
 w6MGSOKe5Mre8/E3DF76ZueZX6A8S267qJTj7muvdHtXCr3KgJzx2Ya76r+9uzxgjWoBGAdpd
 140ZgP+oUr2fpGMm7cnoHzD5jG/gKKhSRva2Eig==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 11:36:14AM +0200, Alexandre Belloni wrote:
> Hi,
>=20
> On 24/09/2020 21:24:53+0200, Jonathan Neusch=C3=A4fer wrote:
=2E..
> > v3:
=2E..
> > - Relicense as GPLv2 or later
>=20
> I don't think you had to relicense. The kernel is GPL 2 only, you are
> free to license your code under GPL 2 only if that is what you desire.

I don't mind in this case.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9uaHAACgkQCDBEmo7z
X9vzphAAoCYGjLQdcxjaBh9Jk+4k/cEK567Nzrk68QQMIyXemvEY15Rvd+Hmtuw4
6Kz+TfyxGKQT+kapBiKmMUAmezz5c376BNN6yc330IAZ76mK+Zt3JtUut2vDC3m3
/uk2xriYBB/vbwGeUCBmjzvmhN330o8ZqqEShJHNnnRZHCp66ACtyw7Vrius/Dyz
dqzbJZ50EktrNkTXQO/oqumv82L0UO4IwThJTWLl1/+XWd6M1FG9OkBNuGlJs1kH
PPn4lMdZ+QP/+G7ZSM2E12eFXojqD9Y8mpclnGmbfC0plNFK8z5fxnVKYO0vSrl8
nyNuqyc2LnTQaUw9d/8Dgg1K9S8XdU8ImtYz4GJG4WqMJx5tHsLzdocvIh9/bSjP
WU2RgRUt6TPc8eeRibBgiKqDGCFhLy/yj532rRrSwNOetNwEEMWd597YyCusWMbY
kDJxDpKivTP3dd9iqTMMJIyYQjGOr8JH013kFkr0bSOdIaBPybgqvALxzZnLJ7AB
axnS1Ev8HBJ9zlM7EReT8VZqdfY4BnjsDGLZoVUBCU9iikV9RwVNfD+g5G44zurG
9XfmWBTcjwwN/3Esf//WDtjHTwYCJaIyk6eh15hrSxG+uxg+yW4nbX0EZwDbIMhi
IDGN4OuZkCF/kNo2vX383ynU4CS6mzkaOECfsWbvISi7m3ffldc=
=IVvh
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
