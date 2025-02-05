Return-Path: <linux-pwm+bounces-4776-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DD3A28B14
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 13:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB83E7A43C1
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA586359;
	Wed,  5 Feb 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XpjOBkXJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010011.outbound.protection.outlook.com [52.103.68.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D188FC0A;
	Wed,  5 Feb 2025 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760255; cv=fail; b=J+MpLHeVeXvk9Dv8g42AZcZZBZ/1vas6G+tmZ1nv414naE648zQns4HwfwwLvdRdHengV6Y/79loGtDgavrYl6PbN5w1lKqLTL9UJs1CHTrCdKTszkyjpZbZrfHxkPQN0b+FkfPIGgRq5tAEM+cGJiAaLElTnVgN5lVE0Pm3lOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760255; c=relaxed/simple;
	bh=SnOC4QCLKC/LmmoNoBMOep3lShzQefb5AYqLIxEdhMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bdig6BD1VOhON5q41A7AXyA2BXdX9FmXNN5QiZRhFPE+ygDuzak/W02SPQuSBDjQPx97A0ODnvks5bNAySYc9s3NsEObZvnTmgJwsgA6fXFWOwjfqvbAuktaqjCc+R0kadyvVkLeBulEII0ri0m5hptojxc0ltNcxhmegFLlSzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XpjOBkXJ; arc=fail smtp.client-ip=52.103.68.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCuFQsrVyoQgeO2mC0DtkP6zzBN1R9e0QUEkNruzowV7EHMb4jVlHt0IHWQIAVwc7bIiKjEAFOx4KEKVarmjNh/cB52LApoz7vYkQ5fLlQmdB/85CXyb2178QZ1xz/TY72+ph191KIgrHWvhmw/27XS7fB5GWabw6ZmvwW2RbDDHIWQHrgXODVCVfX0f5KgPdoqXRfPzi7f/edp+F2/ShrrqwQKXgrtxyJeXwmCRv8GmwFUmWnUlzX2WIadYHYMIIrDSXC4dJqiFajhhJu0IQjLsOVDlgKdeE4TPCKLaNYM/5cRGW0FtXTxBrW1n0AltTAwSfoPrVwZJfKmzTqRInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsmQXwyQzN+ADZz4izzB8yiOiY6//qDmTGfv8QF1Qws=;
 b=KgI7stV3jaGV+1/CMuuXnra77Dn8pwy6qpIgq7LwKchu1uRFPUwtQ/Q8uuh93PA9j63nzX+fXINflNjndCGnQQHNk+5cPEWuWEKZ95tT7EcyQQwBq7l3H1CgxGkaLd9e1lBG3kpvbNWy7sploBLC2kgQKcdKC9gdm5h5s6Z6nFW/rl8E9zDJce0BTt/axxh+3rdv2Qan1gwSnqEf7Isj3y2/WEwaU5Klt6x6jfkP879vvqFxVUEVbCPO7rBSD8fHdrIATzdlVZTw/CJQINr8l/PW1777do9SH7stvDMLlZy8IQy5XYaMpKNiaAL9Ci6XwMFFjYqn9NL54MJehkqdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsmQXwyQzN+ADZz4izzB8yiOiY6//qDmTGfv8QF1Qws=;
 b=XpjOBkXJmUWaO2+MsddUD1ap9s2cZYvYRCB/TlzIrAPfvGT7U3L20qbCmRqetQqzgUAr/QE1o1WW4af69726LO7RgZYki/0ed09yOMtk/tBxnH+NNNjDejCYKTbVztkbANJs+NPv/QTQM0HuXfYTqhMG0LjpnjlqPpGjwG/bwJvfPt6yy+TbnJlD0LKKJgX/wzeINQoS8NIAD72Fk0G5fU2RHixD4sC0UWIH0xHOOzp6mDKEexOONCaDz3EHq0HAJA9E7BdOeY1/brd4JMqXtlR9qhttbq4JNjAxS8dgX8gH8Fw+s7ZWR5mDWIRNac5rAvpsUFhZNMF/uUAjBx0cjg==
Received: from PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ba::9)
 by MA0PR01MB9655.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 12:57:26 +0000
Received: from PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e59c:e6ad:e596:123b]) by PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e59c:e6ad:e596:123b%4]) with mapi id 15.20.8422.010; Wed, 5 Feb 2025
 12:57:26 +0000
