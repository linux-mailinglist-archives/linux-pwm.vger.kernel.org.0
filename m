Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B113725A8F9
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Sep 2020 11:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIBJyJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Sep 2020 05:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBJyH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Sep 2020 05:54:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490F1C061244
        for <linux-pwm@vger.kernel.org>; Wed,  2 Sep 2020 02:54:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q9so3762962wmj.2
        for <linux-pwm@vger.kernel.org>; Wed, 02 Sep 2020 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M8TcxUyh3FwDr1kvEIkJvkbvWI5FAt8CTFrE3ll+7dc=;
        b=Yhqz5khIb730Hw/NZPk0CzwgE1uf+OzLd3XnuJ/A5Nd4t14o+2zuEeAM7oI3IWojWj
         s/J32VPnBjf/1Q7yqUNT+EiSREHO9JXevgzinGyMCZKDAYgELrM4nSCvrt5FVHI33p+2
         342y8/XYe1v6exWPjhdEq/0ndzwQLVE+FMQXcBCkuFXBeOUGZ6LFH1oGRCrtbyXnKRZQ
         Mk43GSfd3auCbXq2gEcROtjQWzH0FGYonOqTFCzBV+PBrl61SqEkT6xRiuXOwzLfsoWb
         RO/V4MTKBmoKLqZYGT2kgw55ZqObWM+P45RBzXoapFpsvabMbX3VqUTxyrbqq42f8g64
         t6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M8TcxUyh3FwDr1kvEIkJvkbvWI5FAt8CTFrE3ll+7dc=;
        b=R1uqLNy1oPVgss0VaB8zxo2nxA0zxc+b3z59oAu2bkUTzLvz9wAbZFqVYTui1XRlM8
         dwK97J/TTUzVcVicolGHdnjCMLWb0Tjpf374MaUAy26nb4hPfXqaBG27dXQfuom11jV7
         FfbNxvPdm4vI2ABraTnZo4Bg6D/O2UEpcsNIcj/ATCOtShOdGgoTrwm8WovS8iX4wlTy
         Vcv7jiEJfXYhHyh4+W17T8MEdnffUjKJGBDzjLbE8wA/tMqfe33PpNSPw4mZvguY7GZL
         MN90uOmIiKqKGf2s5KAqTKrpdodUg0YNMGMaVDWQHOdCtUl45TKL61E0cPOZb2OFZdgH
         Bt9g==
X-Gm-Message-State: AOAM53182p+QJ2X9HKfBGcD6PY0wIZmmC9ABVIaTeVEer907mVetG6/F
        N0Vn4pc833a5J4Xg3t5zsDnTWw==
X-Google-Smtp-Source: ABdhPJzidzZcJbtSblI1fVOA5IWxK7eDzxi7ZZLnT1lE/sVjG8wzghGcunr0siyIXU9SNK88ljnUiw==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr6252389wmh.21.1599040445433;
        Wed, 02 Sep 2020 02:54:05 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id j10sm6299078wrn.2.2020.09.02.02.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 02:54:04 -0700 (PDT)
Date:   Wed, 2 Sep 2020 10:54:02 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Andrey Lebedev <andrey@lebedev.lt>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: pwm-sun4i: PWM backlight is not turned off on shutdown
Message-ID: <20200902095402.pombrirqqjdew34b@holly.lan>
References: <ae58976c-a8d7-0d00-fe72-d21579b37240@lebedev.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae58976c-a8d7-0d00-fe72-d21579b37240@lebedev.lt>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 27, 2020 at 10:55:28PM +0300, Andrey Lebedev wrote:
> Hello,
> 
> I think I'm experiencing problem with pwm-sun4i module. I'll describe
> the symptoms first.
> 
> I have a device, based on Allwinner A20 (Cubieboard 2) with LVDS display
> that has a PWM-based backlight. The problem is: when linux shuts down,
> the backlight stays on. I expect it to be turned off. This used to work
> as expected on kernel 5.2-rc2, but after upgrade to 5.8 the backlight
> does not turn off anymore (most of the times, see below).
> 
> The backlight is configured in the device tree [1]. The brightness can
> be changed by writing to "brightness" file on sysfs. So, linux can
> control the PWM line. Backlight sysfs directory also has a "bl_power"
> file, which can accept "0" to power on or "4" to power off the backlight
> (according to [2]).
> 
> Now, writing "4" to bl_power sometimes turns the backlight off and
> sometimes not. I've found that the probability of backlight turning off
> pretty much correlates with the current screen brightness: on 100%
> brightness it will never turn off, on 50% brightness it will turn off on
> about half of the times. When backlight does not turn off, it goes on
> full brightness. It feels like the line, controlled by pwm stays in
> whatever state it was the moment backlight was powered down - either
> full 1 or 0.
> 
> The pwm backlight device driver (pwm_bl) requests to set the duty cycle
> to 0 and disable the pwm with the same request [3], but I suspect the
> implementation driver (pwm-sun4i) does not actually set the duty cycle
> to 0 before disabling the pulse width modulation.
> 
> Is there anything that can be done to fix this?

There's some rather odd logic in sun4i_pwm_apply() that results in the
PWM being disabled twice... once when it applies the initial config
and again after waiting for a duty_cycle.

I suspect disabling the initial disable would solve your issue... but it
might provoke some new ones!

Anyhow, try removing the else clause starting at line 299 and see what
happens:
https://elixir.bootlin.com/linux/v5.8/source/drivers/pwm/pwm-sun4i.c#L299


Daniel.
