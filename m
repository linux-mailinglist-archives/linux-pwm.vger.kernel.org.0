Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1D11F1755
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgFHLNK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 07:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48531 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729482AbgFHLNJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 07:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591614786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhgJTWJr6h9G9PmHmPph9dyAvRbYjMyPRPIHK6pK8vc=;
        b=F3ud4RqtpYEnSlAIqACKsQMg5ASW2izchYkv3CVtcNWQjPqbBwzWS6S48od+Nz0ynkQkZw
        vtczwO1sQSSFygLoq249xhUIFJvxJJIYts2bNHyDNOOfsTUUO1BM+aV6rGyn+V+ZTawnll
        cc6kJwAOmosqAmI0dkufWoG5XAEU2zU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-K2gwz78EO2SLTetiftNelg-1; Mon, 08 Jun 2020 07:13:04 -0400
X-MC-Unique: K2gwz78EO2SLTetiftNelg-1
Received: by mail-wr1-f71.google.com with SMTP id c14so6981911wrw.11
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jun 2020 04:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhgJTWJr6h9G9PmHmPph9dyAvRbYjMyPRPIHK6pK8vc=;
        b=RETXruH5tzN9Yd8GPDlEd2918P26Sxr8klCu00AEHGDNJQhTpBBpHlC+Pj+1nW36q6
         b50OqzIMaoYrEgl4qWa5WZEV+KsIRhqPfNlXgrBvwnJ6hGGC8HFOl5J3NkTfskyftTih
         7HQGKSTxOdCVxtyAaTezk/6QEi38+FeZCavPlCV0Vn6SbmnnkiE8KhqDWvtiTz+s7nJN
         uOEeXpWJlmELmFS8kIEFV14ufV7707ECp2oM2RoX52rIswG5vG4Jvv7TZJpa+O/UUllz
         YFuZLf/cF0Jz6Btb3P3dZA1ot1MEQJG7SKi/KFIpNuZVEZWbdyHxgH0LUTipjyRveTek
         fwfw==
X-Gm-Message-State: AOAM533k/AxSk4RCDujet6z97lN06Yt1i9QH6V5m85GDP92U4gWCFYD+
        hA5C703hLIINrXz0UwA409FELiEEnFRkg/lP3WJx6g1Db8LEkyqTCGc3eQIAEkG91nGYGwpEtYN
        bnIX+5KXKX6IX8H+uaYZF
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr22474418wrx.214.1591614783647;
        Mon, 08 Jun 2020 04:13:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsVhaPysSkuHY7OnSe0IptFhwBN2fdZnKtM5beXPetYqOZNC7m8APlsFf+Xeln1lc8xR47Kg==
X-Received: by 2002:a05:6000:10cf:: with SMTP id b15mr22474396wrx.214.1591614783396;
        Mon, 08 Jun 2020 04:13:03 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v19sm21737311wml.26.2020.06.08.04.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 04:13:02 -0700 (PDT)
Subject: Re: [PATCH v2 04/15] pwm: lpss: Fix off by one error in base_unit
 math in pwm_lpss_prepare()
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
 <20200607181840.13536-5-hdegoede@redhat.com>
 <20200608035512.GA2428291@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c8a8d466-9b4a-9021-ca74-01d315e99117@redhat.com>
Date:   Mon, 8 Jun 2020 13:13:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608035512.GA2428291@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/8/20 5:55 AM, Andy Shevchenko wrote:
> On Sun, Jun 07, 2020 at 08:18:29PM +0200, Hans de Goede wrote:
>> According to the data-sheet the way the PWM controller works is that
>> each input clock-cycle the base_unit gets added to a N bit counter and
>> that counter overflowing determines the PWM output frequency.
>>
>> So assuming e.g. a 16 bit counter this means that if base_unit is set to 1,
>> after 65535 input clock-cycles the counter has been increased from 0 to
>> 65535 and it will overflow on the next cycle, so it will overflow after
>> every 65536 clock cycles and thus the calculations done in
>> pwm_lpss_prepare() should use 65536 and not 65535.
>>
>> This commit fixes this. Note this also aligns the calculations in
>> pwm_lpss_prepare() with those in pwm_lpss_get_state().
> 
> This one sounds like a bug which I have noticed on Broxton (but thought as a
> hardware issue). In any case it has to be tested on various platforms to see
> how it affects on them.

If you like at the datasheet / read my commit description then it
becomes obvious that because of the way the PWM controller works that
it takes the full 2^(base-unit-bits) for the counter to overflow,
not 2^(base-unit-bits) - 1. This will make a difference of a factor
65535/65536 in the output frequency which will be tricky to measure.

IOW I'm not sure we can really test if this helps, but it is
obviously the right thing to do and it aligns the pwm_apply code
with the pwm_get_state code which already does not have the - 1.

Regards,

Hans

