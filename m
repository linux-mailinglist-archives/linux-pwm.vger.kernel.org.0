Return-Path: <linux-pwm+bounces-4546-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0EA0380B
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 07:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8F51885FEB
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jan 2025 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E628A1DC046;
	Tue,  7 Jan 2025 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Up6wFlat"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2102.outbound.protection.outlook.com [40.92.59.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089711A0BCA;
	Tue,  7 Jan 2025 06:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736231838; cv=fail; b=ghPmrpJwzfYTDN/TUEy2GqFPt8QxrAMGis0iYDUjnSAjB5aKPWNY8DDKgEFSKF+FLZFERy5Tafr3w3DqHVu0L2CW986ebziZmPu9B0Y2oS0cW0RAC1ashGpmmWw44L6eeWulAO66byfH0lVwcL/rve4hkbarGkQzgMhMWTM+kik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736231838; c=relaxed/simple;
	bh=u9EddVBk4KZEeqzOK7JXGav6p2+hvv1cD3SK2kXDiJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AoK1JUm8eO+glCymIRbo3lSjz5Lbxu8Xmh7W+42hQXygRnvSJ2V6BEFLffCQPrgO/WVF9P7c7Aec2ooFh2tVJQdwz2Tj68G4pYYP2bYfVZM0fnSp/KxB1kYttZ3USvuvbujmaTaWVeDyr6FgwAua9XRO+cKtAWwI6NYrQBq2kVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Up6wFlat; arc=fail smtp.client-ip=40.92.59.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq9L0/8WJH93iywytPO1mLNwFJemzV3IbJTxI+QAEYsUbEKceuuh+z3umfyeFN/MIvGJFq3z8lWJ58FcWlONfHY+73DUpogpOhrPBEqaawbJx+hwT9/aRS+86ThJGRXZZkcxwT1/S9cZWm8ecqVvEyP0DyP3ShpZ1Xzcv7BCQCtOiYWBtactZQxqqiQvPjZTaqe5y/pg0/KeRDYptaEieKWTmjSpLhDxli2r/KbeOskIvWsYbGuSypOx7lxqf4k8AZR3H8ynxI1Ev/kS4PrMf4HHg4uyQ2uxVlGY0eR2vnhQN5pt0j3CaIvXVi1E5tD249++2SXE91g7h5sO/nnyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wu16qBoiGUAM01JgJuVVQm4VWtNosAEWGLrvaCDmso=;
 b=lhfEmWCl5oPcTPtEYiHsvVco3i81EwqtD9Eimmyv9XyWDmqeR2Pp7hEvp0FBysCXL+l2z7WP3YEN1oTY7swYoXVSm4eacanmRICb7wYVGgpYqdLJWspV5/NzCGGOKlCclrbxU5K+g5wRuVRqKSpXMc3/zpwmmoESVPMTzhSn16SuMCmTLLd8kOCV2Tkbx+s1s5wiw9x8oapAmsAHvd01X4+fJp561FDitx8u3oHotioYzHIiq7iu7tz3AcWq2by94uaLYgyjwYPNwEvl5tR7/RalAzAaT5gwQONjBKNs6AYgRo+1fKRgE3DUTveuI6EDWGHICnM4+FXctzNargJQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wu16qBoiGUAM01JgJuVVQm4VWtNosAEWGLrvaCDmso=;
 b=Up6wFlat175Wgi5UOnGfrRAIonXSOtMhPnJ1/hU2bAEvWXgtmtApoMuq3ucAGkAlDE2vM48POa5Nn4O5VuqYfjLPxKyKV6h7Zv74lSDooiCr2ux6S1E94cHX7Mfc7KOAAvPklXzmvsUN8Q5BwbxSwbyjhSfR5KV91HbrykOLVeZq3m60Ygg8Vak+qAeLZ+mcfthZqlLW1U9iyJMRbZaBqZQvn/ZADUhWzoLUs1Gx2lA2OZZ2+EqUh7u20XnWsWGEwCa43VmuftMEkx3CLOvmGbwnvEuAiYhhbDbROuntItDDO401gXX5PbJCoTNH2fUFeM2VjN+CiPmkw5YH1IGJXg==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by VE1P189MB0895.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:160::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 06:37:14 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:37:14 +0000
Message-ID:
 <AM7P189MB10091DAF204BB660E619A01FE3112@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Tue, 7 Jan 2025 07:37:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: william.qiu@starfivetech.com, hal.feng@starfivetech.com,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 p.zabel@pengutronix.de
