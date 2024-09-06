Return-Path: <linux-pwm+bounces-3139-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BF996FB1D
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 20:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8447128D48A
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAE91D86D0;
	Fri,  6 Sep 2024 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ibdltl8C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315A1D6788
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725646098; cv=none; b=kit0MJw/Sqs2WopiDDNDSG43f36iFZ7IyGaszbD9WDn36zr1llPL9B54TzUSL9bGHGKK2ftfuyTn0fNEehhHBBUpQTmFGA1J5UVRB1p9uJOHKkr3O0yGYuV++a9jlyXEP0XaRJAu+NjnVNWW1ef675tO1J7PtRvIKNFQoYIR6E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725646098; c=relaxed/simple;
	bh=N5s3RNIQuunVeyKUC1/eTJBNh3LQ4OWVmL8QX5Y3Juo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flUtbJMt6AqbTt9MwGr7bDU5IseVOVvCBK366fUNdB8mgW+pmSK2ho7LYy/5rXQa3AxH1hgWThgvFivNebHlUuEk4vKnFzwU99DOS9qno4nCzOFH41yZSrVoYS4Wz9e8e7Hw2GrZ4mv6orK/d80aWnGBGXTp+ScdnWkDVdKgrdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ibdltl8C; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c524b4a3aeso10173416d6.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725646094; x=1726250894; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZBmlozXg2XqplOo0lXdwMOSJwMm67uW2etrNqOWyDI=;
        b=Ibdltl8CiOTgZDbFQbtnn72XUL0hGf7dstcIf2CSU0iGjy/hueImrVzFE1u8WGiLTN
         7aDc5zBCsDnIrop5+bkTsRajLJURxTkdIVxyBSZXbf4bRPL6J5shHoJh7WWjl+tKZ12u
         mMwIyEuMbp618b2cgc0dxPmPhsBMukuSMarRXI69o581pVP1iFZpXYPAGm+hPQGG37eL
         8Mc3ZfeNbxpc5JWA2zX5F5IVH34Y/I6CHSi51qdNiJzk6Z/uC3mTZ4Buae3UVOUrNiIU
         uACON0Sa3qRz/PvWhDw3+/oa7IfuiqcKF8T0+DFhAjQPtBIfF+YaDZXUVNfYzOfW6IUv
         7fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725646094; x=1726250894;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZBmlozXg2XqplOo0lXdwMOSJwMm67uW2etrNqOWyDI=;
        b=EROHbbVQrWda7AWgdRTKW59K2FMtqTc8x2l4VJFz8VbvYpYM4VG8NzTTJTS3EkUWww
         XHXUv3KdPSOW95mKB+jvb6IuJQEKbtTg18GxVvxYdAA7LDV8DOtvRsGoyT5eXAtF+xEL
         NJb+FlEWZC7RVanc+fqEHgIgqlb3kx0hsPxyRG0+1IuwpnroHoMam+nMEtfb2lnJEBJf
         ZcjODdqr+RGx3FpAm+6WPDoj2Z06DgXUyqUpuh4EPioJ2j7krKkn278kVEg6YaxFQm8X
         eePa/QX8hC1C8te1ePbJgPVcAXL/cKq5cDCdEe/fCni/B6zpbKrFOxzpqRdmzU+CJVIg
         Zyog==
X-Forwarded-Encrypted: i=1; AJvYcCUp4Tq82HdRfN9SXThtorFJKXt9Tt41Edmz5JQUGomN3Dai6CNG2pkbDoeElUbMJBVchra6Y9X0Bw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HxWm3Df34Fa7mTqMHC2/sQJ/n5aPGZhOoyJVSsBgX1qg5Vu8
	WJQ8ImzS8FgqQVOq9bZ74fx1fsvQCgM3MmfSFfl9Pb1fwlGsFX/tXbP7+zY6HHM=
X-Google-Smtp-Source: AGHT+IEWKDq1ah705WzWjjDO4xpUmOR5NO+BvCFUHxQollwC1IilPu1r9vgqKZ9KZFfQuYw7cjyJ6A==
X-Received: by 2002:a05:6214:5a09:b0:6c3:67b3:4c1d with SMTP id 6a1803df08f44-6c5283f86efmr47965766d6.13.1725646094398;
        Fri, 06 Sep 2024 11:08:14 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201dee10sm18712426d6.13.2024.09.06.11.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 11:08:14 -0700 (PDT)
Message-ID: <6d838ec8-9b1e-441d-b7f8-6e31860e944d@baylibre.com>
Date: Fri, 6 Sep 2024 14:08:11 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] pwm: New abstraction and userspace API
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com, Kent Gibson
 <warthog618@gmail.com>, David Lechner <dlechner@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024-09-06 11:42, Uwe Kleine-König wrote:
