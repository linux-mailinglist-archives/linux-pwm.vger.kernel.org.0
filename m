Return-Path: <linux-pwm+bounces-2936-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71421941406
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE971C20128
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDDC1A08CA;
	Tue, 30 Jul 2024 14:12:16 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E819F499;
	Tue, 30 Jul 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348736; cv=none; b=p/C5zKg5nCzqKPmGQYsjxr/JdnvvmZY4WRkI9NE71IRa0yi8l+Z0Ubirk92URDsa3tiQ8XmGioF8xaqc8c39yrw9J5ITuus5ZdxnQv8Ca+I/InCbGU2022DX/j1KBQCxrzCuud8U95B5eoUl+GOh2WHcKQgjGaMgeDSKCSm8E3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348736; c=relaxed/simple;
	bh=EIyDO6moySu65v83gDl+oNa2dyM42z0e1qjHWoEuFsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrXVH+40uYxeTetcPFq2bezVO6G1zfEahuxolQdHqu9tcr87vPa0EplCJLm9k0JWKCLt2XGUezrplvCXgnEOvm8lZgPbZG/ntvS/KnKX/D3xcSfCDEK473LRx22kweml/YTLRWA0bKO9i95fdBbg5fR3KRfOTVA5XIplPJy7hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F37C32782;
	Tue, 30 Jul 2024 14:12:14 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:12:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-pwm@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v3 6/8] pwm: Add tracing for waveform callbacks
Message-ID: <20240730101246.5fef41fb@gandalf.local.home>
In-Reply-To: <7b9c9ee490df1df1de3bbfafd501f45c6cb2ec4c.1722261050.git.u.kleine-koenig@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
	<7b9c9ee490df1df1de3bbfafd501f45c6cb2ec4c.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jul 2024 16:34:22 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
> index 8022701c446d..8ba898fd335c 100644
> --- a/include/trace/events/pwm.h
> +++ b/include/trace/events/pwm.h
> @@ -8,15 +8,135 @@
>  #include <linux/pwm.h>
>  #include <linux/tracepoint.h>
> =20
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
> +		__entry->chipid =3D pwm->chip->id;				\
> +		__entry->hwpwm =3D pwm->hwpwm;					\
> +		args)
> +
> +#define TP_printk_pwm(fmt, args...)						\
> +	TP_printk("pwmchip%u.%u: " fmt, __entry->chipid, __entry->hwpwm, args)
> +
> +#define __field_pwmwf(wf)							\
> +	__field(u64, wf ## _period_length_ns)					\
> +	__field(u64, wf ## _duty_length_ns)					\
> +	__field(u64, wf ## _duty_offset_ns)					\
> +
> +#define fast_assign_pwmwf(wf)							\
> +	__entry->wf ## _period_length_ns =3D wf->period_length_ns;		\
> +	__entry->wf ## _duty_length_ns =3D wf->duty_length_ns;			\
> +	__entry->wf ## _duty_offset_ns =3D wf->duty_offset_ns
> +
> +#define printk_pwmwf_format(wf)							\
> +	"%lld/%lld [+%lld]"
> +
> +#define printk_pwmwf_formatargs(wf)						\
> +	__entry->wf ## _duty_length_ns, __entry->wf ## _period_length_ns, __ent=
ry->wf ## _duty_offset_ns
> +

The above is interesting. But if it works for you, then you do you ;-)

-- Steve


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
> +		__entry->wfhw =3D wfhw;
> +		__entry->err =3D err;
> +	),
> +
> +	TP_printk_pwm(printk_pwmwf_format(wf) " > %p err=3D%d",
> +		printk_pwmwf_formatargs(wf), __entry->wfhw, __entry->err)
> +);
> +

