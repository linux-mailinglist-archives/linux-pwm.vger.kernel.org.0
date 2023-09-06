Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6367940E5
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Sep 2023 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbjIFP6R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Sep 2023 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbjIFP6Q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Sep 2023 11:58:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D91733
        for <linux-pwm@vger.kernel.org>; Wed,  6 Sep 2023 08:58:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduur-0004vA-NZ; Wed, 06 Sep 2023 17:58:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduuq-004STC-HI; Wed, 06 Sep 2023 17:58:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qduup-00GuhI-Qa; Wed, 06 Sep 2023 17:58:03 +0200
Date:   Wed, 6 Sep 2023 17:58:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Young <sean@mess.org>
Cc:     linux-media@vger.kernel.org,
        "Sicelo A . Mhlongo" <absicsz@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Timo Kokkonen <timo.t.kokkonen@iki.fi>
Subject: Re: [PATCH v3 1/2] media: rc: remove ir-rx51 in favour of generic
 pwm-ir-tx
Message-ID: <20230906155803.vkyvifbazkleb3vr@pengutronix.de>
References: <20230822145644.213589-1-sean@mess.org>
 <20230822145644.213589-2-sean@mess.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jkxpbv25mm4dc7z"
Content-Disposition: inline
In-Reply-To: <20230822145644.213589-2-sean@mess.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7jkxpbv25mm4dc7z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Aug 22, 2023 at 03:56:43PM +0100, Sean Young wrote:
> The ir-rx51 is a pwm-based TX driver specific to the N900. This can be
> handled entirely by the generic pwm-ir-tx driver, and in fact the
> pwm-ir-tx driver has been compatible with ir-rx51 from the start.
>=20
> Note that the suspend code in the ir-rx51 driver is unnecessary, since
> during transmit, the process is not in interruptable sleep. The process
> is not put to sleep until the transmit completes.
>=20
> Tested-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> Signed-off-by: Sean Young <sean@mess.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pwm@vger.kernel.org
> Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> Cc: Pali Roh=E1r <pali.rohar@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Timo Kokkonen <timo.t.kokkonen@iki.fi>

Looks ok for me. I assume this will go in via the media tree and the pwm
list was only Cc:d because drivers/media/rc/pwm-ir-tx.c uses pwm
functions? I'll mark this patch as "handled-elsewhere" in the pwm
patchwork. Please tell me if you object.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7jkxpbv25mm4dc7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmT4oYoACgkQj4D7WH0S
/k57VAf/fjJOPeKwPPiC/Nog9d0l8aGdFYwFGNMic5W+3/azzkfhPvkX4+WSGDH/
3SEv7//ugXU3IkQ6Quwxb8Ey5Rs1/+U1Ag8x6kHZQGDFdHZs/FwWaLITjvzj0Iy8
ftxNjZLWvUfR1gScHFE+zu7NG/K6LI+qqD0Aw5aSHolIotxfWNOaCAcYomlD4HHv
hvAGth3SeD8+AGXDvqTb8F6W1giqpPmNigm1+JchJXpZbnzuYSlkVJAPvIxEA1Ec
4ODyvDTz2lPPwGoYw06QIPOwubX9/aZPxsoYGbhXdQKNs9s/vCC54qXj1a3BG/5r
vlwhlDNC0/hzqqZMjQbgdXMUE9fSwA==
=M0Ct
-----END PGP SIGNATURE-----

--7jkxpbv25mm4dc7z--
