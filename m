Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53221549D9C
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jun 2022 21:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350388AbiFMTZY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Jun 2022 15:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243600AbiFMTZH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Jun 2022 15:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BD0537A84
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jun 2022 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655142090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9imHR0PldrK/4QqffqMQG4YlpeKi0rN5tf1tCAqvxI=;
        b=OfLxLKMmXh1S0JEAwuW9kESxX/WmvV01sGlNpabaDxngbFrcIEHSG/5Fkm581Wd2AvJodx
        IQVrUHuwGIKNdBkaL7D8xdVWIAU2Hq3X5lUoWk55A2iwasA5NQz3M4jTNc1hKEoqJopw8A
        xF1Ia0qB9fKRr0O0qyctqVGEdnh8MNc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-xCDx9VKwMLGJSSQBNi3WIQ-1; Mon, 13 Jun 2022 13:41:29 -0400
X-MC-Unique: xCDx9VKwMLGJSSQBNi3WIQ-1
Received: by mail-wm1-f71.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso6236974wms.0
        for <linux-pwm@vger.kernel.org>; Mon, 13 Jun 2022 10:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=q9imHR0PldrK/4QqffqMQG4YlpeKi0rN5tf1tCAqvxI=;
        b=kMRdGUgrtpIDx4Mw695f8EzMmuBLs/oJXIPEWIgdq3ZlWdesF+Jg7Tp0WGRBliNx+P
         5rW2qPs+Iwf77368hU3G0FPIQaaOTCMjOQ1xluOnNMeQ+JcG6DavERluqdY9FIwgj8dj
         P6W5MNgJQkDXh079FNYYx4CrgXrtD4SX0BmtCOAOZ3/HjFhYAh7Le0RFzT5DGdJFw1Ha
         h3jp4JqO+xJt6LcCJ3bxlV06smM8XEZdUsJUlWl3/jdhpwaPLLgecmfQB3KYuyAzfq1b
         1EQ0/MkOm4UUhgOBwFy1Dd6rTpSZ45hQOeNpz9FOhuRTeEGQOcPTPgPPJNpwt0aj9rCV
         Eu3g==
X-Gm-Message-State: AOAM533JG0yo5zASIN40Gtk6aAHYhA/1wzO5zItVRg1oRZZmCYNX2arc
        9VoqkMRMmV7wcMdd866g0E2sLLec3R9gUcNmTYzCi/ha4NOtqiJ/+mMbXcGkBm8yK5xColreC4c
        ZusB2oBBLm2EUACIrqoVk
X-Received: by 2002:a7b:c389:0:b0:39c:49fe:25df with SMTP id s9-20020a7bc389000000b0039c49fe25dfmr648454wmj.164.1655142087967;
        Mon, 13 Jun 2022 10:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOHYbSdU3QvmmoWgh9ozEuOjCqKEtc/UugRXjsMVcbeHCAdcofLjg4QDbLTxfNrnseTW/13Q==
X-Received: by 2002:a7b:c389:0:b0:39c:49fe:25df with SMTP id s9-20020a7bc389000000b0039c49fe25dfmr648438wmj.164.1655142087759;
        Mon, 13 Jun 2022 10:41:27 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b0020c5253d90asm9201616wrx.86.2022.06.13.10.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:41:27 -0700 (PDT)
Message-ID: <8cbfcc29-bc31-9bc8-2eaa-d873f7cf2d5f@redhat.com>
Date:   Mon, 13 Jun 2022 19:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Dominik Kierner <dkierner@dh-electronics.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>
References: <7a78d57342754a5d9bd3ce7c7bf3fa47@dh-electronics.com>
 <YqdZN6mtEDF2CRtS@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YqdZN6mtEDF2CRtS@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 6/13/22 17:35, andriy.shevchenko@linux.intel.com wrote:
> On Mon, Jun 13, 2022 at 11:39:30AM +0000, Dominik Kierner wrote:
>> On 5/25/2022 21:46, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> Thanks, I looked at the code briefly and think that there are things there that we
>>> could use. I.e the 3-wire SPI support that's in panel-solomon-ssd130x-spi-3wire.c.
>>
>> When writing my driver code, I wasn't even considering using regmaps,
>> like You did in Your I2C-Code. If that's applicable for 3-wire-SPI,
>> it would likely be the better, more generic option. Your SPI-code
>> reuses these parts to some extent. For that case,
>> ssd130x_spi_regmap_config.reg_bits would need be changed to 1,
>> as the "register address" has a length of 1 bit and we are sending
>> 9 bits over the line and not 16.
>> Since we still have 2 bytes of host memory,
>> it should still be compatible with the 4-wire write, right?
>> Or would 3-wire SPI require a second regmap?
> 
> I believe the cleanest solution is to have different regmap configurations.
> 

I agree with this.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

