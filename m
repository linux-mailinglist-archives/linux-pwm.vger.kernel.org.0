Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DC22E82E
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 10:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgG0Isc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgG0Isc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 04:48:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA1C061794
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 01:48:32 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzyoA-0002oQ-HE; Mon, 27 Jul 2020 10:48:30 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzyo6-000296-Le; Mon, 27 Jul 2020 10:48:26 +0200
Date:   Mon, 27 Jul 2020 10:48:26 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, linux-pwm@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200727084826.vwnnvdzi2ldpgvcg@pengutronix.de>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-7-michael@walle.cc>
 <20200727073027.GA2781612@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="amgrwuxc4vqaa7rq"
Content-Disposition: inline
In-Reply-To: <20200727073027.GA2781612@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--amgrwuxc4vqaa7rq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[stripping recipents as most probably won't be interested in this]

Hello Thierry,

On Mon, Jul 27, 2020 at 09:30:27AM +0200, Thierry Reding wrote:
> On Sun, Jul 26, 2020 at 01:18:27AM +0200, Michael Walle wrote:
> > +	/* Polarity inversion is not supported */
> > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
>=20
> Just a note to myself since this just occurred to me: in the legacy API
> we used to have a ->set_polarity() callback that indicated whether or
> not a controller supports inversion. Since that criterion can no longer
> be used with the atomic API we may want to consider adding some sort of
> capability flags so that these checks can be performed in the core.

I'm not (yet?) convinced this is a good idea because these concepts are
somewhat blurry. For example a controller that only supports normal
polarity (probably) still can generate the wave corresponding to:

	.enabled =3D true,
	.polarity =3D PWM_POLARITY_INVERSED,
	.duty_cycle =3D 0,
	.period =3D 5000,

and unless we refuse this request at the core level (should we?) the
driver must be aware of .polarity anyhow. Ditto for .enabled =3D false.

> Looks good to me. I assume Lee will want to merge this along with the
> other changes through the MFD tree? If so:

I'd like to have another go through the patch. Will do so (hopefully)
later today. So please don't apply yet.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--amgrwuxc4vqaa7rq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8elNcACgkQwfwUeK3K
7AmE7AgAln2mlNddqAYsPqfoJDb6iz8dl3auioilYydesVa5QtWVud5nkjF/Oqj9
AmFrEFgAJjw2hfBM1e8H9hil1PEXEm4BNVWUG+V+8V/IPRbfVBciRgGfaSkaXlno
4peGBVsZ8ugh9Dx8flJW04SlAkw3z7WGnNp2Cpyt7JupYqzqbMBaesHjJ+Sb7yNA
lxNe5VAPD0fpscRnpSLk3k1k7YgjmrUYd1yc4kCoUiySp1Kj7xDbXL/wQqXY4sCc
Yfb+tbsQEPObBqXym7drSV37wVlqjykZqSqRggekdA2gyjy6ObYt0R0yNiYvlmj/
KaZThss+ZXDIhOib7wormYYore3+Rg==
=xvXM
-----END PGP SIGNATURE-----

--amgrwuxc4vqaa7rq--
