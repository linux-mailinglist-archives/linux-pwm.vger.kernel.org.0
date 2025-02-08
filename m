Return-Path: <linux-pwm+bounces-4832-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDEFA2D757
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Feb 2025 17:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0559F3A4ADC
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Feb 2025 16:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266EE1F17F0;
	Sat,  8 Feb 2025 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiS8qgjX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53822E000;
	Sat,  8 Feb 2025 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739032124; cv=none; b=JYkIKgiNacc0qNYD6BfulYre0YvBxmG53jd1OI3PyQH3aTRAGHnOad/X+y5zejRTdndL/m2wTC9yLnWH+v0CSHk6P/LZQaYIRTxj1cD9PPcytDkygu4OyjoCGc8DPfNAVZ5OTdf4BzgOITwAzb0MOUnUtT5kVkRK+PPa/YEn4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739032124; c=relaxed/simple;
	bh=tykPa8GoQ49MGU6co4vs2qfusgwWAwyvX7jJVsAdVTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sek8IwJ4kCSvCBpMy63lhgCmQXBxc6/OaLU3smenpVXLTqzzVXgMJE9WvlE5qSawJRGCuP2aKjYkeF2ef00AiJwQ1sYrGZ1Kp/lLWh4mA2quxapJ718DJyKcgn4T2Bo790WzXDYM1a82s8TIz2SZzgZzteeIxJJLBZioDu4Nz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiS8qgjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2870C4CEDF;
	Sat,  8 Feb 2025 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739032123;
	bh=tykPa8GoQ49MGU6co4vs2qfusgwWAwyvX7jJVsAdVTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FiS8qgjXj15kRgAyBkMs+BXniTa5x0d4n3//nGByc0IEgcIc+QCnQVJk/XI+I0ehh
	 0ZVNFc6XkX6WRWzKV05qifwvD8h9SolpR3LmZhkIVA96zB6brClqGyt3qOwspV+KX0
	 52QWQHicmrXwA9kn/MK07pyBE5sgg8p6g2h/9bQ1yrd1NxKdXVL9+pYACx6rh4EwEL
	 ednqHThw19dTEocaqLn2YdCw1R0yuNqAF8AHHZo/vz7CeInuRKGWXec9SGgPHkg1F+
	 ffxav9VYBXThDRJk6a+/eqhIePcCaWzmnzTAxEhdIO5ctsxrEuclKyD0/8hfNh5Lwo
	 ECXeZL3AjVoVQ==
Date: Sat, 8 Feb 2025 16:28:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v12 9/9] iio: adc: ad4851: add ad485x driver
Message-ID: <20250208162835.719e0638@jic23-huawei>
In-Reply-To: <20250207140918.7814-10-antoniu.miclaus@analog.com>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
	<20250207140918.7814-10-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Feb 2025 16:09:18 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD485X a fully buffered, 8-channel simultaneous
> sampling, 16/20-bit, 1 MSPS data acquisition system (DAS) with
> differential, wide common-mode range inputs.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

One really trivial comment to add from me.

Jonathan

> diff --git a/drivers/iio/adc/ad4851.c b/drivers/iio/adc/ad4851.c
> new file mode 100644
> index 000000000000..01cc88ecad52
> --- /dev/null
> +++ b/drivers/iio/adc/ad4851.c
> @@ -0,0 +1,1316 @@


> +
> +static int ad4858_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4851_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *ad4851_channels;
> +	const struct iio_chan_spec ad4851_chan = AD4858_IIO_CHANNEL;
> +	int ret;
> +
> +	ret = ad4851_parse_channels_common(indio_dev, &ad4851_channels,
> +					   ad4851_chan);
> +	if (ret < 0)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ad4851_channels->has_ext_scan_type = 1;
> +		if (fwnode_property_read_bool(child, "bipolar")) {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_b;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_b);
> +

Trivial but this blank line doesn't add anything useful and looks a bit odd!

> +		} else {
> +			ad4851_channels->ext_scan_type = ad4851_scan_type_20_u;
> +			ad4851_channels->num_ext_scan_type = ARRAY_SIZE(ad4851_scan_type_20_u);
> +		}
> +		ad4851_channels++;
> +	}
> +
> +	indio_dev->channels = ad4851_channels;
> +	indio_dev->num_channels = ret;
> +
> +	return 0;
> +}


