Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E6922BC29
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 04:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGXC4o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 22:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGXC4o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 22:56:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C4AC0619D3;
        Thu, 23 Jul 2020 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gIHSieEI/ICBzURiExKROzcBrLGuuEu7fSniuyclIJg=; b=A6lV4ZEVvGkxCKJPOGUxlk9s9B
        xREQAJqnoX7K22XrxYkYSJWN4M5FBq2cU3xSTBpBh3NzBJ9oz2XQTBgLDjev1S5r1VTjqrGAcMgMl
        E3XHJDPwh+XxJ1Nvs+ENCenmweZmgg59lHlB3ut+Gqr882Zo4zX7YWHFBjEVF9Iq4fk+uB6BuSqRV
        oke0s4Z1Gu3y86B1/HzPa1GBaS7qF7pxqWrSPS8CXLTPGllzniQjgIGfv8qi7WVfzuUYEHEDvCCTV
        PMOY0s//aX/GRAPnDZVcajmv2nBy+jOlRVZuQaDKmkuWI5abCYPskbxc8RsRrjQNGwUnxdoDZEb5d
        nMhU2w8w==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jynt0-00076g-Io; Fri, 24 Jul 2020 02:56:39 +0000
Subject: Re: [PATCH V17 3/3] Input: new da7280 haptic driver
To:     Roy Im <roy.im.opensource@diasemi.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
 <71818ab8-0020-77db-c412-8d35a541ead3@infradead.org>
 <DB8PR10MB343644A6DADE61D62BEE157C85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f549102d-4e69-c903-1672-f50bdb7994a3@infradead.org>
Date:   Thu, 23 Jul 2020 19:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DB8PR10MB343644A6DADE61D62BEE157C85770@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/23/20 6:54 PM, Roy Im wrote:
> On Fri, July 24, 2020 5:51 AM, Randy Dunlap wrote
>> On 7/23/20 8:01 AM, Roy Im wrote:
>>> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
>>> index 362e8a0..06dc5a3 100644
>>> --- a/drivers/input/misc/Kconfig
>>> +++ b/drivers/input/misc/Kconfig
>>> @@ -869,4 +869,17 @@ config INPUT_STPMIC1_ONKEY
>>>  	  To compile this driver as a module, choose M here: the
>>>  	  module will be called stpmic1_onkey.
>>>
>>> +config INPUT_DA7280_HAPTICS
>>> +	tristate "Dialog Semiconductor DA7280 haptics support"
>>> +	depends on INPUT && I2C
>>> +	select INPUT_FF_MEMLESS
>>> +	select REGMAP_I2C
>>> +	help
>>> +	  Say Y to enable support for the Dialog DA7280 haptics driver.
>>> +	  The haptics can be controlled by I2C communication,
>>> +	  or by PWM input, or by GPI.
>>
>> 	  Is that                GPIO.
>> ?
> The Haptics can be working by GPI(if see from the haptic device), but from the Host it is GPO. Do you think the GPIO is correct?

To me it needs to represent what services/interfaces/facilities are used by this driver that are
provided by the Linux kernel.  If it uses Linux GPIO services, then it should say GPIO --
although I don't see it using any Linux GPIO services.

>>
>> Can the haptics be controlled only by PWM or only by GPI(O)?
>>
>> Just curious: why is I2C required to build the driver if a user is only controlling the device by PWM or GPI?
> 
> I2C is required to control registers and it can be triggered by I2C or PWM or GPI(controlled by host outside this driver), so PWM and GPI are optional.
> With your comments, I think it's better to remove below lines(//remove) to avoid confusion and add PWM as below if you agree.
>          // remove
> 	  The haptics can be controlled by I2C communication,
> 	  or by PWM input, or by GPI.
>          // update, adding || PWM
>          depends on (INPUT && I2C) || PWM

Since <linux/pwm.h> provides stubs for when CONFIG_PWM is not enabled,
it appears that "depends on  PWM" is not required.

I'll leave it up to you. I was just trying to understand better.
It may be that no changes are needed.


thanks.
-- 
~Randy

