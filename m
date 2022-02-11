Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3147F4B252F
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Feb 2022 13:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbiBKMGE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Feb 2022 07:06:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiBKMGD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Feb 2022 07:06:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8B88F59
        for <linux-pwm@vger.kernel.org>; Fri, 11 Feb 2022 04:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644581161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BASHV7aFfw3qHYbxs7gIYxsZkBm2pYuduv5XXGleEkc=;
        b=Lg1CNixSW3/U5mGxbr0OPUFlwnvdiOjWoGeolxFq0lyRs0mUNabd4UTIL8PQGaNKyI21EA
        Ahg23A/P1/BvEGyYJMkkNFcyJ4+fN1dohEUvp+6Aw5iMy4BcGIpbPQ7FxmPyXpgNEnl0IS
        r+vyKHUZj4/PpxnkPmdHSdv+ssWb+o0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-M6er4VqyPGiNsy9ywl22Rg-1; Fri, 11 Feb 2022 07:06:00 -0500
X-MC-Unique: M6er4VqyPGiNsy9ywl22Rg-1
Received: by mail-wm1-f72.google.com with SMTP id p24-20020a05600c1d9800b0037be98d03a1so5236810wms.0
        for <linux-pwm@vger.kernel.org>; Fri, 11 Feb 2022 04:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BASHV7aFfw3qHYbxs7gIYxsZkBm2pYuduv5XXGleEkc=;
        b=zbYdLhKpW01QK75p4Y8+2oFQLJ29IPF6NL85EF+xTKJlghXP3FOTzuhNG2nPqzSWXi
         w4Wb4sk7X6S9U0ULgF4zn6GIME3S9tuhJdT6IwzHnN3De8MXzVOh1V28yzva7+PEtJkB
         4yFZZk73rUopKYgmIrsG+THYve6aF2IfKzfnAT5oBmWkT4WclSyFhFtW2IWrPdGFLPCC
         zcxRzpMZ6EFoDrf4uFr+SCb+9wpW/4l1njENXvcu2PpwOVkVyf3XmfMwEORknj144aPE
         4Hirw3t+A/NgjF8DzkMcmSwHqSPhr5n5w0gTy9L6pkVCBOvdKv5zuqi1SD/+2JMPZmOM
         ykow==
X-Gm-Message-State: AOAM532p34i3EwCTQnu/RYPG8abl3gadUuJzo10jFMR1dLhz7UaU5IJB
        5FO4IsPZByDVslb6moesMDJEQ5y4uSrlsJHijPJ2OGXBU5gJCWFxuVidNO/XoCwdbENlf4FrIJ4
        zaoLII0BoI2dghLADGBYs
X-Received: by 2002:a5d:5692:: with SMTP id f18mr1182596wrv.285.1644581159523;
        Fri, 11 Feb 2022 04:05:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/wwEdn1CDOpccM3hGHhbtDnjh87iUZ0MvvFV8jLkai8DaWkcExzOlYAiyBmaBdWNEv6pKZQ==
X-Received: by 2002:a5d:5692:: with SMTP id f18mr1182575wrv.285.1644581159299;
        Fri, 11 Feb 2022 04:05:59 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g8sm1531531wrd.9.2022.02.11.04.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:05:59 -0800 (PST)
Message-ID: <eed8200c-7716-ce4f-dac5-bd6f0345b631@redhat.com>
Date:   Fri, 11 Feb 2022 13:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
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
        linux-pwm@vger.kernel.org
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-4-javierm@redhat.com>
 <YgZJpi4llqr93U9Y@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YgZJpi4llqr93U9Y@smile.fi.intel.com>
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

On 2/11/22 12:33, Andy Shevchenko wrote:
> On Fri, Feb 11, 2022 at 10:19:24AM +0100, Javier Martinez Canillas wrote:
>> This adds a DRM driver for SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
>> OLED display controllers.
>>
>> It's only the core part of the driver and a bus specific driver is needed
>> for each transport interface supported by the display controllers.
> 
> ...
> 
>> +#include <linux/backlight.h>
>> +#include <linux/bitfield.h>
> 
> bits.h

Ok, missed that both weren't in the same macro.

