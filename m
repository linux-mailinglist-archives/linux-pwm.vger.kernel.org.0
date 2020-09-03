Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7125C00A
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgICLSL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 07:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728417AbgICLPk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 07:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599131701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efREBgpIuAxc+bnBJ5R3S/pFsZS/Ey21En4F0jCEO9A=;
        b=DkTuQfrXIjNzJobZILFiPZlFO8O60VfZFVCgROtNwecTFcgUk4LniK/oiyu7yQS4fT7Byy
        6smTIMnOvUmwb+30ikT406egzOTQlU/GdD3hC/dZExusHccEhf5IBruFGD3XMPucBpYtwY
        X+sFopp9c95+dRWx0ybCxkq+dSOGjjk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-W5vf7tJVNvOFirayoluYqw-1; Thu, 03 Sep 2020 07:12:34 -0400
X-MC-Unique: W5vf7tJVNvOFirayoluYqw-1
Received: by mail-ej1-f71.google.com with SMTP id li24so189297ejb.6
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2020 04:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efREBgpIuAxc+bnBJ5R3S/pFsZS/Ey21En4F0jCEO9A=;
        b=d6O/NI8anfgehmu3SheWE8mxVZEiFsb2oiiiF+eMBAYzJRAYycUpSnNKSpuY3mdiq7
         Q4GJcXwjOwRkKOubKMnAi/sQVroP5iXchXvGn8m67v3em9BCc3tgOgn/M+u/Fg34RKDi
         ApPizyZij4gJH1tq42oPn38b6DKYw62oL83xRTXUq3R5L3/YxmaRtqRP+N00jTuo+5IE
         UrUp4kKXhDAUV+/MlBabHzn9Ym+w6izIeAQFmYG3OSkFdSrxt83fcxqVEB/0oc7mHM1t
         ejIgccD5V3hY5ejQiNVCU9uwZFrgb5bs5w2RbJCE/BALsSQYsKSSDRhRfTQUiIbhrAeV
         AdSA==
X-Gm-Message-State: AOAM530lsjHiRPiliJCdOHM8bySlRMjlhCnaLZbgQvoCmBNSUrhDhXQh
        06AjYVQCgYgqjYTFnJuclonlfFLxP/0nvyKCByV5Qky/c6wvgpdr2O6rz7xzH9I8KCyl7TU01Cr
        6mVikImSYvInw4kdwverr
X-Received: by 2002:a17:906:c7da:: with SMTP id dc26mr1490804ejb.491.1599131553463;
        Thu, 03 Sep 2020 04:12:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz45IHe95vEABByf1/DSG38NFHvqU3XHec96U37Ufe0eGhD/vOjFiqWQ2lkLsAJDGyIGIi4Q==
X-Received: by 2002:a17:906:c7da:: with SMTP id dc26mr1490775ejb.491.1599131553140;
        Thu, 03 Sep 2020 04:12:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id r16sm2909233ejb.110.2020.09.03.04.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 04:12:32 -0700 (PDT)
Subject: Re: [PATCH v9 06/17] pwm: lpss: Make pwm_lpss_apply() not rely on
 existing hardware state
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200903105114.9969-1-hdegoede@redhat.com>
 <20200903105114.9969-7-hdegoede@redhat.com> <20200903105909.GA3756465@ulmo>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e342aee0-c7a6-62db-e4b7-9d72554fd55c@redhat.com>
Date:   Thu, 3 Sep 2020 13:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903105909.GA3756465@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 9/3/20 12:59 PM, Thierry Reding wrote:
> On Thu, Sep 03, 2020 at 12:51:03PM +0200, Hans de Goede wrote:
>> Before this commit pwm_lpss_apply() was making 2 assuming
>> 2 pre-conditions were met by the existing hardware state:
> 
> I think that "making 2" is too much.

You're right at first the sentence had something about making
2 assumptions, then I added pre-conditions in there for it
to better describe the problem...

>> 1. That the base-unit and on-time-div read back from the
>> control register are those actually in use, so that it
>> can skip setting the update bit if the read-back value
>> matches the desired values.
>>
>> 2. That the controller is enabled when the cached
>> pwm_state.enabled says that the controller is enabled.
>>
>> As the long history of fixes for subtle (often suspend/resume)
>> lpss-pwm issues shows, this assumptions are not necessary
>> always true.
>>
>> 1. Specifically is not true on some (*) Cherry Trail devices
>> with a nasty GFX0._PS3 method which: a. saves the ctrl reg value.
>> b. sets the base-unit to 0 and writes the update bit to apply/commit
>> c. restores the original ctrl value without setting the update bit,
>> so that the 0 base-unit value is still in use.
>>
>> 2. Assumption 2. currently is true, but only because of the code which
>> saves/restores the state on suspend/resume. By convention restoring the
>> PWM state should be done by the PWM consumer and the presence of this
>> code in the pmw-lpss driver is a bug. Therefor the save/restore code will
>> be dropped in the next patch in this series, after which this assumption
>> also is no longer true.
>>
>> This commit changes the pwm_lpss_apply() to make any assumptions about the
> 
> Did you mean to say "... to _not_ make any assumptions ..."?

Yes, oops. That is a small but important difference.

I'll do a v10 with your 2 Acked-by's added and both commit msg issues fixed.

Hopefully that will be the last version.

>> state the hardware is in. Instead it makes pwm_lpss_apply() always fully
>> program the PWM controller, making it much less fragile.
>>
>> *) Seen on the Acer One 10 S1003, Lenovo Ideapad Miix 310 and 320 models
>> and various Medion models.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/pwm/pwm-lpss.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> Other than the two small nits, this looks much more idiomatic and true
> to the atomic API, so:
> 
> Acked-by: Thierry Reding <thierry.reding@gmail.com>

Thank you.

Regards,

Hans

