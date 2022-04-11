Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908724FB3F6
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Apr 2022 08:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiDKGup (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Apr 2022 02:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245051AbiDKGuo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Apr 2022 02:50:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F82218361
        for <linux-pwm@vger.kernel.org>; Sun, 10 Apr 2022 23:48:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndnqY-0006W3-LS; Mon, 11 Apr 2022 08:48:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndnqY-002Kv3-LA; Mon, 11 Apr 2022 08:48:21 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndnqW-002XnH-Io; Mon, 11 Apr 2022 08:48:20 +0200
Date:   Mon, 11 Apr 2022 08:48:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
Message-ID: <20220411064819.bnfyqekd6yy45g6a@pengutronix.de>
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34u7c5whjbihn6jn"
Content-Disposition: inline
In-Reply-To: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--34u7c5whjbihn6jn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Mon, Apr 11, 2022 at 09:23:40AM +0300, Baruch Siach wrote:
> pwmchip_add() unconditionally assigns the base ID dynamically. Commit
> f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> dropped all base assignment from drivers under drivers/pwm/. It missed
> this driver. Fix that.
>=20
> Fixes: f9a8ee8c8bcd1 ("pwm: Always allocate PWM chip base ID dynamically")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Thanks for catching this.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

There is another one in drivers/staging/greybus/pwm.c, will send a patch
shortly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--34u7c5whjbihn6jn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJTzzAACgkQwfwUeK3K
7AmcJwf/b2YGS+Af72cn9FnxhQVnt2dboiTM+9C0jFds+wekiizXGGqRp8NvtG1e
Lw6GYhhe5nWw2KpD1sl32+DsdQxATOrGbI5iGdEuh0naeukAu6cxrLxnR65gSpOx
VmWlFrF801WgN28OEN17kp3lAsrA7afvXojN9MULpUS3r0A3AQX9Trlz47U8a6CS
XPsGMFDmvDi+QBR1LFF7lAlVNT+9bLPOCNPe54CDLHBRfd0biMo1f4z+sQk4wa6H
xRTpfk3VJrL6KqxPotEokGI2/SQnc0zJbClHh8Z/0l0D1G8md7t8aOYaTXsnQVMn
CcQe6XPTSHh6Wn9mdlk1z0xb8Eoy8w==
=fOzn
-----END PGP SIGNATURE-----

--34u7c5whjbihn6jn--
