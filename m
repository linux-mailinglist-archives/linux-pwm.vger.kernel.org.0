Return-Path: <linux-pwm+bounces-7420-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E26BC6A1D
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 23:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C6554E173E
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAC289824;
	Wed,  8 Oct 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JczEOkin"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC225B31B;
	Wed,  8 Oct 2025 21:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957489; cv=none; b=JtRWvifym1fdpdLK+zsOtAcDTdpjw/tdR+mfATSadQCDnHKJ0+OpHii+9c1MoARGkykLSE5WFQo03IP75LU3o007bCafhhXm9thFYgvufvjHZPxWa/S5dXgXF/tslovxkvreobWAqLIU1VLdprBtp4pYfXcridy5Ta+5FA8kmcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957489; c=relaxed/simple;
	bh=DUrTLLQsvlhnm79OFb+6dhzxJ2dEBoswcMK+hCZHfEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEUUb7C2dRi9GnUUW64WPtobEU6kUXTzWIIqwuV5SGEXTbQPMwnz+T/CwEjFT6wGFmt82YlLEH2UkyWGH+QRJpuBPruDt08QjhUJzhKvmTBtqmJOBhdSvEQ2pN4xnz/p7utXWaHl5reUOBjybBjwSQkB4FLrvpF1Bo/VIv3qRNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JczEOkin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6993C4CEE7;
	Wed,  8 Oct 2025 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759957489;
	bh=DUrTLLQsvlhnm79OFb+6dhzxJ2dEBoswcMK+hCZHfEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JczEOkinIROsrNKDxzKrLvWQJRt5CuBqkfRtlOigv/7DvJ4HLaW9izHy/OaZKBeYb
	 YuZIbw6CgTURhNfEjHEUItWpceTJ/pPfUTlVMFCAAVEDaclAJq2MJunuCwdkLoyNtP
	 6S5D7aBfAkzmJkiRRN5gVfeCAcmQ6SDxjs0n/zm7r79PTiO+IZ0dE5LLoagnAva7z2
	 DUqean8TX2DlIR6eWhrp2zQlGPZMJd4q22V2xYEZLnaDmOr/1Ne+dzM59qGfct7nCn
	 sbUj7pcfbukoIrWOOi2XlhE44Vr9936RN0h3Z0xud15IpdwHgWJ/keZbi/GYVtWGpI
	 ToPMmVQ+CB1Jg==
Date: Wed, 8 Oct 2025 22:04:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, ukleinek@kernel.org, michael.hennerich@analog.com,
	nuno.sa@analog.com, eblanc@baylibre.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v4 7/8] dt-bindings: iio: adc: adi,ad4030: Add ADAQ4216
 and ADAQ4224
Message-ID: <20251008-penniless-tiling-9a83d4b4ba48@spud>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
 <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+9vxzm5tGtI+pL56"
Content-Disposition: inline
In-Reply-To: <7e51e036ba930284c74cf42afd53b17d49093654.1759929814.git.marcelo.schmitt@analog.com>


--+9vxzm5tGtI+pL56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 10:51:37AM -0300, Marcelo Schmitt wrote:

> Change log v3 -> v4
> - Now only documenting GPIO setup to control ADAQ PGA pins.

> +    else:
> +      properties:
> +        adi,pga-value: false

I assume this is an oversight?

--+9vxzm5tGtI+pL56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaObR6wAKCRB4tDGHoIJi
0kHlAQCNN/lqGRisHBRNDTNe6yzS5aAFVyHucN9UkezRIKpd1QEApz2WA7qTAhYa
1jjFSqAogoyTGGp6jrtfczWr0b0Tvgs=
=jI7J
-----END PGP SIGNATURE-----

--+9vxzm5tGtI+pL56--

