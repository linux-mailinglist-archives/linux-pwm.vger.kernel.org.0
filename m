Return-Path: <linux-pwm+bounces-5683-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834AA9A256
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 08:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C83F3BEE82
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 06:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4141C860E;
	Thu, 24 Apr 2025 06:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIJ4L+Qr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4217A31C;
	Thu, 24 Apr 2025 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745476502; cv=none; b=Ucl8aBoklb3AzYOdRw1r7VBFFxdlImg1SZ9h/Bffqzff0V9v0q0PDEy5wu8fAevkaQaFpy+t8GSUN9UAW3YoTUMrgc3gqduU8vHxSffs9hIqW8m9rHdpP/zt0xOlZfOtePJw/2fXp3VoRBEdG/ZXQ8gbqAMYatjre9cKa9Mdylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745476502; c=relaxed/simple;
	bh=4gClZZchBPS5nWHetbxzyLcECQQe429cDxgXba/S5p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIGelneMczQ5Zi8MQEGxIuGv35XTpvzGVglurcqzoNeXjUuW8Muy0Imv2eyKjKrx/91AXs4+H672f/NTpKHZzXtha/5cFcxkTEmtMNifppY+WEPYBPIcVK3l821Iifk1CDIZi1wRACP3TDASDtmO+pChdxT1fpDx/rYZqNPwgdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIJ4L+Qr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D49C4CEE3;
	Thu, 24 Apr 2025 06:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745476501;
	bh=4gClZZchBPS5nWHetbxzyLcECQQe429cDxgXba/S5p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIJ4L+QrkTELRIRh4kjqs0BHkuu80qMpSFBaEm1F0cenLZJb0F7MyPPfUTFUP6yRM
	 bYzv+IwctnllFt/Ka5OA6W80dGA9tERFTU9XDKvtmOX/DPwj9Li+821K7qHCl3CuQa
	 cYjm70RTgYtq/V8oUsZS/Y+CibOu5KK4kBZ9sD4AkZrANZaFvQNmvctdx3n/lcsRje
	 VBYHnJWBcsRNFllxDffEerx4EwjrFYdOXOHsJP6hroDwE/4x9S5A7+qXmKNQC5FGGZ
	 z8cVTIiB62kmBd6M6Nz7o6ysDMcNYhp671krnng45ePVcNpmknv+TDP17E9axLgHe/
	 cBq6efIzoyVfQ==
Date: Thu, 24 Apr 2025 08:34:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
Message-ID: <yscledgclp2v4p7djwrszbc3dnqifkcofky7rugkcip7o2rmof@xljfd2kfyzzs>
References: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qhetb3dose7tjp32"
Content-Disposition: inline
In-Reply-To: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>


--qhetb3dose7tjp32
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
MIME-Version: 1.0

On Fri, Apr 18, 2025 at 06:55:07PM +0400, Alexey Charkov wrote:
> Rewrite the textual description for the WonderMedia PWM controller
> as YAML schema, and switch the filename to follow the compatible
> string.
>=20
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Split the series from v1 into separate bindings patches so as not to
> spam all the subsystems with unrelated changes, per Rob's suggestion

That's a good suggestion.

Applied with Rob's R-b tag to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

I saw you signed your patch using PGP, which is great. However I didn't
find your key. I recommend to make it available on keys.openpgp.org like
this:

	gpg --export alchark@gmail.com | curl -T - https://keys.openpgp.org

and then verify your identities using the link in the output of this
command. Still better, (additionally) add your key to the kernel keyring
(which however requires you to be in Linus Torvalds WoT, see
https://korg.docs.kernel.org/pgpkeys.html for the details).

Thanks for your contribution,
Uwe

--qhetb3dose7tjp32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgJ248ACgkQj4D7WH0S
/k71GAf/cV7upSehxuOa5yALPuIkS68mnMURiVpePuIYzsRORKndFKnxWyqUXbFW
RpbACn/GJCb21cf9SV5Kf1UtDUszG5rzJvy3se0FUoq/z5YFc9E+xaXKjpn8Ihet
XX7sv7UPi+gGHKzztpiDpUXCmOHbWPf8kp4IvvjMyZdh8tr4Nv3P2WuhMdGak28+
DINKNuRrqnZL/A1VblAwbwhAPCVpGSj5xpfQa97Gg6i9Xc1tzVdujhlt9d5vl9zT
THzXD7o1if4I4KS/P99qpUmJZO3sFwXfiVA8u/xNfcgEY48qhUGHQt+QuF20qCJC
KU9yOZDFmT+Sclw4+G8KTxI+uaSp3Q==
=edGU
-----END PGP SIGNATURE-----

--qhetb3dose7tjp32--

