Return-Path: <linux-pwm+bounces-9291-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QcixHy2eL2qKDQUAu9opvQ
	(envelope-from <linux-pwm+bounces-9291-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 08:39:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA3683E17
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 08:39:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KWVdxXcM;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9291-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9291-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A905B300F9CA
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0DC3AFAF4;
	Mon, 15 Jun 2026 06:37:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5A3A0E80;
	Mon, 15 Jun 2026 06:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505451; cv=none; b=k3P2huGgOZBUihihMfOyKfsNAptgbKF+y1gZyG4+Vde6YUjSN2G8rKwkWFvwwG+kLTVrfASOZ3GpYCJO0RdVy38DVk7UO9OZGMym5cmnY6QeL0EtxEzRyumKbjDv7k9FmLcRw1kO+9OiLDVfUg2IAyj1+Eg/GJlXAV9BwnM+LrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505451; c=relaxed/simple;
	bh=xYhec2l2zy7ltRZnfYBjNGcFte6NZlmFwPRyNJOyiaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4sNChW2fobciC8BujIxihRTexnGXBI9Z86jOoJsmy75/UnLNrsZI9tuy7A2D2g463VmvExzBvCqxfveaAVtTYi7ugZS6idIJuaZL+4vR6lEVBilcdcheDYd/AoZ3WGVWBQdHZhorU5oMYz39DEF+8ov0umQwn3ftam2xsJsV4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWVdxXcM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 539C21F000E9;
	Mon, 15 Jun 2026 06:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505451;
	bh=wYvlTdTkI8iTFk+/aWNvdop1BELaOWjR9XgqorfHy0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KWVdxXcMy5KN4BO2w3B22IRJrWNfqThxDyUC0W8HUkClZuh2P9N9iWaBPIZoBlaRt
	 boUKjMI3L5d9spGYBtbMPEIGbNBJE5swnZVzIYy/27dOv9HGs+M/7a9cxebTCsvk84
	 vJ9Mwq2PqNQ3q3zmKQFAZekSsQ9/Fa4iQc7mAkms/aSStQtJdzXrkjCAj5lgJmiE1r
	 EwMu4BrlqhYYlxZy0YuDxkTVikIdxwekAwj/Us+diEjiAc7i380cKyY0CWrfDUwOvS
	 RliT5chIFPkzKkYZV36iTCzJJR1EB2htPdsDeH4dYYCDEen4Mb6GQwL92UvXY+XUak
	 vNF6so87QfGjw==
Date: Mon, 15 Jun 2026 08:37:28 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, linux-pwm@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Naushir Patuck <naush@raspberrypi.com>, Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
Message-ID: <ai-dNlC1_nbQTy5Z@monoceros>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <f8dd46a553351adaf9d29fbba9f98e803b672fe7.1780670224.git.andrea.porta@suse.com>
 <0b6a7f41-b753-48dc-b46e-77aaf0e999f4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajhov2qxsz3lss5g"
Content-Disposition: inline
In-Reply-To: <0b6a7f41-b753-48dc-b46e-77aaf0e999f4@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:julianbraha@gmail.com,m:andrea.porta@suse.com,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9291-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CACA3683E17


--ajhov2qxsz3lss5g
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 2/3] pwm: rp1: Add RP1 PWM controller driver
MIME-Version: 1.0

On Sat, Jun 13, 2026 at 01:27:49PM +0100, Julian Braha wrote:
> On 6/12/26 15:01, Andrea della Porta wrote:
>=20
> > +config PWM_RASPBERRYPI_RP1
> > +	tristate "RP1 PWM support"
> > +	depends on MISC_RP1 || COMPILE_TEST
> > +	depends on HAS_IOMEM
> > +	select REGMAP_MMIO
> > +	select MFD_SYSCON
> > +	help
> > +	  PWM framework driver for Raspberry Pi RP1 controller.
> > +
>=20
> Hi Andrea,
>=20
> Selecting REGMAP_MMIO is unnecessary here since you're already selecting
> MFD_SYSCON.

IMHO selecting REGMAP_MMIO explicitly here is fine because at least to
me it's not obvious that MFD_SYSCON enforces REGMAP_MMIO.

Best regards
Uwe

--ajhov2qxsz3lss5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmovnaUACgkQj4D7WH0S
/k6rsQf/UOXqKwIUO7qhgK9i5TY4JtULpUGRl6MSYUIchZKFq4oJExnI1G1PeqVe
B5QU11I7UGYCjLgU8TBxtxpajjDFLxl+9c9a+AgJNftMMlSXV4ow8aaE9f3ejLFd
71RW8KxSTWSmXioUKYFklPhx6PaKSaob6D3tE78UBsm95+m8RNQPGFNjus73flHZ
RYJU+Kw9oFjKhrYWD628kCEED5GjMK6xvExvq33NP6RNi8nFvsLlcB0kbC/89esk
SWE2CiR/4hGygS1KtKNMA9WjLxxVSCJWeWPv024Fb06m83lBiOJfImYHZyFt2PPQ
hmyOo+L9FLZ2rshpaiIaqAZgYZarhw==
=s2AI
-----END PGP SIGNATURE-----

--ajhov2qxsz3lss5g--

