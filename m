Return-Path: <linux-pwm+bounces-4967-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A4A3F355
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 12:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08993B7C7B
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Feb 2025 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B0209F23;
	Fri, 21 Feb 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="btR5qn/J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207F209681;
	Fri, 21 Feb 2025 11:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138623; cv=none; b=Cmay3QM8yeaXRad378hWkK0LHqQC1MWcLcFXY1WarCqKJjL9lWHKlUQ1fB4BtTESZuXBPZ86PREQo+OpoFB+epE2miYgoP685MGCOwCYvv0oo0BAcVanLind6lDtiTOym7bKliGOaqgmPTht+IWDNaB6K8CsWPhbNvakCS55tH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138623; c=relaxed/simple;
	bh=Ax1HLOrCM4FuTAt8HYk3+RIVVxX7+VlgLIn7Jnlyv68=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m/MxzqzqKmSyamxvxoz45+1yi+WavmqwzUcRzX6kYgUjj3uqCigt/x7PK1HW5rtbBJ0qESjxZqxNlqQqGf3FrYoZ+ja5puc829l7SMI83IH9C3UUBUqI/iwJekLzbi3fDYzTGNYJngugPVvt7cQnMBWyUNS8B0gc0Ov/Id3+FLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=btR5qn/J; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e59d4d.dip0.t-ipconnect.de [217.229.157.77])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id EF6BC2FC0182;
	Fri, 21 Feb 2025 12:50:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1740138617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntN7Ken4o08cAX1i2z6UfMc3CME1b/XumOkdtvbq90M=;
	b=btR5qn/JQZ2iM9Z6Qbqzm/UmO/OMIde4ej5pERpuC3eETwAT8pHKMz6AUIKnWCToZlZAU+
	/X5twyqGS+nefMFbZx2YpTS3yzfB7Rtmjzup7pjS6YSnwLw+pZ6TEGzSM6OPzbRIVitOpm
	R9lA9Lc+l3h/gWNXJ5X+Ac/+G521zdY=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <cde97a29-bfe6-4dba-a059-b6df91814e6c@tuxedocomputers.com>
Date: Fri, 21 Feb 2025 12:50:16 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI
 TFAN via hwmon
From: Werner Sembach <wse@tuxedocomputers.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, ukleinek@kernel.org,
 jdelvare@suse.com, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20250205162109.222619-1-wse@tuxedocomputers.com>
 <20250205162109.222619-2-wse@tuxedocomputers.com>
 <767538f2-d79e-44e4-a671-4be56a3cfe44@roeck-us.net>
 <fce7929b-87e7-4c9a-8a54-ab678c5dc6b4@tuxedocomputers.com>
 <8f0a9bd6-52dd-442f-b0fd-73cf7028d9f0@roeck-us.net>
 <b32284b7-ddc8-4fb5-82f8-20199b0dec5a@tuxedocomputers.com>
