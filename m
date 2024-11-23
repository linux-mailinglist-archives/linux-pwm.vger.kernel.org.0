Return-Path: <linux-pwm+bounces-4125-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE79D69DB
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 17:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2632C161721
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Nov 2024 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1164376E0;
	Sat, 23 Nov 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuBKwiNM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B54A0A;
	Sat, 23 Nov 2024 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377861; cv=none; b=WS2GOzR4lhiFm9F0zAxK35iHWStugJ38ZQJKSgAbW2VlCkx6UQOIPQ8Pn5z9eijCmT5SCtZGnBeDtNXxG5s1OJWVr3A4hj1THJ9esv9QlkNoB10TwKxmoR5qYovbcp8FpBsigy2+SnkgUhyWW1cFU7eMtcnv1Z5TDO5v6uKTPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377861; c=relaxed/simple;
	bh=jaomfDdcZ0nhVLaVQkVwKJTgLatvthJtUcLzsBIQOaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7KamzChPIUfmXRuuHuJpH0IpE5sOSFUnIzWQZHLyLIlY5ZsNaag182KL4jnAezGmyIZ/vTBIT4Yj0own0XDfNPqP1hy1ykm9DtJCStZFuc7reGmpdHgQUHTTgwGA3jb3gHAzgqoZDRasGZ/n41FW0kgAbqLQNRpDbjHDR+Lm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuBKwiNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FDAC4CECD;
	Sat, 23 Nov 2024 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732377861;
	bh=jaomfDdcZ0nhVLaVQkVwKJTgLatvthJtUcLzsBIQOaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cuBKwiNMfbsl6c9NVDvlURPcAZBk7XABDuty7OhZdSTNrt3F/6QD4oa13m3JZRs8Q
	 mMoTEiQ62joH40WxTloIKmBN5C4Zk8lg5hK/OmNDknp+QHw56udyvz6qeg7vKfv/XO
	 LlR2cM50rNFEe/AF1bqeFOdl0oTHC2de5RZaOO19j8G+0449VwnarKRvXf5pSPjqi8
	 0AxUtZCbMyf06DaZZie7fA1yk/WgKJAoI+UhudeU005o6/O01fE3FGrmC2mfJPgOFG
	 Q2tVEsREtBc4DYI93ahZSp3TW0XXOXnj+hnLCdIby92+5RJUaFtrkLv2Znc3cxI6Tu
	 VKCnUo/hu4kbQ==
Date: Sat, 23 Nov 2024 16:04:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v6 6/8] iio: adc: adi-axi-adc: add oversampling
Message-ID: <20241123160414.5238fa45@jic23-huawei>
In-Reply-To: <20241111121203.3699-7-antoniu.miclaus@analog.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
	<20241111121203.3699-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 14:12:01 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for enabling/disabling oversampling.
As earlier, this is usually an oversample by N, not just a boolean.
If it is boolean for this device, then I assume there is a fixed
ratio.  Make the interface controlling between 1 and whatever that
ratio is.

Jonathan

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v6:
>  - add support for oversampling enable/disable.
>  drivers/iio/adc/adi-axi-adc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 9bf967d5b730..8ec668f59c88 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -46,6 +46,7 @@
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
>  #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   AD485X_CNTRL_3_CUSTOM_CTRL_OS_EN_MSK	BIT(2)
>  #define   AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK	GENMASK(1, 0)
>  #define   AD485X_PACKET_FORMAT_20BIT		0x0
>  #define   AD485X_PACKET_FORMAT_24BIT		0x1
> @@ -341,6 +342,14 @@ static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
>  				  AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK, val);
>  }
>  
> +static int axi_adc_oversampling_en(struct iio_backend *back, bool en)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				  AD485X_CNTRL_3_CUSTOM_CTRL_OS_EN_MSK, en);
> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -390,6 +399,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
>  	.data_size_set = axi_adc_data_size_set,
> +	.oversampling_en = axi_adc_oversampling_en,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


