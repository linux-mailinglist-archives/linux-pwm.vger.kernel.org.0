Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D4D7C8301
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 12:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjJMKaK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 06:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJMKaK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 06:30:10 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCA0AD
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 03:30:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrFQk-00031O-Uu; Fri, 13 Oct 2023 12:30:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrFQk-001NBe-Hp; Fri, 13 Oct 2023 12:30:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrFQk-00FVjx-8D; Fri, 13 Oct 2023 12:30:06 +0200
Date:   Fri, 13 Oct 2023 12:30:06 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 109/109] WIP: pwm: Add support for pwmchip devices for
 faster and easier userspace access
Message-ID: <20231013103006.dw5tsromopi443hb@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
 <20231012163227.1004288-22-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5fryr6gtukrctuny"
Content-Disposition: inline
In-Reply-To: <20231012163227.1004288-22-u.kleine-koenig@pengutronix.de>
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


--5fryr6gtukrctuny
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Oct 12, 2023 at 06:32:38PM +0200, Uwe Kleine-K=F6nig wrote:
> Todo:
>  - reshuffle order of functions to get rid of forward decl of __pwm_apply=
_state
>  - implement remaining ioctls
>  - drop debug output
>  - maybe merge core.c and sysfs.c (separate commit?)
>  - ensure opening /dev/pwmchipX takes a reference to the chip to keep it
>    alive long enough.

The reference handling is fine for opening /dev/pwmchipX, however
pwmchip_remove() gets it wrong.

I'll squash the following into this patch for the next review round:

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 914775ab9403..d779efec81ee 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -456,15 +456,13 @@ int __pwmchip_add(struct pwm_chip *chip, struct modul=
e *owner)
=20
 	mutex_init(&chip->lock);
=20
-	if (chip->id < 256) {
+	if (chip->id < 256)
 		chip->dev.devt =3D MKDEV(MAJOR(pwm_devt), chip->id);
=20
-		cdev_init(&chip->cdev, &pwm_cdev_fileops);
-		chip->cdev.owner =3D owner;
-		ret =3D cdev_device_add(&chip->cdev, &chip->dev);
-	} else {
-		ret =3D device_add(&chip->dev);
-	}
+	cdev_init(&chip->cdev, &pwm_cdev_fileops);
+	chip->cdev.owner =3D owner;
+
+	ret =3D cdev_device_add(&chip->cdev, &chip->dev);
 	if (ret)
 		goto err_device_add;
=20
@@ -527,7 +525,7 @@ void pwmchip_remove(struct pwm_chip *chip)
=20
 	module_put(chip->owner);
=20
-	device_del(&chip->dev);
+	cdev_device_del(&chip->cdev, &chip->dev);
 }
 EXPORT_SYMBOL_GPL(pwmchip_remove);
=20

(The first hunk is only cosmetic, the 2nd is the relevant)

My branch on git.pengutronix.de is already fixed accordingly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5fryr6gtukrctuny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUpHC0ACgkQj4D7WH0S
/k44rAgAispC9lNxBriWHLuNr+CyOxhamEHulDoJkQhbNypIKb2dpnPoUzQefhj4
UGkFE7dmZCrLgw7oE4U53hcBY17HjRxvuuedzi55A0WD6FJJxs8XWD9u+FxYiuPP
Gv5uDwf7toPhPuS0SUdLvJHP8+D6k9V/vUUmP7JIKgnMwJy3iFVS/OxD+OSXkMcE
Uh5X/NMonfDBEJwQheTiQKWMc0HfdBDw7TVnPKFG9kX+Tm03j+oiGpBlqUko7Fwz
q5RxdsGwUJo/uPW63cPUaDLG1EjMTCZwaNC+u03K04Z1BdrbGEsjFIYWAmWypGgW
UQw8bdbO6IuarMsGPULbMbmpGq2vtQ==
=vwdz
-----END PGP SIGNATURE-----

--5fryr6gtukrctuny--
