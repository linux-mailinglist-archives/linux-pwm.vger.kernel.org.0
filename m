Return-Path: <linux-pwm+bounces-8351-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF50DO3DwmlflgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8351-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 18:03:41 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1F3199FE
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 18:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACB8530C0006
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6F3FEB0C;
	Tue, 24 Mar 2026 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W13BeOL/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DB239D6D2;
	Tue, 24 Mar 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370761; cv=none; b=iYsUfXPwys/lDesSajpzl8bzslxW7hlCYWUrCwCvfbHf/wl81gebDkX3/vIUxk9kHDwUA27UXwJijI69ZeYOpTOYkAQKW+oO03Sn+kGueioAIizri/bGNEc5yx9HHldXSunCtWpUtE/dStgTAaXqwDlvDdBvS/ZoJZGTP8Id/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370761; c=relaxed/simple;
	bh=mps0Jzaa87vZjkX3oRbc3hBqAAt/2vdzpyMiDDGWu/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APtvHKZ2cImzhLqASDxkP0uj0sF9kxBlmomHOjjyuV4hTClmgAdtmfWSkMA2Ys4ZAvMBMnv+QxIAb0ZsUSWfB7iecYmv8pnouvrfKvlik4YgmTZCeUQTdQWUAAIGFvJOczvIdPL1gwhW5iHWrEKobEy5OKzt3ZxfWnjr7TeRfeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W13BeOL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A87AC19424;
	Tue, 24 Mar 2026 16:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774370761;
	bh=mps0Jzaa87vZjkX3oRbc3hBqAAt/2vdzpyMiDDGWu/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W13BeOL/QJAFbSH8YWx8Oi3fuu6vpMWiqeEyLmrXiW/vii8oI13sWlgXkYHkNLSNq
	 LH5ABjgTvQEe7GfEIEcYaI5aS6OWPiz0ZQjK9OsvMuO7JYavgbydvlDeVMqv3ddVvw
	 uyzZbe0lUIeKv5u45kZJRGsBaDTSucfphEsi8hJMh2jgorOtC4WzP7rkPRgnGw6ZzF
	 Vh2WrZyabTjh6ECpXyr6v3bqHiJiuXUZQOObzlW77jW5FCSN254ku902MYFWVlw1JA
	 6DQdLtcJm2a5pjwirBxGgLFdceJhXAOSPHEcU2b1GgsLTPG7f+MsrRWuwDRdrsr07j
	 GGMwK16AgX/4g==
Date: Tue, 24 Mar 2026 17:45:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH 0/5] Tegra264 PWM support
Message-ID: <acKi4_RPGZnkHFZU@monoceros>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c3pivq2irjszuqua"
Content-Disposition: inline
In-Reply-To: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8351-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84B1F3199FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--c3pivq2irjszuqua
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/5] Tegra264 PWM support
MIME-Version: 1.0

Hello Mikko,

On Mon, Mar 23, 2026 at 11:36:36AM +0900, Mikko Perttunen wrote:
> this adds support for the PWM controller on Tegra264. The controller
> is similar to previous generations, but the register fields are
> widened, the depth is made configurable, and the enable bit moves
> to a different spot.

looking at the driver it would be great if you could provide a
get_state() callback (or even convert to the waveform callbacks) and
fix:

	static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
				    int duty_ns, int period_ns)
	{
		...
	}

	static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
				   const struct pwm_state *state)
	{
		...
		err = tegra_pwm_config(chip, pwm, state->duty_cycle, state->period);
		...
	}

where state->duty_cycle and state->period are u64 and thus big values
are not passed correctly to tegra_pwm_config().

The former helps a lot for testing the driver, and the latter for fixing
the fallout that you then will probably notice :-)

Best regards
Uwe

--c3pivq2irjszuqua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmnCv8QACgkQj4D7WH0S
/k4LTwf/S1NKsnkisomh5Q9yrwoCIml/SMFQ8qwHtXAYo3Y8dQyJNEpEZMh8hTbf
tBkilQuFq7knNjjdRvR2wihR8Jzuqd2COoboSXpLSlnEHKe65N+zUFZYFiieXDei
7C1nJJjTz6ADfMjfE13HCS/6q+yzq0a+2j9RYA57+6LFlZpfFvShAw8bdpXEbwJ1
eJ0wBBOEkLF8HEzLdqjPdPRWj2Dif1kkugjXSPxR8pc9kW4W1aQDj5HY4i3NYkCd
p3CUs+SxHXqZENHezq45m2R78EUX6pxvI11Cqw/036uDyaoGhEcAftEn0HFrHYh4
Ulw8UbzVzxRS59lfEHGnmA1Py7vRIA==
=zXvZ
-----END PGP SIGNATURE-----

--c3pivq2irjszuqua--

