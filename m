Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980A83114EB
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Feb 2021 23:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhBEWS0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Feb 2021 17:18:26 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:44351 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232710AbhBEOeG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Feb 2021 09:34:06 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A71127DA;
        Fri,  5 Feb 2021 11:12:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 05 Feb 2021 11:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=P
        RZqKf7lsxMpUiRCiHe2f26y9RuSEPh83D4t+a5YnDI=; b=O9WE39yuJimMdhmEK
        Oh7kP+0ctQ0BbS0Gzg4CCtNU/EhOTAM6VDNVnPpgeYLyO8QEZKBGETWjAWIKRz5u
        C8b+PXuwuFo9hCGjnG90rL66U93CxIa7kVQKdd1kkCwuYrKciEY9kwFrg9I9dJ7d
        70STTT7wbu122UYlDN3l45xNpJRZ4Fixo4uDcKbAXnjE7/Dx58sauRbq54dWPHxk
        1tFe00BJHBCnYq3i94K/Y4jM9GdvSXm5JoN7X1K1wjiIfLHniU5kHMgYlA6Hvgrl
        F6Yn6qgkaXHMHg0sk7ALhwNH7wJKfiiVubWshmgwBM5xTXwIg3EH8iST+4BaELTl
        FAGrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=PRZqKf7lsxMpUiRCiHe2f26y9RuSEPh83D4t+a5Yn
        DI=; b=HvZ4TyXYoBJjChzAjp3LsoVIFGD5X20D5V/Q8mPiaKvWHBr+VF7EOMRyW
        0MTbwiPPFOWxysTHf0lsgX+dT7i49w4BDjrWDbJjAQb8ECqNXDL9RjBKf0iN4e+g
        vvvNoUXUGfL5gDimuQwOX6Aer4FoKo1wh8TELN9wkeVQh7+Bvv3mShB3GLG/3Cdg
        H5bMTkPWZctNEh70RvxZNO5BC82SSL/TuVtDz2OQspGctBzPBjJI2B6e3dMv1sVz
        3PWOdRxkcgZEfo9jCehUFXeowOqIiSfe1mbhRUMGOPdeFh0bJvvgd1gZl0FG8sLS
        rlqXxXXg9CCoAFct6laH5k2S7GExg==
X-ME-Sender: <xms:UG4dYFwmsp1RaDLckf2VZIU-JwkMHrvybMRk1-7W1bKvZampdLjPCw>
    <xme:UG4dYFN-lsDLS8uvU77R3udQ7S4ARSz2vHg4jv8oTEx0Qp2kcxYRkFIP6WvL5cJ0k
    oVJu59QP20alFCQiGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrgeeigdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjgesthhqre
    dttddtjeenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpefgjeejkeejtddtteehtdefleetfe
    ffuddvvedvhfdtieduteeljeegleeffeeuvdenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UG4dYMNQO0U0KI1IxfR8IgNIw_avqnycneeuA7m_S7058DnF3FOJkQ>
    <xmx:UG4dYPSBPxQIQI4849S5dE9nJB2k6lMebff34WHqaweaPsNTpybeuQ>
    <xmx:UG4dYGCWuiH4HEdCR1a_Ifw98FBxQ5qGqERdgNfz9XEQJ6S_yeLdFw>
    <xmx:UW4dYBdSqng_4wvBTrT9OO2eSjIJ1hL3ntUY0TrsiK3smG1qFJFqQg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7848324005A;
        Fri,  5 Feb 2021 11:12:00 -0500 (EST)
Date:   Fri, 5 Feb 2021 17:11:58 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?54+t5rab?= <fengzheng923@gmail.com>
Cc:     thierry.reding@gmail.com,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, wens@csie.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Message-ID: <20210205161158.gqinjayxcihtiofe@gilmour>
References: <20210203125317.1975-1-fengzheng923@gmail.com>
 <20210203154628.infi5jnlofdrysvs@gilmour>
 <CAE=m61-oXn8CkzUpSxkuS-gLkxjwd8wSeL42Q5T+27_V89xgNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAE=m61-oXn8CkzUpSxkuS-gLkxjwd8wSeL42Q5T+27_V89xgNw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Thu, Feb 04, 2021 at 11:47:34AM +0800, =E7=8F=AD=E6=B6=9B wrote:
