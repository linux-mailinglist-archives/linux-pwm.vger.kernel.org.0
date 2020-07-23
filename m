Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6384022B81F
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 22:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGWUur (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 16:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGWUur (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 16:50:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54483C0619D3;
        Thu, 23 Jul 2020 13:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hcFSk1zoqynrqfpyHJjn5KFl4stE+TWu+6kpqiKw4a8=; b=RMdgF5LZBJN+Q2JKXhCdwoq6MI
        lHC2E3mTeJpYN2Rfp8vqlq3CcjjTW9w9Lqa+Mex9mY+cL4F/NDFHzeEhHeJXM53PAmFrJhRDT+B2Z
        ZAV1n5cL9QhDIDkhTF3bs5a2lqKwOaNF51TGkgwc+S+f6B3lpqafkpoelpakn/LyMiovcEe1s8DF3
        vSLSnsO6oEbN/O0K2TTKBRPrQiWrNevficXi1Wu+Lny4ZAyKHDpBJCugQFc6DicufZU6gQ9/xRADX
        FutwXcbei2/Os6/NIExZMVOZ1Dm8BxC6wZ81ZTXfjme13xhewn6hIOZjqXXbAwwAIY2oFu7bw343r
        DbwQaxyA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyiAs-0003r8-ML; Thu, 23 Jul 2020 20:50:43 +0000
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
Cc:     Support Opensource <support.opensource@diasemi.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <cover.1595516501.git.Roy.Im@diasemi.com>
 <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <71818ab8-0020-77db-c412-8d35a541ead3@infradead.org>
Date:   Thu, 23 Jul 2020 13:50:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c13d812871b7f09205c1f04e95f5bdf07f307eaf.1595516501.git.Roy.Im@diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/23/20 8:01 AM, Roy Im wrote:
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 362e8a0..06dc5a3 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -869,4 +869,17 @@ config INPUT_STPMIC1_ONKEY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called stpmic1_onkey.
>  
> +config INPUT_DA7280_HAPTICS
> +	tristate "Dialog Semiconductor DA7280 haptics support"
> +	depends on INPUT && I2C
> +	select INPUT_FF_MEMLESS
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the Dialog DA7280 haptics driver.
> +	  The haptics can be controlled by I2C communication,
> +	  or by PWM input, or by GPI.

	  Is that                GPIO.
?

Can the haptics be controlled only by PWM or only by GPI(O)?

Just curious: why is I2C required to build the driver if a user is
only controlling the device by PWM or GPI?


> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da7280.
> +
>  endif

thanks.
-- 
~Randy