Message-ID:
 <PNXPR01MB7488BA555BDE96E59741DBACFEF72@PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 5 Feb 2025 20:57:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com,
 Sean Young <sean@mess.org>
References: <cover.1738737617.git.unicorn_wang@outlook.com>
 <ae8ea1bf0bb0a09336cd8b7f627a994630524bba.1738737617.git.unicorn_wang@outlook.com>
 <ivgsidvdx2ypntnlopww6fiwyuzj2sadt3znyofr54dsz3c5d4@3mr25vhwlwy3>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <ivgsidvdx2ypntnlopww6fiwyuzj2sadt3znyofr54dsz3c5d4@3mr25vhwlwy3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ba::9)
X-Microsoft-Original-Message-ID:
 <c13f6f27-f38d-4d21-9240-76c32832da88@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNXPR01MB7488:EE_|MA0PR01MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: 022d5b49-9608-430c-5dfe-08dd45e4a38b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|8060799006|461199028|6090799003|5072599009|19110799003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEt0ZGhlWnpYNkhlZEdqZGwxVjI0eHJqTWpuazhzYkllYjB3NlhvUzZZRVJr?=
 =?utf-8?B?RlhoQzlTU3lzejBSaG5samZkZFVOZHhOZ1NWQytTNHVMN2tHLzYxSVJKWjlv?=
 =?utf-8?B?d2daSWJEVElraHJ3bmR6eHlkZ2tiaGtaa2NxOXRjOEFFZkgzK25Wa3RxUk1z?=
 =?utf-8?B?VGtTaE1EWkw1VFVZZjRldCt4VW1NeDNjNVFPS0tUYm1lbUN6ZElJOXpDVE41?=
 =?utf-8?B?U0VDdUgzbzE5akZSZzhJSzNERXZPQWNHOGJyVnZwMEthMExSSWlsRWVDWFdE?=
 =?utf-8?B?dWhzOTA0Z1c4K3pmVFZWbXE1YUwvYjZSTzQxTkxiYjJGNG5kRHhOdDFOZk4x?=
 =?utf-8?B?OGdjSWl4TzhYT3A0TElKOVlZOXdIOEhXOUtxYWM5ekZpdXZ6aklIWHVEcDZS?=
 =?utf-8?B?UFRQR1lXcHRIa1E1bGFoMFNOWmtucEsvSHNqTjcwc3k2NEtSSmtCa0ZuYXQr?=
 =?utf-8?B?QmRYQ2FibmJESXNuU2pGTXNJb0sxajVtekF1ZEhhbjBpNHZWTmZoTC9wb0lW?=
 =?utf-8?B?ckRSRlVuWm0rK0JBeXZGNkpuSFoxbGZOYmdlc09BQnpPVVVuOGtDZFlBc3Fr?=
 =?utf-8?B?UWtYVU5FQUh0UUlUQVlLZERXalJDSzZ2MitqRWdTUFdnUVVWVTNoVCswVlhM?=
 =?utf-8?B?Vzg1Tzl5bWtndzNxbkp3MUtwM3dqbytndThVa05wNHJOcVFmQ0Q0K0ZZMHlz?=
 =?utf-8?B?eUZoRnQ5N2M0cm9oVkVIQm5GaFM1NVl5bGFaSVVtOGo4YU00cnVHWXVLZVV5?=
 =?utf-8?B?K2hOQk9PT0JZNURGN2xnNGsrTHRBVVB4M2Z5R05VU0owYll3dUhqTk40Z3hi?=
 =?utf-8?B?elpzSXJkM0JCMENaMnpBUzFxOFBoWHBNYmNsMW1oMjZxQlU4dEZ0NnJRU0x4?=
 =?utf-8?B?cGdqb203ZWc2eVVxcVhZRENoRXZjZExEb0VuNG04cW5UcnhaWEJWYTZ5RlFC?=
 =?utf-8?B?QUFjdGpHYWhWbiszOU5ud25JMXRSTGxIdnBVN3pSeGlTanV0eUdjRGhwcmxX?=
 =?utf-8?B?M3RxelZnOVZIQTVrWHplNUJmaWw5a2ltVEIyUVY1SWM0eC9kVUg0YUlReEZ1?=
 =?utf-8?B?UmR4MXpFZDFTbDgvUVlsT2twYmswckdDbzFyWkp6d0dUOEJTbFdwbnZEZDZu?=
 =?utf-8?B?YzVTMFdSS2d2dkpFbmFHVFNhVitoSmJ6QlhkQkVKK2Frak5vZDN0d292T0Z2?=
 =?utf-8?B?L0Q0cXA4Skl2RjgwVDd1VHRmVStlVmtSVmNXcE9NeUN6T01KS21SZ0FEc2lk?=
 =?utf-8?B?ZkZsbHh4Y0xqekY1QkhqV2tDcHBWdkxXOG5LWEFUUEkvVzJ4SlMzYmhYaEtQ?=
 =?utf-8?B?NnhwSGVrR1pCVlhZUzlsa25SaW52NmZJZi94Y21RUkVxZ3o0dXVmMUY3cXVK?=
 =?utf-8?B?VitJNTNRenFRcXVoZ0EwYlJOOS9tY3JieFBNaXdVaFRjdzRyeVZyRHNlZlA4?=
 =?utf-8?B?Y3YzQkQ0T3lDRUdsRkx5UTRaWEFBYU5mWldNenlrbmpYSVhaeFB0RThpaUhp?=
 =?utf-8?B?bUU3di9NNDNqcHk0aVoxd2ZJbXgwT3lLdmFIS3R3VU5nVUhGNzcrL1RPU2Ni?=
 =?utf-8?B?N29FQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVpBSEZiZXZZVlhrMTNFS0ZiaXhiS29Nc1hwRFpvblRKaXR0ZzVSZzNJVmZD?=
 =?utf-8?B?U1RqUGZxbXNTU1JtQUVBV3g0UUo5cTVURGRoQlVXVks4ZWZMREgzQ3ZSb3Zz?=
 =?utf-8?B?a0ZoZEVlaUlvY01vbnBGL2FwS04rZHVJZUpSYzZWREV6L25ENTFkMmcya3Ey?=
 =?utf-8?B?dUI3VGdpOE1mOEhMTzFaMzNIRG9hME1qN0h6eGFzaExvTHlGRHZPQkYvaytZ?=
 =?utf-8?B?Nm9lSGRlaktOOTVjajB1bUYxcjViV05icWVRekFydlhiSWpnUTZZeUVhVXc0?=
 =?utf-8?B?K0Q2YXdteFJoSlNHcWNsb3Z4TjMydTRNYXZaSGh0TldkQjNpdTFNbjR1ZE5q?=
 =?utf-8?B?MTgranNTMzlCTDM3TVNySFFqN0VUZU1wb1E3NmtiRER4MGo1MFJ0ZkprWWdH?=
 =?utf-8?B?OG5KRDduMDdqUldSN3VmbndLNXZvanhkYUpxMUdGUzArQlVNRVdGRHBmSkg0?=
 =?utf-8?B?NGVIaVNFbGkzVEJmTmcvd2ZyVmV4bno2MFJYMWNVbFFGWjY3UHYvdlg2K1hE?=
 =?utf-8?B?Tzcxa2JKNFowTERUMUlLc3Q5RjY2OGtSYk5LSGF3NUhZZkFST3l2VElIT1VZ?=
 =?utf-8?B?WFc2S3IwL3JiakkrOUZRY1hXNXRwMEZpZHM5WjBJdVFPMGdrdmxXbkozbCtl?=
 =?utf-8?B?dTRNOSs4RWwrcWkzMnVtYm9sRW9vV2VVUU15L2dyRWFIYktxdk5adEdUVlFN?=
 =?utf-8?B?VDFZUWJmV0pYUUgxU0lsbnJqci9md2M1QnE4eEQwRnhUUzFCWWdsZkZEL0JE?=
 =?utf-8?B?YWVoSGR5d28zcGF5RkRNb1pxSXZGSDBHci9PT3pRNTlXUjVySlg3TTRwb09F?=
 =?utf-8?B?Qk40TTZlUk1YM3U2TUNXaDYxT2x4VlE0cVRDMEp1eERJUkNsRXUwdkFQRDg3?=
 =?utf-8?B?Q0FEUU5BRFpVZkFZZ3FPYVV3d0hTQWxOcUp4dlZXRng4N0VSaEYralZyNWJo?=
 =?utf-8?B?alZqeE5sd0tnTER5RldESFJoYi9aUk5PQjQzeU0vY0xVdmF1L1l2VkY4RjNn?=
 =?utf-8?B?dCtCMTJ4bmtUR3pMZjRGUmE2bjI3UkRTV0VUQjJRTEdKRGNKdmZSMW9GZzZa?=
 =?utf-8?B?SVhUNlg1VWl4ZFNLTU1Nb0E4WW1NMmNoYllNSk5jMkZrR2F0SmxudE9jYjcy?=
 =?utf-8?B?N2Iwbm9aR2E4SmtRL043VTFNYitXVnRKRVRjSHMyZUtWcmlHdmRlRS8yLytj?=
 =?utf-8?B?TUM5Y2NmanFPQytEc1lKYm1DajRvV1hCMElSR1J1dmgwU3BPTGxISk9Pc2hB?=
 =?utf-8?B?d0hHZFJrWkZheWM3L2dkeHdOQWFsUkVnYkR1elJGTW5LcWlYSjBDLzArMkxh?=
 =?utf-8?B?ZjEwWkNCVXlIeVg2UHRmNFRibWVhN3NjZ2kxcVFWNVY4TjczTDdtU3FGK2N3?=
 =?utf-8?B?NVNoT2N1NEIyR2R6UE9MbElHQUZMSFQ0czJMTFFIZy9xZEN0U1U3L24yRFZ0?=
 =?utf-8?B?VzNZRWVrQ3FYZXNuNGVYNnRibXNYeHJWOHdQQUJkd1cyQ0Z1TFVERUVSQk1I?=
 =?utf-8?B?NHFqUVNQNmJWNUhXTFhyOU91SEw4WWpEZEM3YzBCTGF1UmU1RVlQb1E2SnVV?=
 =?utf-8?B?VEtqbStzL1NtNER6d1VhMEJMa2hrUFRsUnhxSWRFNEVFWGxDOFBnMTg5NUh4?=
 =?utf-8?B?M1h1a3E4VDRoMEt3bi8vRG5GSDVzQ2dROXFKM2toclByU2EvY2R2aHNZc0pR?=
 =?utf-8?B?cWsydjhYUWE3YXh5VjFyeWxuNlIwd1YxSkcxUUFZYnFySjJXOUE0dFM2Nm9y?=
 =?utf-8?Q?42nXjocI6uXhg9f5xFRwbByROBYJcMwvJ/+W5Yz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022d5b49-9608-430c-5dfe-08dd45e4a38b
