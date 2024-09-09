Return-Path: <linux-pwm+bounces-3164-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71399971389
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 11:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2867228402B
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 09:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EDD1B3B22;
	Mon,  9 Sep 2024 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="T+p/AU9h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2036.outbound.protection.outlook.com [40.92.103.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC761B373E;
	Mon,  9 Sep 2024 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874088; cv=fail; b=IDmybvtHWEiNVhOyR9id87NVHxkmYj2xisKj6FSVkCUA/3fs5fhqjXmr5u+kmh+Y0NkOk9IvU9J+t9DF1mayp44tTkH7XYvV8Daf5BysJMtw3W6kIizF0fvYtgVY6Msfc96jkqYAw3wvYd2tqoRq80iqqh4azzlYT+oLKWz37oQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874088; c=relaxed/simple;
	bh=0W96JVl57d5RwvgDbvo/3/OTe1EL1ooaFat0+clQN4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jc3KzOIBy80iY04EvrQ5B+um83F+yQeFUnfi4988gshwp+irl3k7cjvBkAMAbVtWM/TgI6RumtogMKMeanXomz6KuJFKGfQFGWiwWD6vNRkzPbh8oB9K/J1GsmduzuXQ7FGYNY6Zu5k52/3MpwOrDKxVsZG1LfrUoX3ohHS74MA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=T+p/AU9h; arc=fail smtp.client-ip=40.92.103.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQBK/GI1SP0gymr+ikte6qDucYtULt6iZwBr9+wipG2nw03TBxU0bpk9AhKwoU4md7xx6TiVNTZJpM3SmvuJ/DKrNHDaxJMQ2CKW8dzPLDZdi7M2L1DdW3tXGC9vpLc+ClXpneHZqhVW7xEBKdt4mJwfaYgwaoWtuA7pCCJUtN7cfNBDdL3cYIywQNdEoGshhewk6aSJsziLgVdnPuIzIZfAW3RM3Ol5tvbIBJ0V3PExIv/WQZvYKTG51QDsum0n+sLVrk6OuuzBAkVnmI41znh2sjaCuKa7YvH4hEFgpOTjRmFDYLQlyA0oaYj3J9Y4OpGvEiOURweZB4k7OLoYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbuYg0oj4AOdRnCuV+Vsh0li1qyY6E6vAWQO6+qQeF0=;
 b=S9tQ43KK3135frAFKTr18xadqHnrFSPqcfQFVf/E88l3JfWwmZwwGgD+HLWQm10MnCjCpbYOeKspcEsJHaYJjh8v+4X5suK4LgLGW+pyXDX0nOPdspHw5yRUvWIRDKb94ICvZx4PcQYnXFzPphaMF5lICUjyhx6fYYIw7agQ4hdAmoxj8Ri2YE8KH88NZG/UnfjxHgle3NbCfHjMosKXYRnwVrWGEbo/2D1eJHjVLYvrG8NOBBcmdYlMrKjCyiCt2sSbthuMBzlGLSZXDe8y/Hhu3F3KX40QWM8IkIqlNr/QOzJcP5THle0c7Z7pmyvx2+G29owLjzjEP2sTjCf2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbuYg0oj4AOdRnCuV+Vsh0li1qyY6E6vAWQO6+qQeF0=;
 b=T+p/AU9hiuNqBD+QwU5XIUdHdVWzjp/W7z9uKkgZo8fS1tSAX/5QG9JZHd+HD4vUW+QmYU5BrDoCIT8a5Rp8WUx8IzAp9A9NYoXS+Ww5+z63EIciP2Cv8OWD7ripArKsXlWn0EC4zfF8Owxl+Qij/rTAkkHydNH/3t+M2+NLTD/Owo7X2oohtx1GMmdBlazP0LUakJjBt1PtzRSw7guCZuiuHdAlw6kkWQg3TxFdJW/zl4bSedkq6YNHA4KSd9Xv+tyUi+lfhkAB//yOmygshXepXUXovi1ZHR1nDtIEgJ0WDDfhnJMJJGRe7+j8Qn7cFxWk1JBLMKE5xu6S+p9Eew==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB0476.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:121::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 09:27:59 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 09:27:59 +0000
Message-ID:
 <MA0P287MB28226A4E7548F8AC57B966C8FE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 9 Sep 2024 17:27:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
