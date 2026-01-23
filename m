Return-Path: <linux-pwm+bounces-7999-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PhREn2tc2nOxwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7999-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 18:18:53 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D578ED0
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 18:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7C09300A600
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ED1258EE1;
	Fri, 23 Jan 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0L+ihcn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0096021D3DC;
	Fri, 23 Jan 2026 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188609; cv=none; b=EFKzAQFJfJXNSkZ1jAmdeiaFCyJ6ecG0eN5dNA1mj3FKCV//RNH2QK02HHegoLv+ZZpubF7rZ1pb+iMz4/hTBAgEU9uVQzkttrX7Y4Z6Ksqk+tTSkVFsU39Xca57tYbyzQhOgk5vv8y3OTHmXKfpfPCnzslEB3hzh7o6N49ppas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188609; c=relaxed/simple;
	bh=aMDxWhlC5nOmrdQBlFnypdMUOLvQlVAHKKR2/LaH7Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEYv3T6DouE7EgC3JZD6ZwdhuoW64l/bGz7OyigzDr8GGLB2lnupYObIC3vjpPbETN3oXqi/larllnnB16NOhUGhooEmWUn49L0RwpC0FDRfZ+VfFaC1tQBJ6uEnxRTiXFOchG4YLz82/TS2rS1uCDD37ylrHa1fHG+Z1kxCav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0L+ihcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3C8C4CEF1;
	Fri, 23 Jan 2026 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188608;
	bh=aMDxWhlC5nOmrdQBlFnypdMUOLvQlVAHKKR2/LaH7Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0L+ihcnCO6gK8k6F3P/u+Yi1giyGodb/U+f+X5b2HpCoQVzrEBgP4n0d1M9hTAh9
	 BbkUy8ybvvn90rQJJr+re5tob9gaMGkoHRtKzb3rf4xEgoqHpy4rSreTbfGDIziIge
	 m4h6t7JtiNxNPAJ7LVgU54zd6e8a3wcdhLP96mu9Xi27k2RgvBAm0/aTTEsB1oEh+8
	 d+TolSHEitGsAvWk3EFD1A3Z80hqeKK4/uvFNb8Z6KnLq9fkqUALrcbGsSQ0GUocI2
	 OPE9w0L7tT3o9NMMwywL6RY9LMy8K87RdURNrKyTRbzut9wZUMuS2djSb0suuLNZHJ
	 22PX3rteUcdwQ==
Date: Fri, 23 Jan 2026 17:16:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Kocialkowski <paulk@sys-base.io>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: pwm: allwinner: add h616 pwm
 compatible
Message-ID: <20260123-crook-siberian-8585f695d630@spud>
References: <20260123093322.1327389-1-richard.genoud@bootlin.com>
 <20260123093322.1327389-2-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CAw543iWCw6hPofx"
Content-Disposition: inline
In-Reply-To: <20260123093322.1327389-2-richard.genoud@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7999-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de,sys-base.io,bootlin.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A34D578ED0
X-Rspamd-Action: no action


--CAw543iWCw6hPofx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--CAw543iWCw6hPofx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXOs+wAKCRB4tDGHoIJi
0h32AQDLqV2mPg23b2nz6Sb13oSR73B61KVZ6efRpRHAMb/5PQEAkVqiTCVFbhVf
BJ7Cx0d0nfZ7dqTZwBrUBLQm03iSYgU=
=qfxy
-----END PGP SIGNATURE-----

--CAw543iWCw6hPofx--

