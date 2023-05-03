Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96EA6F5DB9
	for <lists+linux-pwm@lfdr.de>; Wed,  3 May 2023 20:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjECSQL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 May 2023 14:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjECSQK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 May 2023 14:16:10 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300E02698;
        Wed,  3 May 2023 11:16:08 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ec8133c59eso6481574e87.0;
        Wed, 03 May 2023 11:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683137766; x=1685729766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9yiKwuZiEdXJrF/1rUslwvmYmxkjetYRDuNTZSaxYQw=;
        b=gATGtv97fWbahCxBOgzaiFbZU4Pzqk6UNyZW3zqdNwFNGQ6A5ACRZbJpVQH3f5UcA/
         q3aObt9nJOAyJXzz3pdPWWqLGVycIcqGsOscThesaoMBdeVgDZ2beXizG24AhyxJo1+D
         ojgYu7ykLy/bEWbGI7zcfbBhlinhchxHBJ4B/yW0aLh52JdzqUSb2RmPs5qgZUPV4QPx
         0h5Ump8ONW+g6zWGAbjFrGuVQ5O/dJex6wpWvSrJA7fCd4OZfjaawBnBvBWiUf5yR2Kq
         ZGg+4nYv3vSX518VVV6zfyqjS7Ghy5MC/INaHXuE1nk3AzCqEJ48+CjUltaLaOcs43hf
         Rx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683137766; x=1685729766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yiKwuZiEdXJrF/1rUslwvmYmxkjetYRDuNTZSaxYQw=;
        b=hU2qXtgKcVsLM1qKGaS+JkfG6Y22ZSGAhGCxIBx7jzzKBkSe5qCad+Q156Hm1s2oaA
         BHc1rPUuNWeW7IH5dLc2xMOSt2Lgw2ul46u523hCy8FEV13hBRMvu3X3WGVMr6ud1+Ay
         K6+UkrZcng+0b16plp/N1gufn7t6DGQnGTEvs3/34bxWB5/9S05/iT/O+ZmwmP25ZOUA
         o4mOnQHdWrFP+0hxYSqiKZkdc1jCc0IyoQlZeaaNjZ8SaTP+2glc3B4YGhgSj0u/fhuU
         Krzdob7EMZo3isieuuFeFMyYzQMZncp2GO9gzPhmDT+tAUoFCDKM3h9OWaZqgsZgjWO3
         +urQ==
X-Gm-Message-State: AC+VfDx2SErtxOWP7e/5nzG5cZNynKN48NgwkI3hogLSovCm9oOzOdAt
        Z0ePfyMJDsHLdEAETEpNfOVXFiNW9ig1gKvC
X-Google-Smtp-Source: ACHHUZ6VB+SeesdhIuto8jqmh6FJP7g2Z0ynzDhFlxE/dGFO1LkllAzqmGTpv6npDONufo3SVFV7lQ==
X-Received: by 2002:ac2:5457:0:b0:4cc:7282:702b with SMTP id d23-20020ac25457000000b004cc7282702bmr1121327lfn.2.1683137766031;
        Wed, 03 May 2023 11:16:06 -0700 (PDT)
Received: from localhost.localdomain ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id f9-20020a19ae09000000b004eff64a26ccsm4557627lfc.196.2023.05.03.11.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 11:16:05 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.96)
        (envelope-from <jekhor@gmail.com>)
        id 1puH1I-00AFnn-2q;
        Wed, 03 May 2023 21:16:04 +0300
Date:   Wed, 3 May 2023 21:16:04 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 00/19] platform/x86: lenovo-yogabook: Modify to also work
 on Android version
Message-ID: <ZFKk5JVgpLc2kG4Z@jeknote.loshitsa1.net>
References: <20230429181551.98201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429181551.98201-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Apr 29, 2023 at 08:15:32PM +0200, Hans de Goede wrote:
> Hi All,
> 
> The Lenovo Yoga Book (yb1-x9*) is a yoga 2-in-1 where the keyboard
> half has a touch keyboard (with a backlit fixed key layout) to make
> it extra thin and light. The keyboard half can also be switched to
> an alternative wacom digitizer mode where it instead can be used
> to draw on. The backlight + switching is handled by
> the lenovo-yogabook driver.
> 
> There are both Windows and Android versions with different BIOS-es /
> ACPI tables. This series extends the current Windows model only driver
> to also support the Android model.
> 
> On the Android yb1-x90f/l models there is not ACPI method to control
> the keyboard backlight brightness. Instead the second PWM controller
> is exposed directly to the OS there.
> 
> This requires adding a pwm_lookup table and the lenovo-yogabook code
> can (and typically is) build as a module. So the first patch in
> this series exports pwm_add_table() and pwm_remove_table() for use
> in modules.
> 
> I believe that it is easiest to just merge the entire series through
> the drivers/platform/x86 tree. Thierry, may I have your ack for
> patch 1/19 to merge it through the pdx86 tree ?

Wow, great! I thought about ACPI table substitution by one taken from the Windows
tablet but didn't try this. I'm glad if this works because ACPI tables
in Android version looks like as a placeholder from the Intel's SDK, not
a real thing.

There is instruction how to install Windows on Android version, maybe it
will be useful for you:
https://web.archive.org/web/20220516142318/https://www.poz1.com/windows-on-android-lenovo-yogabook/

> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (19):
>   pwm: Export pwm_add_table() / pwm_remove_table()
>   platform/x86: lenovo-yogabook: Fix work race on remove()
>   platform/x86: lenovo-yogabook: Reprobe devices on remove()
>   platform/x86: lenovo-yogabook: Set default keyboard backligh
>     brightness on probe()
>   platform/x86: lenovo-yogabook: Simplify gpio lookup table cleanup
>   platform/x86: lenovo-yogabook: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
>   platform/x86: lenovo-yogabook: Store dev instead of wdev in drvdata
>     struct
>   platform/x86: lenovo-yogabook: Add dev local variable to probe()
>   platform/x86: lenovo-yogabook: Use PMIC LED driver for pen icon LED
>     control
>   platform/x86: lenovo-yogabook: Split probe() into generic and WMI
>     specific parts
>   platform/x86: lenovo-yogabook: Stop checking adev->power.state
>   platform/x86: lenovo-yogabook: Abstract kbd backlight setting
>   platform/x86: lenovo-yogabook: Add a yogabook_toggle_digitizer_mode()
>     helper function
>   platform/x86: lenovo-yogabook: Drop _wmi_ from remaining generic
>     symbols
>   platform/x86: lenovo-yogabook: Group WMI specific code together
>   platform/x86: lenovo-yogabook: Add YB_KBD_BL_MAX define
>   platform/x86: lenovo-yogabook: Add platform driver support
>   platform/x86: lenovo-yogabook: Add keyboard backlight control to
>     platform driver
>   platform/x86: lenovo-yogabook: Rename lenovo-yogabook-wmi to
>     lenovo-yogabook
> 
>  drivers/platform/x86/Kconfig               |   6 +-
>  drivers/platform/x86/Makefile              |   2 +-
>  drivers/platform/x86/lenovo-yogabook-wmi.c | 408 --------------
>  drivers/platform/x86/lenovo-yogabook.c     | 587 +++++++++++++++++++++
>  drivers/pwm/core.c                         |   2 +
>  5 files changed, 593 insertions(+), 412 deletions(-)
>  delete mode 100644 drivers/platform/x86/lenovo-yogabook-wmi.c
>  create mode 100644 drivers/platform/x86/lenovo-yogabook.c
> 
> -- 
> 2.39.2
> 

-- 
Yauhen Kharuzhy