X-MS-Exchange-CrossTenant-AuthSource: PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 12:57:25.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9655


On 2025/2/5 18:06, Uwe Kleine-König wrote:
> Hello Chen,
>
> I was tempted to apply this patch while reading throug it until nearly
> the end ...
>
> On Wed, Feb 05, 2025 at 03:01:13PM +0800, Chen Wang wrote:
>> [...]
>> +static int pwm_sg2042_probe(struct platform_device *pdev)
>> +{
>> [...]
>> +	rst = devm_reset_control_get_optional_shared_deasserted(dev, NULL);
>> +	if (IS_ERR(rst))
>> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
>> +
>> +	chip->ops = &pwm_sg2042_ops;
>> +	chip->atomic = true;
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret < 0) {
>> +		reset_control_assert(rst);
> This is wrong (well, or unneeded). With
> devm_reset_control_get_optional_shared_deasserted() the devm cleanup
> cares for reasserting the reset.
>
>> +		return dev_err_probe(dev, ret, "Failed to register PWM chip\n");
>> +	}
>> +
>> +	return 0;
>> +}
> If you want I can apply and squash the following in:
>
> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> index ce8cf8af3402..ff4639d849ce 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -174,10 +174,8 @@ static int pwm_sg2042_probe(struct platform_device *pdev)
>   	chip->atomic = true;
>   
>   	ret = devm_pwmchip_add(dev, chip);
> -	if (ret < 0) {
> -		reset_control_assert(rst);
> +	if (ret < 0)
>   		return dev_err_probe(dev, ret, "Failed to register PWM chip\n");
> -	}
>   
>   	return 0;
>   }
>
> ack?
>
> Best regards
> Uwe

Ack.

Thanks,

Chen



