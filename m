Return-Path: <linux-pwm+bounces-6209-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2011BACACA9
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511E917977F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32EA1FECBD;
	Mon,  2 Jun 2025 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1i4aU5Y"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444321E885A;
	Mon,  2 Jun 2025 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860722; cv=none; b=R9/SHn65RcXi5s0WnuKVKTL2scPHBR8wYrvE2yHbpROG/EpJ3+AyWhaq/zQCJHd5ayP2qyYvgqlPvUULk7+hJ3iq6e1kN+XEusi37v01HkVzvzhr4lzWBHBITA33IaKhxGyWdNOuX+xcHKk/FYm7RvdabeOIipprAcm6PPWpAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860722; c=relaxed/simple;
	bh=vlGm7NoJVTdY5rMQoj+/eKcWHgSfT26Ch33MqngzHpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAkYzZUHq6+0Im1gXH9vaP7klZbP4Poga9zcN28TcaULlMVVGk2fWZdUQ2xjTNKi45wcNqw1aA+G190JtSmf8frWiOwpAz9MqEvP/chYN3kmWwkepMAIrkLWJZqJpcVkaA+0N/V0JrjB9cg47X16hJH0PXHCJud2SaN7Bp/Gknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1i4aU5Y; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-52eec011ff2so1365816e0c.1;
        Mon, 02 Jun 2025 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748860720; x=1749465520; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ztgng4bXNGVQuJIZ6DTocfGtin3f377FQSFRju5g4c=;
        b=V1i4aU5YG9VgdDpkMlrq8i2uiQL9bxX6lsILbz8ghF7kByAv262vFuAumxX3URSmul
         tjP8fkkbAJUhsOYkr0uZo00AKgV5nxnpF9s6XK9AYnCOCCg52Marb0bvKd8+g/Kk4NWZ
         2MYSI3tALDcF+od79UYigMN5A+DXOfraakK1Ndm0HM1HaBKjFAT53of5K5QKx1+o+msF
         hq4wQeNDPcWe4pD+yaGAjKlEMLaLSOoPNikSazrAP5B9aoUViIMmzASClDH6hBeKS58/
         wz9VKwfK1pEd4Y4D41c7jyMmecDd7lPOG6tT/mFg/mvQtE2GcakIDIsqNmnpHdm5bxY8
         8+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748860720; x=1749465520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ztgng4bXNGVQuJIZ6DTocfGtin3f377FQSFRju5g4c=;
        b=s4fBl2BhaodSYzovHD/3vWEm1f4zmlMEGvcnVnhDGwXm8SPmIXA5wmAKDNQG2ogavL
         Sx4wZzYIBM2LdC53GG5jR/SM2qgacF2PLFZOVvEoaw4Z/5K/A28Oiayf1b7Q1bQ7FqBB
         wnM0byyTnlxzmMu3RgwDXvOZEOZDEn02xkh9xjdfBuI4z7DhAHTlGCK/gP9yaliI9Mx2
         0ak12k8nhBzdQaIWOxvmV8OhJMSDp+71aU4cdiZI/ZY42ScpBBQEIaKkI/iVhHDN15qT
         xM083eBK4V/EoORpeThrUq4Zq0JCXxzP6M7+GkxaXRacPTO8iWuMHC/FiF2cr3sdud62
         wlcg==
X-Forwarded-Encrypted: i=1; AJvYcCUYjJ9qGrpgjbUIz487jSlxk7Rr8FFuT4C2/rK8JAdGg45f5v3gwctsYXfBNETL5992Z7yqlJCZCJYK@vger.kernel.org, AJvYcCV2sYWSPrW9BGzfaK79dR3AkeiDyhqz2x7I1ahN6EVI7erpKp6FfLVjQvvlUPwBNWsx4y39CoxdOf49@vger.kernel.org, AJvYcCV7lahjUy/5Vme1SMkOeJCB1Yt+Mrdox/2WSsEVsFuo8n58+6ZR06p+4Ve3aVvpQ9lYCDltVxjDTKRZCNN4@vger.kernel.org, AJvYcCVVu4EVTK2CI/Guv5BI7IRs7nFZBKfo1jZ91QCh0euc/JAqhzv9YIcYIr5hvrJhLeKsE3WyBcGtFv/V@vger.kernel.org, AJvYcCW38Dkb49s1u4Rif7K4DqCCCTenkjS2JmFeFKBHBXTSCLk45/6qIhdTMmTzBYNMfChc+oCOo4WDqsiy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnmf8eKL5oIDUnRpMVGc1Yo6XqCgskGf1OenGuf4g1qa2LxzLe
	bmEBIwaeNSERZ8++zo2lXLV/00KHQCbGLwjA92VVl5sa8zFMYmJv49K3e4BpY85e9U4=
