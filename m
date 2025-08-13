Return-Path: <linux-pwm+bounces-7035-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A00B25485
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 22:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA26586F9E
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522612DE71C;
	Wed, 13 Aug 2025 20:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1189CjP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81E2C0F90;
	Wed, 13 Aug 2025 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755116953; cv=none; b=ekaBjHl7Cd52zgD+GjEvhDEzfbqbuzDq1dyhrgAz94VlL3cc5R0Vb0cSNa+/FPvDuG3zdzIidRDrE0Qo14bhR4LPD2FiLmYwKTkwpRMUgD/a6EqO49ZU50rUP6kYLyZG+mIRUwKlbiU8HwrcpuhNDjvfURP4GVnFBzK1us/71jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755116953; c=relaxed/simple;
	bh=JDqkqLnA1DgwrkxpFOGRanFFgHAOdkpUE2gvLXGPfb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSH8Nz7HHlw0IAJ4Tpf3nrWqbA741xnKoXzPJ2AkBLhyfBZYCGrF4UMkLV3E/tAqOHEuEDNJOvDwNtcemXfDCh9nDsMcs/1Zb8/PWfRTJ16VsvzNIywefkLJIZTcvP1YOkrJhSlUI+nCDGksnePKgAKZnHGSfGhwMMBEXcF9/PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1189CjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509D7C4CEEB;
	Wed, 13 Aug 2025 20:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755116951;
	bh=JDqkqLnA1DgwrkxpFOGRanFFgHAOdkpUE2gvLXGPfb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1189CjP9ZTarvY9ceaieigv/aNNlwUUoVqmGx2j6PeIT/sjoavrw+j0Ko+NMJPFa
	 Nt1+myVWY9FV32xNHi/gZMxbsA2SS0mn2m8MM5ySv/8OBgvrs+80YAP9/WpF5Rcequ
	 1XfNpBG3qsuNq93vUMFFNO/X8NpjrUrXgjzC8xdkk4cbhnBnvZ2kX0SbqOWX5nL7s/
	 xBtUFQZ0pWr1p1/YRqfPC6I5EpKj2eaBGjfXFFOyzQACJDQG6pdB+CwRknSu37nqgc
	 bbFmbK7s2DFRjzJB89bWZeoxFqnnPAqVV11jZt+d2REN7ZdW2+rEwogMHeUkAzFz/L
	 okM/auhD7lglQ==
Date: Wed, 13 Aug 2025 21:29:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	lgirdwood@gmail.com, tiwai@suse.com, conor+dt@kernel.org,
	lee@kernel.org, ukleinek@kernel.org, gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH 7/8] sound: dt-bindings: ti,omap-twl4030: convert to DT
 schema
Message-ID: <11e5ae2f-d692-4f34-8319-8fda028fda5d@sirena.org.uk>
References: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
 <20250811224739.53869-8-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z01+OwFMchK4Q9wz"
Content-Disposition: inline
In-Reply-To: <20250811224739.53869-8-jihed.chaibi.dev@gmail.com>
X-Cookie: Turn the other cheek.


--z01+OwFMchK4Q9wz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2025 at 12:47:38AM +0200, Jihed Chaibi wrote:

> Convert the legacy TXT binding for the OMAP TWL4030 sound card
> to the modern YAML DT schema format. This adds formal validation
> and improves documentation.

Acked-by: Mark Brown <broonie@kernel.org>

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--z01+OwFMchK4Q9wz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmic9ZEACgkQJNaLcl1U
h9DsmAf8C2WEGZVTspM9EPpF8Gy1IOWSpSZhVHAkTzZyrUIixzwbYvF4+DXjEnZk
HeWO9uMVHTG9As1ouM7GysgUGVrOH9UJk5VkEoIoZVIa+AI/SmAjNhkck1EZ85zE
Kjhtv8Mv2NN7vzsfFCg9EEdRN1JDFkxGXc0Au+/sSPbPMoW3E87JFUj4fCuXc/Fh
xqLN0fXvgk6FIpBM2gM9TlHuuGqXKj33PiNHNz2loWkLRZ1woZNnsURzUvQx/5xm
Mj6Mf/MTK7zzsFMGst2jLBICjj3G0Yk7iswk/9ZMwoT6ym5Xgy05nvaDAvzqPvKw
+6rernCFRjmR98GcHCQR+68pJD1JiQ==
=feCv
-----END PGP SIGNATURE-----

--z01+OwFMchK4Q9wz--

