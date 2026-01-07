Return-Path: <linux-pwm+bounces-7863-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB63CFD25E
	for <lists+linux-pwm@lfdr.de>; Wed, 07 Jan 2026 11:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF23C300EA23
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jan 2026 10:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE611E515;
	Wed,  7 Jan 2026 10:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eh1K3/SV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012067.outbound.protection.outlook.com [40.107.200.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A3D312813;
	Wed,  7 Jan 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767781429; cv=fail; b=cgrBTCmQ+29GcnMXLvTzEbfjF0HYa3yBbqTBImJk4w3Tk7/49bEqsERDWfM+Hv3hRQvWnS6kD1zc6UgPZ0ga+eLsDL6Pj2OwjPcJhx5pJOOy266eVoOP4+gSJBTMjelUUBu/HiY7MvPNLpYjUbW71e9eUW/Hpt9ZzEog70VsYuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767781429; c=relaxed/simple;
	bh=zCje2cZNX/l81C/PAe1BPbuxuiCjR1mYrZ1i3BK/NDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kKe7mHsHmKskzJCUnFPLHIaeL8z8UVJSbhsWI64CxaI/giITmbl/HDlVFQGQ4RikT7QZjbsZgS82nmVd4RP7w1gyXm5nHvdJ3e9fqUGc2wh6oeE2OoqEXA6nNAjhFxornkWA7C2XRYc9/iHIw1jMNzZekINhC0sZkwJexmTdASE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eh1K3/SV; arc=fail smtp.client-ip=40.107.200.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IofpCwuci5Gbl8k7iUYkb2sTfMba3rR6KGOU3dXhJjRpfG9clXdi2DibDd7CYvqDJ3OCX0WvJ21QWpOIHCsSH+AU3lYu/AsFWIoUBWsktUhdSvbdxaV5hpN5w4Kblc+Pn1jjw8kTnwiXeCq2uVFZXL7f9FM44B98UOSNP1RZEyHYQV2xVRESIYggAhMYmYdYqE9W0cpfG/hMOsl9usRJQ4jxf7qIMQcceEq7qzkkplAqQasUCGOPqdf7R7/MfWjwdlBLvgI5yVULIByfzFUKCNQAnLtS60D/nubrah79efIsFNzPl+yK4XJhdMHbDr14/XSiq4nyfN+YaBfWCH5wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQKndZDIMG1OrEBXuFEoQSChodRmeNhAyFCwmO+NTpw=;
 b=eQd+jEIUnftbHx+3PN7J1cmgWMqqRhZ9qyi9LGMTxtgrg4hyNsVvshqG5MnQwubl9bqALncYy3Shjufyq8pHeC96sFm726oAkbnrKf7iBipWjG1YDpQC4e7i5eSwFW5//Uux2k8foUkjMB1rRNMIHu6+yihxee4Tlx8zCMgtKETvsJq7/L7cD7jd3sp8XF6YUTc72Vn+kTXOKTZo0h/SC7zDHCYw+n7U0yRig6LrsqpIshCb70NZ/Yd3oSyX4MjT5KAJkuS0DuCCFyA3k+fXm+4ZzZH0S8ogtZwJqFY8sTzQqEEysG6yVNt2Ob+36jGjZDOlKWmKOj1BrJ0Uq2sK2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQKndZDIMG1OrEBXuFEoQSChodRmeNhAyFCwmO+NTpw=;
 b=eh1K3/SVM10gL+zpQ6K61uhl9qoNbSdmgOG26prcHrqU1UywcT7NSX1HE2iQWoQKkW0ZmHtsLDhMltaU7LVW2fJ+beL3BT3ftKbRe4qUaUCluipXESKVP0NjBMF2iUdcajLV3+EINiFQb1u4i78P4pxnpHVVN/HOc7VU4JkY/Wg=
Received: from BL1PR13CA0273.namprd13.prod.outlook.com (2603:10b6:208:2bc::8)
 by SJ5PPF1D755039F.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::790) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 10:23:41 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2bc:cafe::c5) by BL1PR13CA0273.outlook.office365.com
 (2603:10b6:208:2bc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 10:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 10:23:40 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 04:23:36 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 7 Jan
 2026 04:23:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 7 Jan 2026 04:23:36 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 607ANXEK547341;
	Wed, 7 Jan 2026 04:23:34 -0600
Message-ID: <60ef0a6d-f4f5-41ea-899c-e353ec9c1c8c@ti.com>
Date: Wed, 7 Jan 2026 15:53:33 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: <j-keerthy@ti.com>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <n-francis@ti.com>,
	"Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>, Gokul Praveen
	<g-praveen@ti.com>
References: <20260107055339.10999-1-g-praveen@ti.com>
 <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <kkddrxw37dx7w6f6csomopcwz5xk2o7ezddrisfisij6lq46hf@ije72we4xrek>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ5PPF1D755039F:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8e2c8c-d07b-411b-9ad4-08de4dd6d418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzdYQkUwenBKZUdIajF4MG51TzhiNGxTeXc0aDl4NWU4QW5HQ0s4RGc1Kysw?=
 =?utf-8?B?SmczUGZsMitqbUh3U2dTT2RHanRRNS80cy91QlZmeU9Md3VNRkFzWEdHR3gw?=
 =?utf-8?B?aXlJMHlWZjY4OWJraW5xUFo5Y3NPUVcrU3JTY3lURFVBNFc1MUQvUEVBNXVI?=
 =?utf-8?B?T1E3OGZLNllQd2trQnRKNmo0ejVMQzkyb0ZNcWt2L3RuUDVWeDhobDVDTlZM?=
 =?utf-8?B?Q3ZWMTc0V1UvTHpjSDAwSTkyL3lKSlNUWTJuODliQnFpZmQ3dndaRUxpeXh6?=
 =?utf-8?B?NER5cU1KZml2MnFIemcwSlVhU1lWMXJQZkNnU2ZQcTIydDcwTzZ6NlF4YW1l?=
 =?utf-8?B?dmw0MmlPZ05ENTFOMVhveVJBdXJVb1Y3Tk5wbDN6Q3hKbGV3SE1VaHQxUWNu?=
 =?utf-8?B?MkVzcjI2TVlCaklnMEgyclBEMThJWFpoWWdMYjdBQUZ1a2NrbXFlMjNFNmpR?=
 =?utf-8?B?ZlZ3OFVSNjRyV3NnWnpZN2QyaVcwMVRNMXl5OXFUZ0dNOWc5RitTUjZzQXV2?=
 =?utf-8?B?TUs2citOQjhPMENEdUQ1bitNc2tpQ1ZGVmx2elZsL2c5Y1p4dnlVTG1nTVM2?=
 =?utf-8?B?MjNBcWUzTE9sbDBKVXN2Z0grUnlHK0tHWHc0NEdZUjJ6Mkl5N2JIdTFCcUhE?=
 =?utf-8?B?V0N1TmRLbUgxSm1BcytCdEYrQUNBdlBnekZyVzRCMzFxNTBZRGJISFM4QzVL?=
 =?utf-8?B?UjcvZld3QzVERDNvSWt4Y0VhN2ljV1c3cEdaSU9xNEtRWDNLVVNINExnNUFE?=
 =?utf-8?B?cXJtTjhEMXUvU09adk5vbStOOGpNcGNxY2hRZWZCd1FIQnpJaTk5L3lWazhP?=
 =?utf-8?B?UWl5ejVaQUR6YnhiNG5JL0NvODd0cGNGams3cGhoUEEvTTJ1NjZyZk5MRmZG?=
 =?utf-8?B?MWZBNDYvRlRFZFc5UXhtT2Z0QmxncFl2cEM4c1VhNkQ0R2VCejNNSDdsM052?=
 =?utf-8?B?RytuSVNDV2ZrUE83VG1Sb2ZzK2F3djcvamxzeEJuZUFtTGtlQnVqTjUyR0xD?=
 =?utf-8?B?OG55STRNZW5sSFY0clMvWk5TbnJZaS9YYnhxNHBDcHlsUlJNTGZWdFJ1Y1Fr?=
 =?utf-8?B?VFhSd1lWTDNBK2s2T1EvcHJpRjNjUGZTSlpMeEFFbkZQbDltYk9YSU95U1gx?=
 =?utf-8?B?Q2R0VThZNkhwT3hUdU1PZmt0Q2NUYnRJRXV6WXFKajBuYzFvbDlGamI5eUp1?=
 =?utf-8?B?U296UVpXUHNHV1NjVjZMaDJwaklua2xuRWRNb2NKNVJBL1dGYm1HdDk2TEVG?=
 =?utf-8?B?emlvMHBrRWtJSDVlUUdsMTFvaXN2UVRsMlZnWFhhbkxXb3FpZTFTLzROeDh1?=
 =?utf-8?B?Q1V5aGVKUXRIMFRTRVhvdzI3N05vM0htRElwVC9jZ2w0aWQ0d09QOTJmVzZj?=
 =?utf-8?B?azZ5Y3Q5QmE1d0UxZnJFTGxOT3BwcFJaZmNmcnZsdUlUWlRQeXlmckhJZFFj?=
 =?utf-8?B?dmxUQ1BKenlpRGJhOGNGL2JaMnhIQkx2Q1VoRHBjdXdxVTZYdm4wbURRN3Vo?=
 =?utf-8?B?bTE3ODNwdkFDQzhrWk9IZStrcXhTZDJwelFxaXVPbWNIQytkTit5YUMyenBW?=
 =?utf-8?B?VkFSK1FVSThvSmpRcWpDbXN0Z3RzNGVSSnBkMzhwTDNHTStLZ1BBWG4rcSs4?=
 =?utf-8?B?QjBNUTdlMkRBa1pkSjZRYXFsQ0RsenhsdndmUmVSRlFZM2JUZU4wWVhONStM?=
 =?utf-8?B?TTYzRWtqZ1VZYWV3NlJzUy91VEVCSG5pS2xKb0Z0NnRUSzRyb1dGN1RoZVV4?=
 =?utf-8?B?THhhb1pUbUVZNVVRcVVTNGVueS9jaTgrQlRHNVlWR1ZzbnhzZnY2citqTlB5?=
 =?utf-8?B?ME1tRG1MeTVoeHY5SzRqdUpBUUVoNDBEdll6QmJlN2twNEtSb1FhcEJDSGdI?=
 =?utf-8?B?T1dWVFJQNkhCRy91OU05V3gxVGdPRmtPdXlCc2ZFMDlQdjdyY2ova0FaOWox?=
 =?utf-8?B?b2tlYzJxejhyOEI5RkpzQWdZNTBGSmdHMDBEZENSSXlYamtKcWlWVllIMEZF?=
 =?utf-8?B?bExBYnpOcHh3QVpIcG1RUkNtSUVDWDhCemsvQ29xZXlNY3hHcUNZMXllOW5z?=
 =?utf-8?B?WnJLWXRaa2ZRTUhJcUdxZ3liUDQyUzVHUjFrWkJhdGxJTS9RQlJIRDRQNmJL?=
 =?utf-8?Q?HsTU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 10:23:40.8761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8e2c8c-d07b-411b-9ad4-08de4dd6d418
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1D755039F

Hi Uwe,

Thank you for your prompt response and reply.

On 07/01/26 15:21, Uwe Kleine-König wrote:
> Hello,
> 
> adding Rafael to Cc: who sent a patch series for this driver that I
> didn't come around to review yet. Given that neither he nor me noticed
> the problem addressed in this patch I wonder if it applies to all
> hardware variants.
> 

Yes, it applies to all hardware variants, Uwe.

> On Wed, Jan 07, 2026 at 11:23:39AM +0530, Gokul Praveen wrote:
>> The period and duty cycle configurations does not get reflected
>> after setting them using sysfs nodes. This is because at the
>> end of ehrpwm_pwm_config function, the put_sync function is
>> called which resets the hardware.
>>
>> Fix it by preventing the pwm controller from going into
>> low-power mode.
>>
>> Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> ---
>> v2 <==> v1
>> ==========
>> * Removed space between Fixes and Signed-off tag
>>
>>   drivers/pwm/pwm-tiehrpwm.c | 22 +++++++++++++---------
>>   1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
>> index 7a86cb090f76..408aed70be8c 100644
>> --- a/drivers/pwm/pwm-tiehrpwm.c
>> +++ b/drivers/pwm/pwm-tiehrpwm.c
>> @@ -237,7 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	if (period_cycles < 1)
>>   		period_cycles = 1;
>>   
>> -	pm_runtime_get_sync(pwmchip_parent(chip));
>>   
>>   	/* Update clock prescaler values */
>>   	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
>> @@ -290,12 +289,11 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>   	if (!(duty_cycles > period_cycles))
>>   		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
>>   
>> -	pm_runtime_put_sync(pwmchip_parent(chip));
>> -
>>   	return 0;
>>   }
>>   
>> -static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				const struct pwm_state *state)
> 
> With this function also caring for *state the name isn't appropriate any
> more.
> 

