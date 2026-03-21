Return-Path: <linux-pwm+bounces-8328-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBmaHIcfv2m7vQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8328-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 23:45:27 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C04412E7887
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 23:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 614E2300BD9C
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2026 22:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9812E1DC;
	Sat, 21 Mar 2026 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD1i/Lfy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9BB40DFCB;
	Sat, 21 Mar 2026 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774133124; cv=none; b=azJbnnkESrS2a2c3mFgtx88YXIMJsItS/1p8RPlYA9oWFAP29NpoByZ1x1m9CQckKyS0ySsXnhs67juia61zaWxc34MjjHd0msPhf9T/bLWcPOYmCgItOUntRROYfzzZybF1605G6AbhC5QbeTycfugRpHzjxDJwN5D7LpQeyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774133124; c=relaxed/simple;
	bh=IW12eEI3ZKbVq37cMKA3pc+CzTg1bSKIJO3BKrL4t7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nS1/BVMrpqGkNWOm0OUcBOiXmpq3trl3nS22U0DHJSJM/JRH/msM/PiSXgPVfzRC5eYFNRckvM9qspclSGvvT5rnKVGYksSGzO83hyAxpr1a+KCuDDwlZgwxvM+HtGQH+F++dN5/tA6W0en/kI2WWtN2Z4fcMJgoQ4P7Ktc/DZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD1i/Lfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26122C19421;
	Sat, 21 Mar 2026 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774133123;
	bh=IW12eEI3ZKbVq37cMKA3pc+CzTg1bSKIJO3BKrL4t7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FD1i/LfywIet50OXtisHK/RxZsXn5Vu/ApZy5YeJmiatak4UTyF1aSNpqA7xA9yK9
	 Wu1V/WPRpvz2j447ug5dfJOLZLyBikP7xz2wDM7ZsZTnRBYPeTx0IPJSg4le2Sh0ut
	 uf76lReW2skwt6i7XplmRDOjn91vuh776cKprTsZdLx6F121T6YuDb0ogQ6Z95H0Bj
	 qeD1pwJEJL9D53i0nFd9b0HX3tRN61LliRXLtA2dO8RWSz/GI2iyM7TG5JHQvmM9yj
	 yDyPm//Q6fUh6e7V8IjDIgIQEGSPWGZe76gBYLS2uD+fxmOetpohjt2jB6yYBtw3Lm
	 0+ziJd524rlGg==
Date: Sat, 21 Mar 2026 23:45:20 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
Message-ID: <ab8fLL87ZZUHLXF4@monoceros>
References: <20260320220644.3237290-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d5bkty6jini6mazq"
Content-Disposition: inline
In-Reply-To: <20260320220644.3237290-1-andriy.shevchenko@linux.intel.com>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8328-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C04412E7887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--d5bkty6jini6mazq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
MIME-Version: 1.0

Hello Andy,

On Fri, Mar 20, 2026 at 11:06:44PM +0100, Andy Shevchenko wrote:
> This driver includes the legacy header <linux/gpio.h> but does
> not use any symbols from it. Drop the inclusion.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied with Paul's ack to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E

Thanks
Uwe

--d5bkty6jini6mazq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm/H34ACgkQj4D7WH0S
/k6rGQgApyW+1MrG9Kc1sa6lpDJfebt3VuAAe9eXTm0VcUgr5jyfmnXpxMp7scCZ
Jxk2MPUr9Qqt0YRIkuP8IhjJBqhzFvL+bdxb4W8szVrsUSA+Y+XqzZ5yCzuKIIZ8
0hrtjt5h4wBpK5kkmbaSvGQgQDqQqSxBnh2tSqwy2cjxwv5sWWW/o896uIz6gPeD
rmOOdm61bi2Zk0iLL0RlEzA1HzCrJC4MPjlEBCjB5+A71VnKKJvzVpmHnHFFBpbh
XhG5GIM+TxtYlUnXAdlP3ZICKiB64c6x9lVCRqMope4a2mZfoARWgOAt9Tg5zsf0
PnZbhPdDdlMxGqzxTBQjxVSXbrOUSg==
=azbb
-----END PGP SIGNATURE-----

--d5bkty6jini6mazq--

