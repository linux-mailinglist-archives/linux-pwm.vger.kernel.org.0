Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11F41EFFCA
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFESSE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 14:18:04 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:35417 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgFESSD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 14:18:03 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CB0A122FEB;
        Fri,  5 Jun 2020 20:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591381080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZQrvFc+JfRqJrBZHhTycEUPJ1czO+KGCEWzplfdwq6c=;
        b=vTxrPVq7pwVzE9K+7xVF8maUzd1Hx1QtGuBVG62RAkkKjnyiRqh+YnQ+r4CAiE/XqWFkXn
        jHE8MEGzEv3DgzZGP8Tonrvze71RaVmch6aNEnZwsBRYAEylZ3cCVe+s7C2uVzXtps72J8
        0KLiMnUZz6+snc/Vk6MWgY9lmuzGKCY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 05 Jun 2020 20:17:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 05/11] pwm: add support for sl28cpld PWM controller
In-Reply-To: <20200605084915.GE3714@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-6-michael@walle.cc> <20200605084915.GE3714@dell>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <b3324f5c1c908edc89a9cd2676644dfe@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-05 10:49, schrieb Lee Jones:
[..]
>> +static inline struct sl28cpld_pwm *to_sl28cpld_pwm(struct pwm_chip 
>> *chip)
>> +{
>> +	return container_of(chip, struct sl28cpld_pwm, pwm_chip);
>> +}
> 
> Why not save yourself the trouble and just:
> 
>   struct sl28cpld_pwm *pwm = dev_get_drvdata(chip->dev);

Is there a reason why not a single pwm driver uses something like that?

-michael
