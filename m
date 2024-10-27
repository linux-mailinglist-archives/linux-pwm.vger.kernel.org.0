Return-Path: <linux-pwm+bounces-3926-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544509B204F
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A5F1C21189
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EC517B402;
	Sun, 27 Oct 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hii6+6d6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83D79C2;
	Sun, 27 Oct 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730060665; cv=none; b=ZROEo08UL2Bb6GZ86waI5A3RGCtqOeB6aRGs3lVfIDJKmuPjHA3a031AHySVgSFBvQc4Q29Igsg953KJjmSAJQFQuz9BYk4/ggezVAVJZG2qN/WNU7WdpBOw8uw94nJXjyaDnCJvTpqc/XEGCV9TIZuBzp36S2w9acMKHSkvXtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730060665; c=relaxed/simple;
	bh=zealYBrI6W8wdD5666Nv0nCWGRRCBk0RAzKP+h2Zbqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUydQhQjJ3axmHy1iMkVV1LAErqGxzk/c9HW7mcgueDhZaXKUvxKP2JP1PyfAqAqO02a6GZ6Z/VQp1DyJUc6HPS12TBxGqGTONwjnpvAGJC/XRuoEKHLdfi/qFwf3fiVPVRMwWTJE22jzPvUOpcAsAI8KQPnJTaLZABsNnq0Zxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hii6+6d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0EFC4CEC3;
	Sun, 27 Oct 2024 20:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730060664;
	bh=zealYBrI6W8wdD5666Nv0nCWGRRCBk0RAzKP+h2Zbqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hii6+6d6G5kHdfmltb0sDzctukHhQVRjUaMvsVDy86prI/HvJwxEECt5NB7aY1Lpl
	 cqSDbNi4gox0Dab658yIUUbNh8e9qQiE7iQoUv/BB6xQDqOSeoObrctJruls2KO65U
	 GW2QuLJlpjUACc4aFZNNTfDlCezJp/8yrgiJdDZ7qyMZr3bm4GyS10QyvZ76EfnwSM
	 NPQPLQCYDKRE7BeuTweyPlC40BKaWQTd9xQfrtpNiy/3NEEQh86NPX/pDALVDTXMnw
	 OavhB1yKHu8zUFdNawG9U06CO1c+PGxhNAvEhP+ToetWZkq+7cZKqnrKhJKKUQzXWq
	 +BL+eSiMHrpsA==
Date: Sun, 27 Oct 2024 20:24:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 05/15] spi: dt-bindings: add PWM SPI offload
 trigger
Message-ID: <20241027-uncaring-popsicle-d64e25f954e2@spud>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-5-f8125b99f5a1@baylibre.com>
 <20241026161837.30a56ae1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l2yxdNpy+aKzuPvZ"
Content-Disposition: inline
In-Reply-To: <20241026161837.30a56ae1@jic23-huawei>


--l2yxdNpy+aKzuPvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 26, 2024 at 04:18:37PM +0100, Jonathan Cameron wrote:

> So this one may need more explanation and justification and I'd definitely
> like some DT maintainer review on this at a fairly early stage!
> (might have happened in earlier reviews but it has been a while so I've
> forgotten if it did)

I intend looking at this, but it'll be Wednesday before I do.

--l2yxdNpy+aKzuPvZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZx6hcwAKCRB4tDGHoIJi
0perAP9oQoeOiUJ+7aWxSJJ+VLf0bQCYbgBVVl/ZrZEuqyfEYQEAqlGurtl/bTSb
+FbT17liXH5mCGTXaWgWZST0cnSOsAo=
=0Fzf
-----END PGP SIGNATURE-----

--l2yxdNpy+aKzuPvZ--

