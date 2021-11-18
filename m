Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA2345573B
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 09:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbhKRIpn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 03:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244798AbhKRIoa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Nov 2021 03:44:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E4DC061202
        for <linux-pwm@vger.kernel.org>; Thu, 18 Nov 2021 00:41:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mncyx-0004bJ-VT; Thu, 18 Nov 2021 09:41:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mncyw-000OOR-65; Thu, 18 Nov 2021 09:41:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mncyv-00088F-4X; Thu, 18 Nov 2021 09:41:21 +0100
Date:   Thu, 18 Nov 2021 09:41:08 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     cgel.zte@gmail.com
Cc:     deng.changcheng@zte.com.cn, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, zealci@zte.com.cn
Subject: Re: [PATCH V3] pwm: rcar: Use div64_ul instead of do_div
Message-ID: <20211118084108.vfdyogbd25bwnyzf@pengutronix.de>
References: <20211117130144.161788-1-deng.changcheng@zte.com.cn>
 <20211118030215.163306-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6lcqnwrjq4ga5ig"
Content-Disposition: inline
In-Reply-To: <20211118030215.163306-1-deng.changcheng@zte.com.cn>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d6lcqnwrjq4ga5ig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 03:02:15AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>=20
> do_div() does a 64-by-32 division. Here the divisor is an unsigned long
> which on some platforms is 64 bit wide. So use div64_ul instead of do_div
> to avoid a possible truncation.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

You're supposed to add a S-o-b line for yourself with a email address
that matches the sender of the patch.

Other than that the patch looks fine now.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--d6lcqnwrjq4ga5ig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGWEZwACgkQwfwUeK3K
7AncMgf/TNY85gnpHIxioH2vicjmrkcKoXefQ2C5TqCwwqaLtwcwUFPB/FucrQoL
zcQbQhgiL/vTY9UJcJNLtc0FvpJc3rbtLg3cgToWHpYQREbQAyKD54RG36bLXt60
fFrVMXz5XKKVsSzZqK1+SKI8qXWZo+G5Zv7KK5z05Qb7PWHZH0cEHzv4DggZvHSD
UFT7GsYLedClDRf99CCi2+48zZltHIBMKXlmDQl9YYelDoDUUPngnST+gY+v/y/6
qiB75gEDoeuoiMtVGJwnWDGLGWNVtCNJPMRs5qHvPx3k3+Q8pajlU7JDjYLxyDvP
ggM1tdCz+W8LRBKIoqkZ0DRuFxXbOQ==
=rBwa
-----END PGP SIGNATURE-----

--d6lcqnwrjq4ga5ig--
