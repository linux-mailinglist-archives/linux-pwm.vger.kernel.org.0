Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253DC25C356
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgICOte (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 10:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729072AbgICOTS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 10:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599142756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOKwAmzdX19wFLaLs6FnpWqrSpxl3eshTWS+wqlIdDI=;
        b=YPvzNAQYMjt7UIyeroSGX1hdhzQsgDq2srUoyP8NTynD5l3wrQh7IMjG9yQn24GmLBcCgZ
        OlE3tzeDSKB82Tl8pXmxBzFZMxD1iHWIr3caIQl0mqcqXGho9WDepW6tq+pT/LeFYG7Kih
        MRsNkfUpwsAVuDtdlJPtq6sOCXh/1TI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-7vRsxcciO_yf_1g8f6Qrzw-1; Thu, 03 Sep 2020 09:09:42 -0400
X-MC-Unique: 7vRsxcciO_yf_1g8f6Qrzw-1
Received: by mail-ej1-f72.google.com with SMTP id gt18so1177763ejb.16
        for <linux-pwm@vger.kernel.org>; Thu, 03 Sep 2020 06:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oOKwAmzdX19wFLaLs6FnpWqrSpxl3eshTWS+wqlIdDI=;
        b=srQJwaWAgexGuSo3hP5dBfcqLd2EirOPdjKjTUQV5bq7pL6WUt3TphA8KJsWX1BII4
         Q26KK2Z+SGoJ8v523w/gQPLi7fWhOd5q+47GwZZDhyrR8PNfMzNWokwf3IKBFJQYnoAw
         RYWzT1UtXMmLIL+jihGNH3LAy732ifrZszvyPV0o1GerPFV77L+qb5320EZCLR0KJkii
         tBoMPrXsmR84TJnhTxjsGXadav9hmBKjUXN/LqDiPIGVPI0/gTXpk1q4EfA4LbYD/lAX
         LbBOmltmIkXrRIUEk3Egc5gOy3WhtJoCglEESZOMgWyV83rExW9I/D1p8qEpze2IVI65
         TouQ==
X-Gm-Message-State: AOAM533lQWK67ZmotVrh+7JgsPkZDE7dSOrUSEDzoL8+q3Ce6nYdND4B
        JrUnrOhO6p9D4p5UkSlsz1+wfsa8NUd1zi+if6ky4qv1O/s+Pmqj44Ha/HTnwZK2Bt4uzvZh7v7
        HL2mrzgBiudqdlot4bbMx
X-Received: by 2002:a17:906:d282:: with SMTP id ay2mr1910844ejb.265.1599138581377;
        Thu, 03 Sep 2020 06:09:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4WbCzGSIX11Eb7tLYhakyrPDa74ODNUuKAajKTh1x+4i7BJ6ADpqdzqIF9xQvFCK8/v6JPQ==
X-Received: by 2002:a17:906:d282:: with SMTP id ay2mr1910818ejb.265.1599138581124;
        Thu, 03 Sep 2020 06:09:41 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id v7sm3391177edd.48.2020.09.03.06.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:09:40 -0700 (PDT)
Subject: Re: [PATCH v10 07/17] pwm: lpss: Remove suspend/resume handlers
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
References: <20200903112337.4113-1-hdegoede@redhat.com>
 <20200903112337.4113-8-hdegoede@redhat.com>
 <20200903124816.GA1891694@smile.fi.intel.com>
 <20200903125620.GB1891694@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <63bf5fd7-148e-262a-4076-66d2ffb58557@redhat.com>
Date:   Thu, 3 Sep 2020 15:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903125620.GB1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 9/3/20 2:56 PM, Andy Shevchenko wrote:
> On Thu, Sep 03, 2020 at 03:48:16PM +0300, Andy Shevchenko wrote:
>> On Thu, Sep 03, 2020 at 01:23:27PM +0200, Hans de Goede wrote:
> 
>> the question is do we need to have similar in acpi_lpss.c?
>> For example,
>> 	static const struct lpss_device_desc byt_pwm_dev_desc = {
>> 		.flags = LPSS_SAVE_CTX,
>> 		^^^^^^^^^^^^^^
>> 		.prv_offset = 0x800,
>> 		.setup = byt_pwm_setup,
>> 	};
>>
>> 	static const struct lpss_device_desc bsw_pwm_dev_desc = {
>> 		.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
>> 		^^^^^^^^^^^^^^
>> 		.prv_offset = 0x800,
>> 		.setup = bsw_pwm_setup,
>> 	};
> 
> Okay, it's a private space which has clock and reset gating, so means we still
> need to handle it.

Right I was about to say the same.

As always, thank you for your reviews.

Regards,

Hans

