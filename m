Return-Path: <linux-pwm+bounces-4798-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352ECA2A456
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 10:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E7E318857E6
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Feb 2025 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B3A226541;
	Thu,  6 Feb 2025 09:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="rMoe7h01"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABB022616E;
	Thu,  6 Feb 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834089; cv=none; b=Wxz/lcOs1XKYenbXj4NMs87MjEoMkgurAY8JwbZP6xLEmdFZ4I/Z2KoWZidz98KQqXYilroRUF/GVFwlToF5gensOGvEhrSw/2yybxOPOgm/ba/+Xyd3fUs52l1UyHV2wsZI8WwsVLy7RAcfu3A7rz0Zi8usELBvRHi0t5VkpiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834089; c=relaxed/simple;
	bh=zYX39rabcyN3ixLWykJR0Z37Lozt4lrlAfubxzRMZP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8wC1HtDnVcAmSzhnGuQ09RO1csYcSJoqcfz4rzpR4rz8O/PSqekTbNjF3tKesRlHIzbs20wISsKWUjSwoCNMa8euyfU61ER6HM3Lrzj4sIi/B+KwqZezlMhu1b3txj+KTFiQPS7Ov5iDBDS2mSE6qxDZTNGuSARQ8f+i1rQXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=rMoe7h01; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59260.dip0.t-ipconnect.de [217.229.146.96])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 533ED2FC0079;
	Thu,  6 Feb 2025 10:28:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1738834082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k+/kYSqfzTrf6Y+pMyJWXvqfqv5LJD/YJBcpQ+BYYMw=;
	b=rMoe7h01HYn1Uc8klsFC3ZE3g+OvbbHAT2gSbdgdxKukc0jsloXs2JizLln6tlHYvJTGuA
	roL0IVX+zXE+UOkPck+/5fInud7AfHNK4t3mI0R2KJ5Yxvh+J7VP7YcIcdPth6UaejaiY/
	5ko8hBSeoXDp0gA0Deys5W3pwSi2ft0=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <fce7929b-87e7-4c9a-8a54-ab678c5dc6b4@tuxedocomputers.com>
Date: Thu, 6 Feb 2025 10:28:01 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI
 TFAN via hwmon
To: Guenter Roeck <linux@roeck-us.net>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, ukleinek@kernel.org, jdelvare@suse.com
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20250205162109.222619-1-wse@tuxedocomputers.com>
 <20250205162109.222619-2-wse@tuxedocomputers.com>
 <767538f2-d79e-44e4-a671-4be56a3cfe44@roeck-us.net>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <767538f2-d79e-44e4-a671-4be56a3cfe44@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 05.02.25 um 19:01 schrieb Guenter Roeck:
