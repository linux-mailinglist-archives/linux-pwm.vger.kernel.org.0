Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C697681F8
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Jul 2023 23:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjG2Vh0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Jul 2023 17:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG2VhZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Jul 2023 17:37:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F3326A9
        for <linux-pwm@vger.kernel.org>; Sat, 29 Jul 2023 14:37:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPrck-00008X-6d; Sat, 29 Jul 2023 23:37:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPrci-00315D-Fj; Sat, 29 Jul 2023 23:37:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPrch-008pjT-OP; Sat, 29 Jul 2023 23:37:15 +0200
Date:   Sat, 29 Jul 2023 23:37:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 18/18] gpio: mvebu: Make use of devm_pwmchip_alloc()
 function
Message-ID: <20230729213712.mkfqgk6cage6yqsd@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
 <20230718181849.3947851-19-u.kleine-koenig@pengutronix.de>
 <CAMRc=MfGWvAGYAh8q7mOenGDMpKS3q7UK7-Yxw5bn1avhoQ-UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e67n3kcjaaudhirc"
Content-Disposition: inline
In-Reply-To: <CAMRc=MfGWvAGYAh8q7mOenGDMpKS3q7UK7-Yxw5bn1avhoQ-UQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--e67n3kcjaaudhirc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bartosz,

On Sat, Jul 29, 2023 at 04:09:40PM +0200, Bartosz Golaszewski wrote:
> Looks good to me (although I have my reservations about the concept of
> foo_alloc() for subsystems in the kernel...).

Wolfram's EOSS talk[1] mentioned "__cleanup__ + kref as suggested by Bartos=
z?
Paradigm shift, probably looong way to go". I guess that's what you'd
prefer? Do you have a link for me to read about this?

> How do you want this to go upstream?

I haven't thought about that yet. I first will have to convince
Thierry that this is a good idea I guess. This version will not be
merged for sure.

Best regards
Uwe

[1] https://static.sched.com/hosted_files/eoss2023/e3/LifecycleIssues_Wolfr=
amSang_2023.pdf

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--e67n3kcjaaudhirc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTFhogACgkQj4D7WH0S
/k4Bzgf8DtYV4R5X7URkPapzSd7lwfpZoroMiDZnejnmpO+bnNwRKlapEo+seuwc
mC/zd0uhGGkzkXxpiY4iQ4A0VwZgt7G64GdphGsLyOikPtiR3u2DP79OAwudRP49
MlGJHnVcT3l8o3NdmCgovI9uLsQJpi04/aaRJQ9LtNcl2Sfr6jyqndRIyC0MiYC7
cVlz3Ayh5w4yL5prMP7gcw+Hc4v5/2jutdXYki8STgACm2I5lWlifyCmu0rBC0g5
iy3yOYdboSiR69eshdAx6pX44H77ncTAZmr0S7T3vUJmUnTEHqFz5T50BIw0x7Sj
Xk4BLmOGi6Te0DqrtvdKg4yz6jpPCQ==
=RhDt
-----END PGP SIGNATURE-----

--e67n3kcjaaudhirc--
