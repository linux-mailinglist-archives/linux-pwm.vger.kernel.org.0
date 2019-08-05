Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456B7815B0
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Aug 2019 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHEJld (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Aug 2019 05:41:33 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:50164 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfHEJld (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Aug 2019 05:41:33 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 05:41:33 EDT
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id A084D4D4DE; Mon,  5 Aug 2019 11:31:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 9C2AB4D4BC;
        Mon,  5 Aug 2019 11:31:27 +0200 (CEST)
Date:   Mon, 5 Aug 2019 11:31:27 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Hans de Goede <hdegoede@redhat.com>
cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "youling257@gmail.com" <youling257@gmail.com>,
        nikolaus.voss@loewensteinmedical.de
Subject: Re: [PATCH 5.3 regression fix] pwm: Fallback to the static lookup-list
 when acpi_pwm_get fails
In-Reply-To: <20190730154848.5164-1-hdegoede@redhat.com>
Message-ID: <alpine.DEB.2.20.1908050935570.62587@fox.voss.local>
References: <20190730154848.5164-1-hdegoede@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Hans,

On Tue, 30 Jul 2019, Hans de Goede wrote:
> Commit 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> made pwm_get unconditionally return the acpi_pwm_get return value if
> the device passed to pwm_get has an ACPI fwnode.
>
> But even if the passed in device has an ACPI fwnode, it does not
> necessarily have the necessary ACPI package defining its pwm bindings,
> especially since the binding / API of this ACPI package has only been
> introduced very recently.
>
> Up until now X86/ACPI devices which use a separate pwm controller for
> controlling their LCD screen's backlight brightness have been relying
> on the static lookup-list to get their pwm.
>
> pwm_get unconditionally returning the acpi_pwm_get return value breaks
> this, breaking backlight control on these devices.
>
> This commit fixes this by making pwm_get fall back to the static
> lookup-list if acpi_pwm_get returns -ENOENT.

Ok, I didn't find any pwm_add_table() calls in the x86 directory, so I 
thought the fallback matching is only for non-DT/non-ACPI systems. If it 
is used for ACPI nodes without PWM controller binding, it maybe should 
apply to DT nodes without PWM controller binding, too?

It would be structurally cleaner as DT and ACPI handling was symmetrical.

Niko

>
> BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=96571
> Reported-by: youling257@gmail.com
> Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/pwm/core.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index c3ab07ab31a9..8edfac17364e 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -882,8 +882,11 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>                return of_pwm_get(dev, dev->of_node, con_id);
>
>        /* then lookup via ACPI */
> -       if (dev && is_acpi_node(dev->fwnode))
> -               return acpi_pwm_get(dev->fwnode);
> +       if (dev && is_acpi_node(dev->fwnode)) {
> +               pwm = acpi_pwm_get(dev->fwnode);
> +               if (!IS_ERR(pwm) || PTR_ERR(pwm) != -ENOENT)
> +                       return pwm;
> +       }
>
>        /*
>         * We look up the provider in the static table typically provided by
> --
> 2.21.0
>
>
