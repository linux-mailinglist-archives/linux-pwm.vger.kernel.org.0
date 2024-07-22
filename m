Return-Path: <linux-pwm+bounces-2887-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 153C7938818
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 06:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316E11C20D7A
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 04:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEB017543;
	Mon, 22 Jul 2024 04:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RZD4xAoD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0F32FB2
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jul 2024 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721623003; cv=none; b=M44fahC36B1hlebStSjSX7npIJDPi7OVDEczVNezXgirpHEWBbTyQ8Tg2X+yFTKH6bGjVPQU3c+5CCGpvdEIaoCTxOCtnws7qDGxLwN3vzoK0Kn/xwJ+AB/4bWcaTDLJLZKpvVKM3teoNXLvNmfDdOo4jzyuKcXojLlhKycc9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721623003; c=relaxed/simple;
	bh=kawPWjJUSiyPbHtiTN23EdJFTn7YCLOnWW85D2j4qlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRDD8y4J5pBVyj5e6BLmGIV/Hz8QR+PGls1m9umSiIJkcEaFa8pY9dfehniLZLRmnRJwRZtuT5cLLyEzu46tCGEzPFEX8PP+FkotrQIrKTFIjvuFArCPiZWB7jLJ/9t86R3e3sXE4KsS7HTu3eH6UKQZtaufGfn80ZA83U6Dm+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=RZD4xAoD; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 31CCC2C04C9;
	Mon, 22 Jul 2024 16:36:38 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1721622998;
	bh=kawPWjJUSiyPbHtiTN23EdJFTn7YCLOnWW85D2j4qlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RZD4xAoDjCh72n2OBfaULCMovvEFyVfFcZKYqt76E8CyjJZ8GlQLb1rj8Ak9nIz3H
	 tTPlYdkVGlQV65SrsAJ170qO07FOc1eufuDzHzgNGbVuGS+cf4qd+L1EMOYD82dSGY
	 p7T+lWAd60qv6gkrSJv9D2X0vLFOuhhnPiVMTa8fcMctUBg6YDflKrt/2tAldNlX9V
	 SzSJaydzKGH7N0oBgVVdtAu/lhDhTi5b5G8Yh3PB/S7jUzncpKtbA4kZI5xu8MC/ql
	 z5OUqchk6Az21MGZWALvoSJsIbrw5zf4TQUMHQhMmeRk5LiXaxjecjmWeYhZnXHigG
	 n20Q2E//08V1Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B669de1d60000>; Mon, 22 Jul 2024 16:36:38 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 1F88C13ED2A;
	Mon, 22 Jul 2024 16:36:38 +1200 (NZST)
Message-ID: <e28e9ff2-a48e-4cf2-b763-6bf3b5d9a959@alliedtelesis.co.nz>
Date: Mon, 22 Jul 2024 16:36:38 +1200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v6 3/3] hwmon: (adt7475) Add support for configuring
 initial PWM state
To: Guenter Roeck <linux@roeck-us.net>, jdelvare@suse.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
 <20240722005825.1800403-4-chris.packham@alliedtelesis.co.nz>
 <15f4c51c-3f7d-4e93-9c3a-71ac1d626463@roeck-us.net>
 <c261c74f-6829-4888-9836-6f27ba87dc25@alliedtelesis.co.nz>
 <ed179848-2c8c-41ef-acca-a53d958a30b6@roeck-us.net>
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <ed179848-2c8c-41ef-acca-a53d958a30b6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=669de1d6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=hpbk-zw_1wb9Up7sGCwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 22/07/24 16:27, Guenter Roeck wrote:
> On 7/21/24 21:09, Chris Packham wrote:
>>
>> On 22/07/24 15:53, Guenter Roeck wrote:
>>> On 7/21/24 17:58, Chris Packham wrote:
>>>> By default the PWM duty cycle in hardware is 100%. On some systems=20
>>>> this
>>>> can cause unwanted fan noise. Add the ability to specify the fan
>>>> connections and initial state of the PWMs via device properties.
>>>>
>>>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>>>> ---
>>>>
>>>> Notes:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v6:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use do_div() instead of plain /
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use a helper function to avoid repetition=
 between the of and=20
