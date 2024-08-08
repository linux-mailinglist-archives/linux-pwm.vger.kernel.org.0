Return-Path: <linux-pwm+bounces-2981-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A3794B4BF
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2024 03:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161171F2341E
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Aug 2024 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F729A2;
	Thu,  8 Aug 2024 01:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbSHxLY1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52238139D
	for <linux-pwm@vger.kernel.org>; Thu,  8 Aug 2024 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723081520; cv=none; b=HoBNvcvqe8IPNqpsTzF1dZIYi0SDc+USRcKr4mFNCk1Y3rOLM8+ed4oEqHYMQ6ZO9HZ16P1i4hSUxOYV+DrIfyaQApa8QWJh90LzitSR9m+GyWCGG6k5QbxzE29tJmyu+n7RLzqzCwoe9NzSP1VT+ZATsgN/ji09EgyYjrLZtZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723081520; c=relaxed/simple;
	bh=1+QyuxjejtsnBbckjpLQkIj9vOo+hQICCUI/ToHvtu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORlZ7SSgOYTC2l4sHwVf8nalp2FQ/Zi+P+nKC1qp26fcKFuzLx/R1IWT6G2qBaQX5yezajQb0teBInJkDLguikuENXrZMQbxlZN9/A+5ncanN9+wJrk4vQDdPHuEStJZSNSyqRYT/n/N4u6fZpT0tqp1P40MUtvYebBFE2n4BPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbSHxLY1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1102876b3a.0
        for <linux-pwm@vger.kernel.org>; Wed, 07 Aug 2024 18:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723081518; x=1723686318; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FUfX4UBs1RVJ+pcP4zWV+lz43NfHYQ0ZDcvMNMgSIog=;
        b=WbSHxLY1wCif+Vy3i+L8dd+XZ1mZd0+O8Hwrof9Q4ogGxWmwl8yxHLXmq1gr5qPSyB
         pR89SmGlHNEmQ326nEnv+/bZBVwrkL+3H5gm7O7RrpMfa1dYOnbbqky6uQVxSYiS7zmv
         irkGxIBy8q2WQ2uvROU50Jcr8FKMOeT4+zEBxhF/x5TpM+JqCFGGRvDpDkng5JUrGpc8
         ME6I70DO6y3LhIPYagTZUIh/Q6ya+hCrerUP6PbQyUpy6YM+VyJmpDQx2mLnyRxXebl0
         iGQTpwHogdMfX1lFJEst1TgFEbWhNSGZyRazf2aGa2Tk/hFKPfX0c8CXG98g9wEffu7z
         kh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723081518; x=1723686318;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUfX4UBs1RVJ+pcP4zWV+lz43NfHYQ0ZDcvMNMgSIog=;
        b=CuPxXRdEXgQtaQQ5oxtTyJaM7G6UPSj0DJkyorlgf/dm2V6pnevHTWJcgSYnULTP+P
         S0LU/4QSp2Ujp5Ui80T2kMucVsCA9nwNYPQTeci4BIp7hp5CuKEXr5iz/ZdCrX2NSyVp
         MbWR88gEuRUHfXOq52dIX3S+nUG/8QW7Lj5XUOdFg1q+L2LUCrJ90R8o8Im1tIi6lFYf
         PgExdYbJAAEA4CmWGpWG6Q8FAoEVCABcsFJXUX+kfZ06Te3YVyd7y2J2xnIQMOPS9Vmf
         GLd3vDinvd76LwZSn+oXIonDstfd84Ogrv/Ew/iD7+q3pOtaD2WHLcgLRKi4nj0iJkil
         n4Eg==
X-Gm-Message-State: AOJu0YyiEqYxdBiRk6hgCGO1kqp1sh9J9voRoDcfD7HaowOyIOxkNx/n
	D1W0jDFGINOOC+XJddwVW/vzkfOxmX4H0P9munJeb091wafe2HuD7zirTg==
X-Google-Smtp-Source: AGHT+IHoQpYeUq4bqCgeySDRSBR9kNGGCFyNowhq3xEPUC2WQrNQgX1OmhQ8I6I7LGuyDyDzyt2WvQ==
X-Received: by 2002:a05:6a20:430c:b0:1bd:1d5f:35be with SMTP id adf61e73a8af0-1c6fd546b42mr420583637.11.1723081518436;
        Wed, 07 Aug 2024 18:45:18 -0700 (PDT)
Received: from rigel ([118.209.204.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2ccf29sm143462b3a.128.2024.08.07.18.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:45:18 -0700 (PDT)
Date: Thu, 8 Aug 2024 09:45:13 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <20240808014513.GA4195@rigel>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <e61728fdc9e3c80c4cf6961883754095b604a399.1722261050.git.u.kleine-koenig@baylibre.com>
 <20240807023433.GA29189@rigel>
 <thicnbomf7hux32cx2e5fzd2lpo43hiuaxmxw5tdsppet4hx5j@r2y5cobt4hph>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <thicnbomf7hux32cx2e5fzd2lpo43hiuaxmxw5tdsppet4hx5j@r2y5cobt4hph>

On Wed, Aug 07, 2024 at 08:04:22AM +0200, Uwe Kleine-König wrote:
> Hello Kent,
>
> On Wed, Aug 07, 2024 at 10:34:33AM +0800, Kent Gibson wrote:
> > On Mon, Jul 29, 2024 at 04:34:21PM +0200, Uwe Kleine-König wrote:
> > > diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
> > > new file mode 100644
> > > index 000000000000..c89ba3e3def8
> > > --- /dev/null
> > > +++ b/include/uapi/linux/pwm.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > > +
> > > +#ifndef _UAPI_PWM_H_
> > > +#define _UAPI_PWM_H_
> > > +
> > > +#include <linux/ioctl.h>
> > > +#include <linux/types.h>
> > > +
> > > +struct pwmchip_waveform {
> > > +	unsigned int hwpwm;
> > > +	unsigned int __pad; /* padding, must be zero */
> > > +	__u64 period_length_ns;
> > > +	__u64 duty_length_ns;
> > > +	__u64 duty_offset_ns;
> > > +};
> > > +
> >
> > I would go with __u32, rather than unsigned int, to be absolutely clear
> > on sizing.
>
> Hmm, the upside of using unsigned int is that it matches struct
> pwm_device::hwpwm. To the best of my knowledge all Linux platforms have
> sizeof(int) == 4, so a change would have no effect on binary
> representation, but only help the human reader (which is good).
>

The uapi headers define ABI, a machine interface, so I would give
priority to precision over human readibility.
The size of __u32 is guaranteed, while unsigned int is not.

FWIW, __u32 is used more frequently in include/uapi/linux/*.h than unsigned int:

$ grep "unsigned int" include/uapi/linux/*.h | wc -l
441
$ grep __u32 include/uapi/linux/*.h | wc -l
4234

> I don't know yet, but I will consider the suggestion.
>

No problem - just a thought.
Sorry for not reviewing earlier.

Cheers,
Kent.



