Return-Path: <linux-pwm+bounces-3140-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7E596FBCA
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 21:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2010B284108
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD37155C98;
	Fri,  6 Sep 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="08A28jil"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F81C9DE7
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649583; cv=none; b=ZZ5tEl/o8s23uP++413e9l0IRgGY6EB53DVxngP6iYr7pRAK14ZBRAFMKFf7VEJYZrYv75NVb+7qtB59sra3Fq3rpYs5WcMfOM2b0ergn5QvKaFUnbWaYzWqcRuQzFmLiOrc8SU7831mOd6m42lGVNtVtQKOTGrTR4NDvR987B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649583; c=relaxed/simple;
	bh=X+OX1A8Q6OgV4SR6WwyW3nVha2u746YGuE81l2DdMdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+2qEDeVuc9t+6pWaaM6U4iPrN9zhSqU+FMUPEKNI6bRzIVLXbyPO/FILozFnaC0c/wnBuzcjHJE2Ok9VzUjS0cTXS3MqQNedHtwnlylVHyXcf7Xe/WY9HkEuCAyWOssg9lmA4k2S+H8qOIoEkOvtwldhyVZ/ToPD66Fl/U96jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=08A28jil; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70f79f75da6so1515213a34.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 12:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725649580; x=1726254380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRL0IOkPquaSmH/TxMcTrkn2lAb7RgDZ+KVgL/uKDo8=;
        b=08A28jilPARB13PmpusJH/FP0Z4EgYX7Hmb3KwkI20mJogR3zxl6G0e5MElVddW0pL
         vvoClMo24PfcCJqeOBu+ZEpGUUTB9XsrTF+Tm4qezsq1YpJaf0aFoNl4Bq+93u3e68AY
         Z6osRkEN4aNfyzhO7Q432032CGlNRS8jh52K8hjLVWZOYwwuTDpHfR8h1vG4/rbKAzro
         jfCSeipANRJULlRs0jVSSDDUvaHe99qRnKN5LlTtYoWayy/MJJM5CUweiT4FX7w/KajY
         Q3ozI2KDFdkAxmqYZiO/Y/qZ5ORs0mNa51e4fFnMh4BJrBfshJ7dDMwQMfzAYmUhQWz1
         P0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725649580; x=1726254380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRL0IOkPquaSmH/TxMcTrkn2lAb7RgDZ+KVgL/uKDo8=;
        b=GrNr2Ed3QUuMYnqsWA8endNSx+XAjuB13HQK0kBcov2GIELFRZdtkBCALpQtXJK6ui
         e5Ae8OfxsqevZvjB4cRJZ8yEu421TaR2MHaDpP8CM7AslaOCF2emCXqPMzL5wWkPYq0D
         Fdq4299sSLDVRvyAExOXOnhL2jRRIfpc5bVGY41+PQCCXkte8D+HfBFOWK8DpTdOFQ8p
         RvYzJZrySGAVaz1QbOoctxrVGKQd7vQEFzCGPtWTqQ0XWWXOcouYJzf8nWaWvDp5ziN2
         bLGw80moATNklkxT1z2m0mm86nhwoIsYM7f9fUVx3eDdwRMuRJCgZil9M0sQ96Pr0hVV
         hH9w==
X-Forwarded-Encrypted: i=1; AJvYcCWgdcFqVroHo6pAqWU+vcwYTjj0C/llwUM8CS+73ccUzYc17fy3M1zKLB03OHQeNn0Y0feriUakjbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbN6GxXdcvzpejPlw0uSmyD8cIQn+dEw5uq0dET6JY+PP9qEc
	qy2XkVM80ckhNeRsmbeaL0MwZ/h6ssBx5v3nOiuVq/mouMUbAxH1iw7VZ0JyahM=