>>>> non-of
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 code paths.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v5:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Deal with PWM frequency and duty cycle be=
ing specified in=20
>>>> nanoseconds
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v4:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Support DT and ACPI fwnodes
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Put PWM into manual mode
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v3:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use the pwm provider/consumer bindings
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v2:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use correct device property string for fr=
equency
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Allow -EINVAL and only warn on error
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use a frequency of 0 to indicate that the=
 hardware should be=20
>>>> left as-is
>>>>
>>>> =C2=A0 drivers/hwmon/adt7475.c | 130=20
>>>> ++++++++++++++++++++++++++++++++++++++++
>>>> =C2=A0 1 file changed, 130 insertions(+)
>>>>
>>>> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
>>>> index 4224ffb30483..fc5605d34f36 100644
>>>> --- a/drivers/hwmon/adt7475.c
>>>> +++ b/drivers/hwmon/adt7475.c
>>>> @@ -21,6 +21,8 @@
>>>> =C2=A0 #include <linux/of.h>
>>>> =C2=A0 #include <linux/util_macros.h>
>>>> =C2=A0 +#include <dt-bindings/pwm/pwm.h>
>>>> +
>>>> =C2=A0 /* Indexes for the sysfs hooks */
>>>> =C2=A0 =C2=A0 #define INPUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 0
>>>> @@ -1662,6 +1664,130 @@ static int adt7475_set_pwm_polarity(struct=20
>>>> i2c_client *client)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0 }
>>>> =C2=A0 +struct adt7475_pwm_config {
>>>> +=C2=A0=C2=A0=C2=A0 int index;
>>>> +=C2=A0=C2=A0=C2=A0 int freq;
>>>> +=C2=A0=C2=A0=C2=A0 int flags;
>>>> +=C2=A0=C2=A0=C2=A0 int duty;
>>>> +};
>>>> +
>>>> +static int _adt7475_pwm_properties_parse_args(u32 args[4], struct=20
>>>> adt7475_pwm_config *cfg)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long freq_hz;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long duty;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (args[1] =3D=3D 0)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 freq_hz =3D 1000000000UL;
>>>> +=C2=A0=C2=A0=C2=A0 do_div(freq_hz, args[1]);
>>>> +=C2=A0=C2=A0=C2=A0 duty =3D 255 * args[3];
>>>> +=C2=A0=C2=A0=C2=A0 do_div(duty, args[1]);
>>>> +
>>>
>>> Gues I am a bit at loss here, just as 0-day. Why use do_div ? It is=20
>>> only needed
>>> for 64-bit divide operations.
>>
>> Mainly because of Uwe's comment on v5. I think I've avoided the=20
>> original u64 issue now that I'm converting=20
>> fwnode_reference_args::args to a u32 array. I can probably get away=20
>> with plain division, although 255 * args[3] / args[1] might overflow=20
>> in theory but shouldn't in practice.
>>
>> I'll let the earth turn and send out a v7 that uses plain division=20
>> unless someone has a strong opinion that I should sprinkle some more=20
>> u64s around.
>>
>
> You lost me, sorry. Neither duty nor freq_hz are u64. What u64 variable=
s
> are you talking about ? Using so_div doesn't make those variables u64.

One way of fixing the 0-day complaint (I think) is to declare freq_hz=20
and duty as u64 which would avoid all the theoretical overflow issues.

But plain division is probably easier to understand for everyone so I'll=20
send out something like this in v7

 =C2=A0 (unsigned?) int freq_hz;
 =C2=A0 (unsigned?) int duty;
 =C2=A0 ...
 =C2=A0 freq_hz =3D 1000000000UL / args[1];
 =C2=A0 duty =3D 255 * args[3] / args[1];
 =C2=A0 ...

>
> Guenter
>
>>>
>>> Thanks,
>>> Guenter
>>>
>

