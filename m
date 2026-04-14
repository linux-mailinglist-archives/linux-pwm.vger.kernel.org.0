Return-Path: <linux-pwm+bounces-8575-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LgoD5MO3mnRmQkAu9opvQ
	(envelope-from <linux-pwm+bounces-8575-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 11:53:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D03F841A
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 11:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19D37306707D
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 09:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52683BB9E0;
	Tue, 14 Apr 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDeN1PXQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BDE3BD657;
	Tue, 14 Apr 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160130; cv=none; b=Qz+zoYIoe5X4S7S/NkGApNr0y1gsAoujMYI6W9NXHyA12dZ3LKEH+FyqyzygkUHHN52ygz812n8plS4WDDStYMxG5MOuBErKImyrazS1rzpyMTPyB6/GGBTvQrp9nmityCJxP+hDMqPFoTUmTJOFJ+uh00QpV8hH8huvcd+qgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160130; c=relaxed/simple;
	bh=22mEg7TC8hlK7fpynNDkNoReZfVYGw/TEFvhSPUn9F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ot7Srnfjb6zM44YpqKescBisx/6XWt+5XVy5bvO7jtIRRQbZpPYBbhzNyBUo3iNoO/wrmBIkLprCDb5sH/zsFxwgD4bG0DOXF8Uyin0+DP4YtjAd6mNxyK1EuvZxLOfzlcQ5cajmSjo8UL/Uyy/5I3zDC4+wqAqWl+Ov8jRBkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDeN1PXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BFCC2BCB5;
	Tue, 14 Apr 2026 09:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776160130;
	bh=22mEg7TC8hlK7fpynNDkNoReZfVYGw/TEFvhSPUn9F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rDeN1PXQmPT5h/tqIJkwV3RjadZ8gVr5KMcF1OjZU8p6hwa74kgut5xHa7iVOYD3H
	 EBD58Tbr66in2oF86hszJQXnEvwcamYKwL7bxZKSBi3D4Tx03K3rejJ2VScHy6el+Y
	 BJ1BEBn7qsR/HZ7oBvvLVxDebTZLFiurb324jBKuf2Cg9sb8FygNeDfvL1CyVUNWtU
	 CPg8xRQbWXi0DpA8PWfvEDninhpMya70iB8bO7LJj26OooJ6U1r/uCvhgbL+w13qeh
	 utC/w71cW/2B6zB/ndnWh56PtLkph9j8biekd1vtUKkPETLq3XkExskKVr8H9P5cK0
	 RZ3fxoPaKpguw==
Date: Tue, 14 Apr 2026 11:48:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org, julian.friedrich@frequentis.com
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
Message-ID: <ad4LRX3tkC7lKiZu@monoceros>
References: <20260225125159.20822-1-richard@nod.at>
 <9c733024-8ad6-459d-ae5a-a9825f85c506@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bsmluefizzo4bzaq"
Content-Disposition: inline
In-Reply-To: <9c733024-8ad6-459d-ae5a-a9825f85c506@roeck-us.net>
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8575-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A6D03F841A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--bsmluefizzo4bzaq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
MIME-Version: 1.0

Hello Richard,

On Thu, Feb 26, 2026 at 02:38:27PM -0800, Guenter Roeck wrote:
> On 2/25/26 04:51, Richard Weinberger wrote:
> > The Nuvoton 6775 chip family also offers PWM functionality to control
> > various fans. Depending on the hardware design, the PWM can also be
> > used for other purposes, such as controlling a display backlight.
> >=20
> > Historically, the driver implemented its own sysfs-based interface to
> > control the PWMs. This made it impossible to use the PWM as a backend
> > for other drivers, such as pwm-backlight.
> >=20
> > This patch registers the PWM functionality as a PWM chip within the
> > PWM subsystem. Since the Nuvoton chip has non-trivial control logic,
> > the following constraints exist:
> >=20
> >   - Exporting a PWM for external use is only allowed when the fan mode
> >     is set to manual or off.
> >   - As soon as a PWM is exported, changing its configuration is no
> >     longer possible through the hwmon sysfs interface, reading is
> >     still allowed.
> >   - Changing the PWM period is not supported. IMHO, it is too risky
> >     since the PWMs usually control system fans and similar components.
> >   - Reading and decoding the current PWM period is only supported for
> >     one chip variant so far, for all other chips, a fixed period of
> >     100ms is assumed.
> >=20
>=20
> This is a good start, but I'll want to see stronger safeguards.
> - Creating a pwmchip entry for a pwm channel must be triggered by
>   device property data, obtained either from devicetree or through
>   DMI or through device properties embedded in ACPI data. For each
>   channel, this must be confirmed by checking that the channel is
>   not associated with a fan control channel.

I personally would be more lax here. root being able to change the
configuration at runtime is fine for me. IMHO this is in line with being
able to unload a driver or manually bind and unbind a driver or
dynamically creating an i2c device via sysfs.

> - If a pwm channel is configured as pwmchip, it must not be used for fan
>   control, meaning the hwmon properties associated with that channel
>   must not be created.

I fully agree here. At each point in time the hardware should either be
exposed as hwmon or as PWM channel. And if changing that during runtime
is possible, the old configuration must be completely gone before the
new one gets active.

This patch still was in the pwm patchwork as "action required". As is
both Guenter and me agree the patch isn't ready to be merged (though for
different reasons). I discarded the patch from my todo list and updated
the state to "changes requested" now.

Best regards
Uwe

--bsmluefizzo4bzaq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmneDX4ACgkQj4D7WH0S
/k6BvQf/Q+3gBkHZ0ssuUbPrh5i/AYFsu8RBkt4hNK2oEm8EPU89z72OwsZJoYKu
/fInRzl4rgUEHn3AWBnyCKFuK602EVp7Kerw9tmx/hRajNt4pxW47bQSa//gJf2J
Ma/K/HQGKHZ+lgh/aPB/lY9uBw+vCvfNLd+4IR62ViA3pHgm853BkOURWO+94pK6
yi7Dg1p/w13BTn6iXSBiy547+Xls3jNFRi5RhU77rN7/s+dCgbvEV1teEu9S5cgr
P0A2hevBPwpyxXXdx33VzB58AHfEQoNstj5WWTaIuhJroqCqA+Z49yg6l9cTFfM5
WsracqZr1dCPNQCD304r7yY0Dbuz2Q==
=cQPw
-----END PGP SIGNATURE-----

--bsmluefizzo4bzaq--

