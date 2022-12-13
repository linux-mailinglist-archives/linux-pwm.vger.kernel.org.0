Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCF264B397
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Dec 2022 11:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiLMKvn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Dec 2022 05:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiLMKvk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Dec 2022 05:51:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D3C1CB23
        for <linux-pwm@vger.kernel.org>; Tue, 13 Dec 2022 02:51:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p52sk-0007zF-Kv; Tue, 13 Dec 2022 11:51:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p52si-004E2H-Ak; Tue, 13 Dec 2022 11:51:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p52si-004jdr-Dr; Tue, 13 Dec 2022 11:51:28 +0100
Date:   Tue, 13 Dec 2022 11:51:28 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
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
Message-ID: <20221213105128.74skjowy5v7dlaf6@pengutronix.de>
References: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ityz2bai4hbhs2hn"
Content-Disposition: inline
In-Reply-To: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ityz2bai4hbhs2hn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Olivier,

[Cc: +=3D William Breathitt Gray, linux-iio@v.k.o]

On Tue, Dec 13, 2022 at 11:27:07AM +0100, Olivier Moysan wrote:
> The PWM capture assumes that the input selector is set to default
> input and that the slave mode is disabled. Force reset state for
> TISEL and SMCR registers to match this requirement.

When does the problem occur? Only if the bootloader changed that
setting? Regarding the urgency: With the current knowledge I'd say this
patch is material for the next merge window. Do you recommend
backporting to stable?

> Note that slave mode disabling is not a pre-requisite by itself
> for capture mode, as hardware supports it for PWM capture.
> However, the current implementation of the driver does not
> allow slave mode for PWM capture. Setting slave mode for PWM
> capture results in wrong capture values.

What is your usecase for PWM capture support? I didn't double check, but
I think you're the first contributor to PWM capture since 2018 (i.e. the
commit you're fixing).

Did you check if the counter subsystem would solve your problems? If it
doesn't I assume William would like to hear about that.

Looking at drivers/counter/stm32-timer-cnt.c it does seem to work in
slave mode, TISEL isn't touched though. So maybe this driver needs a
similar fix?

Apart from that the change looks reasonable:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ityz2bai4hbhs2hn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmOYWS0ACgkQwfwUeK3K
7AkZ4gf/aHuApfMQQDwyeI0LfKUOjRO8sK5UYlF3Qujm7oDFR7lwKxUzAhHeYh8S
e241Q+8oWro/WfUnm3Sm3ZSiDYo/VZZzrdccndO5d5pf/UFqXdKuy8bRxtpMBzAO
Ea5Qjm1gUlFIykSnP8kzHR0NKr2nLcp2YioeL6334HKM0SYZit/j7u2Q2T3Q3pUt
+xnuyTHq6NIJsmAWXS9kxbOrw1hsDI0GgFEDJKuGqNlLIQmsc63DnE6LiudBoEXo
+5v7GneAAlceYjMReIJeBZLuJH39VRhcUYyOV98HGoPCQpYxvy5Vh6xkvXbkA5pj
HrYuDwX7hX2dXtxtAf7uUdWTAIcoPw==
=4QWU
-----END PGP SIGNATURE-----

--ityz2bai4hbhs2hn--
