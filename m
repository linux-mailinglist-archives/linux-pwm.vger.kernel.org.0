Return-Path: <linux-pwm+bounces-8312-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JdwKpJhvWlF9gIAu9opvQ
	(envelope-from <linux-pwm+bounces-8312-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 16:02:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C32DC3A8
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 16:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15BAA30D31AE
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 14:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF033C73FC;
	Fri, 20 Mar 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8PyEklX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54273C73D9;
	Fri, 20 Mar 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018228; cv=none; b=YkaApWpyNErZUvZFHnc4hQCwtb7X9k0dUxz6IVmW9QdKWXxgwiFRBEQW7qejIBwk0y9MOd9h7/eXug2XYboF/ch+tBheDPJgF0FO0+NDdZtyZx1KihDeyc4B9F3+d2b20szNRfw83BZcKWDx7C9l9BhGd3HlSVuim6cIfzcM1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018228; c=relaxed/simple;
	bh=xEq0lkHiWlfzRjTk9tAbY2BUU4eS/9QAmtJ8rJpta60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho83ocKaPVOW6sTICrI+fQjeL1xCvyL6nMMUos8WO9+gGLYIaugt/NHOozipZhP+860xTRHQejtcuURFlB8xlPMPOIKtBVXXdtDVTfU+vW6VNZEjJv80WHR7V+hvLqFYhYo6Z9fjej2CDoIDMDC4s7gHJUSJUJImIJ4ho81qQkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8PyEklX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FC3C19425;
	Fri, 20 Mar 2026 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774018227;
	bh=xEq0lkHiWlfzRjTk9tAbY2BUU4eS/9QAmtJ8rJpta60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X8PyEklXlRJu+UqDu9GCKeEZJfQdaZQ3fRzearO8/+biLOD5xVHtfvWxJ83UTPeTm
	 e3vfw/zpLxQpWpcuCfR/Ot1WDWP6YV6P0j3HqTUX9hXJDnxljg+GIn6pFEgBlqPe8i
	 GMJJKLqjV2etuZF+CCXEUaMFnWJKgxzzldDO9rHQdo0vESuUDXw8L/GJAGpYHk44bO
	 v+KchtE9yiJAOELCm8qR2BhmbUSSPoviK0FF2OWgY2BSP9ciCloM3FwE+nPW9lzSdZ
	 x/jvOIcgKEl/RfsbNMEDvoNAJ3xRPleQRcLWO2w2X9XMw0kVjdrM4NhhMMcXvtgYAV
	 VoCq4zNKjnF3Q==
Date: Fri, 20 Mar 2026 15:50:24 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Janne Grunau <j@jannau.net>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Linus Walleij <linusw@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Sasha Finkelstein <fnkl.kernel@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8122
 compatible
Message-ID: <ab1d82Y9dGzstkgy@monoceros>
References: <20260320-apple-m3-initial-devicetrees-v1-0-5842e1e393a8@jannau.net>
 <20260320-apple-m3-initial-devicetrees-v1-7-5842e1e393a8@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pshe747cvhfvjhsk"
Content-Disposition: inline
In-Reply-To: <20260320-apple-m3-initial-devicetrees-v1-7-5842e1e393a8@jannau.net>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8312-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,gompa.dev,linux-watchdog.org,roeck-us.net,openbsd.org,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jannau.net:email]
X-Rspamd-Queue-Id: E75C32DC3A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--pshe747cvhfvjhsk
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 7/9] dt-bindings: pwm: apple,s5l-fpwm: Add t8122
 compatible
MIME-Version: 1.0

Hello,

On Fri, Mar 20, 2026 at 01:23:25PM +0100, Janne Grunau wrote:
> The PWM controller on the Apple silicon t8122 (M3) SoC is compatible
> with the existing driver. Add "apple,t8122-fpwm" as SoC specific
> compatible under "apple,s5l-fpwm" used by the driver.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

You didn't say what the merge plan is here. I assume they should all go
in together via arm-soc?

If so:

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

Best regards
Uwe

--pshe747cvhfvjhsk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmm9Xq4ACgkQj4D7WH0S
/k7iZQf/VTQKMp3e1OfZ1SAfsbTIm7E2kaGDHWHFtIVuX45NMEsa5s60N6D2/j0T
nwX7JnD1CLlsDCLGR9s3H/iTHHlfdmptcfT2+I8ViUMDZ5driYxpysuUMnyDfzMe
aQbUtV3SRsRzD35HLuiLV06UIUXEiwt1aeBCZRlzfmWsi14Or0IPcHY/D1lPnVvT
bLrFxHXIfECSWwXcuFekr+Iu7h5iM5EuUiJ7JcaPW4G/K0a+mL8s5LbV69kGF9Lb
2y+ow+PAdQbmSY9swQuO17set/frraA/XfgUV5DmB+QDwXZ/r927lMNIbdsfTPuk
woJH3T+AOnP7z2Su0xKexD40E0FiBA==
=kFFv
-----END PGP SIGNATURE-----

--pshe747cvhfvjhsk--

