Return-Path: <linux-pwm+bounces-3750-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2839AB482
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 18:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9301C22E66
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 16:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C41BC9E5;
	Tue, 22 Oct 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="YMQouRoP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2116.outbound.protection.outlook.com [40.107.247.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E446256D;
	Tue, 22 Oct 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616269; cv=fail; b=jjLxSB4t9CBTSqYu/nVfGa5vU65xvmqMAk7ABe0VwWfiec1N9WRyLVAqXvUeE9/oKzfGZ2pk9cFhiSLanN/UnfIS+MUrP/OaY74Knpqk9+6cKJ8cQemxbUAxCWTxLuXUesPIVC1VWSfwxZGI3inXKwDy0WH2gwbS09K0Og77/7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616269; c=relaxed/simple;
	bh=YVwd7rriGfYWq7j+G6e6y7M6i8ritzFXaEZSBPqYQAs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hBBmtG5l7kDDzXrp/JUQlRZLz9T0muiKV23LKbK94O2iAeA5BvW/a56GqX32g718HTa33OLQH1kfY4R67sqHM+u6r5MJZbWDrzIZh2pJtxT+a5a3MDhOoPhoeiI3WKU2z4yfZdLOvXKzaFO3+R2bzwEMzwGeDHfmUx+ys/l5QvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=YMQouRoP; arc=fail smtp.client-ip=40.107.247.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlzEKvgzy4F7CnF6D5VE1uyNPq0KegANs7iS/i/Z30EgF9zAj5cE3y5Ph7HQLoFYoCe1Dqwj8Dj3J4FQvdLSBoY5ktTxy7brxlsaneEZXf6Dq/3/WDWuCXO/8yX8pqkwJpb6wzni8BXdlKaQj3SPeQ9VBKli8FAD4VVe16CSRKDcHT4SDaanxQPNYP63HA1qha9a5fmByqL08zaV0W9hcw11ubYejW/ZIy/1Pj+l0wcYuR+TT1exII4u8KiiAfLHnm2Dtd+g+UPdBMFhANDObUYpebYfiJLlfQtHwRQ/I/aFMRPDpYdRL5QD7DrDA3b2FZtylZMh9C82qhqAv5cxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ok+ChEZwJjXKoFvr0xSEuSNpLWa2odbwyQGVn8dHhsQ=;
 b=VmJR44rgbEYlO0JPLC/oO8oOHUXU3lNVODcHFnhc3aoQzSuWIzmi8Sf+LvvRFuO/CivA/fBq3KqGAn/7EcRK4VCSOx5a1CPpg1M9sJFj27IOwVumALlxtptavqnyyVOD2ET84lEu7OEOJN5yXU6Y7NwYom7YuZSQZEUN2bnBnnyxn/3TceAC2+jEsTUytxmGyqhXKDa4PfhXO/puYWW00fs3MCURMtQxGn1uHObz9id4UHK9yOn3cq42BvIijBU/ZlTSYsyOe/sC8FG2gqgV8MkmQL66y5TbxiA/BzwnCGRS0M3L0YOXpR+gULLKE/gf2W+pyf1E4+iFWxn9NS9FDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ok+ChEZwJjXKoFvr0xSEuSNpLWa2odbwyQGVn8dHhsQ=;
 b=YMQouRoPC2a1YOGwALuIdAtLSrCaY0+Tf/SqTKfkpW4ew+7mUpkbO+CRVJopoWUMNavb/Xpd/a4mpC6MXhNc1GToF12h8furM0vTktrageC6DLuU08p0AuV38d1syCE1tLxgTUGyntB0nQw+hhkEcgPxoHHsWzr5iIZIMSOHPrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by DU2PR08MB9990.eurprd08.prod.outlook.com (2603:10a6:10:492::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 16:57:40 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 16:57:39 +0000
Message-ID: <4df5447c-6410-4da6-84ed-031735fdce29@genexis.eu>
Date: Tue, 22 Oct 2024 18:57:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
To: Rob Herring <robh@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
 <20241021190053.GA948525-robh@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20241021190053.GA948525-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000453F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::356) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|DU2PR08MB9990:EE_
