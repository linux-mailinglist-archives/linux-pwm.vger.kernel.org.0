Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298A862DA11
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Nov 2022 13:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbiKQMAA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Nov 2022 07:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbiKQL75 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Nov 2022 06:59:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF046EB7D
        for <linux-pwm@vger.kernel.org>; Thu, 17 Nov 2022 03:59:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdYd-0007jZ-OY; Thu, 17 Nov 2022 12:59:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdYc-004qC5-5b; Thu, 17 Nov 2022 12:59:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdYc-00HGds-5k; Thu, 17 Nov 2022 12:59:50 +0100
Date:   Thu, 17 Nov 2022 12:59:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: devres: add missing PWM helper
Message-ID: <20221117115950.mlzkipddy3qwwp2k@pengutronix.de>
References: <20221102024430.1444714-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c4ipze7ht6c7ow6a"
Content-Disposition: inline
In-Reply-To: <20221102024430.1444714-1-yangyingliang@huawei.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--c4ipze7ht6c7ow6a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 02, 2022 at 10:44:30AM +0800, Yang Yingliang wrote:
> Add missing devm_pwmchip_add() to devres.rst. It's introduced by
> commit bcda91bf86c1 ("pwm: Add a device-managed function to add
> PWM chips").
>=20
> Fixes: bcda91bf86c1 ("pwm: Add a device-managed function to add PWM chips=
")
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  Documentation/driver-api/driver-model/devres.rst | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documenta=
tion/driver-api/driver-model/devres.rst
> index aac9c1e39ebc..2bea236d6919 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -402,6 +402,7 @@ POWER
>    devm_reboot_mode_unregister()
> =20
>  PWM
> +  devm_pwmchip_add()
>    devm_pwm_get()
>    devm_fwnode_pwm_get()

Oh, didn't know that doc list.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Is this expected to go via the pwm tree, or will Jonathan pick it up?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c4ipze7ht6c7ow6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2IjMACgkQwfwUeK3K
7Anvuwf+Il5y7s+/soZmr0RgjnoE9Z+GnjrGde36or2ZEVsySOgqWy0VXHxVfALk
OokI7ugamaycQLSdzWcWLV0h8cuV6z+l7imr3F6dFMTCof+h4qioeAWfdYgOGju8
tqNg1P2DsNCrG8gRNTzlyeWS4vJFef1YUzaBU5E8Fw/axUs3vLprJGBHfX95aZ37
zGkwise4szv/8W26SKPAq0XNMW82VIpKIAkGHwb+3/6v8iwst7KFDRU6VK/VCCyG
75joFmM3HLjyh46PGqQbh4O2YE0Mg8qAw62EgrrVUP/mMP8kQ32ehRRocsky4/xm
sy07SLJWzcDh7ZVl19ewm86A6/QxkQ==
=qeBp
-----END PGP SIGNATURE-----

--c4ipze7ht6c7ow6a--
