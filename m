Return-Path: <linux-pwm+bounces-2160-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D178BD8CF
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 03:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5B81C20DF0
	for <lists+linux-pwm@lfdr.de>; Tue,  7 May 2024 01:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAE10FA;
	Tue,  7 May 2024 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCY11im9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AB19E
	for <linux-pwm@vger.kernel.org>; Tue,  7 May 2024 01:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715044270; cv=none; b=UoLws7jF2FxeU0EESdTxA4WOrlr6u+bectVkUHN+8RYn7gNLaMZmFZJJZ9DzfLed+LSUTA2cM/Yf/HJJo/z6mFDL8G+t696zqby2dpQIF/m8FwX6w3f6iAtH3lIp/AM/FrzjzWlJlslCA+ktESwkJvsRTFw1Cr25/f7Ke70qRL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715044270; c=relaxed/simple;
	bh=PZc6jHtIsdZQcAyIL6FG93mXvWVH0lyn6qsGmhZXGDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kD46c9veUMEBoJ0ul1kBctBRhS08H0bi0LxPh8rj6Jn5ZbTH0CYmZaCbRscZWMG/dhqAdjtObuwigVmCcCLSrsc1+6/SfdYchknSAMsG8vqTDnhcTPJuGUAw41P1Jy53Ues9szyLcNmcli/5Pzsmf/BldWAiHp8l9+JiUvkRlYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCY11im9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ee0132a6f3so13927915ad.0
        for <linux-pwm@vger.kernel.org>; Mon, 06 May 2024 18:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715044269; x=1715649069; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZjZu/4aLJ0GooWOf1ODXVJW8sAAenP6wPk1c3vR5vuE=;
        b=UCY11im9d4zcg8dpdNEWkY5o2locbd7+6NpeWaNVNQAccf/Ztz42eb/JKgKa4pdLrG
         hgUT9j8e2VrLgz/lBskI9Sy26nya7IQYW2CvM4VwD2WkumABKSyO7bnhSzZqvg0u6/i7
         5e0plTo4JJmSVliiDeit8JsK3GfAndcvbmyv7EAk/I92aqG9SCKReUAmCglfBEuiafob
         WRjJkDQJKlbeou57DG+SbgKku2Kl85wnrstUlpMOEZnUISZOLuv3b3i4+Wc8P7DRk9u8
         KWRQIHMBsaheYXiOohGOfzKOGH4qi/qNY2C0ZOfLE90CeGbChxSXgn/Z40RBlEfYeE/u
         pGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715044269; x=1715649069;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjZu/4aLJ0GooWOf1ODXVJW8sAAenP6wPk1c3vR5vuE=;
        b=KpRkdmYG0wT4a2HMpJ/Itl4ZUlWYDXxyrLutFnRro7PCC58K7ng1CebosySKbquEw3
         n21rTHqLQDaMVuYZqOugVuRkWRuP1H4V2vJHJo17xPkIYvlHj0y/GyZeNM66HjSA4BWQ
         hRcsRpcoz7jUPcvUxNK29J8iZSEMq0rTpH/lB6CsjyVlfeJfBI3mRE9dNXHMKBiCcLbC
         MP+ejiCDfR4WiGKMI0WCKyPva+e9dMF8ZmbXbha7GyDGKTZ6iIY3vtMc65mKPvHSk9im
         Mb+F75z9FG5VCe46VyAb6bQakXBtTlaRnw3lrOqQsV8OfOtnBNGFIyDCrC3dtviLiyZh
         4u6w==
X-Gm-Message-State: AOJu0Yzi+xB8kXxAhXkLZI+w3CA9xA6Mw8A/cVCroOm5eBZ8S1denoet
	+3ea17KyHGH8N9RtcoXQbCDl2fzma9HdyKWMLB2hRCC6z4vVKaUFP9UWTg==
X-Google-Smtp-Source: AGHT+IHT4cU9RcfObEhySTXJys9HBntRAhuFfhOgqDDsKy4yeXeUvx+TcvarwpKoqY7nRjN8tM2VZw==
X-Received: by 2002:a17:902:b111:b0:1dc:de65:623b with SMTP id q17-20020a170902b11100b001dcde65623bmr10252010plr.60.1715044268569;
        Mon, 06 May 2024 18:11:08 -0700 (PDT)
Received: from rigel (14-200-166-65.static.tpgi.com.au. [14.200.166.65])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902f0d500b001dd02f4c2casm8963317pla.164.2024.05.06.18.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 18:11:08 -0700 (PDT)
Date: Tue, 7 May 2024 09:11:03 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 8/8] pwm: Add support for pwmchip devices for faster and
 easier userspace access
Message-ID: <20240507011103.GA26136@rigel>
References: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
 <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d3acfc431ecd431d6cced032dcb58ad2579474c.1710670958.git.u.kleine-koenig@pengutronix.de>

On Sun, Mar 17, 2024 at 11:40:39AM +0100, Uwe Kleine-König wrote:
> With this change each pwmchip can be accessed from userspace via a
> character device. Compared to the sysfs-API this is faster (on a
> stm32mp157 applying a new configuration takes approx 25% only) and
> allows to pass the whole configuration in a single ioctl.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

> new file mode 100644
> index 000000000000..ca765bfaa68d
> --- /dev/null
> +++ b/include/uapi/linux/pwm.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_PWM_H_
> +#define _UAPI_PWM_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +struct pwmchip_state {
> +	unsigned int hwpwm;
> +	__u64 period;
> +	__u64 duty_cycle;
> +	__u64 duty_offset;
> +};
> +

Sorry for being late to the party, but I only ran across this thread by
accident.

Have you considered the implications of sizing and alignment here[1]?

Change this to:

struct pwmchip_state {
	__u32 hwpwm;
    __u32 __pad;
	__u64 period;
	__u64 duty_cycle;
	__u64 duty_offset;
};

to clarify?

Cheers,
Kent.

[1] https://docs.kernel.org/driver-api/ioctl.html#bit-compat-mode (and
subsequent sections)

