Return-Path: <linux-pwm+bounces-7983-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJx8I7eucGmKZAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7983-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 11:47:19 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED75577D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 11:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C357560556C
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24EF314A7F;
	Wed, 21 Jan 2026 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjGHqpDA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7133E480DFF;
	Wed, 21 Jan 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991106; cv=none; b=qEnMHrwAaZgd9BQ1GF8sLQU+PDj1t/FTIMvH3smWWh2qhYd2D1DqkfWN2IaCW6m8XWn5Mlp+K7gWLvwgFMMEAB/+9OtgqDCTuX2Axconz+3HvqphoCXASP5fbww/to132dDBEWmiwUIEw7pHnVfUfMbOUycN5dvcAhIrhpEcijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991106; c=relaxed/simple;
	bh=yDwrv2b5rhwVaRWHXnt7mAij4/mxhQw1uJSP+5yYNAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y13mSAKpZ3kYTg6J7VXUU47LtCTnKnfbuT+0OHaEkz9cNX085O9rvODt/IWO/urifguaSp3yHsZUUJ283Y2BIrzgAWgCAnFT7iftltj62AdwYiP1rK56tfhBZ+7nu+MkIf5TGr41ztxtrbT4cpY1HNYSNjLwA8f/t0BZFwuCvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjGHqpDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00398C116D0;
	Wed, 21 Jan 2026 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768991102;
	bh=yDwrv2b5rhwVaRWHXnt7mAij4/mxhQw1uJSP+5yYNAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjGHqpDAq/t6pWcj56Amu4+Z6QSv3F3yigWrw6xmuGnWx5QnlljO3lgSR3z4zIPO1
	 2+gp5aunSnoFiFfZt7wzMwUwlxKCHbxeR819Z3kWvLH62r9H+PrmGgtoAKMKx5FrL0
	 oO0lFXTc6+g8ojEux1miEshIZzlQ9xEzElfYnmHqv+WKfuo/SzbKVPu3tVo4GHp8Y8
	 LQ7c07guy3ZuUCUD5C5grlySTLFx8wXA7jEziam3rgs9AlqGJh8mITd0wtapw7cheM
	 YKdAe6XfgHihc6Wqk33VaHDge76+THdoWUe1lZ5NtJ58VC2jV7iQwCbREa3TLCefBh
	 2Z7O6rrpdRqVw==
Date: Wed, 21 Jan 2026 11:24:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
Message-ID: <r4v2i5pdpot473frsy3jn2pckf6ao447kmf3pmzqz5lp6g5lqa@qnoktv67llyy>
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>
 <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
 <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>
 <izui2w7jddvnji3nbw57yivdoohrs6tabkb42gtklhy53v7byg@zkcjf4js5fbl>
 <31b27059-f980-4b44-a9fd-1d909c9729ea@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4odi6pt2cpvvgpe"
Content-Disposition: inline
In-Reply-To: <31b27059-f980-4b44-a9fd-1d909c9729ea@mailbox.org>
X-Spamd-Result: default: False [-3.56 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7983-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[raspberrypi.com,vger.kernel.org,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 4FED75577D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--g4odi6pt2cpvvgpe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
MIME-Version: 1.0

Hello Marek,

On Tue, Jan 20, 2026 at 11:25:59PM +0100, Marek Vasut wrote:
> On 1/20/26 3:19 PM, Uwe Kleine-K=C3=B6nig wrote:
> > On Tue, Jan 20, 2026 at 02:50:03PM +0100, Marek Vasut wrote:
> > > On 1/15/26 5:37 PM, Uwe Kleine-K=C3=B6nig wrote:
> > > > . Given that the dt specifies something made up and the driver was
> > > > written in a way that is wrong but does the right thing in combinat=
ion
> > > > with the made up .dts, you cannot fix the driver to be a correct PWM
> > > > driver without having to adapt the invented values in the .dts, too.
> > >=20
> > > I think this is what this V3 does. Would that be an option here ?
> >=20
> > No, the driver doesn't become a correct one with your patch.
>=20
> Hmmmm. Then I really do not know what to do or how to move this forward,
> because if I go with the V2 approach, I wouldn't be able to use this on t=
he
> board I use.
>=20
> Can we update the timing information in DT ? I think we can not.

Why not?

> > Another option I see is to make the driver directly a backlight driver,
> > instead of a (broken) pwm driver + pwm-backlight.
>=20
> That's what I mentioned in reply to V2, but then we lose the benefits of
> reusing pwm-backlight code .

I think that benefit isn't that big. And if this driver was relevant for
me, I'd go that route.

> > > > Maybe the lesson to take away here is: if a driver implements a PWM=
, Cc:
> > > > the linux-pwm list and the pwm maintainer on the submission. And le=
t me
> > > > point out that even get-maintainers.pl knows about that:
> > > >=20
> > > > 	$ git format-patch -1 --stdout d49305862fdc4d9ff1b1093b4ed7d8e0cb9=
971b4 | scripts/get_maintainer.pl
> > > > 	...
> > > > 	"Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org> (maintainer:PWM SUBS=
YSTEM:Keyword:pwm_(config|apply_might_sleep|apply_atomic|ops))
> > > > 	...
> > > > 	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM:Keyword:pwm_(co=
nfig|apply_might_sleep|apply_atomic|ops))
> > > > 	...
> > >=20
> > > I do use get_maintainer to CC people when sending patches, hmmmm.
> >=20
> > What I looked at before writing this was:
> >=20
> > 	$ git log linus/master -- drivers/regulator/rpi-panel-v2-regulator.c |=
 grep Link:
> > 	    Link: https://patch.msgid.link/20250616154018.430004-1-marek.vasut=
+renesas@mailbox.org
> > 	    Link: https://patch.msgid.link/20250609223012.87764-1-marek.vasut+=
renesas@mailbox.org
> > 	    Link: https://patch.msgid.link/20250609000748.1665219-2-marek.vasu=
t+renesas@mailbox.org
> >=20
> > and neither I nor linux-pwm was on Cc: for these. Maybe you used
> > get_maintainer.pl from before 8f960106c150a9733f5d7408b975c0a687617961?
> > :-D
>=20
> No, I use the one in tree only, which has to be the one from linux-next
> around the time it was posted.

Then I guess there is a bug somewhere in your workflow. The commit
creating the driver (d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4) has an
author date of "Mon Jun 9 02:06:42 2025 +0200". So it was probably
prepared on top of next-20250606. Running the above command in that tree
also emits my email address and linux-pwm. =C2=AF\_(=E3=83=84)_/=C2=AF

Best regards
Uwe

--g4odi6pt2cpvvgpe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlwqXkACgkQj4D7WH0S
/k6tvQf/dzNNrn2/wdxuenYIcwqvdIKfWsKe0sbJL2mdvKsvxKW3FiMnnDym5ypT
F8Z0liYg0umjAYC7iu12M+VxH1X02yS7O9/ebehvZt86RCQJ49Ot7etuHH3N+B7y
uDpOBCMfCqz+Ll8LcBgwuqpl82kv5icX9KuzRCOTfEVeuftAftfnRoCGqP0wG7Ns
LPasxI2WWKB5AvJfI2XkWilMsvZavOZLXzzWuDKZLs8fbogX3x7C2WAfxez6rlSE
A6xMMa7SuVp4ncvPO0zHoGDRHWj0VGb55uoSxKEXcwbenjsvUOCDJC/0wh42d90B
3+Nlua6jp0c4ynR3y89/pwhngaCxaA==
=lI2D
-----END PGP SIGNATURE-----

--g4odi6pt2cpvvgpe--