X-Gm-Gg: ASbGncuoM+tCpxnzCIF/mC0krYh4pAPVEkp5eNkHZMgTn65RzjjA6VKAusU/8fTfLM9
	qA++1nFhcsslvJ4hWvW6BtkBDDLFpH8IN5Wtk8WxAAdw2VDWsh2alrHJuX+aualEM0oKJI+Q6bv
	AE5HlKl5j6xmNy+kADCpWv+RSexckKmCBPeyWFYvXIY398wocr3jimfdOqCSD3N1Pva4y6/eZ24
	DzmRnWQBNzWC8GNxG0UL3Gvf/ch6nmcYjw7tvo0Zpf467tMPLd4O4t26AZoRgqwh0e2e4+Sh3xV
	T3kywd8CpnLXtYqjn+aJFhiOAi7VJ5VgMSaD/3FFjvgEBIrSj3uuL6K1E2WyAlPqBDpT5OR/lyi
	A
X-Google-Smtp-Source: AGHT+IHa5cxboieLvmCtHPVB20IC9g6NUuYsJf93eIYatfbNalHTY43j35vKDJqGc+n6p6vMyFJ6/w==
X-Received: by 2002:a05:6122:3bc1:b0:520:6773:e5ea with SMTP id 71dfb90a1353d-53084c639abmr8165473e0c.7.1748860719952;
        Mon, 02 Jun 2025 03:38:39 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1225:ec01:ecf2:8e21:9f0f:159e])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5307482a15esm7388405e0c.0.2025.06.02.03.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 03:38:39 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:38:27 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: adc: add support for ad4052
Message-ID: <nz2o4fi5geowbki3flpou2ccs4hfjr356qmfx763u6lilrgp33@72bj5i7qqark>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
 <6zn53fgyiwtm5ad5piyt32uxcwenwgkhwhantizsjytwbf42ts@4pg6hkna3yah>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6zn53fgyiwtm5ad5piyt32uxcwenwgkhwhantizsjytwbf42ts@4pg6hkna3yah>

Hi Uwe,

On Fri, May 16, 2025 at 12:11:56PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Apr 22, 2025 at 01:34:50PM +0200, Jorge Marques wrote:
> > +static int ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int freq)
> > +{
> > +	struct pwm_state pwm_st;
> > +
> > +	if (freq <= 0 || freq > AD4052_MAX_RATE(st->grade))
> > +		return -EINVAL;
> > +
> > +	pwm_get_state(st->cnv_pwm, &pwm_st);
> > +	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> > +	return pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);
> 
> Is it clear that pwm_st.duty_cycle isn't greater than
> DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
> 
> I'm not a big fan of pwm_get_state() because the semantic is a bit
> strange. My preferred alternative would be to either use pwm_init_state
> and initialize all fields, or maintain a struct pwm_state in struct
> ad4052_state.

Ack. I will mantain pwm_state in ad4052_state.

> 
> > +static int ad4052_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long mask)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	struct pwm_state pwm_st;
> > +	int ret;
> > +
> > +	if (!iio_device_claim_direct(indio_dev))
> > +		return -EBUSY;
> > +
> > +	if (st->wait_event) {
> > +		iio_device_release_direct(indio_dev);
> > +		return -EBUSY;
> > +	}
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = ad4052_read_chan_raw(indio_dev, val);
> > +		if (ret)
> > +			goto out_release;
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		ret = ad4052_get_oversampling_ratio(st, val);
> > +		if (ret)
> > +			goto out_release;
> > +		ret = IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		ret = pwm_get_state_hw(st->cnv_pwm, &pwm_st);
> > +		if (ret)
> > +			goto out_release;
> > +
> > +		if (!pwm_st.enabled)
> > +			pwm_get_state(st->cnv_pwm, &pwm_st);
> > +
> > +		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, pwm_st.period);
> 
> Is this the expected semantic? I.e. if the PWM isn't running report
> sample freq assuming the last set period (or if the pwm wasn't set
> before the configured period length set by the bootloader, or the value
> specified in the device tree)?
> 

Yes, but I will just use the (new) managed pwm_state instead:

  *val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, st->pwm_st.period);
  return IIO_VAL_INT;

> > +
> > [...]
> > +
> > +	ret = pwm_enable(st->cnv_pwm);
> > +	if (ret)
> > +		goto out_pwm_error;
> 
> pwm_enable() is another disguised pwm_get_state().
> 

Ack.

> > +
> > +	return 0;
> > +
> > +out_pwm_error:
> > +	spi_offload_trigger_disable(st->offload, st->offload_trigger);
> > +out_offload_error:
> > +	enable_irq(st->gp1_irq);
> > +	spi_unoptimize_message(&st->offload_msg);
> > +	ad4052_exit_command(st);
> > +out_error:
> > +	pm_runtime_mark_last_busy(&st->spi->dev);
> > +	pm_runtime_put_autosuspend(&st->spi->dev);
> > +
> > +	return ret;
> > +}
> 
> Best regards
> Uwe

Best regards,
Jorge

