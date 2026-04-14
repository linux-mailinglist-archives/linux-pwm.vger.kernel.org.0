Return-Path: <linux-pwm+bounces-8574-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEpRLOQA3mkRmAkAu9opvQ
	(envelope-from <linux-pwm+bounces-8574-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 10:55:00 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E8E3F78C6
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 635673018BE0
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Apr 2026 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0788D3B635C;
	Tue, 14 Apr 2026 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcJ0UqUR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58E43B52FE;
	Tue, 14 Apr 2026 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776156713; cv=none; b=lb9CHvHUBpME8foxOgoNk6utGnNbxMYgspB4TlLDuBwGMTWqVG+RWNw4dCTZwSOwApNznOdQyyJycjElmvxN3mj0uN4fWjamrdce5TdxlZMeqKlO2LBCDhszEng0InVFQda/Hmmt1WwcMECX9sxTFXBXYMLShLnCUs1+qFARgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776156713; c=relaxed/simple;
	bh=AEXwQ9+zCpeRarpI+crLAToxDi6vZC8Hs1as6pCd9tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/wwQSJSzOZ8v2jyiR/0zpca1suI5BFeaTsPAnur1F07DLVL1KsQONAJVC0Vp6Qb+XrEa+EE+vrCs2/8c3iek4RPQvhPxA7Ly3tvf0ZpEy3JKisB0ApV+Xil+mCCCymJS4Dv19u+CXDdSZTaJraKgfHNHIp99ajDDTnwHeo49qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcJ0UqUR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2078EC19425;
	Tue, 14 Apr 2026 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776156713;
	bh=AEXwQ9+zCpeRarpI+crLAToxDi6vZC8Hs1as6pCd9tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcJ0UqUR1HWxQob5+TUyGTSp1j9V7/RfeyEcUcT0JkavYBqPFomDsk/tFrxmjjKH/
	 ZpZmnfKokk2JEx4I5YIPlnRmZ1GOv6ryaLaKF0ZkSJuT5jeJxyharSt2P7th8WuBG6
	 4M3HomPVWSxsjH+B9wAD7i+JHIaUn6HWzEfyMhnTwJvrKyVWiOGcPTRXEW3Ts24hgh
	 I0/ZpixNSnNQlQlsSPdHXBEKJ9p0bkeAwC80lmxc4+nx1nG8yhNp9m2MlFoEjKSAiv
	 HR/glsvcmkLIGkAQMRfZeT6b3Gq0NBFI2ixQjEd3M0QjOsl86SvgPmvpg4BiHf51+S
	 L7wy6TcL6qNhQ==
Date: Tue, 14 Apr 2026 10:51:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 2/2] pwm: pxa: Add optional bus clock
Message-ID: <ad3_t19jQ4P5NqSK@monoceros>
References: <20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org>
 <20260409-03-k3-pwm-drv-v1-2-1307a06fba38@kernel.org>
 <adyq-Uckwwe9uACA@monoceros>
 <20260414060453-GKA203300@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lg2qudji4ddugdlr"
Content-Disposition: inline
In-Reply-To: <20260414060453-GKA203300@kernel.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8574-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09E8E3F78C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--lg2qudji4ddugdlr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] pwm: pxa: Add optional bus clock
MIME-Version: 1.0

Hello,

On Tue, Apr 14, 2026 at 06:04:53AM +0000, Yixun Lan wrote:
> On 10:38 Mon 13 Apr     , Uwe Kleine-K=F6nig wrote:
> > On Thu, Apr 09, 2026 at 12:45:12AM +0000, Yixun Lan wrote:
> > > +	/* Get named func clk if bus clock is valid */
> > > +	pc->clk =3D devm_clk_get(dev, pc->bus_clk ? "func" : NULL);
> >=20
> > I'm not sure, but I think passing "func" unconditionally to
> > devm_clk_get() would also work fine.
> Passing "func" unconditionally, will break old compatibles(not k3-pwm), a=
s only
> one clocks property is provided, but no clock-names property

I thought that if there is a single clock without a name,
clk_get(dev, "somename") will return that one. But looking at the code,
that assumption is wrong. So keeping the conditional here is fine.

Best regards
Uwe

--lg2qudji4ddugdlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmneACQACgkQj4D7WH0S
/k6GUQf/XUpuHEHCjJWM30P5yPGqtdpF2dQLSODSO3OqjWaYtSgh9yTuYgTCUdjg
SgQbtGGQMih30RLAqIIZFnoR/Wc5vTMrN/QSel8Ue3FlPjQ2zfGv/0alEx4mo7ny
jZeBywaadyAhFxa0PZsRbMbiJAnp3OQ7P+E4zv7thoejLC8G08YtwGH7lOJHgriw
0WaGX/7X8wz/iiC4e276/etJ/KKHH7q5RyxE0F8gUUjd4Rtyk40VnAvGNvn25Txx
BVcgvaQ+s7WG1a0P3Pny4Jgm9PYEX1BgeZF1ItHlopg0IrCVQOsblygW3xazEdAs
Oy5LF5qKWbxCFcnkUnRKEvHCXNgCSw==
=CL9c
-----END PGP SIGNATURE-----

--lg2qudji4ddugdlr--

