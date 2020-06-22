Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2003C203C11
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jun 2020 18:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgFVQDa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Jun 2020 12:03:30 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:37388 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbgFVQD3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Jun 2020 12:03:29 -0400
Received: by mail-oo1-f66.google.com with SMTP id q188so3468682ooq.4;
        Mon, 22 Jun 2020 09:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VKM6qdl4XxQVGL7OyBuykfl37CtWnc+tdGzZUekyK0U=;
        b=Ybt180rrz59vDERidm724FKQ8gLx3if+Wekg/Ti6Jewo74KedQnCHB+fx/u/v4hFLy
         GcOB+dpnQPGR6jdwzxdiarLbUs/ETXzOsdF84OCDuedRX9aUiwHj1LYPlttp08COVgVR
         2UnSgb3UIp7mB/zPRGn12/1+dwnlgigmBeAR1j6L7lPZTd34GKEhDpEG7FvjhXPt0CnV
         gtRqbmmJfGOzxETg/qunQXzoMvgA+guXqcRvUtpCyfelhgtmqHj7rpnoDRSDRqfW2nHi
         s2d3fa2h20dzzDmy5e1nGe5Kl5EPR6GdPvBwzH9GVlFCm87MjqE3kcRPSetC+Gg5PyvB
         cp/Q==
X-Gm-Message-State: AOAM533nqVggJ6g16Z+ERRzbFSLilaigFzOJprj8pSHLN0QN7vxInZ/m
        tum+4CRcWyIU3Nlf9E/37GrQMBTvVh1BEelOLRs=
X-Google-Smtp-Source: ABdhPJztT2kIm5+7aGh27njiWN+yCK4UNRDLDkh0MGlPoCw1P8uYpgB3LfSffpwKz8rwB34VXzzt+NuMGnXFvvsI1JI=
X-Received: by 2002:a4a:6513:: with SMTP id y19mr14820649ooc.75.1592841808852;
 Mon, 22 Jun 2020 09:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200620121758.14836-1-hdegoede@redhat.com> <20200620121758.14836-2-hdegoede@redhat.com>
In-Reply-To: <20200620121758.14836-2-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jun 2020 18:03:17 +0200
Message-ID: <CAJZ5v0hheU2SaebNiLgRdxwC_dV44uSFWgAx2pr3w5ENeEF7EQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] ACPI / LPSS: Resume Cherry Trail PWM controller
 in no-irq phase
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Jun 20, 2020 at 2:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The DSDTs on most Cherry Trail devices have an ugly clutch where the PWM
> controller gets poked from the _PS0 method of the graphics-card device:
>
>         Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>         If (((Local0 & 0x03) == 0x03))
>         {
>             PSAT &= 0xFFFFFFFC
>             Local1 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>             RSTA = Zero
>             RSTF = Zero
>             RSTA = One
>             RSTF = One
>             PWMB |= 0xC0000000
>             PWMC = PWMB /* \_SB_.PCI0.GFX0.PWMB */
>         }
>
> Where PSAT is the power-status register of the PWM controller, so if it
> is in D3 when the GFX0 device's PS0 method runs then it will turn it on
> and restore the PWM ctrl register value it saved from its PS3 handler.
> Note not only does it restore it, it ors it with 0xC0000000 turning it
> on at a time where we may not want it to get turned on at all.
>
> The pwm_get call which the i915 driver does to get a reference to the
> PWM controller, already adds a device-link making the GFX0 device a
> consumer of the PWM device. So it should already have been resumed when
> the above AML runs and the AML should thus not do its undesirable poking
> of the PWM controller register.
>
> But the PCI core powers on PCI devices in the no-irq resume phase and
> thus calls the troublesome PS0 method in the no-irq resume phase.
> Where as LPSS devices by default are resumed in the early resume phase.
>
> This commit sets the resume_from_noirq flag in the bsw_pwm_dev_desc
> struct, so that Cherry Trail PWM controllers will be resumed in the
> no-irq phase. Together with the device-link added by the pwm-get this
> ensures that the PWM controller will be on when the troublesome PS0
> method runs, which stops it from poking the PWM controller.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/acpi_lpss.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index c5a5a179f49d..446e666b3466 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -257,6 +257,7 @@ static const struct lpss_device_desc bsw_pwm_dev_desc = {
>         .flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
>         .prv_offset = 0x800,
>         .setup = bsw_pwm_setup,
> +       .resume_from_noirq = true,
>  };
>
>  static const struct lpss_device_desc byt_uart_dev_desc = {
> --
> 2.26.2
>
