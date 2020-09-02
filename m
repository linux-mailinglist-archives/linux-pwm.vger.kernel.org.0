Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED425B346
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 20:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBSAH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIBSAG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 14:00:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947E6C061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 11:00:06 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDX3D-0001GO-3u; Wed, 02 Sep 2020 20:00:03 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kDX3A-0000sJ-G7; Wed, 02 Sep 2020 20:00:00 +0200
Date:   Wed, 2 Sep 2020 20:00:00 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, kernel@axis.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, oliver@schinagl.nl
Subject: Re: [PATCH 2/2] pwm: Add GPIO PWM driver
Message-ID: <20200902180000.gvpdmybna4red2sx@pengutronix.de>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200814155513.31936-2-vincent.whitchurch@axis.com>
 <20200815075032.k2xyw75l56sbl7nx@pengutronix.de>
 <20200902121154.6bb5d5sqxwf2tmgt@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qupgqorf2fz4jqr"
Content-Disposition: inline
In-Reply-To: <20200902121154.6bb5d5sqxwf2tmgt@axis.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6qupgqorf2fz4jqr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Vincent,

On Wed, Sep 02, 2020 at 02:11:54PM +0200, Vincent Whitchurch wrote:
> On Sat, Aug 15, 2020 at 09:50:32AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Fri, Aug 14, 2020 at 05:55:13PM +0200, Vincent Whitchurch wrote:
> > > +static const struct pwm_ops pwm_gpio_ops =3D {
> > > +	.owner =3D THIS_MODULE,
> > > +	.apply =3D pwm_gpio_apply,
> >=20
> > Usually a .get_state callback is nice. Does it make sense to do
> > something like:
> >=20
> > 	if (driver is up)
> > 		report current setting
> > 	else
> > 		val =3D gpio_get_value()
> > 		report(period=3D1, duty_cycle=3Dval, enabled=3Dval, polarity=3DNORMAL)
> >=20
> > ?
>=20
> I implemented get_state() but I didn't do the gpio_get_value() thing
> since the driver sets the gpio to a known value in probe().

This however is wrong, .probe() is not supposed to modify the output.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6qupgqorf2fz4jqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9P3Z0ACgkQwfwUeK3K
7AkAWgf8CaJSHXSDJHLXeccuVtuLMAI9klF8NshwoA489xmoj+fwyRxeT6cbxuez
ZfiuOHTTo+Oh4KrdMnfogKgh2F+ddTLWOQikM2nuJ0d5pt2xR+KS4xzizjMTXEnd
0kmgIPp4f/PdbsAdLRdG1CFggYMjthizbRqKmiS2qZjkS4GkgrpX39A5cKFZpwfP
1wUNN/1VrGxeZNOFrEkiqdO6Fw6pbVR63M0g5uW6buwvaZYM8WP+unqdJruDHyiW
ZNlLXInCRWO7N8OSegx88g/DaXpa7yluEUPXxxUGDr0z1B4+frFG2jW9BceC5PLs
8/t74enGXwpeJ4KmmWz9SrZnkkdXcA==
=iNyx
-----END PGP SIGNATURE-----

--6qupgqorf2fz4jqr--
