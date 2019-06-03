Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00032CD8
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Jun 2019 11:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfFCJ1i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Jun 2019 05:27:38 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:36082 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfFCJ1i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Jun 2019 05:27:38 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 06AB24D20F; Mon,  3 Jun 2019 11:27:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 044134D200;
        Mon,  3 Jun 2019 11:27:36 +0200 (CEST)
Date:   Mon, 3 Jun 2019 11:27:36 +0200 (CEST)
From:   Nikolaus Voss <nv@vosn.de>
X-X-Sender: nv@fox.voss.local
To:     Dan Murphy <dmurphy@ti.com>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/3] PWM framework: add support referencing PWMs from
 ACPI
In-Reply-To: <d4e035b7-7419-cb69-9e22-6103d53d5aaf@ti.com>
Message-ID: <alpine.DEB.2.20.1906031120001.63281@fox.voss.local>
References: <cover.1559127603.git.nikolaus.voss@loewensteinmedical.de> <254cc03d5467ba7db0f5677646266768e5b24127.1559127603.git.nikolaus.voss@loewensteinmedical.de> <d4e035b7-7419-cb69-9e22-6103d53d5aaf@ti.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dan,

On Thu, 30 May 2019, Dan Murphy wrote:
> Nikolaus
>
> On 5/29/19 7:18 AM, Nikolaus Voss wrote:
>> In analogy to referencing a GPIO using the "gpios" property from ACPI,
>> support referencing a PWM using the "pwms" property.
>>
>> ACPI entries must look like
>>   Package () {"pwms", Package ()
>>       { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}
>>
>> In contrast to the DT implementation, only _one_ PWM entry in the "pwms"
>> property is supported. As a consequence "pwm-names"-property and
>> con_id lookup aren't supported.
>>
>> Support for ACPI is added via the firmware-node framework which is an
>> abstraction layer on top of ACPI/DT. To keep this patch clean, DT and
>> ACPI paths are kept separate. The firmware-node framework could be used
>> to unify both paths in a future patch.
>>
>> To support leds-pwm driver, an additional method devm_fwnode_pwm_get()
>> which supports both ACPI and DT configuration is exported.
>>
>> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
>> ---
>>   drivers/pwm/core.c  | 112 ++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/pwm.h |   9 ++++
>>   2 files changed, 121 insertions(+)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 275b5f399a1a..1d788c05193e 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -6,6 +6,7 @@
>>    * Copyright (C) 2011-2012 Avionic Design GmbH
>>    */
>>
>> +#include <linux/acpi.h>
>>   #include <linux/module.h>
>>   #include <linux/pwm.h>
>>   #include <linux/radix-tree.h>
>> @@ -700,6 +701,75 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
>>   }
>>   EXPORT_SYMBOL_GPL(of_pwm_get);
>>
>> +static struct pwm_chip *device_to_pwmchip(struct device *dev)
>> +{
>> +     struct pwm_chip *chip;
>> +
>> +     mutex_lock(&pwm_lock);
>> +
>> +     list_for_each_entry(chip, &pwm_chips, list) {
>> +             struct acpi_device *adev = ACPI_COMPANION(chip->dev);
>> +
>> +             if ((chip->dev == dev) || (adev && &adev->dev == dev)) {
>> +                     mutex_unlock(&pwm_lock);
>> +                     return chip;
>> +             }
>> +     }
>> +
>> +     mutex_unlock(&pwm_lock);
>> +
>> +     return ERR_PTR(-EPROBE_DEFER);
>> +}
>> +
>> +/**
>> + * acpi_pwm_get() - request a PWM via parsing "pwms" property in ACPI
>> + * @fwnode: firmware node to get the "pwm" property from
>> + *
>> + * Returns the PWM device parsed from the fwnode and index specified in the
>> + * "pwms" property or a negative error-code on failure.
>> + * Values parsed from the device tree are stored in the returned PWM device
>> + * object.
>> + *
>> + * This is analogous to of_pwm_get() except con_id is not yet supported.
>> + * ACPI entries must look like
>> + * Package () {"pwms", Package ()
>> + *     { <PWM device reference>, <PWM index>, <PWM period> [, <PWM flags>]}}
>> + *
>> + * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
>> + * error code on failure.
>> + */
>> +struct pwm_device *acpi_pwm_get(struct fwnode_handle *fwnode)
> static?
yes, changed.

>> +{
>> +     struct fwnode_reference_args args;
>> +     struct pwm_chip *chip;
>> +     struct pwm_device *pwm = ERR_PTR(-ENODEV);
>> +     int ret;
>> +
>> +     memset(&args, 0, sizeof(args));
>
> args should be zero'd out when initialized on the stack so this is
> necessary.
>
>> +     ret = __acpi_node_get_property_reference(fwnode, "pwms", 0, 3, &args);
>> +
>> +     if (!to_acpi_device_node(args.fwnode))
>> +             return ERR_PTR(-EINVAL);
> Add new line
ok

>> +     if (args.nargs < 2)
>> +             return ERR_PTR(-EPROTO);
>> +
>> +     chip = device_to_pwmchip(&to_acpi_device_node(args.fwnode)->dev);
>> +     if (IS_ERR(chip))
>> +             return ERR_CAST(chip);
>> +
>> +     pwm = pwm_request_from_chip(chip, args.args[0], NULL);
>> +     if (IS_ERR(pwm))
>> +             return pwm;
>> +
>> +     pwm->args.period = args.args[1];
>> +     pwm->args.polarity = PWM_POLARITY_NORMAL;
>> +
>> +     if (args.nargs > 2 && args.args[2] & PWM_POLARITY_INVERTED)
>> +             pwm->args.polarity = PWM_POLARITY_INVERSED;
>> +
>> +     return pwm;
>> +}
>> +
>>   /**
>>    * pwm_add_table() - register PWM device consumers
>>    * @table: array of consumers to register
>> @@ -763,6 +833,10 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
>>       if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
>>               return of_pwm_get(dev->of_node, con_id);
>>
>> +     /* then lookup via ACPI */
>> +     if (dev && is_acpi_node(dev->fwnode))
>> +             return acpi_pwm_get(dev->fwnode);
>> +
>>       /*
>>        * We look up the provider in the static table typically provided by
>>        * board setup code. We first try to lookup the consumer device by
>> @@ -942,6 +1016,44 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
>>   }
>>   EXPORT_SYMBOL_GPL(devm_of_pwm_get);
>>
>> +/**
>> + * devm_fwnode_pwm_get() - request a resource managed PWM from firmware node
>> + * @dev: device for PWM consumer
>> + * @fwnode: firmware node to get the PWM from
>> + * @con_id: consumer name
>> + *
>> + * Returns the PWM device parsed from the firmware node. See of_pwm_get() and
>> + * acpi_pwm_get() for a detailed description.
>> + *
>> + * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
>> + * error code on failure.
>> + */
>> +struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
>> +                                    struct fwnode_handle *fwnode,
>> +                                    const char *con_id)
>
> I am wondering if it would be better just to convert the existing of_
> calls to device_property calls and make it more generic.

With this first patch I wanted to keep DT and ACPI paths separate. Merging 
the two paths as far as possible is reasonable but should be done in a 
second step.

Nikolaus
