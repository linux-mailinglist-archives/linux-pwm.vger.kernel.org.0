Return-Path: <linux-pwm+bounces-4823-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA9A2CBD9
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 19:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20F316AA03
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367CD1A239F;
	Fri,  7 Feb 2025 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="BqRLI3RY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF4723C8D6;
	Fri,  7 Feb 2025 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953889; cv=none; b=YMQEVP0f0MslU20Pk3q85HIh+VEYixmzQSgjvUptAkKlgprGXnyZbTwYZu8iLbsF+ZubQha6xoV06SrnveIZ3mdcJpzxY5jZNPTGgCTpigESaHGjzmWSBmTqjbViNSTErQzUk9BjDZHh4OubBm3vqj5yajs2njGQVBiYySfQxSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953889; c=relaxed/simple;
	bh=AsQurwdDOgdIjFL3cRJVYdubuIPI0faKGIQ2IIj4y9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h4xf7LIEVCoPqUwnELocL95M5OW0lYLRSiNxj1SQl2TnKQubv6WMSCvNkWsanxhejTblhh9vmWVr48/6Amr0O5qlUmZqIA2IVo1sNHx8go+PuiyDnJoEem3NBuyWpxzVs/gYkJJW+fqiltdvQDom5gHZZwJuE8szfBlkEjEnj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=BqRLI3RY; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59260.dip0.t-ipconnect.de [217.229.146.96])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id A06D82FC006B;
	Fri,  7 Feb 2025 19:44:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1738953883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0/Npr2aYsuX4RiSHrF3i7/a3fwJRJEpxwy130oXDFg=;
	b=BqRLI3RY7dmVpp/MORJ9m3MamQvcOFLieRE2FGrScQ/zfZjTxQpW7ZNE2qJ1fJrqt4z/Xj
	yNYGTEpRKTdDbXuh3Tq7W89D7n6PR/RpIiLUMkn1ygAX395tBinIqCqE3IAp3PyBIMq0Jq
	1zSvrpjJtarGFbUUsLft/0qT4UmTAFI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <4a5e6ff0-7783-46f0-b0af-78f85d555ac8@tuxedocomputers.com>
Date: Fri, 7 Feb 2025 19:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI
 TFAN via hwmon
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, ukleinek@kernel.org,
 jdelvare@suse.com, linux@roeck-us.net, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250205162109.222619-1-wse@tuxedocomputers.com>
 <20250205162109.222619-2-wse@tuxedocomputers.com>
 <dde736d4-6343-30e3-2bab-6eebbf4515e9@linux.intel.com>
 <358c235f-14e4-43ef-bc82-9ad5d54f0976@tuxedocomputers.com>
 <d99bb466-f9e6-9e86-8a0c-55f51655fb6f@linux.intel.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <d99bb466-f9e6-9e86-8a0c-55f51655fb6f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 07.02.25 um 12:53 schrieb Ilpo Järvinen:
