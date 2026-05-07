Return-Path: <linux-pwm+bounces-8840-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNm/Nz+s/GkNSgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8840-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 17:14:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620C64EAD9C
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 17:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5FFE30067A2
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203937475D;
	Thu,  7 May 2026 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLRHNBHD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDEC23E320;
	Thu,  7 May 2026 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778166652; cv=none; b=H3kSjintmVPfvY8fqXebgtfcV6IFWX5imWjhMesmS2KeSpYnUZ9ZOENeOSv4iLWO62o6gUGSCbRVQ02XSt8LhAot+g6VFp9RCu/xVNl/njUojKwdpbS8xJV51uHZVQ7KiNXxqgWyOz1wBuCCeRSbHX/2kDNVa51LARTlU1iycNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778166652; c=relaxed/simple;
	bh=tsBfVPTCZ5IUcJdFvskcbUleeAO2hrmio9stQ7rwRhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cE35MSexmjJGDd0QwXECMRpX0TdtPBYRHEf6vA4C1zx9Kteg8YGojMJpwoQp/vKHqCJULi+xle9jwMTuMx5JN0cUrg1W038Qm2Gr3m3Z6KBNgfXKUziZiIrrd21VZeaJzay3q0WzM/ILKuH5UEZwDg+24kJVI4ZhAEDEUR54abQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLRHNBHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7682EC2BCB2;
	Thu,  7 May 2026 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778166651;
	bh=tsBfVPTCZ5IUcJdFvskcbUleeAO2hrmio9stQ7rwRhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLRHNBHDZylButJQ8c2+7lButyda4pakF/u7sqIIEgYShZv4cNjx1Vv23SNdo/f+H
	 cvHjg4DFgeBLCRrs8JMR0lOBeiCrrhauIo5VV3mxnaiet4hFdMqGICcIBnjweM18Ki
	 QNNFTZq6B3EzMXpWrOpIodr5SrzpFcPiSJ6E2OIgyAO+B3ANLQ7duAdGfIQPeqkTn9
	 7h9bHWpx59WpDdCqpi0jyVwKagC3nYjjqf+rYQgr3vNNCFVkYEDX+DneOHdj/8XOB8
	 DT5ByVX9yhubrPSt0FhaGuBIj/uSY2aAolMbZXJ1PdFKCOHZqARBMp1DO8DaPY01xC
	 8VGQF2ECgUdWw==
Date: Thu, 7 May 2026 17:10:49 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: linux-pwm@vger.kernel.org
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Consistently define pci_device_ids using named
 initializers
Message-ID: <afyrQ9_saRlKv-Fi@monoceros>
References: <20260504085535.1914668-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxe5n4y2iddipvfx"
Content-Disposition: inline
In-Reply-To: <20260504085535.1914668-2-u.kleine-koenig@baylibre.com>
X-Rspamd-Queue-Id: 620C64EAD9C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8840-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Action: no action


--bxe5n4y2iddipvfx
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: Consistently define pci_device_ids using named
 initializers
MIME-Version: 1.0

Hello,

On Mon, May 04, 2026 at 10:55:35AM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> The .driver_data member in the various struct pci_device_id arrays were
> initialized by list expressions. This isn't easily readable if you're
> not into PCI. Using named initializers is more explicit and thus easier
> to parse.
>=20
> The secret plan is to make struct pci_device_id::driver_data an
> anonymous union (similar to
> https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre=
=2Ecom/)
> and that requires named initializers. But it's also a nice cleanup on
> its own.
>=20
> This change doesn't introduce changes to the compiled pci_device_id
> arrays. Tested on x86 and arm64.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--bxe5n4y2iddipvfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmn8q3YACgkQj4D7WH0S
/k7wvggAmTiTOKr8lbW0iMJE+cffeuK98DCbwhAbZHHJxCELQ2Y5UfUbVzrqgV9Y
89TShLVk/xcET71gnD8CW+pq+/KD/ObnA69v0HVQ029jP/5DQ/l//0facjhaFCs/
k1VDat2bn73LyZ9E02PR9WF+5Q1uTv/T0NU+aV35umyYAiYUsSOJ7LOZmdAr2+N/
C/4Gvc1rS5bMoYf8f0lu2LEOo9odr9dmGHOzcW2Dpz5eoMzZXL7pRROiYanOORhJ
8pD2u6Yrca6UMjnIUjIAdYjBTz+byfYKARaGgt9RwW4yv9tok7EP4pedGrIsd74D
IqLiDy2J2Jbkf3hrnvBdEFDpL5sxMw==
=jbWB
-----END PGP SIGNATURE-----

--bxe5n4y2iddipvfx--

