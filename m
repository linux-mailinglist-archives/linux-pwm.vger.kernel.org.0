Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF323E0BC
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgHFShy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbgHFSfp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 14:35:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51830C0611E0
        for <linux-pwm@vger.kernel.org>; Thu,  6 Aug 2020 11:35:24 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3kjS-0004BS-94; Thu, 06 Aug 2020 20:35:14 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k3kjR-0007aU-Sj; Thu, 06 Aug 2020 20:35:13 +0200
Date:   Thu, 6 Aug 2020 20:35:13 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] pwm: cros-ec: Accept more error codes from
 cros_ec_cmd_xfer_status
Message-ID: <20200806183513.nbaeonm5sevjvxkb@pengutronix.de>
References: <20200806153308.204605-1-linux@roeck-us.net>
 <20200806153308.204605-5-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="prp6ta2dfdqjn5v6"
Content-Disposition: inline
In-Reply-To: <20200806153308.204605-5-linux@roeck-us.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--prp6ta2dfdqjn5v6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 06, 2020 at 08:33:05AM -0700, Guenter Roeck wrote:
> Since commit c5cd2b47b203 ("platform/chrome: cros_ec_proto: Report command
> not supported") we can no longer assume that cros_ec_cmd_xfer_status()
> reports -EPROTO for all errors returned by the EC itself. A follow-up
> patch will change cros_ec_cmd_xfer_status() to report additional errors
> reported by the EC as distinguished Linux error codes.
>=20
> Handle this change by no longer assuming that only -EPROTO is used
> to report all errors returned by the EC itself. Instead, support both
> the old and the new error codes.
>=20
> Add a comment describing cros_ec_num_pwms() to explain its functionality.
>=20
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--prp6ta2dfdqjn5v6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8sTV4ACgkQwfwUeK3K
7Ak7Xwf/bIpQ0ms3aJzAL2lKasQAGjulu7pJpdL40M8US0eyiWsAEWMEbxFoO7Ha
W2ICAFrAFn6KUTuSPzSOIWOxqcxKE4uDxXKTvh98I9FkFXAY7VKFn32Dbshh+hhZ
7NxJfdO7YM1evP67JxWrADaNlKbRij0KSGRPFnJ3mzt4XaiDCdUJX3opo9cyDglP
rX8m/vpdUF8GDgCyh9YjskLqEV56kEzb0WNEVc9jqwkuMEQ6g2silpvtmFnbPpa3
ZmCPcH2eOqz61dAOdjPdCGAeQmTY7zrXBkw2I4zXWButDK4/9q7yelYOISMMkrO1
qohHip3HBU5CTDOp52IMtEWlkZauTw==
=x1Y7
-----END PGP SIGNATURE-----

--prp6ta2dfdqjn5v6--
