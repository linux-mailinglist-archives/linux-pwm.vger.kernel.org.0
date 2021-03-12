Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D025233877B
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 09:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhCLIfR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 03:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbhCLIew (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 03:34:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422C6C061574
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 00:34:52 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKdFy-0005xq-Ag; Fri, 12 Mar 2021 09:34:50 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKdFx-0003pC-MX; Fri, 12 Mar 2021 09:34:49 +0100
Date:   Fri, 12 Mar 2021 09:34:49 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: lifetime of pwm devices
Message-ID: <20210312083449.5htbbr2zgqfxc3wo@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjssctusxlvw6wd4"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tjssctusxlvw6wd4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

currently PWM consumers (like for example a PWM fan) get a device link
to the PWM device that ensures that if the PWM device goes away, the
consumer is removed, too.

(This results in:

[   67.234400] pwm-fan pwm-fan: Dropping the link to 3f20c000.pwm
[   67.234429] device: 'platform:3f20c000.pwm--platform:pwm-fan': device_un=
register
[   67.234694] device: 'hwmon1': device_unregister
[   67.235384] device: 'pwmchip0': device_unregister
[   67.235488] device: 'pwmchip0': device_create_release

when I do
	echo 3f20c000.pwm > /sys/bus/platform/drivers/bcm2835-pwm/unbind

on a rpi3 like device with a PWM fan and some debugging enabled.)

Before the device link was established in commit

	b2c200e3f2fd ("pwm: Add consumer device link")

for v5.3-rc1 the machine was easy to crash after the PWM disappeared by
making the consumer use the gone PWM.

Now I wonder if it is just harder to trigger such a crash or if the link
is good enough to cover all corner cases.

I wonder if the pretty approach would be to ensure that the pwmchip's
lifetime is tracked using a struct dev that ensures that the pwmchip
doesn't go away until the consumer releases it. Is there an urge to
address this?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tjssctusxlvw6wd4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBLJ6YACgkQwfwUeK3K
7An6fAf/QgvfSw1m4iWz69cZ5Sch53R/yc4rVjp/OKnd+uh61jhdwFbFWePdcF6p
HFW0RN10s3c046XhZ63+e1Ybr+i9VHpjIoz9Meu7Rns74gCNZ86k/V2XHGZF73V8
/FAgA5YgicGzoFLL7MQP0b5tY27ya2txMHvO1Kw49LltACuc7+ucQoZjWWsNMXC+
J1s7+WHv+BKIPvzQLXMUTltm86enEPKyYhxcpVVg5coA4d6LaVzPsSNPittqXG4g
Iec7pdcVXh0nw48y+X7BZSxj5arEFsZ/M7NQySC5YJfb1VqiwwvGtVYEGLbbt8UG
yc7GhctgJcNUqTv7cPS9HMnnLpAJew==
=LvXN
-----END PGP SIGNATURE-----

--tjssctusxlvw6wd4--
