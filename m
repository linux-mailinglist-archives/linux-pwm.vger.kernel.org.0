Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629A94029D1
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Sep 2021 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbhIGNiw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Sep 2021 09:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbhIGNis (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Sep 2021 09:38:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD2C061575
        for <linux-pwm@vger.kernel.org>; Tue,  7 Sep 2021 06:37:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNbIB-00053L-T9; Tue, 07 Sep 2021 15:37:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNbIA-000289-I1; Tue, 07 Sep 2021 15:37:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mNbIA-00088E-FT; Tue, 07 Sep 2021 15:37:38 +0200
Date:   Tue, 7 Sep 2021 15:37:38 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <long870912@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: twl: Simplify using devm_pwmchip_add()
Message-ID: <20210907133738.s3l4w3csrdvuld6v@pengutronix.de>
References: <20210907111518.15914-1-long870912@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g65mzlg4iurgudtc"
Content-Disposition: inline
In-Reply-To: <20210907111518.15914-1-long870912@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g65mzlg4iurgudtc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 07, 2021 at 07:15:18PM +0800, zhaoxiao wrote:
> With devm_pwmchip_add() we can drop pwmchip_remove() from the device
> remove callback. The latter can then go away, too and as this is the
> only user of platform_get_drvdata(), the respective call to
> platform_set_drvdata() can go, too.
>=20
> Signed-off-by: zhaoxiao <long870912@gmail.com>

A similar patch is already in next as c9bb1c9e5460f6e84e95b65fe4c5bb09d5dff=
10a

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g65mzlg4iurgudtc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE3ax8ACgkQwfwUeK3K
7AmV6Af/b3do9EdB2z5/5NjmPplRGHlQks7W68yDofy/rL9S2672bXolBT5mckZn
0+JHDJJbgQRH3k8OVD0w6dcp7fTNkp1x2HgJ8VTWYD8LhH6W/yJwJEUAV6TP1AAd
38OtBXZ2+7kejeAHJcVPQGIbvxj6fo659M2x2/9JR4bNLaMwoMoPDNdPhn8+MhYO
pAYzRS82EbQj2Um+GCqPr25UKABMHa2gGW8bzGWd+3oeaQMauH0gkE3gZ87KN/IA
rmEZCOOpfZlrIdKNzQjenZ0sAtDOi/oKMxe1nMubpaUhVkwx4Xy249CE+Uljg4K8
9tvAxJnfb8LjZ/k8lCCGuWTbcQKajg==
=04po
-----END PGP SIGNATURE-----

--g65mzlg4iurgudtc--
