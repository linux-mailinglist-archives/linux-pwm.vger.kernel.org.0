Return-Path: <linux-pwm+bounces-3110-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1696E217
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 20:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913371C2188F
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E817A58C;
	Thu,  5 Sep 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="dL0yAMEE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2109.outbound.protection.outlook.com [40.107.21.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBF1C2E;
	Thu,  5 Sep 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561330; cv=fail; b=LCgKVomVCb8HtndDh4CnW+S4aljNdAqkhog+qWl149Mpq7G9zjOpRtssyAtz23ryURLeS51IaSOVrzIcJTIy+ueFE+HVcEcUS9mt/IZ7iR/NmZST0YSyYyOQtSoKUyrLw8quDC6h8BoOuhBRren9yBvJRqmCFg3rkBhnSwwfBlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561330; c=relaxed/simple;
	bh=SsiBmcXuUrLrwvBRWWzMivd+cFDkBUXMneGJf9bfeN0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCMd4HrWMWab1Iyb1CBha9JRl1yLfC8dsa21Z4sZ1Hrazw6ViPogAlH9qy0fsVXqvo82h7v+w3AW0g3cG3BGihUHTmrvUZKD7ipk8hhKV8Ee+q6oKsoD7Mni1Zqsw3JL01zYEv3L5C0VhJxlH9/tMIXSd1iNiT29ar3D8mpo+bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=dL0yAMEE; arc=fail smtp.client-ip=40.107.21.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWuFBA7JnmsNlbRhCHwsdHuPZo3ERxH1UQWzZh6iRA96a5m6kPsTFrXdXwcIUHQdYlpKocdCXfHvvpnxOBhCQZd7vc2MARQmpvIS5rF5eaFObXAOnPG4+X9ejwVclzWWGAPVJED3cNwQ2KmsMN96i+QQM3JPoIL5xrX/OmRwA0FiQPNcJ73izh7yM40UUt9KwSAR4rea4ow+5cfYSwR+D8q7GGQNpWNFOYqYh8CXd84KbA63m2T0nhBO0xBVspojvB90eTEvDjWs1G80MCJB+iodP2Hhe18VPv7QRqqHSi3KmjDbHOSLVnYcCmI28H0Y0Sn4i6qoosiglQGk0kwD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnH92hfxF1eTWGuZ2L9bPU6SUNXY/rWqsOGRDrGg2v8=;
 b=F8Dw8rI5uszbyJrgL1K/1MpmRHTsEfq5awfFldTlLm6lWgveBCb8srKgdS0JrvWkClGrEuROJi5xrkh73cnfJ59RUwIBnySKqf5aXwLZ3/bSo34y/3J3kfK2qzlHapjd+jvwGWqvNlXF4o/zeOaYbcZwdiKJexMWA3toYJY6y61GTonx3AGzuKasQo7UP1JBPxyA/L16/JHNvkShXue9UnoVg5jdzcO7BiSrg8AQvx48DX5UN3IUMuo3AY5tWbqmmWlPbdNBz2dMn6XZ7e90QXXuFawseBrcDXv3rJIVHZ2d6QWcRAeZgM9tGHgcbrftmgmbECFmf7m4Vlyj8vtZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnH92hfxF1eTWGuZ2L9bPU6SUNXY/rWqsOGRDrGg2v8=;
 b=dL0yAMEEHh6X3a2GCDovP0UIj37vVyLSnq/OIt/5+9jQh0ul8k5kuPr3X1arg1aEXILKLZLpSBcAUI61h9eBXspdUnTylnrksyz8BkHpBElzGjGOHo1dzgQxlmlclhD7V+AirMjub4NAKdBhS1YOH2BEVWe813UiwTq+fafkldI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by PAXPR08MB6493.eurprd08.prod.outlook.com (2603:10a6:102:15a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.12; Thu, 5 Sep
 2024 18:35:20 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%5]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 18:35:19 +0000
