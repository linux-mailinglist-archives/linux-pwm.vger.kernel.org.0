Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E602F92B3
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 14:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbhAQN6s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 08:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbhAQN6r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Jan 2021 08:58:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC497C061573;
        Sun, 17 Jan 2021 05:58:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id j18so289430wmi.3;
        Sun, 17 Jan 2021 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wlKj2unX4bd2wnXWL8XEV8g4DxbkxSu3MAe6w+eN7/Q=;
        b=HzKNiMu2kkSEbUCaz2ieWHyFCdL+dR5VX6M6Hzy4mu3WdNEE5BQC9AFOgMaPgOw7BH
         sAxcttrU6JuwzJ7nE5z5WofofZtVzOuxQXCuMBFZr56PGaxRoUnrEeLW7rPYxpNJp+jO
         ZL3Bda+86TbwKtFlYkIwP/GIfBOoteMePW7gKXID2C2scUUNv7Hfhzq6o5FbzNCu4SJv
         1NgF2AehvjEQhIliRy37kxEnF4QQMmyIPHRTnRXVww+nIEXelYETFG9TwhWOFrIo3EVa
         rfRCH00mWur/87U2IoSmOEhxZIv6zuhZKfHMONmLBFNYTFkC2IkB4Vnhu8Fr9zravcN5
         qzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wlKj2unX4bd2wnXWL8XEV8g4DxbkxSu3MAe6w+eN7/Q=;
        b=MpkvGCmmrcN4BHykj6nADYtZ0mkZqf0sBjnzsK5WzjiSKwB0xM7OtocLWY+e/IR4H/
         YMJIH/H6UFhRAZt41V5ZXERdLyN66Vzl7GvhXTs9kQeBhtc4QAsmp593387wNLs44R41
         mfAQhc/mZRP/c53/IOlTQ6gdq7E0iH2IVYXT41RgyqqSn+6DO6emrUXaBwyG/IM4e3Ml
         U2eXZivP2xEvPPdEQ+p8qnT8jKQlwmw/0u4hE5q7RFtcpEKgBXX5U/W1gV4qSZMY3pz2
         y0EODnJHsOL47PwYcU+eWa/LhpScZN/Dd1FFWvYhNnFVLf7R9OytaEzgPrExJTtaj9+3
         a/Tg==
X-Gm-Message-State: AOAM531HOeRu8KqG4zDkRrN64xWUqpqmKYVW00oToGuTx7Cv+gUBPc3K
        iEufVsvbK7rH2Eso9q24EhY=
X-Google-Smtp-Source: ABdhPJx2hDTspiYKuXGF2viFRRQFv+mcYQQ8DK9xaJMeuKRr5NkhvTRc9Zh0JrLzVeHsR1u4op+VPw==
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr14981445wmf.67.1610891885429;
        Sun, 17 Jan 2021 05:58:05 -0800 (PST)
Received: from einstein.dilieto.eu (smtp.dilieto.eu. [188.68.43.228])
        by smtp.gmail.com with ESMTPSA id z8sm22644233wrh.65.2021.01.17.05.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jan 2021 05:58:04 -0800 (PST)
Date:   Sun, 17 Jan 2021 14:58:03 +0100
From:   Nicola Di Lieto <nicola.dilieto@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: pwm-gpio: New driver
Message-ID: <20210117135803.gt2zgta5pv7o6t6t@einstein.dilieto.eu>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-2-nicola.dilieto@gmail.com>
 <20210117130434.663qpp6noujptdyt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210117130434.663qpp6noujptdyt@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

thanks for reviewing this.

On Sun, Jan 17, 2021 at 02:04:34PM +0100, Uwe Kleine-König wrote:
>Maybe only add the line for the binding doc in the second patch?

>I would have called this struct pwm_gpio_ddata. Given that pwm_gpio is
>the common prefix of all variables and functions in this driver,
>pwm_gpio alone is a bit short.

I will change these as suggested.

>Usually you want to check the return value of gpiod_set_value. @Linus +
>Bartosz: What do you think, does it need checking for an error here?

I will wait until they reply.

>> +
>> +	if (!atomic_read(&pwm_gpio->enabled))
>> +		return HRTIMER_NORESTART;
>> +
>> +	if (pwm_gpio->state) {
>> +		ns = pwm_gpio->cur.toff_ns;
>> +		pwm_gpio->state = false;
>> +	} else {
>> +		if (spin_trylock(&pwm_gpio->lock)) {
>> +			pwm_gpio->cur = pwm_gpio->new;
>> +			spin_unlock(&pwm_gpio->lock);
>> +		}
>> +		ns = pwm_gpio->cur.ton_ns;
>> +		pwm_gpio->state = true;
>> +	}
>> +	pwm_gpio->output = pwm_gpio->state ^ pwm_gpio->cur.invert;
>> +
>> +	schedule_work(&pwm_gpio->work);
>> +	hrtimer_forward(handle, hrtimer_get_expires(handle), ns_to_ktime(ns));
>
>This is hard to understand. I think we need more comments explaining
>(e.g.) the semantic of the members of struct pwm_gpio.

Would it be OK if I added the following comment in the code?

pwm_gpio_apply writes the new settings to pwm_gpio->new, synchronized by 
the spinlock. At the beginning of every PWM cycle pwm_gpio->new is 
copied into pwm_gpio->cur, but only if the spinlock can be locked 
immediately (meaning the settings aren't being applied concurrently to 
the beginning of the period).  By not waiting for the spinlock, no extra 
jitter in the PWM period is introduced.

>Does it make sense to use the workqueue only if the GPIO is a sleeping
>one and for fast GPIOs call gpiod_set_value directly?

I thought about this but didn't implement it as it seemed overkill to 
me.  The workqueue is needed anyway to cope with sleeping GPIOs, and it 
can deal with fast GPIOs with insignificant degradation compared to a 
direct implementation.

>> +static const struct pwm_ops pwm_gpio_ops = {
>> +	.free = pwm_gpio_free,
>
>A free without request seems wrong. The callback stops the PWM, this is
>wrong, the PWM should continue to toggle.
>

Would it be OK to remove the pwm_gpio_free callback altogether and move 
the cancel_work_sync() call to pwm_gpio_remove?

>Error message please if pwmchip_add fails

I will add this.

>> +}
>> +
>> +static int pwm_gpio_remove(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct pwm_gpio *pwm_gpio = platform_get_drvdata(pdev);
>> +
>> +	ret = pwmchip_remove(&pwm_gpio->chip);
>> +	if (ret)
>> +		return ret;
>
>This exit path is bad. The return value of the remove callback is
>ignored and after pwm_gpio_remove() returns the gpio and *pwm_gpio are
>freed.
>
>> +
>> +	hrtimer_cancel(&pwm_gpio->timer);
>> +
>> +	return 0;
>> +}

Would it be ok to cancel the timer first and then "return 
pwmchip_remove(...)"?

Best regards,
Nicola

