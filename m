Return-Path: <linux-pwm+bounces-8289-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPOUAoIjuWkrrwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8289-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 10:48:50 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E02A7318
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 10:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A4E305A40D
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2026 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C00C39F188;
	Tue, 17 Mar 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC4YnDEJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7C371CE2;
	Tue, 17 Mar 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740561; cv=none; b=KjBz+WzjsVm3LZC3o/FJzkP9ColLmdKAmws8QkmtsFdJne+bwplxmB56BWMnnC9IcGZpIWOacrhd/QbwWisXIMtAkJmunfaPqmGyb0ZYx8fBriaBEOAJFyp0D8nxBPCC8pDNZW+T8mdq2zmfbkEFv1pwFa8UXgTeHo1/pcsbSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740561; c=relaxed/simple;
	bh=GOgDglq38ZJQbFD9CQRV0CUd4xxBjr9NAQ/XAYazlMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErI1GdMnuzZTU2LxGzDmwlVBj8DxNZiYxDSSTqIJBSqQROQielgCCZOmaZl7tgcOOtN69fJzFw9XZJ3RqnOwhqS9rO8y8Dsboqy/1L90Xa2B2gZlB8Tk6nQm5d8exrVOYyi8XRCpal7nA6Je2Rr5zjyyV0GjvgoqJW4omg1aAIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC4YnDEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919DDC4CEF7;
	Tue, 17 Mar 2026 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773740561;
	bh=GOgDglq38ZJQbFD9CQRV0CUd4xxBjr9NAQ/XAYazlMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rC4YnDEJjVyIL0EuKnWVKCgniluJiL4dfnUiWcyufq13pI1ifp/An3oC+2yV94Zo1
	 a8k/e3BEGNccINq+Fpgq2tEwUNIFkD/Xm1QkEhHpEAfcbQK3JGJQY9svWUEJuwusPC
	 3Q1YBy0orWspi+im23jtcsBLXQqhSHuqW0rSdB6e/B6fDQxaG5aPJKA9GITFdVCehc
	 bCJrxKFqGFKWRiAHHk0qXCk9QQQlmuKomkhPNsBpNBvbULb9WaGLaH6mZJG5TQ02c6
	 u7hmDVkGR2rh3f6oejFh+Zvx/0Y2EWHErXo3DNXN0gSAMGuQ3vNPlyofkRzW4Q5KhK
	 0gjy/jKGtncUg==
Date: Tue, 17 Mar 2026 10:42:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Xuyang Dong <dongxuyang@eswincomputing.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ben-linux@fluff.org, 
	ben.dooks@codethink.co.uk, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <abkg_5PlNLfyAEmw@monoceros>
References: <20260306093000.2065-1-dongxuyang@eswincomputing.com>
 <20260306093058.2126-1-dongxuyang@eswincomputing.com>
 <20260307-charming-shrewd-mantis-54bf9f@quoll>
 <2d4f2cf9.3fe0.19cd1e8df20.Coremail.dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgwzkypnenelndf5"
Content-Disposition: inline
In-Reply-To: <2d4f2cf9.3fe0.19cd1e8df20.Coremail.dongxuyang@eswincomputing.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8289-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 964E02A7318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--zgwzkypnenelndf5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: dwc: add reset optional
MIME-Version: 1.0

Hello,

On Mon, Mar 09, 2026 at 05:23:45PM +0800, Xuyang Dong wrote:
> The DesignWare PWM controller provides separate reset signals dedicated=A0
> to each clock domain, as specified in the hardware documentation.=A0
> Without asserting and deasserting these resets during probe, the PWM=A0
> output may remain in an undefined state after system reboot.

Note there is an additional difficulty: A usual wish for machines with a
display is that the bootloader sets up a splash screen that is smoothly
taken over by Linux during boot. A reset of the PWM driving the
backlight then most probably results in a short dark display which
doesn't qualify for smooth.

So if you have a way to distinguish between "random state after
power-on" and "already programmed by the bootloader" this would be
great.

Best regards
Uwe

--zgwzkypnenelndf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm5IgsACgkQj4D7WH0S
/k76Hwf+Is79BfN2t2mk4AmX4znPAvPkJFzQZ64CCr/XjKKXcSFLUKH2iCjQgHgV
+w3kpzNO55hWMfbAQR3Pt7FYHLXOsPA5qxxMaKqJoQDFkCtS1Qwi0zQCWnIPio+p
ujYxrJeaBHmrcy71VCG0sSMxIErrHuELuLPtJ7BVeeAXQehQP297HtQXYReNQkkt
PTaBW0TwN8a7FJXgWGPsl1nN/nLD2LPG2cKrKdpNZR0dDc+5evZj8K6KGF5aiQnN
CKXMw93ewCQZQKioRUeNd0ahD6RcOmbDCRqOSA/Gy5AaPY5J0tSGaZoQCyKnG2Uf
oS9LE9hEMZasEwEsV+bskVXqTumFqg==
=ftGc
-----END PGP SIGNATURE-----

--zgwzkypnenelndf5--

