Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B701CE5F4
	for <lists+linux-pwm@lfdr.de>; Mon, 11 May 2020 22:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgEKUpd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 May 2020 16:45:33 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41203 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731636AbgEKUpc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 May 2020 16:45:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id 63so1339932oto.8;
        Mon, 11 May 2020 13:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8HYjnhh8Bu8XYDVDKIXasgsrQoeCjoEU/+GLZVp6VL4=;
        b=uXcM4p4xBbOwgs+INZ2/puw0lKenm4NLcwzj0XpH1V6Z2gLm87nl7V7ROaI7/zCg5L
         lQqvbe46Qr20HiPLrkrEt4+lDtkB+COd+1BZ27JPepw+e2POEXGxgA7dwcd7ZFfvJtB5
         8Mzg5TXhLNFNuU+E7rq1HCRrYWniPTnrQU3SeVodUfmO/qvp+RUDFwj/UNtNINXGbrE5
         S0s2bc2ec0OyLe04sWorBgVRXOm+viVoPj2YiJvWynfSdD3WuXhJGiDON+gVUHYW8FvL
         G4RTaPyLx/88r+CG/D6PJTlWMHysbk0us/T/zhYKT0hn1XzOtfr33w1kO03BPzzDSq0d
         uJfQ==
X-Gm-Message-State: AGi0Pualo8+1VHIsPCUPHX4SHJlUe/8Fv2PRkkiC5GHRCcneN/4Ii5i1
        OSy8EfNO9ZftsExpT9zdZg==
X-Google-Smtp-Source: APiQypKrHjG2YQsNuUzJ0MXv21zFdiAFCnjL4QWURbbEGJWV5Y68QNrIXfpv8r9brDsrOsEu41aYVA==
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr14284404otq.262.1589229931484;
        Mon, 11 May 2020 13:45:31 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n24sm263926otr.35.2020.05.11.13.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 13:45:30 -0700 (PDT)
Received: (nullmailer pid 14771 invoked by uid 1000);
        Mon, 11 May 2020 20:45:29 -0000
Date:   Mon, 11 May 2020 15:45:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 08/16] pwm: add support for sl28cpld PWM controller
Message-ID: <20200511204529.GA3518@bogus>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-9-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423174543.17161-9-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Apr 23, 2020 at 07:45:35PM +0200, Michael Walle wrote:
> This adds support for the PWM controller of the sl28cpld board
> management controller. This is part of a multi-function device driver.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-sl28cpld.c | 203 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 drivers/pwm/pwm-sl28cpld.c


> +static const struct of_device_id sl28cpld_pwm_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-pwm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_pwm_of_match);
> +
> +static const struct platform_device_id sl28cpld_pwm_id_table[] = {
> +	{"sl28cpld-gpio"},

copy-n-paste error?

> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_pwm_id_table);
> +
> +static struct platform_driver sl28cpld_pwm_driver = {
> +	.probe = sl28cpld_pwm_probe,
> +	.remove	= sl28cpld_pwm_remove,
> +	.id_table = sl28cpld_pwm_id_table,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = sl28cpld_pwm_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_pwm_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld PWM Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.20.1
> 
