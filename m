Return-Path: <linux-pwm+bounces-9275-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2kBFJpIYKGqC9wIAu9opvQ
	(envelope-from <linux-pwm+bounces-9275-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Jun 2026 15:43:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF5D660AF1
	for <lists+linux-pwm@lfdr.de>; Tue, 09 Jun 2026 15:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j+EpRCl9;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9275-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9275-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10FEC3021C81
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2026 13:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478674183BB;
	Tue,  9 Jun 2026 13:42:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E41E40E8C7;
	Tue,  9 Jun 2026 13:42:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012565; cv=none; b=qqKGEKQJkswzwh1OxhZwSS2VZjwEbRfvaFyPc3IqofiM+UOD7CDru1HQN/obT/pGz7SnoCgPfa4i5+7Zqqr7U+rHoD6Q0XCQrKyYFIdLrF6yrKbBNsCO1SAujiQgJYdjlSj+zhz47MEo5GpnTKKIphej2TOwJ99IVTJucrILLYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012565; c=relaxed/simple;
	bh=zGNMPlb3a/Tydzp3/Rr2Tf/J5wLi5iPR3DtAmkbGU5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2FR+eYwwn1pr4mGRblqeelVZpatr6HG4HbHoMSqb2O+6MuQwZuUWCa4qnMA4TrrkJUhOl9yEN9JdKn/SHWCVGRXGlB5Xum02UFC5ikrIDojkW0JXdeJmVjltMqSVLY+uPPSTNIeidYVIPtn+uY3yWEtFFCPSw4SWulGSoUM590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+EpRCl9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 845161F00893;
	Tue,  9 Jun 2026 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781012564;
	bh=zGNMPlb3a/Tydzp3/Rr2Tf/J5wLi5iPR3DtAmkbGU5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+EpRCl9CnBBkSYW22+rXzNItf40DiMC3rXqRMP3LQH6e+08DqG4ZAP+sU7OUONwl
	 Pv5+Mzs3cGZ0s4UKZBAArZ+ElTYL9bQtPCvVHnb0rEzyWfYKMmIxu9tEYrpLT9VZyy
	 u7+DoWqsEs4ji/fRQAL92d/goRG+zQmt4f0AG4E0QI31XLNusxBZqQjKlqx7WtfDde
	 Njgz3PFjGEc0VoOs4v9VdArfAKLdk8dRgHDST8O8Hxjp5zz93AuSDEzIe5vvaeH733
	 eXFZkdEu7bD92u2+sAUd8uQ3aycmzCbHTzuwu1mu7UdXd2GP/ADCgd3jjNUriAIWBH
	 YkPoFEvywd7WQ==
Date: Tue, 9 Jun 2026 15:42:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	stable@kernel.org
Subject: Re: [PATCH v6 01/11] pwm: rzg2l-gpt: Fix period_ticks type from u32
 to u64
Message-ID: <aigX3L2ScRk9plDG@monoceros>
References: <20260604095647.108654-1-biju.das.jz@bp.renesas.com>
 <20260604095647.108654-2-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ke56f66di4ti26gc"
Content-Disposition: inline
In-Reply-To: <20260604095647.108654-2-biju.das.jz@bp.renesas.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9275-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:biju.das.au@gmail.com,m:p.zabel@pengutronix.de,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:biju.das.jz@bp.renesas.com,m:linux-pwm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:stable@kernel.org,m:bijudasau@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[pengutronix.de,glider.be,gmail.com,bp.renesas.com,vger.kernel.org,kernel.org];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,renesas.com:email,monoceros:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CF5D660AF1


--ke56f66di4ti26gc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 01/11] pwm: rzg2l-gpt: Fix period_ticks type from u32
 to u64
MIME-Version: 1.0

Hello,

On Thu, Jun 04, 2026 at 10:56:31AM +0100, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> period_ticks is used to store PWM period values that can exceed the 32-bit
> range, so change its type from u32 to u64 to prevent overflow.
>=20
> Cc: stable@kernel.org
> Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I applied this patch (only) to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

=2E I currently don't have the capacity to go through the remaining
patches of this series, but I have them still on my radar, so there is
no need to resend/rebase.

Best regards
Uwe

--ke56f66di4ti26gc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmooGE0ACgkQj4D7WH0S
/k43/ggAisGfmu1Pnp1+ZL8xZU7NmIOv5vs9lMLl+21louOsbRImZmPi42pfE1nF
nNusRy2Ffr8rVQODie7QNSZXJh6/+ONxiqLMFReviBisZ++a2XTPmVl3OkUnz9eR
7ZSIqS7k1sjrywc+jUt50pQn3TRMp6GYv1IfsJqEuk6dfS8Cube5U6kwi639O8XW
XP3RbDhqpsxgIubWPvhImIc8nutlqzfn9GK03GYI1di7+7DidY4+WrjyXBWeSk9X
yAnfXzXuy+pSq7isrLkFYP7dQgddJfZKG/vnvLSSEk+/UaIPlNQB93P9qB/Qmw+I
PmPzslkRHMLX3SrnMcL5S30aBzS5YQ==
=wTyj
-----END PGP SIGNATURE-----

--ke56f66di4ti26gc--

