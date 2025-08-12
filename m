Return-Path: <linux-pwm+bounces-7029-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F9B239D8
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 22:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD02D62139D
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481B225EF81;
	Tue, 12 Aug 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSYItNaT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6922F068F;
	Tue, 12 Aug 2025 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755029741; cv=none; b=ZNf5gQH+zriVgRwwDfSRVChqvzIWrwksVQ6H5iXCxrQAaXYOkK6n3D2vA3JrAgQJMvqbc11yRMauXT41kjifqfNXjzrgI0d1BRK8JMtYxtSIfQWeqqYd6zu1iru4rj137ut+51Tv3R5XUb+NchEe1s4l1nkm9wWXPxt7FFIbbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755029741; c=relaxed/simple;
	bh=EkRl3IJt0CeCAJlRL+5sBAuUy8C27QEY9r9+qlE9Gcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8vR0lU/ZCSQcJtety26D5Q0K8IO0ANtB/tQJXmFfzVOclDzLVyUv7bocuSSs8GNzc8qCZWz7eAw6HIojw32XyHFBpzkGPQdRtJ4JfMo/Hp0xowyyZFu9Nj84X6YvUUWN+hXm2leqqYdvFOedtjFqCynpMZHzLsQUjFZwajX6kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSYItNaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18303C4CEF0;
	Tue, 12 Aug 2025 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755029740;
	bh=EkRl3IJt0CeCAJlRL+5sBAuUy8C27QEY9r9+qlE9Gcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSYItNaTzGGfcalWZeqUx64xvLKqZwiq0tp2xj6hhakS5XJwDjwK26xhmChbdJY3T
	 BpNzHF2CmmuPPsJ6z9DPclMVgv0fZpUvoFp+6x0Dh9MCkegEj0lnavVgaGMz+ABhdh
	 wCfCi/TcCfwo24Th0IShklnnVX7EvDukhv3NQWyt+4NoyXsRKCQklzCEJuFOXyO0Tg
	 TGVuZzIkC4c4VbXj9Mi9KwCebvg72CNljXT6wBxCQa2rEd36ey5vYLLytoGwhrDNS/
	 9hrI0oEgIWf7dutW4dWOWvsFA3pBMUj/AI+168Mo4y0XJkYWKHxda8xjDLRgxuIVwD
	 bQ2UuiGDJ9IsQ==
Date: Tue, 12 Aug 2025 22:15:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	nicolas.frattaroli@collabora.com, Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
Message-ID: <ztjkhfhr4oyqgarh4wrqtcgu4gh3fqnfnakdx34wlj37ggpiin@fibgy2g4zldp>
References: <20250808223033.1417018-1-sashal@kernel.org>
 <c5s7efnva5gluplw65g6qqxjqpmcgprgtm6tsajkbdqibe73lb@lw5afb6b725i>
 <2025081236-moneyless-enigmatic-891b@gregkh>
 <tjogt2ovj4afxo3lz7ydwsqtk4b52gjvga47es6x3ogdbfopyb@weiw3effavjh>
 <2025081209-vista-preorder-bd6f@gregkh>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h2q4nioysagcscim"
Content-Disposition: inline
In-Reply-To: <2025081209-vista-preorder-bd6f@gregkh>


--h2q4nioysagcscim
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Patch "pwm: rockchip: Round period/duty down on apply, up on
 get" has been added to the 6.16-stable tree
MIME-Version: 1.0

Hello Greg,

On Tue, Aug 12, 2025 at 12:53:49PM +0200, Greg KH wrote:
> On Tue, Aug 12, 2025 at 12:36:48PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Aug 12, 2025 at 10:53:11AM +0200, Greg KH wrote:
> > > On Sat, Aug 09, 2025 at 11:45:23AM +0200, Uwe Kleine-K=F6nig wrote:
> > > > while the new code makes the driver match the PWM rules now, I'd be
> > > > conservative and not backport that patch because while I consider i=
t a
> > > > (very minor) fix that's a change in behaviour and maybe people depe=
nd on
> > > > that old behaviour. So let's not break our user's workflows and res=
erve
> > > > that for a major release. Please drop this patch from your queue.
> > >=20
> > > Now dropped, but note, any behavior change is ok for ANY kernel versi=
on
> > > as we guarantee they all work the same :)
> >=20
> > Your statement makes no sense, I guess you missed to add a "don't".
> > Otherwise I'd like to know who "we" is :-)
>=20
> {sigh} yes, I mean "any behavior change is NOT ok..."

Ahh I though you wanted to say "any behavior change is ok for ANY kernel
version as we don't guarantee they all work the same". So let me explain
a bit:

A PWM consumer (think fan driver) gets an opaque handle to the used PWM
device and then requests something like: "Configure the PWM to have a
period length of 50 ms and a duty length of 20 ms." The typical PWM
cannot fulfill the request exactly and has to choose if it configures
(say) period=3D46 ms + duty=3D16 ms, or period=3D52 ms and duty=3D26 ms (or
possibly a mixture of the two, or an error code). Traditionally each
driver implemented its own policy here and so the generic fan driver
knows neither the possible hardware restrictions (another hardware might
be able to do period=3D51 ms and duty=3D19 ms) nor how the driver picked one
of the options. Making things harder, it depends on the use case which
policy is the best, which also explains that different drivers picked
different algorithms. And also it's unclear even what "nearest" means.
For example a hardware might be able to configure period=3D17 ms or
period=3D24 ms in reply to a request of period=3D20ms. You probably say that
17 ms is nearer. But if you think in frequencies the request of
period=3D20ms corresponds to 50 Hz and then 24 ms ~ 41.6667 Hz is better
than 17 ms ~ 58.8235 Hz.

To improve that situation a bit at least new PWM drivers are supposed to
round down both values. The commit under discussion modifies an existing
driver to align to that policy. So from a global point of view this is
an improvement, because it makes things a bit more deterministic for a
PWM consumer that doesn't know about the hardware details. The down side
is that a PWM consumer that does know these details might depend on the
actual implementation of the previously implemented policy.

So this is a change in behaviour, but it adds to the consistency of the
PWM framework. If you want to make an LED blink or drive a fan, that
(most likely) doesn't matter to you. If you drive a robot arm in a
construction facility, it might.

The mid term solution is a new PWM API that gives more control to the
consumer. The framework bits for that are already done and three drivers
are implementing that and two more are in the making. (And if you use
these with the legacy consumer function you also get the round down
behaviour.)

Best regards
Uwe

--h2q4nioysagcscim
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiboOYACgkQj4D7WH0S
/k5adAgAtbv00nouwE13QCEsW2Oi0H0NXyXNfEPwFVcRvAWnY+0Ephq8i+aIYke4
Fr7eCNHaTaHbgVyBzI0I+OXnT7tO4L/R58QR9nD+RDHeHFY11GxGZUzLeLtqYO4n
4TpGhzhXsowS4IOw1ucgUW0qYKtnxNDJQUSB6F8RJTtbm0dM7CzotaM9aTxHPR/4
HM+DY3LWovU0Zju5UWuPiR7L+AVGy+zaw5lQ24GKk+PM/4jPKVDqGV72PZZItZ9E
nJT4HFgCSOfThvgA4yMy/tKe1EsPBOCaDe1rT5USyhCcGA5hO6u+oQxfygK/Tbam
6Bf3Td6j5J0rXQvmoL5gEx9cNos9WQ==
=qTEt
-----END PGP SIGNATURE-----

--h2q4nioysagcscim--

