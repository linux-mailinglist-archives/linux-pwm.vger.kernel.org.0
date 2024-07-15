Return-Path: <linux-pwm+bounces-2809-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647259313EF
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 14:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9F2B225CA
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 12:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FFD18C170;
	Mon, 15 Jul 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="aKq+uEi3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023078.outbound.protection.outlook.com [52.101.67.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B618A958;
	Mon, 15 Jul 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045786; cv=fail; b=rd2YsjRpgmViF6eN5VLXSE5PRWwvOXNwU6NkmwxUmQkBevtUHo40QjbThMx1m+fqG3S6h4IzHQSAjhrLKQMFuovb9jaoLtHWB6moDaBA1rmogETAgV5OEwqKS7y60cgeCJmeif7Wq0xJo3PHwmC/v5xt4kOhr0MBo8xmpNT2W8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045786; c=relaxed/simple;
	bh=eDnb3mJdPHWRaX+if1l+dkLZSHwjZBeES9aPEKt18MY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Woqtd2cteGz3f4c72+4/boTHGpXyKS3nqv2RK2VfvcW8F52+ULqz9Xhg08ne95RLqi32NKr+jjuDNYxO2GhoKOEDI1rPaDZGImpLDCKFFQks6pNWEsdxaExIguutQ29jac0hlib7W4fTBNXzcwKTf0kCXXghsLNHImVhE9L2euA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=aKq+uEi3; arc=fail smtp.client-ip=52.101.67.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0sMaTJVuWrQIrzf86jTZAru6czJVYpcxeR+z+mUT4o5t8Nss1g/6p+eBpMDDVUP9Jrb+D/qFGZ6aU4k8QmpNsQIzkaKz47p8cmKHnPS2MMD9FjHn00zgPZVaYUUbLnkNqqzD/OPvWrsahFfSitRcY1S0/c5Sf0Me7RxUiH20KEE5KX7ZAqrWodUTBcM4ZHhMfC2+MDdy5EC8eOvKEUKYsTotSlFLHhiPoK8KamBMWKxkrqhjV+WmQt67ECPgU/X5WW8LBEQSaECliLSetMuucm2JeyiYYpDRxnzjTXmtVajUAgcsCGWkz5mpnNvg6C7s9mmoFOnS8VZRzYPb5xNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5/MsOuy3b9Gj58B26OOxutibU0qaiIUEWMHKo41Aoc=;
 b=jC7bkeNtxQP6FEhlVyTLJYkGiyZgCMnlW4MS66abP/BwJjbyYnMNAKlLoBtqM04KdHfcwMe8d+g+TdHt3Re4g17Sb3ZYydqyxkp54orKH64l61+NfNYQHCQKBEcQSK/yZq/kX9moTrQqDp/ItLSf093S7kwFSZVf7p6VV8kQvGLvqOEdq6odcmVvVMjieHTa/8eFWh9q01cf4ulFhoHiPPRKO2izhc0m38PRSKUOz5vJckWOQPZNWnlT7avuL0f2DAsEPoFKZXZKjlas8Q6xYIISjUxVMJXApajLyKxDNCCO7b4qXpH3S4VNLRC5/9ZF8kk5h4wfVX01v58HzlwS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5/MsOuy3b9Gj58B26OOxutibU0qaiIUEWMHKo41Aoc=;
 b=aKq+uEi3qW17u1H5lV6d7SiZovAyY0E131IOopG9jPYDAHwh9Nxl8pMbIQUYIOXMaEZnH+tfvgP3gQpCn22ehZZDuDnW6KujQ1rHcKFle+68yiC8xTBZ7jrD24AgtJRkOz7Jx5F0JONckCK4KfN6ZtugjbiZdzMRdcc1w0w0cgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB7426.eurprd04.prod.outlook.com (2603:10a6:20b:1d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 12:16:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 12:16:17 +0000
Message-ID: <25d71c19-6e94-477d-8d04-758015ca4b2c@cherry.de>
Date: Mon, 15 Jul 2024 14:16:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] pwm: add mule pwm-over-i2c driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Farouk Bouabid <farouk.bouabid@cherry.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
 <20240529-buzzer_support-v1-2-fd3eb0a24442@cherry.de>
 <5hd7fndgivgusx76wq6mbvgefngd3tllqsfsk6pppbphchczte@ujagkep4miet>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <5hd7fndgivgusx76wq6mbvgefngd3tllqsfsk6pppbphchczte@ujagkep4miet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA0P291CA0011.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e734ab8-3b01-4a9b-a4df-08dca4c7ed80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm5HMFZ5YVJURW5yUWovSGxMdnVNekxjLzNuNDd3N0ZzZkY2bk1RVit5WUs1?=
 =?utf-8?B?aVRzOEIyODhWSWFhRHI0TnZvRnBuSnA0M2FJZEFJbTZLVTk3cndOT3dYYjlV?=
 =?utf-8?B?dDVZb0FyVGgvSW5jSlpuNk9Fb1YxN1dDV1pCK0V3SEFVUjNMSnFjWGdGTjE2?=
 =?utf-8?B?VkRLVWc4cGZ0eTQwUlI5SFJMNUp4OVJ6b2IvL2RBSHBtSHcrRE9XbzFKNzBz?=
 =?utf-8?B?WkdDRUpsNXVzVjJaaFNBSnJXUUltRDJWSEVPcVpzRWVvSEZRL3BsY0x0bDl3?=
 =?utf-8?B?TlFSb29wN3pGYVp3bXlKaUkra2paOVFPb3JrS3ptWlBsRU5Db1pTRjB3Ymlr?=
 =?utf-8?B?eUhFNnBxK1l3TXJ5cklSYVhWcHBlbmFKaTVHZmo1K2RtL0s2QVIxbmNFZlU5?=
 =?utf-8?B?cy91UDZuWkVWWnE4RGhzRllZblVsTmc2UzU4a3VBQjluWHJMeFp5RStxdXB0?=
 =?utf-8?B?RUVLZVZhWW0zN0FmdVFaVnZ5OFNFU0tCSWhDU1NONFlaTVRGSmNyVFVRYnYv?=
 =?utf-8?B?d1p2cmp5d0x4Q1VMZURydW1aalY5bWhGM3Z1NUhJN3lodkZWOWo2K2p3YjZ5?=
 =?utf-8?B?VFRPM2N5Rm9jL3VubWl1U3BZWUR4MVppTUNvMDRsMklLeVVrcEN0TGNiYmZo?=
 =?utf-8?B?bHVsdGFJS3YreWloY3ZWNTZ1YVVqeGMzeDNpeXpNcGt2cHY5QzVBMkhtVmtu?=
 =?utf-8?B?Mmd3ZysvVG5SVllhOUtFRjhFY0dYZHNGUGZab1pJdDZuOHZuS1BXR3U4MFFp?=
 =?utf-8?B?Nm5PMHczUS9kYVR1U1B6enRBZmtQbTZRdFB0cUdIRzhkNTVUOHlHNStuRERU?=
 =?utf-8?B?Q1pJWUpQWndYcnRldmF2VTlTa3UwQS9hdFpYTyt4eEJKRzRXdDgrOFBoeElK?=
 =?utf-8?B?bzM2cTVPQ2JlZ0toUTZWZG9kdzZ6NXlCZXJPUVpWSC9WQlRYaXM0RkdaclFa?=
 =?utf-8?B?d2lMSi8yajR0dXpkNW1JWG1IWkVhUC83dUp0MUtraVNqSEVBWU9OYmtCWFlO?=
 =?utf-8?B?L1ZGRUdoMk5DNDZVYUNPd2JiUTBXeHBIdnlyMlBlbFBJYjdraFpNaDczc2dS?=
 =?utf-8?B?THYrbysycnJvZkJGbFdEcXU1dERQelBaZzlPOUxEMGNWY2FpbUpxU2pndGtv?=
 =?utf-8?B?WjR0QkdNbGRwWTBGUmVkQWdHK3JlTFVBZFJpZ0JwbjYyenJmL3Q4ZlFTdzY4?=
 =?utf-8?B?UlFvblFWOGhIMm9kNnlIbEtQaE8vR3EzbkFQcFpyRW1HVXo3Y29WZzdXK0lH?=
 =?utf-8?B?NHA5aWdDcFBCVjNXTDJ5MEJiTmpDUzArU1ZrbmdmUmxvbDVCamsyME9SSW5W?=
 =?utf-8?B?T3lkL0xqY2VMT29lR0ZTVHhXY2JaR0xDaGIyNzJ5cStFK3EwTjI1Y3NBZDVt?=
 =?utf-8?B?SG5SeDk4MktRelNGd1lHVTdSTUFzV0VhTXFIa3hMOEdFd1VlMW5aeEdqWUFD?=
 =?utf-8?B?TGx6TmVRZUZvTGJPSjlXelZ6Qk1IM001eVF1aDg4U2ZPNHpzeDNCSytpVURM?=
 =?utf-8?B?Y3RTb0E0T0s1YkFGUHlnMHhCMHRUeGkrbTMxRUZUK3I2OU50Q2VqWHFaQUdu?=
 =?utf-8?B?YTVyejlHN2JMUXNwc2Ivc1dIN1pDSVFpVm1xKytFSnhYek1DbWs2ejZaWUcx?=
 =?utf-8?B?UFVQRWJwNGxvei8zVmFUK080WFFZc1FTSjZ4YXVPbEdpVUxvTDJpaXNHQTcw?=
 =?utf-8?B?Y1I2V2loQnNWcDU4V0gzVU1yRy9nb3QxT1dZRzFpVmdmTjU2dnowb1FFYkFY?=
 =?utf-8?Q?jJ47SPJnIxxGtyM3H4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlNkcG50eTl3dUpoazF6dTgvdjc5blBHZnlwNUdJSjgrN1FXTm13NGZnbE1R?=
 =?utf-8?B?VGRMYUJvR1pCUVAzNWNGSkpjY1MxQ2x3YTdRUUJNNUZlMVpZN1Z3NlE1bFV0?=
 =?utf-8?B?Tll3eW1LdUUvK21GRVVENzNjU0N5WDRiT3lvK1RpZTN4cnNNNHNWUkJkbi9t?=
 =?utf-8?B?ZWlPVUV4bUwwMDhHamplaUNuRVduUUhBNnhYUlF4VWlxWGhpZHJZMXFuK0ZO?=
 =?utf-8?B?ejJtaFJVdlpocjdpWDlpK3VQajlYeUxkekcwMzM4c1lyTHRvV1J2YUtENk9W?=
 =?utf-8?B?M3VEMFpCZG5UblhMMEUvSDNFMlZVOEJpcjluYzVaRXRSaURLT2VrZEJ5VzBS?=
 =?utf-8?B?ZHZkWXJzbXBwaFhxbFd5QTlyUFlKM3hGKzJncVcxSzV6ZktGcjMwd3JnbFhF?=
 =?utf-8?B?OHNiV2hEdURiM2lxMEVBL0VRZ3Q0ZE42YU1mWTJwMjJNRnRQVytsMnBDbU5W?=
 =?utf-8?B?Sy9PbXZGazRMaGdCTUE0WW1tS21QaU56MnNweFBGOWJKMTFXTXpwWDQ4ZUZU?=
 =?utf-8?B?UkJoOUQ3cjNkNE95VnhzMHQ4YmJwc0FMbFlYMDlPcTFLOWFBZDAvSU9xbElM?=
 =?utf-8?B?QllWYjNwZUFHNkVxWGoyY0d0NTNqaGU2RDlNblR2eTRtdXUwbFVGV2tTSEZl?=
 =?utf-8?B?ZkpmMVdrQXB0bXBGWHNhM1c2SHk1N01LbXNTZEZnb2ZiK3gzL3JXL09TRzFY?=
 =?utf-8?B?bytaYTRzYmtpdG4wNE82RlFkbVhzV21veHI1TStqVGE4QkMvWVNsMC9QSnZw?=
 =?utf-8?B?cFRQNUQycW03UkFiSEN1OVR6ZEI2SmdVSWluQVU4QTJPNHk1L3c5dVRoU3NP?=
 =?utf-8?B?aktjbWhzY3B0S3p0VXNwc2l0bE5kM3J6dUlMMVRpQzVIQ004NzdLZmdTb1du?=
 =?utf-8?B?MFU5eER4WVVqZzhnZ2dGWDhZb3ZtV3czb1FrYVRTV25PWkJDbHpIcExxMlJ2?=
 =?utf-8?B?aDU1TUtjVTkvdXJWUTJOQ3FFdlB2c0lwM1RtU3hON05mdW1ndXhCV21zbzJ3?=
 =?utf-8?B?dGUxUVJOUXJBNG0vOWRVRUZucTgvSTltNTJZTHZxclNKaXdZR0h6MlJmcGNH?=
 =?utf-8?B?WVpPWXE5U29ENWlSY1dvR1BYQVZrRHRKMEV1b0RGVzlFN0VjQnBXUFQ1RHFC?=
 =?utf-8?B?MGtrRTgvVTB6K0h0OEJMWThjK2pRUG5GWlJJT1N0QjJxdGFEU05sUUxpNStT?=
 =?utf-8?B?VjlRRTZTNVNoaXBUK1BHSWhSVWFRQUpSeEJlSXM4NGtEbUZoRXMzckx6Sm9S?=
 =?utf-8?B?bVRISWlJVnlPaVJnYlVzbldkaXRhczdHLzVneHRSdDc0OE1HNkIrTzc1eHFT?=
 =?utf-8?B?M1ovQk1iU1pBWXo3eGRHSWVMN2JtLzJHTlFlN1Rlclp5ZHAzVGhsblNwd0Rz?=
 =?utf-8?B?cWJtWjkyZ1Y3RXM3MHVXTGxQbVEwellDY3BwMjJEY1NHZy9pZ1VXT3RnSmRz?=
 =?utf-8?B?WkZQUTQzL0VuUml1VE12VmNkZVBLS0RJcjJjL0JOOVJNbzhlRmVYSFlkTnla?=
 =?utf-8?B?eThuN2xpbSsrY1JSeUl1YjhWWVBLcDB3RjR2U1JZSjlBa05yNW9SdU9tMGRl?=
 =?utf-8?B?cklXSVVLUTZYR25qUXA1R2hyUS9XZTRkc2dPc2J0MGJjVjFCM3VMS05jSXVo?=
 =?utf-8?B?K3BDZm1Jdm5VZWNSMThGbXhKZU5qd1dFZUU3MVFMbS9SUFVkcFdDbGFaV29o?=
 =?utf-8?B?ZVZnckdPaG13YzR5V1gzNW8rK1M5YXUydHdTeHVQaGpKYUpWTklwMUhVVDlr?=
 =?utf-8?B?K3RzNEx1NEYwZ001bzhYZmY0MzN2aC81dEhOTHpIZ0dIcVVSU3JnQ3NKV3JW?=
 =?utf-8?B?NTkvWTFHaTFjRE9LMWVJajRTNHJocUJlQkZvY1A1Zy9yY29JeHRZZHNhRndV?=
 =?utf-8?B?YlEyNlQrWjJSTk5qZ1d6OUdoT1EyNTg0aytHZnFwVHFlclRoVFlKSzg1TGFt?=
 =?utf-8?B?VXdjcGY5NVNHeEJNeHBhcS8rK3Z3VTgxWkpsbDZ4V1pwbEV6TkM1VWhHclF0?=
 =?utf-8?B?QmxXbVp5N3ljT2pmY1JwUXBta3h2ZmNScERPMGt6OXFvOUNyMHY1ek55K0JD?=
 =?utf-8?B?eWNvRHc0eXFpeGdaUGhMWDJhaE9LMEpVUlgydWZxcUs4eEpTUjkyZnZUNWk2?=
 =?utf-8?B?T29OSnVsejE3amhVMVpRUDRYNkVUVUZ1TXhLU3N4Q2FnOUVIdmFxU2xOTkpk?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e734ab8-3b01-4a9b-a4df-08dca4c7ed80
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:16:17.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+2T1QB/BIz9NEs7a8L71oGWttjF6MgBjPL5NJJGy+/6T4PJchSn/iS+JeGAAYcjn+Sigy8Ig6yt5w7M28u5wCGyM3hRygRarlF7PPLz6Yc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7426

