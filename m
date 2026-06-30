Return-Path: <linux-pwm+bounces-9485-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YsAaK8yYQ2rEcwoAu9opvQ
	(envelope-from <linux-pwm+bounces-9485-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 12:22:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA976E2C29
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 12:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Ez+Zzv/r";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9485-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9485-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E3063014232
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 09:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F43E5A14;
	Tue, 30 Jun 2026 09:59:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55185317164;
	Tue, 30 Jun 2026 09:59:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813578; cv=none; b=UFet9wToJBRDrHxt/KBMsHFtVJ3Jc0omwuE2seak4+VgSbRvHki/6xG979QiZhpkPXE8ASlAI2nk0fZGkr0sMOnqN/22+0N23ExLakcKOsUuvABhzAiriEOh9FJyww/BjByIH2o55BJxXzzuMmM2QI3dX+81g79MxUpe/3U+RCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813578; c=relaxed/simple;
	bh=9HR80y+uE7bIR4bZjVORkXp36/uTWSKCANgLeVCUwcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eu753kZiLTzqPSP+r3/iEiuVljw04HYKprIDwg1bdXqfH2dR1NmeazJVRdkwPi2xae2cJePTYJ8txI2g2UEJL/rBPOQyt3RCh2tysZivlxUSBVs6CxtZGluGmv73EmwzRAgYqU6pWD1Cf8N5e1zEeIMbZ6r1Gb3cUJ5mG/ahaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez+Zzv/r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8609D1F000E9;
	Tue, 30 Jun 2026 09:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813577;
	bh=9HR80y+uE7bIR4bZjVORkXp36/uTWSKCANgLeVCUwcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ez+Zzv/rHixTDU9gexxUTS698bwowOyMBM+JBX6OjvBL6C//6Bj4+Yume51fzGFvp
	 iUx8EuPt6BwTdRdi8eudfMaGoGI7tbwvSg8sbKRvmeT2HQs0Oqv4mBj4Vcl6JUSqam
	 H+kzp0Y3k92jQ3JBJGuhUTBfPRlwghgyJJDb2XeE+iP1VbAkuwnADIKSjJjs8iIAii
	 0J7B7TcnOXdXdsUGao/RRCSj4dzq4xTeHHvmfNDoNWeKXCx25qff0NARydJqw6pMUz
	 oLCtRgT6WogFsTclYFRcCv4FKqSAidNvLX6CFMFzmngxx/GIdJy0CoSBagNR8zmKWD
	 y1XzwW+uI/K5w==
Date: Tue, 30 Jun 2026 10:59:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 1/3] dt-bindings: pwm: opencores: Update compatibles,
 examples and maintainers
Message-ID: <20260630-footpad-barbed-2415fb3acd5c@spud>
References: <20260629063601.63917-1-hal.feng@starfivetech.com>
 <20260629063601.63917-2-hal.feng@starfivetech.com>
 <20260629-unedited-tarmac-b6eaaaced8fc@spud>
 <ZQ2PR01MB130775F6E674F6074A6E2CA9E6F72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zxIQn28rhvHzrlL0"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB130775F6E674F6074A6E2CA9E6F72@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9485-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hal.feng@starfivetech.com,m:ukleinek@kernel.org,m:p.zabel@pengutronix.de,m:robh@kernel.org,m:krzk+dt@kernel.org,m:emil.renner.berthing@canonical.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:aou@eecs.berkeley.edu,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,spud:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EA976E2C29

--zxIQn28rhvHzrlL0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 01:15:09AM +0000, Hal Feng wrote:
> > On 26.06.29 23:00, Conor Dooley wrote:
> > On Mon, Jun 29, 2026 at 02:35:59PM +0800, Hal Feng wrote:
> > > Remove the jh8100 compatible since the JH8100 SoC has been canceled
> > > and will not be released. Add the jhb100 compatible to replace it.
> > >
> > > Change the register size in examples to 0x10, since an OpenCores PTC
> > > IP has only 4 32-bit registers: CNTR, HRC, LRC and CTRL.
> >=20
> > Actually, please also add a fixes tag to the original commit adding the=
 binding.
>=20
> OK. Will add it in the next version. Thanks.

If this version is up to scratch on the driver front, providing one in a
reply here will probably suffice.

--zxIQn28rhvHzrlL0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakOThAAKCRB4tDGHoIJi
0pGDAP0V84v0E0JF11z4iKvk1U9IU4AGvM9YLUuWPTFAiaNNBwD7BJTuPKX9SsUT
AMmioCQOnL6t08Nvm8frfHvjzxL7VwQ=
=konP
-----END PGP SIGNATURE-----

--zxIQn28rhvHzrlL0--

