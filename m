Return-Path: <linux-pwm+bounces-6349-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B94AD9C23
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FF57AAD87
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 10:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A6F1E1A33;
	Sat, 14 Jun 2025 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xt+mCH+h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C757B175A5;
	Sat, 14 Jun 2025 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749897385; cv=none; b=Il118XBUfOU67Bk3wqUB7qgk44R1lrsdHbYC9Z1I9BDuaFn7Lb9UZpLMhZP7ru1+BxQKsWdSJ3LL2449uhXztpnLN0DRjjYaiJE6xzre+ek8/cxRtzheT6M6zws8R9O28DH6wbUjo+CC6/+YOGDRJ+aEP7n/3lRUwlqzwaTUUuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749897385; c=relaxed/simple;
	bh=as6jP1DxC+RFLBHeiO5K9WM7RCKivV22V+29vSgyenA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AqZyUkUECIySbq7QHggjUAxxNzE+lGR2JWMmLwOiRk6/z4BNjVzGNhTFleLT75OCVwiWdrcp0eNPgLfFk90Os6ndcnS9TecXTBBkaB0ACdTUwhy47EgrlJ56jQy0XTN+FcFkjgjFA2bBdKaTB9fkXWqzyr0qsuGC3qg7U+T9+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xt+mCH+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AA3C4CEEB;
	Sat, 14 Jun 2025 10:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749897385;
	bh=as6jP1DxC+RFLBHeiO5K9WM7RCKivV22V+29vSgyenA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xt+mCH+haSeQ4kUW2plHlus8Xzir9ynuAnKPyUJqmQa7b4YpLa1Yeh1RPJX8qnjO0
	 +2Jd8cJVFf/bFhvjHmgFdQtyWNj+z8BkKQ7K690rMFer7BA4VvrrQol73HrP0Aad7V
	 d8728DhRcb958HVLkROag4TGXaqIEaaIbaLizlfsgSnS99xClSPMKqSq7+HGeCfkTB
	 vwZCjFOCBeFG/IMJAQvlLqBoSFZGX8yhbuhXk/Cb5Fo6Mu0MiIPzvLSf0skp+/iCXn
	 pDYjkJzTkjSh9Db/mjPROb9E4CUhF6FYN9tr+crM+PrJyeyT697mQF2qouxHapy13s
	 upLB0MIad5K+Q==
Date: Sat, 14 Jun 2025 11:36:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v3 8/8] iio: adc: Add events support to ad4052
Message-ID: <20250614113616.4663269f@jic23-huawei>
In-Reply-To: <20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
	<20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 09:34:41 +0200
Jorge Marques <jorge.marques@analog.com> wrote:

> The AD4052 family supports autonomous monitoring readings for threshold
> crossings. Add support for catching the GPIO interrupt and expose as an IIO
> event. The device allows to set either, rising and falling directions. Only
> either threshold crossing is implemented.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jorge,

A few comments inline.

Jonathan

>
> +
> +static int ad4052_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +	if (st->wait_event == state) {
> +		ret = 0;

Feels like a case where init ret at declaration would be reasonable.

> +		goto out_release;
> +	}
> +
> +	if (state)
> +		ret = ad4052_monitor_mode_enable(st);
> +	else
> +		ret = ad4052_monitor_mode_disable(st);
> +
> +	if (!ret)
> +		st->wait_event = state;
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}

> +
> +static int ad4052_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   int *val2)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (st->wait_event) {
> +		ret = -EBUSY;
> +		goto out_release;

Not being able to read event parameters whilst monitoring them seems
very restrictive.  Can't we cache the values?  Either play games to ensure
we get them from the regmap cache or just cache these few values in st.

Checking what you are monitoring for feels like the sort of thing
userspace might well do.

Even blocking changing the monitoring parameters is unusually strict.
Why not just drop out of monitor mode, update them and go back in?


> +	}
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		ret = __ad4052_read_event_info_value(st, dir, val);
> +		break;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		ret = __ad4052_read_event_info_hysteresis(st, dir, val);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret ? ret : IIO_VAL_INT;
> +}

