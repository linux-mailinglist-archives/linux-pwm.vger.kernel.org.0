Return-Path: <linux-pwm+bounces-2885-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74A9387F6
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 06:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38541F21A0D
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD72CA9;
	Mon, 22 Jul 2024 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wO30gIeu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE9C8F54
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jul 2024 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721621392; cv=none; b=dzZALHVzHk5ak2mQcruDT3tQJB5aKroIeilRBZqBKa8Px6CXfpAnq5QX7QHmeC7Euf7j9SePm+dSdQX+70W+E6JioNoY6wuPFVqBn/Gwe2G7aKzRMWl22X9Wg/YEePRnOnzDqBIr7YAWDfGVpjCD+K6AwxI5IZ3lWfMjl4qvTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721621392; c=relaxed/simple;
	bh=tvxoEuEatyM2W7KamTa8qc2roxde9Ug4DJkb5OYOHtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PZT4b9rdZCbWQy7IuaLUoF1PHRevVJM4cZ/L4KvzsGAedw0VM/lKV07ZOlYXRZLUdA1ZgIGwi+p0vuL0Oz5I8YrUQ66+X7Q0VTa4s7L9k7IiZdarBBg2NIvV1RoEB26eyzQ3Tc/B+UiOl2doITtFlRb6AXNMMOX4oVpK2BDIRlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=wO30gIeu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EE7B22C04C9;
	Mon, 22 Jul 2024 16:09:46 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1721621386;
	bh=tvxoEuEatyM2W7KamTa8qc2roxde9Ug4DJkb5OYOHtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wO30gIeuj/6a5LaDdtvO3D0kfTBrVSAHI4QaEfKUEKs22u/rbKy/S0jrBsJFbutRl
	 gIGuFKuqkhOi353+lm4odTHzqHMNmPrf+ertit3B+s0zT45eK89vXQdL2AlAfEsCND
	 CosDNoMFCTT5miv/Av1yzbW3AYanprmjMWlkO5xQyEKOpPQ8pVfJYjSfTEJw/tkBS6
	 1q44stN4NoyNNpk4CIlreOUoZ0lyEF0a+UW4ojt+pWydFYixjH1GSzhBHjUEhKhpAx
	 zEHgAf//Dge64/zUPqXqK3qpdG72HLdwaI5/R3v3iJ+CoC0KZlPjpt9rtFtDW0wTO1
	 h7jfOp/oieriw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B669ddb8a0000>; Mon, 22 Jul 2024 16:09:46 +1200
Received: from [10.33.22.30] (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id C8B3513ED2A;
	Mon, 22 Jul 2024 16:09:46 +1200 (NZST)
Message-ID: <c261c74f-6829-4888-9836-6f27ba87dc25@alliedtelesis.co.nz>
Date: Mon, 22 Jul 2024 16:09:46 +1200
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
Content-Language: en-US
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
In-Reply-To: <15f4c51c-3f7d-4e93-9c3a-71ac1d626463@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=669ddb8a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=IkcTkHD0fZMA:10 a=4kmOji7k6h8A:10 a=Kv0HwWCj8ggcw1s04G8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat


On 22/07/24 15:53, Guenter Roeck wrote:
> On 7/21/24 17:58, Chris Packham wrote:
>> By default the PWM duty cycle in hardware is 100%. On some systems thi=
s
>> can cause unwanted fan noise. Add the ability to specify the fan
>> connections and initial state of the PWMs via device properties.
>>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>
>> Notes:
>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v6:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use do_div() instead of plain /
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use a helper function to avoid repetition b=
etween the of and=20
>> non-of
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 code paths.
>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v5:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Deal with PWM frequency and duty cycle bein=
g specified in=20
>> nanoseconds
>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v4:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Support DT and ACPI fwnodes
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Put PWM into manual mode
>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v3:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use the pwm provider/consumer bindings
>> =C2=A0=C2=A0=C2=A0=C2=A0 Changes in v2:
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use correct device property string for freq=
uency
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Allow -EINVAL and only warn on error
>> =C2=A0=C2=A0=C2=A0=C2=A0 - Use a frequency of 0 to indicate that the h=
ardware should be=20
>> left as-is
>>
>> =C2=A0 drivers/hwmon/adt7475.c | 130 +++++++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 1 file changed, 130 insertions(+)
>>
>> diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
>> index 4224ffb30483..fc5605d34f36 100644
>> --- a/drivers/hwmon/adt7475.c
>> +++ b/drivers/hwmon/adt7475.c
>> @@ -21,6 +21,8 @@
>> =C2=A0 #include <linux/of.h>
>> =C2=A0 #include <linux/util_macros.h>
>> =C2=A0 +#include <dt-bindings/pwm/pwm.h>
>> +
>> =C2=A0 /* Indexes for the sysfs hooks */
>> =C2=A0 =C2=A0 #define INPUT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
0
>> @@ -1662,6 +1664,130 @@ static int adt7475_set_pwm_polarity(struct=20
>> i2c_client *client)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +struct adt7475_pwm_config {
>> +=C2=A0=C2=A0=C2=A0 int index;
>> +=C2=A0=C2=A0=C2=A0 int freq;
>> +=C2=A0=C2=A0=C2=A0 int flags;
>> +=C2=A0=C2=A0=C2=A0 int duty;
>> +};
>> +
>> +static int _adt7475_pwm_properties_parse_args(u32 args[4], struct=20
>> adt7475_pwm_config *cfg)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned long freq_hz;
>> +=C2=A0=C2=A0=C2=A0 unsigned long duty;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (args[1] =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 freq_hz =3D 1000000000UL;
>> +=C2=A0=C2=A0=C2=A0 do_div(freq_hz, args[1]);
>> +=C2=A0=C2=A0=C2=A0 duty =3D 255 * args[3];
>> +=C2=A0=C2=A0=C2=A0 do_div(duty, args[1]);
>> +
>
> Gues I am a bit at loss here, just as 0-day. Why use do_div ? It is=20
> only needed
> for 64-bit divide operations.

Mainly because of Uwe's comment on v5. I think I've avoided the original=20
u64 issue now that I'm converting fwnode_reference_args::args to a u32=20
array. I can probably get away with plain division, although 255 *=20
args[3] / args[1] might overflow in theory but shouldn't in practice.

I'll let the earth turn and send out a v7 that uses plain division=20
unless someone has a strong opinion that I should sprinkle some more=20
u64s around.

>
> Thanks,
> Guenter
>

