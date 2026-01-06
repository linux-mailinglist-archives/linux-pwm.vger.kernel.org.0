Return-Path: <linux-pwm+bounces-7858-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4BCCF8839
	for <lists+linux-pwm@lfdr.de>; Tue, 06 Jan 2026 14:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B49B5306A094
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jan 2026 13:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BBB330D36;
	Tue,  6 Jan 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="skBJRGeF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CE331A44;
	Tue,  6 Jan 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767706047; cv=fail; b=nL1EE24GZI5bevLqG/VVljOvj5eC791b7E17YbFksMNqnQFTrNkz/QjdwqcR3xp3POErb+7oQIW9+X1QRRQpocrncbOHuIl/G268DubdjLLMAMVtHmDL2CaKWGWQ6uERSlMv1Ne6X+GzJmlqIl5Ni1Y7NhmiRlshvOdoa6ctqcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767706047; c=relaxed/simple;
	bh=5pVSm+qbkB25w7pXM5Xp2c1ghsVmImZTgix1LhLrCyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kT/YS2Q7IQtpzilODmWB1yHxQ5IKq7fTcWgdekxE37/sVElv+CJ3hE8dbExg+UOdKNipUxdNJOAS6g/SmCJMIBa+b0g09KV2Cdvg56NxiQUKcOpZaXVNHTmYCK0uLUdl5NaO/CNofCj1eC7i8LFxxl4YIKlVQuAnyD40T3e0CfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=skBJRGeF; arc=fail smtp.client-ip=52.101.85.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=viYQCNTREO7pjTQCXBRdIReK++HJictZz2a+ZzVZpgMlsLb/jdpE38WIpRtO0fg8gtjlKJqy9i1nK0imh50RYDWyJ0+KBv33mPpQ4VU1gXlO4f3QJcSm7gXqY5oQU/bw8WXhnHdprgQAgCXbOpY5lIf1J6CiDole1fuY68JyAgShOWb20qSk8N/mxw57ClRwjjHIjWw7LLvgQYqhRhsWwIBol2BoHDMQiR4AtdsTtZmI6KWJ4S8S8p74goKhaxOnjduuy2ddaJxLYVSAIQ3v398vXSiD7C/jCNDuymjB7gS2Ul5xyKAHmIdtQ1QTAMygpoG2wH05XqfaAxkk3Z9oPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TuPlLcozPno5cCKrv9AzHq1Ho2cPM1nMkVoo1EtlgK4=;
 b=qCuZrq91KqHzQqCWr8ENT0HdDkiONaq5YFEnTBKiuq9tSuDjJIjJfJEqgKdkOMRNPnvlFRlnHJ6VqdjouZ1k8yMKu51aAOAXvBiUyjzo50Lxi+2um0TyMvJocdK2a0/bfuWtYEQryF3VM61WHA57Oh4vnt3yODQpsp98nS2R4tXEGs1i+wS0PABMHZ6VdpUxqPBERk9MsxRx7JuIvoZ9shQz9KhjriZ1b/c3SekWP8Gu2mQGPoX78uvHrpfS5B/hNQDjBAkrZoJwmJoyicxuH0fseLVjk94tNOJ/wmeprA7/HCjqgxIZosEo3PQDARg45951bXxAtzlAVh0RozyViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuPlLcozPno5cCKrv9AzHq1Ho2cPM1nMkVoo1EtlgK4=;
 b=skBJRGeFNcv/vulGvd0pINK2E5o3soPQTfo8o0bqw1QASsXt0+s7zHyy3+sR6OQ9TxCkdywAH7pJlm/Yp3nH3ZE2c3adVOdt0E90aQ/f+u65c1LWy5kkYUDqdtsS3zZpAr8HTExOhYqZGUtUu+UZ/3bqtZy/C+BJrD8o/dwtmuk=
