Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1501EFE10
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFEQek (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 12:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFEQej (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 12:34:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D70C08C5C2;
        Fri,  5 Jun 2020 09:34:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id jz3so2817240pjb.0;
        Fri, 05 Jun 2020 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iJmtlF1Fn34skzAHzjUQqZOvSbl81/B3EfHTzE9JIy8=;
        b=Ct9r7A1nDUiRWsfrgAS4CkunE7SysHfUQnD2fZDBCheg65ij+ycPcCnjbPuk4RMS4C
         gtIqQ6n4DGRhDRbWbU+CCoAQY7+CgSCExEaKH+QPyo9rMQ54VIFEzchnvMEdTOj3VyGK
         6C1/1HJLn5ZNm9cs7ghab4axzm3/2VDXnPlBlxoj7jlVlG6A8WLELAhx11hhJKLpT4DP
         nzLQEzYnf7Djc8tDaaCrfV0WSPHr5RtjvHWIqtUg8tRBjDawn4abgoW2A1r1WntSSwhq
         nkleIegA4GFEHxdh31NGOTVyzaeofFQqi2unl6TRwzuh6ItF2Woe4L6Si23SCCi87UNs
         +I7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iJmtlF1Fn34skzAHzjUQqZOvSbl81/B3EfHTzE9JIy8=;
        b=sRywa7SfHIm8xnSVndefLM7NUXej3zdbPLZdTd3RWHmFFDIQtrTuNAkUOXpqV9tWQC
         120WokNzpUF5jnXKTUISv7XmColpQes2pOlj36UaRvxgj22k8+BtZ7OU+x3XWpG/2ri3
         OiFbmXrsquRdTXKMiBMlBJBx0YFPgXa2YhoGbGnOl4Q1nSxKJfWEt+69KIdLTCwFNXWC
         E8Wmj0jTHb/dzqjnsiDuj063uNuHRwTByMGv359DG1Uk8aDmsGejWPNIiqRvsLiZSvwb
         gJ8qsEvQXEXTOx4wSqNZGeyputTkZL2+MCiPZXLOqG++F/5GR4p7qvk2u4L0zWGhLdXp
         GvqQ==
X-Gm-Message-State: AOAM530wFUTjPOj1b5vc/nZ2Y9EV6IoXzg5GNe7Qlc77D8G1qMT09gfy
        HyJyjoN21ElRHtcDcotLEOw=
X-Google-Smtp-Source: ABdhPJykhVRiplBn+3LpRFZ8/4hP6LcJwdpYIczM/dd0iT6NreCKioxKBSYX584oPxHH+eI6+j0RcA==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr10842832plb.241.1591374879375;
        Fri, 05 Jun 2020 09:34:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n38sm110717pgm.1.2020.06.05.09.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 09:34:38 -0700 (PDT)
Subject: Re: [PATCH v4 04/11] watchdog: add support for sl28cpld watchdog
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-5-michael@walle.cc>
 <CAHp75VdeD6zDc--R4NPHsiqQerzfNGwUikLN+WHMiZZVsQ8QSA@mail.gmail.com>
 <8f042c2442852c29519c381833f3d289@walle.cc>
 <CAHp75VfY0BD4CFu6Thx1wE-U0Zt1q8uTOLxkWTMdFk0MBuhYFQ@mail.gmail.com>
 <871a4990-5b94-3a17-01d4-74998375f08b@roeck-us.net>
 <20200605140911.GO2428291@smile.fi.intel.com>
 <20200605150542.GA254229@roeck-us.net>
 <CAHp75VduUG=XkvyZwdZDNqBh3KE67MWZWgqBN67fN6StAa469w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <450ce146-bf9a-130a-78e5-4bcabf1b7063@roeck-us.net>
Date:   Fri, 5 Jun 2020 09:34:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VduUG=XkvyZwdZDNqBh3KE67MWZWgqBN67fN6StAa469w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 6/5/20 9:04 AM, Andy Shevchenko wrote:
> On Fri, Jun 5, 2020 at 6:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Fri, Jun 05, 2020 at 05:09:11PM +0300, Andy Shevchenko wrote:
>>> On Fri, Jun 05, 2020 at 06:52:00AM -0700, Guenter Roeck wrote:
>>>> On 6/5/20 3:50 AM, Andy Shevchenko wrote:
>>>>> On Fri, Jun 5, 2020 at 1:24 PM Michael Walle <michael@walle.cc> wrote:
>>>>>> Am 2020-06-05 10:14, schrieb Andy Shevchenko:
>>>>>>> On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:
>>>
>>> ...
>>>
>>>>>>>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>>>>>>>> +module_param(nowayout, bool, 0);
>>>>>>>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started
>>>>>>>> (default="
>>>>>>>> +                               __MODULE_STRING(WATCHDOG_NOWAYOUT)
>>>>>>>> ")");
>>>>>>>> +
>>>>>>>> +static int timeout;
>>>>>>>> +module_param(timeout, int, 0);
>>>>>>>> +MODULE_PARM_DESC(timeout, "Initial watchdog timeout in seconds");
>>>>>>>
>>>>>>> Guenter ACKed this, but I'm wondering why we still need module
>>>>>>> parameters...
>>>>>>
>>>>>> How would a user change the nowayout or the timeout? For the latter
>>>>>> there is
>>>>>> a device tree entry, but thats not easy changable by the user.
>>>>>
>>>>> Yes, it's more question to VIm and Guenter than to you.
>>>>>
>>>>
>>>> Has support for providing module parameters with the kernel command line
>>>> been discontinued/deprecated, or did it run out of favor ? Sorry if I
>>>> missed that.
>>>
>>> Latter according to Greg KH. One of the (plenty) examples [1].
>>>
>>> [1]: https://www.mail-archive.com/driverdev-devel@linuxdriverproject.org/msg96495.html
>>>
>> What is the suggested replacement ?
> 
> In some mails he suggested to use sysfs.
> 

Using sysfs specifically to defeat "nowayout" would defeat
its purpose, which is specifically to disable the possibility
to stop the watchdog. Using a module parameter (or rather boot
time parameter) is a bit different since that has to be done
consciously and is only valid for a given boot. The same is
true for the timeout parameter. If one can wait for sysfs (or
userspace) to be active, one can as well use the watchdog
daemon to update the timeout. The use case for the module
/ command line parameter or sysfs based timeout is to be
able to set it _before_ userspace is active.

So sysfs is not really an alternative.

Guenter