But the duty cycle, period and polarity values are extracted from the 
state parameter, right?

Please feel free to correct me if I am wrong, Uwe?
>>   {
>>   	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
>>   	u16 aqcsfrc_val, aqcsfrc_mask;
>> @@ -304,6 +302,13 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>>   	/* Leave clock enabled on enabling PWM */
>>   	pm_runtime_get_sync(pwmchip_parent(chip));
>>   
>> +	ret = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
>> +
>> +	if (ret) {
>> +		pm_runtime_put_sync(pwmchip_parent(chip));
>> +		return ret;
>> +	}
>> +
>>   	/* Disabling Action Qualifier on PWM output */
>>   	if (pwm->hwpwm) {
>>   		aqcsfrc_val = AQCSFRC_CSFB_FRCDIS;
>> @@ -391,12 +396,11 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>   		return 0;
>>   	}
>>   
>> -	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
>> -	if (err)
>> -		return err;
>> -
>>   	if (!enabled)
>> -		err = ehrpwm_pwm_enable(chip, pwm);
>> +		err = ehrpwm_pwm_enable(chip, pwm, state);
>> +	else
>> +		err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle,
>> +					state->period, state->polarity);
>>   
>>   	return err;
>>   }
> 
> Why are the changes from the two hunks above needed? Reading the change
> log I only understand the first hunk and would expect it to be enough.
> 
The 2nd hunk is needed I believe because now, the ehrpwm_pwm_config 
function is called inside the ehrpwm_pwm_enable function.

Hence, calling the ehrpwm_pwm_config function before the 
ehrpwm_pwm_enable function within the ehrpwm_pwm_apply function would be 
a redundant call I believe when we try to enable the ehrpwm.

Now, coming to the ehrpwm_pwm_config function which I have added after 
the  ehrpwm_pwm_enable function in the else case, it would be needed I 
believe in order to change the duty cycle and period at runtime after 
the pwm has been enabled.

Please feel free and do correct me if I am wrong, Uwe.

> Best regards
> Uwe


