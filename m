Return-Path: <linux-pwm+bounces-3099-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B4596D82B
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 14:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214481F23544
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 12:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403D19ADAA;
	Thu,  5 Sep 2024 12:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="RB1RQ8Ec"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2096.outbound.protection.outlook.com [40.107.103.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AF19A2A2;
	Thu,  5 Sep 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538732; cv=fail; b=bZVteqWaIItGG+acUyq4ZD0pnq06I69yQH7vBCGqce8cluRt2q9BP/3bMcRdNaHvsvyJSoIq1Ci2nkGVeIgk7z3zLSlkw2ysM7FCXVYY4ZdpPJCZVHWeLdhvu5LvzEnnuaszZkbha8Kzp1q5E18/0hkXcsn5TLwDFfQtew772Rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538732; c=relaxed/simple;
	bh=YL6cggzkSLh+zuHKlHSjnUe2LL0UoRE/noAql7BDUZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WffPuMo66NvU2505xZEI0kfxHpJ7mDPzGSpC/bYA5O+U2Tc1uALFtPWMA/sw+A+8LxgeOSkWqO+zZXPKnrHK1zDs4GPCElS7mS+X2gUEOiM5n5nKlTnAvfVwbL5isXMv+FRuWGFTWFykC2CrNbuYsD3W+B5uxBm5TgloRXiP5BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=RB1RQ8Ec; arc=fail smtp.client-ip=40.107.103.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVQrRbgprCRJ2ZQPUrNVBxXugFdqd5mn+/LViJluxOOjNWPld/jqpauccZt3tCqutRGhZYVdS+kDgWRJs4HmpoK8Z2cxE7Bt8293AdC+FQgmqqlVl0RvlmiMrfmSZx89Voqbmz3RgEvUJnK0leuFgiImoxyXjj7kDE6fim6MLlY3XfVBKuKp0m5uYJbjU7432W4gIp8/abHaTKEJ4WUnBLkZlVI/xH7WVNymmaDp0fa0Qs5KCzS3FROh9BVijnHPnZKWlud/O6tLZjNilKVBjROmbFC6BtZFSX7UAubYpieudQCYCww3hM9sTITpaMbZJuuKz2+phofPRT8rggjJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo5r8K0OqnYYHJWXCssPqdM7QH/Pt1seH2efyonh5/w=;
 b=yqKhDHuK1LgqExsXzWuDE+wZBDsb50Dz/xPlwtszatUwqALPfhqpLfyAXksc1IIRiVGcB2HWCmboNF6AHAdUQye+cLCRel5zPaVrjtusFliQ1L3ZhEu5sGWQZHJCt6UvHKRfm8g+HGZVVuswcbHhYTRcUZgfayqDZTv+7u5qeZWYqc4SMyriNpPdDVuWrDua/Q/qxUcp4nIGuVCvUdOOUxlYOQMEMGJiXXNfzNTdxw4pu3DLf5dGZXwYUXQY89iH0q/cHhxHbUcqf/mv+O13rgIwSN/Xf+J6biGE6pswY00mw4v1I5nshNvZOVP1Xrdmf15M7uhPOT+/QZzQT8CkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo5r8K0OqnYYHJWXCssPqdM7QH/Pt1seH2efyonh5/w=;
 b=RB1RQ8Ec8aCEy315s1rbjVGVFpGN/Khg7Sf+5s+jtChS3mMzpFUVm2X8zZrryVvYGNlxY8M+YzgIBl+LUjplxNBxV0fTeT90PARn8wNtJgqnzlOXxpTW78v3hQUi5mRLacbY5Jbl22yKXR/Z7cjbkR+n0DK9HUtwXbwghC7frX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by DU0PR08MB9462.eurprd08.prod.outlook.com (2603:10a6:10:42e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Thu, 5 Sep
 2024 12:18:43 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%5]) with mapi id 15.20.7939.010; Thu, 5 Sep 2024
 12:18:43 +0000
