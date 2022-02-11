Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DCA4B25B3
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Feb 2022 13:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350066AbiBKM11 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Feb 2022 07:27:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350073AbiBKM1Y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Feb 2022 07:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26E39F71
        for <linux-pwm@vger.kernel.org>; Fri, 11 Feb 2022 04:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644582437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1jepOygsJ0wYycqVUlKRQbdzNQ74bbTHpehDmycDkk=;
        b=WIsk39RA4IR9AQTDFPqzJI+QZ2R3dsAab1+W0DUUmw44bo4hAJY6ueIu/9mQg7KuK0yeHB
        24M9tbWXevGaX/jLcxYAsDLHTdGPCAnhuhg5HDeaOVSPFyPTZXWhQ4htRxqlRB1DM2fI34
        5jyxCtfzNmKQ6f8ZFjCbbRmgSF13FSo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-3LiFIvG8OniEm7YGxBWAXA-1; Fri, 11 Feb 2022 07:27:16 -0500
X-MC-Unique: 3LiFIvG8OniEm7YGxBWAXA-1
Received: by mail-wm1-f70.google.com with SMTP id r8-20020a7bc088000000b0037bbf779d26so2441254wmh.7
        for <linux-pwm@vger.kernel.org>; Fri, 11 Feb 2022 04:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r1jepOygsJ0wYycqVUlKRQbdzNQ74bbTHpehDmycDkk=;
        b=x4Y3ls8ZW32qDqdxEoDpZKYpenqcMWP1P1ReRGRIT++/LOsVa80rJPk82eLHOJ2NuE
         QAIMZK3sdwmexmTcBycvadrCxKoLv5w9KC/pHW6GrM6bXP2itnMPbsU9drBZXo8/g22P
         YC458aGmNEm0Rg+X3eYcqM4DZDpDw+F51FoKrzeuhyXMDRHXZSleLU8FM6v5MgCYY0sg
         zt25HlKwryA8bXjqmChhl5Vs5o/0M0fU9LELf6O3YnxQfJ53D8AZY9lZGyso6C9HFwPZ
         VTpHT+POLAhw9CWwxoCmOYpAgbwec0NXPshCU12gUEHw5lkiB8Cy/t5KjF5vfMdczEvj
         uItw==
X-Gm-Message-State: AOAM531r05a8kU4IJlPCc0N/FwhULAnUysvfDTAB9+SjPbIAv/54nyge
        uu3BmmziHE/v44zS33Rk3RCVhdeF53xe4U/rGS6LfSwMgIVQ5LZ2eKyP2qIIqQErKz++3feOWcF
        nBXZtTxpZl0+fCYeQI6vF
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr123175wmq.44.1644582434747;
        Fri, 11 Feb 2022 04:27:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyaaXjuAalsbgKE6EbrXu5SqtOSmJENkbXZFXygd5mgtIEYu0s5C8pQoelvrRAkNY3tZZipuA==
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr123141wmq.44.1644582434492;
        Fri, 11 Feb 2022 04:27:14 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t18sm22645638wri.34.2022.02.11.04.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:27:14 -0800 (PST)
Message-ID: <5b451266-0217-fc4c-794b-453c4e6439f6@redhat.com>
Date:   Fri, 11 Feb 2022 13:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-4-javierm@redhat.com>
 <YgZJpi4llqr93U9Y@smile.fi.intel.com>
 <eed8200c-7716-ce4f-dac5-bd6f0345b631@redhat.com>
 <CAMuHMdVLmUwgCWui4OiZqvqpVWzA-d9QhjZLa_idgC19XeEEjA@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVLmUwgCWui4OiZqvqpVWzA-d9QhjZLa_idgC19XeEEjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Geert,

On 2/11/22 13:23, Geert Uytterhoeven wrote:

[snip]

>>>> +    if (IS_ERR(bl)) {
>>>
>>>> +            ret = PTR_ERR(bl);
>>>> +            dev_err_probe(dev, ret, "Unable to register backlight device\n");
>>>> +            return ERR_PTR(ret);
>>>
>>>               dev_err_probe(dev, PTR_ERR(bl), "Unable to register backlight device\n");
>>>               return bl;
>>>
>>> ?
>>
>> No, because this function's return value is a struct ssd130x_device pointer,
>> not a struct backlight_device pointer.
> 
> Hence
> 
>     return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
>                                  "Unable to register backlight device\n"));
> 
> ?
> 

Thanks, that would work.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