References: <cover.1725536870.git.unicorn_wang@outlook.com>
 <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
 <id7arbp2z5ui3krscder6vrv5g7v3rvjxpde2eyg7pn5lxjvha@fdishk36pt35>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <id7arbp2z5ui3krscder6vrv5g7v3rvjxpde2eyg7pn5lxjvha@fdishk36pt35>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [wHthis/48JzHlJmzm0eRbO+QAa313E3g]
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <f2d7f9a9-f333-479f-b766-5178ff5e0702@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB0476:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f563e06-ff02-4feb-8f2b-08dcd0b1b1d5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|5072599009|8060799006|15080799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	OD3re4mAfHjfFSTbAEVUrCARHTIgDf3m0HGEupXm1gwnDKdwnPsX0zTlZITBA6/ipmPyz3p7esVwgjAsshsBWfNoUyeB7LWnVm2R9AgarwP+8sZ9bBF/dESS7nu/zkq7bP9bvOh16OveuSnUKNo9Y6fzIPKkOGgi4Zu08Ia9mSO7twvFp4Fhz24IK9Egdkg3fDHShTh61SQkNTXWPJSYx/GkEDH3KOSNphe0s8y5TRlyhQ5h1yUB7Sae6ANZRLYWSSbOKbjnhzP08/xLm6FuRVcwmTJnRrEVeYSJxyBh36suZMpyIosumN4y3Z/04HEHNp3ItDkSkOIWnknavmkJuo1f4vWjvJVQQC3UPqu3dA+PKR9ngLUuc42C/OizTyPqhdDyvOjgcmTffOY75z3XivQRQ5MRU4pa5r3C5XEIkJpki1SHaw+NfrGjjOzJ3qlUm/rPB2oPINu41JBv4NmUTbpvXzT9AZGqku9vtuWY5KU42youcd5AqGS6DK5H9PwA+B67tV76DL1H+oLAaCViWAsLR4oPkKQA8NRy/FoBWFjuZeGUjAeuqnIQcAVVyIgbXTcc3yTUCxmHaLH6qvh6gMUvReGmVbCXCJnOwbGy4Pqi0GLeI/NFktgu/9BoGTJnhq2ZnPLGenrIeBbNoJkgAkcbOV6SZC5vZHmlJNyrtRXqP7jXxZ+yxTDPz5CN5dWWSuJ/V/60IKCTDQ9CM9cnxt9mYK4bikSmcRuPLRK3CkE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnhqQ1FnTk9WeU1qRU41N3A5Zmc1R2pZaWpHYnliOGt6Vkt2TFFHeFAxZ3Ew?=
 =?utf-8?B?L3poUEt4S0ZLb0lKaHlLaldneXNqQmRzRFY2NFQ1SkpvdTNxR3g5azFyTEZl?=
 =?utf-8?B?T2RZQTErN0haOFdMRWcvZ2ZFZVpGTUxTODhYSEx6cEIxVmpud1R5K2Q2TlJZ?=
 =?utf-8?B?alVnMHRoZ3d0Ri9jems2ZU4wTjhabHEyWUFmRjZNWXhoWXp4akZSdHJQRUtG?=
 =?utf-8?B?TGszRDFnU0dKV2ttRFI0QlN5OE54TUgrVGRtQmY0MFBWenRvbGcxL2tLdThV?=
 =?utf-8?B?NDhsZi8xejNOTFg2N0EyT2dnZFlZMWNneXBDaWw2QjNudEF5NS9zS09xc0VH?=
 =?utf-8?B?emFIakVBWXFsMTVWWUd1a2FYczM3aFZ1WjZkYms4cVR2d2NLc3QzL1VLSHBG?=
 =?utf-8?B?RU1hWnlWcDduUk5YN3MzdllqUlVLMGxDbDhSUnNBWUozYXdVK3NLWFVOdmU5?=
 =?utf-8?B?QTJQdDE0NEk3cTlXcE5RSDNlM3hYK3JwNEd2cjhEb3Y5Z1oxaERVYnpQbmMx?=
 =?utf-8?B?dWd0Z1ZudHJ1RzBTTTRmSEc4Q2duam1SdHBoNEhSN3dRVnJRY0VQYTZzd3hN?=
 =?utf-8?B?T0VUNlU1RExKLzJLbCt3eXZMWWxkYWpnSXhLSXVmK0h5N0RzSjU4K3JkZ29y?=
 =?utf-8?B?SWZRNWVIcndPTDZxSElZN256VXNNOUI4MkQxVnBYR0ZJenc2d1NvM0pSMWl5?=
 =?utf-8?B?MHNPaC9uVmJYK1djcW5xWU03YnpXbnh2NHZKNDRLL05ZS05KN3FSSlZjUnhL?=
 =?utf-8?B?cWVnWlIyZ1VydlFsa0xjcHdyQkNTdlQzSk5TRFhTWkVwZXJrTkF1VU1XdXFY?=
 =?utf-8?B?bWY0a0RUQ3VmMGxySzZLUDM2WU5CcEZKZDZNOUFmRW9SeG5raDhjR0JSa28r?=
 =?utf-8?B?dlZ6Q21KUnpMMlgySjAvbTVxbUViN29vWkMrWEUra1BrcTJubUpmOVpkeDF6?=
 =?utf-8?B?bmZjSUhLZEYySGF5YXQxMTJ6UUg2SmMyZkZRaGpTSmRNUVhGdGYzMVVEL2Mz?=
 =?utf-8?B?elpOdEowSUY2VFFyMmlJODljSmc5a0U4dThhK05yb2pQeFpENm1Rd1M1Qmpi?=
 =?utf-8?B?amVnVElaWWJ0RHZVaUdZRm90d3BKeHptbUVBZU5JL2J4ZFhnTHA3V1NaTmJ0?=
 =?utf-8?B?TFdaNStUSXFLbXJ4NEdoQnF6Nzh5WTdSK3NjWGlObHQ1eTFsbkw5ZHU1RUpE?=
 =?utf-8?B?bkp2MzB0WVBiZFZkM1B1Vit2R0hMOGl0WUZxSEJ5b1psbEUzWU1JeHYzWlZh?=
 =?utf-8?B?WmlRRXN4RHRvTFR5RGFMN1FuUHFESjhTMG1QaTFvdDNYamRTb0E3VnJ1b1Nl?=
 =?utf-8?B?alNudmxHaU9SQUxMNk9vQlYyTHdaSnlBRTlXWHE3cE9GeEMyU0ZBK0ZvVFNY?=
 =?utf-8?B?aThZV2YzSkYrVU9CcURxM2VJN3hoMkpNL2VNSzRXd2E1Z3pIZktab3IwaUtW?=
 =?utf-8?B?RGhWcnk0T3kyVTZDVTBoam9DVlVwZ0E4bXNQdHZWS2VCbVp1aDhJdDdjNHRx?=
 =?utf-8?B?Nm02aXZ0YW40TlVNeUxLWG9nVTFZOTRDNEx6cTY4SG9oYzNwZjNsUmVjTzFq?=
 =?utf-8?B?MnI2elpEa1FGVmZhWFV1b2hCbzN3dDExdW9EQkEwNDNsb2Jrbkl5VWs4T3Fh?=
 =?utf-8?B?WE9wTVF4UXZxemRYd0ZWVXZteW5IUjZXaUowRExEdHI0VFgvM3l6T3ZJVHd3?=
 =?utf-8?Q?VL+CdQ1AM7sAW4Bn1cDU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f563e06-ff02-4feb-8f2b-08dcd0b1b1d5
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:27:59.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0476


