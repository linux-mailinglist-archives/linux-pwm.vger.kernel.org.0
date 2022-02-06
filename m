Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A00D4AAE8A
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Feb 2022 10:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbiBFJZh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 6 Feb 2022 04:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiBFJZh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 6 Feb 2022 04:25:37 -0500
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 01:25:36 PST
Received: from mail.schwermer.no (mail.schwermer.no [49.12.228.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAE1C06173B;
        Sun,  6 Feb 2022 01:25:36 -0800 (PST)
Message-ID: <20f95cfd-a851-af4f-1c60-45f2ca238e10@svenschwermer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=svenschwermer.de;
        s=mail; t=1644139072;
        bh=wx9jXfQkpX2qiu62RfHuY8OkrDmcTGVyOARl1nXmt54=;
        h=Subject:To:Cc:References:From:In-Reply-To;
        b=h/yQco5Eg7EF/lfhW6KxQq2zt31ZAQvu3P0Mr7SyrrHL+F/0uMuY4aANB6QL0BHAj
         Qn13hkT8XnMMk2p6781Zdb3xO8wC64EOx8rYqrio+mCJz8kP0/tCdenn/F+abIBtfC
         QI/zzsUUC3YhlSewHc/F3K/P5Rb4rtEmyXcJK0JyCtWLkBoBw8OB1IAzrhrd7EBesU
         CDXn88RxqqTrVksSR61uewCJ5ov4Y+XSgGaEOXQFJxMT8vG6zhK/OoDr9MZ+qDRe9p
         oHUI9ofMPAmO1RjpW+l3v4moCEY3S9LfFZT18LSvds7LLeniblFbLBPR7JKqdD6sDL
         CrRrOT0gyWipg==
Date:   Sun, 6 Feb 2022 10:17:51 +0100
Mime-Version: 1.0
Subject: Re: [PATCH v3 2/2] leds: Add PWM multicolor driver
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>, post@lespocky.de
References: <20220126104844.246068-1-sven@svenschwermer.de>
 <20220126104844.246068-3-sven@svenschwermer.de>
 <CAHp75VfMTCvgib__PhnfB_g7xLhyNws5TDRyMVyzuAkT1ydY_w@mail.gmail.com>
From:   Sven Schwermer <sven@svenschwermer.de>
In-Reply-To: <CAHp75VfMTCvgib__PhnfB_g7xLhyNws5TDRyMVyzuAkT1ydY_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy,

Thanks for looking through my patch. I have a couple of follow-up 
questions about your feedback:

On 2/2/22 13:33, Andy Shevchenko wrote:
>> +                       ret = PTR_ERR(pwmled->pwm);
>> +                       dev_err(&pdev->dev, "unable to request PWM: %d\n", ret);
>> +                       fwnode_handle_put(fwnode);
>> +                       goto destroy_mutex;
> 
> fwnode_handle_put();
> return dev_err_probe(...);
This would skip the destruction of the mutex and releasing of mcnode. 
Isn't that problematic? The same goes for all of your comments of this kind.

>> +destroy_mutex:
>> +       mutex_destroy(&priv->lock);
> 
> Wrong ordering here and in ->remove().
> 
> Don't mix devm_* with non-devm_* calls.
What do you mean by this?

Best regards,
Sven