Content-Language: en-US
In-Reply-To: <b32284b7-ddc8-4fb5-82f8-20199b0dec5a@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Am 06.02.25 um 23:55 schrieb Werner Sembach:
>
> Am 06.02.25 um 19:57 schrieb Guenter Roeck:
>> On Thu, Feb 06, 2025 at 10:28:01AM +0100, Werner Sembach wrote:
>>
>> [ ... ]
>>
>>>>> +        temp = retval * 100 - 272000;
>>>>> +
>>>>> +        for (j = 0; temp_levels[j].temp; ++j) {
>>>>> +            temp_low = j == 0 ? -272000 : temp_levels[j-1].temp;
>>>>> +            temp_high = temp_levels[j].temp;
>>>>> +            if (driver_data->temp_level[i] > j)
>>>>> +                temp_high -= 2000; // hysteresis
>>>>> +
>>>>> +            if (temp >= temp_low && temp < temp_high)
>>>>> +                driver_data->temp_level[i] = j;
>>>>> +        }
>>>>> +        if (temp >= temp_high)
>>>>> +            driver_data->temp_level[i] = j;
>>>>> +
>>>>> +        temp_level = driver_data->temp_level[i];
>>>>> +        min_speed = temp_level == 0 ?
>>>>> +            0 : temp_levels[temp_level-1].min_speed;
>>>>> +        curr_speed = driver_data->curr_speed[i];
>>>>> +        want_speed = driver_data->want_speed[i];
>>>>> +
>>>>> +        if (want_speed < min_speed) {
>>>>> +            if (curr_speed < min_speed)
>>>>> +                write_speed(dev, i, min_speed);
>>>>> +        } else if (curr_speed != want_speed)
>>>>> +            write_speed(dev, i, want_speed);
>>>>> +    }
>>>>> +
>>>>> +    schedule_delayed_work(&driver_data->work, TUXI_SAFEGUARD_PERIOD);
>>>>> +}
>>>> This is not expected functionality of a hardware monitoring driver.
>>>> Hardware monmitoring drivers should not replicate userspace or
>>>> thermal subsystem functionality.
>>>>
>>>> This would be unacceptable in drivers/hwmon/.
>>> Problem is: The thermal subsystem doesn't do this either as far as I can tell.
>>>
>>> See this: 
>>> https://lore.kernel.org/all/453e0df5-416b-476e-9629-c40534ecfb72@tuxedocomputers.com/
>>> and this: 
>>> https://lore.kernel.org/all/41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com/
>>> thread.
>>>
>>> The short version is: The Thermal subsystem always allows userspace to
>>> select the "userspace" governor which has no way for the kernel to enforce a
>>> minimum speed.
>>>
>> You can specify thermal parameters / limits using devicetree. Also, drivers
>> can always enforce value ranges.
>
> Sorry for my noob question: What do you mean with devicetree in x86 context?
>
> I only want to enforce a value range at a certain temperature, if the device 
> is cool, the fan can be turned off for example.
Gentle bump
>
>>
>>> As far as I can tell the Thermal subsystem would require a new governor for
>>> the behavior i want to archive and more importantly, a way to restrict which
>>> governors userspace can select.
>>>
>>> As to why I don't want grant userspace full control: The firmware is
>>> perfectly fine with accepting potentially mainboard frying settings (as
>>> mentioned in the cover letter) and the lowest level I can write code for is
>>> the kernel driver. So that's the location I need to prevent this.
>>>
>> It is ok for the kernel to accept and enforce _limits_ (such as lower and upper
>> ranges for temperatures) when they are written. That is not what the code here
>> does.
>
> It conditionally enforces a minimum fanspeed.
>
> So is the problem that hwmon drivers are only allowed to enforce unconditional 
> limits?
Here too.
>
>>
>>> Also hwmon is not purely a hardware monitoring, it also allows writing
>>> fanspeeds. Or did I miss something and this shouldn't actually be used?
>>>
>> If doesn't actively control fan speeds, though. It just tells the firmware what
>> the limits or target values are.
> What is the difference if it tells the firmware a target fanspeed, which can 
> be ignored by it, or a driver a target fanspeed, which can be ignored by it?

Here too.

Best regards,

Werner Sembach

>>
>>>> Personally I think this is way too complicated. It would make much more sense
>>>> to assume a reasonable maximum (say, 16) and use fixed size arrays to access
>>>> the data. The is_visible function can then simply return 0 for larger channel
>>>> values if the total number of fans is less than the ones configured in the
>>>> channel information.
>>> Didn't know it was possible to filter extra entries out completely with the
>>> is_visible function, thanks for the tip.
>>>> Also, as already mentioned, there is no range check of fan_count. This will
>>>> cause some oddities if the system ever claims to have 256+ fans.
>>> Will not happen, but i guess a singular additional if in the init doesn't
>>> hurt, i can add it.
>> You are making the assumption that the firmware always provides correct
>> values.
>>
>> I fully agree that repeated range checks for in-kernel API functions are
>> useless. However, values should still be checked when a value enters
>> the kernel, either via userspace or via hardware, even more so if that value
>> is used to determine, like here, the amount of memory allocated. Or, worse,
>> if the value is reported as 32-bit value and written into an 8-byte variable.
> ok
>>
>>>>> +    *hwmdev = devm_hwmon_device_register_with_info(&pdev->dev,
>>>>> +                               "tuxedo_nbxx_acpi_tuxi",
>>>>> +                               driver_data, &hwminfo,
>>>>> +                               NULL);
>>>>> +    if (PTR_ERR_OR_ZERO(*hwmdev))
>>>>> +        return PTR_ERR_OR_ZERO(*hwmdev);
>>>>> +
>>>> Why not just return hwmdev ?
>>> because if hwmon is NULL it is still an error, i have to look again at what
>>> actually is returned by PTR_ERR_OR_ZERO on zero.
>> That seems a bit philosophical. The caller would have to check for
>> PTR_ERR_OR_ZERO() instead of checking for < 0.
>>
>> On a side note, the code now returns 0 if devm_hwmon_device_register_with_info()
>> returned NULL.  devm_hwmon_device_register_with_info() never returns NULL,
>> so that doesn't make a difference in practice, but, still, this should
>> at least use PTR_ERR().
> ok
>>
>> Guenter

