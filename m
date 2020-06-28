Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6865E20C6FE
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Jun 2020 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgF1IaJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 28 Jun 2020 04:30:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:54027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgF1IaJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 28 Jun 2020 04:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593332952;
        bh=hOJe2Dl97VdPxKycDeziAd+nXQpgXsQroYTTcoE/0SE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kF+5prutYgh/ojChMkly43MvsPZjzllf21DKPyKHojBWnb46m+D7H03EktknbDHDk
         uOurR0PaAOpkTsPu2F6eUqdz5m2tzGo0O9jlglxkto6ROVoUCGvSPmL53TmVupb9SX
         YtfcfHwCjbP7DL7Hao1cRuP8jed5fSy2EIChSNx8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1jWySo3TvZ-00LEs9; Sun, 28
 Jun 2020 10:29:11 +0200
Date:   Sun, 28 Jun 2020 10:29:06 +0200
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
Subject: Re: [RFC PATCH 04/10] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20200628082906.GB2561@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-3-j.neuschaefer@gmx.net>
 <20200627101738.2fe4abc3@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
In-Reply-To: <20200627101738.2fe4abc3@aktux>
X-Provags-ID: V03:K1:EYN80R10Ni3JCrJyeMviqBbci9FWV67OkIWXJtmMXrxey+sKk/R
 9MEJ5n+ZLPxFZe2KOI+BmQVyl9jGiCdUlBp0u/Rs8ygy+H7o0NKC8otozyktJiuOf9SyKZA
 9xQP1Wd/X6DTV5U8tXR8gkGPOZgBUW2Wj+b8W9nxgknV+gmCj9zGVB6l6+SIBh8nbgxQ6Au
 09a/g4lfVcGRHLn2GOTtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CC9HN+ivt+g=:pajcjlYCJhSA5Ml7EhsTw1
 a4mpBJCL7ZksCxRyA+qWuPO9uGCF4XKF3HAuZ4/KY6/xg2NBc8vD8KYllFgmlToONCvTjL2yq
 Dh7H8UKsd/JgVbbDXpHdD+GNjNvHRHoGbSnuDkH8KB7Zw9v7C7D4GLz2EIcSngV4ntLUtUndu
 /qJ0JfZZ5vfUkx+2IKLUGjYpfZ1Gn77Pc7cY7gqgSgxKELjAZMZkxvhYFqZoUwQCAvivPQ1LA
 lyUBLsSY7P2hr5KAACqg257N90QvGlnEvqyDqdQGQ8dyaRzKknj0ojexkLhzeBuy3cfFhnDOu
 KA325F2/ddwenMnMu8x/ZyYda0FVVQ7b6DwGo2NQF0ox+LSKu2qrj+1lBzHDf6yS7zddGbbUM
 pugKSRMyPbUaTjj2ZaG4OXFieNrVt6ubfdDaedqmrdsLjQPvylQURA7sBRoHBDb2dRLT8G0TE
 dmaW91Pb+y7qfSJSLLtw7QktSBObvyhBH2SCt/j9UH1e2RVtbAKfqvFJoChBgUTMlltpF+O0f
 1sr7a4KWx9aai+YDAUMhHn49v6GeWyJLN3SYDKpI34OgvFCfD+6buWbUYYD8utf7p7ZphxKdW
 dOnyx3X8B8N1jphsLGW7/lrvqURSk5AV9TedpjZ7gT8jli13dMPCIUc2nbCu78TOaTz/gJniB
 4y3WQXlIhdEJ67++1NoOEwo2y7cA1Rt+GlUVLwlX8iPztAzWJ5wry9q2dXmo+h3H5uCCYQ/OI
 g33M2xwCEQmS0FMagJyGCW0eBaDyTbyIjk/X/AqSobT1Wx+HBYHkxkOHJM+H/0sIn6LZMtXSR
 d6zucJ5qTmCKjWiHdkPE5dyG3sqblLb3xPUnkYAMPpOHTYOc1+8XRenlnyTFv11Tf75zGqFXJ
 Z5ZYwXZE+3AuC4N66bZna7jIUK5quZI1DvcIDIXPs6afKT+Mfroipkycod2IT8eC7o491a7ix
 wn6ZYuJrIVEkI4qNcRoqXQhr94aWde+snZLTR1HNADA1CryJr32VF4DdYTl6SxW7jzsEMpRS7
 ohAUP43zhPjprIXRPNztXXFeIgYfxCaoo774Vzw1X0foaBvwuaseou2Hx4VIXDJ1p7x/Yd12Q
 WV/EpD9DU8npNnwBm8llOrZIXZsGxGhq37+cmJ5PnqHdxTVQ0IMvoDDdbEJ7FKECrp95m3ax7
 8qvZofJG42doUNvyg6LyTY+xI5oijQcidmAaRyxk8n1/ayxoVq1/uWFpMtYvKyBY89Ui77efg
 g0bvbSg/7CZbO8148qlqYAzI7PWiR2mXHhKvV6Q==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2020 at 10:17:38AM +0200, Andreas Kemnade wrote:
