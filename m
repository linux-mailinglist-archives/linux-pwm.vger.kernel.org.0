Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C13766624
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 10:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjG1IBU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 04:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjG1IAg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 04:00:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAA949E8
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:59:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPINr-000173-Oz; Fri, 28 Jul 2023 09:59:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPINr-002esQ-4L; Fri, 28 Jul 2023 09:59:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPINq-008RfE-Ge; Fri, 28 Jul 2023 09:59:34 +0200
Date:   Fri, 28 Jul 2023 09:59:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: Drop unused #include <linux/radix-tree.h>
Message-ID: <20230728075934.4t5p6qqibey25vuf@pengutronix.de>
References: <20230728071259.590902-1-u.kleine-koenig@pengutronix.de>
 <ZMNuhcw1CIczzfxe@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pw5w4t4toxn7t27x"
Content-Disposition: inline
In-Reply-To: <ZMNuhcw1CIczzfxe@orome>
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


--pw5w4t4toxn7t27x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 09:30:13AM +0200, Thierry Reding wrote:
> On Fri, Jul 28, 2023 at 09:12:59AM +0200, Uwe Kleine-K=F6nig wrote:
> > core.c doens't use any of the symbols provided by linux/radix-tree.h
> > and compiles just fine without this include. So drop the #include.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/core.c | 1 -
> >  1 file changed, 1 deletion(-)
>=20
> Looks like I forgot to remove that when the radix tree support was
> dropped in 247ee6c780406513c6031a7f4ea41f1648b03295. This didn't apply
> cleanly, so it breaks the b4 tracking.

Ah right, I based it on v6.5-rc1 while it conflicts with commit
0a41b0c5d97a ("pwm: Explicitly include correct DT includes"). If you
pass -3 to git am, it applies fine though.

I don't know what you mean by "b4 tracking", maybe git am -3 fixes that,
too?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pw5w4t4toxn7t27x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmTDdWUACgkQj4D7WH0S
/k5tywf/SLKrzhymag4nUvlabbjQn36VxPXQVmm4bX0Ut2CDacfST3NrtrfC9asc
0DxnXV1JULkDy2yUwA9gEmk4XvC+4QBhgS+hApNtkirMe/ewZUTGZdsbTNInpa4F
YsgrfQFk4cskPBezi5+FHU+Q5TAEgw5KWXIX0Eu1AUlHi+vfjGBNb7yzY+f18jaj
3EU8z4MsLjzwbfljf2Tl44n5spAFQYBwrRBrP8b19PztVz/LObiNbb0rE3C8h02O
XUqbt/5Xc/LReCBlgc9hrlyBNkhSW8Fj2vBhgAzOTivTO6op2825kPzRsmoLGMc1
OFIQz+NiSDz2ZndB63BNpx5rphcOKQ==
=9Uqw
-----END PGP SIGNATURE-----

--pw5w4t4toxn7t27x--