Message-ID: <a0a14b57-cc4e-43ef-984f-fb405949b41d@genexis.eu>
Date: Thu, 5 Sep 2024 14:18:41 +0200
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
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <xmlta4za6malgthd6cmt5fcipxgyzwmqwxqdg5e4qahcuqzcrt@eidsf6mexrkz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3PEPF00002BA7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:19) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|DU0PR08MB9462:EE_
X-MS-Office365-Filtering-Correlation-Id: 610e14e2-f65d-4db1-8df9-08dccda4e208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGhNVUJxSmhvMEVob3F2eFRMN3VZb1ptTHBEYkxaeUNzbFhNNVY4SkRvdzY1?=
 =?utf-8?B?NGR4Y0dNd1VLNmpsNGo4d3dhTjZZc09KUFcwRUd6RHQ5MmFiOThVdTZKeXdM?=
 =?utf-8?B?VWJNdDN0U3NQUVp6L2kzaVFMcWw3cHJES1ZkU1lJS3FDVlFxYW5zclhUb1Rx?=
 =?utf-8?B?YndKTjNQV2REQ0plZjExemVOQkJhR0dNMGtrNVl4LzRjcTJZdkt3WGJmcTh6?=
 =?utf-8?B?aXU1R1RsMmNrOTFUTElMNSsra0ZrK1VQclBRbmVWMTBIeWttYmhmSTZFQlB0?=
 =?utf-8?B?Mjl1YmdmZmIzWHN4TmpXaHlGalpzUHN5ZDh6U2x2YVZINnhTRWxpWFozL0ll?=
 =?utf-8?B?M3YybGJuMUcwNmJJRFoxZ05RQU1WbVE1S2ovbngzdUM4UmRLalFkUUN0bzly?=
 =?utf-8?B?QjBVdFBsT0NHWVVKbUNaeHpwa1pDQ0JJWHhFVUtVckNYcnRtZ1lpTjBlbk11?=
 =?utf-8?B?N1FYOUNlU1EyRWtTeHVQeWVScVluc3dMUXR2emNuWER0WmljVnRkTXpuTnFv?=
 =?utf-8?B?bUhieEw5NnR3S2dpT2RyOXk5WTN2RzB6SHkrV0FrdlNCb2xSK1pqSHhJWXhw?=
 =?utf-8?B?aUNjYmJOZVhKYVM1ZE8yRU1oZGFsYkpackZEbFpSeVdjVklxeXh6NE0vY3dE?=
 =?utf-8?B?OHBPWHYwNUxrNTF6ak9TOEF0UHhBNVhuREtZWDcraWZxYy9CWmhmcUhaMXlR?=
 =?utf-8?B?SHliYmZ2Vlg5YkhsbGxGN3Q0S1Q4RWVNWFV1S3ZFd0p2VUNyc2cwSjEyeHR4?=
 =?utf-8?B?SURRSUhieDIrUS92RXM4WVBrS3BBOTkyQkxBd3Z3WUtKMGZEUVlCVzFYOEpw?=
 =?utf-8?B?a2NXaXZRZUtGdW1GdXVYcDJQZTVqaER4dCt5UHI0czZzN25IOTAxRGw1cGN2?=
 =?utf-8?B?ZnRWN3Fkc01iTkVSMHJIVzFEVW16ZUlBMXVrckgvK250cW5xams0WU1XcHJ0?=
 =?utf-8?B?TWlWbFVQUFU0L3AvQmNUWUZFaDNLc1dCcHAxSTFQWGExaHFuT3BmUndwRnZ4?=
 =?utf-8?B?RFpuWStOMmRyM3FZTXFjVm5JWjlHTUg4eTB6a09Ob0FwVVpWV1FSVTY4UkRV?=
 =?utf-8?B?Rnhmdnp3MVBLc1A4MWJaNDRUUms3bDB2TnczVnowem1UeC9JczlzZkJ3QnE5?=
 =?utf-8?B?QzVvY2Y2eXpDVHJzakJTK29sZ3dCWmhVM0NPMzVEdFovME1qNkpjb1lxY09v?=
 =?utf-8?B?NzVselVpZWxxbDhBeGVaL2dYaVpBbm1qSzZBV3VZRVZIS1p6TWlYS3BjUHlh?=
 =?utf-8?B?UTlGcXJTYis1MXVudTVwdXdyTFNBZ1Yxb3VTTkVUZkFFWU9PM0RCekJZc1F4?=
 =?utf-8?B?TXp4M3lLNm5mRFh6Q1BSanMzS0pqaU03bkc1QnBpbXJlNkZhM1ZwTmZPM0Zk?=
 =?utf-8?B?R0FudE5GKzFlOWtyT3ZjZ1pDOUs4eDRnR0RRc1NGQ3dVVjhZdXVhSHBlZWdO?=
 =?utf-8?B?Z2Z5ajRrWTdCc0NtZFcyaFJTaFNkZHJZUjgrMWQ2b2JnUjl0ckRjZDZyMEVz?=
 =?utf-8?B?eHpQZDRzNEtLcFVKR08xU2s0VkJEMmY2TFE0ZnhodGtjUTBNR3M2dVE0bXNq?=
 =?utf-8?B?dVlsTXZwVjBKNnF2Y1Izc1Frai9tT1V0TEZobmtrOTd4N3dkZkZzd2x0cWFq?=
 =?utf-8?B?Z2RjSUFZaFdTVGF1TVlqcDJORVRFUk92NUVMNjJCd255UFBIVTlBSC82VmE4?=
 =?utf-8?B?dFcxL3lmeDJLdWNRb05IcTdubXA0SGtMSjNDejcrY2FueVFyVGFtVTJ5LzVx?=
 =?utf-8?B?V2FVbnZrT24yMlZ6ekhyTkw3bFA2SkxMNkpVc25KSDV5YXZ4M0hrWTFObUNj?=
 =?utf-8?B?MUJFVDYyN0tBWFNLeTMwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFJQaGxtZ1EvZG9iTFNNMURhOXJEQTRvTkJHZkI5SXRHNzVBYmpEVnRaMkNl?=
 =?utf-8?B?TTJZQ3dodzM2Z1owb1o0aVVjZDN1aWw3cGdLRVFMNjNsRmlTNFZoMjhra25z?=
 =?utf-8?B?aWNjS3VqZkw4eHp5M1VMWmR5WnZEaHV2dDl6emxudGNEUW4xTHJLMlhMWEN3?=
 =?utf-8?B?alNURHFwMGJ6Y2dseUpta2RvU2xDcW44RVdoN041ZXg5bSszSUt0a3hnVXFj?=
 =?utf-8?B?aWY2RUtpb2hmOUZuZm5pVXlKWUV2RTc0R01IU0hSazEyTm93eUJMdmhwcEJj?=
 =?utf-8?B?cVhCVGV2RjF3YW1md1JWK3Uzb2FCdEloaktZbkc3djFIWFRaL1hNREw0ZW1i?=
 =?utf-8?B?M09TVjVmcWdvN0hZM0V3eGMxUS9zcEx3WlNuSmE5VHFXeHkzS1RjZURWMHZl?=
 =?utf-8?B?Z0FsdkY0dkNPZlhwZ0xRSVN1QnJMM0xiQkViUjYzYlpJd2JET0hVSER1VXdY?=
 =?utf-8?B?ZytWcmdKdk8yK1dZS01vVWhrUVVQbzVmWkFncm4rSjFIcXZXQURQcEE3RFR4?=
 =?utf-8?B?VXdiM0oxWnlxdUpLN25admRORFJtUzl5bkw3amhGY2ZKQ1lXSHJJNTM1UGZy?=
 =?utf-8?B?UlphcTRYNW1aWG5OUWl5TU55VHRpQklhN05LejNKd3FxODNZYXZ6dnFyaDBJ?=
 =?utf-8?B?UG9TWjYwZHlNaXd6VzFqeXhGMytUZ084T2R6Mk81UGQ5N2lGbjFpRHc4Tndz?=
 =?utf-8?B?K0RYMGNqSmowRllnZ2MxcmxJMzFvQ2ZHZ1BIM2w1TnBPUnhEMEc1bTVlakZZ?=
 =?utf-8?B?ZXQydDA5SkVnZWhhL2JiRUVSL2ZVbUtTNGJHNzdOaFpqSzBQZHQvbCtlMU1Z?=
 =?utf-8?B?Z1VaWnZwTEVUeXg2dU96OVhGN3NpbC9uckpob2NnZXBlQVMrQzl1N0QzWkhV?=
 =?utf-8?B?dHl4ekRiSUEvRzQ0c0ZHZDlKdmVLcnV2cDRVSkl4TWtkc2FaY0VtMUdNYjZv?=
 =?utf-8?B?N0JZdzBuTWE2dFZPQm1mRXJhVmJKUE9XY1lpNzAwcVE3U3VuM3hPM25ld1Rx?=
 =?utf-8?B?YjBMQ0RkQkUwMWtKL3d6M2VlYnJJMityRHZETERHWUxOM2pINTBlZ0FCZUFL?=
 =?utf-8?B?REZCKzZMV0pIdzdFcWlTR2RRanF5MzNmbWVXZjlVYUVGeFJqaDErbjlidmNm?=
 =?utf-8?B?QVdOejVkaG9qZjRFcWd3QUE3bCtHaVZ2cjZCT2x6bkxqWXhndUJWUnRBT0Nh?=
 =?utf-8?B?L1g2enkvY2VZNVY2eGMvbFMwK2pZUW9wQmFwUTBjSFgvSEczdXk3YWFiRi82?=
 =?utf-8?B?RGJES0h0TWh4RVgvWU03Z1ZqZGdXMkpEbG0zazBEWXN6RzgxY29CbXdteFRZ?=
 =?utf-8?B?NEdyOEFIblR1TUpnM05SV1l3b1crSkVlL3BsazNRTVZnK1lYVzBTZk5UUUh4?=
 =?utf-8?B?R2ZNUktTUTlLY1BNNHFlNVk4M2xQWW9RYy9LdGljOVJ5OHIxUDNzR0ZVZUlZ?=
 =?utf-8?B?cmlYZFBPOTNXSHd1VEhSUzdmdkk3VThUVTRlcHpIeGlWc0FyTnd4SkJFbUFv?=
 =?utf-8?B?bGJGVUJncWNUR1Z5K0RCVno1OFlCNHpVTFJBNmEzaGhvYjZKOFVQNEZSUFZt?=
 =?utf-8?B?cHhUYWc4OEZpVEZURUt1OUVqV0liUlczTTVuVUFLeU1kdXNWc2psNlZxdlhk?=
 =?utf-8?B?RTZhcXVTSkR6MTVrZXRxaHVGYmdPQmZYNXBRR0lDSGs2NXMwcjhuOWdJRFFo?=
 =?utf-8?B?dk5iVVNJaDV4N0FIOENFR3JoOGJrV04wOWwyRTFDb0V4MWdVNnVOWVRzNXNj?=
 =?utf-8?B?RldJUlNiYmxJdG9hVjIrR2RnVk1hbGw2dE44YTNVa3BKSnpTSXVTYW83RERX?=
 =?utf-8?B?L3RMSVlSOG1DL0NIYTJNS1FmQytVYVlKYTZLd3JZSUEvMUdyYkUzam5hNlVP?=
 =?utf-8?B?NFFrZmRtN29acFFBam9iMjNHby9FdGNRbllKRjRwSkZ6T3VvZGg1ODdYa1p4?=
 =?utf-8?B?Qkt1ZlBmT3lSVzhBUGZjVTgzVnQ1WERBVTZva1gxclZwNGlNTUtpclJtS1Zs?=
 =?utf-8?B?V2lMWHZxOE9tNEFpNUorTDdqcjJiK2ZPOWFPN1VVRVEvM3JpSFliUU90MlFI?=
 =?utf-8?B?aHphSXBKczg2Z1NDWmVvUVY2eFJDeUkyWkNJekdqZHJUb1NuVmlBeUxwSndz?=
 =?utf-8?B?WXRxa0xYTWVsOHdIZEUyZHRNa0RIOGtYanVFbGwwNEg1NmJ6Wk1ReTcxYm5E?=
 =?utf-8?B?ZjdSWVhWcXdjZHJwYlNhcXJkRXB0U3dnWWUwd2VjbXpDM2FCMEp2NXY4WTNz?=
 =?utf-8?B?RTU4NEd4eXRzY3RLNDVRL25ORU9nPT0=?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 610e14e2-f65d-4db1-8df9-08dccda4e208
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 12:18:43.1829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSPlfFXLp0OGN09Dvt8EQ8kMgAkGD8Yb1PEL2Tj8k+7YgxmVqNmd5hnZ5nn9CAsyYOGxMfR8+L6BDMBY5SbvK39cxkcZcFNsGmuaXnYbte8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9462

On 2024-09-05 11:30, Uwe Kleine-König wrote:
> 1 second long pulses with a period size of 1 second, so a constant high
> signal?

Hi, I think I was unclear. The SoC documentation is not that detailed. 
But I think I understand how it works now.

One register contains the minimum duration (d_min). And then there is 
one 8 bit register for the signal low period (lp) and then another 8bit 
register for the high period (hp). Per my understanding a change of 
polarity is then just a swap of lp and hp.

The period is d_min * (lp + hp) and duty_cycle (on time) is then 
d_min*hp (per my understanding of the linux api). This means that there 
can be different settings that result in the same pwm signal (if you 
double d_min and halving lp and hp the signal should be the same).

This means that when requesting a period and duty cycle you need to 
search through the configuration space to find the optimal value.

>
> Another thing that would be interesting is, if it can happen that you
> get a mixed signal. That is, if you update from
>
> 	.period = A
> 	.duty_cycle = B
>
> to
>
> 	.period = C
> 	.duty_cycle = D
>
> that you get one period with length C and duty_cycle B when the period
> completes after configuring period but before duty_cycle.
>
> Best regards
> UWe

I will perform this test also.

MvH

Benjamin Larsson