Message-ID: <2e8806fa-c476-4cfa-bc2e-dc02754830d1@genexis.eu>
Date: Thu, 5 Sep 2024 20:35:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] pwm: airoha: Add support for EN7581 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
References: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
 <20240831-en7581-pinctrl-v3-5-98eebfb4da66@kernel.org>
 <yfqmlca6cnhrghpo5s6tml36tngmekcfbyjakxs7or7wtap3ka@7qlrxjowo4ou>
 <d9298199-fe10-4b28-8e28-dc252bd6832c@genexis.eu>
 <t2f5kockuvfi66qqumda6jxf5a4c4zf35ld5ainsnksavkchyj@kdueaqlhjoar>
 <b7e44fb2-6cf6-4530-a271-9e1730d4f431@genexis.eu>
 <xmlta4za6malgthd6cmt5fcipxgyzwmqwxqdg5e4qahcuqzcrt@eidsf6mexrkz>
 <a0a14b57-cc4e-43ef-984f-fb405949b41d@genexis.eu>
 <64zfjgmc2dutmsukg2bxhb44k3wu2y7tt3h26hej7d4fx5nc7z@5zvo3hsucipc>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <64zfjgmc2dutmsukg2bxhb44k3wu2y7tt3h26hej7d4fx5nc7z@5zvo3hsucipc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0059.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::12) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|PAXPR08MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 67f051cc-2286-4ed0-c824-08dccdd97e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2QrczBaWXhaSERPZERwbEc2ZXNBV0s4bDgzbEFOVXJyenVjcitnMEIxVVc1?=
 =?utf-8?B?dVNxY1JieVIzTGpJNEVUUjQyaTlSUDg1NVJuMkQvT0duT0I2QXFpczJnLzMw?=
 =?utf-8?B?V3BZU3BaVVk0OGpqLzd3L0FQRlliWkd1Y21kVU9peUxvejVIdERBM1RoUk1X?=
 =?utf-8?B?SlpVZWlBYndhVmtoTmcyc2xlTFRidjhCQWJqT2VGd1I1N0x6aFlmT2x4WlZO?=
 =?utf-8?B?ZWtoaERiaklOcmNVVTdQaTRaYnJwQlV0MmU3a2lKR2hkSkdSbWsvMVg1T1gz?=
 =?utf-8?B?VnBTWG05Ylo4emQ5SmFvczlXNjVrZmxCSlkzSVVBMFdnREZDMUhBcDRCdGow?=
 =?utf-8?B?SE5vSVh3eUMyRnVxTmg4NHZ3aUw2M0loNUVSODVJY09HQjJMeVdjN0lWWGRB?=
 =?utf-8?B?WTJna1A1WTF5N3FoUU51L1JTM0pwTXF4bll1bCtUTkVDRGV6NTM1S3RPMXNK?=
 =?utf-8?B?amw3dVNWUUY0RlB6cXRtdFN4QjRxMFNDVGFzNXhUZTQ1UE5LeTdMU1BXRTZ2?=
 =?utf-8?B?ekNLaURBaDl3S2RJSlgwcmVoNXYxeGZDS2ZMQ3QvamxPM2pXdmN0Y1ByTWM2?=
 =?utf-8?B?VXZMMXVFNFZBTEVESXZwZmtTNDRIT203OW5kaS9JTXZkeGFqM0hqVnFkZ0RZ?=
 =?utf-8?B?ZmUwbjlqVVJHSm9jQ29ENjFBeElyVHNOYnFNTVgxQzFIUnFQaWltYklYUis1?=
 =?utf-8?B?WVJKMUJPYlhDZk9sU1JXc3BjemNWa3JiN0lUK3JLVzM3dTlDWVdrQjFoazJx?=
 =?utf-8?B?VlVXYTRjUzU2UkV4dTBQdVRqVnRnZTBYWXlzd0FuTnQyeTd4eGxhQ1JVQ2dm?=
 =?utf-8?B?RENyY08xZGZENDRJWm0zOVNLTkg5RmM0eGZNWlZ3NDVDTEtOTUZLSjVGc2xi?=
 =?utf-8?B?dnNoT1BMQkZuSjJobkZZenExUDZtU2svaVR2WU9WL1pRdkU0blFNM2tmNENx?=
 =?utf-8?B?LzZ0cll4Z3M1RnM3VEo0LzB1aGI4TWRpMllSVUpzTTh5RGQyWGxyNDZNMVUz?=
 =?utf-8?B?emxnc2NELzdZSE1iY0hwNlo0bFZjNGRFNlRaZ1ZoaURDWktvci9pT1huazNa?=
 =?utf-8?B?MzJHQkZWamtXQ2FwZWJxVGsraUVVYkNnSmE0V3ZPdzN1ODdPOHR0N3QxeWho?=
 =?utf-8?B?K2t0L0ErRncwNHNnZ09oRFg3WUtZWFhWbzV1Tk5Gc2Nxak1IZlJUVmdxZVF1?=
 =?utf-8?B?SDI3M2ZxWndOWGN6Y3hhVFI4d2VIQVU1dlN4UURvU1AzVmRZT0pkcHZxVmNz?=
 =?utf-8?B?UkJRaEZvUmZYNUgxaW1xUXJMeHRPd3o1S25ZU1o2Z0VuMEVkUEwwMHFQeks2?=
 =?utf-8?B?ZUJ2d1NoUkNESG5LVVBWblFjdExyTHhoelp2NzJLbHE3bTdWNyt0TlJrd3Yv?=
 =?utf-8?B?dCtzQjA3SG1wcHJ2eE8vY0NVRXJwMzdzOUtDRWRIeGV2cmpRdFp3dC9XYzhy?=
 =?utf-8?B?U00vMUhzSklKNE1XR0Y2Q2x1ajhxMWw1SWJzbnQ2QTBSUGZ1Zmc5czUvcVY2?=
 =?utf-8?B?QUptUjIrdllsaHhsejd4Q0F3UGZxeFpPdGxHY3g5dFowc09pRnZSQWU4UDM5?=
 =?utf-8?B?Ym94TytMT3Rra3NXYTVRdHMvV2pJZXRLNlc4cWRKTE0zdXc3RDJKOTAybzd5?=
 =?utf-8?B?Vnk1K1huckZwU0t1ZHNRRklOUXpTb3FEd0dha01sem9MZVQ5YjAxL0ZVcmww?=
 =?utf-8?B?Nmp2djIwa2ViZ3ZnYVNZYWNVN0M5OTBacEVTc2tPQ1g4REVza2U2TURmQ2Ix?=
 =?utf-8?B?S1RwN3gxSHdGR3o3dmtVMUdDRDgydE5xbFBhanlLeHhVQmhzaU9aTXFsL2VK?=
 =?utf-8?B?eDNLM1VWa0MvQjNBaEIxQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ZGVUdBU1BrL2FRTFEvdUYrN2xhNnV6RWRmY2pmUkFuMHhuQndYMzVjeFph?=
 =?utf-8?B?UlNzTUJ0Ni9Td2JYYnFyZ3RZb0w4dmdDcmtpYjRwVDlNYWdPZlZ4Y2t2SE1B?=
 =?utf-8?B?bFlPc1dVdWdqOUtNbnJGOHlDSXl1Z0tCRVQrWDdkYnIzNlF3UkV1N0lRYXNK?=
 =?utf-8?B?QWE5c0t6ZVZmQkVLQ0Q1SG92ZE1wbEo5Qk5KbTYwMXVLdjZCaTVoQmhaZk9P?=
 =?utf-8?B?N280TTRSd1IrL1VPaURJMlJQdkV6UWpucEVPZ0pGU2orcG9UdDJNRklqNGdH?=
 =?utf-8?B?emo2ZGxjbzVUa1F1cGp3K1NtTnNwWUlqTFVrN3daNUhiMzloWXhuUkFIMStR?=
 =?utf-8?B?WHU1RUVjdE91ZjZyRDhNOFlxc0hUckRCSnpyc1ozcmdJRVRjSndBbW1keUdh?=
 =?utf-8?B?dEhPOXpzaEdyS0NmSGMveFpqbkxvNlNjbTZ3Z1pWYjBpbW1tZVpYd2NaZHNt?=
 =?utf-8?B?VWNRZEYwd0VZbXdPN0xxRUFWdGpSYzZOVkNwNytTSVZHL0lydG5iQkhjM2R4?=
 =?utf-8?B?UW5sRkhZaythMGU1blo1c0lqUWZSMmxrdU5JTXg2VnhsM2tod2ZxRXgvMnBw?=
 =?utf-8?B?bE13ZlVBam9UenNRaGZ6c3Z3S3pHWVFwUzlMaGx2TFo5dlJTKzIzSmJDdEVY?=
 =?utf-8?B?RHhObHZvRmJRRGJQem1xSGd0VjIzSGVrdGt3ejN1WTVkbVVjQ0pTRUx4bzk4?=
 =?utf-8?B?R0NPWDRXUklNV1R0akVwdnNmR2JCMTNDNkVtU0NZUXN5VDI5VEdEZHhCSDZy?=
 =?utf-8?B?clNJTlQrNlRuUWlBNnhOLzFqTXEyaTNuV2JUeUhob25sTUpSK0U2TWR4Qkk4?=
 =?utf-8?B?dXhuZXZzMVpoS0s2TE1LV2FEZnl0OE5aS2RXQjc0SFFWeWxsdUhMVjg1YkVs?=
 =?utf-8?B?VGNtRmE3bVI4M0Fnc0wwTzEzanhSaXdxZHU2dU5oQnVSUDZETTFud0VhT3J2?=
 =?utf-8?B?eitHbzdSdWFML0t3cEFVVTNSTkkrbVVwckhsMDJpZU5EbnFNcERxcVVrc0xu?=
 =?utf-8?B?aFhRd01DcW5aeXZQbzFoRGZ3Nk9WaWVJNmp0WGp2a3VHNnFDSkdERUZyZDR4?=
 =?utf-8?B?ak8yR2dYM090bkk0ekIzeEdubExoVlVmSTAwOFRjSzNCRGZYcHNQMWVKZ296?=
 =?utf-8?B?cmFIYXA5dVZIQXRMakJBdFJQc2w3aitPUEY2V09OcDU2VXFkZ1lLdS9RbEpu?=
 =?utf-8?B?dHpWNm9wOERzN29JY0p1NlRWNExxbVJTU3g0T1RFTVI3Sms3R1VpaUMvdXJa?=
 =?utf-8?B?U0xaQjQ0TUZ3MEp6UzVKOGFYVEIrY0pEaU83eEs3U1ZuR3lhSGFFczc0ZGRP?=
 =?utf-8?B?TFB6MVJLdHlnNDVvaUFOb1p2aWpMZzNhMFBscktZUGRacHVTOEZNTDBXZTRa?=
 =?utf-8?B?WVFRS3R3eDVqVGlHREMvMncwbklDanYzN2JOb2FQRTl6WW1XR3NsNDFpRjdZ?=
 =?utf-8?B?cmZBa1Z6aVhlbE5aa2VBWFcwQ0hIaGpZNnlOWDdtRm5pNlZkZFkxTXJKMlBi?=
 =?utf-8?B?eFR5T1l4aXdKS0l5YnBWdDUrc3JHcnRPcTU1QmRBV2Q4RkFaK1pLWGl6eGdl?=
 =?utf-8?B?M2VSdjJkSDJHMlVROHl2N0hNcWtud1VJd1FpTlh5cnYzaFZiSWdqS0o4NDNp?=
 =?utf-8?B?TjlOZE5YVGtoODlxTzE5N3gyYzQ1d1V1Wk1XeFdTaExDVmdOcFFJS2JZMEpX?=
 =?utf-8?B?MXgxL3JSVmllcm1PLzFNdUFPdGFZdmdIcDNnSnNUTmwyOWFwU1FzR3ZkdzdQ?=
 =?utf-8?B?OFdkSlVkaFBXaDdFSmdEN1NjL1hMSytvNk1ReHFpRmFUNm5sY3ZMV0hFSE5P?=
 =?utf-8?B?R0JwSUpMTHpxUHJNWGFIazRLeDJldGRiM1luK3Bxck5wdEdMWXZteDYzN0lY?=
 =?utf-8?B?bEl5RmpQektTb3ZNRXV6UWcrbHlPTFk1aVR6c2VXMUdvU0NzUXFPMVI0dWZO?=
 =?utf-8?B?bnJkdWJWS3hFR2tvMThjck1QSERtRFYyRE11NVJETStLZ2FGN2lzMHNWV2tp?=
 =?utf-8?B?akhNUzJ2TU53RWEyejBmTE1RTk1sU2owUzQ5Q3pRZkhzWW1ueDQ4cVJITDV4?=
 =?utf-8?B?QnVCZ2RlVGZvempCcmpRWEx3NytOM3gzUkZJMEVFTFhFQXY1TkJaTm0xU0ll?=
 =?utf-8?B?ZHgwdi9CTXovdDFCWG5Sa2xsOUthQkFxSzhSRGFrVXhiWXhwc0ZlcGlVMEdQ?=
 =?utf-8?B?L0E9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f051cc-2286-4ed0-c824-08dccdd97e6a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:35:19.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atIA96TPkeLDRES8nzqmDPblePXaDCRVXB/pY1zdm1OXXTip/vbNv0b1m4my9fE+qJ0VAxgildL9CzkUXJdifrSo8OLtd6+9kJCkuw7kYzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6493