> Hello,
>
> here comes v4 of the series to add support for duty offset in PWM
> waveforms. For a single PWM output there is no gain, but if you have a
> chip with two (or more) outputs and both operate with the same period,
> you can generate an output like:
>
>                 ______         ______         ______         ______
>     PWM #0  ___/      \_______/      \_______/      \_______/      \_______
>                   __             __             __             __
>     PWM #1  _____/  \___________/  \___________/  \___________/  \_________
>                ^              ^              ^              ^
>
> The opportunity for a new abstraction is/should be used to also improve
> precision of the API functions, which implies that the rules for
> lowlevel drivers are more strict for the new callbacks.
>
> Changes since v3, which is available from
> https://lore.kernel.org/linux-pwm/cover.1722261050.git.u.kleine-koenig@baylibre.com/
> include:
>
>   - Drop PWM_IOCTL_GET_NUM_PWMS ioctl (patch #4), suggestion by David
>     Lechner
>
>   - Define members of userspace API struct using __u32 instead of
>     unsigned int; thanks to Kent Gibson for the suggestion (patch #4)
>
>   - Ensure that pwm_apply_state_{atomic,might_sleep}() don't return 1
>     Noticed by Fabrice Gasnier
>
>   - Rebased to current pwm/for-next.
>     (fixing a missing +1 noticed by Fabrice)
>
>   - Dropped Tested-by: from Trevor
>     While the axi-pwmgen driver didn't change, there were considerable
>     changes in the core. So I dropped it.
>
>   - add some missing EXPORT_SYMBOL_GPL for the new API functions
>
>   - Add kernel doc comments for the new API functions
>
>   - debug message in stm32_pwm_round_waveform_fromhw (another suggestion
>     by Fabrice)
>
> I also updated the branch pwm/chardev in
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git to
> match this v4.
>
> I'm aware of two issues in this series:
>
>   - Triggers a lockdep warning in the pwm-meson driver. This affects the
>     new pwm locking vs the clk framework's prepare lock. I think this is
>     a false positive and to fix it, only changes in the clk framework are
>     necessary.
>
>   - The functions pwm_set_waveform_might_sleep() and
>     pwm_round_waveform_might_sleep() have an unusual return value
>     convention: They return 0 on success, 1 if the requested waveform
>     cannot be implemented without breaking the rounding rules, or a
>     negative errno if an error occurs.
>     Fabrice rightfully pointed out this to be surprised by this and
>     suggested to use at least a define for it.
>
>     I couldn't find a decision that I'm entirely happy with here. My
>     conflicts are:
>
>      - I want a constant that now and in the future only means "cannot be
>        done due to the rounding rules in the pwm framework". So the
>        options are:
>          * Introduce a new ESOMETHING and return -ESOMETHING
>            I think that's hard to motivate and also myself doubt this
>            would be sensible. As below, the question for a good name is
>            unresolved.
>          * return 1
>            This is what was done in the earlier revisions and also here.
>
>      - When keeping the return 1 semantics (and also for a new
>        ESOMETHING):
>        I agree that a name instead of a plain 1 would be nice, but I
>        couldn't come up with a name I liked. Given that this can be
>        introduced later without breaking anything, I don't consider that
>        very urgent.
>        My candidates were PWM_REQUIRES_BROKEN_ROUNDING,
>        PWM_REQUIRES_FORBIDDEN_ROUNDING and PWM_ERR_ROUNDING.
>        These are too long or/and imprecise.
>        If you have a good idea, please tell.

PWM_ERR_ROUNDING doesn't seem too bad.

What about something like PWM_REQ_INVALID, PWM_WF_INVALID, or 
PWM_WF_REQ_INVALID?

>
> Still I'd like to get that forward and (unless a new and relevant issue
> pops up until then) intend to put it into next after the next merge
> window. Nevertheless I'm open for suggestions to further improve this
> series.
>
> Best regards
> Uwe
>
> Uwe Kleine-König (7):
>    pwm: Add more locking
>    pwm: New abstraction for PWM waveforms
>    pwm: Provide new consumer API functions for waveforms
>    pwm: Add support for pwmchip devices for faster and easier userspace
>      access
>    pwm: Add tracing for waveform callbacks
>    pwm: axi-pwmgen: Implementation of the waveform callbacks
>    pwm: stm32: Implementation of the waveform callbacks
>
>   drivers/pwm/core.c           | 867 +++++++++++++++++++++++++++++++++--
>   drivers/pwm/pwm-axi-pwmgen.c | 154 +++++--
>   drivers/pwm/pwm-stm32.c      | 612 ++++++++++++++++---------
>   include/linux/pwm.h          |  58 ++-
>   include/trace/events/pwm.h   | 134 +++++-
>   include/uapi/linux/pwm.h     |  24 +
>   6 files changed, 1545 insertions(+), 304 deletions(-)
>   create mode 100644 include/uapi/linux/pwm.h
>
> base-commit: cf6631b07b907d4c644ca42f7cc234e7149290a2