Hi Uwe,

Answering since Farouk's on PTO.

Just to clarify, below when I say HW, I mean the actual HW, the MCU 
basically. There are two flavours of those, ATtiny816 and STM32F072CB. 
They need to be swappable, so same API. When I saw FW, I mean the 
firmware running on both MCUs (though we do have two different FW, one 
for each MCU, but they expose the same API and we expect the same 
behavior, which can be challenging).

The FW is only supposed to run on Cherry products fitted with one of 
those MCUs, we do not plan on selling them separately or releasing the 
FW for consumption in other devices. As such, there's no need on our 
side for public documentation. I'll try to answer the FW questions to 
the best of my ability though.

On 7/12/24 10:54 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, May 29, 2024 at 12:10:31PM +0200, Farouk Bouabid wrote:
>> Mule is a device that can output a PWM signal based on I2C commands.
>>
>> Add pwm driver for Mule PWM-over-I2C controller.
>>
>> Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
>> ---
>>   drivers/pwm/Kconfig    |  10 +++++
>>   drivers/pwm/Makefile   |   1 +
>>   drivers/pwm/pwm-mule.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 126 insertions(+)
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4b956d661755..eb8cfa113ec7 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -425,6 +425,16 @@ config PWM_MICROCHIP_CORE
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called pwm-microchip-core.
>>   
>> +config PWM_MULE
>> +	tristate "Mule PWM-over-I2C support"
>> +	depends on I2C && OF
> 
> It would be easy to drop the hard dependency on OF. Please do that.
> 