> On 2/5/25 08:19, Werner Sembach wrote:
>> The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
>> ACPI interface which currently consists of the TFAN device. This has ACPI
>> functions to control the built in fans and monitor fan speeds and CPU and
>> GPU temprature.
>>
>> This driver implements this TFAN device via the hwmon subsystem with an
>> added temprature check that ensure a minimum fanspeed at certain
>> tempratures. This allows userspace controlled, but hardware safe, custom
>> fan curves.
>>
>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>> ---
>>   MAINTAINERS                                   |   6 +
>>   drivers/platform/x86/Kconfig                  |   2 +
>>   drivers/platform/x86/Makefile                 |   3 +
>>   drivers/platform/x86/tuxedo/Kbuild            |   6 +
>>   drivers/platform/x86/tuxedo/Kconfig           |   6 +
>>   drivers/platform/x86/tuxedo/nbxx/Kbuild       |   9 +
>>   drivers/platform/x86/tuxedo/nbxx/Kconfig      |  13 +
>>   .../x86/tuxedo/nbxx/acpi_tuxi_hwmon.c         | 421 ++++++++++++++++++
>>   .../x86/tuxedo/nbxx/acpi_tuxi_hwmon.h         |  14 +
>>   .../platform/x86/tuxedo/nbxx/acpi_tuxi_init.c |  60 +++
>>   .../platform/x86/tuxedo/nbxx/acpi_tuxi_init.h |  16 +
>>   .../platform/x86/tuxedo/nbxx/acpi_tuxi_util.c |  58 +++
>>   .../platform/x86/tuxedo/nbxx/acpi_tuxi_util.h |  84 ++++
>>   13 files changed, 698 insertions(+)
>>   create mode 100644 drivers/platform/x86/tuxedo/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.c
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.h
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.c
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.h
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
>>   create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0fa7c5728f1e6..2d3fe9de4e9cf 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23916,6 +23916,12 @@ T:    git 
>> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git turbostat
>>   F:    tools/power/x86/turbostat/
>>   F:    tools/testing/selftests/turbostat/
>>   +TUXEDO DRIVERS
>> +M:    Werner Sembach <wse@tuxedocomputers.com>
>> +L:    platform-driver-x86@vger.kernel.org
>> +S:    Supported
>> +F:    drivers/platform/x86/tuxedo/
>> +
>>   TW5864 VIDEO4LINUX DRIVER
>>   M:    Bluecherry Maintainers <maintainers@bluecherrydvr.com>
>>   M:    Andrey Utkin <andrey.utkin@corp.bluecherry.net>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 0258dd879d64b..9b78a1255c08e 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1199,3 +1199,5 @@ config P2SB
>>         The main purpose of this library is to unhide P2SB device in case
>>         firmware kept it hidden on some platforms in order to access devices
>>         behind it.
>> +
>> +source "drivers/platform/x86/tuxedo/Kconfig"
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index e1b1429470674..1562dcd7ad9a5 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -153,3 +153,6 @@ obj-$(CONFIG_WINMATE_FM07_KEYS)        += 
>> winmate-fm07-keys.o
>>     # SEL
>>   obj-$(CONFIG_SEL3350_PLATFORM)        += sel3350-platform.o
>> +
>> +# TUXEDO
>> +obj-y                    += tuxedo/
>> diff --git a/drivers/platform/x86/tuxedo/Kbuild 
>> b/drivers/platform/x86/tuxedo/Kbuild
>> new file mode 100644
>> index 0000000000000..0de6c7871db95
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kbuild
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +obj-y    += nbxx/
>> diff --git a/drivers/platform/x86/tuxedo/Kconfig 
>> b/drivers/platform/x86/tuxedo/Kconfig
>> new file mode 100644
>> index 0000000000000..82df7419cf29d
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/Kconfig
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +source "drivers/platform/x86/tuxedo/nb04/Kconfig"
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kbuild 
>> b/drivers/platform/x86/tuxedo/nbxx/Kbuild
>> new file mode 100644
>> index 0000000000000..db8def8ffe8f6
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/Kbuild
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +tuxedo_nbxx_acpi_tuxi-y            := acpi_tuxi_init.o
>> +tuxedo_nbxx_acpi_tuxi-y            += acpi_tuxi_util.o
>> +tuxedo_nbxx_acpi_tuxi-y            += acpi_tuxi_hwmon.o
>> +obj-$(CONFIG_TUXEDO_NBXX_ACPI_TUXI)    += tuxedo_nbxx_acpi_tuxi.o
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/Kconfig 
>> b/drivers/platform/x86/tuxedo/nbxx/Kconfig
>> new file mode 100644
>> index 0000000000000..827c65c410fb2
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +#
>> +# TUXEDO X86 Platform Specific Drivers
>> +#
>> +
>> +config TUXEDO_NBXX_ACPI_TUXI
>> +    tristate "TUXEDO NBxx ACPI TUXI Platform Driver"
>> +    help
>> +      This driver implements the ACPI TUXI device found on some TUXEDO
>> +      Notebooks. Currently this consists only of the TFAN subdevice which is
>> +      implemented via hwmon.
>> +
>> +      When compiled as a module it will be called tuxedo_nbxx_acpi_tuxi
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.c 
>> b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.c
>> new file mode 100644
>> index 0000000000000..8ebb2bfc19e20
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.c
>> @@ -0,0 +1,421 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#include <linux/array_size.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "acpi_tuxi_util.h"
>> +
>> +#include "acpi_tuxi_hwmon.h"
>> +
>> +struct tuxi_hwmon_driver_data_t {
>> +    struct delayed_work work;
>> +    struct device *hwmdev;
>> +    u8 fan_count;
>> +    const char **fan_types;
>> +    u8 *temp_level;
>> +    u8 *curr_speed;
>> +    u8 *want_speed;
>> +    u8 pwm_enabled;
>
> Pretty much all those variables are not range checked when assigned.
> I commented on one of them below, but it pretty much applies everywhere.
> Overflows will have some interesting results.

curr_speed comes from the firmware where I know what the max value is (255).

temp_level comes from the code itself and has a fixed max value (length of the 
hard coded temp_levels array + 1).

fan_count while technically not limited by definition will realworld never be 
anything big (realistically it will go up to about 4).

Would it be enough to document this?

pwm_enabled and want_speed see below.

>
>> +};
>> +
>> +struct tuxi_temp_high_config_t {
>> +    long temp;
>> +    u8 min_speed;
>> +};
>> +
>> +#define TUXI_SAFEGUARD_PERIOD 1000
>> +
>> +#define TUXI_PWM_FAN_ON_MIN_SPEED 0x40 // ~25%
>> +
>> +static struct tuxi_temp_high_config_t temp_levels[] = {
>> +    {  80000, 0x4d }, // ~30%
>> +    {  90000, 0x66 }, // ~40%
>> +    {  95000, 0x99 }, // ~60%
>> +    { 100000, 0xff }, // 100%
>> +    { }
>> +};
>> +
>> +static umode_t hwm_is_visible(const void * __always_unused data,
>> +                  enum hwmon_sensor_types type,
>> +                  u32 __always_unused attr,
>> +                  int __always_unused channel)
>> +{
>> +    switch (type) {
>> +    case hwmon_fan:
>> +        return 0444;
>> +    case hwmon_pwm:
>> +        return 0644;
>> +    case hwmon_temp:
>> +        return 0444;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int hwm_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>> +            int channel, long *val)
>> +{
>> +    struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +    struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +    int ret;
>> +
>> +    unsigned long long params[2];
>> +    unsigned long long retval;
>> +
>> +    switch (type) {
>> +    case hwmon_fan:
>> +        params[0] = channel;
>> +        ret = tuxi_tfan_method(pdev,
>> +                       TUXI_TFAN_METHOD_GET_FAN_RPM,
>> +                       params, 1, &retval);
>> +        *val = retval;
>> +        return ret;
>> +    case hwmon_pwm:
>> +        switch (attr) {
>> +        case hwmon_pwm_input:
>> +            if (driver_data->pwm_enabled) {
>> +                *val = driver_data->curr_speed[channel];
>> +                return 0;
>> +            }
>> +            params[0] = channel;
>> +            ret = tuxi_tfan_method(pdev,
>> +                           TUXI_TFAN_METHOD_GET_FAN_SPEED,
>> +                           params, 1, &retval);
>> +            *val = retval;
>> +            return ret;
>> +        case hwmon_pwm_enable:
>> +            *val = driver_data->pwm_enabled;
>> +            return ret;
>> +        }
>> +        break;
>> +    case hwmon_temp:
>> +        params[0] = channel;
>> +        ret = tuxi_tfan_method(pdev,
>> +                       TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>> +                       params, 1, &retval);
>> +        *val = retval * 100 - 272000;
>> +        return ret;
>> +    default:
>> +        break;
>> +    }
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int hwm_read_string(struct device *dev,
>> +               enum hwmon_sensor_types __always_unused type,
>> +               u32 __always_unused attr, int channel,
>> +               const char **str)
>> +{
>> +    struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +
>> +    *str = driver_data->fan_types[channel];
>> +
>> +    return 0;
>> +}
>> +
>> +static int write_speed(struct device *dev, int channel, long val)
>> +{
>> +    struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +    struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +    int ret;
>> +
>> +    unsigned long long params[2];
>> +
>> +    params[0] = channel;
>> +
>> +    u8 temp_level, min_speed;
>> +
>> +    temp_level = driver_data->temp_level[channel];
>> +    if (temp_level) {
>> +        min_speed = temp_levels[temp_level].min_speed;
>> +        if (val < min_speed)
>> +            val = min_speed;
>> +    }
>> +
>> +    if (val < TUXI_PWM_FAN_ON_MIN_SPEED / 2)
>> +        params[1] = 0;
>> +    else if (val < TUXI_PWM_FAN_ON_MIN_SPEED)
>> +        params[1] = TUXI_PWM_FAN_ON_MIN_SPEED;
>> +    else
>> +        params[1] = val;
>> +
>> +    ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_SPEED,
>> +                   params, 2, NULL);
>> +    if (ret)
>> +        return ret;
>> +
>> +    driver_data->curr_speed[channel] = val;
>> +
>> +    return 0;
>> +}
>> +
>> +static int hwm_write(struct device *dev,
>> +             enum hwmon_sensor_types __always_unused type, u32 attr,
>> +             int channel, long val)
>> +{
>> +    struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(dev);
>> +    struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +    unsigned int i;
>> +    int ret;
>> +
>> +    unsigned long long params[2];
>> +
>> +    switch (attr) {
>> +    case hwmon_pwm_input:
>> +        if (driver_data->pwm_enabled) {
>> +            driver_data->want_speed[channel] = val;
>> +            return write_speed(dev, channel, val);
>> +        }
>> +
>> +        return 0;
>> +    case hwmon_pwm_enable:
>> +        params[0] = val;
>> +        ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE,
>> +                       params, 1, NULL);
>> +        if (ret)
>> +            return ret;
>> +
>> +        driver_data->pwm_enabled = val;
>
> val is not range checked. Since pwm_enabled is declared as u8,
> writing a multiple of 256 will cause it to be 0. This may result
> in unexpected behavior.

I somehow assumed that pwm_enabled val can only be 1 or 0, will fix this brain 
fail in the next version.

Same goes for the pwm value which should only between 0 and 255.

>
>> +
>> +        /* Activating PWM sets speed to 0. Alternativ design decision
>> +         * could be to keep the current value. This would require proper
>> +         * setting of driver_data->curr_speed for example.
>> +         */
>> +        if (val)
>> +            for (i = 0; i < driver_data->fan_count; ++i) {
>> +                ret = write_speed(dev, i, 0);
>> +                if (ret)
>> +                    return ret;
>> +            }
>> +
>> +        return 0;
>> +    }
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct hwmon_ops hwmops = {
>> +    .is_visible = hwm_is_visible,
>> +    .read = hwm_read,
>> +    .read_string = hwm_read_string,
>> +    .write = hwm_write,
>> +};
>> +
>> +static struct hwmon_channel_info hwmcinfo_fan = {
>> +    .type = hwmon_fan,
>> +};
>> +
>> +static struct hwmon_channel_info hwmcinfo_pwm = {
>> +    .type = hwmon_pwm,
>> +};
>> +
>> +static struct hwmon_channel_info hwmcinfo_temp = {
>> +    .type = hwmon_temp,
>> +};
>> +
>> +static const struct hwmon_channel_info * const hwmcinfo[] = {
>> +    &hwmcinfo_fan,
>> +    &hwmcinfo_pwm,
>> +    &hwmcinfo_temp,
>> +    NULL
>> +};
>> +
>> +static const struct hwmon_chip_info hwminfo = {
>> +    .ops = &hwmops,
>> +    .info = hwmcinfo
>> +};
>> +
>> +static void tuxi_periodic_hw_safeguard(struct work_struct *work)
>> +{
>> +    struct tuxi_hwmon_driver_data_t *driver_data;
>> +
>> +    driver_data = container_of(work, struct tuxi_hwmon_driver_data_t,
>> +                   work.work);
>> +
>> +    struct device *dev = driver_data->hwmdev;
>> +    struct acpi_device *pdev = to_acpi_device(dev->parent);
>> +    unsigned int i, j;
>> +
>> +    unsigned long long params[2];
>> +    unsigned long long retval;
>> +
>> +    long temp, temp_low, temp_high;
>> +    u8 temp_level, min_speed, curr_speed, want_speed;
>> +
>> +    for (i = 0; i < driver_data->fan_count; ++i) {
>> +        params[0] = i;
>> +        tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>> +                 params, 1, &retval);
>
> The return value from tuxi_tfan_method() is checked elsewhere. If there is
> an error, retval may contain a random value. The resulting behavior may be
> unexpected.
Thanks for spotting the missing error handling. I will come up with a safe fallback.
>
>> +        temp = retval * 100 - 272000;
>> +
>> +        for (j = 0; temp_levels[j].temp; ++j) {
>> +            temp_low = j == 0 ? -272000 : temp_levels[j-1].temp;
>> +            temp_high = temp_levels[j].temp;
>> +            if (driver_data->temp_level[i] > j)
>> +                temp_high -= 2000; // hysteresis
>> +
>> +            if (temp >= temp_low && temp < temp_high)
>> +                driver_data->temp_level[i] = j;
>> +        }
>> +        if (temp >= temp_high)
>> +            driver_data->temp_level[i] = j;
>> +
>> +        temp_level = driver_data->temp_level[i];
>> +        min_speed = temp_level == 0 ?
>> +            0 : temp_levels[temp_level-1].min_speed;
>> +        curr_speed = driver_data->curr_speed[i];
>> +        want_speed = driver_data->want_speed[i];
>> +
>> +        if (want_speed < min_speed) {
>> +            if (curr_speed < min_speed)
>> +                write_speed(dev, i, min_speed);
>> +        } else if (curr_speed != want_speed)
>> +            write_speed(dev, i, want_speed);
>> +    }
>> +
>> +    schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
>> +}
>
> This is not expected functionality of a hardware monitoring driver.
> Hardware monmitoring drivers should not replicate userspace or
> thermal subsystem functionality.
>
> This would be unacceptable in drivers/hwmon/.

