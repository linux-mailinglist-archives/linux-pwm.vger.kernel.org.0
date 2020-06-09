Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9651F3D01
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgFINpm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 09:45:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726803AbgFINpl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 09:45:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591710340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvpsAccmwpkGhYKxsT7pHl6ms2pXYRlDnYwLyHWCq1I=;
        b=MIUryzQCa6NRVRr8k59JaFE1TmSt0FV5Dm2VoPxXSc320qhgycwmtksgB298K8vZOwwJph
        qcOyz5X5b+Yy1VbASiewjqWjX+6b/XxTb9+J2EmESFu6VfHFjTkJKsE92Fyu5szraIzXat
        /s3w6VxNSRNMDQOfDERiz1B1jrKEjec=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-u-wc0mTFNWmeXbIJW3IJEg-1; Tue, 09 Jun 2020 09:45:27 -0400
X-MC-Unique: u-wc0mTFNWmeXbIJW3IJEg-1
Received: by mail-ed1-f70.google.com with SMTP id f13so8177137edv.11
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jun 2020 06:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fvpsAccmwpkGhYKxsT7pHl6ms2pXYRlDnYwLyHWCq1I=;
        b=p4PCqJVBYUhD47xXSNFjzU9HlInziRb70rYRbYpPWXZYvummszv8HatJrV5jwe80we
         yCKs0wByoTrpZeuwZf1Kgp+JmKkrmp+vH1xzIyn028CnueJJf10V8ThJILo8gVWUWdzc
         9OQDUyOipgfk7dkkrXrfOnIgsFVOTmSqB066e0xx5va2pwrrRnmLGBOeTbnNWjpHZK3W
         /9WwdWrnHmHI+yVTPVSoHHLhz2h5hKkr9Esvy4zcoenDFl3WHa9xNq/MjGpXGqQEwPYA
         m76B1FzBGxg4cJ3PoC/B8p+DWui2NPHcb3tYu4UaUDM9u2qgWSLEYlVXofn9AjdC2/fB
         z5zg==
X-Gm-Message-State: AOAM531mJhJO7xB7XEUDnA71/T2Hfss8fX5yuHdtuZXv82r8CC/Skgfi
        0prwZoZ0FNmsnAlOIMQGGj4jlsbn58pp/HffiKjdi7gX5XRJ4mRSk082Gdk7QP+ACO6OL6GKSX3
        koJsOILP6/tY/kDHlvm9T
X-Received: by 2002:a17:906:344c:: with SMTP id d12mr23943646ejb.130.1591710326729;
        Tue, 09 Jun 2020 06:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxunOyD5XPkDfbblW74CXvBtjgUGkZRw2EP+zRYxbRvuH44U47dy20JU3ob/DBn+LIrrsRQOQ==
X-Received: by 2002:a17:906:344c:: with SMTP id d12mr23943614ejb.130.1591710326418;
        Tue, 09 Jun 2020 06:45:26 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id rp21sm13345743ejb.97.2020.06.09.06.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 06:45:25 -0700 (PDT)
Subject: Re: [PATCH v2 06/15] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
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
 <20200607181840.13536-7-hdegoede@redhat.com>
 <20200609112905.GK2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fd839acc-9e25-14aa-d1ac-dbc262c7860e@redhat.com>
Date:   Tue, 9 Jun 2020 15:45:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609112905.GK2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/9/20 1:29 PM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:31PM +0200, Hans de Goede wrote:
>> While looking into adding atomic-pwm support to the pwm-crc driver I
>> noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
>> there is a clock-divider which divides this with a value between 1-128,
>> and there are 256 duty-cycle steps.
>>
>> The pwm-crc code before this commit assumed that a clock-divider
>> setting of 1 means that the PWM output is running at 6 MHZ, if that
>> is true, where do these 256 duty-cycle steps come from?
>>
>> This would require an internal frequency of 256 * 6 MHz = 1.5 GHz, that
>> seems unlikely for a PMIC which is using a silicon process optimized for
>> power-switching transistors. It is way more likely that there is an 8
>> bit counter for the duty cycle which acts as an extra fixed divider
>> wrt the PWM output frequency.
>>
>> The main user of the pwm-crc driver is the i915 GPU driver which uses it
>> for backlight control. Lets compare the PWM register values set by the
>> video-BIOS (the GOP), assuming the extra fixed divider is present versus
>> the PWM frequency specified in the Video-BIOS-Tables:
>>
>> Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
>> Asus T100TA 	200			200
>> Asus T100HA 	200			200
>> Lenovo Miix 2 8	23437			20000
>> Toshiba WT8-A	23437			20000
>>
>> So as we can see if we assume the extra division by 256 then the register
>> values set by the GOP are an exact match for the VBT values, where as
>> otherwise the values would be of by a factor of 256.
>>
>> This commit fixes the period / duty_cycle calculations to take the
>> extra division by 256 into account.
> 
> ...
> 
>> +#define NSEC_PER_MHZ		1000
> 
> This is against physics. What this cryptic name means actually?
> Existing NSEC_PER_USEC ?

Yes, using existing NSEC_PER_USEC is better I will use that for the
next version.

Regards,

Hans