X-Google-Smtp-Source: AGHT+IFMNu7CkzsCPaFKzf0VUQEiZwLzm4UrG2v/Np24ZK9LDshdqsK0810LAPAwttIC/hC3aaCcKQ==
X-Received: by 2002:a05:6830:6404:b0:709:3b06:d578 with SMTP id 46e09a7af769-710cc25c94amr4383633a34.26.1725649580418;
        Fri, 06 Sep 2024 12:06:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671ca4a0sm3783279a34.79.2024.09.06.12.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:06:20 -0700 (PDT)
Message-ID: <6e4b7ef4-19c7-477c-b753-d4d59ed38e3a@baylibre.com>
Date: Fri, 6 Sep 2024 14:06:18 -0500
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
 Trevor Gamblin <tgamblin@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com, Kent Gibson <warthog618@gmail.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/6/24 10:42 AM, Uwe Kleine-König wrote:
> Hello,
> 
> here comes v4 of the series to add support for duty offset in PWM
> waveforms. For a single PWM output there is no gain, but if you have a
> chip with two (or more) outputs and both operate with the same period,
> you can generate an output like:
> 
>                ______         ______         ______         ______
>    PWM #0  ___/      \_______/      \_______/      \_______/      \_______
>                  __             __             __             __
>    PWM #1  _____/  \___________/  \___________/  \___________/  \_________
>               ^              ^              ^              ^
> 

While working on an ADC driver that uses these new waveform APIs, we came
across a case where we wanted wf->duty_offset_ns >= wf->period_length_ns,
which is currently not allowed. [1]

                ______         ______         ______         ______
    PWM #0  ___/      \_______/      \_______/      \_______/      \_______
                               __             __             __
    PWM #1  __________________/  \___________/  \___________/  \___________
                            ^              ^              ^              

We worked around it by setting:

	wf->duty_offset_ns = DESIRED_NS % wf->period_length_ns

Having PWM #1 trigger too early just causes the first sample data
read to be invalid data.

But even if we allowed wf->duty_offset_ns >= wf->period_length_ns,
this offset wouldn't matter because there currently isn't a way to
enable two PWM outputs at exactly the same time.

In the ADC application we work around both of these shortcomings by not
enabling the DMA that is triggered by PWM #1 until after both PWMs are
enabled. However, there may be similar applications in the future that
also need such an offset and synchronized enable that might not be so
easy to work around, so something to keep in mind.

[1]: https://lore.kernel.org/linux-iio/20240904-ad7625_r1-v4-2-78bc7dfb2b35@baylibre.com/


> 
>  - The functions pwm_set_waveform_might_sleep() and
>    pwm_round_waveform_might_sleep() have an unusual return value
>    convention: They return 0 on success, 1 if the requested waveform
>    cannot be implemented without breaking the rounding rules, or a
>    negative errno if an error occurs.
>    Fabrice rightfully pointed out this to be surprised by this and
>    suggested to use at least a define for it.
> 
>    I couldn't find a decision that I'm entirely happy with here. My
>    conflicts are:
> 
>     - I want a constant that now and in the future only means "cannot be
>       done due to the rounding rules in the pwm framework". So the
>       options are:
>         * Introduce a new ESOMETHING and return -ESOMETHING
>           I think that's hard to motivate and also myself doubt this
>           would be sensible. As below, the question for a good name is
>           unresolved.
>         * return 1
>           This is what was done in the earlier revisions and also here.
> 
>     - When keeping the return 1 semantics (and also for a new
>       ESOMETHING):
>       I agree that a name instead of a plain 1 would be nice, but I
>       couldn't come up with a name I liked. Given that this can be
>       introduced later without breaking anything, I don't consider that
>       very urgent.
>       My candidates were PWM_REQUIRES_BROKEN_ROUNDING,
>       PWM_REQUIRES_FORBIDDEN_ROUNDING and PWM_ERR_ROUNDING.
>       These are too long or/and imprecise.
>       If you have a good idea, please tell.

To avoid using the return value for status flags, we could introduce
an optional output parameter. Consumers where best effort is good
enough can just pass NULL and consumers that care can pass an unsigned
int to receive the status flag. This could even be a bitmap of multiple
flags if it would be useful to know which rule(s) could not be met.


