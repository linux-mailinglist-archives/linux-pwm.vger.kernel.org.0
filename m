Return-Path: <linux-pwm+bounces-4699-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650E2A18DF9
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 09:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1BE3AC32B
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 08:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185B120FA81;
	Wed, 22 Jan 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hB8z8WQT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E551F76BB;
	Wed, 22 Jan 2025 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536323; cv=fail; b=H70//iH1cDP8EIHknPyuthFTvtYsp4yVPA4EWPt9XPkrZwVNp7WAfzaA2LnLFPwOq5PoR12ENBxe2hRHTAxuwhX1GgJbV/MHzRmrRELPI33g+il3h1bXzDsMM3ixIFM2g1Tuys8IQ97gQFgbKVf1+lNfYunTTatTumKJ9nAvZFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536323; c=relaxed/simple;
	bh=mdcMH0FpbcaOqfcDKhzlWAVm7r5hGzGi6lgk7TT4V0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVNQ4Jqvz/mMaCd1ftGvJ05rBCW5utIVLdi1G7KxLH3UYNxouKJnzXpjwQRxNRQkRnYLqHVrBlB18WrECuURODBTSmfuqNZRTC1vH4PgS3dUPFdwvzA8a34Hu75R50lN7DzziiSAPSevIofOtHh4L17FTTS3GRGeMqAJf4A/EqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hB8z8WQT; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT6ERiWCyFD3B0+pCRfOFflCHwe2WnW+4j2XMnHWOMWjGWJk6kPJqx+x88XBcOvMYaYyK4vVyRWwr336YynC+tP+P/qKiWqxxHaG/goKgwq0ulGo82WWJK1Ywp7sEeaucIloy+FlYtwZcUnaNawgAr+P95qibd7CFdHp8bEyS5H0GftNgohOPR3PoZmX5v60JJok0Y2aE2duo4O1Z1+3ipvSCwyNrMjW2m8azkpZjJ+jHmwOLmUc8KiJ2q5Uvzn2gtfHUCgYIDiBzaDrQdMAhyVO5Ir+AzMIoVZDlvAZOjEHS+2I0+s47yZoelZglS0l2ku7XnmPSjeXFRWOYPmE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AATuoNmRU0HKHVADjFuYGVSJd3FsL/1SVUHRHUj2wMk=;
 b=RfhOFs7Dur/MPcdaw5WvrTDE5n+1N5KaSaHAOsgRQwz3LUbklzNbCHyLI/VEt8HOP3Cuh2lE9eYpTq8+joiDCTQ/vejS9/iVrt1jeAHxKvW96UE22IRgyf/ziZm+Bulc5uITgK90hAvBc/AiiqbxPaLEUMEpJEMHDaSP3QdhRqboyhBYgjyAa1WtlkpShlDBks0HCqCAFjOHKUi7KCX8ra+T0ZBHiYnhCi4fagz4AaBvyQJA2ToZKoe5gU18dERD85DvAdkGH9Ag2LFhg0ytpxV0uFUNrTiCWTt/MJny4F98L0JIk3moGfllBDui8PZlFHPgUdd4WA5drz+dApwW9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AATuoNmRU0HKHVADjFuYGVSJd3FsL/1SVUHRHUj2wMk=;
 b=hB8z8WQT2lia6R+aO6RTsoxafcRd1lp5eJHKUa5NF0l7QmygUlTK+7WgK4EM4+4+F4gw3k4mEDMmSLvwK+YSARLfj8ZTBKhO6UQGBz9MES5gb4DW4c8g+bHNvE5ZGfqnYV2S1ZPShY4bl9uYFv0IszSkzne0xyIN4dw4ycwfXC1sgdh45dRR5RI2Pn4S1AdaZxvGx5wYu+OxO/yl/3GFG8FfvPsYkH25pYyKKL1i0/ej7n40pHEe0tK83T8CfNvt5z+BrXEFSk9tHFdmylXIpUsqJaixILUIzIUxb1UK1BytP97Eft20dOA1DM/tAMWccrtpEFLVMCYm4bgk/dSiyA==
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:44::15)
 by PN0PR01MB5467.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:68::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Wed, 22 Jan
 2025 08:58:32 +0000
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869]) by BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 08:58:32 +0000
Message-ID:
 <BM1PR01MB2545319120D9B3932C8C8806FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 22 Jan 2025 16:58:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Chen Wang <unicornxw@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com,
 Sean Young <sean@mess.org>