Just being curious here, what would be the benefit?

[...]

>> diff --git a/drivers/pwm/pwm-mule.c b/drivers/pwm/pwm-mule.c
>> new file mode 100644
>> index 000000000000..e8593a48b16e
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-mule.c
>> @@ -0,0 +1,115 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Mule PWM-over-I2C controller driver
>> + *
>> + * Copyright (C) 2024 Theobroma Systems Design und Consulting GmbH
> 
> Is there a publicly available datasheet? I guess not. (I ask because
> adding a link there to such a document would be nice.)
> 

Unfortunately no. It's also only part of our product line and there's no 
plan to start selling it standalone or selling the IP.

>> + */
>> +
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +
>> +struct mule_pwm {
>> +	struct mutex lock;
>> +	struct regmap *regmap;
>> +};
>> +
>> +static const struct regmap_config pwm_mule_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +};
>> +
>> +#define MULE_PWM_DCY_REG	0x0
>> +#define MULE_PWM_FREQ_L_REG	0x1	/* LSB register */
>> +#define MULE_PWM_FREQ_H_REG	0x2	/* MSB register */
>> +
>> +#define NANOSECONDS_TO_HZ(x) (1000000000UL/(x))
> 
> Don't introduce such a macro if you only use it once. Having the
> division in the function results in code that is easier to read (IMHO).
> 
>> +static int pwm_mule_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			      const struct pwm_state *state)
>> +{
>> +	struct mule_pwm *priv = pwmchip_get_drvdata(chip);
>> +	u8 duty_cycle;
>> +	u64 freq;
>> +	int ret;
>> +
>> +	freq = NANOSECONDS_TO_HZ(state->period);
>> +
>> +	if (freq > U16_MAX) /* Frequency is 16-bit wide */ {
>> +		dev_err(chip->dev,
>> +			"Failed to set frequency: %llu Hz: out of 16-bit range\n", freq);
>> +		return -EINVAL;
>> +	}
> 
> You're supposed to configure the biggest possible period not bigger than
> the requested period. So this should be:
> 
> 	/*
> 	 * The period is configured using a 16 bit wide register holding
> 	 * the frequency in Hz.
> 	 */
> 	unsigned int period = min_t(u64, state->period, NSEC_PER_SEC);
> 	unsigned int freq = DIV_ROUND_UP(NSEC_PER_SEC, period);
> 
> 	if (freq > U16_MAX)
> 		return -EINVAL;
> 
>> +	if (state->enabled)
>> +		duty_cycle = pwm_get_relative_duty_cycle(state, 100);
> 
> This is wrong for two reasons:
> 
>   - It uses rounding to the nearest duty_cycle, however you're supposed
>     to round down.
>   - It uses the requested period instead of the real one.
> 

I assume you want:

unsigned int real_period = ((u64) NSEC_PER_SEC * 100) / freq;

which rounds down?

> I wonder why the hardware doesn't use the whole 8 bits here.
> 

It's even a 16b register that the HW uses. I guess we just went with the 
most human-friendly API :) I believe it's something we should be able to 
change in the FW before releasing if this is something that really makes 
sense. FYI, the register stores the number of clock ticks for the signal 
to be high, once reached, put it low (or the opposite). So it's 
necessarily a fraction of the clock frequency. 100% was easy because we 
know that every clock frequency we support is a multiple of 100 so 
there's no issue around rounding for example since we definitely do not 
want to do float maths in MCUs :)