References: <20250106103540.10079-1-william.qiu@starfivetech.com>
 <VE1P189MB1024E9669B8CFCB943D633E7E3102@VE1P189MB1024.EURP189.PROD.OUTLOOK.COM>
 <7kfpvipnkirfacy3ro3qb3cmbw5fv5dlyjh3qowc4juvmcb2jj@43zpytio2273>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <7kfpvipnkirfacy3ro3qb3cmbw5fv5dlyjh3qowc4juvmcb2jj@43zpytio2273>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0149.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::18) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <473b2de2-b5ce-4377-9371-7cd1d412bf95@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|VE1P189MB0895:EE_
X-MS-Office365-Filtering-Correlation-Id: 4304fbc6-348c-45f6-1898-08dd2ee5b8f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|461199028|19110799003|6090799003|10035399004|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmlRdTFSVUNKb2lXMlU3VEtkcndQaHV4QytZbCs5K3Y5c1V3QlVDNTlqQjli?=
 =?utf-8?B?VjM3a1hHU2g3ZFFFRU53d2hIeWJRbTFmVVRWamhiKzdDcDlxVHdRRUlJZGw4?=
 =?utf-8?B?bmlGcUYyK0FLd2RVa2I1ZThOU0tDUEpPWFZYQ0tvZUp3Sm13TjhHRkRJZG5E?=
 =?utf-8?B?cDBwRTdhMTNSQlUyTGxLRUYrOXByVVBjYlR4bHp2YzdGak05RWxENkZmSmZH?=
 =?utf-8?B?TzRic2RBYUsvTmlwNUt6b09qZ2VsTGpWZFQvcmtnempKNTMyL0hnQjAxa3NU?=
 =?utf-8?B?SytXeGZ6c0JWNWNHVjZRa1daYnFHbVR6c25MbG8zSjF5elRqVlJ2Tkt2MndS?=
 =?utf-8?B?QkEwMnM1VWtXUkVmV1hieTJ0SytBZkR2Y1RzSDljMVlMWWxhRmNjcEpTS2dI?=
 =?utf-8?B?c1NFNGcvRmtFWVdvSlNuVmtTQVBYbTdNcTFvYXMwNmw2RXZOY3NOOVJDdXRy?=
 =?utf-8?B?aFJ0RnNqZkFMek9WNzhuelFMOXlMR202YUhRT29UM1RsdzBWV1NYblpCMUlD?=
 =?utf-8?B?dXRPMU1Ga1JybWtpaDZoeWVTK0FKcjd6dGZYK3VPSDNFdFB6OWpLUEhEL3Y0?=
 =?utf-8?B?dmt2eEJVRXBFenBMUFFKYnhBRU1RdnFKTnptMVM0UzdGbThYZU5QMWc0aXMw?=
 =?utf-8?B?VkFjQnF4VkM3NHpuQitML2FCZWFTTlBuNzF2L2RZQlVUSHdXNVEvc01rd3hn?=
 =?utf-8?B?Q0hzL1NyTXZESmd3U1pxUHg1b0N0NXI4eHRsVEZtTnlYaUU2SUdLTzg2a3hH?=
 =?utf-8?B?UWtBKzR2bENZbnlBZ3BaUHNhUlBkRFlRNllpV1YzVjZHWEcwamxpQ1pzM2xm?=
 =?utf-8?B?WDRVRGxEU2MyQlpVZlRrUTJTY2lXQTRVeU5LVGxNVDhaSUl3aFRUSnZDYVFi?=
 =?utf-8?B?aDZKaFRodnByTTIxNmQyelQrNlhKMFIxekdFclpreWx1RUp2TFByb1hEU0du?=
 =?utf-8?B?UkMrS0M5MTFIV3VVZTJwQlZBSVpRS2V1RHcxSFArU3dXUGZsYUpmUlhkN3pr?=
 =?utf-8?B?WUpubWJ5UzZwWWV1Qzdua3ZjSGFyUHNYcGZTTkEvVk1tZHg1SnN6ZUtUOWxy?=
 =?utf-8?B?eVRZV1BGdDF3ZzN2QmZPd2RSVUVZS3RMVWdiZEFRK3VqQmNOUFBvWmQwZ0ZF?=
 =?utf-8?B?cWNlMlZZa0VlWWhhbjIzWnBaU205RnZhYWY0dmJFbis5bVpGRUo2Wk1uR2lj?=
 =?utf-8?B?aXBmZUNLYUFQaitZWEU5Q2dKSzlXTENNMUFwcy80SE9FODF2MlV4d1pXdUNC?=
 =?utf-8?B?ZDlIMVRGWDhMRC9lb3NFNmZWWDNzeU5Ba1VNOE9mam56ZUNRbmZoQ0dFTUFW?=
 =?utf-8?B?dHE2bTd6WjVweGVJQTlDMW9TN1dscWt4dFdZSUtacmw4RElwVXdIcDJUcWJ0?=
 =?utf-8?B?M2hXZ3Yvd1c3R2lnY253anlieFpsWmlsVmsxZGIyVmwzTm5hZFpqUlZJQWl6?=
 =?utf-8?B?bzdWd0NmZ2VaVmdCNXBGdHh1cUt2dXlXK3VKbURvZDF5bXFHa1NVOGtVdVda?=
 =?utf-8?Q?UO8IHGWdi5gHMklKdX6VQ4ciWhK?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGJVN0dGVE0zeHV5czRQZXhhMnZ6MnVDcnNrYzhhdGxDbXJiRlo0dXB3dXJl?=
 =?utf-8?B?WEwwQ2lrTjlhNEk2dnJQbHZXcDZ1dHRaU2x4UmY2VUptRmhCYU11YUZZYjI0?=
 =?utf-8?B?U3Vwemxid1hCOS9SM2RHTkw3T2NSU0MrUzNROG8xNEdoMHJUaUZma1ZUL29z?=
 =?utf-8?B?RkNsQk1TWkdQQkJRdzFrTk9lVTNCQlNOeVZja3A4QXJpMndRZ2x1NENsMGpY?=
 =?utf-8?B?WmR2aUhGRWFtTWJaL3BuWlB3TkRseVArNHVqMm41UStKQ21oeSttQ2s2dVhi?=
 =?utf-8?B?eXg1Zk9JNVVjaDNvQUdGakJIcFBEQytNSnN6eDlJSDNMT01sQW5KUXBValFZ?=
 =?utf-8?B?UGZ1S1JuZFV0K0NpTzRBU0RCWDJNckwxV1IwSldXM0RSV1RVOFNDYWNjWHJJ?=
 =?utf-8?B?blcvU29wNkl4SS9LT0dqblJxbXY2WXQ4R0F5U0R5Zy9VbzRKL3czSWlONlhU?=
 =?utf-8?B?aUw5MWFKRUNEZEsxeDVYR0tWejlrU2hEZE1OSWZJREo1dUdHTkc5ejF0bkR6?=
 =?utf-8?B?OG9iYm1maFJBN1E5SkxGcFVFVGNFRUJvTVBUY0pvNkJPZDBQZFZlRm9GZDUx?=
 =?utf-8?B?SXBMaWtkUjErdjlld0FLTiszdUJTUUFCbDdDVnUya2krN2E0RVphSEZhZ3k3?=
 =?utf-8?B?YWplYW41emdNZTRNbHBrb09FTmtpaEF1V3JIUS9KV28wUXpnaXRibThDak1W?=
 =?utf-8?B?T0FTRzNydTFuc1BVM29aM1llTWZTRThRcHVBUFNTNVpaSkNsNGJSNytFTmtW?=
 =?utf-8?B?bVgyaXp5TGoybHFKcXVVUE1FWTJ3WW81dmUzckM2MStwTkIvUitoUmRRMEhn?=
 =?utf-8?B?eWx6NHgyMGFyQ2NXN0FmUUhBckxGWnF0Y3BJZmVZZzU4cU42V3Z6UW9uVi80?=
 =?utf-8?B?b0hpTERDUi9IcVJHb3Q5aEZZWXM0clhNbUR4QnMvWW9UMndKdW9zbTdXN3d0?=
 =?utf-8?B?bzYxMy9LTGdWZUpSMHU0MHJsZmdyRHV0a0pjZzlmMWNnajEvS0tEM09yN0hW?=
 =?utf-8?B?WUx5V2EzQ3hEOEJrV2hZNFlKOFcrNGE3TlkrbW5CVGdPZ083VG5RamhNUzFj?=
 =?utf-8?B?R2lqZHAyNHYxVGRyNU1INzk4MzU5N2tnVFpzZHVEQzNyVjQ3K2dQRGFqQWc0?=
 =?utf-8?B?cGZTeTNuRnkwbmUvREowTDBrQWl3cXZ0enMzZWs3SmF3Y015YUxJL0RMcVpk?=
 =?utf-8?B?NUFYaWRrZUN0cmVRY2tLMmdqTHUxR2dnWkZYUEpKM0VzSUU4d01RM0dDN0pj?=
 =?utf-8?B?SUZjVnhxejhxUVQvSEQzcWdGaEIzTEdXUjA4eDJjRzJuTVprUTZRNWdONGhF?=
 =?utf-8?B?YVhncjd1WXNaZkI4d3hPbEZnVVpSY0x5NHUzUzlpNU54YUNscCtZRUVHUjdE?=
 =?utf-8?B?VFJ5djBMek1QYUxrV1h5dzMrRUxNaFppeDZkTStvOTNGRWRDTWUyM2JGc05Y?=
 =?utf-8?B?eUpxdlNaMFhadkhRM1JVZ2ZXZ29Cc1VGQlgrMWthUFdRYWpRRVN1blk0MjU1?=
 =?utf-8?B?Y0NiSmsvU2N5clZqcHNyVWVOVW1FVy9tdGFnTWVJeFlWRmlaMTIwK2NCQU5B?=
 =?utf-8?B?Sm9hdUdiZ2ExU3hiblRiSk1GcHpyTXpiWVhNRW9Ya3NrVlVxbFRrczE0ekhD?=
 =?utf-8?B?cE50dTdlQ1FYQVlYVy9VTU01bUtxTjlnUERKREpLcjVHYmpEaUluKzdWVzlC?=
 =?utf-8?B?NlVGQmhLR3NsRCtEZkFsTTYvRGZoMUxjTG5TcUdLZ2FZM05yZkFVeGFORVZH?=
 =?utf-8?Q?Xm90IkHVPpC4i+J7uez6ySCyK0v2pd8TkFLwCwz?=
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4304fbc6-348c-45f6-1898-08dd2ee5b8f2
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:37:14.4759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB0895