X-MS-Office365-Filtering-Correlation-Id: d8573a2c-beec-4733-84e9-08dcf2baa34f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekRkL0pqUUc4WWlzQzNHSlltelpCS1IwZ1BjaGo0NnVFS3QyZW5KRlg4bDIv?=
 =?utf-8?B?UHNSdzRzMGtnbXEzMnBSamNNMnNlT2NZOCtzcDZRdzViWmYrTUZVejVYSmlR?=
 =?utf-8?B?MUNtcldkYW4yS0xkTlZpcElFTHlLN1l4RjZzQitmUkQ0VTgwNnhpMTVmbWJM?=
 =?utf-8?B?UlJXdGRWUDRnTy9IQmlHTEptUzlhTURlWTFPYU1ETW1YVDF5NFY0UHMxSm9M?=
 =?utf-8?B?Y3NRcjN3enQrNmlFWldPZkJ1WjZoVTVmbVRiZ3VNQ29RNitNVDNNU3RVMWd2?=
 =?utf-8?B?bUdQQ1FSazY4TGJmT05ldHJmL0dta2h0czdPSWFkV21XS25lK1BLbXlDQmZr?=
 =?utf-8?B?bGNURTdCcEcvTXhsRnhTTThjeCtiMitrd0gyMkR6eldTakZtZ1AyZkdGT3Vq?=
 =?utf-8?B?TnJ5QWk3MGxaMW8wdU1rRURQTjdWeGRNYnU3N0lBSkF1Q05LRlc2TFBYUThp?=
 =?utf-8?B?bXdzVkYzQ2pDeEtmRG1zc3F5M1N0b0pnblhTczdtRDNNREQ1eHZlUFlhRkZ3?=
 =?utf-8?B?RkdXMHg5TmpqZ2pFZzdlbnRBQm1IaTFZYmgvbENuazFVYTlzZXVCM1BZc0Fo?=
 =?utf-8?B?dU10dHgyQWoxb3NyQWowRVR1bzN1ZUoxWDMwZUVjNU5mcXlMcXk5anZzWmlG?=
 =?utf-8?B?bVJ3dUtWV2N5ZFlOaFRYVTlDeHA0M1lWWGR4d1QyaFpndForaWIvNjQ2Vkt1?=
 =?utf-8?B?SUxmZ1ZKVXc1STIweUNlQTg1Q1AxZWwrcGZBRTdqK1AvMVN0WFZFMGVmSnpO?=
 =?utf-8?B?Q2NJbk9YNFlSeWlDTGgwbVkxSE40SkMwTVl4UUlNbkdVK2tITkk5eDJRT0hh?=
 =?utf-8?B?L2FadWEzWXZuT2Z0RVdYYXdCUkJadFlaVjluZmsyajBnZEJ3UFRWRlJNSmtY?=
 =?utf-8?B?MzN6dms4MWoyM2R2SjBBYW5sQW1HS0ViWU5WYnFqbG5XRnlneHVjT0I4NXRv?=
 =?utf-8?B?TUFtSEVzZEJNck45TjFYWHZlT3BONlc5ZFU1clFsQldZVXo3Vk5pci9kUnZE?=
 =?utf-8?B?VTl4TnBwcW1vTlcwUi9WUGtuWWZ2eXkwVWdlZ2NXSVBQY2xKaVVBTDNrSXdB?=
 =?utf-8?B?Ym1MQzJZSHB6MG4yTTRzNEtiL2xmb3dFTmcxYW95ZUsrTERFYkhvNERYTjB3?=
 =?utf-8?B?ZXp2T3ZuSGZKZHJLN1JocloxTGdNNmNhdHJ1RjRhQjJtKzRvOUgxRS9LeWlC?=
 =?utf-8?B?UWhtdGNyZWdpYm02UGU2TElRTU9ITjZxdHliSGppMkhTMGMrcVZ5MjhaL21F?=
 =?utf-8?B?Q01ub3p5anFBTmtoMDV4MmNRcXcxZGxVWkcvN0JuVXdjc28vZURtc1NsY3B2?=
 =?utf-8?B?M2hEZ1JxWWdnbThyZmxxclN1aG9lRG5jWS9JbU1pTkhvenhRNXdHK3BpZzNP?=
 =?utf-8?B?amtPSG5GRmJUa2JVOCtxMzNudUxQQjBwK1psTkl4RXN0RmpOdmk5T01RTG96?=
 =?utf-8?B?US9YMGpicVplakxpQmo1OHE4ekNnaS9WdUhHRzBRTUN6WU1uZ1dMN2hpenhh?=
 =?utf-8?B?WGhrUUE2NGhyNFQzWDRUbWJOZ29zbDBPZitPTnhCZEdLU0xxd3lTZDRNQUJx?=
 =?utf-8?B?cEQyY3JXejB6UXluMHoxUXVaRkFqektqcmVsQVRqd3hVYUtLNU9UcTNkQ1A5?=
 =?utf-8?B?aTNWTHh3Nk9sNjR2ZktCZWJmTStIUHQvay82NC9wOTMyUFMzU24xSERBVXhv?=
 =?utf-8?B?NDZnS3hTb1VnSGFIMzIya3IyS2NuU3I2VE1RYTlYQi9KTXBGUXlybmw2Q0RP?=
 =?utf-8?Q?CkMit7NORxBHJobQ36Ve6kdKqSgbtsuenyNhHq/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHRtSzIvUzI2ZzFQcUt0RWVjSGxCcW8wMDZyc1RWVHduaXorK3E5NWh5WHUx?=
 =?utf-8?B?VEN3TkVMNzJWMk1RbW15M3FzZXVnTGRFK1JrVTVTODhDeFBzemNSZ0JXK3dC?=
 =?utf-8?B?SWx4N2x0QnM0VU9vbjlJb3ZhWTRpbEE4WnplT0RHazIvVnBtQWhaclJZOG15?=
 =?utf-8?B?R1NmRFBvcE5xaXFVeGk1QitNMzlyZ1FWM3ZyODJNZVVLdEd4bjgzNlFWOUtH?=
 =?utf-8?B?a2JkNUdUcExFRWhkb2ZNdldIV09JQS95Wmd2Y1BVa0JSTWlHdFhneEZOaUdX?=
 =?utf-8?B?bFNxcytaK0w5QWN5MmtLalBldzB4MCs4RWwzc1l2VFR4VXFETVdUOFpRd0kr?=
 =?utf-8?B?NzVuRllKclMrVGxhcWtrcVI0amNQZTRIL0VJbzFoU1c3QnNEV2oyZnMzT0Ir?=
 =?utf-8?B?NTFiTHYxbHkzTnBSd2N6Z0tyZ04xRXprdlZ2Vm5UeTFCYng2TWZpUUZzSHBY?=
 =?utf-8?B?ajRxeXpPQk9STEZST0g1Z2xZNUhESnIwVnNZdVJZbW1MRG5jN1BuR2Eya3FC?=
 =?utf-8?B?b0UyeFQvZyszMEpVUk9OaE5OOU8wN1pwbG1EUlVOOHZMa1lwcURnQTJPbWxu?=
 =?utf-8?B?Q082dDQ4eFNoYkEwVkhrQnFwTjd2b0xtTGFoMVBhRkp4VzNxS3JTMThwdWIv?=
 =?utf-8?B?bk5vSVRKdkRzSlZUZEY1Qm9VcUtKWmJCb3lOR0dhclRUQlF5V2dqUG1wOWt0?=
 =?utf-8?B?UXBIYVJieVdLdjJqOEtGOE9QNm5wRXkxRURKMXZnZHJxRkpEdi91UWIvdmRn?=
 =?utf-8?B?dnRpTUIwSFJiZTNCTFhOVytBandyWXBYZFY0RTJZVllLUVRYRktDMWJJZENh?=
 =?utf-8?B?U3E4WHJMaFhtRm1jVDRqSUFRcFdQR3hZQzRTOS9peE4wbEMzdDV0OEVEaGhJ?=
 =?utf-8?B?UW5pbmdQZ0xUazViRGR2UEh3c3ZjNlNhTlJUcWwzUVZWTDExWi9tUlFUZCs1?=
 =?utf-8?B?VWpwbDl2cVZHVjhRcVpUQjdqSmQzbWtENzYrZ3Rwbnk3OFg5SUhnelhjOGoy?=
 =?utf-8?B?K283OFZYK0RKVk5ibFJZOVAxSWhjZWpQbG9lMkdZcjZEQU4zaG5WZlM2RmVt?=
 =?utf-8?B?bXp3K2Jzc1ZTZ1dZNlRaZVhSL0pwM3h2Rk9SN2N5V2pxZDdMK0x5WlRVODAw?=
 =?utf-8?B?b3B6T0F3andaUU5HdEJ4Qmt5NlkzcFV5Yyt4RGJvcUt3Z1JEa1I4ZytEemI1?=
 =?utf-8?B?SDdBSGJYN0RKUTIxOFBBRS9YaFI5RTB0TE9SZER2SkpsUVBLc0liOUxPTDhS?=
 =?utf-8?B?RUtweHZmWTJydmg2NENuRldoVlcvQ0JHZStPK0JoRTczclFpVkpGbXRsZ25P?=
 =?utf-8?B?bGJXeC9NbjliZk1GZkNUZ2drY3JSb0dMREhCNThlL0ZNcXVrVndRRWE1MWJa?=
 =?utf-8?B?OHZTL28xVFU5ajdnUmtZaHNtdHVOWDVhTVgzaHgrU0I4TGlKM3RTTUdUcWdS?=
 =?utf-8?B?NUo0YUtwZGwxeHpnQXZ6YUZ6M3BiL2FVQkJldU16Z0JPZXE4YnR2OGVhRE10?=
 =?utf-8?B?MkpzMmlQR1Q3QURVa2FHNGVibWJOOHJhUksrajZacE53YXZXdjZsVjQvVlRN?=
 =?utf-8?B?QzA3L2FyYXREd0ZDeUY2QktBUlBqQmF3VWUrWDgwNFVsdE40dUpoR29BZGpw?=
 =?utf-8?B?dkt2c2xUdGg5YTRnOXB5WlJyUE9PVER2MVZBbFJ3alpRcXFYRVQ2NFNvTVhH?=
 =?utf-8?B?eTduTFpiWGhvNm1JTVJXSHR5ZTFPQXhzZDBVYXNkNVhDNHRsSlpJWlRVNUJ0?=
 =?utf-8?B?SEtmOFpWUkpZMlZOcG1aU00wTE5pVEtUdjN6MEwzazRLd1hGQXVrYUtKRlAw?=
 =?utf-8?B?RHA3UzM0YUhqRlExS2VkR3drUkhINXB2TVNVOEJKbk5vMGJ6Ym1ockFkZDJX?=
 =?utf-8?B?aW9ad21ldlNzRmtIdHdvYnhOV0Rid0owS2FRV1VoZ1VhU3NqaTkvMU1GblFn?=
 =?utf-8?B?WkV0akhHSUx3aDRocHUrMVFHSnZWQXpTbE1wU1crRXN1MVpvdGxFUTRaajVF?=
 =?utf-8?B?TmZVcGU2Q2toM0NWcDBKQWNROFBhZVZxOWtFTzRUS1RGcFk4YUt4MW9SNjFG?=
 =?utf-8?B?WVNTVnRmN0xVVXpFRUovR01lU01nWVFJbHc0WWNXMDMwRVczalg0MkVuRFJy?=
 =?utf-8?B?TWlvazEzL3BiKzU1SlhJZ2pVbFpiL01wRVNxbW5KZnJjaFF0dkhUb0ZHV3gw?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d8573a2c-beec-4733-84e9-08dcf2baa34f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 16:57:39.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXvIyHHullg+m2IdbSlDWqmgJ3uiO7CKgOC7fRNOldp+SgsG4ay+CjynwIzv2XHdzONoyQsayWRbj+CcFS1NI03R2NfZsti+E9GrV6wNyQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB9990

On 21/10/2024 21:00, Rob Herring wrote:
>> +  airoha,sipo-clock-divisor:
>> +    description: Declare Shift Register chip clock divisor (clock source is
>> +      from SoC APB Clock)
> Where is the clock source defined?
>
> You can specify the PWM frequency in PWM cells and should be able to get
> the APB Clock frequency. Then you can calculate the divider.

Hi this controls SRCLK for shift registers.

https://www.ti.com/lit/ds/symlink/sn74hc595.pdf page 8 has the limits 
for this chip.

I am fine with removal of this option. The main use of this pwm driver 
is for leds and for that purpose the default is ok.

But I will try to get a value for the clock source, I guess with that 
value the option can stay in.

MvH

Benjamin Larsson



