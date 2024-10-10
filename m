Return-Path: <linux-pwm+bounces-3589-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7EA998F3E
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 20:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479931F25ECE
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Oct 2024 18:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F40419D89E;
	Thu, 10 Oct 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6E+4EKk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE67188A08;
	Thu, 10 Oct 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583456; cv=none; b=tq+ctl9rUdzNB0J1apXMVUDc61p+OiqpmcVmLKHbGbCZJ8vyS+S+lOu97sZLrFp67MpjTv3+jdPyFyVI+ZJbhXZ6fv9c5WyfQmj+azg/DimrTZuf/RV1UGzao0y+zBj/kDfEoiSU7CSUQk9Aq3XKw6D/Wf/toKdTU/WG1C1SGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583456; c=relaxed/simple;
	bh=bXzsja91oxEK7A4oh7gQhxbPTPspC3mQheHfMkv4M1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rI+5axm9lr+pp0y64+CJ5xgxc1ST/sKGxHHxKc1gblocSR5Ta44t461yd4X+qvCQaXog+EZLO+sB/PSmXy7gbgkLTFENyL6Dgk/bVRqud8NcxEk5ED3B2VEhJzaJFd72VvOmsQr41QGdF4wK/00yGTlCcdsGcEZngLyUNpXJV5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6E+4EKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D5C4CEC5;
	Thu, 10 Oct 2024 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728583455;
	bh=bXzsja91oxEK7A4oh7gQhxbPTPspC3mQheHfMkv4M1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6E+4EKkTEMnER0y7X54Q3GxgUBkzewVbE3MXRvQtspaT4h78hayMtoHIGHBci/LL
	 4KEoRBTA+l0HbHxU41XeTv8irhEHDzDelj4tLjNW5maFYy4WG+bBG114rOW1iOsYvH
	 7NprZ/c5JHnuq7bu6wh3VHxdCSSQHJouefMj2VGlGZhxkUPtv4JTbdae82UmHndgTX
	 3n3cL+NDYGzce4oti1RYMtA902XEQf6hX+QBEjNy8bfOkJnKBA82lRTA6Jx5KDIJzE
	 fU09cG9jEYkBr28dHdwo6H6/nrZ3HY5Tb326w6lm1jB06NsihJLFnhJSS5ZK3a53BC
	 WaBcVY5O2poTA==
Date: Thu, 10 Oct 2024 19:04:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guillaume Stols <gstols@baylibre.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 aardelean@baylibre.com, dlechner@baylibre.com, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 09/10] iio: adc: ad7606: Add iio-backend support
Message-ID: <20241010190400.34905ab2@jic23-huawei>
In-Reply-To: <ac765343-7804-4bd5-8057-d67fec2f17b1@baylibre.com>
References: <20241004-ad7606_add_iio_backend_support-v3-0-38757012ce82@baylibre.com>
	<20241004-ad7606_add_iio_backend_support-v3-9-38757012ce82@baylibre.com>
	<20241005125318.0c4a7bc8@jic23-huawei>
	<ac765343-7804-4bd5-8057-d67fec2f17b1@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> >> index 3666a58f8a6f..d86eb7c3e4f7 100644
> >> --- a/drivers/iio/adc/ad7606.c
> >> +++ b/drivers/iio/adc/ad7606.c
> >> @@ -21,6 +21,7 @@
> >> @@ -737,6 +773,10 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
> >>   			return ret;
> >>   
> >>   		return 0;
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		if (val < 0 && val2 != 0)
> >> +			return -EINVAL;
> >> +		return ad7606_set_sampling_freq(st, val);  
> > Currently I think  for the !backend + pwm case this can go out of
> > range for which that code works (fsleep removed in next patch).
> > Perhaps delay adding this until after that patch.  
> 
> Hi Jonathan,
> 
> The sampling frequency can be adjusted only for the backend version, 
> otherwise (including pwm+interrupt), there is no sysfs access to the 
> sampling frequency (only available for AD7606_BI_CHANNEL).
Ah! That makes sense.
Thanks,

J