> Maxime Ripard <maxime@cerno.tech> =E4=BA=8E2021=E5=B9=B42=E6=9C=883=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:46=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Hi,
> >
> > On Wed, Feb 03, 2021 at 08:53:17PM +0800, Ban Tao wrote:
> > > From: Ban Tao <fengzheng923@gmail.com>
> > >
> > > The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
> > > IP compared to the older Allwinner SoCs.
> > >
> > > Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> >
> > Thanks for your patch. There's a bunch of warnings reported by
> > checkpatch --strict, they should be addressed.
> >
> > > ---
> > > v1->v2:
> > > 1.delete unnecessary code.
> > > 2.using a named define for some constants.
> > > 3.Add comment in sun50i_pwm_config function.
> > > 4.using dev_err_probe() for error handling.
> > > 5.disable the clock after pwmchip_remove().
> > > ---
> > >  MAINTAINERS              |   6 +
> > >  drivers/pwm/Kconfig      |  11 ++
> > >  drivers/pwm/Makefile     |   1 +
> > >  drivers/pwm/pwm-sun50i.c | 348 +++++++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 366 insertions(+)
> > >  create mode 100644 drivers/pwm/pwm-sun50i.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index e73636b75f29..d33cf1b69b43 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -737,6 +737,12 @@ L:       linux-media@vger.kernel.org
> > >  S:   Maintained
> > >  F:   drivers/staging/media/sunxi/cedrus/
> > >
> > > +ALLWINNER PWM DRIVER
> > > +M:   Ban Tao <fengzheng923@gmail.com>
> > > +L:   linux-pwm@vger.kernel.org
> > > +S:   Maintained
> > > +F:   drivers/pwm/pwm-sun50i.c
> > > +
> > >  ALPHA PORT
> > >  M:   Richard Henderson <rth@twiddle.net>
> > >  M:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 9a4f66ae8070..17635a8f2ed3 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -552,6 +552,17 @@ config PWM_SUN4I
> > >         To compile this driver as a module, choose M here: the module
> > >         will be called pwm-sun4i.
> > >
> > > +config PWM_SUN50I
> > > +     tristate "Allwinner enhanced PWM support"
> > > +     depends on ARCH_SUNXI || COMPILE_TEST
> > > +     depends on HAS_IOMEM && COMMON_CLK
> > > +     help
> > > +       Enhanced PWM framework driver for Allwinner R818, A133, R329,
> > > +       V536 and V833 SoCs.
> > > +
> > > +       To compile this driver as a module, choose M here: the module
> > > +       will be called pwm-sun50i.
> > > +
> >
> > Even though it's unfortunate, there's a bunch of other SoCs part of the
> > sun50i family that are supported by the sun4i driver.
> >
> > Which SoC introduced that new design? It's usually the name we pick up
> > then.
> >
>=20
> In fact, some SoCs has not been supported by the sun4i driver, such as v8=
33,
> v536, r818, a133 and r329.
> v833 and v536 are part of the sun8i family, but r818, a133 and r329 are
> part of the sun50i family.

Indeed, I missed that sorry.=20

> So,I'm confused, how do choose the name of this driver?

Just go for the earliest SoC that introduced that design. What was the
first SoC to use it?

> > > +static const struct sun50i_pwm_data sun8i_pwm_data_c9 =3D {
> > > +     .npwm =3D 9,
> > > +};
> > > +
> > > +static const struct sun50i_pwm_data sun50i_pwm_data_c16 =3D {
> > > +     .npwm =3D 16,
> > > +};
> > > +
> > > +static const struct of_device_id sun50i_pwm_dt_ids[] =3D {
> > > +     {
> > > +             .compatible =3D "allwinner,sun8i-v833-pwm",
> > > +             .data =3D &sun8i_pwm_data_c9,
> > > +     }, {
> > > +             .compatible =3D "allwinner,sun8i-v536-pwm",
> > > +             .data =3D &sun8i_pwm_data_c9,
> > > +     }, {
> > > +             .compatible =3D "allwinner,sun50i-r818-pwm",
> > > +             .data =3D &sun50i_pwm_data_c16,
> > > +     }, {
> > > +             .compatible =3D "allwinner,sun50i-a133-pwm",
> > > +             .data =3D &sun50i_pwm_data_c16,
> > > +     }, {
> > > +             .compatible =3D "allwinner,sun50i-r329-pwm",
> > > +             .data =3D &sun8i_pwm_data_c9,
> > > +     }, {
> > > +             /* sentinel */
> > > +     },
> > > +};
> > > +MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);
> >
> > What are the differences between all these SoCs? If there's none between
> > the v833, v536 and R329, and between the r818 and the A133, you should
> > use the same compatible.
>=20
> Compared with the sun4i driver, this patch is a completely different PWM =
IP
> controller.

Sure, I didn't mean to compare it to sun4i. What I meant was that as far
as these struct goes, the A133 and the R818 look to have the same PWM
controller. Just like the v833, v536 and R329.

If the PWM controllers are indeed identical across those SoCs, you can
just use two compatibles, one for the PWM with 9 channels (again, the
earliest SoC among the V833, v536 and r329), and one for the PWM with 16
channels.

None of those SoCs are supported at the moment in Linux though, so it
would make more sense to support them first before adding a new driver
for those SoCs, it's gonna be dead code otherwise.

Maxime
