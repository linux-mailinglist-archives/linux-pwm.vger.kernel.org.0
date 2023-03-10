Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBEE6B53E2
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Mar 2023 23:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCJWJ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Mar 2023 17:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjCJWJm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Mar 2023 17:09:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F52BAEFF
        for <linux-pwm@vger.kernel.org>; Fri, 10 Mar 2023 14:09:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1paka5-00043Y-LX; Fri, 10 Mar 2023 22:47:17 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paka1-003GHn-RB; Fri, 10 Mar 2023 22:47:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1paka1-003tZx-3f; Fri, 10 Mar 2023 22:47:13 +0100
Date:   Fri, 10 Mar 2023 22:46:58 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     fnkl.kernel@gmail.com
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/5] pwm: Add Apple PWM controller
Message-ID: <20230310214658.424vui3frynit437@pengutronix.de>
References: <20230214-fpwm-v8-0-65518a0d4944@gmail.com>
 <20230214-fpwm-v8-2-65518a0d4944@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wbrnvcvhbc5cviao"
Content-Disposition: inline
In-Reply-To: <20230214-fpwm-v8-2-65518a0d4944@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wbrnvcvhbc5cviao
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sascha,

On Fri, Mar 10, 2023 at 07:44:08PM +0100, Sasha Finkelstein via B4 Relay wr=
ote:
> +static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			   const struct pwm_state *state)
> +{
> +	struct apple_pwm *fpwm;
> +
> +	if (state->polarity =3D=3D PWM_POLARITY_INVERSED)
> +		return -EINVAL;
> +
> +	fpwm =3D to_apple_pwm(chip);
> +	if (state->enabled) {
> +		u64 on_cycles, off_cycles;
> +
> +		on_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						state->duty_cycle, NSEC_PER_SEC);
> +		if (on_cycles > 0xFFFFFFFF)
> +			on_cycles =3D 0xFFFFFFFF;
> +
> +		off_cycles =3D mul_u64_u64_div_u64(fpwm->clkrate,
> +						 state->period, NSEC_PER_SEC) - on_cycles;
> +		if (off_cycles > 0xFFFFFFFF)
> +			return -ERANGE;

This is still wrong and needs clamping, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wbrnvcvhbc5cviao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQLpU8ACgkQwfwUeK3K
7Al6iAf/brzDkPdu7qhixSZXlHEcf+6cCEGjYdch6SwKLkspprLcOrBvHsvEa8ay
TYG02baQpF4eNbZdPBbBv2b4VOqDOJ92H8Bx7IvfhCQy+fdZkSCiSeXHPteY91Hc
A56UkrBNesv68qEdfX6e4vtVYZbexHFqgaeTZMPfr8dsqt0ms0RyyMMuT/DhrpPs
sBTZd7V0IybwXTCEomXUMbxOA1mzWfU05rEz4bPUOS14N9TL8i1Mom8VsZrMD5UH
bO6F9Y13HCXq8xUgLKZnoxqEEm1E2r6ZunUTSb/RenSaxGE2xx9NlHlTNeyKJR2V
FYA1FefcQgl8RIZvCowtSH9Y+Lkcvg==
=MgXN
-----END PGP SIGNATURE-----

--wbrnvcvhbc5cviao--
