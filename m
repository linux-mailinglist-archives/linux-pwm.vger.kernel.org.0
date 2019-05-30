Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 924872FE9B
	for <lists+linux-pwm@lfdr.de>; Thu, 30 May 2019 16:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfE3Oyn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 May 2019 10:54:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34802 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfE3Oyn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 May 2019 10:54:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4UEsUie069672;
        Thu, 30 May 2019 09:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559228070;
        bh=kCVEE6RftNg+CR0Qr7gt6vfGGGAIIStsNmVWKIPanME=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=h61yE8qfOGavnWzAHZX0v1/LVEf0hGoHmqg0vC3I0ffYi9sgvY5V2uI+f1zxgwJTG
         ZMRB8mi997qAq51l2vOmQkhJh1u1XBw2mfS9fFRWzFglnhzEuQfogSXIHOoONNGK64
         6R2HDUUf1HhFICaTZwCysa8slMq8yEkTMi0mI1+0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4UEsUcv122341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 May 2019 09:54:30 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 30
 May 2019 09:54:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 30 May 2019 09:54:29 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4UEsTtw038549;
        Thu, 30 May 2019 09:54:29 -0500
Subject: Re: [PATCH 2/3] PWM framework: add support referencing PWMs from ACPI
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-acpi@vger.kernel.org>, <devel@acpica.org>,
        <linux-leds@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de>
 <254cc03d5467ba7db0f5677646266768e5b24127.1559127603.git.nikolaus.voss@loewensteinmedical.de>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <d4e035b7-7419-cb69-9e22-6103d53d5aaf@ti.com>
Date:   Thu, 30 May 2019 09:54:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <254cc03d5467ba7db0f5677646266768e5b24127.1559127603.git.nikolaus.voss@loewensteinmedical.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Nikolaus