> (FYI, specifically sent a patch few days ago to add explicitly the inclusions
>  that needed for bitfield operations in the example inside bitfield.h).
> 
>> +#include <linux/delay.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/property.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regulator/consumer.h>
> 
> ...
> 
>> +#define SSD130X_SET_ADDRESS_MODE_HORIZONTAL	(0x00)
>> +#define SSD130X_SET_ADDRESS_MODE_VERTICAL	(0x01)
>> +#define SSD130X_SET_ADDRESS_MODE_PAGE		(0x02)
>> +
>> +#define SSD130X_SET_AREA_COLOR_MODE_ENABLE	(0x1e)
>> +#define SSD130X_SET_AREA_COLOR_MODE_LOW_POWER	(0x05)
> 
> Do the parentheses add anything here?
>

Not really, the fbdev driver used it and I understood that was
a convention to denote that these are command options and not a
command or register. I'll drop them.

> ...
> 
>> +/*
>> + * Helper to write command (SSD130X_COMMAND). The fist variadic argument
>> + * is the command to write and the following are the command options.
> 
> This is not correct explanation. Please, rephrase to show that _each_ of the
> options is sent with a preceding command.
>

It's a correct explanation IMO from the caller point of view. The first argument
is the command sent (i.e: SSD130X_SET_ADDRESS_MODE) and the next ones are the
the command options (i.e: SSD130X_SET_ADDRESS_MODE_HORIZONTAL).

The fact that each command and options are preceding with a SSD130X_COMMAND
value is part of the protocol of the device and a detail that's abstracted
away by this helper function to the callers.

>> + */
>> +static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
>> +				    /* u8 cmd, u8 option, ... */...)
>> +{
>> +	va_list ap;
>> +	u8 value;
>> +	int ret;
>> +
>> +	va_start(ap, count);
>> +
>> +	do {
>> +		value = va_arg(ap, int);
>> +		ret = regmap_write(ssd130x->regmap, SSD130X_COMMAND, (u8)value);
>> +		if (ret)
>> +			goto out_end;
>> +	} while (--count);
>> +
>> +out_end:
>> +	va_end(ap);
>> +
>> +	return ret;
>> +}
> 
> ...
> 
>> +	if (ssd130x->device_info->need_pwm) {
> 
> Yeah, unfortunately we still don't have pwm_get_optional()...
> 
>> +		ret = ssd130x_pwm_enable(ssd130x);
>> +		if (ret) {
>> +			dev_err(dev, "Failed to enable PWM: %d\n", ret);
>> +			regulator_disable(ssd130x->vcc_reg);
>> +			return ret;
>> +		}
>> +	}
> 
> ...
> 
>> +static void ssd130x_power_off(struct ssd130x_device *ssd130x)
>> +{
> 
>> +	if (ssd130x->device_info->need_pwm) {
> 
> Redundant check. The two below are NULL-aware.
>

Ok, I'll drop it.

>> +		pwm_disable(ssd130x->pwm);
>> +		pwm_put(ssd130x->pwm);
>> +	}
>> +
>> +	regulator_disable(ssd130x->vcc_reg);
>> +}
> 
> ...
> 
>> +	ret = ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_COM_PINS_CONFIG, compins);
>> +	if (ret < 0)
>> +		return ret;
> 
>> +
>> +
> 
> One blank line is enough.
>

Indeed, that was a left over when changing this to use the macros.
 
> ...
> 
>> +	for (i = y / 8; i < y / 8 + pages; i++) {
>> +		int m = 8;
>> +
>> +		/* Last page may be partial */
>> +		if (8 * (i + 1) > ssd130x->height)
>> +			m = ssd130x->height % 8;
> 
> Perhaps it can be moved out of the loop with refactored piece below.
>

Not sure I'm following since it depends on the for loop iterator value.

[snip]

>> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
>> +					    &ssd130xfb_bl_ops, NULL);
>> +	if (IS_ERR(bl)) {
> 
>> +		ret = PTR_ERR(bl);
>> +		dev_err_probe(dev, ret, "Unable to register backlight device\n");
>> +		return ERR_PTR(ret);
> 
> 		dev_err_probe(dev, PTR_ERR(bl), "Unable to register backlight device\n");
> 		return bl;
> 
> ?

No, because this function's return value is a struct ssd130x_device pointer,
not a struct backlight_device pointer.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