Received: from MW4PR04CA0348.namprd04.prod.outlook.com (2603:10b6:303:8a::23)
 by PH5PR10MB997735.namprd10.prod.outlook.com (2603:10b6:510:34d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 13:27:20 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::7b) by MW4PR04CA0348.outlook.office365.com
 (2603:10b6:303:8a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 13:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 13:27:19 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 07:27:14 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 07:27:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 07:27:14 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 606DRBxx2936523;
	Tue, 6 Jan 2026 07:27:12 -0600
Message-ID: <4dd61e57-bc6a-485d-847d-8a86b854d358@ti.com>
Date: Tue, 6 Jan 2026 18:57:11 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: tiehrpwm: Enable EHRPWM controller before setting
 configuration
To: Gokul Praveen <g-praveen@ti.com>, <j-keerthy@ti.com>,
	<ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <n-francis@ti.com>
References: <20260106105411.36033-1-g-praveen@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260106105411.36033-1-g-praveen@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|PH5PR10MB997735:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c6e292-c19f-4410-6ca3-08de4d275167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YndmaUVjNEEzeEFUS1JuZ3F1SEVpR0hZNGdkRUlXcUkrVlpvelpxTU11RjMx?=
 =?utf-8?B?UXhoSkRNVjJpMUV1d1BLYzE1UXRRcEdqL0tpRVV2RWV6SU1VckU5aDF3YTdy?=
 =?utf-8?B?Z0src0FiTXorZk1DN1NTQWp6Q3JPRFRTRkZTNnFUcmhoT1drMFE2dm9IUUlM?=
 =?utf-8?B?Ylh5RjdJakFkZTJlMytqR0RQaVFBOUlIZlVBU0NXV0lmNHRHdXBPRHpTS2FI?=
 =?utf-8?B?RklNV0JnZ1lISk9SUjVyUjI4anAvVUJwaStRaElwVkUvK3Q5V3dhK3hWMHJJ?=
 =?utf-8?B?a09tdnJ6WTJYczZhd0NhUUJrZ2twM043MnRCeGFraDBFVVFxdUJETldNV1Jo?=
 =?utf-8?B?WUhwQ1Uzb2JLUGRMN241c3lTbjBGWGhFQ1oxc3k1M2ZGVGpwVkMzNVVEenZO?=
 =?utf-8?B?b0pyajZnTjlvVnAwWWZKOHc4RUhyd2N0Y2FqZWN3eVhKQzYvTDQ3V0RxRmd5?=
 =?utf-8?B?T2dGeG5CRE9mMTdzd0h4SGZjWGJlTlJVanhHM2xMaXpQdkJBVjNwUUd5Mzlx?=
 =?utf-8?B?NXZFYTlpZGxpeGZSRWlya1JDNmVhYmZNVUtIUjhhOGtBdDRXaWhmNXlqQkNM?=
 =?utf-8?B?WktpOWNhOEQ0dTVQMmRBZHBkT3ZiYVJFVmxXSEJ6bTltc0RhOTNKRkU2cGZN?=
 =?utf-8?B?eG41Z0RENnVnVW11LzdYNTY2V2hvZ3lFZVh3aWhJTDV2MVZ5OU80RENYbjhR?=
 =?utf-8?B?TXB3UWhFZ0NnRlVXNElVK3JKc2Y2Qm9PbE5HUmg1Z29NMzRDRmhINmlHaDVv?=
 =?utf-8?B?TEtma3JMbTl2eWV1MnM2OXVaSGpBbXRRUDlDUWdGZitIQStoYWg5VFlBZUhE?=
 =?utf-8?B?L0FnLzZQdHpDNlAvWExKMUx1SVp6b3RhRTVsQWF1R2trRDlRaXFOb0tIcktM?=
 =?utf-8?B?UTROZG5BS1B6NWNQdExhZS9IcFdaamxLQWpGSEdXMStWUk1MckFJZHRieStz?=
 =?utf-8?B?RE5XbG44aE1RM2lWSVZTcnRXR3p1cmtqVWxkUHBYTWdpQnYvU0VBNjJhZXdv?=
 =?utf-8?B?VmllRXQ2UTd6MWhKa2VqWC93Q003dVRuKzZscVRSZldPd3BaaHVJSnA2dGRG?=
 =?utf-8?B?ZXdKRU8rbzRMRkJvT1Buc29LeE5hcW5CUTlYWTBHcTdXVHBESkxGUmNYTFVO?=
 =?utf-8?B?Z3dDcFVyc1B5VGpKdVBiZVNlTUxEUjZXQ21jRkFDbE9Dbk9uTjBGVUprS1Bv?=
 =?utf-8?B?ZEM4QkVUM0Erem5IRlY5WmlETHNyVDQ1bHNDdTdaVkR1S2VCUDA5dWZ5Tzcx?=
 =?utf-8?B?MkdyOU9zOWlRT3Nzem1RdHdTUWhuTXNudndmY3RLZW9ybFQ2VjFNMDRZR3Vl?=
 =?utf-8?B?MkNOSy9TbjlmbkltL05RZjd1aTRqcG9nNjgxK3pyZHhlbjJHT2kzZXpPczYx?=
 =?utf-8?B?ZlMwSTJ2VmdwcWl6OHY5K2ZLOFZlcWZMaTFlUTQ3YlNzbDR2S1FIODRxSTJn?=
 =?utf-8?B?elp6aTBXL0w2dUkzQXVLOVdIaWhJUUpmcHhORUdwdXl0NzdpWUdYRGNMcVhH?=
 =?utf-8?B?d1ZTVDQwbUdVd2JOaU9UUVpwT2pSQkJiZUNhc0F2UHdaeDB4Yks5LzdGZkxT?=
 =?utf-8?B?blFYVklqTUMySE9xS0JFMWQvU3BvTGxqSUQyZWNIajhPRkxTSURVWXNBODB4?=
 =?utf-8?B?bFlxYWVDYlkzM0VaREJXWENDWXpZaUhNTEpuU093UWFVRDMzcngwdFlJd3Rj?=
 =?utf-8?B?enZnQjFad1RwTEh0eFYrckppNU44bXJPelhpOHArVjRndEFFNm9ZT1NDMGc0?=
 =?utf-8?B?WmNxQklwVmNNS3JtSHh0dFcyYVVTUDl4dmE2dENYeC9CRHlpUnVRVVJvak81?=
 =?utf-8?B?VWFyUk9EclRiNDdMOE02b00vWEp5V2VCVmg2aUdHZ3JjWXYxK09RYkV3TlE0?=
 =?utf-8?B?Y0xaaWtObW9IekUxSnhaclhBNUsrWVRyNjNSUkFzMEVsYUhPWHRoS0NiWXhZ?=
 =?utf-8?B?a2VwNHhsOGptcjdwWE4wcVhRM0VzelFqc09GakFTbkxyK0d2cXlGTUE2cXla?=
 =?utf-8?B?ZTVXYjN2ZjJvUmlvU1ovVEpmSFVoSm5MWUZFQUJ4MklMdGxjckMzK2R1NEwr?=
 =?utf-8?B?Y3pEWlVBK1lzeU96aGpUbGYrZGpZcXhzQzY5K1ovN0xPWFRlWmFuTk53R2dS?=
 =?utf-8?Q?Ni7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:27:19.7261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c6e292-c19f-4410-6ca3-08de4d275167
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997735


On 1/6/2026 4:24 PM, Gokul Praveen wrote:
> The period and duty cycle configurations does not get reflected
> after setting them using sysfs nodes. This is because at the
> end of ehrpwm_pwm_config function, the put_sync function is
> called which resets the hardware.
>
> Fix it by preventing the pwm controller from going into
> low-power mode.
>
> 'Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement
> .apply() callback")'
>
> Signed-off-by: Gokul Praveen <g-praveen@ti.com>

No new line,  between Fixes and Signed-off-by Please ,

You can drop ' before fixes.

rest LGTM.


> ---
>   drivers/pwm/pwm-tiehrpwm.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 7a86cb090f76..408aed70be8c 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -237,7 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (period_cycles < 1)
>   		period_cycles = 1;
>   
> -	pm_runtime_get_sync(pwmchip_parent(chip));
>   
>   	/* Update clock prescaler values */
>   	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
> @@ -290,12 +289,11 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>   	if (!(duty_cycles > period_cycles))
>   		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
>   
> -	pm_runtime_put_sync(pwmchip_parent(chip));
> -
>   	return 0;
>   }
>   
> -static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> +static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
> +				const struct pwm_state *state)
>   {
>   	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
>   	u16 aqcsfrc_val, aqcsfrc_mask;
> @@ -304,6 +302,13 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>   	/* Leave clock enabled on enabling PWM */
>   	pm_runtime_get_sync(pwmchip_parent(chip));
>   
> +	ret = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
> +
> +	if (ret) {
> +		pm_runtime_put_sync(pwmchip_parent(chip));
> +		return ret;
> +	}
> +
>   	/* Disabling Action Qualifier on PWM output */
>   	if (pwm->hwpwm) {
>   		aqcsfrc_val = AQCSFRC_CSFB_FRCDIS;
> @@ -391,12 +396,11 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>   		return 0;
>   	}
>   
> -	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
> -	if (err)
> -		return err;
> -
>   	if (!enabled)
> -		err = ehrpwm_pwm_enable(chip, pwm);
> +		err = ehrpwm_pwm_enable(chip, pwm, state);
> +	else
> +		err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle,
> +					state->period, state->polarity);
>   
>   	return err;
>   }

