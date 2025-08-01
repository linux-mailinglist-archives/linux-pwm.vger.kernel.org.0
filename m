Return-Path: <linux-pwm+bounces-6929-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5855B17FFA
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 12:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 448E41C223B4
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Aug 2025 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A030233715;
	Fri,  1 Aug 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz5q07GJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408220E030;
	Fri,  1 Aug 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754043112; cv=none; b=XAatORsp1WSTNBUSIxmR6aHJUkcis5zwy5URt4YndyOQIMDX8dCC/ak6koROwHeg0IG+tMzoa7nirjpTL0lQ0VrhtgptUgN2yiLs2gDksMcnz1/bd76x8M4pKnYId94aEdZ5aN81zV4j9evydY9BhLALnYCzAQa08I459M7j7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754043112; c=relaxed/simple;
	bh=emSfXgxgLE13qdHNoG4H5bIFSvoxwcECzeINaeEVYRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7UPjkTaRKAvV0crsum9AVpaTQxVsucxz8/TTFLhYsWYi2rzY0BRzU9ut1YZhbLfY05JJykxvnuwj0fi1B8Md5DAw58JKLD+V9oiYhIXFoy8HfL5buTN0B7NIyMbhAYbG17ojKGy1R1KmaauLhKPv1qAdSpZDnE6gyfam2uLyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz5q07GJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C549DC4CEE7;
	Fri,  1 Aug 2025 10:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754043111;
	bh=emSfXgxgLE13qdHNoG4H5bIFSvoxwcECzeINaeEVYRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sz5q07GJsgTqqkdMenDp3vnrAyom3IziUOdcb+iep8kxTMI/my/PYOEanQXh284Qt
	 mdA5ZAj7sUVg5gpNlnxi95F5ziHsHjpczCdKNGjfjt9BfqE7TwdPHT9nMDiUuQ01vr
	 W6S/u4lYnq1htAhq7CFA8hsTEbhil5pvQxEczUNjwcoRYc/H82cyuKC17PvPD3JVVc
	 g17rXskfOILO+3oLfMBvP2Raz5zXUDJwgFJfUsyzK4/cBMs7eP/85yuGiS2qEaGhUG
	 sWEQRDwaNboXcJcXOecz6tL6YBCmgVW0QLQt3OikwXoDSMADTm31TqHP9iqFWTTBbm
	 1xDXcrN1sCRTg==
Date: Fri, 1 Aug 2025 12:11:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v12 04/10] pwm: max7360: Add MAX7360 PWM support
Message-ID: <2msg7e7q42ocjewv35rytdtxwrfqrndpm2y5ustqeaeodencsd@nfdufgtevxte>
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
 <20250722-mdb-max7360-support-v12-4-3747721a8d02@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7segp7ac5cyefa5g"
Content-Disposition: inline
In-Reply-To: <20250722-mdb-max7360-support-v12-4-3747721a8d02@bootlin.com>


--7segp7ac5cyefa5g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v12 04/10] pwm: max7360: Add MAX7360 PWM support
MIME-Version: 1.0

On Tue, Jul 22, 2025 at 06:23:48PM +0200, Mathieu Dubois-Briand wrote:
> +static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct max7360_pwm_waveform *wfhw = _wfhw;
> +	u64 duty_steps;
> +
> +	/*
> +	 * Ignore user provided values for period_length_ns and duty_offset_ns:
> +	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of 0.
> +	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/256
> +	 * to 254/256, while value 255 will provide a duty cycle of 100%.
> +	 */
> +	if (wf->duty_length_ns >= MAX7360_PWM_PERIOD_NS) {
> +		duty_steps = MAX7360_PWM_MAX;
> +	} else {
> +		duty_steps = (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX7360_PWM_PERIOD_NS;
> +		if (duty_steps == MAX7360_PWM_MAX)
> +			duty_steps = MAX7360_PWM_MAX - 1;
> +	}
> +
> +	wfhw->duty_steps = min(MAX7360_PWM_MAX, duty_steps);
> +	wfhw->enabled = !!wf->period_length_ns;
> +
> +	return 0;

The unconditional return 0 is wrong and testing with PWM_DEBUG enabled
should tell you that.

I think the right thing to do here is:

	if (wf->period_length_ns > MAX7360_PWM_PERIOD_NS)
		return 1;
	else
		return 0;

Otherwise looks fine.

Best regards
Uwe

--7segp7ac5cyefa5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiMkuEACgkQj4D7WH0S
/k5GpggAoRMGf6bBt76DGferXRgCHrKnAuG70WtM4Ae+thaAxNDvteHX/NGrc9nv
CH3nIMUgYGFo8OtBBVJkHtlV/Bl44mbxk9cXLGOupuOoM3J2rHV3ex+kVJzYkT5b
j6nCZiDaDwu4G8KVN0I1o5sNam7BvUHo2kBSpyJrTcMKDtcGcKly2nS2y4RTJZ5w
n/Jip/bw0kOJIR9+n2tCwmkmHOH56WXFyMYjvqb8z1gdnr4F/tDp+XGuK3Fs2a1q
Bn1nqXtqJZWtoMIUWD943ekNcpYolqMkeM7SqEDuyIo6wpbKwMbNy//CIr/ZhSmb
7Qly62VCNOd/6dx4wssh+LMOgd5Png==
=y1VP
-----END PGP SIGNATURE-----

--7segp7ac5cyefa5g--