On 2024/9/6 0:03, Uwe Kleine-König wrote:
> Hello,
>
> On Thu, Sep 05, 2024 at 08:10:42PM +0800, Chen Wang wrote:
[......]
>> +static void pwm_sg2042_config(void __iomem *base, unsigned int channo, u32 period, u32 hlperiod)
>> +{
>> +	writel(period, base + REG_GROUP * channo + REG_PERIOD);
>> +	writel(hlperiod, base + REG_GROUP * channo + REG_HLPERIOD);
>> +}
> I suggest to use the following instead:
>
> 	#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
> 	#define SG2042_PERIOD(chan) ((chan) * 8 + 4)
>
> 	...
>
> 	static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32 period, u32 hlperiod)
> 	{
> 		writel(period, base + SG2042_PERIOD(chan));
> 		writel(hlperiod, base + SG2042_HLPERIOD(chan));
> 	}
>
> The (subjective?) advantage is that the definition of SG2042_HLPERIOD
> contains information about all channel's HLPERIOD register and the usage
> in pwm_sg2042_config is obviously(?) right.
>
> (Another advantage is that the register names have a prefix unique to
> the driver, so there is no danger of mixing it up with some other
> hardware's driver that might also have a register named "PERIOD".)
Agree, will fix this in next version.
> Is this racy? i.e. can it happen that between the two writel the output
> is defined by the new period and old duty_cycle?
>
> How does the hardware behave on reconfiguration? Does it complete the
> currently running period? Please document that in a comment at the start
> of the driver like many other drivers do. (See
>
> 	sed -rn '/Limitations:/,/\*\/?$/p' drivers/pwm/*.c
>
> )

When hlperiod or period is modified, PWM will start to output waveforms 
with the new configuration after completing the running period. Will 
document in a comment as other drivers do.

>> +static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			    const struct pwm_state *state)
>> +{
>> +	struct sg2042_pwm_chip *sg2042_pwm = to_sg2042_pwm_chip(chip);
>> +	u32 hlperiod;
>> +	u32 period;
>> +	u64 f_clk;
>> +	u64 p;
>> +
>> +	if (!state->enabled) {
>> +		pwm_sg2042_config(sg2042_pwm->base, pwm->hwpwm, 0, 0);
>> +		return 0;
>> +	}
> Here you're missing (I guess):
>
> 	if (state->polarity == PWM_POLARITY_INVERSED)
> 		return -EINVAL;
Yes, it is required, will add this in next version, thanks.
>> +	/*
>> +	 * Period of High level (duty_cycle) = HLPERIOD x Period_clk
>> +	 * Period of One Cycle (period) = PERIOD x Period_clk
>> +	 */
>> +	f_clk = clk_get_rate(sg2042_pwm->base_clk);
>> +
>> +	p = f_clk * state->period;
> This might overflow.
>
>> +	do_div(p, NSEC_PER_SEC);
>> +	period = (u32)p;
> This gets very wrong if p happens to be bigger than U32_MAX.
>
> If you ensure f_clk <= NSEC_PER_SEC in .probe() (in combination with a
> call to clk_rate_exclusive_get()), you can do:
>
> 	period_cycles = min(mul_u64_u64_div_u64(f_clk, state->period, NSEC_PER_SEC), U32_MAX);
> 	duty_cycles = min(mul_u64_u64_div_u64(f_clk, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
>
> This would also allow to store the clkrate in the driver private struct
> and drop the pointer to the clk from there.
f_clk should be 100M and <=NSEC_PER_SEC, will improve the code as your 
suggestion, thanks.
>> +	p = f_clk * state->duty_cycle;
>> +	do_div(p, NSEC_PER_SEC);
>> +	hlperiod = (u32)p;
>> +
>> +	dev_dbg(pwmchip_parent(chip), "chan[%d]: period=%u, hlperiod=%u\n",
>> +		pwm->hwpwm, period, hlperiod);
> pwm->hwpwm is an unsigned int, so use %u for it.
Ok, will fix.
>> +	pwm_sg2042_config(sg2042_pwm->base, pwm->hwpwm, period, hlperiod);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops pwm_sg2042_ops = {
>> +	.apply		= pwm_sg2042_apply,
> No .get_state() possible? Please use a single space before =.
Will add .get_state() and improve the format.
>> +};
>> +
>> +static const struct of_device_id sg2042_pwm_match[] = {
>> +	{ .compatible = "sophgo,sg2042-pwm" },
>> +	{ },
> Please drop the , after the sentinel entry.
OK
>> +};
>> +MODULE_DEVICE_TABLE(of, sg2042_pwm_match);
>> +
>> +static int pwm_sg2042_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct sg2042_pwm_chip *sg2042_pwm;
>> +	struct pwm_chip *chip;
>> +	int ret;
>> +
>> +	chip = devm_pwmchip_alloc(&pdev->dev, SG2042_PWM_CHANNELNUM, sizeof(*sg2042_pwm));
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +	sg2042_pwm = to_sg2042_pwm_chip(chip);
>> +
>> +	chip->ops = &pwm_sg2042_ops;
>> +
>> +	sg2042_pwm->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(sg2042_pwm->base))
>> +		return PTR_ERR(sg2042_pwm->base);
>> +
>> +	sg2042_pwm->base_clk = devm_clk_get_enabled(&pdev->dev, "apb");
>> +	if (IS_ERR(sg2042_pwm->base_clk))
>> +		return dev_err_probe(dev, PTR_ERR(sg2042_pwm->base_clk),
>> +				     "failed to get base clk\n");
>> +
>> +	ret = devm_pwmchip_add(&pdev->dev, chip);
>> +	if (ret < 0)
>> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
>> +
>> +	platform_set_drvdata(pdev, chip);
> This is unused and should/can be dropped.
OK, will drop this, thanks for point it out. I should have cleaned it up.
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver pwm_sg2042_driver = {
>> +	.driver	= {
>> +		.name	= "sg2042-pwm",
>> +		.of_match_table = of_match_ptr(sg2042_pwm_match),
>> +	},
>> +	.probe = pwm_sg2042_probe,
>> +};
>> +module_platform_driver(pwm_sg2042_driver);
> Please use a single space before =.
Ok, will improve the format.
>> +MODULE_AUTHOR("Chen Wang");
>> +MODULE_DESCRIPTION("Sophgo SG2042 PWM driver");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.34.1
>>
> Best regards
> Uwe