> On Sun, 21 Jun 2020 00:42:15 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > Third-party hardware documentation is available at
> > https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-cont=
roller
> >=20
> > The EC supports interrupts, but the driver doesn't make use of them so
> > far.
> >=20
> > Known problems:
> > - The reboot handler is installed in such a way that it directly calls
> >   into the i2c subsystem to send the reboot command to the EC. This
> >   means that the reboot handler may sleep, which is not allowed.
> >=20
> see
> https://patchwork.ozlabs.org/project/linux-i2c/patch/20190415213432.8972-=
3-contact@stefanchrist.eu/
>=20
> for a fix of such problems.=20

So far, regmap isn't involved here, but I'll remember it when I switch
to regmap.

Between when I first wrote this driver and now, the I2C has added
support for transfers in atomic contexts very late in the system's life
(exactly what happens when you reset a system via PMIC/EC), so this
problem seems to be gone from my driver, for now.
(See commit 63b96983a5ddf ("i2c: core: introduce callbacks for atomic trans=
fers"))


[...]
> > +int ntxec_write8(struct ntxec *ec, u8 addr, u8 value)
> > +{
> > +	return ntxec_write16(ec, addr, value << 8);
> > +}
> > +EXPORT_SYMBOL(ntxec_write8);
> > +
>=20
> do we really need both 16bit and 8bit accessors?

No, the hardware/firmware doesn't care.

> If not, then simply use regmap_i2c_init and set val_bits accordingly.
> Maybe just doing the << 8 in the constants?

Thanks, I'll try this approach.

The values are not always constants, for example in the PWM driver:

	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_HIGH, period >> 8);
	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_LOW, period);
	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_HIGH, duty >> 8);
	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_LOW, duty);


Jonathan

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl74VL8ACgkQCDBEmo7z
X9vsEg//cjP0FgATqceA5CjhLzEVJxxLCujFQN03O2AvzBf5EdlAzS+Rbl8vmTqw
aGm+JAhI0gHbQgTni2UFe58LXIjCY6PG1weU2Zge52QLRIFsfKnh2qz9sAJUPBXD
vrJOSTrlxBy7j4kAg4vsWpo1y0a+hg7NVzaV4VLtnhb7iEPjnbjgupi28gx2ak/P
gJrVyIJOLMiHAOpJe+TiZPVUphklEBC/tLOZkq70vw6PElkemNNC9ajufmf2V+D6
kItW8NNCiOVXC6+1tklpoZlyttCPfVVv8XpTk+KtjEIghryk6aGbDxxD1HNOAUyz
TqgtqsDwJh7Wr6YC6cDsiwD9YAzg2MvtplzHaOYpOEeXRT2ZjUxtz4MJ5YdxaXfl
QApB1HpUzZvAECUOO4tRR+Olq1rB4y3g3pjn+NEH7XtKZiokxtT/8iCvcHIkIwLG
LFiQ7E2Lha6nprVbGyiCG1l3uz8FZtqdrHzXxeVkkMvvFDSWXSNWKGogw6/SNGTc
vB8tkxixvppfKlbS2j4kBXe1griaqSFPC6epS9VT1NpNGecekg+5M+6OEm+LTq+v
XI4kTNYHd9GacgNzLbSQG3p0nNg6YGdyYXXID5jArsVOPbRThclnNLDajEQ9r2IZ
3DAjcL/TTRxwmCiAFAoNMVRnBvGOxyrWJ5YuLslonkne5i2lAFE=
=7+bu
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
