Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06BB403BD0
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Sep 2021 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349052AbhIHOzX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Sep 2021 10:55:23 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:54620
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233754AbhIHOzX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Sep 2021 10:55:23 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 757B13F333
        for <linux-pwm@vger.kernel.org>; Wed,  8 Sep 2021 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631112848;
        bh=PPEH7eqQppzchji3H/CDxGtbZIPHBFWweQotyEYpChs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=RiPJwjQBV26LOeE7WiTGZWvol75fpLqFZ28SJxfY6lYaPW77X28uY2sx98vWBJTFl
         jIrg3doA62OQ28es2v9HJjS9DIS99l4jNGXrhrddFlJNU/7L090bDs22YLrEkPHRyo
         639QiFQ7GnHze03Zr/iVedVMyISnr6K/iLR1lRwe+K3InvmmXC2IuqRFWJkF01BX3a
         PMlIAo2T6+W3Nt82AnnrISnAm0+pT1b8HhQXSRdvWorts0BFLHNRI7Ub+rVXD85KD0
         jWUOZ0uySEQf1+9S03qPGNv5G4rFQ8tU75dE2HsKaFaBbMr69l3cJgA/b7+fu7KRuW
         J31sEAVKifGSg==
Received: by mail-wr1-f71.google.com with SMTP id r11-20020a5d4e4b000000b001575c5ed4b4so587651wrt.4
        for <linux-pwm@vger.kernel.org>; Wed, 08 Sep 2021 07:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPEH7eqQppzchji3H/CDxGtbZIPHBFWweQotyEYpChs=;
        b=2l6PbYJ3MFY/huAsDolyl/onWaAGXHvYte5JLRjUbABlCq1mMu1fk/OMQOsFZ0AG80
         xSE49iRXGh7X4GjcSmdJGOhxZ1PDw1S+mVhXMcdB9FT1lQhG5l2M7ExYR3qBlGn9PcvX
         IFdyANeZbS5RxxWQAjIl2YZgos8ZC2rBVaJ2D3T8OnzE6ch9ZbaQZ/F6dfpXJsLWC8Eh
         eWhK2hB9V0GSOD0RrM1jtsD1RN4OWfBRIXm5m+PBwJwkNbWbQmjOOMOgHHf6qV3WZe4W
         X8jcAb9/mgG7Lmflxt7KxogTgqEgfqy2Hcf3/Hb/hHj9mQzq0fjPkE69Cpp/5m2S3zBs
         C/kQ==
X-Gm-Message-State: AOAM531nd7AhhPeJanwUBiedk9EUdFfOHtuRK+udYcQnSamH93ND3g7n
        h59an2GQdBikcaNTfq7xZ2s+fhRgXg+CKa7L5Ti/Ft+Kpq6zlT9SIo1RizCXS06BVCTGXFmp4tP
        UUEtRJ03BrJdxmKiRg4WZ4ZYXdkYk3PD6916K7w==
X-Received: by 2002:a1c:2c3:: with SMTP id 186mr4053979wmc.195.1631112846836;
        Wed, 08 Sep 2021 07:54:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8uHAI2kpSEQ7KV+8Ioobvjgq3WtjS4Yt3m49QKkDkaLq1kN95/M3vwIzAoxOGdwafenUd0A==
X-Received: by 2002:a1c:2c3:: with SMTP id 186mr4053960wmc.195.1631112846647;
        Wed, 08 Sep 2021 07:54:06 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.74])
        by smtp.gmail.com with ESMTPSA id d7sm2413103wrs.39.2021.09.08.07.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 07:54:06 -0700 (PDT)
Subject: Re: [PATCH] pwm: pwm-samsung: Trigger manual update when disabling
 PWM
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@axis.com
References: <20210908142708.14145-1-marten.lindahl@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <fc40e31d-16a2-33f3-1eb0-4af81fc27065@canonical.com>
Date:   Wed, 8 Sep 2021 16:54:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908142708.14145-1-marten.lindahl@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 08/09/2021 16:27, Mårten Lindahl wrote:
> When duty-cycle is at full level (100%), the TCNTn and TCMPn registers
> needs to be flushed in order to disable the signal. The PWM manual does
> not say anything about this, but states that only clearing the TCON
> auto-reload bit should be needed, and this seems to be true when the PWM
> duty-cycle is not at full level. This can be observed on an Axis
> ARTPEC-8, by running:
> 
>   echo <period> > pwm/period
>   echo <period> > pwm/duty_cycle
>   echo 1 > pwm/enable
>   echo 0 > pwm/enable
> 
> Since the TCNTn and TCMPn registers are activated when enabling the PWM
> (setting TCON auto-reload bit), and are not touched when disabling the
> PWM, the double buffered auto-reload function seems to be still active.
> Lowering duty-cycle, and restoring it again in between the enabling and
> disabling, makes the disable work since it triggers a reload of the
> TCNTn and TCMPn registers.
> 
> Fix this by securing a reload of the TCNTn and TCMPn registers when
> disabling the PWM and having a full duty-cycle.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
>  drivers/pwm/pwm-samsung.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> index f6c528f02d43..7d90652402a0 100644
> --- a/drivers/pwm/pwm-samsung.c
> +++ b/drivers/pwm/pwm-samsung.c
> @@ -105,6 +105,9 @@ struct samsung_pwm_chip {
>  static DEFINE_SPINLOCK(samsung_pwm_lock);
>  #endif
>  
> +static void __pwm_samsung_manual_update(struct samsung_pwm_chip *chip,
> +				      struct pwm_device *pwm);
> +
>  static inline
>  struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
>  {
> @@ -278,17 +281,21 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  	our_chip->disabled_mask |= BIT(pwm->hwpwm);
>  
> +	/*
> +	 * In case the PWM is at 100% duty cycle, force a manual
> +	 * update to prevent the signal from staying high.
> +	 */
> +	if (readl(our_chip->base + REG_TCMPB(pwm->hwpwm)) == (u32)-1U)
> +		__pwm_samsung_manual_update(our_chip, pwm);

I did not test it but looks reasonable. Just please move it above
setting "our_chip->disabled_mask", so the code will be close to
pwm_samsung_enable.


Best regards,
Krzysztof
