Return-Path: <linux-pwm+bounces-2060-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F08B0311
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 09:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A261C2426B
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 07:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EB1157E78;
	Wed, 24 Apr 2024 07:19:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DC9157E6F
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943183; cv=none; b=Ix2kyjQgG/yAupNNpVn+AFrmfp/p8RRTtqumqgIsEM0mDFQnh3tbqj318PWrTTC7rI7Jcb9GZRq8mema5dPHY9PMuTHJNbjnw9yQm7Pxlvfm5oXJukQZC7vGJFcSuOx3FnvM1ogNLToaoQyHxD6durpZRGZg75gW0RRY5vbqG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943183; c=relaxed/simple;
	bh=peBdXF+tZbOPnP/wixBXjaNOlL9aVdZLMZ7AgmJF0Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP745qvXuI2NSoS8vAqPKsTUflxRp38HAmdaEKZXvsIEsHPO10UmwL6+jMzdqTSimHpZQZfo2Bb7Rx0w5q9JenDyxoHZtxLCu2XqT2R+wm0qIsSxcXoqqlpCw66gzAJkTimz/KFbOlj5DwhE1rKM5X0aKtQNUjDb21e6TcmDgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWul-0003XV-IH; Wed, 24 Apr 2024 09:19:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWuk-00E2OB-Mt; Wed, 24 Apr 2024 09:19:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rzWuk-007gCX-20;
	Wed, 24 Apr 2024 09:19:34 +0200
Date: Wed, 24 Apr 2024 09:19:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: George Stark <gnstark@salutedevices.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, jbrunet@baylibre.com, 
	martin.blumenstingl@googlemail.com, thierry.reding@gmail.com, hkallweit1@gmail.com, 
	linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@salutedevices.com, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [PATCH 1/2] pwm: meson: drop unneeded check in get_state callback
Message-ID: <wkn6ybnnlco7vrqbpclfxaajt5cvywpr633au7qcr6vpjihabq@kb7q6y4khh2k>
References: <20240423161356.2522636-1-gnstark@salutedevices.com>
 <20240423161356.2522636-2-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3xwbvuajde4meb2t"
Content-Disposition: inline
In-Reply-To: <20240423161356.2522636-2-gnstark@salutedevices.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--3xwbvuajde4meb2t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello George,

On Tue, Apr 23, 2024 at 07:13:55PM +0300, George Stark wrote:
> Drop checking state argument for null pointer in meson_pwm_get_state()
> due to it is called only from pwm core with always valid arguments.
>=20
> Fixes: 211ed630753d ("pwm: Add support for Meson PWM Controller")
> Signed-off-by: George Stark <gnstark@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>

I'd apply this one with the following changes if you agree:

 - capitalize "drop" in the Subject line
 - s/get_state/.get_state()/
 - make "null" all caps (i.e. "NULL")
 - swap the order of Signed-off-by lines to have yours last.

Alternatively send it in a v2 together with addressing the comment in
the second patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3xwbvuajde4meb2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYosoUACgkQj4D7WH0S
/k7G1gf+PGBuQXOKBKGgHuOhdu/hGX+YqKlLX7bGKVF4a/6Hj5zjVxP2W2WeOd42
o5lwOx0Aby2qxA2/greyP1XODpf86xX9J5CPuk0h9haNt10XVsLP+tzX0bpgorYY
ltKCskC3VzFM4L+l7tiSF+8478kLzjpzwKR/lg1jr6ib5IH8g/riSNpJekMstrK6
FUnzSKBW1r01wv8T7OW+cy3f35ygttE//Bii1OSiEGqU/gtouoEtoy2AKZrIwCuP
C28ArBOOsUmbVTW/0U9g7wakmNlxaLVqC8kJPVrG4cz5ndaDczWjQV02MlbvrkO/
XaP6LMwi1REygGrxkME/m1VxDaxEVQ==
=gKa2
-----END PGP SIGNATURE-----

--3xwbvuajde4meb2t--

