Return-Path: <linux-pwm+bounces-4831-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D6A2D744
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Feb 2025 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1550A1888719
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Feb 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4841F30AA;
	Sat,  8 Feb 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiXVaSFT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F81F30A0;
	Sat,  8 Feb 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739031788; cv=none; b=b/sGxWWBnlZXjsAwcN46eczkUmzUnCQEBZ1NFjA4umaw4jd/H51/J2wPJZxfi9Nz5KeotFRM4DOakPIS1rhLQIcymRNfBUSqE3eiHIxtKcmSNLf7g0qZfG9d7Sqt2gyy+Ji2nMLcnAawOf3PnrdozDY5gJZ5MObjI99iz5d/Auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739031788; c=relaxed/simple;
	bh=Ekrz3bFy6IXUZ9DvsoaOzw9ElB1mg+eDRl5ttyj4wvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VF6KDtXDeXqqxPDOgjSosGlDHeXtdB7jXPntU7NBdXrjqGtjuQ6y4E+3QHO4VIVUUls9NWkwInt/kA1IC19G0x8c2Rt3aOtkHAY6u6AckQenVMccwZXS1Y+zpQ7HMHyVcWh1OKAd9U+Z+Bl2DrO1reJgeKSKOs0x4sUb7Igokmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiXVaSFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E36EC4CED6;
	Sat,  8 Feb 2025 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739031788;
	bh=Ekrz3bFy6IXUZ9DvsoaOzw9ElB1mg+eDRl5ttyj4wvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tiXVaSFTHCd2BnGBU6J1JW3BUWB/nZzL8J14ihe+0e8b4DmYj+q6zsClqRrejU/76
	 ZgZv201/vtwztsb/vT/2SJUSkmzPNygOMZxH3NanW9TyDsS+inukDMbK9iu7ZwhFhi
	 2qTIalO1FO0k8PtS0p/vg5Mfh8dGl6fCbPQKCIfkqY1/qeMLOmacfCeMAn3CBiPw0C
	 /RjO67Y3E9RtwVKt4xfviV2x3a7Ot3zcygS+nftfOkO72CMyupenLYXgXlFJkAzQ96
	 KAMMsqURuVsBPjle7acLshajVssjjYceo4cIRDG3i4+6kB/efmxSLxJrPSj1LUvqoF
	 6vtkdClshGEaA==
Date: Sat, 8 Feb 2025 16:23:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v12 7/9] iio: adc: adi-axi-adc: add oversampling
Message-ID: <20250208162300.1e083279@jic23-huawei>
In-Reply-To: <20250207140918.7814-8-antoniu.miclaus@analog.com>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
	<20250207140918.7814-8-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 16:09:16 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for enabling/disabling oversampling.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v12.
>  drivers/iio/adc/adi-axi-adc.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
> index 272d82c6e887..872ff51e08a7 100644
> --- a/drivers/iio/adc/adi-axi-adc.c
> +++ b/drivers/iio/adc/adi-axi-adc.c
> @@ -46,6 +46,7 @@
>  #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
>  
>  #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
> +#define   AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
>  #define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
>  #define   AD485X_PACKET_FORMAT_20BIT		0x0
>  #define   AD485X_PACKET_FORMAT_24BIT		0x1
> @@ -363,6 +364,28 @@ static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
>  				  FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
>  }
>  
> +static int axi_adc_oversampling_ratio_set(struct iio_backend *back,

Same thing David pointed out in previous patch applies here.
axi_adc_ad4851_oversampling_ration_set() or something like that.


> +					  unsigned int ratio)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +
> +	/* The current state of the function enables or disables the
> +	 * oversampling in REG_CNTRL_3 register. A ratio equal to 1 implies no
> +	 * oversampling, while a value greater than 1 implies oversampling being
> +	 * enabled.
> +	 */
> +	switch (ratio) {
> +	case 0:
> +		return -EINVAL;
> +	case 1:
> +		return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +					 AD485X_CNTRL_3_OS_EN_MSK);
> +	default:
> +		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
> +				       AD485X_CNTRL_3_OS_EN_MSK);
> +	}
> +}
> +
>  static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
>  						 struct iio_dev *indio_dev)
>  {
> @@ -428,6 +451,7 @@ static const struct iio_backend_ops adi_ad485x_ops = {
>  	.chan_status = axi_adc_chan_status,
>  	.interface_type_get = axi_adc_interface_type_get,
>  	.data_size_set = axi_adc_data_size_set,
> +	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
>  	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
>  	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
>  };


