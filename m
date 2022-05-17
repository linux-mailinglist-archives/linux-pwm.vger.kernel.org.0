Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3EF52A563
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349411AbiEQOyA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349504AbiEQOx5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:53:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5BB25EBC
        for <linux-pwm@vger.kernel.org>; Tue, 17 May 2022 07:53:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqyZt-0003hT-Iv; Tue, 17 May 2022 16:53:37 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqyZs-002tOA-IM; Tue, 17 May 2022 16:53:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nqyZq-00AK4E-AN; Tue, 17 May 2022 16:53:34 +0200
Date:   Tue, 17 May 2022 16:53:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
Message-ID: <20220517145331.7ffab4pyjwrh5lkg@pengutronix.de>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
 <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lzgyb2mlekugipiz"
Content-Disposition: inline
In-Reply-To: <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lzgyb2mlekugipiz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 17, 2022 at 04:26:20PM +0200, Alexander Stein wrote:
> This adds the enable attribute which is used to differentiate if PWM duty
> means to switch off regulator and PWM or to keep them enabled but
> at inactive PWM output level.
>=20
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/hwmon/pwm-fan.rst | 10 ++++
>  drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++----
>  2 files changed, 95 insertions(+), 10 deletions(-)
>=20
> diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pwm-fa=
n.rst
> index 82fe96742fee..0083480068d1 100644
> --- a/Documentation/hwmon/pwm-fan.rst
> +++ b/Documentation/hwmon/pwm-fan.rst
> @@ -18,3 +18,13 @@ the hwmon's sysfs interface.
> =20
>  The fan rotation speed returned via the optional 'fan1_input' is extrapo=
lated
>  from the sampled interrupts from the tachometer signal within 1 second.
> +
> +The driver provides the following sensor accesses in sysfs:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +fan1_input	ro	fan tachometer speed in RPM
> +pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=3D0
> +			0=3Dswitch off regulator and disable PWM
> +			1=3Dkeep regulator enabled and set PWM to inactive level

Is the pwm1_enable supposed to be set to 0 if that only does the right
thing if the PWM emits low after pwm_disable()? The question I raised in
v2 about "what is the meaning of disable?" hasn't evolved, has it?

I still think it's unfortunate, that "pwm1_enable" has an effect on the
regulator.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lzgyb2mlekugipiz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKDtugACgkQwfwUeK3K
7AmkAAf+Jg/NaHTE6D0cI+VGke8kConLhaiJOsAMqb3AXb4VV0yf/CA2gfogVhP9
d1RXpe/g5iy70RWHoDnmLmIB7dHZgek/KglAiJBBYK+6CvNFC6NhvL3roX+itqg/
Nq0LLZwyJsbpcHVyMnfVq1xckPDwv1NLGsffPQWRJO8ume2VaHkCvcZQ/ujr7ODA
Uqw6s4N3D73vGIQm7WICurWuV+ITu9I7uLtCFK22REET614NEkFxKZgG2n01ogbF
q7QdWe4Y1l+IjDtxf5Jf21pWM3VXsyzk+LNU40h+gzOjMxkwmQGJXmP/tsMH0Rbi
aiT7lAub/OJwffO8MFX32QC3mXWx/A==
=MXzg
-----END PGP SIGNATURE-----

--lzgyb2mlekugipiz--
