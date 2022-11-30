Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7198063E1C0
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Nov 2022 21:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiK3UUO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 30 Nov 2022 15:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiK3UTs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Nov 2022 15:19:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B3975D3
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 12:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD79D61DBD
        for <linux-pwm@vger.kernel.org>; Wed, 30 Nov 2022 20:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CAAC433D6;
        Wed, 30 Nov 2022 20:15:14 +0000 (UTC)
Date:   Wed, 30 Nov 2022 15:15:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 02/11] pwm/tracing: Also record trace events for
 failed API calls
Message-ID: <20221130151511.7f0d4fa3@gandalf.local.home>
In-Reply-To: <20221130152148.2769768-3-u.kleine-koenig@pengutronix.de>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
        <20221130152148.2769768-3-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 30 Nov 2022 16:21:39 +0100
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
> index cf243de41cc8..12b35e4ff917 100644
> --- a/include/trace/events/pwm.h
> +++ b/include/trace/events/pwm.h
> @@ -10,9 +10,9 @@
>  
>  DECLARE_EVENT_CLASS(pwm,
>  
> -	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
> +	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int err),
>  
> -	TP_ARGS(pwm, state),
> +	TP_ARGS(pwm, state, err),
>  
>  	TP_STRUCT__entry(
>  		__field(struct pwm_device *, pwm)
> @@ -20,6 +20,7 @@ DECLARE_EVENT_CLASS(pwm,
>  		__field(u64, duty_cycle)
>  		__field(enum pwm_polarity, polarity)
>  		__field(bool, enabled)
> +		__field(int, err)
>  	),

If you are changing this, perhaps order it a bit like:

        TP_STRUCT__entry(
                __field(u64, period)
                __field(u64, duty_cycle)
                __field(struct pwm_device *, pwm)
                __field(enum pwm_polarity, polarity)
                __field(bool, enabled)
		__field(int, err)
        ),

And that way the struct pwm_device pointer will not cause a 4 byte hole on
32bit architectures.

>  
>  	TP_fast_assign(
> @@ -28,28 +29,27 @@ DECLARE_EVENT_CLASS(pwm,
>  		__entry->duty_cycle = state->duty_cycle;
>  		__entry->polarity = state->polarity;
>  		__entry->enabled = state->enabled;
> +		__entry->err = err;
>  	),
>  
> -	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d",
> +	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
>  		  __entry->pwm, __entry->period, __entry->duty_cycle,
> -		  __entry->polarity, __entry->enabled)
> +		  __entry->polarity, __entry->enabled, __entry->err)

Hmm, and why not show the values here:

TRACE_DEFINE_ENUM(PWM_POLARITY_NORMAL);
TRACE_DEFINE_ENUM(PWM_POLARITY_INVERSED);

	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%s enabled=%d err=%d",
 		  __entry->pwm, __entry->period, __entry->duty_cycle,
		  __print_symbolic(__entry->polarity,
			{PWM_POLARITY_NORMAL, "normal"},
			{PWM_POLARITY_INVERSED, "inversed"}),
			__entry->enabled, __entry->err)


-- Steve

>  
>  );
