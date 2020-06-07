Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619E11F0DA0
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jun 2020 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgFGSPw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Jun 2020 14:15:52 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729715AbgFGSPw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Jun 2020 14:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591553750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9tV0sc3/5YMNSjozidZETTw4qiF+7h3IC9IbudBHo9g=;
        b=CxYIzKRR1ahJWaQMRWxpjLy4nYWKVfN7DiLPtWZ9ERRCNjbESDii88eMmh90a4wsHAAMrL
        OJOWzXIOT/lnwHYaDA3kieej9iDn0Gm49u8ED7qYbBE66xMsW2kpASmj9+bLY3xh23chBR
        cJhI64JfeDaF/UpDdJokIPsC3Jal0YY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-yhaA_WF-P-OuHzh6aECytA-1; Sun, 07 Jun 2020 14:15:48 -0400
X-MC-Unique: yhaA_WF-P-OuHzh6aECytA-1
Received: by mail-wm1-f72.google.com with SMTP id g84so4470955wmf.4
        for <linux-pwm@vger.kernel.org>; Sun, 07 Jun 2020 11:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9tV0sc3/5YMNSjozidZETTw4qiF+7h3IC9IbudBHo9g=;
        b=OQKPjp7Nq87PwikqeESzSV6FxWp8XtV67K0+gcsX6RbpHDSdDcpac0XZvegXpjyxqS
         Oat+nDOlkRoO28gnIUOlO8fiaPw8Jf5x7srp7b1H+llbLAkPlyz9GYPTQwLomFbC8jUD
         iaHZrDP7H8ljJTKd1Bg+piUP13vIzXhx0Uy4HEr7w+30pAB1gj7aWHvhOlXBxwYMuwXy
         ns1u42YYma+b8bTUeZFhzuvLUu082N8zOWUBRN3dYis/poq71dI7GCD3a9lPVTUepejH
         16/fSf61ccblJFVmC6bbSRKqmVQ837fsZ1YiVvofcZEZMJCdWWDYfWjbHp3+IpVv7av3
         urVA==
X-Gm-Message-State: AOAM530M6GzmybGZENL3B8KX1Ho3pj95QM58XNIy11SvPosa0mRRakMc
        LZAd0oHiyttW+RRxipHMDNlk8gWvfzohb9XI/9KjhAwa4jaD4S6lq1viqfruh3yDwNBW0kldxcd
        QyvVhzgiCx+dar/C/H797
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr19583040wrw.401.1591553747560;
        Sun, 07 Jun 2020 11:15:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtMJG8U/xRqsGWMK/X6uJ6kAHwVq+/SqfPqHWjteOKKkHd9bjINVe1zY0JZ46Ljwl1tR73lA==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr19583025wrw.401.1591553747365;
        Sun, 07 Jun 2020 11:15:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id z132sm21677650wmc.29.2020.06.07.11.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 11:15:46 -0700 (PDT)
Subject: Re: pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the
 atomic PWM API
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
References: <20200606202601.48410-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <606dd687-f560-3798-afec-fbab8418d212@redhat.com>
Date:   Sun, 7 Jun 2020 20:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi All,

I forgot the [PATCH 0/16] part of the subject here and I accidentally
left a patch adding some debugging printk-s in the series. I will
send out a v2 addressing this.

Regards,

Hans

On 6/6/20 10:25 PM, Hans de Goede wrote:
> Hi All,
> 
> This patch series converts the i915 driver's cpde for controlling the
> panel's backlight with an external PWM controller to use the atomic PWM API.
> 
> Initially the plan was for this series to consist of 2 parts:
> 1. convert the pwm-crc driver to support the atomic PWM API and
> 2. convert the i915 driver's PWM code to use the atomic PWM API.
> 
> But during testing I've found a number of bugs in the pwm-lpss and I
> found that the acpi_lpss code needs some special handling because of
> some ugliness found in most Cherry Trail DSDTs.
> 
> So now this series has grown somewhat large and consists of 4 parts:
> 
> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
> 2. various fixes to the pwm-lpss driver
> 3. convert the pwm-crc driver to support the atomic PWM API and
> 4. convert the i915 driver's PWM code to use the atomic PWM API
> 
> So we need to discuss how to merge this (once it passes review).
> Although the inter-dependencies are only runtime I still think we should
> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
> merging the i915 changes. Both to make sure that the intel-gfx CI system
> does not become unhappy and for bisecting reasons.
> 
> The involved acpi_lpss and pwm drivers do not see a whole lot of churn,
> so we could just merge everything through dinq, or we could use immutable
> branch and merge those into dinq.
> 
> So Rafael and Thierry, can I either get your Acked-by for directly merging
> this into dinq, or can you provide an immutable branch with these patches?
> 
> This series has been tested (and re-tested after adding various bug-fixes)
> extensively. It has been tested on the following devices:
> 
> -Asus T100TA		BYT + CRC-PMIC PWM
> -Toshiba WT8-A		BYT + CRC-PMIC PWM
> -Thundersoft TS178	BYT + CRC-PMIC PWM, inverse PWM
> -Asus T100HA		CHT + CRC-PMIC PWM
> -Terra Pad 1061		BYT + LPSS PWM
> -Trekstor Twin 10.1	BYT + LPSS PWM
> -Asus T101HA		CHT + CRC-PMIC PWM
> -GPD Pocket		CHT + CRC-PMIC PWM
> 
> Regards,
> 
> Hans
> 

