Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B19939DCA3
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 14:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFGMk3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 08:40:29 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34630 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGMk3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 08:40:29 -0400
Received: by mail-oi1-f171.google.com with SMTP id u11so17876153oiv.1;
        Mon, 07 Jun 2021 05:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPqUa+rnrW+mAtOHr655MOrMNS6a9/BQ4oZGZxu7cDk=;
        b=WMx1xCAYjFP9RqMuap37fRX/WyzLJEIttCJLRnHk70ugB84JkqYYLzWIUQUJhtLmMq
         JyvoVW18zuppAjgGK0/7nDgFOJX2gb03Dcw7YUUtQ3H7QIhXF7ezu/hI4jL27U5+G1ix
         F6diN40FTry0TuzjBlA55qYo1R6EejcaFpiSTXBN34LG/g415aKWP0a2tNllZkCWNDF/
         EhY49ZI0EKiFqjNvyBMY1C/SM1uAnA8U8gLG+aEmUwUCxtYRyu7iroHGJn6PqtPdemHu
         l5luI1CzEdnQsJHOAsZk4//tkBDJbHx22dCH47iuh5xSkRn4IDag+VITS1lIac7f3CRg
         gjaw==
X-Gm-Message-State: AOAM530515bmoqSiHXSmZWuGbudXea9lWVCZ4mZveDnz8LQ6xg+a8MMF
        uwIK6rvvyWZEjHfUC90TWux2tp5wkAzRx72vsKnQh3RY
X-Google-Smtp-Source: ABdhPJxG45pKCsCJJD+kHj6VkDfMM3V3FJpuBCYxz+oHzaDHklCgG3UuML5yWElZSWgbciBjhWz2XvDkW+9+jzUnpcM=
X-Received: by 2002:aca:1910:: with SMTP id l16mr10589505oii.69.1623069517585;
 Mon, 07 Jun 2021 05:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:38:26 +0200
Message-ID: <CAJZ5v0jNWTzy37rX_V6LF7y7LOdy=KUokkVZ+25zj4+AZ244OQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] docs: firmware-guide: ACPI: Add a PWM example
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 7, 2021 at 2:24 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When PWM support for ACPI has been added into the kernel, it missed
> the documentation update. Hence update documentation here.
>
> Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I'm assuming this to go in via PWM.

> ---
> v3: despite flags being optional, don't alter it in the documentation
> v2: updated example to use 600 ms instead of 600 us (looks saner)
>  .../firmware-guide/acpi/enumeration.rst       | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
> index 9f0d5c854fa4..f588663ba906 100644
> --- a/Documentation/firmware-guide/acpi/enumeration.rst
> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -258,6 +258,38 @@ input driver::
>                 .id_table       = mpu3050_ids,
>         };
>
> +Reference to PWM device
> +=======================
> +
> +Sometimes a device can be a consumer of PWM channel. Obviously OS would like
> +to know which one. To provide this mapping the special property has been
> +introduced, i.e.::
> +
> +    Device (DEV)
> +    {
> +        Name (_DSD, Package ()
> +        {
> +            ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> +            Package () {
> +                Package () { "compatible", Package () { "pwm-leds" } },
> +                Package () { "label", "alarm-led" },
> +                Package () { "pwms",
> +                    Package () {
> +                        "\\_SB.PCI0.PWM",  // <PWM device reference>
> +                        0,                 // <PWM index>
> +                        600000000,         // <PWM period>
> +                        0,                 // <PWM flags>
> +                    }
> +                }
> +            }
> +
> +        })
> +        ...
> +
> +In the above example the PWM-based LED driver references to the PWM channel 0
> +of \_SB.PCI0.PWM device with initial period setting equal to 600 ms (note that
> +value is given in nanoseconds).
> +
>  GPIO support
>  ============
>
> --
> 2.30.2
>
