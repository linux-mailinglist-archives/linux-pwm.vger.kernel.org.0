Return-Path: <linux-pwm+bounces-9673-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9W+rGajfT2o3pgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9673-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 19:51:36 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A96734017
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 19:51:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NB+wtT9J;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9673-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9673-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04BD030864E6
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D2A4DA540;
	Thu,  9 Jul 2026 17:50:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99C4195D0;
	Thu,  9 Jul 2026 17:50:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783619418; cv=none; b=NtdhRZLZeOVlLcwKgMyGk1JxFiNhP3DXFD9KJl6VcSPxwMG9Zob59bWxBUEkb+hZJqPzND4NFStqEoXeDpR3ayZX6p+jhAYqq09KjrHJmAFHraMgqV7Se1nU6QjacG35sOY+h/hETJCnbkVnvBupachkvao99f+yfoyHTW9m7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783619418; c=relaxed/simple;
	bh=fMzGtFG8sajsnLHWl1lHh8gsBbPiUDwZ61eEP13vpu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJHVJYRd1H4zXshUev6qfem2QAVQatldM5L1EqFBRacd3XWh8731jZsXXWi7xWT+e2mhh46BCVJI+SO09Im0kMIBix3tEqJ/FSHF/UFX4EZOc5nTjBoxb6NOOmf7U1AMhj+apdL3xZ8Ejbf7bwYhNoPALe/TJix4vZoazUNgFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NB+wtT9J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF22A1F000E9;
	Thu,  9 Jul 2026 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783619417;
	bh=fMzGtFG8sajsnLHWl1lHh8gsBbPiUDwZ61eEP13vpu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NB+wtT9JQ0SHManTBvYWYMb9t79Eo6NCEtla19MxdwR9FHjw+RetxZzOZxRpU5jqt
	 cueoK1QrH9M9tA1LsFAUMEQEzdce0COUZ2gXu5H9o+sYYD5HYWLo93QHDjKVL6TYxO
	 7STj84HaJdGsMUst61aNBpj8Hb8MnfNNhvuPEYbi8hwi8fdCwT9ME5GKHcQ7yAM8uX
	 dV50Iav5nkV4mLISbxojRk1CHxIyHf4YHj5OuZNUrsRV4KJMcB47O0qN3/bqeTyRa1
	 sBkzBQueNdypLRdkz5ysKziu0db8aFRCkQ/71YFPjxlU0lqviJGL4KweSee1aPRX0S
	 5VRsh7Bev2eSQ==
Date: Thu, 9 Jul 2026 18:50:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: arm: apple: Add M3 Pro/Max/Ultra
 devices (T603x)
Message-ID: <20260709-unflawed-humorist-918325879ab6@spud>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-1-55b305833123@jannau.net>
 <20260709-impeding-tingling-c5858eb0191d@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VXR0uJe6BRvVu9jb"
Content-Disposition: inline
In-Reply-To: <20260709-impeding-tingling-c5858eb0191d@spud>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:j@jannau.net,m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9673-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,spud:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4A96734017

--VXR0uJe6BRvVu9jb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2026 at 06:47:40PM +0100, Conor Dooley wrote:
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> pw-bot: not-applicable


Actually, sashiko complaint looks valid here?

--VXR0uJe6BRvVu9jb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/fUwAKCRB4tDGHoIJi
0h6jAQCRkdoCjcZVRfdOhVVCPGjDz9q56/rC1wfgPdgTHwlLcgD9Fp64DGtobS1L
8mZoKmKNHw0fTD2YNcrtlBHM/Ag4wQ4=
=rCUn
-----END PGP SIGNATURE-----

--VXR0uJe6BRvVu9jb--

