Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD020EBE0
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2020 05:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgF3DOF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jun 2020 23:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgF3DOE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jun 2020 23:14:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD742C061755;
        Mon, 29 Jun 2020 20:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=DTz5nZ2U2vWrhMxB2tZISkXyFSv2s5nmvlXXxcC25tA=; b=FR0SZP0y+XdblDdVeC0FOLt4ij
        KClSdfMcFcTiIifhgmYA8qZUXemTwAXHLhCRZ8qjypY+ecDQTZ3ekBViMx1dJZJeHqSQZitc2Mded
        K6AH64qA12pGKx5nKLWaQrHvi96ShySY1VVti8yYZokVyvwxngSatDbK5YAGdBc0w/h4Iwcq/hFpS
        1pc2Z3fzYnk1a5OSztWpnfq7CUAEA8pRFMY1vCHNuVDrWLuqH0KuIY2Kd6kgGSQMEZ7FBacUkFXzH
        fJpmT/4eQKpA+QWmSdFo8B2kToT6Ds0XSU7p4w9jexM58ZVPzcQd7X57V90bAgqSqrhzPbcu2AVxw
        VE0k4RFg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jq6iY-00008H-TB; Tue, 30 Jun 2020 03:13:56 +0000
Subject: Re: [PATCH v15 3/3] Input: new da7280 haptic driver
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
References: <cover.1593435662.git.Roy.Im@diasemi.com>
 <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <602a5743-d27b-3e81-e917-d343f58d35e9@infradead.org>
Date:   Mon, 29 Jun 2020 20:13:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c7b8cb993abe7bb771108bb94e5d9edbeb4f7103.1593435662.git.Roy.Im@diasemi.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Roy,


On 6/29/20 6:01 AM, Roy Im wrote:
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 362e8a0..79fbddb 100644
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
> +	  The haptics can be controlled by i2c communication,

If you make any more updates, make this:   I2C communication,
please.

> +	  or by PWM input, or by GPI.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called da7280.
> +
>  endif

thanks.
-- 
~Randy