Hello Uwe,

On 1/7/25 6:07 AM, Uwe Kleine-König wrote:
> Hello Maud,
>
> On Mon, Jan 06, 2025 at 07:59:23PM +0100, Maud Spierings wrote:
>> Hello William,
>>
>> I've once again put the patch to the test, and it seems the oops is
>> resolved.
>>
>> I did notice something odd though, when controlling the backlight  bl_power
>> 0 means the backlight is on and controllable, 1 seems like off, but instead
>> sets the screen to maximum brightness and then stops listening to any value
>> echoed into brightness.
> Note that for bl_power 0 is on and 4 is off. Still the behaviour you
> report sounds wrong. Quickly looking in the pwm_bl driver, I don't spot
> something obvious.

you are indeed correct thats alittle odd but ok.
>> The brightness is also reversed from what would be logical, so 255 is off
>> and 0 is maximum.
>>
>> Now the little text at the top specifies that the hardware only does
>> inverted polarity, which I guess explains this, but I don't understand it.
> The backlight's operation should still be fine, its usage be independent
> of the PWM's details.
>
>> I also encountered this when I got an error to start with so I had to add
>> PWM_POLARITY_INVERTED to my pwm-backlight definition.
> That makes me suspect the problem is on your end. If you add
> PWM_POLARITY_INVERTED the result is that the pwm_bl driver still
> configures duty_cycle=0 for backlight off, but you then get a constant
> high output.
>
> So with the hardware capabilities (i.e. not being able to emit a
> constant low output) I think you need to not use PWM_POLARITY_INVERTED
> and accept that completely off doesn't work (unless you have an
> additional GPIO or regulator to disable the backlight).

