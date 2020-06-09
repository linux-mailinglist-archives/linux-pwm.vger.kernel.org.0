Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03791F3CF5
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 15:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgFINo1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 09:44:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726803AbgFINo0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 09:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591710265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ciM2j9nevs9rj7f3kAoWqHnY0nARQeatB2ntlMR/UQk=;
        b=gQyIUsnae/zjDXW55g/MfBsdOCCE/FrbxkbYjeGbgtSpZQhIb6hjQ/6XW5RHhhwoYVg8zu
        vvZq5wkkmKwxwLPaXtyakz+wuINWDX6yIGuuXYeXeWWi7XvjvQYJ+sb2XG5KU2Qts8R2OX
        QuoNWAlvj2KWiTYvTImLOy6oVAcFJzw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-9-ln33xFPZSzZiEAbHEcbA-1; Tue, 09 Jun 2020 09:44:23 -0400
X-MC-Unique: 9-ln33xFPZSzZiEAbHEcbA-1
Received: by mail-ej1-f69.google.com with SMTP id bo19so7530524ejb.0
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jun 2020 06:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ciM2j9nevs9rj7f3kAoWqHnY0nARQeatB2ntlMR/UQk=;
        b=L6xXwcAiADudVyhp87gd2tHN26yH2K4wM/wn6LTTI+ADtMzO6l/QUXXu2vxPC15L+9
         i5NuZ1fxhw4c2dSPmA+CZYRo11R4Pnr22Eej0KVzORpfXLPf0p1EFClnrrHJWQp8Cgf4
         moR2Cob51Qd5y8GbaBlYbEE6ImjOzbKzSyB3inQhS78y81Je4E37oFHouQffXVxo93EY
         Yb5zhvCyiVi16R97jrUAOazfyTZiM/d8LiiRHolJuZlrB0P91F3UmsG9CsKYiy3v5hRc
         wksQmbu3KWd0OkkSMiaBu8Fde8SenJqqxq3N8PrBE+AqedF4YnWIgX1PIkacpL+Li+W+
         GMyA==
X-Gm-Message-State: AOAM533cV3A/I9CItacGGAKZp9uuryTTiqW/Sonf/XHcCEfCDsddejMO
        CtMwbkewW8xp99U/MxchTnuxCGD875TQodc00Z0j7T0Pi464yLkYlJi48Bg6AvCBDXZq5G0xn53
        kYYUK3ue4zPLXmZ7Ucb9b
X-Received: by 2002:a17:906:aec5:: with SMTP id me5mr26966107ejb.54.1591710259647;
        Tue, 09 Jun 2020 06:44:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKA4dtsW1lefAvu07pIsZYL8eurJ7KGixlwM3PoADUunSCQ5qYiEPYeJz/bkLkGnOdTBQrmg==
X-Received: by 2002:a17:906:aec5:: with SMTP id me5mr26966096ejb.54.1591710259476;
        Tue, 09 Jun 2020 06:44:19 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id gj10sm13143604ejb.61.2020.06.09.06.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 06:44:18 -0700 (PDT)
Subject: Re: [PATCH v2 10/15] pwm: crc: Implement apply() method to support
 the new atomic PWM API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-11-hdegoede@redhat.com>
 <20200609113220.GM2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <93c7843d-1225-c8c6-9eb7-1f11b44bec34@redhat.com>
Date:   Tue, 9 Jun 2020 15:44:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609113220.GM2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/9/20 1:32 PM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:35PM +0200, Hans de Goede wrote:
>> Replace the enable, disable and config pwm_ops with an apply op,
>> to support the new atomic PWM API.
> 
> ...
> 
>> -static int crc_pwm_calc_clk_div(int period_ns)
>> +static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>>   {
>> -	int clk_div;
>> -
>> -	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
>> -	/* clk_div 1 - 128, maps to register values 0-127 */
>> -	if (clk_div > 0)
>> -		clk_div--;
>> -
>> -	return clk_div;
>> -}
> 
> ...
> 
>> +		clk_div = PWM_BASE_CLK_MHZ * state->period /
>> +			  (256 * NSEC_PER_MHZ);
>> +		/* clk_div 1 - 128, maps to register values 0-127 */
>> +		if (clk_div > 0)
>> +			clk_div--;
> 
> And again... :-(

Well yes I cannot help it that the original code, as submitted by Intel,
was of very questionable quality, so instead of just converting it to the
atomic PWM API I had to do a ton of bugfixes first...   I tried to do
this all in small bits rather then in a single big rewrite the buggy
<beep> commit to make life easier for reviewers.

I can introduce the crc_pwm_calc_clk_div helper earlier as you suggested
in an earlier mail. I guess I could also keep the helper here, and then
fold it into the function in a later commit (*).

Would that work for you ?

Regards,

Hans



*) Because having a helper for 3 lines of code when it is used only
once is not helpful IMHO, it only makes it harder to figure out what
the code is exactly doing when readin the code.