On 5/29/19 7:18 AM, Nikolaus Voss wrote:
> In analogy to referencing a GPIO using the "gpios" property from ACPI,
> support referencing a PWM using the "pwms" property.
>
> ACPI entries must look like
>   Package () {"pwms", Package ()
>       { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}
>
> In contrast to the DT implementation, only _one_ PWM entry in the "pwms"
> property is supported. As a consequence "pwm-names"-property and
> con_id lookup aren't supported.
>
> Support for ACPI is added via the firmware-node framework which is an
> abstraction layer on top of ACPI/DT. To keep this patch clean, DT and
> ACPI paths are kept separate. The firmware-node framework could be used
> to unify both paths in a future patch.
>
> To support leds-pwm driver, an additional method devm_fwnode_pwm_get()
> which supports both ACPI and DT configuration is exported.
>
> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>   drivers/pwm/core.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/pwm.h |   9 ++++
>   2 files changed, 121 insertions(+)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 275b5f399a1a..1d788c05193e 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -6,6 +6,7 @@
>    * Copyright (C) 2011-2012 Avionic Design GmbH
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/module.h>
>   #include <linux/pwm.h>
>   #include <linux/radix-tree.h>
> @@ -700,6 +701,75 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>   }
>   EXPORT_SYMBOL_GPL(of_pwm_get);
>   
> +static struct pwm_chip *device_to_pwmchip(struct device *dev)
> +{
> +	struct pwm_chip *chip;
> +
> +	mutex_lock(&pwm_lock);
> +
> +	list_for_each_entry(chip, &pwm_chips, list) {
> +		struct acpi_device *adev = ACPI_COMPANION(chip->dev);
> +
> +		if ((chip->dev == dev) || (adev && &adev->dev == dev)) {
> +			mutex_unlock(&pwm_lock);
> +			return chip;
> +		}
> +	}
> +
> +	mutex_unlock(&pwm_lock);
> +
> +	return ERR_PTR(-EPROBE_DEFER);
> +}
> +
> +/**
> + * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
> + * @fwnode: firmware node to get the "pwm" property from
> + *
> + * Returns the PWM device parsed from the fwnode and index specified in the
> + * "pwms" property or a negative error-code on failure.
> + * Values parsed from the device tree are stored in the returned PWM device
> + * object.
> + *
> + * This is analogous to of_pwm_get() except con_id is not yet supported.
> + * ACPI entries must look like
> + * Package () {"pwms", Package ()
> + *     { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}
> + *
> + * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
> + * error code on failure.
> + */
> +struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
static?
> +{
> +	struct fwnode_reference_args args;
> +	struct pwm_chip *chip;
> +	struct pwm_device *pwm = ERR_PTR(-ENODEV);
> +	int ret;
> +
> +	memset(&args, 0, sizeof(args));

args should be zero'd out when initialized on the stack so this is 
necessary.

> +	ret = __acpi_node_get_property_reference(fwnode, "pwms", 0, 3, &args);
> +
> +	if (!to_acpi_device_node(args.fwnode))
> +		return ERR_PTR(-EINVAL);
Add new line
> +	if (args.nargs < 2)
> +		return ERR_PTR(-EPROTO);
> +
> +	chip = device_to_pwmchip(&to_acpi_device_node(args.fwnode)->dev);
> +	if (IS_ERR(chip))
> +		return ERR_CAST(chip);
> +
> +	pwm = pwm_request_from_chip(chip, args.args[0], NULL);
> +	if (IS_ERR(pwm))
> +		return pwm;
> +
> +	pwm->args.period = args.args[1];
> +	pwm->args.polarity = PWM_POLARITY_NORMAL;
> +
> +	if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
> +		pwm->args.polarity = PWM_POLARITY_INVERSED;
> +
> +	return pwm;
> +}
> +
>   /**
>    * pwm_add_table() - register PWM device consumers
>    * @table: array of consumers to register
> @@ -763,6 +833,10 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>   	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
>   		return of_pwm_get(dev->of_node, con_id);
>   
> +	/* then lookup via ACPI */
> +	if (dev && is_acpi_node(dev->fwnode))
> +		return acpi_pwm_get(dev->fwnode);
> +
>   	/*
>   	 * We look up the provider in the static table typically provided by
>   	 * board setup code. We first try to lookup the consumer device by
> @@ -942,6 +1016,44 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>   }
>   EXPORT_SYMBOL_GPL(devm_of_pwm_get);
>   
> +/**
> + * devm_fwnode_pwm_get() - request a resource managed PWM from firmware node
> + * @dev: device for PWM consumer
> + * @fwnode: firmware node to get the PWM from
> + * @con_id: consumer name
> + *
> + * Returns the PWM device parsed from the firmware node. See of_pwm_get() and
> + * acpi_pwm_get() for a detailed description.
> + *
> + * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
> + * error code on failure.
> + */
> +struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       const char *con_id)

I am wondering if it would be better just to convert the existing of_ 
calls to device_property calls and make it more generic.

Dan

> +{
> +	struct pwm_device **ptr, *pwm = ERR_PTR(-ENODEV);
> +
> +	ptr = devres_alloc(devm_pwm_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (is_of_node(fwnode))
> +		pwm = of_pwm_get(to_of_node(fwnode), con_id);
> +	else if (is_acpi_node(fwnode))
> +		pwm = acpi_pwm_get(fwnode);
> +
> +	if (!IS_ERR(pwm)) {
> +		*ptr = pwm;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return pwm;
> +}
> +EXPORT_SYMBOL_GPL(devm_fwnode_pwm_get);
> +
>   static int devm_pwm_match(struct device *dev, void *res, void *data)
>   {
>   	struct pwm_device **p = res;
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index eaa5c6e3fc9f..1a635916cdfb 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -411,6 +411,9 @@ void pwm_put(struct pwm_device *pwm);
>   struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
>   struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>   				   const char *con_id);
> +struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
> +				       struct fwnode_handle *fwnode,
> +				       const char *con_id);
>   void devm_pwm_put(struct device *dev, struct pwm_device *pwm);
>   #else
>   static inline struct pwm_device *pwm_request(int pwm_id, const char *label)
> @@ -516,6 +519,12 @@ static inline struct pwm_device *devm_of_pwm_get(struct device *dev,
>   	return ERR_PTR(-ENODEV);
>   }
>   
> +static inline struct pwm_device *devm_fwnode_pwm_get(
> +	struct device *dev, struct fwnode_handle *fwnode, const char *con_id)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>   static inline void devm_pwm_put(struct device *dev, struct pwm_device *pwm)
>   {
>   }
