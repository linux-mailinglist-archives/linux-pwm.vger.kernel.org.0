Return-Path: <linux-pwm+bounces-1931-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945558A3BE6
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 11:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41CAD283742
	for <lists+linux-pwm@lfdr.de>; Sat, 13 Apr 2024 09:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E37F1DFEF;
	Sat, 13 Apr 2024 09:22:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783818B14
	for <linux-pwm@vger.kernel.org>; Sat, 13 Apr 2024 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000161; cv=none; b=k55EUG1/YTmF2cWrTHgypbZVoCVIOnyVit2Q8qMnRIkuWfy5lzfTjyC2AjFGjARBUxtpFKUgVJZlZfIqgR5+TVOApgrqRdhcRwSre0AB5xf0YRXuEKsp+JT9dYMSFMZ4+o9VNDrhsPQRfGTY0E6dWgUtSOPQZB52vyPcRRgJrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000161; c=relaxed/simple;
	bh=NhoRlOub3hGY2Wr6gMKhXt1Pu/YNnisEixCIxNzqyqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKobtkkwMXl8vu5i4pvRd6Y4ZGnxw+wEjQXulEj4Ju06Mpl/+g/mIhQi9vhhtnU5yvoOsAS2ty1rh8/fzfYz6cK6JP5TLibIzpQouctLqtpj6WDZtzsIIFEq1SeHbMT3FdaX3C0kV/w1hnKQQBcR7dOSPzeGmVMBAVTTB+V/XhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZam-0003nZ-JX; Sat, 13 Apr 2024 11:22:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZaj-00C2Nu-NT; Sat, 13 Apr 2024 11:22:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rvZaj-000hEY-23;
	Sat, 13 Apr 2024 11:22:33 +0200
Date: Sat, 13 Apr 2024 11:22:33 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	kernel@pengutronix.de, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	John Ernberg <john.ernberg@actia.se>, Thorsten Scherer <T.Scherer@eckelmann.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 0/8] pwm: Add support for character devices
Message-ID: <ywvi3wqcte5wfwq7twg26smtu7rgjv5z2tbdu6mz5cehjlxf72@2h77sey4xsv2>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zj47uaeekg2t34wy"
Content-Disposition: inline
In-Reply-To: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--zj47uaeekg2t34wy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Mar 17, 2024 at 11:40:31AM +0100, Uwe Kleine-K=F6nig wrote:
> After the necessary changes to the lowlevel drivers got in for v6.9-rc1
> here come some changes to the core to implement /dev/pwmchipX character
> devices.
>=20
> In my tests on an ARM STM32MP1 programming a PWM using the character
> device is ~4 times faster than just changing duty_cycle via the sysfs
> API. It also has the advantage that (similar to pwm_apply_*) the target
> state is provided to the kernel with a single call, instead of having to
> program the individual settings one after another via sysfs (in the
> right order to not cross states not supported by the driver).=20
>=20
> Note the representation of a PWM waveform is different here compared to
> the in-kernel representation. A PWM waveform is represented using:
>=20
> 	period
> 	duty_cycle
> 	duty_offset
>=20
> A disabled PWM is represented by period =3D 0. For an inversed wave use:
>=20
> 	duty_offset =3D duty_cycle
> 	duty_cycle =3D period - duty_cycle;
>=20
> . However there are some difficulties yet that make it hard to provide a
> consistent API to userspace and so for now duty_offset isn't (fully)
> supported yet. That needs some more consideration and can be added
> later.
>=20
> A userspace lib together with some simple test programs making use of
> this new API can be found at
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git
>=20
> .
>=20
> The start of the series is some cleanup and preparation. The lifetime
> and locking patches are needed to not crash the kernel when a character
> device is open while a lowlevel driver goes away.

This series is already in next for some time, but I'm not sure that I
want to really send it to Linus in the next merge window as there are a
few issues with it:

 - A (false positive) lockdep warning reported by Marek Szyprowski.
   See https://lore.kernel.org/all/5a49cadd-21b7-4384-9e7d-9105ccc288b3@sam=
sung.com

 - A speculation warning flagged by smatch that I don't understand
   completely yet (and failed to attract attention by people that know
   more about about it)
   See https://lore.kernel.org/all/1e3dc81d-dcd4-4b04-85b1-23937e2f0acd@mor=
oto.mountain

 - I'm a bit unhappy about the rounding behaviour. Actually I'd like to
   only provide userspace access via the character device to drivers
   that adhere to the rounding rules for new drivers (that is: First
   pick the maximal period that isn't bigger than the requested period.
   Then for the chosen period pick the maximal duty_cycle that isn't
   bigger than the requested one) to give a consistent behaviour. This
   is further complicated by the fact that the character device exposes
   a more flexible API (involving a duty_offset instead of polarity) and
   the natural extension for the rounding rules with duty_offset is
   different than for inverted polarity configurations.

I currently consider introducing a new callback that in the long run
should replace .apply() and that properly implements the duty_offset
stuff. Then the character device could only be provided for the drivers
implementing .apply2().

I'm open for feedback, e.g. suggestions for a better name for .apply2().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zj47uaeekg2t34wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYaTtgACgkQj4D7WH0S
/k41GggArwCz04UM8XYP40a2/xPS4R0IFZU9g8hFxLKfZke42KtDgVJp84tyvxRk
Ce74eLiOxvzP9iMUB30qYalIWscFxabpizkVnXXVYOrKGrrCb4vKW/x2/LYYy3My
9UDrF5YndTxX3Y9wI8TH6YXn6nKN14Lwr5iw3lrbhH3T3g4XODyiRJuaVgbcgn81
Xz3mwGljML/9wV2dYN5gNQPuhi/1h1KgMCE5m7Hz3LNmNp0GAwxYE3CM+sAaaEVE
PG9uJSi+tFUv9lscozE9qWjD7NbN9ZZ6LoA+fBeHOnM0rU5Z0IUbu1/p6U0MoVTF
zJxMjSxvnSYNUkBzCfjLeej3Spk+pQ==
=QS8z
-----END PGP SIGNATURE-----

--zj47uaeekg2t34wy--

