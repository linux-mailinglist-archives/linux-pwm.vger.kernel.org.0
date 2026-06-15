Return-Path: <linux-pwm+bounces-9290-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xlXyClCdL2o6DQUAu9opvQ
	(envelope-from <linux-pwm+bounces-9290-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 08:36:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4A683DE1
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 08:35:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M15whiB7;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9290-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9290-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B9FB301D322
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jun 2026 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21FF3B14C4;
	Mon, 15 Jun 2026 06:34:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E633AFAF4;
	Mon, 15 Jun 2026 06:34:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781505295; cv=none; b=iEmJddhsRiXefRGgGgFHvIVtL1vVGzFFLEyjKcDWQRZDc2fus38bvi9WTezv7yW0Gp4nBdPxW3+14pduEe/PW4lV4y+kRyt0p8rNbU3K4X1F4d9mUjVguhFSMQMX1FXN+RV8PhPM36TGPENlSX91CJxaJiwD9EveizGrVdUW+rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781505295; c=relaxed/simple;
	bh=LwVwZ1OH794aFnSS7FIyTAlzmDuCdGBWxBc78g/rlcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CybEPb2eZiMkJAOMEUhmePhGa8H9dywysKJAD4/AywbkLeVjanT4FojC8wVKelq4vbIA/PfDhzr9oHhaOKz4e6Oqzo62SAtVxppv9mbF5Cn2L2ej4V465JtN1ic46SND1adlR/BSajiWEZl1S3PmBSqtVNTgg/xb5rNHJwXnHNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M15whiB7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A230B1F000E9;
	Mon, 15 Jun 2026 06:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781505294;
	bh=LwVwZ1OH794aFnSS7FIyTAlzmDuCdGBWxBc78g/rlcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M15whiB7awNSzpgBgSLlWyrVBDSrbGMngmgj4QA5DHrS9J3frZf509O0fV2RQbd94
	 yhpGEseCZZDlGfCAaUUrtT1CNxBkhSAzt919SG0KUMewHAfTf81TYOsS0Co1zO3JAf
	 +HSErqQLjMyM/q+XqhcLjDCJj/KUWo4mLP4Kir/5plPOMbfOy6VfwPHTyQHil4MbyB
	 km3LiF8oxFKGJXhKisvRoZcinCilhh2pvZb9EtZd5gkXmQbYlCe5SaIeEPW8+J248C
	 S1QVq2vi39+IiTCtQZe4E106CR7PxvTVZkQDCT2gugxR2+wtEi//eQ81X84Rr9wMyO
	 vt+0OsI2+CTjA==
Date: Mon, 15 Jun 2026 08:34:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Pal Singh <ajitpal.singh@st.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: st,pwm: convert to DT schema
Message-ID: <ai-cWP8XW0ZwBnbH@monoceros>
References: <20260613-st-pwm-v1-1-458c2c89709a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="emncwsoh2jwmrgbx"
Content-Disposition: inline
In-Reply-To: <20260613-st-pwm-v1-1-458c2c89709a@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.76 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:charan.pedumuru@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ajitpal.singh@st.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:charanpedumuru@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9290-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85C4A683DE1


--emncwsoh2jwmrgbx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: st,pwm: convert to DT schema
MIME-Version: 1.0

Hello,

On Sat, Jun 13, 2026 at 07:04:11AM +0000, Charan Pedumuru wrote:
> Convert STMicroelectronics STiH41x PWM/Capture controller binding
> to DT schema.
>=20
> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>

FTR: sashiko found a relevant issue in this patch, sent a mail about it,
but not to the list. It's about the old binding requiring `interrupts`
which isn't the case in the new proposed one.

Find the full message at
https://sashiko.dev/#/message/20260613071327.BE3101F000E9%40smtp.kernel.org.

So I marked this patch as changes requested.

Best reagrds
Uwe

--emncwsoh2jwmrgbx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmovnQgACgkQj4D7WH0S
/k40YwgAuXZImzLUX+KOPP158jbavgVEmzuiuBb//DdDlrIGgzzO6v+dBAMA9SDj
PvuC7RBW/B5UooAcMZ1ug0XNSKEBPdmt5Y0gQ87AHDpCorEj0TT7sxnwkNsPFX7x
HWl9G8cL27P6GutcVbCOluI0yYR7Nw1zHYQf21RyAACqbQ8Vhyhh72ob5smi9YfV
33kT4xEB6wS6RhPxBqf4Nq+uAItquyUKzPnYPnJyA/tYFsPGidRAMDVQ67CCC59y
b1wHuvuWgjOm7Vf43RWcIcBZflb/1IGtXsHWm2NX0LiS7MCBDIiuchqFT32NykG0
RZvK1jwXaN14bK03WyRqvyufOjWRXA==
=XSA6
-----END PGP SIGNATURE-----

--emncwsoh2jwmrgbx--

