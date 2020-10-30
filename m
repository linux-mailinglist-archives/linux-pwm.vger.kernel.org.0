Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1032A05AC
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3MoO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3MoN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 08:44:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF67C0613CF;
        Fri, 30 Oct 2020 05:44:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f38so5115859pgm.2;
        Fri, 30 Oct 2020 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=msaB35j/GqzFCFILpIKnuFGPXha2jKiGqHTe2T0vhD0=;
        b=d16xDWG/8WfuuHc32KNgBuOIfo5BmD97ZioCCBZKc0jyJM91pN+R/ZVer7qFCJTEfn
         jaZeBBWJleAZrS5R/GjpwxIXeCauW9ZMaREcbElVX2OLd34Uj3f1U3vDMCdkaV4zFyku
         nxcdDiKttTHjI7aDe/QFP0/4TlPkWDybOXyX6o5+GjFH8kePfeflR9sqZaC+wuClXEF0
         NrqjKt2hbrrfWaUlsBVwnk1IG5r4SOBIPfU1db5Y1V3Gekcj6Q0wQeLbSPkQsQtyuVgw
         4/Bv2cGk6CLc2+hAFVLI/CFi234C79rrCNpLNYbB8zkyrop3ThL0Fb6fvJe4wn2fRcey
         HJvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=msaB35j/GqzFCFILpIKnuFGPXha2jKiGqHTe2T0vhD0=;
        b=Da+VtiS82EFEqjoAjZm91jW1wr71QRC29E8tGldMJF5XH5ZOKfluSiyz++j8Xh9bVl
         KjHReDJweI8VDAud3IpYkJAwyRlSvWnNCJLt2u/74673NV9seEQUzs8B+1P20THTA24f
         f+ITprvF8Nyy3SXjptkNMpcH0sSQhEfZDpXqi2Da9Y/9CtkU3ODElTJSQEebbM5ncOXw
         lbcZY6SDUf25FLOSdNrurIgJxYJwT3DpmfwFNYosCY2snFSWWHBfat2Th2SAIzxaailb
         xn4HkexhF5um8cyCvflIfDprb3QqFkN/jkl61jDaT3YLhVqlWCDVEq5n5T5Vz5f42evr
         QR7Q==
X-Gm-Message-State: AOAM532ks3Ganot+slVIJvvbfCCKaXMJJ2GyqaUtVjIo04Edt2p1yeOg
        2Y7SRmsQwaThJsNAIKAKgcY8OREWGdsOV56VcxcLt+/K2xE=
X-Google-Smtp-Source: ABdhPJxP2XR3i0qcVh8/GHeGtadzfjqxIVztZlyn/OIevOxoamy4L1cT0kdcDzCNJuFF4/wWMt11NFIT5x+M10WM6V8=
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr2769173pjb.129.1604061852705;
 Fri, 30 Oct 2020 05:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201030094832.18297-1-hdegoede@redhat.com> <20201030094832.18297-4-hdegoede@redhat.com>
In-Reply-To: <20201030094832.18297-4-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Oct 2020 14:45:01 +0200
Message-ID: <CAHp75VeP4ttqXBiS3VCQJBkN=D9-vRoOKn0ZMiZdt8gvsCpRgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] pwm: lpss: Set DPM_FLAG_SMART_SUSPEND on Cherry Trail devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 30, 2020 at 11:48 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> As the comment above the code setting the DPM_FLAG_NO_DIRECT_COMPLETE
> flag explains:
>
>     /*
>      * On Cherry Trail devices the GFX0._PS0 AML checks if the controller
>      * is on and if it is not on it turns it on and restores what it
>      * believes is the correct state to the PWM controller.
>      * Because of this we must disallow direct-complete, which keeps the
>      * controller (runtime)suspended, on resume to avoid 2 issues:
>      * 1. The controller getting turned on without the linux-pm code
>      *    knowing about this. On devices where the controller is unused
>      *    this causes it to stay on during the next suspend causing high
>      *    battery drain (because S0i3 is not reached)
>      * 2. The state restoring code unexpectedly messing with the controller
>      */
>
> The pm-core must not skip resume to avoid the GFX0._PS0 AML code messing
> with the PWM controller behind our back. But

> leaving the controller
> runtime-suspended (skipping runtime-resume + normal-suspend) during
> suspend is fine.

This paragraph is good to have in the comment of the code I think.

> Set the DPM_FLAG_SMART_SUSPEND flag to allow this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-lpss-platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
> index ac33861edb48..38d17e2e2b4c 100644
> --- a/drivers/pwm/pwm-lpss-platform.c
> +++ b/drivers/pwm/pwm-lpss-platform.c
> @@ -71,7 +71,8 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
>          * 2. The state restoring code unexpectedly messing with the controller
>          */
>         if (info->other_devices_aml_touches_pwm_regs)
> -               dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> +               dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE|
> +                                                   DPM_FLAG_SMART_SUSPEND);
>
>         pm_runtime_set_active(&pdev->dev);
>         pm_runtime_enable(&pdev->dev);
> --
> 2.28.0
>


-- 
With Best Regards,
Andy Shevchenko
