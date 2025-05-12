Return-Path: <linux-pwm+bounces-5920-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C05AB3956
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AC01884468
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE1B293744;
	Mon, 12 May 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhLTxl1L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D4E5674E;
	Mon, 12 May 2025 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747056682; cv=none; b=tjoYhvachwrSAUvZjl5ddTqecAOQJnlHIIZM6kId2NRhCSl7B/IvIJjGNnIMTEdFgOJiyY1EkzpTisWMZMLDcPM3elNVjMb8UFN1cEQ4HNQQs4yZhTOCUwj8+AppIkwKKWgvz/XS+qio4uRHyAgjWfq8BU1GHlQP6nhZ1DIps2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747056682; c=relaxed/simple;
	bh=+D0uSfQEm6iJVXyJgjFC6uTeK0qCXRUpY5ighloyhvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXTTIJRaIusEh9b+u+tJ48TTJ63a/+bEy/mID+oP8TMXMGftAKDS7D1ZvSSMEcXfqLiAa6Dv36UAjEzEdoBw00QMasFI/vhDAlGXPaRg+sWhZCq/DyHCzBlNEDv4qpUAdb09FVb9kBR0PpWYL1Q9UBLWZr714c8iqcjHnGcjsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhLTxl1L; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso32996115e9.3;
        Mon, 12 May 2025 06:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747056677; x=1747661477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6zAuz1VS2so8ZTeS7KZCrx29zpgetdbyE48Jtj2DVGQ=;
        b=HhLTxl1LmXuwQAGeQhWgMIIsSl+YvXFCl96JCCDAz3+z1ObxHbkuYXNpfW3KSGbKTL
         pKZQ3Qxw7fs1Prq3rShOAcYt6QK3RGmin9DvRdT99BoudkU+IeOpc3zlIVwbOgaaQ89w
         o7fnPwc2NGHT6QrRS+KG8G02YnYOl5p57UGs3qr4IqbbW+oAGl6QALiQQ53OGdh4xoc3
         tu+dh3r4/PtElNIRKldn79Oy0ZVT9su/mJOl6SQTrSiAc0fQ5rj2aECxUXSroH+fnHus
         lLWtnmMeHxyOn1lTMy3V9CtoxUovpwWP6cQUSgUffJQwbPtvSog0d9UoFwS9uI75IZ+B
         igIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747056677; x=1747661477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zAuz1VS2so8ZTeS7KZCrx29zpgetdbyE48Jtj2DVGQ=;
        b=Y8Yfcy4A2ew5iI1XKau2Z73kKT0GGdfaSmQN9gfNga0hGbthslzHbBF8u6kBCKnSgD
         LvypsoDNcb9c2XL0O4g/fcVq10fIWm52aFtR388cYvTES9hX6BKHuNVZfsI1o+6WaWFJ
         xeFTB+u2T+NjXsFlaWlYRBSRt+Mue6bQ+Aewz+20OMyZtLAq2dk8+OXoOu/hC1GbTHj3
         WvnERhSu6efdsBkw3oExAV77DSmmQVWya+FJdPLuwO5lz/Soj2iJtT6YcrT5eBIZrg/P
         AUD+e0so+q4wUp1tzOsDaaLJD6WVN60XEz0S4fUepVh0CarJRLDNVxAqqvswMGr6VFPW
         9Y+g==
X-Forwarded-Encrypted: i=1; AJvYcCX+E7SWbPMsI2STe7BVdoLq2rdG2IvrUzXlCwUP1ih5lGZMjrfzKMAHbnwjLaba8+1cX2RzQRswywnN@vger.kernel.org, AJvYcCXqbMMrmuxWoFju1gygwBF4RSgZzVgCD1bsebmDpnbaoWLAHTrzBSCg9gyZZwvBBx/Fya6+pR2EfR/24w==@vger.kernel.org, AJvYcCXxVN70DQ+Uw12nhgPUVebqqlXVhYEbLROOIlDOgHAFI7XGUzBn2l5PZKLKYPsHvLghxAqw5WU3UJdCZjkQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtO3pTQf4lsSuQ66WFHgiW9fgs3z4VvN+EIJVpDpa7gWgMWhO
	QWYu0poF+0pDLw54nP5PBDg1wIxewQe09SKA+BOyteX3j20ZjM2r
X-Gm-Gg: ASbGnctHog+YBR0ZZ8w2rS5IUJl05D7vugOM+jyzUPor0omJ8fn3quGMlS4ji3EY04w
	85RJCJgduTzJkC9WJWUtyXZcbRowYNc3Uap2S5gnqgqfUNpxu64EF+82kR0zMQcRQ43ZdM8Kcqm
	vIDwu2k2pZJM9E9XfyXYgZ9zC4feHK5NCTdX6tMmwlaCApbmyrmaxfsPg8ZSQz8Udlu6EqrqBnO
	BECdtidc9b8VXEAktRrcHfFKGnXzMbKlQR/YnOK19kXP7o6eNlNdph8VxpbksliSyWUHLyP+ZL8
	kaGEGDEKs+dEUmhfFvFc7ntqsjzwvw1MTMoDdDcsG4JqEwJOFg==
X-Google-Smtp-Source: AGHT+IHexpS/kCUtu4cQjVf5ElozgT9OgpQAe3kO1bBidwu9RV+jz6FTarStflln3KUpQ38w46TfZQ==
X-Received: by 2002:a05:600c:3586:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-442d9cacc19mr106241865e9.17.1747056676796;
        Mon, 12 May 2025 06:31:16 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:632:2600:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd34bd84sm167702805e9.22.2025.05.12.06.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:31:16 -0700 (PDT)
Date: Mon, 12 May 2025 15:31:14 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: dimitri.fedrau@liebherr.com,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jean Delvare <jdelvare@suse.com>, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] pwm: mc33xs2410: add support for temperature sensors
Message-ID: <20250512133114.GA6440@legfed1>
References: <20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com>
 <1bd48694-9760-4e6b-9138-4651d42ff032@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd48694-9760-4e6b-9138-4651d42ff032@roeck-us.net>

Hi Guenter,

Am Mon, May 12, 2025 at 06:04:33AM -0700 schrieb Guenter Roeck:
> On 5/12/25 04:26, Dimitri Fedrau via B4 Relay wrote:
> > From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > 
> > The MC33XS2410 provides temperature sensors for the central die temperature
> > and the four outputs. Additionally a common temperature warning threshold
> > can be configured for the outputs. Add hwmon support for the sensors.
> > 
> > Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> > ---
> 
> > +
> > +static int mc33xs2410_hwmon_read_out_status(struct spi_device *spi,
> > +					    int channel, u16 *val)
> > +{
> > +	int ret;
> > +
> > +	ret = mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Bits latches high */
> > +	return mc33xs2410_read_reg_diag(spi, MC33XS2410_OUT_STA(channel), val);
> 
> Is that double read of the same register needed ? If so, you'll probably
> need a lock to prevent it from being executed from multiple threads at the
> same time.
> 
> The comment "Bit latches high" doesn't really mean anything to me and doesn't
> explain why the register needs to be read twice.
> 
>

All bits of the output status registers are latched high. In case there
was overtemperature detected, the bit stays set until read once and cleared
afterwards. So I need a second read to get the "realtime" status.
Otherwise I might end up returning an false positive overtemperature
warning. I don't think a lock is really necessary, since I'm only
interested in the "realtime" status but not if there was a warning in
the past. What do you think ?

Will improve the comment.

Best regards
Dimitri Fedrau