If I do not set PWM_POLARITY_INVERTED in the dts it will cause an EINVAL 
in ocores_pwm_apply

>> But I don't understand why it isn't supported. Wouldn't supporting non
>> inverted polarity be a very simple calculation? 40% negative duty cycle is
>> of course equal to 60% positive duty cycle, 20% N == 80% P etc. I don't see
>> why the hardware would specifically have to support this.
> If you only care about the mean voltage level (as is the case for a
> backlight), that's right. But only then. And if the hardware cannot emit
> a constant low signal, this doesn't help you.
>
> Best regards
> Uwe

I did some more digging, took a look at the pwm-backlight driver in the 
vendor kernel, and it seems there are some tweaks there [1] (all the way 
at the bottom). And it explains some things, first off why it didn't 
error before without the inverted polarity, because it sets this value 
in the pwm-backlight driver in that kernel.

but the interesting line is this one:
|brightness = (u8)~brightness;

Which is doing what I thought to do in the end of my previous email.

So maybe the hardware is indeed the odd one out here, sadly I have no 
access to the design of the board.
But there is definitely# something weird going on here, not quite sure 
where to fix it.
|

[1]: 
https://github.com/DC-DeepComputing/fml13v01-linux/commit/cc7131dd58e068c58e54f8c8fd23c5ac41c33f46

Kind regards,

Maud


