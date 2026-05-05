Return-Path: <linux-pwm+bounces-8779-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIIDF+Pv+WmcFQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8779-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 15:25:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7BB4CE6FB
	for <lists+linux-pwm@lfdr.de>; Tue, 05 May 2026 15:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56226304E659
	for <lists+linux-pwm@lfdr.de>; Tue,  5 May 2026 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DFE3E4C71;
	Tue,  5 May 2026 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX6B/FLQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8D392C32;
	Tue,  5 May 2026 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987422; cv=none; b=SiFXf5JYv/Ss6fFNVqkNy6/JkdQ4CkpfRD0sXkhWsjvisJT0aiTVNZbIezZ9ub1jmEJuam7EFaq+ZdI6R+eA35dYsHHlPu4mtVoNgmxFnX/H0ND0gs18W8ARdCdsjSvtRPGWWWAaS94L5TP5evW6bbzqBPmMZuB6UEKZ6YsjJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987422; c=relaxed/simple;
	bh=Hgq1xuGgwGhdzj9TbVmCIlyjgoWMt078/W8y7jpz5tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qODkfM/mzmbivQW4Hh0Pej7v9WnqUZgHM/VU32NjEjaBuhZJ3o/J0WdqzD+piMJyYV+Ym+drsW+xajx/o7z+gSmk6eBjOpS/4bL5dPVW/aC/mIXSYEJhbEwAsiRMBSR9ighXJuHjYAjphNVB2hK6nVwO8B0jzUdnb4mNit0Lupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TX6B/FLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E664AC2BCB4;
	Tue,  5 May 2026 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987422;
	bh=Hgq1xuGgwGhdzj9TbVmCIlyjgoWMt078/W8y7jpz5tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TX6B/FLQk9+Pi5HsG7DtcwJF6tl8JRNDHikvpK8nECA+kVKRAzgnajCXCxD480UV/
	 F7HvMdiosf1m+pqw5t7/60+FllC8b96C02pMHJNGr0bS5nnSFQMZ/GekELNWDaS3PK
	 y6QHr+aM5J4OXRCtYmogcq+r3x90WbmSXaTnr276YDfqUzlf8nIZUGQ8vcY/0gAV0Z
	 4c53Sy789IVXIADrNgBZvRt21/HXa+OS0pSuZxdLldoKANFVgyYD9tN+hPyh/Xw09l
	 FHgJsZ1GExxvnrHYipXG9HkeiQx28BUa2xYwY0lHI1ohkCfP+GJIW5VGWDuaVmY+6B
	 0a4zfdabIbEWg==
Date: Tue, 5 May 2026 14:23:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <20260505142328.05b4b127@jic23-huawei>
In-Reply-To: <20260430-ad4692-multichannel-sar-adc-driver-v9-2-33e439e4fb87@analog.com>
References: <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-2-33e439e4fb87@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BA7BB4CE6FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8779-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[analog.com,metafoo.de,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,baylibre.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 13:16:44 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add support for the Analog Devices AD4691 family of high-speed,
> low-power multichannel SAR ADCs: AD4691 (16-ch, 500 kSPS),
> AD4692 (16-ch, 1 MSPS), AD4693 (8-ch, 500 kSPS) and
> AD4694 (8-ch, 1 MSPS).
> 
> The driver implements a custom regmap layer over raw SPI to handle the
> device's mixed 1/2/3/4-byte register widths and uses the standard IIO
> read_raw/write_raw interface for single-channel reads.
> 
> The chip idles in Autonomous Mode so that single-shot read_raw can use
> the internal oscillator without disturbing the hardware configuration.
> 
> Three voltage supply domains are managed: avdd (required), vio, and a
> reference supply on either the REF pin (ref-supply, external buffer)
> or the REFIN pin (refin-supply, uses the on-chip reference buffer;
> REFBUF_EN is set accordingly). Hardware reset is performed via
> the reset controller framework; a software reset through SPI_CONFIG_A
> is used as fallback when no hardware reset is available.
> 
> Accumulator channel masking for single-shot reads uses ACC_MASK_REG via
> an ADDR_DESCENDING SPI write, which covers both mask bytes in a single
> 16-bit transfer.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
Hi Radu

Just one query that Sashiko raised that made me look 
closer at how you are handling different register sizes.
https://sashiko.dev/#/patchset/20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87%40analog.com

There was also a question about whether the sampling frequency control would
be better described as shared by all.

> diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
> new file mode 100644
> index 000000000000..05826b762c7f
> --- /dev/null
> +++ b/drivers/iio/adc/ad4691.c


> +static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
> +{
> +	struct spi_device *spi = context;
> +	u8 tx[2], rx[4];
> +	int ret;
> +
> +	/* Set bit 15 to mark the operation as READ. */
> +	put_unaligned_be16(0x8000 | reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_SAT_OVR_REG(15):

Sashiko raised a query here.
"Will this result in a truncated 1-byte read for AD4691_ACC_MASK_REG (0x185)?
AD4691_ACC_MASK_REG falls into the range between AD4691_SPARE_CONTROL and
AD4691_ACC_SAT_OVR_REG(15). In ad4691_reg_write(), AD4691_ACC_MASK_REG is
handled explicitly alongside AD4691_STD_SEQ_CONFIG to perform a 16-bit
write, but it seems missing from the 2-byte read block here."

Just to check - the reasoning behind not just treating these as
fixed sized registers and using bulk reads and writes is the statement
about them being invalid if partially written?

The ACK_MASK_REG is documented as two separate 8 bit registers so why
attempt to treat it as a larger one?


> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 1);
> +		if (ret)
> +			return ret;
> +		*val = rx[0];
> +		return 0;
> +	case AD4691_STD_SEQ_CONFIG:
> +	case AD4691_AVG_IN(0) ... AD4691_AVG_IN(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 2);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be16(rx);
> +		return 0;
> +	case AD4691_AVG_STS_IN(0) ... AD4691_AVG_STS_IN(15):
> +	case AD4691_ACC_IN(0) ... AD4691_ACC_IN(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 3);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be24(rx);
> +		return 0;
> +	case AD4691_ACC_STS_DATA(0) ... AD4691_ACC_STS_DATA(15):
> +		ret = spi_write_then_read(spi, tx, sizeof(tx), rx, 4);
> +		if (ret)
> +			return ret;
> +		*val = get_unaligned_be32(rx);
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4691_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct spi_device *spi = context;
> +	u8 tx[4];
> +
> +	put_unaligned_be16(reg, tx);
> +
> +	switch (reg) {
> +	case 0 ... AD4691_OSC_FREQ_REG:
> +	case AD4691_SPARE_CONTROL ... AD4691_ACC_MASK_REG - 1:
> +	case AD4691_ACC_MASK_REG + 1 ... AD4691_GPIO_MODE2_REG:
> +		if (val > U8_MAX)
> +			return -EINVAL;
> +		tx[2] = val;
> +		return spi_write_then_read(spi, tx, 3, NULL, 0);
> +	case AD4691_ACC_MASK_REG:
> +	case AD4691_STD_SEQ_CONFIG:
> +		if (val > U16_MAX)
> +			return -EINVAL;
> +		put_unaligned_be16(val, &tx[2]);
> +		return spi_write_then_read(spi, tx, 4, NULL, 0);
> +	default:
> +		return -EINVAL;
> +	}
> +}


