Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB50F36053E
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhDOJGk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 05:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhDOJGi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Apr 2021 05:06:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1009C061574
        for <linux-pwm@vger.kernel.org>; Thu, 15 Apr 2021 02:06:15 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWxwy-0001Uy-K8; Thu, 15 Apr 2021 11:06:12 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lWxwx-0007rB-Fc; Thu, 15 Apr 2021 11:06:11 +0200
Date:   Thu, 15 Apr 2021 11:06:11 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] pwm: mediatek: remove unused function
Message-ID: <20210415090611.jjbwoz2nbcam3kct@pengutronix.de>
References: <1618475753-102123-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7bpyeb4yz3dyj6pq"
Content-Disposition: inline
In-Reply-To: <1618475753-102123-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--7bpyeb4yz3dyj6pq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 15, 2021 at 04:35:53PM +0800, Jiapeng Chong wrote:
> Fix the following clang warning:
>=20
> drivers/pwm/pwm-mediatek.c:110:19: warning: unused function
> 'pwm_mediatek_readl' [-Wunused-function].
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Looks right, even though I would prefer to see a patch implementing
=2Eget_state instead (which probably would make use of this function).

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7bpyeb4yz3dyj6pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB4AgAACgkQwfwUeK3K
7Ak5AAf7BTvu8rSzXv1FOdNJdLxf7+YfcvZs28wu+8AjrB4lxsn3KmModBJ0Zd3S
kWP2SjRYH6z6yufXwBLo+hePxCVf4ZXwtNcpjX3KS2DMiDNh3W4maCwdWwuLbuVq
Tkwvbw55qamozBBxcMvNO2NeQMk1NRoS5H5kG3sJbOppG7zaALoNz4WEEu8ByNXt
1v8d+FWjdAAfaVQnLI1ndYC1AWVkdKEjQLO6FkMQ2F/hVzRzZqnFoxAqgqYyZe8f
F4cAA9JWdK5MC5uAtCm0QfL1FFs39AZ5Y0jRkZDug5swopt6nSHS6zm6HZhJydTo
nWOhe9Ugom7Yq1L+XSiWIO8NWhq4XQ==
=wl9M
-----END PGP SIGNATURE-----

--7bpyeb4yz3dyj6pq--
