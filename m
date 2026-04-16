Return-Path: <linux-pwm+bounces-8621-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB7JAs/o4GlInQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8621-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 15:49:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6538840F281
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 15:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E6A301990D
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 13:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE93C3C02;
	Thu, 16 Apr 2026 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm6vBwCg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48E3B7A8;
	Thu, 16 Apr 2026 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347298; cv=none; b=qcSsJFWDTYvPwpPULc1BxUvdOxu0yzmCTQhl/JcLNAhn2sHmYLQE4Kya8wMWrAzz8yGGH+tiKuScyxCRyEDqA/w5E+3NBRAIngNRMtUWL5xA/vEjcE6/yr0Pas0VoZtUJ3nTkBYxjoVf1/Xo/dIFadh6U22F8JOIDKOz0ZcxFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347298; c=relaxed/simple;
	bh=uTJD2gM29MtP9GMelRFqj+IKtjoMn9+Dn//dWVAgy88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk0GG57dDoMaNeUeDfSJ3pzoiOfeBv+7KLFoZihZO3Hn/fWQH7VquAw14Xx4njaPHJTgXJuvrn24O9wpMO7jSXmJYy+/5jFYg5CDxK9NvjSqY/HL992+N/CdqGrT1cL0dj31HqKeDZmqRkJPN62USNhys5gdQFvKpJtF9fiHtJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm6vBwCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6ACC2BCB3;
	Thu, 16 Apr 2026 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776347298;
	bh=uTJD2gM29MtP9GMelRFqj+IKtjoMn9+Dn//dWVAgy88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fm6vBwCgh/orJ+Veej0NxOgBPBdM3c4HilOYT/mTK3zbRqgF+VgPtMAckcXiE9En9
	 qzeqYh49dgiDhZ6p6vr5eIj7LlktJJHzed4z5ZpLPJN5hBjT+8DX7wGRgy8tpt3zKy
	 alM1wVycCERuFhcU0uGVLzBvxdhTX6LQNWxCVsSTjUFJVTgfKNVH1qJqdYeCowTF5u
	 WzAy9pQI+UeHqW9R0in129XTFMGU9A3Qu7V0GpuYT1EfgIdnKdMSg4PxAqdbcq7TW5
	 JY6QSpQGb96OYRUS4mqKYVKEiy7L38JtF6CMmA7E67dgEDKUdirh0CdAh+rsOwGzcO
	 JVm7phy6y5CuA==
Date: Thu, 16 Apr 2026 15:48:15 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <aeDmk-t5Lc1zpkg9@monoceros>
References: <cover.1775829499.git.andrea.porta@suse.com>
 <0d99317b9150310dfbd98de1cb2a890f0bffe7cd.1775829499.git.andrea.porta@suse.com>
 <adkrHkANCzxO8KUP@monoceros>
 <aeC6U7D6TfWm8JPx@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53ygmt545ulvux3v"
Content-Disposition: inline
In-Reply-To: <aeC6U7D6TfWm8JPx@apocalypse>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8621-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 6538840F281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--53ygmt545ulvux3v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

Hello Andrea,

one thing I forgot to ask: Is there a public reference manual covering
the hardware. If yes, please add a link at the top of the driver.

On Thu, Apr 16, 2026 at 12:30:43PM +0200, Andrea della Porta wrote:
> On 19:31 Fri 10 Apr     , Uwe Kleine-K=F6nig wrote:
> > I assume there is a glitch if I update two channels and the old
> > configuration of the first channel ends while I'm in the middle of
> > configuring the second?
>=20
> The configuration registers are per-channel but the update flag is global.
> I don't have details of the hw insights, my best guess is that anything t=
hat
> you set in the registers before updating the flag will take effect, so th=
ere
> should be no glitches.

Would be great if you could test that. (Something along the lines of:
configure a very short period and wait a bit to be sure the short
configuration is active. Configure something with a long period and wait
shortly to be sure that the long period started, then change the duty,
toggle the update bit and modify a 2nd channel without toggling update
again. Then check the output of the 2nd channel after the first
channel's period ended.

> > > +	if (ticks > U32_MAX)
> > > +		ticks =3D U32_MAX;
> > > +	wfhw->period_ticks =3D ticks;
> >=20
> > What happens if wf->period_length_ns > 0 but ticks =3D=3D 0?
>=20
> I've added a check, returning 1 to signal teh round-up, and a minimum tic=
k of 1
> in this case.

Sounds good. Are you able to verify that there is no +1 missing in the
calculation, e.g. using 1 as register value really gives you a period of
1 tick and not 2?

> > > +	if (wf->duty_offset_ns + wf->duty_length_ns >=3D wf->period_length_=
ns) {
> >=20
> > The maybe surprising effect here is that in the two cases
> >=20
> > 	wf->duty_offset_ns =3D=3D wf->period_length_ns and wf->duty_length_ns =
=3D=3D 0
> >=20
> > and
> > =09
> > 	wf->duty_length_ns =3D=3D wf->period_length_ns and wf->duty_offset_ns =
=3D=3D 0
> >=20
> > you're configuring inverted polarity. I doesn't matter technically
> > because the result is the same, but for consumers still using pwm_state
> > this is irritating. That's why pwm-stm32 uses inverted polarity only if
> > also wf->duty_length_ns and wf->duty_offset_ns are non-zero.

Please align to the pwm-stm32 algorithm (as of
https://patch.msgid.link/c5e7767cee821b5f6e00f95bd14a5e13015646fb.177626410=
4.git.u.kleine-koenig@baylibre.com)
here to decide when to select inverted polarity.

> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_disable_clk:
> > > +	clk_disable_unprepare(rp1->clk);
> > > +
> > > +	return ret;
> > > +}
> >=20
> > On remove you miss to balance the call to clk_prepare_enable() (if no
> > failed call to clk_prepare_enable() in rp1_pwm_resume() happend).
>=20
> Since this driver now exports a syscon, it's only builtin (=3DY) so
> it cannot be unloaded.
> I've also avoided the .remove callback via .suppress_bind_attrs.

Oh no, please work cleanly here and make the driver unbindable. This
yields better code quality and also helps during development and
debugging.

Best regards
Uwe

--53ygmt545ulvux3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmng6J0ACgkQj4D7WH0S
/k7hMggAn8rENjZtWE1kj1D/NlWx5jd1LB+UVOUTfUUHjZwhyEqvw7BXYQ42LooK
ONSs3zBv+kpBp8ZVk5oON1Qw7Cjp7WXon5ePWM4adZE96cqdp62lExHO873C/2f1
LJcEvluoxNyDLtSoDKvlhlnYfxi/Cww2aMEa+Mm2n/NWbkEQAnI8zW8WWifBr16/
xKaZDUHJKyxfAq2wrgqWwersaJTsx4OQ3slVTLraUQ9nG3bJmuhde3NcSRLzXlcg
1Be+aAYFggvG10IjVlmiqaRAVEa4jTMo42ep/xQH+Lqr1BYgVFwbYHvpFQ7kmPep
4VBRQjnRDS5So3LCp7p3VgT3IkAGGg==
=S8mZ
-----END PGP SIGNATURE-----

--53ygmt545ulvux3v--

