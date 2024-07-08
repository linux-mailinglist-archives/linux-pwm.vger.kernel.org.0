Return-Path: <linux-pwm+bounces-2735-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A638B92A8CE
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 20:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CBE1F21D80
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A0148FED;
	Mon,  8 Jul 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mknpea0e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6161474A8
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 18:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462456; cv=none; b=iPlENlHjUlERMBEmh98t0QsbMKoq6ePe+4MQPR1v56desSTT1UlQXcSta/YrA0CLiBBQcjiJJIRxeAeLHfoIIQyaOdNstkxR0Wbdy0Nq/+poU3PyV8FMhv3Dg5Fk3uzoN24fIc3F9DDJYb3q1v05KW4i21jrhm6AJCwCKnu5Z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462456; c=relaxed/simple;
	bh=XAqz2SfnWdOhnU654TXwOKtbz5OL0iwlbhXCXRKca98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2atwtAAJO5eLnkFQFSib3rdFr4hWxdt24mekpp9VNZ37J5YO/l/pv1ot5ZtZhgXa4gnz2jmRqNbuaLVg22Bp4N7p3wNPjgPltHI6yxlfxLYyUB44X18fmLmAQnsw+0xh5djHikDso0lYSBMLpJ1wyxIGGTGHfqUUgct32Tz7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mknpea0e; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d853e31de8so2445976b6e.2
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720462452; x=1721067252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcJtxONO8DFrSfBKeeoipPW1tITMccUV/k01FLaxFTU=;
        b=mknpea0e0XnIyv99rmYK3UfN8YNeBs8YF3MqC0jSkzYuuWU1TH16s3prPVCSfSZ2fC
         cFUPeW+DRxsNF32dSuUY3ikPVkAtdIq/s+tGdNrbNaVbHgMtJ39hgs3h1B6hAgeodOze
         h95FJN3AYsux1FAEFo/Qp2yju6Zszj8Yo6FLBuwPdCj9kFzjaizlVp7yjOzZaBHHgGkR
         37WGv5ITYwQUL/DvmT8H/voIxKvbBwJbJ7FbJ1ZFrXPbqXIdKiRZF7UZIVX/74JuEVZC
         VhpP3eJRpsR8XGkROeSpkNJj//UxXgaTDMaX6+WG4M79nWjpSR+zwWrdPIn0Uv4gbhIX
         Ra5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462452; x=1721067252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcJtxONO8DFrSfBKeeoipPW1tITMccUV/k01FLaxFTU=;
        b=adMx3Nnftfme0LR6FBTI3L9hX6Cnd3QanVRLBbYOk9AFxl/Pe0/2VdHDwLL/rWbOWV
         RRCKISZEby+glkYGTOjfICcJwXPj1yQodVnPAU9v0dOVnIvTp1ZmnNTDl7KvJcCEKOzR
         6MywQVSsQgtMx3jRU83NMtFKxsPxkp8KkH5TOyBMmzBQuiUa2K0U8K4Hi0w5uz9X0fh+
         12zCgl4cjJEWBOfWfDan8qh/7+Ptk1oQ7ngrAQQjKEOluwtcMtevxLVECUvxWZdz+yVE
         Y/PSkBqo0bUPa2CtoicJQrqoEdR0HOIzJKpwen8sgZzRswidUfGqmI2Q1Mf7bd5r0aZG
         dAEw==
X-Forwarded-Encrypted: i=1; AJvYcCW2gHDz2DWcHYmG8WrIWAkAPifwXvgiKvH7/VkJKqhaqiWfrGDKqJgzPjDdnojPg1eE4ohkAImRHDkBfe4dEHVeFlA7uVAqil0Y
X-Gm-Message-State: AOJu0YxMOPOkYlz0aFbdH1VhVjVDb1PPAJcWI6m05ysBWH0Nguovndbu
	1lg0h8xvErLM/hyxBoGGWYWw4kIpnlkNCg6VwWwJstvs2Uo6h/A6XNVubugCYKk=
X-Google-Smtp-Source: AGHT+IHscVPZ0Pz+DS3pViZY6Kwa7+MgqVJz3MCO6Vk3uY4qysj8Cy9+sYheMm44kR7SiPc3myRIDw==
X-Received: by 2002:a05:6808:1312:b0:3d9:24b1:74ae with SMTP id 5614622812f47-3d93c041072mr229408b6e.23.1720462450612;
        Mon, 08 Jul 2024 11:14:10 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9bd2649sm1809081cf.68.2024.07.08.11.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 11:14:10 -0700 (PDT)
Message-ID: <c12fe2f2-404b-454a-8474-0020a4aaafb6@baylibre.com>
Date: Mon, 8 Jul 2024 14:14:09 -0400
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] pwm: Add tracing for waveform callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <7f7ce46efc76e02a472ed52ab1fc06c3575a14e8.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <7f7ce46efc76e02a472ed52ab1fc06c3575a14e8.1720435656.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Missing a sign-off?

