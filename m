Return-Path: <linux-pwm+bounces-4835-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0861A2F283
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CBF1887B4A
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2025 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF44247DF8;
	Mon, 10 Feb 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnA+7RNv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841E247DC9;
	Mon, 10 Feb 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203621; cv=none; b=N7z6ZgYRXXPARy24MZ1Tbx9z8bfo74kjeHen1HkKkvekXFSSxMI2IEI4KQTOM1g5NZmlmhCw59g9kJxnEz+Mszf/h7Jrqh+SdyPnZ0xjLZOQ7pB/FNHe3kCulQROTR3SVVLnEVV+i4CjdQ7680HFCe8sFkikeRmFNBdRObyPxTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203621; c=relaxed/simple;
	bh=kMzVySL+KsPyifhKYjl79ydoeIFGhKb0gqHpGEZiRg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V8MoIp22c34LsactqYwTfiCzntG3S/fh1ac9sDHb7OYXVibfRnnbJBt/i8Cxn7sWp7TgI5mRMAk762WQtM7k5ZRL8dKXoR5NkB0tFt85Db0dt6nO47FLiOWzOulrYLuTWOlQYBJDKEtmGN14kzLtKJpobOMOo9whd1SYnPcXGRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnA+7RNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69884C4CEE5;
	Mon, 10 Feb 2025 16:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203620;
	bh=kMzVySL+KsPyifhKYjl79ydoeIFGhKb0gqHpGEZiRg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UnA+7RNv2SqFH+w5fTdNOqktNxbt8gG1JajPB2UBwblQCu2pxM5/Ad6XD+38AkU5M
	 gWX0tZv0mNlDEJUL6+JzAj2COee89n6d3aQrVlyYPlhk2KOVZHnlm0e7OHFbF/f20h
	 XdLsscxK6r6IVMWL5AOhOIPOeb5701gCaDwzyGbrR0DhFoVpNrGW2gCXRGTum15hZh
	 /vhrOTKP6YB2Cr1cjizu5TZyNeJ2ah3enHO/3J8qvJCnd90PwqjhoH7IMEwDhRVv0b
	 GPAlYW5Du17PDvLjOMpCtJQcdn56OYffkcmO1ysWBfXZ3wN8llr12IuDA7BxpMyba5
	 Oy761P9ZUWi2A==
From: Mark Brown <broonie@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Axel Haslam <ahaslam@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
Subject: Re: (subset) [PATCH v7 00/17] spi: axi-spi-engine: add offload
 support
Message-Id: <173920361716.57731.16678374643709028298.b4-ty@kernel.org>
Date: Mon, 10 Feb 2025 16:06:57 +0000
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 13 Jan 2025 15:00:05 -0600, David Lechner wrote:
> We've got Reviewed-by's from all of the relevant maintainers now other
> than SPI, so up to you Mark to say what you want to do with this.
> 
> If we think this is good enough to go in, the SPI patches should be
> applying fine since this is based on a recent linux-next. But the IIO
> patches will need some care. There are dependencies on both the
> iio/fixes-togreg and the iio/testing branches as well as a couple of
> patches that haven't been applied yet because they are waiting for other
> dependencies [1]. Given the timing in the merge cycle, if Mark picks up
> the SPI patches and they make it into 3.14, then Jonathan can pick up
> the IIO patches after the 3.14 merge window closes. Or we can wait until
> then for everything to go in at once.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/17] spi: add basic support for SPI offloading
        commit: 8e02d188698851436f76038ea998b726193d1b10
[02/17] spi: offload: add support for hardware triggers
        commit: d7231be4b4657e5f922a4c6dc11e8dffc71fee87
[03/17] dt-bindings: trigger-source: add generic PWM trigger source
        commit: 83f37ba7b76ab17e029ab4127ec64ccccce64c00
[04/17] spi: offload-trigger: add PWM trigger driver
        commit: ebb398ae1e052c4245b7bcea679fe073111db2ce
[05/17] spi: add offload TX/RX streaming APIs
        commit: 700a281905f2a4ccf6f3b2d3cd6985e034b4b021
[06/17] spi: dt-bindings: axi-spi-engine: add SPI offload properties
        commit: e1101373df5cd7672d988bb4e9cdd5eb97003165
[07/17] spi: axi-spi-engine: implement offload support
        commit: 5a19e1985d014fab9892348f6175a19143cec810

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