References: <cover.1733281657.git.unicorn_wang@outlook.com>
 <4a7db3ecac9ac2b00c063360334834d6656672e3.1733281657.git.unicorn_wang@outlook.com>
 <e2we4klv7w234zyc4vnbcydieyhcte63sdwcp43vmolmlasv5f@scsiepnnw3db>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <e2we4klv7w234zyc4vnbcydieyhcte63sdwcp43vmolmlasv5f@scsiepnnw3db>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::10) To BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:44::15)
X-Microsoft-Original-Message-ID:
 <4207d7bf-0036-4f5a-a32a-6e8756c168dd@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB2545:EE_|PN0PR01MB5467:EE_
X-MS-Office365-Filtering-Correlation-Id: cad2f68d-4719-4708-827f-08dd3ac2f259
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6dEoOZOj4tPAZubvlSTC8VXvKc2gWm/IHEhe+tzzAhTrVv3tdYI/+VSUWvtcModyGTrsBetD7SYHBqGkyLg/3xg+VlItdLZIIH+l7LN9zqiSOEvgSkRfwD1BauXE3SzB7njRgJbn0WljvetFziOCxegAhwwFA3vTOGYN962X/bjQI2UIooNpyTLuA3dGw6szDkaqtVD9c4EWnNBQB8XS91ep9fkEnoBwdwIJH4ztIIcvCd+gzgNn6+cvXcktXvJKT676kD2XhrJ0YIVw5SKMZGGGlKKOIhHiPq41M3LQj7QEPQmD/vaWsHLiN6vYjfHGDz/5890D0teMBC4zN18VUebAZFlKrruzTt3zSZD96c83DEz4hBuCSEww3QMmqS4iHn5wm2m7oBOrOMiaEQ7XOPl3by7O0ar4b560erbVIfEDfRb6R/At7BdqzFLf4j0GE/FUvS1IgyGVPuLigxLKG/jR07VFgpu7ZTJcBCLmQFn9HyR7I6ahTYhKJGHd8Bt5xDsRrcqvlHMUQiXPaQx0wzLsvyOZW6xep/9mVs+XyzrESLI4d12TmX2NqCbAVS0NNhP+BviF8F4gzzGAwg+us1xNpGcIGFuLuqndAkeb+6brgrau7wbqSFJoojET4cB4+g5DoDUk0mjDhe+l6ZJtLDDyHdEE8eSYBeLU+NRdCoWLULW47g973udYrE40Vv4N3N/zIq7nSK+41F+zykXOvz/8LFOCAKgOypq8jpLn0Uoe3RacJNKLVFvQmJnUyBD3Kc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|8060799006|15080799006|5072599009|6090799003|461199028|19110799003|440099028|3412199025|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWlHWWNqZmVMNytWUUk3MTk0R09RMjd4RVAyTGRhUzMrQjZCWWlDTENhRnFI?=
 =?utf-8?B?QTJrRUl5NFRKUGc1VnlPQUZHck1PS0JybnR3ckZvTHlkQkkyRlBWendSZDkv?=
 =?utf-8?B?Y2l5N0Q5OWhMSWpuRXQvVDUvcXcvNnRUNmZVWnh3dXBrR2FKMVdxanBwbjRN?=
 =?utf-8?B?ZTl1QkNpTGFoVnZGaCttcUxNMEsyWHk2aVl5QjdUYytjbGhQcU1vRHpnenc1?=
 =?utf-8?B?eG5DZ0xEQ2UySWIwSTZSeXFIekpZV3ppUkI3MVU0R2dlekF5ekZVRnVSajUy?=
 =?utf-8?B?c2VqNU56S1puN3h6bXJSeXhWRnZvMi8wNzdQZlQwZzFtbkQ2VTNwQS8yY0Zw?=
 =?utf-8?B?UGdXRlFpekVONmpXWU4rOGZEb2c3VEtLS213M0FONll1OTlFcy8yY3JpaDdy?=
 =?utf-8?B?VUltM0x6QythMDAvZzVCTXFZS3RuMUtzbS9VcmhWRi8veE5XVHBEYUlhQUZk?=
 =?utf-8?B?WjM0OThyQkpSaldmYndkL2d4Kys3WkZpb3BobGhxQS8yWFBQNU5XUUNCYzZN?=
 =?utf-8?B?bXZMRjhCNjNSdm5RVVB3UGpIUWRON2wramNPaDJuV3N0Q1MrYnBEQU5qM2pa?=
 =?utf-8?B?OEovWU8yc2dTRFlIK3d0RjY4TVNmZXd3RjR6Z1lKSG1rODdHWGkvbkFyaWNr?=
 =?utf-8?B?RnQ5cmlSSjBUa1dTbS9qYXU2VTRibFRzaDlRc282RjhRd3BORE5wRzlmVDZ4?=
 =?utf-8?B?NkdXM1gwN3N5ZUxmNkZjOVg1QnFvN0JqVXkwM2NwMU1pMWhyVFdROFA5UC9T?=
 =?utf-8?B?WTdaTDEzcTRpaTdzRzRkemFmb3hxZFdhVkxBWjNHRUVQWklBWVZXMnRySkdP?=
 =?utf-8?B?ekhDcWhmWkNPYW5GcDZqZlRYNmVzb0llUXJrOFV6cFhHR1RJZlpsa2ZKV1RW?=
 =?utf-8?B?a256bGVvZEFOb3hqTDNqMlRzVENFY0FJRy9RUGsxWitydUJGTU53RTlpVzFj?=
 =?utf-8?B?T3d4OHRBNWR5T0J0K2h6SzJEZy9UMzlSWjhqMEsvOTE3NERiZzRVNUpzbVVz?=
 =?utf-8?B?V25kbG11SWp1ejA0N2ZaYWNkNVo4U2ZOR2NoOHZoR0NnNExtcmpmOFBhdlBn?=
 =?utf-8?B?Y1Q5Q2l6WnNSMjd3UzgybXNvdFVTalN0dmNTOXc0Y1FCWEVxempMVms0L2ho?=
 =?utf-8?B?Wit5RkV4eVBPbjdQQzJDdkJFbWlnaUhrTkVyYkxjVGJVVzFHZjl6dEZHVUtu?=
 =?utf-8?B?QnVOd2EydTNtVXN5S0xNcXhnVkVsTFpYcEV5MVJ2QTAxbjJLZjRQd1dPbVU1?=
 =?utf-8?B?N3licW00OGd3aUxPV2piSCthcXZQK3JnWmFGWXhoeEl4VDI1T3Zsem1YdE02?=
 =?utf-8?B?djNrTlJUckxCeWFuNlFMdFlpd3lzTDJrUVMyeW1ZMnhoVTRVRHVtelVYNEtw?=
 =?utf-8?B?TWVwWU50MjlLTGdKUExaN0o2THJBMVFsdTBoRUNGbWw5OXdHSm5tOHBUaVFI?=
 =?utf-8?B?ZXBFdW9LN3JXeVRpMjVYclNCL3M1bGxaVUl6cnNXRllZWGcyZDNjQi8rY0tZ?=
 =?utf-8?B?VmIydU4xbmpHTWk4U05nVjlZSVRYV2hucWhkNEVOalpXTnNORHEySzArTVNq?=
 =?utf-8?Q?5oGI3bOK879iArdjwW+xD8PZQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHRnTG04THl3Y01SNnc2eXNaWkYwU1VlelEyclBvKzI1eDlqcTRoRzM4V0ZO?=
 =?utf-8?B?WWlFWW14RHZOVUR3ME5naXVUbkVZb2EyYWhIRnQvS1NodVVyMm5tSjdYQmFS?=
 =?utf-8?B?bXhQc2h1bmhRd0FLbzZuREprYXNQM2QxQm5pRzB0QUpQQ0VPc2hDQWJwYkR2?=
 =?utf-8?B?VHBoWnY2c0doSTIzQzRNOVJSbHF3SHROZjRDakFoNUV0cHBib01uVnY1cFBY?=
 =?utf-8?B?cEtGU0xGOWViZFhiSmVkTVBWS1g2M2RtazlmVEdHZFpseTE3SXlrNnVCelMy?=
 =?utf-8?B?WDFiNXRFbFplUzVydERxRlN1YkdNcGxMdEhMeXZROVdrWnd4UGZITzQwOUJl?=
 =?utf-8?B?elh1eHdXeU9uUEhFWkpwWTd2REUzajF0K3hZc2ZDWHllYkR1Wkc2NEtMUndF?=
 =?utf-8?B?aUFwSlp5ZjlMWWxCMHE5djhYVk5QYVU1TWhwQVZzTWpBazN6dTNSZmM3cHp4?=
 =?utf-8?B?bE9VYVN2ZmU1QzFUTUc4Vzd0ZE5XTjNsVWtPSUVxVXRRRWJ6dkZDazhDQWxV?=
 =?utf-8?B?OC9pY0o4YlNtanlzeTUvWUw1c2JXRWR6YU9GWHkwR2FCUGF5ZjFNbUJ5R3ox?=
 =?utf-8?B?U3Jud0Y3eElnQWUycTYrb2dlQ0JEZmIwN3ZrVitNT2tnQytKWVZMb3RmeTFv?=
 =?utf-8?B?UE13a0tVUEZvaExhUmdzWjJUMThMWG04TEpTSVZiblhCcDZBMlpGUjJyeFFw?=
 =?utf-8?B?RXEyNVZ1am5WRnE0ZW5hSkF2Y3N6TCt5bU9XR0FmU2dUVlN1ejJpUjhGS1Ji?=
 =?utf-8?B?N0I3N1g0aXcxZXc4UEFFK0kxUU8rOHJidStxQ0tuellmaU5jWDZQdlVPWUlN?=
 =?utf-8?B?UUpEMW51Ry9oUWVSZEFUdG9mbis5b3htajRsU2tVRUZGK1poRkNSWWt4aGVv?=
 =?utf-8?B?K09nanhVcDNIdml2SStwZnZLU0JEZGFrUXhkZm1RdzFIK1lzcVRiQjlhNzlw?=
 =?utf-8?B?eEYzMkZOdGhRNmYxczE0VzRGS1B2VUhCbUlNSmg5aUFoM3BuY1dkNlN3dlBV?=
 =?utf-8?B?Q0w3K2JuRitsN1dJcnZTUkI3NHBYZXE1LzZvdEF0MlFQUDU3b25LUmV0eEZs?=
 =?utf-8?B?TmlVdDJsZTQzdy9Zc0VRTFdhbFQ4b0RwVTZ4Vm45TVl0UlZjMGN3YzB3NVZ0?=
 =?utf-8?B?QWZFYk0vWlZyWkNVd1ZuMEcyN2Znb0hxYnVjWlVpVEtBOFdPbUVBK1FpekEv?=
 =?utf-8?B?VU9BeUVzT3ZTb3l3bDgyQWI0N2hBdThUbHAvOVZCVWJCSlVqcngxK3B4Q1Q0?=
 =?utf-8?B?S3B1ZDNHZ3ZnREZZekJxM1dlRlpva3BZL05QV000N3RzWGRJT21vUVZhYm5L?=
 =?utf-8?B?T1NBWkN3Z0dIcTFxQVN5elVEMzRsbWNibEtwSkhqSjJtZThna3N6N0s3V1Nl?=
 =?utf-8?B?V1ZKTVRCbjBqcjQxVmo2eEx6MWFySDBYZEhMc3JVT0ZnaGdOQ3Fsam5CNmtB?=
 =?utf-8?B?dzlvUXUrbWlKRDR0ZG5Db1pHSk8vdE9LaVJ3MngwcVNSOTdFOGJaWE9UZnor?=
 =?utf-8?B?ZTVJTjRUUzJ0SjBkZFZCNFJkWHFPUEdDY0pEalBJejEvQXZtYkJJSzd0dmMw?=
 =?utf-8?B?S2FOQTl3M04xcVdzUjF3Z3JNUkR6UWI2VklxY044ZjhKdkxyb0o0OHpoRkpa?=
 =?utf-8?B?Ym9GYWlFeUErNzFRY0JOMlNzelk4OVBkNUY1SzJvck5NTUtxNlNyU2s0S3kw?=
 =?utf-8?B?RUJHMXJLN0duUlQxZVl3Y1J0WGNSbU9vWjFxQkozYlpLNkxJOTluL3prUWlK?=
 =?utf-8?Q?kzpvlNUpieIEGMFm5qvuiV/g1FP66agKwO8r0Ph?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad2f68d-4719-4708-827f-08dd3ac2f259
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 08:58:32.7504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5467


