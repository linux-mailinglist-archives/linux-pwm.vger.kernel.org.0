Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF0279039
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 20:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgIYSY3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 14:24:29 -0400
Received: from 7of9.connected.by.freedominter.net ([185.238.129.13]:57602 "EHLO
        7of9.schinagl.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgIYSY2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 14:24:28 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 14:24:28 EDT
Received: from [10.2.11.237] (unknown [10.2.11.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id 4805E1645499;
        Fri, 25 Sep 2020 20:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1601057699; bh=bwlagJW4WI1C6rLX7ywRq20+AC2AgZ776FTe2qlrIlw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D09n7SQ4IlZeYfDM1p1adAIESZzmdkHgdlkEiSZ9V2/dkDdy6n7K7zT8Xky7cTNkZ
         FBx+Btpbp4HE7SaRc+z2JXITWNpIP+u+yTa9cJzVXjqJwRVl4UeHBaTkD1jQQbR7k7
         M1xX+t7Cs/AOWDQMLXPNI+BTBDhytfsdVu9D/snk=
Subject: Re: [PATCH 2/2] pwm: Add GPIO PWM driver
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        kernel <kernel@axis.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200814155513.31936-1-vincent.whitchurch@axis.com>
 <20200814155513.31936-2-vincent.whitchurch@axis.com>
 <703362fe-1454-c16e-180a-76bfc4e3ab3f@schinagl.nl>
 <20200915140208.bzserxn2bgw4xiwk@axis.com>
From:   Olliver Schinagl <oliver@schinagl.nl>
Message-ID: <cbb303e9-a352-ec2e-691d-4e073bbee8c0@schinagl.nl>
Date:   Fri, 25 Sep 2020 20:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200915140208.bzserxn2bgw4xiwk@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hey Vincent,

On 15-09-2020 16:02, Vincent Whitchurch wrote:
> On Thu, Sep 03, 2020 at 11:15:31AM +0200, Olliver Schinagl wrote:
>> On 14-08-2020 17:55, Vincent Whitchurch wrote:
>>> Add a software PWM which toggles a GPIO from a high-resolution timer.
>>>
>>> This will naturally not be as accurate or as efficient as a hardware
>>> PWM, but it is useful in some cases.  I have for example used it for
>>> evaluating LED brightness handling (via leds-pwm) on a board where the
>>> LED was just hooked up to a GPIO, and for a simple verification of the
>>> timer frequency on another platform.
>>>
>>> Since high-resolution timers are used, sleeping gpio chips are not
>>> supported and are rejected in the probe function.
>>>
>>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>>> ---
>>> While preparing this driver for posting, I found a pwm-gpio driver posted to
>>> the lists way back in 2015 by Olliver Schinagl:
>>>
>>>    https://lore.kernel.org/linux-pwm/1445895161-2317-8-git-send-email-o.schinagl@ultimaker.com/
>>>
>> Thanks for reminding me there :) As I think I still use this driver, I
>> don't mind migrating to this one (if merged) but how do you suggests to
>> proceed with regards to multiple PWM's, as this is how I am using it
>> currently. E.g. how do we merge them? I'm fine with 'taking the simpler
>> code method' for a start point, but i guess I solved that part
>> (somewhat) in 2015 :p
> 
> Since this is just a software construct, the simplest way would just be
> to create multiple instances in the device tree if you want multiple
> PWMs, wouldn't it?
> 
Not entirely, as they are no longer 'logically grouped'?

Olliver
