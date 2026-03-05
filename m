Return-Path: <linux-pwm+bounces-8178-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FPYFg1GqWl53gAAu9opvQ
	(envelope-from <linux-pwm+bounces-8178-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:59:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FAA20DD8B
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 09:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8507A300874A
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525453750D7;
	Thu,  5 Mar 2026 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyrzZSbv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E589372EC5;
	Thu,  5 Mar 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701025; cv=none; b=BYiqUl51Qhrij/XXA3YCP7Xg/jjmi4UdVRS+OWDSoSR1N2WPzTdfcYKK+bLY8xx/bFc+uNCIDWGfBaY0vEjFzmYt4EVJSYQa3N72TA7J8imLVf4n1PEjm8/pxzFjIAZdPtvUXsRGETQbdSMmIWw1Jv7LPb267pCmhF9uCyhjBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701025; c=relaxed/simple;
	bh=iqU5pDubMQ06tWai2ZxGuPk0TJeUQI6pQzatbxUVvj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG4gK/48cmV1luOGa5V2eYPgBEbO9irzjEuoqaDHVHcIcbgAyBnsb0HGEu7gt1pAcI0xEGglfaDRkphyPz5dJTo8Cekzch7ALPYi7h4bVeyEGPEos53gApZkiBY+6T/1sS1FRZax8Dq89D/zgtpwiL67ljFtmCFNuUdQLKoGeI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyrzZSbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A26C116C6;
	Thu,  5 Mar 2026 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772701024;
	bh=iqU5pDubMQ06tWai2ZxGuPk0TJeUQI6pQzatbxUVvj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyrzZSbvsg9feohGDgAsR0KJ58/BzUhcMLcVU8xgvBmH6cNwppZmtnArAj7ZOPzIr
	 7bMY6ogG/hlpvycGq4ZmIXc5mZci/DgBwfbxburCw6ehmJtXlm+liXPo5fzirOVvAX
	 ZeHm8ZxBa/2/ZcruOO1Stu6qN4qZ7c89+l0OGeZTpv2qcjx6Zg7ASY+WJrgST6GwNq
	 YOCxzy3+lJoN2Z2zuvGVUwow5dCe+PkWwhEfkakXAn16HN1ZxtYbYtcvfqqqj5f5Xh
	 tWVE6Wz7HbhXZnMdQvEZS3+fL+WDlIITDD+0Zx/8YBf/DbvGqHNfY7GDK8M5yX2zYz
	 Vcna2ylwW93Zg==
Date: Thu, 5 Mar 2026 09:57:02 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
Message-ID: <aalEXwdvHtToZmRQ@monoceros>
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v3ukleok2z5qariw"
Content-Disposition: inline
In-Reply-To: <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Rspamd-Queue-Id: A7FAA20DD8B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TAGGED_FROM(0.00)[bounces-8178-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[bp.renesas.com,kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--v3ukleok2z5qariw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd
 channel
MIME-Version: 1.0

Hello Cosmin,

On Fri, Jan 30, 2026 at 02:23:49PM +0200, Cosmin Tanislav wrote:
> enable_count is only incremented after rz_mtu3_pwm_config() is called
> for the current PWM channel, causing prescale to not be checked if one
> PWM channel is enabled and we're enabling the second PWM channel of the
> same HW channel.

I don't understand the issue. If the second PWM channel is enabled
while the first is only requested, changing the period is fine?!

Can you please show a sequence of events that result in bad behaviour?

Best regards
Uwe

--v3ukleok2z5qariw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmpRVwACgkQj4D7WH0S
/k7Fbgf/bx6EVifYdpoGaB5fRe2misGSlByQK+enGUL2JWVq7IxvXGPY5X+OPJK7
ZvJQBh8SRtcfbW6Wo+g6oinHWPKhOB4+1Z1+9IRxk4mGuHNzTKnCdu5FvuMJVBNN
04+ciEat4zNXhTKuFT2vQYCqEdWqQWoXt2jAIA5sZMPbTSd+u+1mKMREzUw4YwuR
tcpCZAcvmGsQ23HRigkQIKWYvvXAETkmMBE5RhN5vbv1OmQ1PrB0UvKDebdrBNuz
OOYYo07zrd6upaiMVz4Bq6uqOwdfx6/Wf1sRcLV+P2Bm2GXomZaqYtL01hlYelTI
3oVz3coTM2rYYjERqikyAGAJArrkZQ==
=vcUS
-----END PGP SIGNATURE-----

--v3ukleok2z5qariw--

