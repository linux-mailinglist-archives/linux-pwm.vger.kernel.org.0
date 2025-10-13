Return-Path: <linux-pwm+bounces-7446-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE7BD22CA
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 772DA4E6563
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Oct 2025 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A002FA0F3;
	Mon, 13 Oct 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnYVfmsw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996B19E97F;
	Mon, 13 Oct 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345921; cv=none; b=bEE9kY6kUX8ElJNPsJENNLmJquJdBeKm76Vtu/qXQyBx1Hb8fcos9bax9wDzxOV0/aybm4VqXhSeBPYkpK6GNwky+NzjqIzFObnatuG83G6k8b+lqFGnJCwNvh7DedQ/uQrSppaSpa6vdOmuVH66W4LcYyKPlBNfAG/7xvxL7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345921; c=relaxed/simple;
	bh=DH6sklj59YGFbOQd5rlZb56DVFrtEVgWWMTT5kejDjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6vWisXim/jJ5jNB9BczFYmxS1vNQLVNInLC0dPolsN54lxgM4ss7NgFd7dmpLVbw0Hc3ZJxOJ1d/0zXERPS6grWi3U3Bf887pNUF0Ix0tKneJao+xF46e2tBKVhu5bRfFgkPIXDXuFVfloQyy9rG7gApkdDJnprgJ2tzfDFivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnYVfmsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62FDC4CEE7;
	Mon, 13 Oct 2025 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760345921;
	bh=DH6sklj59YGFbOQd5rlZb56DVFrtEVgWWMTT5kejDjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnYVfmswyDLYsLZ339Bh2RM/wHopRsDoeGUAduANNNOlqAzfkpApM61NZIyMTP8Ql
	 nPUCVv4g9PqCoY7JxILu8XvHinpE9Opa5srG5T6h8BB3hQJDW/2b0PlG/7bmq/zjAb
	 SllStGpOFBdRKgML1vRJXA3N8Df83BRTZbQFx1hrDRsFJMmGqo2Olw+a2lDEjJlUnI
	 E9P7SfSW2EeKIjuEqg7JJ7F1AbtwVm5u2gtFyCuKJhzWQNkdKSPvZBR0gL6RetAipB
	 2Cn/827Ol7fkUYZdJzIh9r/AUzNOopf1g1A0fbpc0lh0MlYlvYqfh6xNpR+ETDkM6K
	 FFnDmhRal482w==
Date: Mon, 13 Oct 2025 10:58:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com, 
	eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4 1/8] pwm: Declare waveform stubs for when PWM is not
 reachable
Message-ID: <xklptdwk7skvil6axqeef5xs7jqeotbo5g6r62tvdfpluzozfe@sdrmdzmxoz7x>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <129ff5c5b7f7be4f4f3f9cf8aa3e1957d713acb7.1759929814.git.marcelo.schmitt@analog.com>
 <cuq6eh3vcrkgr7tj3xpo7ax4ruiy4ra6fjxgu45a3eqs2jbtah@ualgnhdwxnih>
 <3cb110ab-05e5-42c3-859d-34df721d98f2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kj7yi3qsfu3mpkdr"
Content-Disposition: inline
In-Reply-To: <3cb110ab-05e5-42c3-859d-34df721d98f2@baylibre.com>


--kj7yi3qsfu3mpkdr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/8] pwm: Declare waveform stubs for when PWM is not
 reachable
MIME-Version: 1.0

On Fri, Oct 10, 2025 at 11:34:49AM -0500, David Lechner wrote:
> On 10/9/25 11:58 AM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Wed, Oct 08, 2025 at 10:49:44AM -0300, Marcelo Schmitt wrote:
> >> Previously, the PWM waveform consumer API would not be declared if
> >> CONFIG_PWM was not reachable. That caused kernel builds to fail if a
> >> consumer driver was enabled but PWM disabled. Add stubs for PWM wavefo=
rm
> >> functions so client drivers that use, but don't depend on PWM, can bui=
ld if
> >> PWM is disabled.
> >>
> >> Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for wave=
forms")
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lk=
p@intel.com/
> >> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> >> ---
> >> I've included this patch in this series because it should save us from=
 being
> >> notified by 0-day about the build failure this patch fixes. From contr=
ibutor's
> >> perspective, it's easier to have this patch together with the rest of =
ad4030
> >> series. Though, no objection if kernel maintainers decide to pick it [=
1] through
> >> the PWM tree.
> >>
> >> [1]: https://lore.kernel.org/linux-pwm/1ac0fc529e02744aacfcb9140ed597f=
f60886f39.1759873890.git.marcelo.schmitt@analog.com/
> >=20
> > TL;DR: nack
> >=20
> > I replied to the original submission about why this patch is wrong. See
> > there for the details.
>=20
> If we want to avoid this patch, then it sounds like we should use:
>=20
> #if IS_REACHABLE(CONFIG_PWM)
>=20
> in the ADC driver around any PWM waveform code.

Or use IS_REACHABLE(CONFIG_SPI_OFFLOAD_TRIGGER_PWM) which might be
nearer to the actual dependency. (Hmm, but looking in the driver, it
handles the pwm device and setting directly, I would have expected that
code specific to SPI_OFFLOAD_TRIGGER_PWM does that and the driver
doesn't even see the pwm.)

Or make the driver depend on CONFIG_PWM, which is cheap.

Or if the PWM support is really optional, convince me to add the stubs.

Best regards
Uwe

--kj7yi3qsfu3mpkdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmjsvzsACgkQj4D7WH0S
/k56bgf/WSWV81G7CodoWUzNZZcBIxEXAYFtv7+fsWeLG81ByuKhZ+VV8Gms1I4O
10YbsnH5lk+y5ZZzVSfYfgo9bOkbi1n17t4BwXLXiJGz7Zpu/vbgyQmVonmQ/pUm
yBn/z8w11IdBVf5GzUm1+mUuP2w3eUkCVeimDlLquB9dGuFo9risBsV6hTEdZ2Lz
JQ/pKnZraYjlLpkPxyA1GloJ7VLlaDCQlD7dSRBkrcDO+yaYbQ9NLLaJZllHRFxt
kSWmjVsSYW6yLRfhramKupP5f6iXlxOFsSw+GSpPp1MWMxZwplPcfmPup+WvoduN
wpL4bxLtovtEZV80Dy6c8rqdPEEs3w==
=8Xqr
-----END PGP SIGNATURE-----

--kj7yi3qsfu3mpkdr--