On 2024-07-08 6:52 a.m., Uwe Kleine-König wrote:
> ---
>   drivers/pwm/core.c         |  68 ++++++++++++++++---
>   include/trace/events/pwm.h | 134 ++++++++++++++++++++++++++++++++++---
>   2 files changed, 183 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index d64c033c4cb2..a2320ae77220 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -138,6 +138,52 @@ static int pwm_check_rounding(const struct pwm_waveform *wf,
>   	return 0;
>   }
>   
> +static int pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm,
> +				   const struct pwm_waveform *wf, void *wfhw)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +	int ret;
> +
> +	ret = ops->round_waveform_tohw(chip, pwm, wf, wfhw);
> +	trace_pwm_round_waveform_tohw(pwm, wf, wfhw, ret);
> +
> +	return ret;
> +}
> +
> +static int pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
> +				     const void *wfhw, struct pwm_waveform *wf)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +	int ret;
> +
> +	ret = ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
> +	trace_pwm_round_waveform_fromhw(pwm, wfhw, wf, ret);
> +
> +	return ret;
> +}
> +
> +static int pwm_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm, void *wfhw)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +	int ret;
> +
> +	ret = ops->read_waveform(chip, pwm, wfhw);
> +	trace_pwm_read_waveform(pwm, wfhw, ret);
> +
> +	return ret;
> +}
> +
> +static int pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, const void *wfhw)
> +{
> +	const struct pwm_ops *ops = chip->ops;
> +	int ret;
> +
> +	ret = ops->write_waveform(chip, pwm, wfhw);
> +	trace_pwm_write_waveform(pwm, wfhw, ret);
> +
> +	return ret;
> +}
> +
>   #define WFHWSIZE 20
>   
>   static int pwm_get_waveform(struct pwm_device *pwm,
> @@ -155,11 +201,11 @@ static int pwm_get_waveform(struct pwm_device *pwm,
>   	if (!chip->operational)
>   		return -ENODEV;
>   
> -	err = ops->read_waveform(chip, pwm, &wfhw);
> +	err = pwm_read_waveform(chip, pwm, &wfhw);
>   	if (err)
>   		return err;
>   
> -	return ops->round_waveform_fromhw(chip, pwm, &wfhw, wf);
> +	return pwm_round_waveform_fromhw(chip, pwm, &wfhw, wf);
>   }
>   
>   /* Called with the pwmchip lock held */
> @@ -180,12 +226,12 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
>   	     wf->duty_offset >= wf->period_length))
>   		return -EINVAL;
>   
> -	err = ops->round_waveform_tohw(chip, pwm, wf, &wfhw);
> +	err = pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
>   	if (err)
>   		return err;
>   
>   	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length) {
> -		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
> +		err = pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
>   		if (err)
>   			return err;
>   
> @@ -203,7 +249,7 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
>   		}
>   	}
>   
> -	err = ops->write_waveform(chip, pwm, &wfhw);
> +	err = pwm_write_waveform(chip, pwm, &wfhw);
>   	if (err)
>   		return err;
>   
> @@ -213,12 +259,12 @@ static int __pwm_set_waveform(struct pwm_device *pwm,
>   	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ops->read_waveform && wf->period_length) {
>   		struct pwm_waveform wf_set;
>   
> -		err = ops->read_waveform(chip, pwm, &wfhw);
> +		err = pwm_read_waveform(chip, pwm, &wfhw);
>   		if (err)
>   			/* maybe ignore? */
>   			return err;
>   
> -		err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
> +		err = pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
>   		if (err)
>   			/* maybe ignore? */
>   			return err;
> @@ -443,11 +489,11 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
>   		 * high.
>   		 */
>   
> -		err = ops->round_waveform_tohw(chip, pwm, &wf, &wfhw);
> +		err = pwm_round_waveform_tohw(chip, pwm, &wf, &wfhw);
>   		if (err)
>   			return err;
>   
> -		err = ops->write_waveform(chip, pwm, &wfhw);
> +		err = pwm_write_waveform(chip, pwm, &wfhw);
>   		if (err)
>   			return err;
>   
> @@ -548,11 +594,11 @@ static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>   
>   		scoped_guard(pwmchip, chip) {
>   
> -			ret = ops->read_waveform(chip, pwm, &wfhw);
> +			ret = pwm_read_waveform(chip, pwm, &wfhw);
>   			if (ret)
>   				return ret;
>   
> -			ret = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf);
> +			ret = pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
>   			if (ret)
>   				return ret;
>   		}
> diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
> index 8022701c446d..3b5b20d2aff0 100644
> --- a/include/trace/events/pwm.h
> +++ b/include/trace/events/pwm.h
> @@ -8,15 +8,135 @@
>   #include <linux/pwm.h>
>   #include <linux/tracepoint.h>
>   
> +#define TP_PROTO_pwm(args...)							\
> +	TP_PROTO(struct pwm_device *pwm, args)
> +
> +#define TP_ARGS_pwm(args...)							\
> +	TP_ARGS(pwm, args)
> +
> +#define TP_STRUCT__entry_pwm(args...)						\
> +	TP_STRUCT__entry(							\
> +		__field(unsigned int, chipid)					\
> +		__field(unsigned int, hwpwm)					\
> +		args)
> +
> +#define TP_fast_assign_pwm(args...)						\
> +	TP_fast_assign(								\
> +		__entry->chipid = pwm->chip->id;				\
> +		__entry->hwpwm = pwm->hwpwm;					\
> +		args)
> +
> +#define TP_printk_pwm(fmt, args...)						\
> +	TP_printk("pwmchip%u.%u: " fmt, __entry->chipid, __entry->hwpwm, args)
> +
> +#define __field_pwmwf(wf)							\
> +	__field(u64, wf ## _period_length)					\
> +	__field(u64, wf ## _duty_length)					\
> +	__field(u64, wf ## _duty_offset)					\
> +
> +#define fast_assign_pwmwf(wf)							\
> +	__entry->wf ## _period_length = wf->period_length;			\
> +	__entry->wf ## _duty_length = wf->duty_length;				\
> +	__entry->wf ## _duty_offset = wf->duty_offset
> +
> +#define printk_pwmwf_format(wf)							\
> +	"%lld/%lld [+%lld]"
> +
> +#define printk_pwmwf_formatargs(wf)						\
> +	__entry->wf ## _duty_length, __entry->wf ## _period_length, __entry->wf ## _duty_offset
> +
> +TRACE_EVENT(pwm_round_waveform_tohw,
> +
> +	TP_PROTO_pwm(const struct pwm_waveform *wf, void *wfhw, int err),
> +
> +	TP_ARGS_pwm(wf, wfhw, err),
> +
> +	TP_STRUCT__entry_pwm(
> +		__field_pwmwf(wf)
> +		__field(void *, wfhw)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign_pwm(
> +		fast_assign_pwmwf(wf);
> +		__entry->wfhw = wfhw;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk_pwm(printk_pwmwf_format(wf) " > %p err=%d",
> +		printk_pwmwf_formatargs(wf), __entry->wfhw, __entry->err)
> +);
> +
> +TRACE_EVENT(pwm_round_waveform_fromhw,
> +
> +	TP_PROTO_pwm(const void *wfhw, struct pwm_waveform *wf, int err),
> +
> +	TP_ARGS_pwm(wfhw, wf, err),
> +
> +	TP_STRUCT__entry_pwm(
> +		__field(const void *, wfhw)
> +		__field_pwmwf(wf)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign_pwm(
> +		__entry->wfhw = wfhw;
> +		fast_assign_pwmwf(wf);
> +		__entry->err = err;
> +	),
> +
> +	TP_printk_pwm("%p > " printk_pwmwf_format(wf) " err=%d",
> +		__entry->wfhw, printk_pwmwf_formatargs(wf), __entry->err)
> +);
> +
> +TRACE_EVENT(pwm_read_waveform,
> +
> +	TP_PROTO_pwm(void *wfhw, int err),
> +
> +	TP_ARGS_pwm(wfhw, err),
> +
> +	TP_STRUCT__entry_pwm(
> +		__field(void *, wfhw)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign_pwm(
> +		__entry->wfhw = wfhw;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk_pwm("%p err=%d",
> +		__entry->wfhw, __entry->err)
> +);
> +
> +TRACE_EVENT(pwm_write_waveform,
> +
> +	TP_PROTO_pwm(const void *wfhw, int err),
> +
> +	TP_ARGS_pwm(wfhw, err),
> +
> +	TP_STRUCT__entry_pwm(
> +		__field(const void *, wfhw)
> +		__field(int, err)
> +	),
> +
> +	TP_fast_assign_pwm(
> +		__entry->wfhw = wfhw;
> +		__entry->err = err;
> +	),
> +
> +	TP_printk_pwm("%p err=%d",
> +		__entry->wfhw, __entry->err)
> +);
> +
> +
>   DECLARE_EVENT_CLASS(pwm,
>   
>   	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int err),
>   
>   	TP_ARGS(pwm, state, err),
>   
> -	TP_STRUCT__entry(
> -		__field(unsigned int, chipid)
> -		__field(unsigned int, hwpwm)
> +	TP_STRUCT__entry_pwm(
>   		__field(u64, period)
>   		__field(u64, duty_cycle)
>   		__field(enum pwm_polarity, polarity)
> @@ -24,9 +144,7 @@ DECLARE_EVENT_CLASS(pwm,
>   		__field(int, err)
>   	),
>   
> -	TP_fast_assign(
> -		__entry->chipid = pwm->chip->id;
> -		__entry->hwpwm = pwm->hwpwm;
> +	TP_fast_assign_pwm(
>   		__entry->period = state->period;
>   		__entry->duty_cycle = state->duty_cycle;
>   		__entry->polarity = state->polarity;
> @@ -34,8 +152,8 @@ DECLARE_EVENT_CLASS(pwm,
>   		__entry->err = err;
>   	),
>   
> -	TP_printk("pwmchip%u.%u: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
> -		  __entry->chipid, __entry->hwpwm, __entry->period, __entry->duty_cycle,
> +	TP_printk_pwm("period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
> +		  __entry->period, __entry->duty_cycle,
>   		  __entry->polarity, __entry->enabled, __entry->err)
>   
>   );

