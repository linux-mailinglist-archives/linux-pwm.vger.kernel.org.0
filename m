Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D27A4F28
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Sep 2023 18:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjIRQfK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Sep 2023 12:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjIRQes (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Sep 2023 12:34:48 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3E82544B
        for <linux-pwm@vger.kernel.org>; Mon, 18 Sep 2023 09:15:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiDuQ-0006eX-6A; Mon, 18 Sep 2023 15:03:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiDuP-007Dzm-7Q; Mon, 18 Sep 2023 15:03:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qiDuO-002eQH-UH; Mon, 18 Sep 2023 15:03:24 +0200
Date:   Mon, 18 Sep 2023 15:03:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-pwm@vger.kernel.org, conor@kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1] pwm: microchip-core: convert SOC_MICROCHIP_POLARFIRE
 to ARCH_MICROCHIP_POLARFIRE
Message-ID: <20230918130322.2wyxfcvnf74wsj54@pengutronix.de>
References: <20230918-finisher-eliminate-b9cacc9d86eb@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pb3idutr7u7rzocm"
Content-Disposition: inline
In-Reply-To: <20230918-finisher-eliminate-b9cacc9d86eb@wendy>
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


--pb3idutr7u7rzocm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Conor,

On Mon, Sep 18, 2023 at 11:23:27AM +0100, Conor Dooley wrote:
> As part of converting RISC-V SOC_FOO symbols to ARCH_FOO to match the
> use of such symbols on other architectures, convert the Microchip FPGA
> PWM driver to use the new symbol.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Thierry Reding <thierry.reding@gmail.com>
> CC: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> CC: linux-pwm@vger.kernel.org
> ---
>  drivers/pwm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8ebcddf91f7b..502d041d4a11 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -407,7 +407,7 @@ config PWM_MEDIATEK
> =20
>  config PWM_MICROCHIP_CORE
>  	tristate "Microchip corePWM PWM support"
> -	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
> +	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
>  	depends on HAS_IOMEM && OF
>  	help
>  	  PWM driver for Microchip FPGA soft IP core.

that seems to be in line with commit 444c3dbdabd4 ("RISC-V: introduce
ARCH_FOO kconfig aliases for SOC_FOO symbols")

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--pb3idutr7u7rzocm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUISpkACgkQj4D7WH0S
/k6ArQgAgc0ImTyrxYvBxdNnzCy0CtQnOIhbapUAm3W7z+OxQZCbT9VcWHNRwybb
YzKfAPVbqGEDMC83cCrOHcIwe8Hp7m77Buh81r2AiQnBvy3BV/iAitJvRWAnqQIc
PsYRLnMF13iV/IFgAzhjyyFhvj3C+FKveTo3q5Oy3z/TlyUIiCdAGI7SHv9QvJMI
EfWSiobNI26fTYnqVr1G49IX/bCUTcBVTF5pCqMTWeYUKQ51D/YYF8cONc4c8D0P
/d9a09AUPRfwsNxwlGwL910h7kqgh/G6d86H8da0LmXNiSnVDQioIWUMxBa91csM
p28P2zIc2JPUydBbE+AXWNGjnrpkfg==
=2sdC
-----END PGP SIGNATURE-----

--pb3idutr7u7rzocm--
