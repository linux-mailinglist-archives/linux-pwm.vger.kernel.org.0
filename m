Return-Path: <linux-pwm+bounces-2975-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B28949DC8
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 04:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C501E1F226CC
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2024 02:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7640E18D65D;
	Wed,  7 Aug 2024 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCuqbIiC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1110E6
	for <linux-pwm@vger.kernel.org>; Wed,  7 Aug 2024 02:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998081; cv=none; b=Pbof+Pec48Q4dha0uGWyBuBuInFxvLcRqJzxUud14TAxHuSwpR9gsL/Ou9bbtz8DLFZ03h/KrBS3G3ydgC0Y7utuplLmRI0vW9601X6BHJzi2O7sqfboT17ALpBZ06+d1LNFVIVJqib9nxUIVHn/HqWRg+VNZVO/23qSK1c+xXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998081; c=relaxed/simple;
	bh=Z3TsrzjXZ9XdRU5w5yZoIkkq0IcM2feua1ijpUYZwmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuq48Ltn/AtVelU8stUAtJ1bPj7gSNpRcnvRjlLsfEtS0+RLfMQVT1rBYcZSBxtSDkuDia1meXds0ZdFquOT0kaPQgA1M/Ew9sZMA8Ch6XhHWL6yD3s9H09/vWQPxuidxfLzaytgAVCuvZ8pwBcH0lP18YKhKXR4sDwE443Hvvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCuqbIiC; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7b594936e9bso988578a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 06 Aug 2024 19:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722998079; x=1723602879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Z/MdL1PXu7LrRSTix+28snUA2zDcCpwJ/1SGOpgySo=;
        b=MCuqbIiCxMtgsYX5b3yoOm+NJ/G3j3gzxbMq4IALmwOP6M0zSZMUNvxJLRTaGTE9cY
         sb7+eNZgm5zElI3gsnTKYbXeTWTQh0nG3xDqGGOZdD9enrJ1lFuJLS6rttCxHvFfVC9X
         P/MVopOr3vj5ov7LYtEwwfVEe05n6zhDKicrq+LozEK1ywUqju9J3ZXWlY1bnCWYkAyL
         JN40cA+oZFFSr/mzzKkvciUhlOaUlIYSG17/uHpicO7in0n+OLsyr03aT3VBOpN6HLKk
         uN036viEYHPfJ2WXarBoi5+QSkvdpjxODKU27Xgboayf5D06cUr/IRE7Cb1Z2stqOphH
         2Atw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722998079; x=1723602879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Z/MdL1PXu7LrRSTix+28snUA2zDcCpwJ/1SGOpgySo=;
        b=pSVqh4bdzZmJ7K9FDAJuOU0jnrInjXep1xR+OMYSpiyTmflCt43xo/I7xgjym7qA9Y
         6p0hsUPXg0/lYAbI+45W0rCSzNARXoJk1LggzJqyikkI5XhdspvO7Eb3SsORXM+eYh2t
         94uCgnjR5DNeSdc1vdVix2yDz0TLbhj3fVEiz/+fT1Za/8o0ycmNgSbOjwr3+M556H8H
         x9ydskvAfMLpm8BKxV/mOOHS3R3Yfql8bc95BQpYdsZRxKZIPmso8MTctk3pitI1I3Mi
         7qbC0W+Fslu6FLHmgsl0H/9PfA0QS7EAyyW4UXY0uaCuje2s9IXXYemQ1ZE9gtHeH2Yr
         V1jA==
X-Gm-Message-State: AOJu0Ywv4TDEvo6ANmDwTX4ysbI9V9aT3Nc2XEaUrjV4/my+vI+8MjO8
	QZ3hGGwCHeg0gadLsReaxj0oxdBID7Ouf4vQaFGoG19p6vDsUz9Sfn8KLg==
X-Google-Smtp-Source: AGHT+IE6bEpZvvPvr5XU0xoR19qEu+Mg9IvTBl1RAOGLfV/CBrC2mcyCCXQLUahFTaAyfxWf8sjRew==
X-Received: by 2002:a05:6a21:6f87:b0:1c4:c7ac:9e5b with SMTP id adf61e73a8af0-1c6996605e3mr14531797637.45.1722998078529;
        Tue, 06 Aug 2024 19:34:38 -0700 (PDT)
Received: from rigel ([118.209.204.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3addc29sm205238a91.29.2024.08.06.19.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:34:38 -0700 (PDT)
Date: Wed, 7 Aug 2024 10:34:33 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 5/8] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <20240807023433.GA29189@rigel>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
 <e61728fdc9e3c80c4cf6961883754095b604a399.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e61728fdc9e3c80c4cf6961883754095b604a399.1722261050.git.u.kleine-koenig@baylibre.com>

On Mon, Jul 29, 2024 at 04:34:21PM +0200, Uwe Kleine-König wrote:
> With this change each pwmchip defining the new-style waveform callbacks
> can be accessed from userspace via a character device. Compared to the
> sysfs-API this is faster (on a stm32mp157 applying a new configuration
> takes approx 25% only) and allows to pass the whole configuration in a
> single ioctl allowing atomic application.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

> diff --git a/include/uapi/linux/pwm.h b/include/uapi/linux/pwm.h
> new file mode 100644
> index 000000000000..c89ba3e3def8
> --- /dev/null
> +++ b/include/uapi/linux/pwm.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_PWM_H_
> +#define _UAPI_PWM_H_
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +struct pwmchip_waveform {
> +	unsigned int hwpwm;
> +	unsigned int __pad; /* padding, must be zero */
> +	__u64 period_length_ns;
> +	__u64 duty_length_ns;
> +	__u64 duty_offset_ns;
> +};
> +

I would go with __u32, rather than unsigned int, to be absolutely clear
on sizing.

Cheers,
Kent.


