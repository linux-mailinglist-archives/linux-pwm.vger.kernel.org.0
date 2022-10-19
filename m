Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A311603AC9
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Oct 2022 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJSHkQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Oct 2022 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJSHkM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Oct 2022 03:40:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE7537FE
        for <linux-pwm@vger.kernel.org>; Wed, 19 Oct 2022 00:40:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3gQ-0005ft-08; Wed, 19 Oct 2022 09:40:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3gP-0003z2-00; Wed, 19 Oct 2022 09:40:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3gN-00918o-RC; Wed, 19 Oct 2022 09:40:07 +0200
Date:   Wed, 19 Oct 2022 09:40:07 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Doug Brown <doug@schmorgal.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] pwm: pxa: Enable for MMP platform
Message-ID: <20221019074007.4csff4n64ihjsllq@pengutronix.de>
References: <20221003015546.202308-1-doug@schmorgal.com>
 <20221003015546.202308-6-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xscbcjif77cnc2qh"
Content-Disposition: inline
In-Reply-To: <20221003015546.202308-6-doug@schmorgal.com>
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


--xscbcjif77cnc2qh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 02, 2022 at 06:55:46PM -0700, Doug Brown wrote:
> The PXA168, which is part of the MMP platform, also uses this driver.
>=20
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 60d13a949bc5..d0d4caebf12f 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -434,7 +434,7 @@ config PWM_PCA9685
> =20
>  config PWM_PXA
>  	tristate "PXA PWM support"
> -	depends on ARCH_PXA || COMPILE_TEST
> +	depends on ARCH_PXA || ARCH_MMP || COMPILE_TEST

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xscbcjif77cnc2qh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNPqdQACgkQwfwUeK3K
7Ak8Vgf/fSwZVFdbySw3+9nfLZ+papGzGgmaJ6z0/pkkrEb6vxc7W3D2b8hIT2u6
17xA5U7f3VS5VmrqBR/px6zar6+tAU41t58M/OJixO1zP+Kh6NaLHlugSG8ndabA
3vWsw3V8bmfKhG7/4DqX/aDzqbCtTDx2LvX/l0VyyMpXALbG9t+RwGaxFtD6TCiC
UpxGdCi/DmFmLf5E2R9MbUSW3cmlwfHoZzp2qZcbTJAaq0D+VSPiphuY2NLWu6YF
maeO6DltKoX+CHZHyHBh7Glph3N/T9100Ih9kO9L7bw390rKifVb3I6gHDusna2b
mTa4GGrLxdRhroQaOesQVcyfmyn00A==
=pr3C
-----END PGP SIGNATURE-----

--xscbcjif77cnc2qh--
