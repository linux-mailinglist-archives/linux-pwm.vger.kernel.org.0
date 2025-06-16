Return-Path: <linux-pwm+bounces-6380-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D7ADB2A6
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 15:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7801885D77
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 13:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7932877D6;
	Mon, 16 Jun 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb0u3a0g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A7285C96;
	Mon, 16 Jun 2025 13:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082104; cv=none; b=hHkbTnAjNhEaBDgZkS+1Pa7XzF0nML7zaDi4ej3hEFHnoMAdjLmC4CHvUql1AMyfJH91Hk5sKqYSB7dAXPhui1GP+bjlCYKLXv/kg3KJnNGfUodbWaN0CnM4fnuJwZar+1Lr0PSbXz/UYAJq3jFa5//ruuyW6h6VTdB7R8iYg4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082104; c=relaxed/simple;
	bh=kDrFiJZeByCxQ9YK3OGGhguZw0QHkU2Ev1SlVF6XmxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiPIepFyQsXw+v2VcO9tZHTJjD3PEFA9y3hurKUnwdHtv6GFbHrr5bYP6lqLZlwGlcO09NxXlsNQREPF/lJLJTWUp2BDpuCBHhlslu3INGESbodlkApOxZOuagP11Mji+be9c1UIHW5zuAR03CCKAXYYzVXj8lxudo7c8Xe3A0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb0u3a0g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so39300515e9.1;
        Mon, 16 Jun 2025 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750082101; x=1750686901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WuF0uH/IFJVKhc9AHQruIp9YqexDw2XvYvqThHWKXxs=;
        b=gb0u3a0gXMlCSMfjKTYmAKAI86tnaxedJMxXU/FUk66ip//dne8+ibMScLPJs+Gikz
         XjDIl4yiWH/5ETU+6k2iPyoxtBTGydDzVCXC883D/Go4TCg34+Whyng1BYbiNaJk+zVY
         lmKW1SE9XSJ934g1Hm1YdVo6w0Uhsigh1MIoyOH/NbW/ck5LFbzcLtgEInrTO9dFCCZW
         uT+fH5N8yRHv7BCOvzRhL94XiJPpZRTaGaxHemmQ8jkZuo+5n8UYuZZOP/eVQok6N3z8
         zd3f2TX8+akvDikcBcAwm4tl64/r3e3XagUZr3m7GHBYswMy9dkXZ8DjzFHAuvyCLNgX
         D2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082101; x=1750686901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuF0uH/IFJVKhc9AHQruIp9YqexDw2XvYvqThHWKXxs=;
        b=HjMuFdef2KgRK/YfNkrrdKdfMHzNEVasv+QNQzwXVoNVmTp3PVHdV9hyu3Wzt37n0l
         an+D7OVbHmPh5vKuvw7szR+KSGrGp91mX69CuDWNrBwA3xy6S6MVABx+qjhge4sqC9Md
         ui3KNcoiqqQXk44J8CFeDc716az7GvdnFyaua6ColZYlUr1NuGA6VAQZQera01tXN34L
         oj1G92Dq3DWYcLcIYxRl40iqNrTW2gF+7EgeWd0X5nHCerThCugFHM/CpSDDaECyzMt0
         ChOJUXicYsbKOfu1DgDAbyFbM56aGzBReguQBdfYSybgVogj3lWDqpuepJSnaJMBZfZ4
         1EJA==
X-Forwarded-Encrypted: i=1; AJvYcCVKoqdBHfeQBP+bqra075ioWvl0rp6HMI0bsh5o1a83/zrX7rBYanyN8gV8nhVFz0qDfpJaaBo5ZpN+@vger.kernel.org, AJvYcCVwqW5K/6RBg/3RZT8zH9GxWSftWMf62pzd928i/uNiTRgAaVr2wkjsm12QroaYDqPPwqjCAmaH++3p@vger.kernel.org, AJvYcCXad+EyGFU0NJOfA8Zz7T5OXpP9IyasGd+/0pXnh4IjzG49wuPEXWLGQKaG5WOrQhEVWn0C8cPMuaFyNJ/k@vger.kernel.org, AJvYcCXrSDLF2iAlbT+LV7DM9h7zbyVYZplPxNQX9MrPPM58fQOHjRF/042z6HXKghbNvS9CaLcfdpQ2gcJB@vger.kernel.org, AJvYcCXwtCVFVC/Hf4eMBBMCR/ltXM6EEkKTlvGF65t4UYUyAvYkKkOYcwhnE/Su7TeowOBXJgwjAvXHN7ak@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPrT3wcNWEWC2PTPTzTCoOt4OI2KhEOfSntqasLApRvYEL6V9
	qIY9UEbLJ67ag/8AZCRi68w/x0hBTpxeV+LqNCvOMLJsmQ40ivfJ183a