>> +	else
>> +		duty_cycle = 0;
>> +
>> +	mutex_lock(&priv->lock);
> 
> If you use the guard helper, you don't need to resort to goto for error
> handling.
> 

I would have liked a link or more precise hint at what this "guard 
helper" was, but found something myself so here it is for anyone wondering:

https://lwn.net/Articles/934679/

Had never heard of that one before, neat!

The suggested implementation would then be:

guard(mutex)(&priv->lock);

I believe.

>> +	ret = regmap_bulk_write(priv->regmap, MULE_PWM_FREQ_L_REG, &freq, 2);
>> +	if (ret) {
>> +		dev_err(chip->dev,
>> +			"Failed to set frequency: %llu Hz: %d\n", freq, ret);
>> +		goto out;
>> +	}
>> +
>> +	ret = regmap_write(priv->regmap, MULE_PWM_DCY_REG, duty_cycle);
>> +	if (ret)
>> +		dev_err(chip->dev,
>> +			"Failed to set duty cycle: %u: %d\n", duty_cycle, ret);
> 
> Please document how the hardware behaves here in a "Limitations" section
> as several other drivers do. Questions to answer include: Does it
> complete a period when the parameters are updated? Can it happen that a
> glitch is emitted while MULE_PWM_FREQ_[LH]_REG is updated but
> MULE_PWM_DCY_REG isn't yet? Maybe updating MULE_PWM_FREQ_[LH]_REG isn't
> even atomic? "Doesn't support disabling, configures duty_cycle=0 when
> disabled is requested."
> 

