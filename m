Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8122416C9
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Aug 2020 09:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHKHBH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Aug 2020 03:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgHKHAy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Aug 2020 03:00:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E80C061788
        for <linux-pwm@vger.kernel.org>; Tue, 11 Aug 2020 00:00:50 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5OH9-0003WW-Iu; Tue, 11 Aug 2020 09:00:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5OH9-0007Y6-6m; Tue, 11 Aug 2020 09:00:47 +0200
Date:   Tue, 11 Aug 2020 09:00:47 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify
 error handling
Message-ID: <20200811070047.vlxykdpqo3llsjxw@pengutronix.de>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y6nwyzidkk3m6jfd"
Content-Disposition: inline
In-Reply-To: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y6nwyzidkk3m6jfd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 02:24:30PM +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record t=
he
> defer probe reason etc., use it to simplify the code.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y6nwyzidkk3m6jfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8yQhwACgkQwfwUeK3K
7AmHhgf+OHoSsLaQmboSTL+NWU08uKvZiet5oGfUdj4sfJyx780Exmid8TAAfOyE
O2vGHb9QiEbu14UdicRYSo4WQ9cwaAJRv2BWBdjz6lvp8DP46P09rm2UU2z4RvlC
5Em8yS8vKUSny4M+daxMqVTpwITw9BgGsPh4viHxjlXmaYN8h/Wp0YOyx4Xx09pn
1aYTTQlBjhXqfa3iTGbWxcgJOS8K0Hqnpgjhk6Nxzo9YBuMVz54ZDnUh/UIQrhbg
8oZk9ZNYkkyQmzmNY66Ly5oKWC6S1YybqIEOqFTtlhO/mQNPhowxYh9DPx1/sc6p
hNMrAl4bRkJKcdO5SmE5+XOT5zJuYQ==
=Swmy
-----END PGP SIGNATURE-----

--y6nwyzidkk3m6jfd--
