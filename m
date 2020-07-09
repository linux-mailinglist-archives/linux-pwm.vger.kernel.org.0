Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E470C21A3FF
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgGIPsH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 11:48:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28879 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgGIPsH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Jul 2020 11:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594309685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOxnlG8KI3xPEqow6g4YLIn7sm4skGyEPtPky2pJiSs=;
        b=P1zw+NjFxQTbjZ8ttTxgbvMvR2gnZ4WFH4M4bYId15OtchDBJoTvFZW6V3uYnn5hsEC2Ka
        lonewrolscR6ErzxSzNn+Zitdo17ZbOErvQsOrGk6CkU2KTtWDT34x1hNb/UaI8ybH4ZVd
        330A6evVc6R5igqBaBtOVP+eKfc4ySI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-NT6pxXj8MbiUEASJ5zwL4g-1; Thu, 09 Jul 2020 11:48:02 -0400
X-MC-Unique: NT6pxXj8MbiUEASJ5zwL4g-1
Received: by mail-wr1-f72.google.com with SMTP id 89so2278470wrr.15
        for <linux-pwm@vger.kernel.org>; Thu, 09 Jul 2020 08:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOxnlG8KI3xPEqow6g4YLIn7sm4skGyEPtPky2pJiSs=;
        b=Dwf+yZ1p0yk81ih7bQ6Xht7JLTcRurlIx5jdtsNuy+HRMPjhVndafTW8Xr4tokg/B+
         ybbYHJvUfiLJPy1T5vZvdU46Ht95kOTbo4HD+pIU5Apg+AdjZqkzUELUxNA+31lfrmlS
         guD9jZUxn8k9ulBsSwxy0sIo5NbjCDygyFo3PVkO4SZmrwQ4CvCMslTqODy965wZ9l5L
         Wf/0xgBEYpIP/u4M5qsNG91az0M3lL3BBdbjWu6+83tTyl7WHAk7yLMrmKvFdXp/xe3m
         rLMhiSthIFJKxnoqatEVnQKZ6UAj84K4KvDMnIZvisa58Z5nvSQe6DMgOkIezThgT8E+
         1Tzw==
X-Gm-Message-State: AOAM530Z++2aq4J47P3k4J2hdk/kGM3569lFyb9pn+NHL1Ibicpdf6Of
        Ryf/aP01d4UbhtllAZOTo29V4fvYZxh6jiQfvgV4CsczoNEmLoHfUUmTFfDyrzLVEtmNJdHbaaL
        ghyqE6WItJQfpeDjEpdpL
X-Received: by 2002:a1c:3954:: with SMTP id g81mr628324wma.73.1594309681192;
        Thu, 09 Jul 2020 08:48:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4y2IzEii9YOA5nS+ZHsnfXytiSmWTStGmkEq37GvHGpqpwSSNWVeWnQtjd9K2u/5bw2gGAQ==
X-Received: by 2002:a1c:3954:: with SMTP id g81mr628315wma.73.1594309680971;
        Thu, 09 Jul 2020 08:48:00 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id z8sm5484573wmg.39.2020.07.09.08.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:48:00 -0700 (PDT)
Subject: Re: [PATCH v4 06/16] pwm: lpss: Correct get_state result for
 base_unit == 0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-7-hdegoede@redhat.com>
 <20200709145013.GA3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <af7158c5-02bb-38ce-4b22-e469079dcccf@redhat.com>
Date:   Thu, 9 Jul 2020 17:47:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709145013.GA3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 7/9/20 4:50 PM, Andy Shevchenko wrote:
> On Wed, Jul 08, 2020 at 11:14:22PM +0200, Hans de Goede wrote:
>> The datasheet specifies that programming the base_unit part of the
>> ctrl register to 0 results in a contineous low signal.
>>
>> Adjust the get_state method to reflect this by setting pwm_state.period
>> to 1 and duty_cycle to 0.
> 
> ...
> 
>> +	if (freq == 0) {
>> +		/* In this case the PWM outputs a continous low signal */
> 
>> +		state->period = 1;
> 
> I guess this should be something like half of the range (so base unit calc
> will give 128). Because with period = 1 (too small) it will give too small
> base unit (if apply) and as a result we get high frequency pulses.

You are right, that if after this the user only changes the duty-cycle
things will work very poorly, we will end up with a base_unit value of
e.g 65535 and then have almost no duty-cycle resolution at all.

How about using a value here which results in a base_unit value of
256 (for 16 bit base-unit registers), that is the highest frequency we
can do while still having full duty-cycle resolution and it also
is the power-on-reset value, so using a higher period which translates
to a base_unit value of 256 (the por calue) seems like a sensible thing to do.

Uwe what do you think about this?

Regards,

Hans



> 
>> +		state->duty_cycle = 0;
>> +	} else {
>>   		state->period = NSEC_PER_SEC / (unsigned long)freq;
>> +		on_time_div *= state->period;
>> +		do_div(on_time_div, 255);
>> +		state->duty_cycle = on_time_div;
>> +	}
> 

