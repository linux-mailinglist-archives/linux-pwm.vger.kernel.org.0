Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A83F2799A1
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Sep 2020 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIZNY5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 26 Sep 2020 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZNY5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 26 Sep 2020 09:24:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45486C0613CE
        for <linux-pwm@vger.kernel.org>; Sat, 26 Sep 2020 06:24:57 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMAC3-00086l-Gw; Sat, 26 Sep 2020 15:24:51 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kMAC0-0001OX-L1; Sat, 26 Sep 2020 15:24:48 +0200
Date:   Sat, 26 Sep 2020 15:24:48 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Olliver Schinagl <oliver@schinagl.nl>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] pwm: Add GPIO PWM driver
Message-ID: <20200926132448.fnjeehot2h6iazdd@pengutronix.de>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200814155513.31936-2-vincent.whitchurch@axis.com>
 <703362fe-1454-c16e-180a-76bfc4e3ab3f@schinagl.nl>
 <20200915140208.bzserxn2bgw4xiwk@axis.com>
 <cbb303e9-a352-ec2e-691d-4e073bbee8c0@schinagl.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiwlv6wmjohe2fja"
Content-Disposition: inline
In-Reply-To: <cbb303e9-a352-ec2e-691d-4e073bbee8c0@schinagl.nl>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yiwlv6wmjohe2fja
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Olliver,

On Fri, Sep 25, 2020 at 08:14:58PM +0200, Olliver Schinagl wrote:
> On 15-09-2020 16:02, Vincent Whitchurch wrote:
> > Since this is just a software construct, the simplest way would just be
> > to create multiple instances in the device tree if you want multiple
> > PWMs, wouldn't it?
>
> Not entirely, as they are no longer 'logically grouped'?

Why is it necessary for you that the PWMs are "logically grouped"?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yiwlv6wmjohe2fja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9vQR0ACgkQwfwUeK3K
7AlsAAf/a3WJfL+fuIdvGMFIDpCvth9YWMMs6WsCNMpGyHHZlH+V7nTrqiCiYf0o
NUIBtgpNNOvIYLoglekTD+WUYRDHRBSrHlToWG7uBP6GvCGVsnJ2TglQDcyCpszh
ErRRt7AZ8HNakSr2NzvlUTuTN6+IDXU3chfrAyt8UVreNhxKvWN/0Bo0xTtOsuNh
DOT7gfHUiVpBfpEU0wwpO4YJOo4bmDIP016Ex1QQDVhZ0Q231P+2AzzYz5/L1P0l
jafGHPB2NrnP8Q55oF0LbocE48VZ4OkgTP+FMdPY/dcexnWshPTw4KND9WCwAQlW
cFHCWpPykC+D2PC72vcz2qwzBy0WtA==
=U4SD
-----END PGP SIGNATURE-----

--yiwlv6wmjohe2fja--
