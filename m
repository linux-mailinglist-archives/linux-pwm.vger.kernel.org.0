Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726EA62D643
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 10:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiKQJSI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 04:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKQJSI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 04:18:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176B96B388
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 01:18:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovb25-0006Dk-0i; Thu, 17 Nov 2022 10:18:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovb23-004p2I-3o; Thu, 17 Nov 2022 10:18:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovb23-00HF5n-79; Thu, 17 Nov 2022 10:18:03 +0100
Date:   Thu, 17 Nov 2022 10:18:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>, robh@kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] pwm: core: Do not create device link for same
 consumer & supplier
Message-ID: <20221117091803.zy42s3qd5bo4r6et@pengutronix.de>
References: <20221117083111.1260643-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bc56imoj6aqct4wa"
Content-Disposition: inline
In-Reply-To: <20221117083111.1260643-1-Naresh.Solanki@9elements.com>
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


--bc56imoj6aqct4wa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Nov 17, 2022 at 09:31:11AM +0100, Naresh Solanki wrote:
> If the PWM consumer is the child DT device of PWM supplier, i.e., the
> same 'struct device' then do not create device link.
>=20
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

In a private conversation I learned that this is needed for=20
https://lore.kernel.org/all/20221116213615.1256297-1-Naresh.Solanki@9elemen=
ts.com/

Given the series above is broken without this patch, I suggest to
discuss these in a single series.

I still think the provider shouldn't consume it's own PWM. Either the
PWM is usable for other purposes, then it should be a proper device on
its own, or it isn't and then please don't expose it.

Both options make this patch redundant.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bc56imoj6aqct4wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN1/EgACgkQwfwUeK3K
7AnnNAf/eGOp37dqF0bFOxwjgwtzGzA3ouTRYcNzsM/76mfYmxeoHa+KYnuhNJbx
ZAAdqDhYr+M9Lj8pigXGBILcvTl4lu9ScTrdJetYczFohQKbeAd1rKlHGmay/EUT
UNc01e8hxpxIaBeaG5+LWfkSe6E4U1D3n5sxRLMdGUEY53s74mYwn48EjWhjl5rs
Ytrt8F+C6Em0lbXyPVPEYs/n6H9UyjonPhcJSei8chYD5rodw5e54fPevx7wG40A
p1F7yOeSNl5rZkEICLdZM7OuIyEK1uxjNy6ZFkZwiRvCBkqEnoXxPo9yYXKvVww/
mtxZdWT/IQ7tSEfs4n+lIWZQzEuS3A==
=jLbW
-----END PGP SIGNATURE-----

--bc56imoj6aqct4wa--
