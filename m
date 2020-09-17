Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697D626DA0B
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Sep 2020 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIQLW3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Sep 2020 07:22:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:36151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgIQLWG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 17 Sep 2020 07:22:06 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:21:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600341671;
        bh=kcQG8LFPG8ZdF1tJX2ReXp1ymOvCchPakQITfwi7wsY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dwDxmHHn/PKRczTzXf++7gZFDephWUFI/02G4b6e5ZI3/Kb+Vo7BLISTM4OdgIR7f
         pYt5zlSOw4slvmQoqBH2qv4ey+sj1pytORKTeCpaqcONBKrRejvHXzPbIHzd5rO+P3
         UBUJKkpfhf5cWGtipmaaQDH8OGk6eHbU9l4N5E64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1kuPW53Tk8-00bYPT; Thu, 17
 Sep 2020 13:12:33 +0200
Date:   Thu, 17 Sep 2020 13:12:27 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: mfd: Add binding for Netronix's
 embedded controller
Message-ID: <20200917111227.GG3306@latitude>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-3-j.neuschaefer@gmx.net>
 <20200915005034.GA593718@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <20200915005034.GA593718@bogus>
X-Provags-ID: V03:K1:ev2u5S77GN0uZkDCjBOntRbHT8/sSZ8XUQEayhtkySNmP8+bRfn
 aDiBBQGrJse0BLqsSGvKr5UIq13EnWQMgp3+BrzC0A6nE5NV93CereLlHSYFWSaxwAWVTff
 3u5cMb9C+fDculSIeXHokBZWKitnyLBgvzrskB5K4vJFJUaxMpF6MqCdAS/wpHr5Ejecq63
 WXGDMG79gAVqrYk1oO96Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6qVPALzKyCM=:RhrAj3SWrfW3i9PouFl01A
 R9WzOIJMuX8H8tzOxK9voLMh5RpjSFc4C86Z3aIXms5kT0T2Vmu7aI9nb8eb0VapY57VzsBht
 WPVjOYQt9fFLPvlsFvnF2SUIbwk5mujtM24GqqJLsei/a1+ZCPn60WuGP/IXxz8iyugNjd5oG
 7U+cPamn5RnPl0p3zYuyPsmpAe6c3Qae0MEUyd68qrTzaNPKMu9ZYRIPHk7NzT7RdzVy0PzWt
 wSSc0hiPRXADSC0opaZAzOaP78jFFuXVV9VWkNgzOeB/oyBRJmxSX1BwTWv/UmhvuBnz79ozJ
 Bq55hon8URzTMUDq4cncUH2wUMsFY4FMkyEYmv2comfjhhh9WnE8t1byeBTrSys5iC1Et3Puk
 NK7f4kcRHRcH+9/q7rPR9Pk8WXLTlVMzI6xIL4RTntwWEdeiWA5UDEiNjXKspJnqrj/xCgexR
 1QT6eAhO25pb/6aJfapdcqcUeHPsaMaH61CX9lP104Ltq2nErsub5XRrAEz+dABZpPvzRPgu/
 XWZj/04MZxsj7PZC1wFIlBeeOVvIG2OPf+n9xqFIlmH6Hp+y0OqG9t4NRbLJfnQjMaNFktxvn
 WnNI1KBU/GeF9tJMbqGo5ptsr3opd/AxftNz5dTFSG1dvyCpdvHQPwaj9SYSAx+8FaSjnd+K0
 CFdq0b4JTUn3YulKzjckJSAmjKj9GUsJkUdW2RtTwucAXHPMvOc6kv852Yxmz4VhpjcbW1qDE
 PoBUaSZXVVJj0GRwylq9yQ8ZgkiMOfEiT9qaWU8JWXhOIm3M6RNsX2614/WWwR4bZ3PwTaj32
 gAbTTe2HfsCC//AUT9gvzYSMIJqEjSJYfnHGrY+E+G4FS/QaRhkJNkvZHovp47Mvvv/SirzYo
 rZ5Kh+O4V2TOL1bu+T89sh+kst8hPS7UWDxTnwlakPcY7BrS+VCl2JptodaZnogq8pbN7Kavg
 jy7IKRItl/18Yzq6++1FI2NGLEhjNgCv3ZTm1Ct6CvoHcYl1NtXRgkoRStwdJ+GnHVzIq/flD
 guz6mvvEf1reJ/LspfmRKeIDJgIU99ETHBSNUxMsODCUkRQB5sqmoNFHUBTn1JFgI7qR7mMFX
 cAaLgWxUkDn6sqjb+IojZvXo6pma8/u2CviQcD8ONJKQLn4ddSPrF2zBbVHzrQuJ3pCid+NNK
 mjXrrf0CrUUkG26ZvLF6OwEDeL3zALdx79PeH7TBdLRkR24cldRRFYycs17tI4CHAeypJZHDE
 a2V8wGNJClZT6Lezqf/dRulgrFuvj6SCmYRUamA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 06:50:34PM -0600, Rob Herring wrote:
