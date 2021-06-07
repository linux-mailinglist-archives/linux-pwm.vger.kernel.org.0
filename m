Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4E39DCA7
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFGMks (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 08:40:48 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42903 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGMks (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 08:40:48 -0400
Received: by mail-oi1-f169.google.com with SMTP id v142so17431513oie.9;
        Mon, 07 Jun 2021 05:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtfBKhSIgrMbklkSEqUXIVw+9PSaocndOPsfs57pBrg=;
        b=D5cGmo1h/808qW+9QGljx/IHtH3jhwAR9pe/dggshNn6V2xmHQHnCi/oF40saGImwq
         Ww+lfs0LWoTvxmYWenFrLq9WAdBrPlL4txNnGjyYxioiZmIoG4I7xgFwIBIMHGnBT6x7
         pvFs3NgbB34/ETTkG1n2RGqLZ1oJUvwsKcOZh5aN51NNzCYbPScdkMyEsWG3KBl42/y4
         sIsz+lBcz4ynpZiUNaxieuubQyr+MabfOje8WauTPl5X7wErPBiLk7F3uJFa83Q1TRN+
         0Yk7ZXvaGiQrZaQK+wc1sX9Zu1gPLxgzm9So8FztjHPtxPHwJlJdJg2OnCVzrdksOyVW
         eRmg==
X-Gm-Message-State: AOAM533gxm7rqa6UvQoypxMP+WUMa0fFq2Z+rfh3/xAU/arcp7MskZE7
        kB/LEXdGDnS6jGlT+QqsHtcUyQqj9JMVw3qPv3Q=
X-Google-Smtp-Source: ABdhPJzlt3b6sqN2DBSPSm7jJv8sukwRnmWDdtIqUNnxpduRN7SvDItcbm+AtfXYs1ipy0GEiB1VkCUptRMcbaCeu9o=
X-Received: by 2002:aca:650d:: with SMTP id m13mr3041451oim.157.1623069536950;
 Mon, 07 Jun 2021 05:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com> <20210607122458.40073-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210607122458.40073-3-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:38:46 +0200
Message-ID: <CAJZ5v0hEHkpoyc9-fYrZ8A79B0XRd4_RUB2wcRcq1kMKXnb7Jw@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] pwm: core: Reuse fwnode_to_pwmchip() in ACPI case
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
> In ACPI case we may use matching by fwnode as provided via
> fwnode_to_pwmchip(). This makes device_to_pwmchip() not needed
> anymore.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> v3: rebased on the tree without dropped patch 2/7
> v2: no change
>  drivers/pwm/core.c | 31 +------------------------------
>  1 file changed, 1 insertion(+), 30 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index f26da1a6a376..c63626c5266c 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -820,28 +820,6 @@ struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
>  }
>  EXPORT_SYMBOL_GPL(of_pwm_get);
>
> -#if IS_ENABLED(CONFIG_ACPI)
> -static struct pwm_chip *device_to_pwmchip(struct device *dev)
> -{
> -       struct pwm_chip *chip;
> -
> -       mutex_lock(&pwm_lock);
> -
> -       list_for_each_entry(chip, &pwm_chips, list) {
> -               struct acpi_device *adev = ACPI_COMPANION(chip->dev);
> -
> -               if ((chip->dev == dev) || (adev && &adev->dev == dev)) {
> -                       mutex_unlock(&pwm_lock);
> -                       return chip;
> -               }
> -       }
> -
> -       mutex_unlock(&pwm_lock);
> -
> -       return ERR_PTR(-EPROBE_DEFER);
> -}
> -#endif
> -
>  /**
>   * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
>   * @fwnode: firmware node to get the "pwm" property from
> @@ -862,9 +840,7 @@ static struct pwm_chip *device_to_pwmchip(struct device *dev)
>  static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
>  {
>         struct pwm_device *pwm = ERR_PTR(-ENODEV);
> -#if IS_ENABLED(CONFIG_ACPI)
>         struct fwnode_reference_args args;
> -       struct acpi_device *acpi;
>         struct pwm_chip *chip;
>         int ret;
>
> @@ -874,14 +850,10 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
>         if (ret < 0)
>                 return ERR_PTR(ret);
>
> -       acpi = to_acpi_device_node(args.fwnode);
> -       if (!acpi)
> -               return ERR_PTR(-EINVAL);
> -
>         if (args.nargs < 2)
>                 return ERR_PTR(-EPROTO);
>
> -       chip = device_to_pwmchip(&acpi->dev);
> +       chip = fwnode_to_pwmchip(args.fwnode);
>         if (IS_ERR(chip))
>                 return ERR_CAST(chip);
>
> @@ -894,7 +866,6 @@ static struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
>
>         if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
>                 pwm->args.polarity = PWM_POLARITY_INVERSED;
> -#endif
>
>         return pwm;
>  }
> --
> 2.30.2
>
