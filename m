Return-Path: <linux-pwm+bounces-4671-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25375A15CC1
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 13:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580EB167336
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jan 2025 12:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EEB191F68;
	Sat, 18 Jan 2025 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFAEtDvP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1063191493;
	Sat, 18 Jan 2025 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737203413; cv=none; b=oEhZ68ooqmKwFDZjEesLA7wpQqswkQy4PWrdyKa1HuH3R9UFff+mpnbfu8ra1N+VW6xQ00j8joRHG0y5e2wexQtAkuev0Opu6OC0TZcb+yZWzOzx6a6NTGH6Yg0280/tfjiOGhNsiNjooCpudBmJkAspFzv9bJ7tko+N1HSETT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737203413; c=relaxed/simple;
	bh=SsP8IaUkBEZO4hK6LfQMg1++ehopkVBbwlEFkXSdrGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgBxYI8+7C1UDINeO+C9xCQDJ3reSPM0GeT1LPKOzjZMonGSHrW06K1uMYb4z1aYzWEcJw+WXvl4xu0gGsi+soMzmwM+BWWBIdmNuSNj0e5Gtw7n1WPS5Zb2h2cyJIzTy2Jv3RdoxCRwKYelX+yWSM68/b06fZmZKURKyxdOmLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFAEtDvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CC3C4CED1;
	Sat, 18 Jan 2025 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737203413;
	bh=SsP8IaUkBEZO4hK6LfQMg1++ehopkVBbwlEFkXSdrGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CFAEtDvPc2JxsjR78qoCsPkewbts3/1TbSBm4/3T8b3jjr/4fXf9Sd9JLLci5uGgr
	 11nKBBzHJUkcRfcWNmXD7hTbW7E9xj0LE017dicLuYVUQ0cIYdFEnLb4qLT9f3vTAV
	 ZqcodkQc3dPLLGYH/qL5I2rC3fLkZTGD/Mf2aBYzLA+1/Jt2YFz2X9BPwi9UD+tff2
	 sVRkXYORZrYUzKVbS/x7Q9C7QZ/e3RErOAj+0UM2yl5xsocsLOhkZKtzKXJSkEn4wX
	 DUt7+bttdxk2k1ligY6L6NSyvkvZmnKzOHriE6ujDKW5RNDpQ/F3Fbczlh2PuaM196
	 ZFTSU71t4CDVA==
Date: Sat, 18 Jan 2025 12:30:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 14/17] iio: adc: ad4695: Add support for SPI offload
Message-ID: <20250118123001.1ae96a0f@jic23-huawei>
In-Reply-To: <6458a3e4-594a-44bc-9593-94d115013c1d@sirena.org.uk>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
	<20250113-dlech-mainline-spi-engine-offload-2-v7-14-e0860c81caae@baylibre.com>
	<ls32gl5a7nsihmmpfabxhm6ilg7idyxdhyrhbkay6e2fiokoah@o5ujfxlsq3s3>
	<67dc52c4-5252-40c3-b89e-8e46e3c2df27@baylibre.com>
	<6458a3e4-594a-44bc-9593-94d115013c1d@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 18:18:14 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jan 17, 2025 at 11:09:03AM -0600, David Lechner wrote:
> 
> > Indeed, thanks! Hopefully we won't need a v8 and Jonathan can fix while
> > applying. :-)  
> 
> FWIW I need to do another proper pass through but from a quick scan and
> my review of previous versions unless anyone else raises something my
> plan is to apply the SPI bits at -rc1.

Works for me.  Assume as a nice immutable branch I can scoop up ;)

Jonathan

