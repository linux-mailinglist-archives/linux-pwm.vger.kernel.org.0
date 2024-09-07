Return-Path: <linux-pwm+bounces-3146-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26E96FF16
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Sep 2024 03:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DA7B2132F
	for <lists+linux-pwm@lfdr.de>; Sat,  7 Sep 2024 01:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C94C79;
	Sat,  7 Sep 2024 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY7SrbwT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477E31171C
	for <linux-pwm@vger.kernel.org>; Sat,  7 Sep 2024 01:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725674288; cv=none; b=Z00lOeId62cIm+QtUSMzD9Dmjlc/wL3LCz2uVOodMvGpcj8BZL+2EVK3kk89Rg7NI/F8+tmNMcFBNSfgfS6lQeaW9UsF2ehp8CSHeDPxbAn69OJNQ/83HfZs8zifh2LOuyA65FZLG7faM8iuQY2nKltR7sT2ObvDd4ZuskJHn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725674288; c=relaxed/simple;
	bh=u2Eo+l5jFYXu7fUou0IwtdQe7FxvvatMGEezZXd7jZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvR0AbjmOXduMAYWlM25dgyabtuxgmPpGVui5tctrek86acGVThP+2TkP945Vq0jMwZKCmMKlNZ+Y1IhsYJwLQqPwtizdkmDVRCqRmx9B/JMTCEA+MKgYeu4a8NqSbivmeYW+PIGF+mqmsNgefrI3r8B4rAoQmk5wg56KG74IYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY7SrbwT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2054e22ce3fso25639595ad.2
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 18:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725674286; x=1726279086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J77sDKL0SrzLbKIWHdOcxvXfUVJv1p/xQR85mAjmtGs=;
        b=TY7SrbwTgofGVcIAptsqYT5Lgeh2wK3ozueVTHTHYJGeAKKDZZhS1VXjLZFlBZZlnF
         nMzmNi9PCqn1g8zevwmUTWTDIg13uZDhbTyUBeBP/wLT2mX+LhU1HScS9qHsxeq1t5bb
         itbEJH/LbhHl4UdiE3knwp91cOXkU0756VXNQ6dPZLyg9v9H8xbZzGnfd4Esd06hhIoT
         divkeq4nr4tF6a3zPr/2yAN0Z1ixscaGtA+UPCbY7zPrZsxePLHzcnO2emoSzHJVCMrJ
         et4wbaiaHduoTs+b7HNZ+xpiaYjgrgSC58GxLo5bcmIrFXoo8cZSOsygcw7rnRHh0jCp
         d0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725674286; x=1726279086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J77sDKL0SrzLbKIWHdOcxvXfUVJv1p/xQR85mAjmtGs=;
        b=sXg8Iet0TH9MJ3I1tklHN9CyWWou7z3ykore5Qihoctp/hTmLzmgvqGiHT8Xt8o0Er
         50IPZebLALfaei+K+u0yDUI36AqFM/pXYgUaFXeTDqPUG4ovjrDyFCFSEO2/uzVhZXUN
         sKHr42u8X7wqQiuTJkUHrk9wfv22WgXRy17OUS77pi30AjuHIO8KaJ5kW+gcBg7SE/IW
         HZ+eOwThyKQZRawMpr52aIendE4al2JUewx4qf4lLix3e0aT87NOr5aAvAZhExFvdaSO
         45OGsS8W17NhjU3e6gsxNuTOOikLtyyzcucKma6tTqb9bxqTPAGpLZhhI3RAmwjmzzRk
         3g3A==
X-Gm-Message-State: AOJu0YyVv+K/aewLDRpdklijwL+HpJpGO13LaXOMydXxNjl2JPbXQAmw
	c3Nuhp5/4Bth1im6cW31KC7eZ8SJXULsIKyt4zokbbp3Me8bozAqmoz4hg==
X-Google-Smtp-Source: AGHT+IEOaFcVxzQdMgyDcSJopYPFK2ir8yS2zMXRALAAY+TSWu+ofyImUBrRKzMgRdWputcjJT1VMg==
X-Received: by 2002:a17:902:da8f:b0:205:3e6d:9949 with SMTP id d9443c01a7336-206f0624635mr50240955ad.52.1725674286416;
        Fri, 06 Sep 2024 18:58:06 -0700 (PDT)
Received: from rigel ([203.63.211.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e100bbsm1159135ad.16.2024.09.06.18.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 18:58:05 -0700 (PDT)
Date: Sat, 7 Sep 2024 09:58:01 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v4 4/7] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <20240907015801.GA8436@rigel>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>

On Fri, Sep 06, 2024 at 05:43:00PM +0200, Uwe Kleine-König wrote:
> With this change each pwmchip defining the new-style waveform callbacks
> can be accessed from userspace via a character device. Compared to the
> sysfs-API this is faster (on a stm32mp157 applying a new configuration
> takes approx 25% only) and allows to pass the whole configuration in a
> single ioctl allowing atomic application.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---

> +++ b/include/uapi/linux/pwm.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_PWM_H_
> +#define _UAPI_PWM_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +struct pwmchip_waveform {
> +	__u32 hwpwm;
> +	__u32 __pad; /* padding, must be zero */
> +	__u64 period_length_ns;
> +	__u64 duty_length_ns;
> +	__u64 duty_offset_ns;
> +};
> +

Some documentation?

> +#define PWM_IOCTL_REQUEST	_IOW(0x75, 1, unsigned int)
> +#define PWM_IOCTL_FREE		_IOW(0x75, 2, unsigned int)
> +#define PWM_IOCTL_ROUNDWF	_IOWR(0x75, 3, struct pwmchip_waveform)
> +#define PWM_IOCTL_GETWF		_IOWR(0x75, 4, struct pwmchip_waveform)
> +#define PWM_IOCTL_SETROUNDEDWF	_IOW(0x75, 5, struct pwmchip_waveform)
> +#define PWM_IOCTL_SETEXACTWF	_IOW(0x75, 6, struct pwmchip_waveform)
> +
> +#endif /* _UAPI_PWM_H_ */
> --
> 2.45.2
>

