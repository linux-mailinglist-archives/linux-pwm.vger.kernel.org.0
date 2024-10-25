Return-Path: <linux-pwm+bounces-3872-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F379AFD8C
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3B0280985
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 09:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0141D4610;
	Fri, 25 Oct 2024 09:03:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1591D5161
	for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846985; cv=none; b=tHA4G0kxPqMGoLEBDBCFgR6tUkAkZDasDlhdZLyVpMA6tlhcCDZKLx5OspDz2QoAnr2j9OM3oiD/keHbhhsN9BhO/fF9eQiQrK6Bn9WC/yFKrJ7SfRYyjoOBEv9Wv5S71KbMklrmUJSJdDZus/8ioHOEQ+T6VF9rjjtYuvQRul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846985; c=relaxed/simple;
	bh=MSNa8VidgGFndoM5D+stANMch+8+eFrp9sAOIyBpKWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqpy0CLBkVjSFf/T8CSmClWTkos0JmBnnA8a4g7OK4m14Zc0wPqD+C6haK6KzcCyx3omMZHpdYM45W9nErJ2s3oQ78LNPM4g4KzxiGxtKnuFZOsYIP9sc+8avOJKFW7D7Ni98/A4yN8h262wLVOyH5J6v3JfORoyU1Pvp7J0WWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4GDF-0002Vw-3H; Fri, 25 Oct 2024 11:02:29 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4GDD-000KtQ-1v;
	Fri, 25 Oct 2024 11:02:27 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 163F235E85E;
	Fri, 25 Oct 2024 09:02:27 +0000 (UTC)
Date: Fri, 25 Oct 2024 11:02:26 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, linus.walleij@linaro.org, 
	brgl@bgdev.pl, andi.shyti@kernel.org, mailhol.vincent@wanadoo.fr, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, wim@linux-watchdog.org, linux@roeck-us.net, jdelvare@suse.com, 
	jic23@kernel.org, lars@metafoo.de, ukleinek@kernel.org, 
	alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
Message-ID: <20241025-dark-efficient-bird-6b09b9-mkl@pengutronix.de>
References: <20241024085922.133071-1-tmyu0@nuvoton.com>
 <20241024085922.133071-2-tmyu0@nuvoton.com>
 <20241024-adventurous-imaginary-hornet-4d5c46-mkl@pengutronix.de>
 <20241024-pumpkin-parrot-of-excellence-299c57-mkl@pengutronix.de>
 <CAOoeyxXX2fpHVJ8urLmy+pBjH1aRdYu6qrtwOmwUxTUyQq30DA@mail.gmail.com>
 <20241025-sexy-fanatic-snail-a1d2e7-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvvsexv3tqputmip"
Content-Disposition: inline
In-Reply-To: <20241025-sexy-fanatic-snail-a1d2e7-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--hvvsexv3tqputmip
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/9] mfd: Add core driver for Nuvoton NCT6694
MIME-Version: 1.0

On 25.10.2024 10:35:35, Marc Kleine-Budde wrote:
> > Excuse me, I'm a bit confused. Is there anything I need to
> > improve on?
>=20
> It looks racy to _first_ add the devices and _then_ the workqueue.
>=20
> So the obvious solution is to allocate the worklist first and then add
                                             workqueue
> the devices.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--hvvsexv3tqputmip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcbXqAACgkQKDiiPnot
vG/v8gf/ZnYZ8UX7isWhAOloRjzqHr1tCeRD0dNOcVRIA2O5jDm1vOg1oHVf4tCm
Y+crw/DQeALVVHoLDLru8STjvEbqTt2x/b88OletCJHckvwLapQaQsRUhX1RHJtp
W3PaKTZPAFpjFdATjCEhrPPX73bJzok9lExwap2uF0R7dzv/XCz5tnVsVqKCp4lu
MhhEesF7ssLrmU5lvCmRj3iw8yssq1sGuPjYRyfL81VameNbcXdzpl//GGx3XBOC
pCYZ1iaK/KuzfSaDtR18JzOiG8o68WkIRDAJUDWRt+OoSg04EcPkma4MONH+uHqt
Ddg9vZTO2m/TN/IbNekjrp0BdO6nqw==
=BAyk
-----END PGP SIGNATURE-----

--hvvsexv3tqputmip--

