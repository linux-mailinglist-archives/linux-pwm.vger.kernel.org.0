Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C161F7C13
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2020 19:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgFLRFE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Jun 2020 13:05:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgFLRFD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Jun 2020 13:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591981501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJhsLiuB5MJfhLZW+3GQ1NI8Ulud2FZJOWodXiS4/hM=;
        b=GrMKhxoA5BPGN4S3LbPTPHTHDRpr2I+6DyNrnhpd1kzZLOsggO2sprbFsj4+i4Ao8NWkN0
        GokV0a7QPeMXnyRClN8O15tsqaRtcw3KlOlNyGiibRkdXbzFMoNPuo1Vf3pqPTvN5dsKtY
        ezbvXqBnlVi52ojMQxReO1q2wpCB8bM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-bq4UNpwUMkO8CEz_Zl6Cxw-1; Fri, 12 Jun 2020 13:04:54 -0400
X-MC-Unique: bq4UNpwUMkO8CEz_Zl6Cxw-1
Received: by mail-ed1-f72.google.com with SMTP id 92so3154584edl.8
        for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2020 10:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aJhsLiuB5MJfhLZW+3GQ1NI8Ulud2FZJOWodXiS4/hM=;
        b=TqmhtR4oUPF0sFtD3kHeTOaQtH2OCI+Y4nz44Ob/G8E7qp4KdEUPV33JjxG2zfU7Wf
         Ivn1dtmxhh4KeAmjlsCXQAc0nFJszrsSJ1AKAt36XWzXhxCb2dGlBJ/8dd5EMXgS2S4K
         YmC1z50cGP12H08GTpUVP/Du/SAVfw74Im1ea4l2yff/6GKTHHDFdBtdBJw/vKKWczL8
         mSGxPawrjOqBgiDxLL8K2754zdeXfpzGPSHL7IIUN4Aai4zS8L4jQP64fmZOs78XCo85
         VCmt4MjcS/LkJgkeambwRc/+PN3JVOlLiG6UPy5cgC0AVKKLcNW0gSJHBAJG6ScwIrCT
         mS2g==
X-Gm-Message-State: AOAM532i7RxfQGIF5hMWxauVOknaTwfrzqXiDztGvTfVTe+5BzdTx4Zi
        p64bYrqBIzGk20LT1Q996Uf7/CJdjwChHqMhERY6o6LlH35VKj524MRAOVCHqLK31j74T4VYgrE
        gz1LRgFSfB6s56GeasUtp
X-Received: by 2002:a17:906:3041:: with SMTP id d1mr14497140ejd.7.1591981493679;
        Fri, 12 Jun 2020 10:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8/X6kVaFS8fcJPbnnHMtvzqT2kk50X8Vfwy3lEhe+LE8MdjUbh7IV+C3pCB1j1LapjG6OZw==
X-Received: by 2002:a17:906:3041:: with SMTP id d1mr14497118ejd.7.1591981493412;
        Fri, 12 Jun 2020 10:04:53 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id o5sm3842626eje.66.2020.06.12.10.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 10:04:52 -0700 (PDT)
Subject: Re: pwm/i915: Convert pwm-crc and i915 driver's PWM code to use the
 atomic PWM API
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
 <20200608143500.GX20149@phenom.ffwll.local>
 <20200611212144.i7ma7kriznidds4r@taurus.defre.kleine-koenig.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <58972efb-003d-ca87-0637-ece4c93aeeb5@redhat.com>
Date:   Fri, 12 Jun 2020 19:04:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611212144.i7ma7kriznidds4r@taurus.defre.kleine-koenig.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 6/11/20 11:21 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jun 08, 2020 at 04:35:00PM +0200, Daniel Vetter wrote:
>> On Sat, Jun 06, 2020 at 10:25:45PM +0200, Hans de Goede wrote:
>>> Hi All,
>>>
>>> This patch series converts the i915 driver's cpde for controlling the
>>> panel's backlight with an external PWM controller to use the atomic PWM API.
>>>
>>> Initially the plan was for this series to consist of 2 parts:
>>> 1. convert the pwm-crc driver to support the atomic PWM API and
>>> 2. convert the i915 driver's PWM code to use the atomic PWM API.
>>>
>>> But during testing I've found a number of bugs in the pwm-lpss and I
>>> found that the acpi_lpss code needs some special handling because of
>>> some ugliness found in most Cherry Trail DSDTs.
>>>
>>> So now this series has grown somewhat large and consists of 4 parts:
>>>
>>> 1. acpi_lpss fixes workarounds for Cherry Trail DSTD nastiness
>>> 2. various fixes to the pwm-lpss driver
>>> 3. convert the pwm-crc driver to support the atomic PWM API and
>>> 4. convert the i915 driver's PWM code to use the atomic PWM API
>>>
>>> So we need to discuss how to merge this (once it passes review).
>>> Although the inter-dependencies are only runtime I still think we should
>>> make sure that 1-3 are in the drm-intel-next-queued (dinq) tree before
>>> merging the i915 changes. Both to make sure that the intel-gfx CI system
>>> does not become unhappy and for bisecting reasons.
>>
>> Simplest is if acpi acks the acpi patches for merging through
>> drm-intel.git. Second simplest is topic branch (drm-intel maintainers can
>> do that) with the entire pile, which then acpi and drm-intel can both pull
>> in.
>>
>> Up to the two maintainer teams to figure this one out.
> 
> I'm unclear about the dependencies

There is a runtime dependency of the i915 changes on the PWM changes
and since the intel-gfx folks use a lot of CI, we this need to get the
PWM changes into the drm-intel tree before the i915 changes can land.

> , but the changes to drivers/pwm need
> an ack (or processing) by the PWM team.

Of course, I asked for an Acked-by from the PWM team
(once this passes review) for merging this through
the drm-intel tree, as the i915 driver is the main
(only AFAIK) consumer of the PWMs controlled by these
2 drivers.  Daniel <snip>-ed that bit when he replied.

Regards,

Hans