On 2025/1/21 19:14, Uwe Kleine-König wrote:
> On Wed, Dec 04, 2024 at 11:17:18AM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add a PWM driver for PWM controller in Sophgo SG2042 SoC.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> Signed-off-by: Sean Young <sean@mess.org>
>> ---
>>   drivers/pwm/Kconfig             |  10 ++
>>   drivers/pwm/Makefile            |   1 +
>>   drivers/pwm/pwm-sophgo-sg2042.c | 194 ++++++++++++++++++++++++++++++++
>>   3 files changed, 205 insertions(+)
>>   create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
[......]
>> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
>> new file mode 100644
>> index 000000000000..a3d12505e4aa
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Sophgo SG2042 PWM Controller Driver
>> + *
>> + * Copyright (C) 2024 Sophgo Technology Inc.
>> + * Copyright (C) 2024 Chen Wang <unicorn_wang@outlook.com>
>> + *
>> + * Limitations:
>> + * - After reset, the output of the PWM channel is always high.
>> + *   The value of HLPERIOD/PERIOD is 0.
>> + * - When HLPERIOD or PERIOD is reconfigured, PWM will start to
>> + *   output waveforms with the new configuration after completing
>> + *   the running period.
>> + * - When PERIOD and HLPERIOD is set to 0, the PWM wave output will
>> + *   be stopped and the output is pulled to high.
> Maybe I already asked: If there is a public manual for this chip, please
> add a link to it here.
There is a TRM on line, I will add the link here in next version.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/reset.h>
>> +
>> +#include <asm/div64.h>
> The canonical include for that is <linux/math64.h>. This is also the
> header that defines mul_u64_u64_div_u64(). Your driver seems to compile
> only because clk.h includes math64.h via <linux/notifier.h> ->
> <linux/srcu.h> -> <linux/workqueue.h> -> <linux/timer.h> ->
> <linux/ktime.h> -> <linux/jiffies.h> -> <linux/math64.h>.
Thanks, I will correct this.
>> +/*
>> + * Offset RegisterName
>> + * 0x0000 HLPERIOD0
>> + * 0x0004 PERIOD0
>> + * 0x0008 HLPERIOD1
>> + * 0x000C PERIOD1
>> + * 0x0010 HLPERIOD2
>> + * 0x0014 PERIOD2
>> + * 0x0018 HLPERIOD3
>> + * 0x001C PERIOD3
>> + * Four groups and every group is composed of HLPERIOD & PERIOD
>> + */
>> +#define SG2042_HLPERIOD(chan) ((chan) * 8 + 0)
>> +#define SG2042_PERIOD(chan) ((chan) * 8 + 4)
> s/SG2042_/SG2042_PWM_/ to match the function prefix and driver name?
Accepted.
>> +
>> +#define SG2042_PWM_CHANNELNUM	4
>> +
>> +/**
>> + * struct sg2042_pwm_ddata - private driver data
>> + * @base:		base address of mapped PWM registers
>> + * @clk_rate_hz:	rate of base clock in HZ
>> + */
>> +struct sg2042_pwm_ddata {
>> +	void __iomem *base;
>> +	unsigned long clk_rate_hz;
>> +};
>> +
>> +static void pwm_sg2042_config(void __iomem *base, unsigned int chan, u32 period, u32 hlperiod)
> Maybe pass ddata here instead of base and add
>
> 	void __iomem *base = ddata->base;
>
> to the function body. Then the calls simplify from
>
> 	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);
>
> to
>
> 	pwm_sg2042_config(ddata, pwm->hwpwm, period, hlperiod);
>
> .

