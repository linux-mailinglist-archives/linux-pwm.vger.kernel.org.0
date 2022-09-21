Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1A45C051D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Sep 2022 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiIURKG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Sep 2022 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIURKF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Sep 2022 13:10:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A84F422FC
        for <linux-pwm@vger.kernel.org>; Wed, 21 Sep 2022 10:10:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ob3EY-000315-Kj; Wed, 21 Sep 2022 19:10:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ob3EY-0026FX-QO; Wed, 21 Sep 2022 19:10:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ob3EV-002VW5-T3; Wed, 21 Sep 2022 19:09:59 +0200
Date:   Wed, 21 Sep 2022 19:09:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Maxim Schwalm <maxim.schwalm@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-tegra@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <20220921170955.4ubpzbruxst2vkiy@pengutronix.de>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <524ca143-e9d4-2a79-3e9e-c8b9ffc9f513@gmail.com>
 <CAPVz0n1Xy=feSqw7_bvNw17=xVGnk2yhAMFmyfddU128dU+5qQ@mail.gmail.com>
 <20220921133222.bzqnjv5sodynqseg@pengutronix.de>
 <CAPVz0n19V5Lx889GO7wRzuvPAdBeVE8vXsMzQ-6EGyp4DFGD5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u5srxwzvzyi72pbi"
Content-Disposition: inline
In-Reply-To: <CAPVz0n19V5Lx889GO7wRzuvPAdBeVE8vXsMzQ-6EGyp4DFGD5w@mail.gmail.com>
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


--u5srxwzvzyi72pbi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2022 at 05:22:17PM +0300, Svyatoslav Ryhel wrote:
> According to clk tree Maxim sent me, pwm's parent is already pll_p, I have
> checked my older logs and it is true for me as well. I can take a fresh c=
lk

> log not sooner than tomorrow. I enclose Maxim clk tree from same device
> trace is (TF700T).

=46rom the below clk tree:
>           pwm                         1        1        0    48000000    =
      0     0  50000         Y

That confirms that here the clkrate isn't too slow. The trace also
suggests that you don't suffer from the problem I debugged before.

But you also have the problem that the backlight doesn't work at all for
you?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--u5srxwzvzyi72pbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMrRWAACgkQwfwUeK3K
7Am26wf+MQKxA9Xf80+LfU7Ew7L69S3AYDkVsv1JUmJmfGRm3nz34J2FNxiFTOOn
L6aYVOEm7/vcacp/S65Rxl2qFyGTIr3D0kQK6S3OPp5XClfARg3BTe72OZSt+LDY
Ic4Lnx5I9anLkPO3PccjSXUEWhF+acYq20Lu2ePHtSYPYq2tNmsUfAMsIZcjNgzj
eEwUFIia5vgHq4uNJ3pkeX9Fj18YcA1g7O9DF7JC5ioCRhEskbN4YXioLB6AwfgL
w59/tyWuURXXjr6dRVUNpwVcfDyOvA2PJQx6j5veLTX1KTJvgnjjswWeV1pIXN0i
dtFdQYgdvwOWwj8HXJNLcTIPt2o7lw==
=SQDA
-----END PGP SIGNATURE-----

--u5srxwzvzyi72pbi--
