Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E575F7AE9EA
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Sep 2023 12:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjIZKGh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Sep 2023 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjIZKGg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Sep 2023 06:06:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7A10E
        for <linux-pwm@vger.kernel.org>; Tue, 26 Sep 2023 03:06:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql4xW-0005Jf-TR; Tue, 26 Sep 2023 12:06:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql4xW-00959T-7C; Tue, 26 Sep 2023 12:06:26 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ql4xV-004wDt-Ty; Tue, 26 Sep 2023 12:06:25 +0200
Date:   Tue, 26 Sep 2023 12:06:25 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@pengutronix.de
Subject: Re: [PATCH v1 000/101] pwm: Fix lifetime issues for pwm_chips
Message-ID: <20230926100625.vudo7qp3h5r2dz62@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="447jssatzw6o27qy"
Content-Disposition: inline
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--447jssatzw6o27qy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Tue, Aug 08, 2023 at 07:17:50PM +0200, Uwe Kleine-K=F6nig wrote:
> this series addresses the issues I reported already earlier to this
> list[1]. It is based on pwm/for-next and several patches I already sent
> out, too. Maybe some of these have to be reworked (e.g. Thierry already
> signalled not to like the patches dropping runtime error messages) but
> in the expectation that I will have to create a v2 for this series, too
> and it actually fixes a race condition, I sent the patches out for
> review anyhow. For the same reason I didn't Cc: all the individual
> maintainers.
>=20
> If you want to actually test I suggest you fetch my complete history
> from
>=20
> 	https://git.pengutronix.de/git/ukl/linux pwm-lifetime-tracking
>=20
> .=20
>=20
> In the end drivers have to allocate their pwm_chip using
> pwmchip_alloc(). This is important for the memory backing the pwm_chip
> being able to have a longer life than the driver.
>=20
> The motivation for this series is to prepare the pwm framework to add a
> character device for each pwm_chip for easier and faster access to PWMs
> from userspace compared to the sysfs API. For such an extension proper
> lifetime tracking is important, too, as such a device can still be open
> if a PWM disappears.

I wonder how this topic will continue. This series fixes a lifetime
issue that can result in a userspace triggered oops and it builds the
base for my efforts to create a /dev/pwmchipX for faster control of PWMs
=66rom userspace (compared to sysfs). (Currently in the prototype stage.)

I'd like to get this in during the next merge window, please tell me
what needs to be done to make this happen.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--447jssatzw6o27qy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUSrSAACgkQj4D7WH0S
/k4ZWgf/U1vYmgAZ8TqqdVw9oUcp0IxUKh9DGNaD9QSxp7rej5iyZaVF1STeMH+A
p+awRoSxtekA1UjZx4ToM27+vnIAKx8E1YnYsUf5eFhDVl/fsKpgMIH7NpAi20Yp
mzk65UfiyY6IXSjZcRyOEwzXFs5kAt2IzlmWKpMlLu9e3XXnzNUpL2nw9dADypFZ
AS38Vb7OhsZ3WDQvlZo1yxBILkAxnbBQKi9ArcgK+uMjxvZ9zQ/pNmD05RAhF8hI
cjNdn9vq7yllRXrLxi23I5Atsp7bCATD4cjqQWuOXidh/avGXYsf/IH7I2XvIREP
mPvH95EcRcE6iOrTBH1UCb0jiKtSqQ==
=o+Ns
-----END PGP SIGNATURE-----

--447jssatzw6o27qy--
