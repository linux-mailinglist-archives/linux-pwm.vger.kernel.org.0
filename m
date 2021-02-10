Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF7431626B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Feb 2021 10:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBJJhA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Feb 2021 04:37:00 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56877 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhBJJep (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Feb 2021 04:34:45 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8D315C2E;
        Wed, 10 Feb 2021 04:33:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Feb 2021 04:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=cxgVaZyeQcRV136PQAdY6FtdPMM
        ky7qQ3FT9Bt8v7KM=; b=HXz7ulgpuoMBPBZbWTIjoiowLkkhe9I22rr7o3oIHLf
        NqRGICRg9WR94TwgeY3rUB9sJxZ9fb9xy2wAzc/Er54iuDFNyu80bGUb2lvy+SZ+
        2T18X2VhB6MYSkwM+2BcU49WzlWW9GoterUXC6TEzOLypW6osA2F+5a3MNXgVqaT
        uenzLneJ7E6Y3TpLGWNyUP3+IQz3eoWFyt5l+LJYleAftmfYK6rHyFKOMyrq4wms
        UiEeHyHHvvmPy+VRVGSHvU8Cyg3GfTtdF9i9jVTRVnDe/g0r6+nB+fL7POl04mC6
        YYjL5momAoqPu3sW71oBPjQWoWaxunuws5KMqhy9fsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=cxgVaZ
        yeQcRV136PQAdY6FtdPMMky7qQ3FT9Bt8v7KM=; b=KBTC6L44sAcs8swG3EG4wW
        LjpubOk4Vbp257nkyA5Y5LRPf120xlrOgzVOUV3ejn9e47xyY2u3M3oIf0JmROgh
        bLJdTPPgS5RSHt6CQiC3uYqqzsb6elh/Pcr/tCH+w5aiwihqM/z9Vesk9svBpKNc
        AWmWd59G8+eKWxg/nBPVzr3n/1RmOeNW36bpmV11PUufTB0o3i2gQFKmWXcxzHe/
        Y49tlzToiX/3Zq6dlwNdH7JEoV0Boal3LtplZ33D7CFsPKy29EzSxgbjN/roE9NL
        z48t/MQ0jxeTb1ljCDJdgBRvT5XQvZoA2B6KVmjjmV4cgw+EHin0zvN5x1ORv9mw
        ==
X-ME-Sender: <xms:cKgjYKKyzT9yR4LmtZ-JKDnAmfm1tdTnvO6SkYXITVXVz7CAVcWCmQ>
    <xme:cKgjYCK3YGpKZuH5lkaQv4zV7DIXGAj-zFFIRCwQAqiHpFUWLqDlIAhgVsX5rkqjY
    uBWffzbkCn4yNuXYgc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrheejgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepuedtgfejueduheevgfevvdettddule
    ffgfffkeeltdffkeegudekjeeuveeigedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:cKgjYKvdbnYAEMXZTsuWYNynEP3QmooRrqG9ttjcZ-P1f0_Hs64R_g>
    <xmx:cKgjYPZv4_B_QgZRWFGDxsGXppHHu_nlVeIYhFJqaos4aS1F8F9zlw>
    <xmx:cKgjYBZ0ea4CiwI6XwIfIlNv1JVPp0R0D0z8TLR48s-SuHzu4g0jzw>
    <xmx:cagjYFE5I2cnN1TlE0TPb5RGU8D2Yp4KSr6_rjKLE3K_wplyS8XkTQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0DBE41080059;
        Wed, 10 Feb 2021 04:33:35 -0500 (EST)
Date:   Wed, 10 Feb 2021 10:33:33 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, wens@csie.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <20210210093333.twjnglabtcbecoku@gilmour>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203154628.infi5jnlofdrysvs@gilmour>
 <CAE=m61-oXn8CkzUpSxkuS-gLkxjwd8wSeL42Q5T+27_V89xgNw@mail.gmail.com>
 <20210205161158.gqinjayxcihtiofe@gilmour>
 <CAE=m6190zD55EL_VOmq=yKw471bxiRwZdjpVTyvNAAvofn9UPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zerufqrg326oioaz"
Content-Disposition: inline
In-Reply-To: <CAE=m6190zD55EL_VOmq=yKw471bxiRwZdjpVTyvNAAvofn9UPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zerufqrg326oioaz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 06, 2021 at 09:27:30PM +0800, =E7=8F=AD=E6=B6=9B wrote:
> Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B42=E6=9C=886=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:12=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Hi,
> >
> > On Thu, Feb 04, 2021 at 11:47:34AM +0800, =E7=8F=AD=E6=B6=9B wrote:
> > > Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B42=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > > Hi,
> > > >
> > > > On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> > > > > From: Ban Tao <fengzheng923@gmail.com>
> > > > >
> > > > > The Allwinner R818, A133, R329, V536 and V833 has a new PWM
> > controller
> > > > > IP compared to the older Allwinner SoCs.
> > > > >
> > > > > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> > > >
> > > > Thanks for your patch. There's a bunch of warnings reported by
> > > > checkpatch --strict, they should be addressed.
> > > >
> > > > > ---
> > > > > v1->v2:
> > > > > 1.delete unnecessary code.
> > > > > 2.using a named define for some constants.
> > > > > 3.Add comment in sun50i_pwm_config function.
> > > > > 4.using dev_err_probe() for error handling.
> > > > > 5.disable the clock after pwmchip_remove().
> > > > > ---
> > > > >  MAINTAINERS              |   6 +
> > > > >  drivers/pwm/Kconfig      |  11 ++
> > > > >  drivers/pwm/Makefile     |   1 +
> > > > >  drivers/pwm/pwm-sun50i.c | 348
> > +++++++++++++++++++++++++++++++++++++++
> > > > >  4 files changed, 366 insertions(+)
> > > > >  create mode 100644 drivers/pwm/pwm-sun50i.c
> > > > >
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index e73636b75f29..d33cf1b69b43 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -737,6 +737,12 @@ L:       linux-media@vger.kernel.org
> > > > >  S:   Maintained
> > > > >  F:   drivers/staging/media/sunxi/cedrus/
> > > > >
> > > > > +ALLWINNER PWM DRIVER
> > > > > +M:   Ban Tao <fengzheng923@gmail.com>
> > > > > +L:   linux-pwm@vger.kernel.org
> > > > > +S:   Maintained
> > > > > +F:   drivers/pwm/pwm-sun50i.c
> > > > > +
> > > > >  ALPHA PORT
> > > > >  M:   Richard Henderson <rth@twiddle.net>
> > > > >  M:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > > > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > > > index 9a4f66ae8070..17635a8f2ed3 100644
> > > > > --- a/drivers/pwm/Kconfig
> > > > > +++ b/drivers/pwm/Kconfig
> > > > > @@ -552,6 +552,17 @@ config PWM_SUN4I
> > > > >         To compile this driver as a module, choose M here: the mo=
dule
> > > > >         will be called pwm-sun4i.
> > > > >
> > > > > +config PWM_SUN50I
> > > > > +     tristate "Allwinner enhanced PWM support"
> > > > > +     depends on ARCH_SUNXI || COMPILE_TEST
> > > > > +     depends on HAS_IOMEM && COMMON_CLK
> > > > > +     help
> > > > > +       Enhanced PWM framework driver for Allwinner R818, A133, R=
329,
> > > > > +       V536 and V833 SoCs.
> > > > > +
> > > > > +       To compile this driver as a module, choose M here: the mo=
dule
> > > > > +       will be called pwm-sun50i.
> > > > > +
> > > >
> > > > Even though it's unfortunate, there's a bunch of other SoCs part of=
 the
> > > > sun50i family that are supported by the sun4i driver.
> > > >
> > > > Which SoC introduced that new design? It's usually the name we pick=
 up
> > > > then.
> > > >
> > >
> > > In fact, some SoCs has not been supported by the sun4i driver, such as
> > v833,
> > > v536, r818, a133 and r329.
> > > v833 and v536 are part of the sun8i family, but r818, a133 and r329 a=
re
> > > part of the sun50i family.
> >
> > Indeed, I missed that sorry.
> >
> > > So,I'm confused, how do choose the name of this driver?
> >
> > Just go for the earliest SoC that introduced that design. What was the
> > first SoC to use it?
> >
>
> The V536 SOC first used this design, so, we should use the name
> "sun8i-pwm.c"?

sun8i-pwm would be too generic, but sun8i-v536-pwm would be great then

>=20
> > > > > +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {
> > > > > +     .npwm =3D 9,
> > > > > +};
> > > > > +
> > > > > +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D {
> > > > > +     .npwm =3D 16,
> > > > > +};
> > > > > +
> > > > > +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
> > > > > +     {
> > > > > +             .compatible =3D "allwinner,sun8i-v833-pwm",
> > > > > +             .data =3D &sun8i_pwm_data_c9,
> > > > > +     }, {
> > > > > +             .compatible =3D "allwinner,sun8i-v536-pwm",
> > > > > +             .data =3D &sun8i_pwm_data_c9,
> > > > > +     }, {
> > > > > +             .compatible =3D "allwinner,sun50i-r818-pwm",
> > > > > +             .data =3D &sun50i_pwm_data_c16,
> > > > > +     }, {
> > > > > +             .compatible =3D "allwinner,sun50i-a133-pwm",
> > > > > +             .data =3D &sun50i_pwm_data_c16,
> > > > > +     }, {
> > > > > +             .compatible =3D "allwinner,sun50i-r329-pwm",
> > > > > +             .data =3D &sun8i_pwm_data_c9,
> > > > > +     }, {
> > > > > +             /* sentinel */
> > > > > +     },
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);
> > > >
> > > > What are the differences between all these SoCs? If there's none
> > between
> > > > the v833, v536 and R329, and between the r818 and the A133, you sho=
uld
> > > > use the same compatible.
> > >
> > > Compared with the sun4i driver, this patch is a completely different =
PWM
> > IP
> > > controller.
> >
> > Sure, I didn't mean to compare it to sun4i. What I meant was that as far
> > as these struct goes, the A133 and the R818 look to have the same PWM
> > controller. Just like the v833, v536 and R329.
> >
> > If the PWM controllers are indeed identical across those SoCs, you can
> > just use two compatibles, one for the PWM with 9 channels (again, the
> > earliest SoC among the V833, v536 and r329), and one for the PWM with 16
> > channels.
> >
> Ok i see what you mean.
>  static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
>         {
>                 .compatible =3D "allwinner,sun8i-v536-pwm",
>                 .data =3D &sun8i_pwm_data_c9,
>         }, {
>                 .compatible =3D "allwinner,sun50i-r818-pwm",
>                 .data =3D &sun50i_pwm_data_c16,
>         }, {
>                 /* sentinel */
>         },
> };
> is this OK? Just write two SoC for the " compatible "=EF=BC=9F

Yes, this is perfect :)

Maxime

--zerufqrg326oioaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYCOobQAKCRDj7w1vZxhR
xSPcAQCkk2tN5ozZ9vemaaEu2p0nHHReG9lkzoBaC3FGwGPchgEAhIwn+ZApgFIm
X4u4MA62tJDDEqywskzfZn18ROi5xgM=
=8JMs
-----END PGP SIGNATURE-----

--zerufqrg326oioaz--
