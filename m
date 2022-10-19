Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092CD603AC4
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Oct 2022 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiJSHjh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Oct 2022 03:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJSHje (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Oct 2022 03:39:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F71D10B
        for <linux-pwm@vger.kernel.org>; Wed, 19 Oct 2022 00:39:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3fn-0005es-KK; Wed, 19 Oct 2022 09:39:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3fm-0003yv-UY; Wed, 19 Oct 2022 09:39:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3fl-00918f-Pu; Wed, 19 Oct 2022 09:39:29 +0200
Date:   Wed, 19 Oct 2022 09:39:29 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 4/5] pwm: pxa: Wait for final PWM period to finish
Message-ID: <20221019073929.3abj6ohhcreifyso@pengutronix.de>
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-5-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4n23ogamoew7lsb5"
Content-Disposition: inline
In-Reply-To: <20221003015546.202308-5-doug@schmorgal.com>
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


--4n23ogamoew7lsb5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 06:55:45PM -0700, Doug Brown wrote:
> If the clock is turned on too quickly after being turned off, it won't
> actually turn back on. Work around this problem by waiting for the final
> period to complete when disabling the PWM. The delay logic is borrowed
> from the pwm-sun4i driver.
>=20
> To avoid unnecessary delays, skip the whole config process if the PWM is
> already disabled and staying disabled.

I wonder if there is some documentation available about this issue. This
feels like a workaround without knowledge about the details and so might
break at the next opportunity.

> [...]
> @@ -122,6 +127,18 @@ static int pxa_pwm_apply(struct pwm_chip *chip, stru=
ct pwm_device *pwm,
>  	if (!state->enabled && pwm->state.enabled)
>  		clk_disable_unprepare(pc->clk);
> =20
> +	if (state->enabled)
> +		return 0;
> +
> +	/* Wait for the final PWM period to finish. This prevents it from
> +	 * being re-enabled too quickly (which can fail silently).
> +	 */

Please stick to the usual comment style. i.e. put the /* on a line for
itself.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--4n23ogamoew7lsb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNPqa4ACgkQwfwUeK3K
7Am8CAgAi8je4Hahx9fvqz//mh9fkYDvIkxfD6mRWhPpZMw5dS8A78gcX1FVYwtX
UhpCSHqMLJnusfl3oIu1rjKORKDmz7UlC6x09JfPhMqK7MsegKrVRevLrixW+Im6
VK79xO850bnwPTGTpEZzsebQcgVy/T1NYa7MpY5WJCa47B8CTlEW/CulhKb4yl/2
e8YAD5I+6KKK2t7TA/HN3Z3hYILl8LVzNNKPnKzmVpREmGt219zRv78mBKCqTtF3
51qa5pq24INHzRNy6HJDX5BCno31fQ76l3ro0Qwnmz+nh1024W/DlOR8J908SArJ
99hca/gpeqQiZ5jfit+qKQTadhjNMQ==
=bfc+
-----END PGP SIGNATURE-----

--4n23ogamoew7lsb5--
