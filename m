Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820F25EC749
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Sep 2022 17:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiI0PLJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Sep 2022 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiI0PLI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Sep 2022 11:11:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA96F6877
        for <linux-pwm@vger.kernel.org>; Tue, 27 Sep 2022 08:11:04 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1odCEc-0002ON-Ab; Tue, 27 Sep 2022 17:10:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odCEc-003Fam-7u; Tue, 27 Sep 2022 17:10:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1odCEa-003vHY-6Y; Tue, 27 Sep 2022 17:10:56 +0200
Date:   Tue, 27 Sep 2022 17:10:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 4/8] pwm: lpss: Include headers we are direct user of
Message-ID: <20220927151053.7eh63stoganpgawr@pengutronix.de>
References: <20220927144723.9655-1-andriy.shevchenko@linux.intel.com>
 <20220927144723.9655-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eethafq2wituzhkq"
Content-Disposition: inline
In-Reply-To: <20220927144723.9655-5-andriy.shevchenko@linux.intel.com>
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


--eethafq2wituzhkq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 27, 2022 at 05:47:19PM +0300, Andy Shevchenko wrote:
> For the sake of integrity, include headers we are direct user of.
>=20
> While at it, add missed struct pwm_lpss_boardinfo one and replace
> device.h with a forward declaration. The latter improves compile
> time due to reducing overhead of device.h parsing with entire train
> of dependencies.

Hm, I copied the cmdline for the compiler from a V=3D1 build and only run
the compiler on drivers/pwm/pwm-lpss-pci.c.

With #include <device.h> I got:

	real	0m0.421s
	user	0m0.354s
	sys	0m0.066s

With struct device; I got:

	real	0m0.431s
	user	0m0.378s
	sys	0m0.052s

Are the numbers for you considerably different?

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
> index c344921b2cab..839622964b2a 100644
> --- a/drivers/pwm/pwm-lpss.h
> +++ b/drivers/pwm/pwm-lpss.h
> @@ -10,11 +10,15 @@
>  #ifndef __PWM_LPSS_H
>  #define __PWM_LPSS_H
> =20
> -#include <linux/device.h>
>  #include <linux/pwm.h>
> +#include <linux/types.h>
> =20
>  #define MAX_PWMS			4
> =20
> +struct device;
> +
> +struct pwm_lpss_boardinfo;

Hmm, I wonder why there is no compiler warning without that declaration.
At least in my builds. Do you see a warning? IMHO it's better to fix
that be swapping the order of struct pwm_lpss_chip and struct
pwm_lpss_boardinfo.

>  struct pwm_lpss_chip {
>  	struct pwm_chip chip;
>  	void __iomem *regs;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--eethafq2wituzhkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMzEnoACgkQwfwUeK3K
7AkrQQf/fZ6ptu/CNAn9zoSn9UaThTEMfKdorGSn8tlmlgLIOC8/ei8xwRnvQ3Bd
dzDnyF/f7mh22PaBsLQBK6GeKB9bJr7Nu6MPc5URE7ML9o3CZjmpTqTHyqiLuGhu
3ZO2htBOBKDZdxK4o96IV4nEwQPPZivsn504DgMeXnpe0SHmBQbR1wuUbUlfN8Wg
NCrM3p9LD20ZdjK6oj/pEtiPa0dX/gdI4OoVgg9UJkn45oa0g7gsofmczsDOIs+x
RJZ/tzMxmY5/q1EMr4fnQV9CquE5A2Osw9UxQaCyT4geVRRVe9yybJXckV5/2tvI
QXfhP7Mkj53HBm4tITtY2iI9e7ZTjA==
=MlPl
-----END PGP SIGNATURE-----

--eethafq2wituzhkq--
