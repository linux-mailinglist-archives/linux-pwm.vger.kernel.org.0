Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446CA231C21
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 11:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgG2Jcg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 05:32:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48652 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbgG2Jcf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Jul 2020 05:32:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596015153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B3NdEtEPvq/yTFpK5ZmTixdu7Jx259zTegavJvefnOg=;
        b=c6b2uohN5nLPDuYjHEtKHCB20IEUsxzsCR6UlA5FSeMBc1ral9LJlQMNmOWANOzsf+SXVJ
        /9vfA9GiyyzNCUQxBumHIeTLRh3CM/21lOWu57wOheh6GigmA82YuIMVmc0bmqsDjOl9ZZ
        g5xcWZYsK/F4UBXozjoLBHs75zJj614=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-SMXqokG1O1OJDFBtMme7IA-1; Wed, 29 Jul 2020 05:32:31 -0400
X-MC-Unique: SMXqokG1O1OJDFBtMme7IA-1
Received: by mail-ed1-f69.google.com with SMTP id b23so5898359edj.14
        for <linux-pwm@vger.kernel.org>; Wed, 29 Jul 2020 02:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B3NdEtEPvq/yTFpK5ZmTixdu7Jx259zTegavJvefnOg=;
        b=RUX7BtuvCdpk2sRzAX/n2WmieYdVYUPGR9iik8mo9SD9sZl2ORgdxEkX/IvhFlUCpF
         7mvp2tOd4t0R1QErrsmfdyseGK6FWwIhtOHv29IFq9jAmJsQ9+6SBBpDcSlSzg9Zyjx7
         V4OXex4O+AB0zjKQkPnDs9UhFaYnhT1f1YnGQaAbhS7OutBATAbcVroo+KUqaf+vZeIl
         cwZuQA0ScTvrsPhQS36o9tejiOnRR4Ens1CYKaofHGdMR2cWCrcMm2hl17M/aOujLs37
         kNe1rcEiLunJNB0D/PO9GUU4ovkbqYwqh26CBb/LWEBuE+avVGD7DxTUMbfvNWoVSB9N
         QSgg==
X-Gm-Message-State: AOAM533R8fG9JvPpi6vxM07KuXVQbg7X0HrK7HKgh7eiIWT5WMR1NOg+
        xSIdfUyQuaCPh4t2yaSqKv+MWOE7ET7UndeBQdmU31K9aCAPAchtlKPk/RHml6YqYqsieClZZgj
        NtTzGk/TSSDNjyQ4OI8f+
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr28993961eji.471.1596015150715;
        Wed, 29 Jul 2020 02:32:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKBgqFRqaTJ3qOVm6sY5SeNDR02oRp8D5ppn0kjXKSLnxPuYsSA12NdfHTt3eZGDVnbgnbuw==
X-Received: by 2002:a17:906:3e54:: with SMTP id t20mr28993942eji.471.1596015150448;
        Wed, 29 Jul 2020 02:32:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a18sm1236467ejt.69.2020.07.29.02.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 02:32:29 -0700 (PDT)
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915 driver's
 PWM code to use the atomic PWM API
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
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
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200727074120.GB2781612@ulmo> <20200729082305.GK3703480@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b87c535a-022f-2894-1e38-5be035c6fbfc@redhat.com>
Date:   Wed, 29 Jul 2020 11:32:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200729082305.GK3703480@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

cHi,

On 7/29/20 10:23 AM, Andy Shevchenko wrote:
> On Mon, Jul 27, 2020 at 09:41:20AM +0200, Thierry Reding wrote:
>> On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:
> 
>> I've applied patches 3 through 12 to the PWM tree. I thought it was a
>> bit odd that only a handful of these patches had been reviewed and there
>> were no Tested-bys, but I'm going to trust that you know what you're
>> doing. =) If this breaks things for anyone I'm sure they'll complain.

Thank you for picking up these patches, but ...

> Can we postpone a bit?

I have to agree with Andy here, as mentioned my plan was to push the
entire series through drm-intel-next-queued once the last few PWM
patches are reviewed.

There are some fixes, to the pwm-crc driver which change behavior in
a possibly undesirable way, unless combined with the i915 changes.

E.g. there is a fix which makes the pwm-crc driver actually honor
the requested output frequency (it was not doing this due to a bug)
and before the i915 changes, the i915 driver was hardcoding an output
freq, rather then looking at the video-bios-tables as it should.

So having just the pwm-crc fix, will change the output frequency
which some LCD panels might not like.

Note things are probably fine with the hardcoded output freq, but I
would like to play it safe here.

Also Andy was still reviewing some of the PWM patches, and has requested
changes to 1 patch, nothing functional just some code-reshuffling for
cleaner code, so we could alternatively fix this up with a follow-up patch.

Either way please let us know how you want to proceed.

>> That said I see that Rafael has acked patches 1-2 and Jani did so for
>> patches 13-16. I'm not sure if you expect me to pick those patches up as
>> well. As far as I can tell the ACPI, PWM and DRM parts are all
>> independent, so these patches could be applied to the corresponding
>> subsystem trees.
>>
>> Anyway, if you want me to pick those all up into the PWM tree, I suppose
>> that's something I can do as well.

drm-intel-next-queued is usually seeing quite a bit of churn, so the i915
patches really should go upstream through that branch.

Regards,

Hans