Problem is: The thermal subsystem doesn't do this either as far as I can tell.

See this: 
https://lore.kernel.org/all/453e0df5-416b-476e-9629-c40534ecfb72@tuxedocomputers.com/ 
and this: 
https://lore.kernel.org/all/41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com/ 
thread.

The short version is: The Thermal subsystem always allows userspace to select 
the "userspace" governor which has no way for the kernel to enforce a minimum speed.

As far as I can tell the Thermal subsystem would require a new governor for the 
behavior i want to archive and more importantly, a way to restrict which 
governors userspace can select.

As to why I don't want grant userspace full control: The firmware is perfectly 
fine with accepting potentially mainboard frying settings (as mentioned in the 
cover letter) and the lowest level I can write code for is the kernel driver. So 
that's the location I need to prevent this.

Also hwmon is not purely a hardware monitoring, it also allows writing 
fanspeeds. Or did I miss something and this shouldn't actually be used?

>
>> +
>> +int tuxi_hwmon_add_devices(struct acpi_device *pdev, struct device **hwmdev)
>> +{
>> +    struct tuxi_hwmon_driver_data_t *driver_data;
>> +    int ret;
>> +
>> +    unsigned long long params[2];
>> +    unsigned long long retval;
>> +
>> +    u32 *hwmcinfo_fan_config, *hwmcinfo_pwm_config, *hwmcinfo_temp_config;
>> +
>> +    /* The first version of TUXI TFAN didn't have the Get Fan Temperature
>> +     * method which is integral to this driver. So probe for existence and
>> +     * abort otherwise.
>> +     *
>> +     * The Get Fan Speed method is also missing in that version, but was
>> +     * added in the same version so it doesn't have to be probe separately.
>> +     */
>> +    params[0] = 0;
>> +    ret = tuxi_tfan_method(pdev,
>> +                   TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>> +                   params, 1, &retval);
>> +    if (ret)
>> +        return ret;
>> +
>> +    driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
>> +                   GFP_KERNEL);
>> +    if (!driver_data)
>> +        return -ENOMEM;
>> +
>> +    /* Loading this module sets the fan mode to auto. Alternative design
>> +     * decision could be to keep the current value. This would require
>> +     * proper initialization of driver_data->curr_speed for example.
>> +     */
>> +    params[0] = 0;
>> +    ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1,
>> +                   NULL);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_COUNT, NULL, 0,
>> +                   &retval);
>> +    if (ret)
>> +        return ret;
>> +    driver_data->fan_count = retval;
>> +
>> +    driver_data->temp_level = devm_kcalloc(&pdev->dev,
>> +                           driver_data->fan_count,
>> +                           sizeof(*driver_data->temp_level),
>> +                           GFP_KERNEL);
>> +    if (driver_data->temp_level == NULL)
>> +        return -ENOMEM;
>> +    driver_data->curr_speed = devm_kcalloc(&pdev->dev,
>> +                           driver_data->fan_count,
>> +                           sizeof(*driver_data->curr_speed),
>> +                           GFP_KERNEL);
>> +    if (driver_data->curr_speed == NULL)
>> +        return -ENOMEM;
>> +    driver_data->want_speed = devm_kcalloc(&pdev->dev,
>> +                           driver_data->fan_count,
>> +                           sizeof(*driver_data->want_speed),
>> +                           GFP_KERNEL);
>> +    if (driver_data->want_speed == NULL)
>> +        return -ENOMEM;
>> +    driver_data->fan_types = devm_kcalloc(&pdev->dev,
>> +                          driver_data->fan_count,
>> +                          sizeof(*driver_data->fan_types),
>> +                          GFP_KERNEL);
>> +    if (driver_data->fan_types == NULL)
>> +        return -ENOMEM;
>> +
>> +    hwmcinfo_fan_config = devm_kcalloc(&pdev->dev,
>> +                       driver_data->fan_count + 1,
>> +                       sizeof(*hwmcinfo_fan_config),
>> +                       GFP_KERNEL);
>> +    if (hwmcinfo_fan_config == NULL)
>> +        return -ENOMEM;
>> +    hwmcinfo_pwm_config = devm_kcalloc(&pdev->dev,
>> +                       driver_data->fan_count + 1,
>> +                       sizeof(*hwmcinfo_pwm_config),
>> +                       GFP_KERNEL);
>> +    if (hwmcinfo_pwm_config == NULL)
>> +        return -ENOMEM;
>> +    hwmcinfo_temp_config = devm_kcalloc(&pdev->dev,
>> +                        driver_data->fan_count + 1,
>> +                        sizeof(*hwmcinfo_temp_config),
>> +                        GFP_KERNEL);
>> +    if (hwmcinfo_temp_config == NULL)
>> +        return -ENOMEM;
>> +
>> +    for (unsigned long long i = 0; i < driver_data->fan_count; ++i) {
>
> driver_data->fan_count is declaered as u8. Using an unsigned long long to iterate
> over it seems to be a bit unusual.
oversight, i initially iterated over the acpi retval directly and was just 
typematching it here, will fix in the next version
>
>> +        hwmcinfo_fan_config[i] = HWMON_F_INPUT | HWMON_F_LABEL;
>> +        hwmcinfo_pwm_config[i] = HWMON_PWM_INPUT | HWMON_PWM_ENABLE;
>> +        hwmcinfo_temp_config[i] = HWMON_T_INPUT | HWMON_T_LABEL;
>> +
>> +        params[0] = i;
>> +        ret = tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TYPE,
>> +                       params, 1, &retval);
>> +        if (ret)
>> +            return ret;
>> +        else if (retval >= ARRAY_SIZE(tuxi_fan_type_labels))
>> +            return -EOPNOTSUPP;
>> +        driver_data->fan_types[i] = tuxi_fan_type_labels[retval];
>> +    }
>> +    hwmcinfo_fan.config = hwmcinfo_fan_config;
>> +    hwmcinfo_pwm.config = hwmcinfo_pwm_config;
>> +    hwmcinfo_temp.config = hwmcinfo_temp_config;
>> +
>
> Personally I think this is way too complicated. It would make much more sense
> to assume a reasonable maximum (say, 16) and use fixed size arrays to access
> the data. The is_visible function can then simply return 0 for larger channel
> values if the total number of fans is less than the ones configured in the
> channel information.
Didn't know it was possible to filter extra entries out completely with the 
is_visible function, thanks for the tip.
>
> Also, as already mentioned, there is no range check of fan_count. This will
> cause some oddities if the system ever claims to have 256+ fans.
Will not happen, but i guess a singular additional if in the init doesn't hurt, 
i can add it.
>
>> +    *hwmdev = devm_hwmon_device_register_with_info(&pdev->dev,
>> +                               "tuxedo_nbxx_acpi_tuxi",
>> +                               driver_data, &hwminfo,
>> +                               NULL);
>> +    if (PTR_ERR_OR_ZERO(*hwmdev))
>> +        return PTR_ERR_OR_ZERO(*hwmdev);
>> +
> Why not just return hwmdev ?
because if hwmon is NULL it is still an error, i have to look again at what 
actually is returned by PTR_ERR_OR_ZERO on zero.
>
>> +    driver_data->hwmdev = *hwmdev;
>> +
>> +    INIT_DELAYED_WORK(&driver_data->work, tuxi_periodic_hw_safeguard);
>> +    schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
>> +
>> +    return 0;
>> +}
>> +EXPORT_SYMBOL(tuxi_hwmon_add_devices);
>> +
>> +void tuxi_hwmon_remove_devices(struct device *hwmdev)
>> +{
>> +    struct tuxi_hwmon_driver_data_t *driver_data = dev_get_drvdata(hwmdev);
>> +    struct acpi_device *pdev = to_acpi_device(hwmdev->parent);
>> +
>> +    unsigned long long params[2];
>> +
>> +    cancel_delayed_work_sync(&driver_data->work);
>> +
>> +    params[0] = 0;
>> +    tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_SET_FAN_MODE, params, 1, NULL);
>> +}
>> +EXPORT_SYMBOL(tuxi_hwmon_remove_devices);
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.h 
>> b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.h
>> new file mode 100644
>> index 0000000000000..248730fab8574
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.h
>> @@ -0,0 +1,14 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#ifndef __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_HWMON_H__
>> +#define __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_HWMON_H__
>> +
>> +#include <linux/acpi.h>
>> +
>> +int tuxi_hwmon_add_devices(struct acpi_device *pdev, struct device **hwmdev);
>> +void tuxi_hwmon_remove_devices(struct device *hwmdev);
>> +
>> +#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_HWMON_H__
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.c 
>> b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.c
>> new file mode 100644
>> index 0000000000000..5e8edb458aba2
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.c
>> @@ -0,0 +1,60 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/module.h>
>> +
>> +#include "acpi_tuxi_hwmon.h"
>> +
>> +#include "acpi_tuxi_init.h"
>> +
>> +static const struct acpi_device_id acpi_device_ids[] = {
>> +    {"TUXI0000", 0},
>> +    {"", 0}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, acpi_device_ids);
>> +
>> +static int add(struct acpi_device *device)
>> +{
>> +    struct tuxi_driver_data_t *driver_data;
>> +    acpi_status status;
>> +
>> +    driver_data = devm_kzalloc(&device->dev, sizeof(*driver_data),
>> +                   GFP_KERNEL);
>> +    if (!driver_data)
>> +        return -ENOMEM;
>> +
>> +    // Find subdevices
>> +    status = acpi_get_handle(device->handle, "TFAN",
>> +                 &driver_data->tfan_handle);
>> +    if (ACPI_FAILURE(status))
>> +        return_ACPI_STATUS(status);
>> +
>> +    dev_set_drvdata(&device->dev, driver_data);
>> +
>> +    return tuxi_hwmon_add_devices(device, &driver_data->hwmdev);
>> +}
>> +
>> +static void remove(struct acpi_device *device)
>> +{
>> +    struct tuxi_driver_data_t *driver_data = dev_get_drvdata(&device->dev);
>> +
>> +    tuxi_hwmon_remove_devices(driver_data->hwmdev);
>> +}
>> +
>> +static struct acpi_driver acpi_driver = {
>> +    .name = "tuxedo_nbxx_acpi_tuxi",
>> +    .ids = acpi_device_ids,
>> +    .ops = {
>> +        .add = add,
>> +        .remove = remove,
>> +    },
>> +};
>> +
>> +module_acpi_driver(acpi_driver);
>> +
>> +MODULE_DESCRIPTION("TUXEDO TUXI");
>> +MODULE_AUTHOR("Werner Sembach <wse@tuxedocomputers.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.h 
>> b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.h
>> new file mode 100644
>> index 0000000000000..33388332a2328
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.h
>> @@ -0,0 +1,16 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#ifndef __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_INIT_H__
>> +#define __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_INIT_H__
>> +
>> +#include <linux/acpi.h>
>> +
>> +struct tuxi_driver_data_t {
>> +    acpi_handle tfan_handle;
>> +    struct device *hwmdev;
>> +};
>> +
>> +#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_INIT_H__
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c 
>> b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
>> new file mode 100644
>> index 0000000000000..292b739a161e7
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
>> @@ -0,0 +1,58 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#include <linux/acpi.h>
>> +
>> +#include "acpi_tuxi_init.h"
>> +
>> +#include "acpi_tuxi_util.h"
>> +
>> +static int __acpi_eval_intarray_in_int_out(acpi_handle handle,
>> +                       acpi_string pathname,
>> +                       unsigned long long *params,
>> +                       u32 pcount,
>> +                       unsigned long long *retval)
>> +{
>> +    struct acpi_object_list arguments;
>> +    unsigned long long data;
>> +    acpi_status status;
>> +
>> +    if (pcount > 0) {
>> +        pr_debug("Params:\n");
>> +
>> +        arguments.count = pcount;
>> +        arguments.pointer = kcalloc(pcount, sizeof(*arguments.pointer),
>> +                        GFP_KERNEL);
>> +        for (int i = 0; i < pcount; ++i) {
>> +            pr_debug("%llu\n", params[i]);
>> +
>> +            arguments.pointer[i].type = ACPI_TYPE_INTEGER;
>> +            arguments.pointer[i].integer.value = params[i];
>> +        }
>> +        status = acpi_evaluate_integer(handle, pathname, &arguments,
>> +                           &data);
>> +        kfree(arguments.pointer);
>> +    } else {
>> +        status = acpi_evaluate_integer(handle, pathname, NULL, &data);
>> +    }
>> +    if (ACPI_FAILURE(status))
>> +        return_ACPI_STATUS(status);
>> +
>> +    if (retval)
>> +        *retval = data;
>> +
>> +    return 0;
>> +}
>> +
>> +int tuxi_tfan_method(struct acpi_device *device, acpi_string method,
>> +             unsigned long long *params, u32 pcount,
>> +             unsigned long long *retval)
>> +{
>> +    struct tuxi_driver_data_t *driver_data = dev_get_drvdata(&device->dev);
>> +
>> +    return __acpi_eval_intarray_in_int_out(driver_data->tfan_handle, method,
>> +                           params, pcount, retval);
>> +}
>> +EXPORT_SYMBOL(tuxi_tfan_method);
>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.h 
>> b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.h
>> new file mode 100644
>> index 0000000000000..670fe02249d06
>> --- /dev/null
>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.h
>> @@ -0,0 +1,84 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>> + */
>> +
>> +#ifndef __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_UTIL_H__
>> +#define __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_UTIL_H__
>> +
>> +#include <linux/acpi.h>
>> +
>> +/*
>> + * Set fan speed target
>> + *
>> + * Set a specific fan speed (needs manual mode)
>> + *
>> + * Arg0: Fan index
>> + * Arg1: Fan speed as a fraction of maximum speed (0-255)
>> + */
>> +#define TUXI_TFAN_METHOD_SET_FAN_SPEED        "SSPD"
>> +
>> +/*
>> + * Get fan speed target
>> + *
>> + * Arg0: Fan index
>> + * Returns: Current fan speed target a fraction of maximum speed (0-255)
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_SPEED        "GSPD"
>> +
>> +/*
>> + * Get fans count
>> + *
>> + * Returns: Number of individually controllable fans
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_COUNT        "GCNT"
>> +
>> +/*
>> + * Set fans mode
>> + *
>> + * Arg0: 0 = auto, 1 = manual
>> + */
>> +#define TUXI_TFAN_METHOD_SET_FAN_MODE        "SMOD"
>> +
>> +/*
>> + * Get fans mode
>> + *
>> + * Returns: 0 = auto, 1 = manual
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_MODE        "GMOD"
>> +
>> +/*
>> + * Get fan type/what the fan is pointed at
>> + *
>> + * Arg0: Fan index
>> + * Returns: 0 = general, 1 = CPU, 2 = GPU
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_TYPE        "GTYP"
>> +
>> +static const char * const tuxi_fan_type_labels[] = {
>> +    "general",
>> +    "cpu",
>> +    "gpu"
>> +};
>> +
>> +/*
>> + * Get fan temperature/temperature of what the fan is pointed at
>> + *
>> + * Arg0: Fan index
>> + * Returns: Temperature sensor value in 10ths of degrees kelvin
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE    "GTMP"
>> +
>> +/*
>> + * Get actual fan speed in RPM
>> + *
>> + * Arg0: Fan index
>> + * Returns: Speed sensor value in revolutions per minute
>> + */
>> +#define TUXI_TFAN_METHOD_GET_FAN_RPM        "GRPM"
>> +
>> +int tuxi_tfan_method(struct acpi_device *device, acpi_string method,
>> +             unsigned long long *params, u32 pcount,
>> +             unsigned long long *retval);
>> +
>> +#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_UTIL_H__
>
Thanks for the quick feedback so far.

Kind regards,

Werner


