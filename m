Return-Path: <linux-pwm+bounces-3917-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4660D9B19A2
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 17:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7531B20AF8
	for <lists+linux-pwm@lfdr.de>; Sat, 26 Oct 2024 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EB670826;
	Sat, 26 Oct 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXjyxJ43"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC0182D2;
	Sat, 26 Oct 2024 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957962; cv=none; b=jvUo5enVOtNXxoGvg52BUcTDw+7fUv2Qb84fVNnS2ps42zRLV1FYsdUH+UMSVRcdIbVbYQukfwnJW13kxWelJrRuX6Ouu2/SbQi89B7eeLQaAk0kAPAbU3AdFGFaAKM28jDgKVH45VPbOaiR5m38NAHqdcDta9wteYDt1DQ6L/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957962; c=relaxed/simple;
	bh=cZvox5WjmizWX1HEoNMg3Cm/BRzzorvtef0st/yaqrs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh6hbf8UPPvf0vntLU3WYIBOMgHPrqyD4Omwasmx4dNQ/cdFvKN8MHwT+fDNNyx8IuOOxvLCjAKlPG5OkciGDRaL1hnRgFaMudSvPrfiXNCwOj/1WOBINkN94f+TpyoUKlsuicmNHsLCbCsCSbghSTcEL9crH/IVFLPTk+uzKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXjyxJ43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95170C4CEC6;
	Sat, 26 Oct 2024 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729957961;
	bh=cZvox5WjmizWX1HEoNMg3Cm/BRzzorvtef0st/yaqrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cXjyxJ43NpgC5TdcxIKBCBaptgTqIy3j3jr0SMuUl+0ZBkKm5Sy9rR3XED6OkX1kz
	 n4uFtdY3nELEN6XhXjWxC3quQtUuDA0hT6UnhlgSJY0nfYcTIUTkYa401AFsxXfiPO
	 uNkl6Mm7OwRnsqmOIOGpHHQalWBVNHNcba5t5QMmGWjHOpNOmJpW5Y5rUNZlnnBs2k
	 FcUVkYia5V2+DA3GUC9g3/nM2pEcFvdLbT/DTIY15yiO8DK/Nfz00ToHmE6YbAyCXe
	 5ufWkU8wupUeQ8mSzQNKvDsNneGa79rHYWlj7ONjAvXRrR8SP1dJW3E2xvGLlFpsGo
	 o98Uw+iXbof9A==
Date: Sat, 26 Oct 2024 16:51:47 +0100
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
Subject: Re: [PATCH RFC v4 13/15] iio: adc: ad7944: add support for SPI
 offload
Message-ID: <20241026165147.2d67d160@jic23-huawei>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-13-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-13-f8125b99f5a1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Oct 2024 15:59:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for SPI offload to the ad7944 driver. This allows
> reading data at the max sample rate of 2.5 MSPS.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>
>  static int ad7944_probe(struct spi_device *spi)
>  {
>  	const struct ad7944_chip_info *chip_info;
> @@ -590,20 +743,75 @@ static int ad7944_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &ad7944_iio_info;
>  
> -	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
> -		indio_dev->available_scan_masks = chain_scan_masks;
> -		indio_dev->channels = chain_chan;
> -		indio_dev->num_channels = n_chain_dev + 1;
> +	adc->offload = devm_spi_offload_get(dev, spi, &ad7944_offload_config);
> +	ret = PTR_ERR_OR_ZERO(adc->offload);
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");
> +
> +	if (ret == -ENODEV) {
> +		dev_info(dev, "SPI offload not available\n");
Too noisy given this applies whenever this device is connected to a normal
SPI bus.  Or an old DT is used.

> +
>
> 


