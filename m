Return-Path: <linux-pwm+bounces-4130-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F59D7602
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 17:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943DE16471A
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2024 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6641D18A6D4;
	Sun, 24 Nov 2024 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcHso7FN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC82188591;
	Sun, 24 Nov 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732466419; cv=none; b=XvMvymEGT+hEpRI6uAlUp9sqvSY+2MQVX4gwoHQurx+XZF+3kUPX1cixxebpbS+McgW/d4Yutcyj8hH0/UoGjX0ZRTrFYxgw2nDBPh0limAyJ4HbYx1X7q6oVoV3HvjDEfkv3OO+DAfXKx5ByfzkPRV1I8NloJumy7DYyQoDrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732466419; c=relaxed/simple;
	bh=ff6MOp1koNCPydpHXMFqMXScTcgzcrX7XCuPo8+XNJU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afsZxqlwOvBZxCErf0+XiFfpJXwh0oM8kPxyhilI6oQrKpJRgZWl/WH6W6c8/mAdUlGwFuuQaulrunERx+xUb13OrFZcTyeOu+OlxeeO6xtkaKTKjJddXzki9V7KLZymaL9We62HQOpkXC7U1Opu2HhSrqs7Nrs8Hm77/kWMQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcHso7FN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B3BC4CECC;
	Sun, 24 Nov 2024 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732466418;
	bh=ff6MOp1koNCPydpHXMFqMXScTcgzcrX7XCuPo8+XNJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BcHso7FNSv4Bl1MbQgwndisE5PDRqh7I0IWqx9wFZQuA34hqkwFkuG2uzc2iGKECb
	 N+8dsmizM7GWcAbxDXALJTsr7e7Ucbcua6dAAYDbC/KmlrRXiBrAmz4RsmvaSyuF7Z
	 lIS10ujumHhgUn79BGBFlV+Vl+zO84lgnbxhIELU0vW7miInSa6KNkPksCs83idZrL
	 XVOnZhAdrb9GjESgX8gqmRWb0sCKCRXwOonLa3YQGVFdPOeuTJQOaeJaTMjhIIHUS3
	 9B5b2E0Fcz3ymm+CGEIXLGaU+YJWmIjkj4aHqy/DGGsq5RuEKd8TnCQihNmB7Iq/ms
	 TSgxCLTnZ3Khg==
Date: Sun, 24 Nov 2024 16:40:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 02/16] spi: offload: add support for hardware
 triggers
Message-ID: <20241124164009.41395009@jic23-huawei>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-2-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
	<20241115-dlech-mainline-spi-engine-offload-2-v5-2-bea815bd5ea5@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 14:18:41 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Extend SPI offloading to support hardware triggers.
> 
> This allows an arbitrary hardware trigger to be used to start a SPI
> transfer that was previously set up with spi_optimize_message().
> 
> A new struct spi_offload_trigger is introduced that can be used to
> configure any type of trigger. It has a type discriminator and a union
> to allow it to be extended in the future. Two trigger types are defined
> to start with. One is a trigger that indicates that the SPI peripheral
> is ready to read or write data. The other is a periodic trigger to
> repeat a SPI message at a fixed rate.
> 
> There is also a spi_offload_hw_trigger_validate() function that works
> similar to clk_round_rate(). It basically asks the question of if we
> enabled the hardware trigger what would the actual parameters be. This
> can be used to test if the requested trigger type is actually supported
> by the hardware and for periodic triggers, it can be used to find the
> actual rate that the hardware is capable of.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

