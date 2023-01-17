Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2C670C2C
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Jan 2023 23:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjAQWxT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Jan 2023 17:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjAQWwv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Jan 2023 17:52:51 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BDB13D5F
        for <linux-pwm@vger.kernel.org>; Tue, 17 Jan 2023 13:43:50 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtk7-00048K-3O; Tue, 17 Jan 2023 22:43:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtk5-006lhK-4N; Tue, 17 Jan 2023 22:43:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pHtk4-00DhUn-CH; Tue, 17 Jan 2023 22:43:40 +0100
Date:   Tue, 17 Jan 2023 22:43:37 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: stm32: enforce settings for pwm capture
Message-ID: <20230117214337.vgvduhiltzczra6l@pengutronix.de>
References: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
 <20221213105128.74skjowy5v7dlaf6@pengutronix.de>
 <2ab70bb7-dbf1-5f19-8118-6cfd9b5dc278@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xnrlbqkomeenntxh"
Content-Disposition: inline
In-Reply-To: <2ab70bb7-dbf1-5f19-8118-6cfd9b5dc278@foss.st.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xnrlbqkomeenntxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Dec 14, 2022 at 04:09:08PM +0100, Olivier MOYSAN wrote:
> Hello Uwe,
>=20
> On 12/13/22 11:51, Uwe Kleine-K=F6nig wrote:
> > Hello Olivier,
> >=20
> > [Cc: +=3D William Breathitt Gray, linux-iio@v.k.o]
> >=20
> > On Tue, Dec 13, 2022 at 11:27:07AM +0100, Olivier Moysan wrote:
> > > The PWM capture assumes that the input selector is set to default
> > > input and that the slave mode is disabled. Force reset state for
> > > TISEL and SMCR registers to match this requirement.
> >=20
> > When does the problem occur? Only if the bootloader changed that
> > setting? Regarding the urgency: With the current knowledge I'd say this
> > patch is material for the next merge window. Do you recommend
> > backporting to stable?
> >=20
>=20
> Yes, the PWM may not be in the default expected state, if the configurati=
on
> has been changed in the bootloader. This is not an actual case today, so
> this patch can wait the next merge window and there is no
> urgency to have it in stable.

Then I'd drop the fixes line.

> > > Note that slave mode disabling is not a pre-requisite by itself
> > > for capture mode, as hardware supports it for PWM capture.
> > > However, the current implementation of the driver does not
> > > allow slave mode for PWM capture. Setting slave mode for PWM
> > > capture results in wrong capture values.
> >=20
> > What is your usecase for PWM capture support? I didn't double check, but
> > I think you're the first contributor to PWM capture since 2018 (i.e. the
> > commit you're fixing).
> >=20
> > Did you check if the counter subsystem would solve your problems? If it
> > doesn't I assume William would like to hear about that.
> >=20
> > Looking at drivers/counter/stm32-timer-cnt.c it does seem to work in
> > slave mode, TISEL isn't touched though. So maybe this driver needs a
> > similar fix?

I want to come back to this question. I only checked lightly, but I
guess the counter patch needs the same patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xnrlbqkomeenntxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPHFoYACgkQwfwUeK3K
7Ana4wf/cy8/TezZWsDyRxH3u4x4x5iGUiJ52kMloAXFi4rQ9qrcH2Aclx/4v9Qr
weZ6nfN0VUu6UDQ7+U3dBoGnB79L2l7X6/nyJzNMGgF0U+yRHFTggARzfsM6xkdA
dtLJdy56dsYka+0eY2OySDmKIKDAnIO2mzbvsyls9WwgMIHO++ZGnO/L2Y3aiy+f
H4wQJyu+RZ/w4HJRVcJuJOf1AJrnbJn9gTYm/XhMPylTurSuFk2QVibWKk/IRDCW
JTcvM7Jwfhqv6TiAyZ/25rD0iOCllNWXQg69Aadl4UWHz1sMI9srUi7NkU2Innue
pmFgsVTv1k4F9mc1rcf+Awo3cOXDtg==
=TCRH
-----END PGP SIGNATURE-----

--xnrlbqkomeenntxh--
