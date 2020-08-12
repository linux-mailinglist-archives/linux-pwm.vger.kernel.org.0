Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193C724258A
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 08:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgHLGkv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 02:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgHLGkv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 02:40:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0508C06174A
        for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2020 23:40:50 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5kRH-0007HF-PD; Wed, 12 Aug 2020 08:40:43 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5kRF-00072c-Ph; Wed, 12 Aug 2020 08:40:41 +0200
Date:   Wed, 12 Aug 2020 08:40:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v6 1/2] Add DT bindings YAML schema for PWM fan
 controller of LGM SoC
Message-ID: <20200812064041.e75p5neq7wcg5dag@pengutronix.de>
References: <cover.1595926036.git.rahul.tanwar@linux.intel.com>
 <e61e6a05353f6242f5450da130b042f195ac7620.1595926036.git.rahul.tanwar@linux.intel.com>
 <20200731181944.GB516550@bogus>
 <e50f198d-42d4-28b1-d32c-32f4b1bbcb0b@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5u42du46nfyz3lys"
Content-Disposition: inline
In-Reply-To: <e50f198d-42d4-28b1-d32c-32f4b1bbcb0b@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5u42du46nfyz3lys
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rahul,

On Wed, Aug 12, 2020 at 11:49:14AM +0800, Tanwar, Rahul wrote:
> Our PWM controller is actually a PWM fan controller dedicated for
> controlling fan. I am looking for some suggestions from you on how
> to handle fan related optional properties in such a scenario.
>=20
> Should i create a separate child node for fan with PWM node being
> the parent? Is that what you are suggesting? Thanks.

What is the problem of just using pwm-fan?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5u42du46nfyz3lys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8zjuYACgkQwfwUeK3K
7AmRFgf9Hj3Ye4VVPi0Zsv+m8e6Jx6F1XgWaK/KLQ5sBH32RoBdkOarZFf2pqcsN
LbNgvrLiCRQWOmo3VdslgqmS8hefjaGsJOsromvz80sh864KQhe9BxjiFjqSGjAd
E9EG1i2kE/zKS9p0Hb41juerIOHns9LoztpCPGUO/CajGa3fFXRHJ0jcACYciXtH
swWCJysH3jPl7Bfxx6nf8/sg038vALQObFwI8166gtk2cT5UzrwqVIpR0EGw4dbE
5Enm9XTReWqzwd0VDPGAPmtnbfUS0EiOVmEsBNh7OxbMk0Tmv1jFngaOohkRkZiD
OqTOL7Gq7DvyN+UfWmLG8C8xmXjIpA==
=jsAe
-----END PGP SIGNATURE-----

--5u42du46nfyz3lys--
