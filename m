Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77D235A80
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Aug 2020 22:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHBU15 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Aug 2020 16:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHBU15 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Aug 2020 16:27:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF3BC06174A
        for <linux-pwm@vger.kernel.org>; Sun,  2 Aug 2020 13:27:57 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k2Ka7-0004sM-La; Sun, 02 Aug 2020 22:27:43 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k2Ka5-0006cH-PD; Sun, 02 Aug 2020 22:27:41 +0200
Date:   Sun, 2 Aug 2020 22:27:37 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v3 4/6] pwm: cros-ec: Accept more error codes from
 cros_ec_cmd_xfer_status
Message-ID: <20200802202737.4ftnva6x345ddkki@pengutronix.de>
References: <20200726220101.29059-1-linux@roeck-us.net>
 <20200726220101.29059-5-linux@roeck-us.net>
 <20200801072130.tmm7b4vtizshmmyo@pengutronix.de>
 <20200801163219.GA230759@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gyzpfjrxwbgaefsm"
Content-Disposition: inline
In-Reply-To: <20200801163219.GA230759@roeck-us.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--gyzpfjrxwbgaefsm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Guenter,

On Sat, Aug 01, 2020 at 09:32:19AM -0700, Guenter Roeck wrote:
> > If I understand correctly this surprising calling convention (output
> > parameter is filled even though the function returned an error) is the
> > old one that is to be fixed.
>
> Sorry, I don't get your point. This is the old convention, correct,
> which we still want to support at this point. Plus, it matches the
> current code, as surprosing as it may be.

OK, so I understood correctly and everything is fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gyzpfjrxwbgaefsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8nIbYACgkQwfwUeK3K
7AlpIgf/QRzJ1wUpff9rQuco3gAX0Q8PnlGIMy0x+36VjEaXUs0EaNnSQgaMxRiV
RNL99R4V3KQuMVUr1t/zDiJd9wOwyWpLSjxuOIuFZOcR2uPf98QwLicI+ydKEe0A
Na3dFO3Y1W5yWfRSzWvHAa1BZvQwcj4l8L/CodcUN2pKnMEvR46d5p2xZXOmRk7y
+TJRXoG0c4tlffsUyg89tYHdVuVwxqTnHh3JJoYgAidVppRGXzqbK7wEsTDXqfUb
t+csrf2Q/rs1bjcepqbbg4nz/cPC385CSpXfKvMqC5ElvDgE1UK6+1UGWKsA50r+
8YedjTyUxxCzOz+CCIL6YMPXjf30iQ==
=q7la
-----END PGP SIGNATURE-----

--gyzpfjrxwbgaefsm--
