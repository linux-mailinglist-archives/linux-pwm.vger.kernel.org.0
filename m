Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093723734A6
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 07:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhEEFVG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 01:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhEEFVF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 May 2021 01:21:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31BAC061574
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 22:20:09 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1le9x1-0004xm-Cn; Wed, 05 May 2021 07:19:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1le9x0-0003zj-Vw; Wed, 05 May 2021 07:19:58 +0200
Date:   Wed, 5 May 2021 07:19:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Martin Botka <martin.botka1@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6 2/4] leds: Add driver for Qualcomm LPG
Message-ID: <20210505051958.e5lvwfxuo2skdu2q@pengutronix.de>
References: <20201021201224.3430546-1-bjorn.andersson@linaro.org>
 <20201021201224.3430546-3-bjorn.andersson@linaro.org>
 <20210505051534.id36dvocqfqg3jqc@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yysvbptvjenjm4no"
Content-Disposition: inline
In-Reply-To: <20210505051534.id36dvocqfqg3jqc@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yysvbptvjenjm4no
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

another feedback that only came to me after hitting "Send": It might be
sensible to split the patch. In the first part add the LED stuff and in
the second the PWM stuff.

It would also be good if the PWM code could live in drivers/pwm.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yysvbptvjenjm4no
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCSKvsACgkQwfwUeK3K
7AnQ6Af8CwOE61uTM3weEDjryyHoZKRK644ASB7dOVPgJftKvZPzv+DS5L1l403C
mKRbcoRqXZB/HfBxjQHH1H+0utzVxcSszp8Z0mmVJ9EgOg3THU9stnOkyKgV9Lqs
yfZgrWu0/78gOK506cUgmRd3L2zSV/+0Zm8TaGRmXnqn7BmpV+WxW7QWKwGptJAA
//ZrUDMOeJ9+MY/2O+Zgd5i4lLCAnkmb/sly4nAIItvDL8iDeMFLY36ZG186Of/3
tsaueeml3rlY3XYR5a859wqgrNyxxPBx1kXnEv+a6zc+0sBFS+dL+5RPNAavKnsL
f3hZZZ9i6pcwk45xjLMnQdsSC2VSFQ==
=AFmy
-----END PGP SIGNATURE-----

--yysvbptvjenjm4no--
