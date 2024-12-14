Return-Path: <linux-pwm+bounces-4345-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB19F1EA3
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 13:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E92188A0C3
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Dec 2024 12:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870E7192B99;
	Sat, 14 Dec 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGGGARwg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C87192B73;
	Sat, 14 Dec 2024 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734180509; cv=none; b=lsAWT3co2iBb1lfGG08OGbb1o0M1Wve6icw86gzn0/7QVVqx4UjydWOp6XU4HT/nilKptOSt6w/d/86XTjfyc5RLtdmnRV8l0FfqS6HokP15RXJUApstjxCVEz6QMfi8n0hw9Q6eppMLHy8+XxJ+mhNg9YRWF/jFMsId7FJVQHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734180509; c=relaxed/simple;
	bh=8ODiZCIJ6gT18sXotgRT0GidCK/0G5fiwXWNMZ1ecrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9GOvKd7mT3yQaNZGIVi3HSLGqdhndh9i//i3iWmiqaAHwb5/fefK/jNdXSZMC0MMbN+H43y+CIrfe98SyHCu+q4FgIJWgHxhsNyt7tglR+3kSsb19vS/bb4V102qtJ3Si+KKCY6vZa9pLDkz3EvHlp3eVc8DKwscmLTH1eSY58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGGGARwg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D01C4CED1;
	Sat, 14 Dec 2024 12:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734180508;
	bh=8ODiZCIJ6gT18sXotgRT0GidCK/0G5fiwXWNMZ1ecrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eGGGARwg6Z+oWOFyxKokJU2uk/0g2preB2Mt8Lvz+eh1/lPx331luR+YvltB4D3i0
	 n8ST5/8P1pXLWOHuInGG/3OG2a9EtPUfO57jb/A8jxq3S/bKnq2QG51WW9xuwfe1+L
	 qZj3Akku01TjzZ6XQeOFtQ2Bwa++hkgyaBPnkPMUBtoJUBTumguolNBdtrJyP/r4at
	 CQlS62i5RIFSbdVNBoLHDF9RrfrcfxP/AcvXQ9yuo2qWgWQ+a3r07yiVt+hxPrLZTW
	 GDcef8+nFeKCAoD/U4gUvKX9qTAzT9l6P8tVbjJO3xH0wv45ZVTlpMSxLWB6eoebMk
	 ipscfXK6VAaKA==
Date: Sat, 14 Dec 2024 12:48:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v8 5/8] iio: adc: adi-axi-adc: set data format
Message-ID: <20241214124820.20b0ae60@jic23-huawei>
In-Reply-To: <20241213164445.23195-5-antoniu.miclaus@analog.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
	<20241213164445.23195-5-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 18:44:42 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for selecting the data format within the AXI ADC ip.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
One trivial comment inline.  If the discussion around David's
question resolves and this is all that is left, I can either tweak
this or we can just decide the long name is fine.

Jonathan

> ---
> changes in v8:
>  - provide inline comments explaning the packet formats as requested in
>    previous review.
>  drivers/iio/adc/adi-axi-adc.c | 46 +++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index f6475bc93796..9a3968769512 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -45,6 +45,12 @@
>  #define ADI_AXI_ADC_REG_CTRL			0x0044
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
> +#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK	GENMASK(1, 0)
I guess this rather long name is straight out of the datasheet / RTL but
maybe..

#define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
Is enough?

> +#define   AD485X_PACKET_FORMAT_20BIT		0x0
> +#define   AD485X_PACKET_FORMAT_24BIT		0x1
> +#define   AD485X_PACKET_FORMAT_32BIT		0x2
> +
>  #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
>  #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
>  
> @@ -312,6 +318,45 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
>  	return 0;
>  }
>  
> +static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	unsigned int val;
> +
> +	switch (size) {
> +	/*
> +	 * There are two different variants of the AXI AD485X IP block, a 16-bit
> +	 * and a 20-bit variant.
> +	 * The 0x0 value (AD485X_PACKET_FORMAT_20BIT) is corresponding also to
> +	 * the 16-bit variant of the IP block.
> +	 */
> +	case 16:
> +	case 20:
> +		val = AD485X_PACKET_FORMAT_20BIT;
> +		break;
> +	case 24:
> +		val = AD485X_PACKET_FORMAT_24BIT;
> +		break;
> +	/*
> +	 * The 0x2 (AD485X_PACKET_FORMAT_32BIT) corresponds only to the 20-bit
> +	 * variant of the IP block. Setting this value properly is ensured by
> +	 * the upper layers of the drivers calling the axi-adc functions.
> +	 * Also, for 16-bit IP block, the 0x2 (AD485X_PACKET_FORMAT_32BIT)
> +	 * value is handled as maximum size available which is 24-bit for this
> +	 * configuration.
> +	 */
> +	case 32:
> +		val = AD485X_PACKET_FORMAT_32BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				  AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK,
> +				  FIELD_PREP(AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK, val));
Yikes.  See suggests for names above.  I think we need to shorted that define
at least a little to improve readability.

> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -360,6 +405,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
>  	.test_pattern_set = axi_adc_test_pattern_set,
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
> +	.data_size_set = axi_adc_data_size_set,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


