Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8442CC32F
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 18:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgLBROA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 12:14:00 -0500
Received: from mout.gmx.net ([212.227.15.18]:39967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgLBROA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 2 Dec 2020 12:14:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606929099;
        bh=pQC+UTEB5yU7IDsAP8sscDmvQ/csugMq2wi4Lt2jCMA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=A0lCja33qclyOmZ7pNpDKQShzqbo23g+otRjsFG0Jw0PPfURqItluSbaPQ3YKyUF2
         /RK3dxDCkrc6NHp/8TeNxUMBqOOaiDFcE+v4Bu9XbMWvwVZsYkk8zr5SUo46fApa9v
         Pu91t1T++C4moITBAUkKhFYpVavUc6ELNLTrtAgc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MyKDe-1jz1Db2IqC-00yhlw; Wed, 02
 Dec 2020 18:11:39 +0100
Date:   Wed, 2 Dec 2020 18:11:33 +0100
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
Message-ID: <X8fKxdIqCbHtx38Q@latitude>
References: <20201122222739.1455132-1-j.neuschaefer@gmx.net>
 <20201122222739.1455132-4-j.neuschaefer@gmx.net>
 <20201202130520.GL4801@dell>
 <X8ed7stMOGhnZ18T@latitude>
 <20201202150943.GN4801@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CjPGjgSPWBKyBoQi"
Content-Disposition: inline
In-Reply-To: <20201202150943.GN4801@dell>
X-Provags-ID: V03:K1:pby5GaQCe/HvbnOvEPJyjfFrmN1ZR4ZMPcfMTgZaH6QQIMsS9Kk
 4X7RFptBlMUrsOi/IIHFOdGz6JOATLTuLKB+sNi0sga4tNzYQZnvZYKpySbykNt/qhlpN9m
 2GhhtQC00i2p8m4LQZtIchq7CW5lOPahB2AIqYhkP2inWc46iGs+vRKE07MafwuO4RGt9gy
 0RI3dJrCYEJYrXML1pzIA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TNBPRIlwunk=:Nsl6q2hLwYL/UQGmoy/mDT
 nJeEY3anUdcnRMg89CcfnQn78e6G0Gyc0oVud99TyvgqFlcXd6k4FNsiO4B35wvTAOFKOwSbF
 j9XMa3HTtStNcWOtJ8DUtja29Hl2V/cLObQAka/FWDxFpyJpS6pLc+TmmaTH2Fnpwwq032ktD
 DpxadmmYTOh5J8sxT5O4qDNDw/kUVan8bxlIvJsS0PBtDJpmhhxdBaEail1revilANxYSDsGv
 co8wnWFiZSFKL2K8rFDqmnt4Nw3r/dz6vqxIThJhYno2HR5PSKxjWsHAk8MGk/btb9h7xz6z+
 Dg5J7rm4dDhdvm4LdVxf3JOWpQbgjN+ju4qNlRPTRn0aB+zauWeQ2cAiea48st9hoZYtchwwU
 zobmBt0lksLNGetBv5g+S2tJX1e5fF6NuE1P02PAysh19jJ9V817wRFS6bzcDj/+fSOHk6/Ry
 ngmiSJD0cAD7lcYiUDhe7VURl68v3n6KAWqCiVuBra9bMP2/EhxnP9xIZG5U4kGAEAXufzzXm
 VBaAow2uTDxd5GVswv9/2fDh26MTtmGkikNEhkXzA8oXrykeLUmmFFeIMxgsRZvP5eTrj3Utm
 HsTRlXQz6AdN7mmavpGPHNOHs2Q8WFlVTECfnBY70ri0LEzrgqYXDJ/cjlFrW7GTd9qhnAjjf
 tuIeuWrNQeo2/PApJ8l+stvGPZfYcSkEf87UPXYMFYDvtOfZtrkPAsV4oz7diaOmu2RNCiyfk
 jrGR58sioE3IWAfT9PFH0f/b+JobE9C6xXwMtmq6cfNw1vtqEV2bBGM3xDwtwOshPISSCxaEn
 kIbtFEA7j4EAyvMpq+s6NsLg+cZ8XAx/LUsbR5SWvdMEZEBrGwyvEXeG402lbtNQ1l66Ok951
 koPkNlYD/HEYykIASRyQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--CjPGjgSPWBKyBoQi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2020 at 03:09:43PM +0000, Lee Jones wrote:
> On Wed, 02 Dec 2020, Jonathan Neusch=C3=A4fer wrote:
>=20
> > On Wed, Dec 02, 2020 at 01:05:20PM +0000, Lee Jones wrote:
> > > On Sun, 22 Nov 2020, Jonathan Neusch=C3=A4fer wrote:
> > [...]
> > > > +	/* Bail out if we encounter an unknown firmware version */
> > > > +	switch (version) {
> > > > +	case 0xd726: /* found in Kobo Aura */
> > >=20
> > > No magic numbers.
> > >=20
> > > Please submit a subsequent patch to define this.
> >=20
> > Will do.
> >=20
> > But I don't think I'll be able to give it a more meaningful name than
> > NTXEC_VERSION_D726. I don't have a good overview of which versions
> > appear in which devices. "0xd726 found in Kobo Aura" only means that;
> > I don't know if it's the only version used in the Kobo Aura, and I don't
> > know if the Kobo Aura is the only device where it is used.
>=20
> Defines are not set in stone.
>=20
> They can evolve over time as more is known.
>=20
> NTXEC_KOBO_AURA would be fine for now.

Alright.


Thanks,
Jonathan Neusch=C3=A4fer

--CjPGjgSPWBKyBoQi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl/HyrUACgkQCDBEmo7z
X9ujoRAAiSfqDRe/Gtnw9hmQ5U6LeACNBPYHEExRWA9+KkwWBO6oVYGD06v1QLp/
7M9dBhcudCM7OXobAwKgZWlnDOTgTct1TNehCOzq7ZyCUbz1oe5+QN+KY98RQNgK
2ZxEIJFrCoyWSBrPRH6qAiFDb3E28xIYJmZmX/EoHYOiVUfeo9DaaiLTZrIOapRg
jjUZ5SDM99aB7z2TGjdjpSyRee+t0jSNgvrdb+z+oJ0ODiKJmWYVvCtHWtiZ+30J
h5z31aKESIm2BaAxM6Xdv2m4OvWURx61gVCx51KVELcwGDtza2nz9osBrcLWqiWm
OVBszstZwniWDNHqEGx5D4jnYdzLE6YG2ll5O9E3fPzrx3Vr28xmabea8bLiw6gF
v1jDpZIy/Vx9vxz5+baXfPFLHBqLqNmsXHW0r4EAcNDyBy3B97Qq1R64nCBPKt7c
3wV+5ja9hykCjQLXAoH9TuATnTP7d5Ya4+njW6KP2p9p6PocSrG9mkKHlgucZGNZ
ZYGOndbFNw16IOyHhu5Vr8LnvND7qZiYbP1i16L3CVduulbnJGVdWF3v1iH8IHHD
yb67MJGHa+qDRI1AAsRt0KgM8Pd9sRmrqIxFDlOp0LOscg45FifdV8k5WjQ79hkT
s5oiVIYAZ0bHyKLggR/Q3yvBFG695uXZucUUZMKj9WyBTYZOsfQ=
=OnND
-----END PGP SIGNATURE-----

--CjPGjgSPWBKyBoQi--
