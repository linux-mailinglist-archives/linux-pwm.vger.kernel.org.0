Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B983D0374
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jul 2021 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhGTUJ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Jul 2021 16:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbhGTTsA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Jul 2021 15:48:00 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4188DC061574;
        Tue, 20 Jul 2021 13:28:38 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C910982977;
        Tue, 20 Jul 2021 22:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1626812913;
        bh=d/oWvjB00i6oJ+9T3eKmMHhNOvRfGvUeewgfn+NNM08=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zEx9w1T7rocWXQVxb4y7WtBWlqCpZ/4cVKL+fYyLX9tzHAqPuVP8G3dvAV+awKcd+
         PbEgh6MvQJIzgJLcH5Py8+eE1i4hkW9ErydVmhmlOasodXYyVgMN/KYYpfbn2QW3Tk
         ky8Dit1JaQ8GoSvFHZEQl03eLHw4F0NzWJNSbC0yTFCv0YinUrIBpjLTQoa0bNTwZo
         XBC2GSQ1kbeLJwFsxb6HTURklLr3DoWAhm0lbacF7iagH/7pcisLT8MTbl7eoFG7wq
         e+NJH8mFka6FNQVIZvHexwLX8rd3UMonhKzGWIA/U9HMa8lmXRXyyqHqGcHusBJF9A
         NT2LsCVU/JL3g==
Subject: Re: [PATCH] backlight: pwm_bl: Avoid backlight flicker if backlight
 control GPIO is input
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org
References: <20210718211415.143709-1-marex@denx.de>
 <20210719112202.4fvmn57ibgy3yesa@maple.lan>
From:   Marek Vasut <marex@denx.de>
Message-ID: <bbaad78e-91c7-0787-fa72-b5cfabcc6dbd@denx.de>
Date:   Tue, 20 Jul 2021 22:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210719112202.4fvmn57ibgy3yesa@maple.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/19/21 1:22 PM, Daniel Thompson wrote:
> On Sun, Jul 18, 2021 at 11:14:15PM +0200, Marek Vasut wrote:
>> If the backlight enable GPIO is configured as input, the driver currently
>> unconditionally forces the GPIO to output-enable. This can cause backlight
>> flicker on boot e.g. in case the GPIO should not be enabled before the PWM
>> is configured and is correctly pulled low by external resistor.
>>
>> Fix this by extending the current check to differentiate between backlight
>> GPIO enable set as input and set as direction unknown. In case of input,
>> read the GPIO value to determine the pull resistor placement, set the GPIO
>> as output, and drive that exact value it was pulled to. In case of unknown
>> direction, retain previous behavior, that is set the GPIO as output-enable.
>>
>> Fixes: 3698d7e7d221 ("backlight: pwm_bl: Avoid backlight flicker when probed from DT")
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
>> Cc: Daniel Thompson <daniel.thompson@linaro.org>
>> Cc: Heiko Stuebner <heiko@sntech.de>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: Thierry Reding <treding@nvidia.com>
>> Cc: linux-pwm@vger.kernel.org
>> Cc: linux-fbdev@vger.kernel.org
>> To: dri-devel@lists.freedesktop.org
>> ---
>> NOTE: I think this whole auto-detection scheme should just be replaced by a
>>        DT prop, because it is very fragile.
> 
> I have some sympathy for this view... although I think the boat has
> already set sail.

I'm not sure that's correct, we can simply say that any new uses of the 
pwm-backlight should specify the initial GPIO configuration, and for the 
legacy ones, use whatever is in the code now.

> However, on the basis of making things less fragile, I think the
> underlying problem here is the assumption that it is safe to modify
> enable_gpio before the driver has imposed state upon the PWM (this
> assumption has always been made and, in addition to systems where the BL
> has a phandle will also risks flicker problems on systems where
> power_pwm_on_delay is not zero).

It is safe to modify the GPIO into defined state, but that defined state 
is not always out/enabled, that defined state depends on the hardware.

> This patch does not change the assumption that we can configure the
> GPIO before we modify the PWM state. This means it won't fix the problem
> for cases there the pin is HiZ by default but whose GPIOD_ASIS state is
> neither input nor output.

That is correct, for pin that is floating, we lost. But then I would 
argue that if your backlight-enable GPIO is floating, the hardware is 
buggy, I would expect some pull resistor to keep the backlight off on 
power on on that GPIO.

> I wonder if it might be better to move the code to configure the
> direction of enable_gpio out of the probe function and into
> pwm_backlight_power_on():

No, I tried that already.

The first thing that is called on boot is pwm_backlight_power_off() to 
set the backlight to 0 (and thus set pwm to 0), but since pb->enabled is 
false, that is where the function exits with configuring PWM and without 
configuring the GPIO state.

I also experimented with some "first time only" flag in those functions, 
but that looked ugly and complicated the runtime code.

> 	if (pb->enable_gpio) {
> 		if (gpiod_get_direction(pb->enable_gpio) != 0))
> 			gpiod_direction_output(pb->enable_gpio, 1);
> 		else
> 			gpiod_set_value_can_sleep(pb->enable_gpio, 1);
> 	}
> 
> By the time we reach this function the driver explicitly applies state
> to the GPIO then we know what the value must be.

See above, I don't think that's the best option.
