Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9751F7BE0
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLRAG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Jun 2020 13:00:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33432 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgFLRAF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 13:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591981203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZefpytQS9Nuutazh9XOblfbRG+wXV9orLCiC5J8cHs=;
        b=VyV9hpjGoBfuMTfEAJSy+yn0c5EGUBt5xlR38CU7CNqGXNZGKJxhO0c/Ue1DOce9da/0It
        DiDrgit3a/85Tm0mfXPvACP8vF1JtTHz4caKJl59A526Drp9i7GIPqkoYZCRNn3rKFyMjm
        Dpw+7Yu70dZelSFlwqfub5LQSjAxx6A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342--feBixskPIegoLjln_PQVQ-1; Fri, 12 Jun 2020 13:00:02 -0400
X-MC-Unique: -feBixskPIegoLjln_PQVQ-1
Received: by mail-ed1-f71.google.com with SMTP id f13so3149708edv.11
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2020 10:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZefpytQS9Nuutazh9XOblfbRG+wXV9orLCiC5J8cHs=;
        b=TZEzdOc99faFW0TDUSHtsNU7Pm/eV7popZ2zt5sySoFElgw+3WuDdMXHZyh7g+5K+i
         zKdr0qzgYuE38Mswdbc5hzty2LA1EjEX8GF1YXjiS/czblNT1lqaeFqOOtPpyuTpkT+p
         Kl1RjunU9D+G2p8Z6FY+Ki5UIaVNJdveMmEDMSKpJgvUXWIbeM5PtCHHnuWrDJTEK2T3
         6mOwaeaSGb7JKTqLywKu/+9oDOc3vuvIjotQrAYMdHKWtK1Kd7BJCArhkDzWAMlnNkc0
         mMYQW4paB9PxrHvtJJCkTOK1VjwdYoBj2HVmgxOZLdPHLUFvcKsEc1IKntgK5Hb8GV9/
         WlEg==
X-Gm-Message-State: AOAM53383egUdJopd0p0gdOwJfLUROpQDW+GZW8B/UwG7VYljUP3b7JW
        ipAG8+pLVYUAlx1cRQ39hT+hmKt/4uC6cvg7U+1hqC8y8JqGAmOG0O1iqmZkPT24Vp5dNw/nEcd
        yrXKR/JaXKrPsAQ2aOsEO
X-Received: by 2002:a17:906:a387:: with SMTP id k7mr14926623ejz.408.1591981200751;
        Fri, 12 Jun 2020 10:00:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbjRA0DxcpKz6XFn10/ujz+AwaKQghqUPzhohiLhOX8HiLCbiRGn+Y5AlGw1zWUhaDAf5BGg==
X-Received: by 2002:a17:906:a387:: with SMTP id k7mr14926611ejz.408.1591981200562;
        Fri, 12 Jun 2020 10:00:00 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id h16sm3865328ejq.62.2020.06.12.09.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 09:59:59 -0700 (PDT)
Subject: Re: [PATCH v2 09/15] pwm: crc: Enable/disable PWM output on
 enable/disable
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-10-hdegoede@redhat.com>
 <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1af668ef-7b42-340a-8aa2-f66c266ac6ef@redhat.com>
Date:   Fri, 12 Jun 2020 18:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611222029.csyo2wxof7nuhjws@taurus.defre.kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/12/20 12:20 AM, Uwe Kleine-König wrote:
> On Sun, Jun 07, 2020 at 08:18:34PM +0200, Hans de Goede wrote:
>> The pwm-crc code is using 2 different enable bits:
>> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
>> 2. bit 0 of the BACKLIGHT_EN register
>>
>> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
>> this commit makes crc_pwm_disable() clear it on disable and makes
>> crc_pwm_enable() set it again on re-enable.
>>
>> This should disable the internal (divided) PWM clock and tri-state the
>> PWM output pin when disabled, saving some power.
> 
> It would be great if you could also document that disabling the PWM
> makes the output tri-state. There are a few drivers that have a
> "Limitations" section at their top. Describing that there (in the same
> format) would be the right place.
> 
> Also note that according to Thierry's conception getting a (driven)
> inactive output is the right thing for a disabled PWM.

Hmm, the tri-state thing is an assumption from my side and we
don't have any docs for this PWM controller, so I'm not sure at
all if that is true. So I think it will be better to just drop
the tri-state bit from the commit msg for the next version.

Regards,

Hans