> On Thu, 6 Feb 2025, Werner Sembach wrote:
>> Am 06.02.25 um 10:51 schrieb Ilpo Järvinen:
>>> On Wed, 5 Feb 2025, Werner Sembach wrote:
>>>
>>>> The TUXEDO Sirius 16 Gen1 & Gen2 have the custom TUXEDO Interface (TUXI)
>>>> ACPI interface which currently consists of the TFAN device. This has ACPI
>>>> functions to control the built in fans and monitor fan speeds and CPU and
>>>> GPU temprature.
>>>>
>>>> This driver implements this TFAN device via the hwmon subsystem with an
>>>> added temprature check that ensure a minimum fanspeed at certain
>>>> tempratures. This allows userspace controlled, but hardware safe, custom
>>> temperatures
>> thx for spotting
>>>> fan curves.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>
>>>> +	for (i = 0; i < driver_data->fan_count; ++i) {
>>>> +		params[0] = i;
>>>> +		tuxi_tfan_method(pdev, TUXI_TFAN_METHOD_GET_FAN_TEMPERATURE,
>>>> +				 params, 1, &retval);
>>>> +		temp = retval * 100 - 272000;
>>>> +
>>>> +		for (j = 0; temp_levels[j].temp; ++j) {
>>>> +			temp_low = j == 0 ? -272000 : temp_levels[j-1].temp;
>>> Please add a define for 272000 magic, or do you actually want to use one
>>> of the _kelvin conversion functions in linux/units.h ?
>> I just realized that it should be 273000.
>>
>> Using the conversion functions would make it more complicated because the ec
>> pretends to return to a 10th degree precision but actually only return to a
>> full degree precission.
>>
>> So i would need to cut of the last digit, convert and then readd it. When i do
>> it directly in the code i can just use 273000 instead of 273150 and just
>> ignore the last digits.
> Fine, but add a local define for it then with a comment about the
> precision compared with the generic define/conversion functions.
ack
>
>>> Missing spaces around - operator.
>>>
>>>> +			temp_high = temp_levels[j].temp;
>>>> +			if (driver_data->temp_level[i] > j)
>>>> +				temp_high -= 2000; // hysteresis
>>> 2 * MILLIDEGREE_PER_DEGREE ?
>>>
>>> Use define for it so you can place HYSTERESIS into its name and forgo the
>>> comment.
>> kk
>>>> +
>>>> +			if (temp >= temp_low && temp < temp_high)
>>>> +				driver_data->temp_level[i] = j;
>>>> +		}
>>>> +		if (temp >= temp_high)
>>>> +			driver_data->temp_level[i] = j;
>>> This loop should be in a helper I think. Naming it reasonably would also
>>> make it easier to understand what the loop does.
>> only place i use it, i could just add a comment, but i can also do it in a
>> separate function.
> I know it's the only user but what the loop does is relatively complex,
> and requires a few variables, etc. Is relatively self-contained
> algorithmically.
>
> Splitting into two functions, both functions could be more focused and
> clear on their intent. Cleverly naming the helper function such that it
> explain what happens in it, can often help to avoid the need to add any
> comments (comments may be needed at times, but when we can avoid one
> there's one place less to get out-of-sync with the code, which tends to
> happen with comments :-)).
ack
>
> But I see Guenther was against some parts of this so please don't take my
> style related comments as overruling his objections.
yes v2 will come once i know what i should implement
>
>
>>>> diff --git a/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
>>>> b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
>>>> new file mode 100644
>>>> index 0000000000000..292b739a161e7
>>>> --- /dev/null
>>>> +++ b/drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
>>>> @@ -0,0 +1,58 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>> +/*
>>>> + * Copyright (C) 2024-2025 Werner Sembach wse@tuxedocomputers.com
>>>> + */
>>>> +
>>>> +#include <linux/acpi.h>
> Btw just noticed, #include at least for kcalloc/kfree is missing.
ack
>
>>>> +
>>>> +#include "acpi_tuxi_init.h"
>>>> +
>>> Remove empty line but see first what I note below.
>> kk
>>>> +#include "acpi_tuxi_util.h"
>>>> +
>>>> +static int __acpi_eval_intarray_in_int_out(acpi_handle handle,
>>>> +					   acpi_string pathname,
>>>> +					   unsigned long long *params,
>>>> +					   u32 pcount,
>>>> +					   unsigned long long *retval)
>>> There's only single caller of this function, so I question the need for
>>> using an utility function.
>> It's in preparation for if the TUXI device get another subdevice besides TFAN.
>>
>> Currently nothing is planed but i though this doesn't hurt.
>>
>>>> +{
>>>> +	struct acpi_object_list arguments;
>>>> +	unsigned long long data;
>>>> +	acpi_status status;
>>>> +
>>>> +	if (pcount > 0) {
>>>> +		pr_debug("Params:\n");
>>>> +
>>>> +		arguments.count = pcount;
>>>> +		arguments.pointer = kcalloc(pcount,
>>>> sizeof(*arguments.pointer),
>>>> +					    GFP_KERNEL);
>>>> +		for (int i = 0; i < pcount; ++i) {
>>> unsigned int
>> kk
>>>> +			pr_debug("%llu\n", params[i]);
>>>> +
>>>> +			arguments.pointer[i].type = ACPI_TYPE_INTEGER;
>>>> +			arguments.pointer[i].integer.value = params[i];
>>>> +		}
>>>> +		status = acpi_evaluate_integer(handle, pathname, &arguments,
>>>> +					       &data);
>>>> +		kfree(arguments.pointer);
>>> You can use cleanup.h to handle freeing.
>> will look into it
>>
>>>> +	} else {
>>>> +		status = acpi_evaluate_integer(handle, pathname, NULL, &data);
>>> This call should be on the main level. You can use ?: operator for the
>>> only parameter you're changing for it between the currently diverging
>>> code paths.
>> then the kcalloc call happens every time even if it is not required.
> No it won't, you'd allocate only if pcount > 0 (in a similar block as
> now):
>
> #include <linux/cleanup.h>
> #include <linux/slab.h>
> ...
>
> 	union acpi_object __free(kfree) *obj = NULL;
>
> 	if (pcount > 0)
> 		obj = kcalloc(...);
>
> 		arguments.count = ...;
> 		arguments.pointer = obj;
> 		...
> 	}
>
> 	status = acpi_evaluate_integer(handle, pathname,
> 				       pcount ? arguments : NULL, &data);
> 	if (ACPI_FAILURE(status))
> 		...
>
> __free() will handle kfree(obj) for you, you don't call kfree() manually.
>
>> also i don't know if ?-operator in a function call is good to read.
> It is much better than duplicating almost the same call, by using ?: it
> is obvious that only single parameter is being altered, whereas on split
> calls, the code reader has to do the compare.
ok
>
>
>>>> + * Arg0: Fan index
>>>> + * Returns: Speed sensor value in revolutions per minute
>>>> + */
>>>> +#define TUXI_TFAN_METHOD_GET_FAN_RPM		"GRPM"
>>>> +
>>>> +int tuxi_tfan_method(struct acpi_device *device, acpi_string method,
>>>> +		     unsigned long long *params, u32 pcount,
>>>> +		     unsigned long long *retval);
>>>> +
>>>> +#endif // __PLATFORM_X86_TUXEDO_NBXX_ACPI_TUXI_UTIL_H__
>>>>
>>> What is the reason for splitting this into so many files? Are there going
>>> to be other users of the code that is split into separate files? For the
>>> init/deinit code, surely not.
>>>
>>> It will be considerably harder to track call chains, etc. when the
>>> function cannot be found in the same file so you better provide a really
>>> good reason for going so extreme with the split.
>> Same as above: in preparation for the future if there is another TUXI
>> subdevice other then TFAN.
>>
>> Also to section of the hwmon logic as I might want to reuse it for other odms
>> in the future albeit it would then need to get passed the acpi-write function
>> in a dynamic way.
>>
>> And imho it not harder to follow over different files, there is a lot of
>> external function references anyway, so having something setup to
>> automatically jump to a function definition in a different file is already
>> required to quickly parse the code.
> For library type APIs, one usually doesn't read those functions. I'm
> talking about functions within the driver. For well-structured and
> well-named code, jumping all over the place not a requirement at all
> because the interfaces that cross file boundaries are well architected and
> rest is self-contained and self-explanatory. I see you started to defend
> the suboptimal split with everybody does that argument ;-).

It is sectioned off in a logical way.

The _util file contains a helper function that you don't need to know the 
implementation details for the logic of the driver itself and the _init file 
just has boilerplate code except the singular acpi_get_handle line.

>
> Your references to "future" sound quite vague, if there are no immediate
> plans for such drivers to exist, I'd just do such rearranging of code when
> the supposed other drivers actually happens (which often is never).
>