> On Sat, Sep 05, 2020 at 03:32:22PM +0200, Jonathan Neusch=C3=A4fer wrote:
> > This EC is found in e-book readers of multiple brands (e.g. Kobo,
> > Tolino), and is typically implemented as a TI MSP430 microcontroller.
[...]

> > +required:
> > +  - compatible
> > +  - reg
>=20
> additionalProperties: false

Ok, I'll add that.

> > +                    interrupt-controller;
> > +                    #interrupt-cells =3D <1>;
>=20
> These need to be documented too.

Interrupt support is something I haven't really worked out yet for this
(set of) binding(s). My idea here was to have the embedded-controller
node act as an interrupt controller, and the subnodes use specific
interrupts that are relevant for their functionality.

I think I'll rather omit the interrupt-controller and #interrupt-cells
properties now, and add them later if they become necessary. If the pwm
and rtc nodes are merged into the main node, I don't think they will
become necessary.


Thanks,
Jonathan Neusch=C3=A4fer

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9jRJQACgkQCDBEmo7z
X9u8KRAAq5gEP5j/6Hqan0bWxs+pnmxfLfJWotg/zYwxGSXKbNeJs5wWVQ1A+Pni
DZFAl1Ai4HcClf/OEA4dU4goQrfPUwunWBXZtzRWtjyssikgRn/Ppkt/Xw8p1zZ/
xxJqR4GD1N3jaP8G1/w8TbTLNSCXuYXh3mV8bfM8PHvBf8R5rGqDLeCP2qdUQKNu
LrO7CNsUNwBwbT+/9H8i9/DLuZCiiFk3RrY9/hTS2dkIYuuJUWnzjB7TLapSNvAS
hN/58HFgjheT7YpmicfOCyGjPCV2o407QDsQN4sEiFn83dk/E1Uz9kizLuvPzzF3
ZUbmlWSGpejZWHM9RBPf9ZRwDtQFu7h7vutQ9U+2Drk+jpVD72fOgBCraAq7wndy
riFBUSvFm+jtFjZ7Z597JuMMuU1pUYv7lUxt/0D0svNGq/tTMU8mYZAxKq9XAvOb
uA9bMxXUjj/wIMK444K8gBtmMZnK/XZhUiqffKm0xuiEUzKPJIVok/5sTLroil10
vNzVBrjQb3fO/sKeB5jLbr7QJ426aYHF+nI1mGC44FM0LiAo3F/+B4VwGgDhhRAh
zrRVgrXDe/YO+yjR1+1E1NmU0CZ6C2dbdLJr3mf+T7RxHsmZ99JCZb9TFSThGP6U
gKdiSgi+T11HDeQXw559Uhf+mLivOh+20AAj+RSOg+F2NDYQS/Y=
=Luic
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