X-Gm-Gg: ASbGncsRudPxphNq/fFglL+ZUbMkDxDJuAoY69alFdsgXq5lowI+SRIWQaZ2He3QiWd
	ztqinO1j+RRjf1bzTYAk3r9mEWXsDhkQvlK4w3l7QNgjAN51Xohl4kETC040+sMSozdZ1kJIgtf
	jepqR7E8tWWUPd9DE5NCtCgTtGY4Pmf9RexkUAOvDzqYWoCOxzsHw4w2U7c0LdNh4IffCl0/ygC
	BXYIkJKSUqwYB8jtZomO7p241PBNVi3UaEVZo1gJIetKRWxn6ntqMsVmDGReELtx3PXcXkf0TYu
	NYfJRoAaq8mcN4SqTOL+h8ofd8s0aJsksZlG5MPcDqM0vQnOsFpoukGK9C14gQIqqhKhkzj5K2n
	2yfnZD4o=
X-Google-Smtp-Source: AGHT+IEgHOUFMFCgr3FayDvhUXf1wP2ej3MU+MRC9MTMlQ0HxZa9/T+TtlTt+0/ujY4/jQfzKhe7aA==
X-Received: by 2002:a05:600c:4691:b0:453:aca:4d08 with SMTP id 5b1f17b1804b1-4533cc5cfd1mr84280755e9.1.1750082100305;
        Mon, 16 Jun 2025 06:55:00 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e25ec9fsm142381335e9.34.2025.06.16.06.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 06:54:59 -0700 (PDT)
Date: Mon, 16 Jun 2025 15:54:56 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: adc: Add events support to ad4052
Message-ID: <2uknsmgz57wie4cv2tll3ttfyiw7lyjyaryc74nd3o5fteoazk@vbgdt5ofkn5r>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
 <20250614113616.4663269f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614113616.4663269f@jic23-huawei>

On Sat, Jun 14, 2025 at 11:36:16AM +0100, Jonathan Cameron wrote:
> On Tue, 10 Jun 2025 09:34:41 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > The AD4052 family supports autonomous monitoring readings for threshold
> > crossings. Add support for catching the GPIO interrupt and expose as an IIO
> > event. The device allows to set either, rising and falling directions. Only
> > either threshold crossing is implemented.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jonathan,
> Hi Jorge,
> 
> A few comments inline.
> 
> Jonathan
> 
> >
> > +
> > +static int ad4052_write_event_config(struct iio_dev *indio_dev,
> > +				     const struct iio_chan_spec *chan,
> > +				     enum iio_event_type type,
> > +				     enum iio_event_direction dir,
> > +				     bool state)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +	if (st->wait_event == state) {
> > +		ret = 0;
> 
> Feels like a case where init ret at declaration would be reasonable.
> 
Ack.
> > +		goto out_release;
> > +	}
> > +
> > +	if (state)
> > +		ret = ad4052_monitor_mode_enable(st);
> > +	else
> > +		ret = ad4052_monitor_mode_disable(st);
> > +
> > +	if (!ret)
> > +		st->wait_event = state;
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret;
> > +}
> 
> > +
> > +static int ad4052_read_event_value(struct iio_dev *indio_dev,
> > +				   const struct iio_chan_spec *chan,
> > +				   enum iio_event_type type,
> > +				   enum iio_event_direction dir,
> > +				   enum iio_event_info info, int *val,
> > +				   int *val2)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +
> > +	if (st->wait_event) {
> > +		ret = -EBUSY;
> > +		goto out_release;
> 

Below are two distinct options with different implications.
> Not being able to read event parameters whilst monitoring them seems
> very restrictive.  Can't we cache the values?  Either play games to ensure
> we get them from the regmap cache or just cache these few values in st.
> 
> Checking what you are monitoring for feels like the sort of thing
> userspace might well do.

(1)
I agree, I can investigate regcache_cache_only and the other cache
options to achieve this. If I come to the conclusion it is not possible,
storing into st will achieve the same.

> 
> Even blocking changing the monitoring parameters is unusually strict.
> Why not just drop out of monitor mode, update them and go back in?
> 
(2)
The core point of the blocking behaviour is to not have hidden downtimes
in the monitoring for the user. An early driver used to do what you
describe and it was a design decision.

Since a custom regmap_bus was necessary to restrict the regmap access
speed (ADC access is faster), bringing back this by behavior embedding
it in the custom regmap now seems plausible, with proper explanation in
the rst page. This should fully dismiss the st->wait_event -> -EBUSY.

Considering (1) and (2), what is the preferred approach?

Regards,
Jorge
> > +	}
> > +
> > +	switch (info) {
> > +	case IIO_EV_INFO_VALUE:
> > +		ret = __ad4052_read_event_info_value(st, dir, val);
> > +		break;
> > +	case IIO_EV_INFO_HYSTERESIS:
> > +		ret = __ad4052_read_event_info_hysteresis(st, dir, val);
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
> > +
> > +out_release:
> > +	iio_device_release_direct(indio_dev);
> > +	return ret ? ret : IIO_VAL_INT;
> > +}