Hi.

On 05/09/2024 17:39, Uwe Kleine-König wrote:
> Hello Benjamin,
>
> On Thu, Sep 05, 2024 at 02:18:41PM +0200, Benjamin Larsson wrote:
>> On 2024-09-05 11:30, Uwe Kleine-König wrote:
>>> 1 second long pulses with a period size of 1 second, so a constant high
>>> signal?
>> Hi, I think I was unclear. The SoC documentation is not that detailed. But I
>> think I understand how it works now.
>>
>> One register contains the minimum duration (d_min). And then there is one 8
>> bit register for the signal low period (lp) and then another 8bit register
>> for the high period (hp). Per my understanding a change of polarity is then
>> just a swap of lp and hp.
> that doesn't sound right.
>
> A "normal" waveform with period = 10 ns and duty_cycle = 2 ns looks as
> follows:
>
>     _         _         _
>    / \_______/ \_______/ \_______/
>    ^         ^         ^         ^
>
> assuming a monospace font that's 1 char per ns, the ^ marking the period
> start.
>
> Ignoring scaling, your hardware needs to have hp = 2 and lp = 8. If you
> switch that (assuming you mean switching in the same way as I do) to hp
> = 8 and lp = 2, you get:
>
>     _______   _______   _______
>    /       \_/       \_/       \_/
>    ^         ^         ^         ^
>
> which is still a "normal" polarity output as a period starts with the
> active part.
>
> I admit that's a bit artificial, because the waveform for
>
> 	period = 10 ns
> 	duty_cycle = 2 ns
> 	polarity = inversed
>
> looks as follows:
>
>       _______   _______   _______
>    \_/       \_/       \_/       \_/
>    ^         ^         ^         ^
>
> which isn't any different from the 2nd waveform above if you ignore the
> period start markers (which are not observable apart from the moments
> where you reconfigure the output).
>
> However it matters if you have a chip with >1 output that are not
> independent.


Ok that was a clear explanation, anyway the pwm hardware is then not 
capable of a polarity change. It is possible to change the polarity via 
other means but there is no way for the pwm block (and driver) to handle 
this.


>> This means that when requesting a period and duty cycle you need to search
>> through the configuration space to find the optimal value.
> Or restrict yourself consistently to something simpler than a exhaustive
> search through the complete configuration space.

Is there a recommendation on what is more important? Period duration or 
duty cycle percentage?


>> MvH
> (BTW, I had to research the meaning of MvH. In case someone else doesn't
> know it: It's the usual abbreviation for "Med vänliga hälsningar" in
> Sweden or "Med vennlig hilsen" in Norway; both meaning "With friendly
> greetings".)
>
> Best regards
> Uwe

MvH

Benjamin Larsson


