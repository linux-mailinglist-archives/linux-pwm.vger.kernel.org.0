Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B203696FB
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhDWQdU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhDWQdT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 12:33:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34FC061574;
        Fri, 23 Apr 2021 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uVLkAug7PYshDKay9sm8NXjWy68RwVQf0iSW+d5QZMo=; b=ODbmV/ml4cNj4bYKjJwfTmwiM2
        CeBdi6/GplEoG5J+wsRXjc48kqEx6eRYxiM+P1bZrlfk8b+e6/R4Gs5eP1hvb3IHJzTDEQgpaTz3Y
        kOScqLulN1+Uie2eSV9mygLxoIN63J2b9VYYU6016uHTp/GDzuQrVX1uRfYWb3ScfluBMPzYn05z7
        Psb6LQYMMEWYk0J1bybKxHQR/E9S8T/IUc1SfxpbbUXOT/YH16CY6chKElFnZG2vKri8yGiOuHcU5
        N4ILJrAQxQYgelbWYW2uwlSEfsAFX9VxHGSu2J1hkHJUmMP4Fl3zm/EP0TtPB/xtTEB6C1D7S0g5Y
        NqMHmyFg==;
Received: from [2601:1c0:6280:3f0::df68]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZyjI-001rxs-VM; Fri, 23 Apr 2021 16:32:33 +0000
Subject: Re: [PATCH] pwm: reword docs about pwm_apply_state()
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Corbet <corbet@lwn.net>
References: <20210423074411.2167332-1-u.kleine-koenig@pengutronix.de>
 <5aa17591-dcc7-6d29-0ca3-3b4a3be7f3ef@infradead.org>
 <20210423162904.t6v6f7wq3u4ms7yg@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1eaa63e6-2035-ffe6-bf98-7fe250bb9dfe@infradead.org>
Date:   Fri, 23 Apr 2021 09:32:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210423162904.t6v6f7wq3u4ms7yg@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 4/23/21 9:29 AM, Uwe Kleine-König wrote:
> On Fri, Apr 23, 2021 at 08:08:48AM -0700, Randy Dunlap wrote:
>> On 4/23/21 12:44 AM, Uwe Kleine-König wrote:
>>> The main issue is that the current documentation talks about the
>>> non-existent function pwm_get_last_applied_state. (This was right in the
>>> context of
>>> https://lore.kernel.org/linux-pwm/20210406073036.26857-1-u.kleine-koenig@pengutronix.de/
>>> but was then missed to adapt when this patch was reduced to a
>>> documentation update.)
>>>
>>> While at is also clarify "last applied PWM state" to "PWM state that was
>>> passed to the last invocation of pwm_apply_state()" to better
>>> distinguish to the last actually implemented state and reword to drop a
>>> word repetition.
>>>
>>> Fixes: 539ed98e2bd3 ("pwm: Clarify documentation about pwm_get_state()")
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>>> ---
>>>  Documentation/driver-api/pwm.rst | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
>>> index 381f3c46cdac..a7ca4f58305a 100644
>>> --- a/Documentation/driver-api/pwm.rst
>>> +++ b/Documentation/driver-api/pwm.rst
>>> @@ -55,11 +55,11 @@ several parameter at once. For example, if you see pwm_config() and
>>> pwm_{enable,disable}() calls in the same function, this probably means you
>>> should switch to pwm_apply_state().
>>>
>>> The PWM user API also allows one to query the[-last applied-] PWM state [-with-]
>>> [-pwm_get_last_applied_state().-]{+that was passed to the+}
>>> {+last invocation of pwm_apply_state() using pwm_get_state().+} Note this is
>>> different to what the driver has actually implemented if the request cannot be
>>> [-implemented-]{+satisfied+} exactly with the hardware in use. There is currently no way for
>>> consumers to get the actually implemented settings.
>>>
>>> In addition to the PWM state, the PWM API also exposes PWM arguments, which
>>> are the reference PWM config one should use on this PWM.
>>>
>>> base-commit: 64d7d074acd52e1bdff621f2cb86c0aae9bcef80
>>>
>>
>> Looks like the patch got horribly word wrapped. ?
> 
> No, this was created using git format-patch --word-diff, which for
> continuous text is much better parsable (for a human at least).

My bad, I'm not familiar with that option.
But yes, now that I see what it does, it is easier to review the changes.

> The same chang in the more usual form looks as follows:
> 
> diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
> index 381f3c46cdac..a7ca4f58305a 100644
> --- a/Documentation/driver-api/pwm.rst
> +++ b/Documentation/driver-api/pwm.rst
> @@ -55,11 +55,11 @@ several parameter at once. For example, if you see pwm_config() and
>  pwm_{enable,disable}() calls in the same function, this probably means you
>  should switch to pwm_apply_state().
>  
> -The PWM user API also allows one to query the last applied PWM state with
> -pwm_get_last_applied_state(). Note this is different to what the driver has
> -actually implemented if the request cannot be implemented exactly with the
> -hardware in use. There is currently no way for consumers to get the actually
> -implemented settings.
> +The PWM user API also allows one to query the PWM state that was passed to the
> +last invocation of pwm_apply_state() using pwm_get_state(). Note this is
> +different to what the driver has actually implemented if the request cannot be
> +satisfied exactly with the hardware in use. There is currently no way for
> +consumers to get the actually implemented settings.
>  
>  In addition to the PWM state, the PWM API also exposes PWM arguments, which
>  are the reference PWM config one should use on this PWM.
> 
> With that it's hardly possible to identify what I actually changed.
> 
> I just noticed that the patch is not only incompatible for you but also
> git-am cannot apply it, so I will have to resend. :-\

oops.

thanks.
-- 
~Randy

