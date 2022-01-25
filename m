Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D3349BE8D
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jan 2022 23:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiAYWbn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jan 2022 17:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiAYWbN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jan 2022 17:31:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F26C06173B;
        Tue, 25 Jan 2022 14:31:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bu18so59522346lfb.5;
        Tue, 25 Jan 2022 14:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kFws1QLJmF8QvPwvGdGpgANuRMNXQI7O3lc1ZgK0808=;
        b=CiVCT6P4dbrpGhRGlDZy/FPU+hMyzuUu7NNLjv5d8UIMkK142lx8JrbsdK0GzrDDXK
         ljApLX3uC1/tCsZzeonHXh1kRu8n24dAm/mhzQypP/0syG0GBKLv78Sy73ANqSHckG1V
         k9+gdmwZ9TR11OTq3f/d5PngjR0DpmA02+nJfxHG2NtbpKwXcRzQGDOUTdt6EyqUoJUL
         h4qV6NMvQtf8OuQPMJYLqtprpE1rNMwfPqpmV3WWYsb8oU/4VsOQvXPwkKAZ83rE0jlB
         CI9lOOWDm2e97HcG5TSBrVNZaF45QlM/t0Xq2s3JTl068MRpC6Oc7/bQnJX7PmVa+907
         1wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFws1QLJmF8QvPwvGdGpgANuRMNXQI7O3lc1ZgK0808=;
        b=cV4eEgMZSZhHK+wem/ZDeu74ZL1rU5zj8pa7Aq+qXNSTIB1Filp7XDC0o2Z3cXBbqv
         F0+g0FQHh6+jPkPl17d/qnMZ/OfQi3G3VpRfDWBXOXuYD41qvWTH9mhosur8jTYQdr6W
         UqcgB25c1uO40/NvfoAWLUnRQ3v2T6hZJm1WYQ+ietrIvmeZXzJyBbOXoNYQ4mmnZ+SH
         qQVJUYBiS51GPIo7eF8bd26amtKH1+sauAhBp/4vnW3H7vpPvCneUH93OorZaEu5Sldb
         O0UJIsD4In9hsDj2yPLj+Supw/LkuzFh/ZQRFgJ/cH2niFUS+NpximefoBzwS2X2BT0J
         Y4Tg==
X-Gm-Message-State: AOAM53360vuX7a/jRcxiHU3gS/ghfVFqjRgdvtEEFWSZDoVz0APIj9+N
        uOI7NZExJfCcfUlVA1T0ew0=
X-Google-Smtp-Source: ABdhPJzdnomD2rsPejlQnHfqDjj/c3/hiPJ0WdomR6AxWQMolYRJKydeOGTcpNgtVT1+Ri7pLYybcw==
X-Received: by 2002:a19:ca5e:: with SMTP id h30mr18559729lfj.442.1643149871235;
        Tue, 25 Jan 2022 14:31:11 -0800 (PST)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id cf32sm161311lfb.133.2022.01.25.14.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jan 2022 14:31:10 -0800 (PST)
Subject: Re: [RFC PATCH 0/2] Multicolor PWM LED support
To:     sven@svenschwermer.de, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        pavel@ucw.cz, dmurphy@ti.com, robh+dt@kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org
References: <20220125092239.2006333-1-sven@svenschwermer.de>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <a147897a-2823-ad45-d727-0b96f48b4da3@gmail.com>
Date:   Tue, 25 Jan 2022 23:31:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125092239.2006333-1-sven@svenschwermer.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Sven,

On 1/25/22 10:22 AM, sven@svenschwermer.de wrote:
> From: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> 
> Hi,
> 
> As previously discussed [1] on the linux-leds list I am missing
> multicolor PWM LED support. In the mean time I have put together a
> working prototype for such a driver. This is my first Linux driver
> so I'm hoping for some feedback. Here are some questions that came up
> while putting this thing together:
> 
>    1. Currently, the max-brightness property is expected as a property to
>       the multi-led node. That seems consistent with the existing
>       multicolor class code, but I'm wondering whether it would make
>       sense to have a max-brigthness for the individual LEDs as well?

For the proper mixed color calculation all sub-leds should have
the same max_brightness as the global max_brightness.

Look at how sub-led intensities are calculated in
led_mc_calc_color_components().

See also [0] and [1].

>    2. The current multi-led node definition calls for a node index which
>       would in turn require the reg property to be set within the node.
>       In this context, that doesn't seem to make sense. Should this
>       requirement be lifted from leds-class-multicolor.yaml?

reg is required for all DT nodes with address unit in the name.
If you skipped the address unit, then reg would be also not required.

>    3. I'm not currently reusing any leds-pwm code because there aren't
>       too many overlaps. Does anyone have suggestions what could be
>       factored out into a common source file?

I think that having a separate pwm driver for multicolor LEDs is a good
idea. leds-pwm.c is old and well tested driver, there's no need to
tinker at it for no vital reason. And there is not much code to share
as you've noticed.

> I would appreciate if anyone would test this code. It runs on my
> i.MX6ULL-based hardware.
> 
> Best regards,
> Sven
> 
> [1]: https://www.spinics.net/lists/linux-leds/msg19988.html
> 
> Sven Schwermer (2):
>    dt-bindings: leds: Add multicolor PWM LED bindings
>    leds: Add PWM multicolor driver
> 
>   .../bindings/leds/leds-pwm-multicolor.yaml    |  73 +++++++
>   drivers/leds/Kconfig                          |   8 +
>   drivers/leds/Makefile                         |   1 +
>   drivers/leds/leds-pwm-multicolor.c            | 184 ++++++++++++++++++
>   4 files changed, 266 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
>   create mode 100644 drivers/leds/leds-pwm-multicolor.c
> 

[0] Documentation/ABI/testing/sysfs-class-led-multicolor
[1] Documentation/leds/leds-class-multicolor.rst

-- 
Best regards,
Jacek Anaszewski
