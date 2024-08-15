Return-Path: <linux-pwm+bounces-3024-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B29537FE
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 18:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EC21F24033
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2024 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E691B32BF;
	Thu, 15 Aug 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNzJ6GoF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FAF1B1512;
	Thu, 15 Aug 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738296; cv=none; b=Na1rkFV482W4vjg1FlICTKjXP2bGEYNE6IXmoyERZm3eg/soYF/RhQSgWDNIwzlQuodcHXliI063P8Ip5Z85nhH0gISs1IguahizATfkSmBXtL07auEJjf2Q5XZzyHA7nzIMoI7udY/MmTGZ66h3Ln0KnJRELJj40ZUV2IZukv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738296; c=relaxed/simple;
	bh=PxxUNLRK1Op1mXSCSf+5ux4a9GTb2aTTZN7C5kMnUb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZN1IywvLFAoLnJRmPCjgqpX2pfY5RtgpM5GsuFI9WNJ9um0EvM0dW7/MWSY89NNhkmqagQzG9xFC2Lh5+Z28Ig93euzQMQG/S3oIey6ZUt0Vy5SeWF4OM8GkdOkbwX0rHocNuvrrhNSaV+YvmnlZZxJc54WHlEa2uPuC+mSDQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNzJ6GoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F71C32786;
	Thu, 15 Aug 2024 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723738295;
	bh=PxxUNLRK1Op1mXSCSf+5ux4a9GTb2aTTZN7C5kMnUb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RNzJ6GoF61TWJYY/9NGo9Aszd5m7ZdIhRnYiPCv+IiQA2RJ5OLAruuGvpPeaWF6BU
	 R80yc96+60xWf7dpuuXWMdom7hU3ksX5MqymAHUvuAUQeLNn4R2zLTUkDY44NrCJLs
	 XVhVBL0s8eh1nCPpjqge5kagNoiyRqDuIC5DFRtg1hgLODurcVwuP5nE5ISlBLW3r0
	 HzLpDiawu1iKOur9Sne15hiJIgpNoG+GIec1ymni9TYOqmA78JzIuOGnmosDtMRplI
	 plNw5SHO8jGg3Oxr1d+VPX9jg9bBUSvUJoUFh8RZLV7iZnxg/YNWwDPh1NI9lhAmex
	 FXUxL49Fw85+Q==
Date: Thu, 15 Aug 2024 17:11:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	20240705211452.1157967-2-u.kleine-koenig@baylibre.com,
	20240712171821.1470833-2-u.kleine-koenig@baylibre.com,
	cover.1721040875.git.u.kleine-koenig@baylibre.com,
	aardelean@baylibre.com
Subject: Re: [PATCH 0/8] Add iio backend compatibility for ad7606
Message-ID: <20240815-favorable-bulge-bbf0b9ed644e@spud>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y8SSMKuOe5JYK1iA"
Content-Disposition: inline
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>


--Y8SSMKuOe5JYK1iA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 12:11:54PM +0000, Guillaume Stols wrote:
> This series aims to add iio backend support for AD7606X ADCs.

Just to point out, your cc list is partially bogus as it contains:

	 20240705211452.1157967-2-u.kleine-koenig@baylibre.com,
	 20240712171821.1470833-2-u.kleine-koenig@baylibre.com,
	 cover.1721040875.git.u.kleine-koenig@baylibre.com,

Cheers,
Conor.

--Y8SSMKuOe5JYK1iA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZr4osQAKCRB4tDGHoIJi
0o9xAP0SASwe8xbESxPqwdG0ONIB1nZR4wqUlTp/EA0AdS3wGQD/d4T3GI7qf2hM
UviXVhLQym3CrZ637s6StEjIvGHRhgo=
=oxT/
-----END PGP SIGNATURE-----

--Y8SSMKuOe5JYK1iA--