Updating MULE_PWM_FREQ_[LH]_REG is atomic (L is stored in SRAM until H 
reg is written, when LH are then written to the hardware IP).

We use double-buffering (supported by the HW directly) for the period 
and comparator registers. I believe we still have a possible glitch 
during a small time-frame in the current version of the FW. Basically, 
trying to change the period AND duty cycle at the same time, the 
following could happen:

- period A + duty-cycle AA
- period B + duty-cycle AA
- period B + duty-cycle BB

Depending on what we consider a glitch, the second element in the list 
could be one. Even if we do a multibyte write to the actual HW, I'm not 
sure if this window can be eliminated.

To give a bit more info on this, there are two possible flavors of the 
MCU, ATtiny 816 (datasheet: 
https://ww1.microchip.com/downloads/en/DeviceDoc/ATtiny416-816-DataSheet-DS40001913B.pdf) 
and STM32F072CB (datasheet: 
https://www.st.com/content/ccc/resource/technical/document/reference_manual/c2/f8/8a/f2/18/e6/43/96/DM00031936.pdf/files/DM00031936.pdf/jcr:content/translations/en.DM00031936.pdf).

FYI, on ATtiny, we use TCA in single-slope PWM generation mode and 
PERBUF and CMP2BUF as period and duty-cycle registers. On STM32, we use 
TIM15 in PWM mode and ARR and CCR1 as period and duty-cycle registers.

Re-reading both datasheets, and if I understand correctly, we could have 
glitch-free transitions by controlling the ARPE bit on STM32 and LUPD 
bit on ATtiny816.

@Farouk, please confirm but the above makes sense to me and I guess we 
could implement something in the FW. The question is how to detect if we 
want to change both the duty-cycle and period at the same time (we could 
decide to document this as a requirement for the API user though: 
"changes to MULE_PWM_FREQ_[LH]_REG are only applied when 
MULE_PWM_DCY_REG is written to").

> Maybe write all three registers in a bulk write, then you might even be
> able to drop the lock.
> 

The bulk write wouldn't help with the glitch, but it's a good idea for 
getting rid of the lock.

> Also please fail silently.
> 

Would dev_dbg() be fine here or would you rather see them gone entirely?

Cheers,
Quentin