ok

>> +{
>> +	writel(period, base + SG2042_PERIOD(chan));
>> +	writel(hlperiod, base + SG2042_HLPERIOD(chan));
>> +}
>> +
>> +static int pwm_sg2042_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			    const struct pwm_state *state)
>> +{
>> +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
>> +	u32 hlperiod;
>> +	u32 period;
> state->period is measured in ns, the local variable period however
> holds a value measured in clock ticks. To make this still clearer than
> it already is, I suggest to rename the variable to period_ticks. Ditto
> for hlperiod.
Agree, changing the name would indeed make it clearer
>> +	if (state->polarity == PWM_POLARITY_INVERSED)
>> +		return -EINVAL;
>> +
>> +	if (!state->enabled) {
>> +		pwm_sg2042_config(ddata->base, pwm->hwpwm, 0, 0);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Period of High level (duty_cycle) = HLPERIOD x Period_clk
>> +	 * Period of One Cycle (period) = PERIOD x Period_clk
> s/Period/Duration/ ? What is Period_clk?
Period_clk is period of the input clock, i.e. 1/(ddata->clk_rate_hz).
>
>> +	 */
>> +	period = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->period, NSEC_PER_SEC), U32_MAX);
>> +	hlperiod = min(mul_u64_u64_div_u64(ddata->clk_rate_hz, state->duty_cycle, NSEC_PER_SEC), U32_MAX);
>> +
>> +	if (hlperiod > period) {
>> +		dev_err(pwmchip_parent(chip), "period < hlperiod, failed to apply current setting\n");
>> +		return -EINVAL;
> No need to check for that, .apply() is only called with
> state->duty_cycle <= state->period.
ok.
>> +	}
>> +
>> +	dev_dbg(pwmchip_parent(chip), "chan[%u]: period=%u, hlperiod=%u\n",
>> +		pwm->hwpwm, period, hlperiod);
>> +
>> +	pwm_sg2042_config(ddata->base, pwm->hwpwm, period, hlperiod);
>> +
>> +	return 0;
>> +}
>> +
>> +static int pwm_sg2042_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +				struct pwm_state *state)
>> +{
>> +	struct sg2042_pwm_ddata *ddata = pwmchip_get_drvdata(chip);
>> +	unsigned int chan = pwm->hwpwm;
>> +	u32 hlperiod;
>> +	u32 period;
>> +
>> +	period = readl(ddata->base + SG2042_PERIOD(chan));
>> +	hlperiod = readl(ddata->base + SG2042_HLPERIOD(chan));
>> +
>> +	if (!period && !hlperiod)
>> +		state->enabled = false;
>> +	else
>> +		state->enabled = true;
> What happens if hlperiod > period? Isn't period==0 enough for
> state->enabled = false? Also if period==0 there is no use in determining
> state->period and state->duty_cycle.
>
> So I would expect here:
>
> 	period_ticks = readl(ddata->base + SG2042_PERIOD(chan));
> 	hlperiod_ticks = readl(ddata->base + SG2042_HLPERIOD(chan));
>
> 	if (!period_ticks) {
> 		state->enabled = false;
> 		return 0;
> 	}
>
> 	if (hlperiod_ticks > period_ticks)
> 		hlperiod_ticks = period_ticks;
>
> 	state->enabled = true;
> 	state->period = DIV_ROUND_UP_ULL((u64)period_ticks * NSEC_PER_SEC, ddata->clk_rate_hz);
> 	state->duty_cycle = DIV_ROUND_UP_ULL((u64)hlperiod_ticks * NSEC_PER_SEC, ddata->clk_rate_hz);
> 	state->polarity = PWM_POLARITY_NORMAL;
Thanks, I will improve this.
>> +	state->period = DIV_ROUND_UP_ULL((u64)period * NSEC_PER_SEC, ddata->clk_rate_hz);
>> +	state->duty_cycle = DIV_ROUND_UP_ULL((u64)hlperiod * NSEC_PER_SEC, ddata->clk_rate_hz);
>> +
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct pwm_ops pwm_sg2042_ops = {
>> +	.apply = pwm_sg2042_apply,
>> +	.get_state = pwm_sg2042_get_state,
>> +};
>> +
>> +static const struct of_device_id sg2042_pwm_ids[] = {
>> +	{ .compatible = "sophgo,sg2042-pwm" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, sg2042_pwm_ids);
>> +
>> +static int pwm_sg2042_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct sg2042_pwm_ddata *ddata;
>> +	struct reset_control *rst;
>> +	struct pwm_chip *chip;
>> +	struct clk *clk;
>> +	int ret;
>> +
>> +	chip = devm_pwmchip_alloc(dev, SG2042_PWM_CHANNELNUM, sizeof(*ddata));
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +	ddata = pwmchip_get_drvdata(chip);
>> +
>> +	ddata->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(ddata->base))
>> +		return PTR_ERR(ddata->base);
>> +
>> +	clk = devm_clk_get_enabled(dev, "apb");
>> +	if (IS_ERR(clk))
>> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get base clk\n");
> I like error messages to start consistently with a capital letter.
ok.
>
>> +	ret = devm_clk_rate_exclusive_get(dev, clk);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
>> +
>> +	ddata->clk_rate_hz = clk_get_rate(clk);
>> +	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
> Please add a comment about why you check for > NSEC_PER_SEC.
Seems no need to check this (> NSEC_PER_SEC ), I will remove it in next 
version.
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
>> +
>> +	rst = devm_reset_control_get_optional_shared(dev, NULL);
>> +	if (IS_ERR(rst))
>> +		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset\n");
>> +
>> +	/* Deassert reset */
>> +	ret = reset_control_deassert(rst);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "failed to deassert\n");
> There is devm_reset_control_get_optional_shared_deasserted() that does
> the two calls devm_reset_control_get_optional_shared() and
> reset_control_deassert() together and also cares for reasserting the
> reset at remove time.
ok, I will check this out in next version.
>> +	chip->ops = &pwm_sg2042_ops;
>> +	chip->atomic = true;
>> +
>> +	ret = devm_pwmchip_add(dev, chip);
>> +	if (ret < 0) {
>> +		reset_control_assert(rst);
>> +		return dev_err_probe(dev, ret, "failed to register PWM chip\n");
>> +	}
>> +
>> +	return 0;
>> +}
> Best regards
> Uwe

Thanks,

Chen.



