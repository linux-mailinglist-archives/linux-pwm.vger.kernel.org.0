Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A8E379267
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 17:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbhEJPUO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhEJPSy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 11:18:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E5C061760
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 07:48:41 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg7D5-0005VZ-RI; Mon, 10 May 2021 16:48:39 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg7D5-0003kb-Gz; Mon, 10 May 2021 16:48:39 +0200
Date:   Mon, 10 May 2021 16:48:39 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/4] pwm: Simplify drivers with of_pwm_n_cells = 3
Message-ID: <20210510144839.nd2sjhelhc6544t7@pengutronix.de>
References: <20210510140640.980100-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3biaz3j3gyzgkb26"
Content-Disposition: inline
In-Reply-To: <20210510140640.980100-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3biaz3j3gyzgkb26
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 10, 2021 at 04:06:36PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> changes since v1:
>=20
>  - rebased to v5.13-rc1
>  - reformulate an if in a way that pleases Thierry (no semantic change)
>=20
> Thierry's suggestion was to apply this series shortly after v5.13-rc1
> (i.e. around now) to have it exposed to next for a long time before it
> flows to Linus Torvalds.

I just noticed I already sent this patch set starting with Message-Id
20210424210718.2787498-1-u.kleine-koenig@pengutronix.de.

Sorry for the duplicate, but maybe it works just fine as a reminder for
Thierry to take this series soon :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3biaz3j3gyzgkb26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCZR8QACgkQwfwUeK3K
7Ame1wgAhH6+BqSJaTi8rKXtCIBrf/dSAaQU/mLcXx0WIXdqK/lKqF/dmS1W+gkg
oM2Hr4fZoLNQbTczxPF962VjIMOzl0CzK+46E9yDvq/YwEXs01hF8L4crGGD0ugQ
Z0t3IA+uVqo9VSF5Zg5Cv3Ce9nbCfScnPhZlVh5ir17q6VA5yDQA18ZoeHlL8yuZ
yqJYetZ5QfY1kavO+/9DfA3QngumGpS0Otvn9dOHc6epEVhk8mE8Tya+u2otHMzX
sAMKADUaOMJvC7HtXd/vOdAXc6jYUgVkU8JCG7fKTksYGwI9yx6Izofe0lRWGta6
31roWr+a2pxwppK4pezrYFhMkBLNzA==
=3it9
-----END PGP SIGNATURE-----

--3biaz3j3gyzgkb26--
