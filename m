Return-Path: <linux-pwm+bounces-2309-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10518D66AB
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 18:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263161F26D53
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA8C156242;
	Fri, 31 May 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="gkBT0sah"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2135.outbound.protection.outlook.com [40.107.8.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B2B22086;
	Fri, 31 May 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172372; cv=fail; b=KDigOTRQNKdc5SMv+E1Qawr/We86GM+lULnFKllv7IzZJ/m8pc2yv/c7l39xTvUOcWcTJZPJGUbILD/oqoqGAdIxKosFQOqw0Ko1C/D22MmTQJjtoCmkwQPGctFLFND8TGKp9MPOQTF3TJ2wuYKZNKaAJHoqmQNcqPXITj2SlFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172372; c=relaxed/simple;
	bh=5JNtA1Rz6u2zRT5QTgp89+DIoogSuFRd1LD+ScOwhvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nd2fxlH6KpmmgxXPIAmd8o9d0iRRsCipaEdw6F1VbHM2e1M2NI5MxI57vhH+hikMAx+s//otvVN1+JC2R69YWhVMt9OP0Q/7iBfUuwjLPxx7BPlAbcJufUV4qzdo/aFhfjQxZibKUqCE/J3P6ebgmiYRqGFnWApsCNnkSi807jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=gkBT0sah; arc=fail smtp.client-ip=40.107.8.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb684Gp8r3krTrSDAkxM0ykg5B/UPbehPtRdo2PuuKPTk8P34zhT2AkIC0vBQ0dOtVs4+Foe/GaqYZ4znxtbdCGmyBkhMzYQyypzw5vb9rmgThACLs7UFawqC5Uk/pFuno6afBCkn9CRE6qllXnjYyaiGHJ9tOMusAaZCAX5nBYPDz6m963Jj/bmTX66Gui2HwA1chSnEZ4d0wtrJrgb2ktcZ0UhzokMuOjSaHUhpsPkSGRphGYu9Tta6wTAdOScaib1/ioD+PR4LHrQSFQGo32MU/0SbkjBqUiKiyMqJCHvc3jg/ibCmA7r6SznQaRfJXBhy78uSpA5J50qcq52pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNDPPkiCHwg6fZEKWaZFL6hVman0cfrEWRTDOjAvU10=;
 b=TNXoQ46qPnd/zIwClnuEqlQQC/q45OfbdB/NVE0l0IULWbyOHY2ttuqk97doeWn6z6+pgLQGmrwt4VND9ihbXtjJEPs36WAl1KKmvQroi8FTGrkvRuOVF3V2FvuFOjiH96dyf26zJLthYh2DmdPcnk0kCIFB21iZ/pj/EGZfJwU9MjFp1C/v5WdffwY29sssc3D+tPFpReiaE1ycnP7xXZ7aOE+R1lBpWYZQeFJxbc3bBA1tjcF5ZlPuc70+DO5uoHutRO8+WpIjLgjON5Kz4v/fkJeK/d6W68eQ9KDxRgkgKhWliFZcA47cOyYEk1y4BvIbZc0jzRAs+1Z78B63BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNDPPkiCHwg6fZEKWaZFL6hVman0cfrEWRTDOjAvU10=;
 b=gkBT0sahJJxIzd+9ENLvkdWVz+Ru9GiWGhwQEjbHPnmPTBq5z1n3DucGvLUJgT3xiV8yYwZdrzBFUDffuzKDpk3CuBJqKITlgb9wizxEL/NyfBH1RPxfePiNBFYO6R9rJqsaC+7TgIrDj+T3unz+SzmPNhAEDeyEnS1k0THW5ig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AS1PR04MB9581.eurprd04.prod.outlook.com (2603:10a6:20b:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Fri, 31 May
 2024 16:19:26 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%4]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 16:19:25 +0000
Message-ID: <0b8e06a6-9b92-495f-999d-9dfc50d17b7f@cherry.de>
Date: Fri, 31 May 2024 18:19:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: pwm: add dt-bindings for mule
 pwm-over-i2c controller
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
 <20240529-buzzer_support-v1-1-fd3eb0a24442@cherry.de>
 <20240529-capably-overgrown-755bb11ece69@spud>
Content-Language: en-US
From: Farouk Bouabid <farouk.bouabid@cherry.de>
In-Reply-To: <20240529-capably-overgrown-755bb11ece69@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0025.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::6) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AS1PR04MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a1152b-1d3e-45b5-9fa4-08dc818d703f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1dyUVBKY1RNckhXUlBiRHVFR1pQN0trTm8zdWhrVC91N1NQS0hNZXpBVzhl?=
 =?utf-8?B?OTZsZytZQ3hkNElldnJleXlTOUc5Z0oyVzU1VktEU3pPZ0hRWVNCQTZncFd6?=
 =?utf-8?B?bDlKV1VQaHhPUG4yVGdHTUoyeDlqcUgyN1JGeTBWak1iaUhreGx6MkwzU2xt?=
 =?utf-8?B?M05ZVnlNQkU0Q3YrZ1djK01nQUVCNTJzMG5xR2l5L1FkZFpQT1JBT05OMldH?=
 =?utf-8?B?Q3NLRlgxUWx2V1Z6WUoxNFpLN3B4a0gzdWtFN1lnaEhnM280TXlCOW1lQUVa?=
 =?utf-8?B?c29TZHdTQzdoMkc2TGk0ZFl3bWd5M2RQcHJOSER0TjFJekJvUzkrdzJmb3Bl?=
 =?utf-8?B?dDBWVGNBWFBLZndFSjFMZEpDWk1BSFlybm9vYVBnS0xjM0EvYUVUdUxFNFFh?=
 =?utf-8?B?K1Y4blFtUE94dVJpdkllMG1BV2hXelFBYjJESlYwVjQycnFLVVhuZzdEMjdG?=
 =?utf-8?B?a09pYVdJMG90d0QvVGpJNkQvTGxVN2hQRTNMNDVYaXd2TlVkRnFQZSt2MkxN?=
 =?utf-8?B?aW1QYTVBczVTdG9rMzFSSm5teUYrR3dqTzJMNWQ4clN5UXFWWFFZM0ptaXV1?=
 =?utf-8?B?a2ZVL1hLSC9Dbm9GWkxjWlorNE5ySzFFNFpHRm1UU05oRS9Cb2NHbmhScFV0?=
 =?utf-8?B?bkZOL0ZLbUNPUEkvUGRpdi96V2l2OVJac0VrbmF2VGdlbWlkSTVhMVZCeW10?=
 =?utf-8?B?V0dkWE1rc0hjbGhGbzZWeUVBQ2g1WGp6YUpDcFkydU1EMUd3d1R4ck96WitP?=
 =?utf-8?B?bzdnTjRzY3YzbjZVdVRXYVFJTkR2U2tEek5wcWdjWFc2dnpvRWs1eFJ4SE9t?=
 =?utf-8?B?US93SExBb3ZzOG9NSnBTeVZBT2tueDJ1VkdsYytDM3VHaVdBdEMyWGg4ZkJ6?=
 =?utf-8?B?L1RuSSsvVy9la2ttVlU4Q21pV2FaNVRObTF3Ums4Y1F0OHRNQ0RLVmtZVFFU?=
 =?utf-8?B?WndYRER6Yi9HNFQ2NWlSeE8vNTdlMkcyTEZZYm5XbHl1Sm9Ma2Q5QnE5dXFo?=
 =?utf-8?B?eXQzOGl4dWFVbGQybENOWm1tQmhIUk1QbGQ2aUxTaHhvakdWK2w5LzZ5SFVE?=
 =?utf-8?B?aThZOE1Ebm51YXVaR0xOMG9UdVl4ZGRXN0J1bXM3cnlJbHJkV3pEV3NIQnNH?=
 =?utf-8?B?cnlpaDBTQy8wZlJKaThDbTI2U2c3U1BpRHE0Y05OWkozTW02RjhjeXBYWE5q?=
 =?utf-8?B?VThoc0ppM0VITEZ6c1JKSVViYVhFeFBYNDBiWWFETnU1WHJzR0hRdlBLQzU5?=
 =?utf-8?B?enB6enh6Rkh4QkR4VUpqbVRKb3NHZVRjbDFHMlFlL2xYSDlLdDh4di9LQXEw?=
 =?utf-8?B?VTI4OG43TDRCYWpzRE5iR0VRbWZzbXFoWU9TZzhkTlJDaTlaazBNMWFlNC82?=
 =?utf-8?B?VW16bHVKajJtUmdjVitZc1F2bUQxRmJuUXZwc0xDT2hrY3p3WmQ2czhiMHlZ?=
 =?utf-8?B?RmkzZDh4d1NEanA5aWViYW5SQjlmeFlKRnFRMHFMbTU0ZXRiZTRaenVCbTFX?=
 =?utf-8?B?dGRGZkl3aFpLeEtlT3kvUEFSbW9MNkkxQlpJRmJNdi9Gc1g4ejNhQ0NCZEtM?=
 =?utf-8?B?MGxUTHFkYVRrejdDOUhua2E5RmJBOXpKS29hMVh0K3BYUEZiQ1oxTVcrQUYw?=
 =?utf-8?B?TmhkRG1xU1F0eEpjZHFaY0pHWUJTTndkZ1J4aC9hUFNjRFlVR3RsYUxZcDBI?=
 =?utf-8?B?MkpxVjRnRE9SOGNRUkNveTdHRGNzNFptYkRoR3pEdEFSeDdHWE5zeit3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW9lanZzUlVUSllwQlhNbVdCTmxUV1gxSjR1dDJkZ1d1cXBlY2JRT0NVTmpk?=
 =?utf-8?B?ejF2M2JyamtOeFJScndCSlR1VmljdVpTcHA4WEIrZU9yanR1QkVjNk56Rjk2?=
 =?utf-8?B?RExqL3lWQ2FRZnJQdlQrUW5CL3U0cTFSUE4wN2FzOTd2bVc5Z2NiOEp2T1dE?=
 =?utf-8?B?aVE0WW15MVdqY21OM25RQmVJZUVBZ25hOEVYSVFXdzV2U1E5cHdxdHpRaXY5?=
 =?utf-8?B?cnBocE91VFBBYzNiVnpORWFJcm9KTVFuV1JlSS94ZGdUNFRnRUxmN1VxU1Fh?=
 =?utf-8?B?Zy9qdkxBVWxabWhxYVQwdmUxczVzc1M2WURVK2N1cmZFdG5Zb2FOemtldkxo?=
 =?utf-8?B?bWwxT3IrVnlpQ2g0UHkxYlZsTzBvM0RYVEhlaUJHa2FVM2lEZURacWtBTGR2?=
 =?utf-8?B?aTA2dU5QcEtpbVZmSSsvNk9JKzN4Q2Jndkw0emR4M1VxUjZhK25PRHgwT2JV?=
 =?utf-8?B?Slp6N1pRZmhpTDNzcnNtMm9IK1RuRG85elFwbGNManV2Tit4WXRreThiclNO?=
 =?utf-8?B?bWt2eWNBQWNKd05TWmw1cjBCQXlrVXB4NkJCOU1yUzVGMmRKY29Dd2NTWXZq?=
 =?utf-8?B?dlhTNXpwNmUxUWV0UnhpVEF0UXFVSFZTQXViRGF1UjlYOUF2Q2V1QW5FMXFX?=
 =?utf-8?B?UEpUMVM3NU9kU3h6MytnNlJ6MkhvL0dUWVZCVkE0bkVqSVQrdFZjQ3lBTjE1?=
 =?utf-8?B?TTNjWkx4bHE4QUdZUmsxb080MU9vcThCV25XaTZLdlcvcStubGl1NzBQV3Bl?=
 =?utf-8?B?VnZRQ0pIOWtJcGNmYlZjUyt6Z3c2NmNvVWhiSy9KZ3FjcGNDN21TU2MxZy9C?=
 =?utf-8?B?dHV5RFRGNC9DNlBZYWo1bW1DeFJKNzFHSG1ib3R3ZzZ5eERmU00reVZDT1l2?=
 =?utf-8?B?WkJjQjcwMEpoU2YyQmNQOU16azVISjIxTUlvNUc3ZXNUZFJ6NnA2b3pEOE5K?=
 =?utf-8?B?Z0ZtVzVqdXJEOWVmYWVFeVJ4cVRObms5UVl3dllQeDlOV1hxVUo1dFhHMzd2?=
 =?utf-8?B?cXVmZlRGZUVOaXB6NE9oVG1pOEs5RFNMelh4NktQUnEwaEtjMzVhNTNUZ1BH?=
 =?utf-8?B?ZlNwMzRFTkthQUs5ZEhkVzJSMGVqOEZjVWU5UXZqeEZUTmVDUzZaMGNnTTlD?=
 =?utf-8?B?WEFBU1BVdlpoMkVQeTFvM2xHRjByL2s2RUhadUZvNXRRaTd4Tk00MFNxcnNh?=
 =?utf-8?B?ai85eHlvdjd6WUZERjNwRzhtVWRNYTZ5TS80S0RGVzRoK0NBNzlZMGt5S1ND?=
 =?utf-8?B?VDJoR0N2R2VkTDRpVG1UUXZOUG1aMmlvaUluUlREbCs0Z2dqZ29TTHQ5clEx?=
 =?utf-8?B?VUlHL1RqNTZaVHhTd01XYTVlZHhOUWpwY0MzZGV5bnhuOFNKOXkxQ3gxemFn?=
 =?utf-8?B?OHBFcUJ5RGg2MGo5VTFPSEkzV3h6OWt3ZHhnKzZRV0JMZGVpSkdmeDQ5ZzFx?=
 =?utf-8?B?QVBpZTRHNVNFZE9uV0VHdFJyWHNxWjZMeGo5Q25MOEJScWNVL0hKNWc0dE1D?=
 =?utf-8?B?bXhQd2FINllsOHlZMWwzRTFtZUhweDJxcENGOG4yRzEveXAyK09sczVxN2U5?=
 =?utf-8?B?ellON1R0cDhCN0dvZ0EyL2RnUVFZSjJZelJJcEJkaEhFWmVQS3dodkxFQklR?=
 =?utf-8?B?QzZOQUlXTy9JdFNybUFaREFnVkVad3lBc29UMXlWSzYyajVxVmJvZUx5TE5h?=
 =?utf-8?B?K21hOUt0SUswSzFmRjNkRzcwQkluM0ZuTGlLUnVQY0V5dnVnTnRtUU04OEU5?=
 =?utf-8?B?dC8xeGhQeitjemFiZEhsM3VIdTg2OGROY21oTEMzeHgwWEMxbnlsajIzRzlW?=
 =?utf-8?B?RWFqdEM2eHNBN1JSb3N4ZHN4WGV1VCtPNWlJc2Judm1wSk92ZldHTzQ1cFJP?=
 =?utf-8?B?YTd6UkJIeFJWNHdENjlueG1DY1c0S09RTVd2ekY4ZDVaQnVXUWV0bHYzclh3?=
 =?utf-8?B?SGJULy9TWUdMWVV0QkEyUFc0Vi9xZzhSaUFCdkc3SUJLZmpSNU81RmdYNlVJ?=
 =?utf-8?B?UHlUd3VpZ2ZaQUpIa3RvQllmWkd6WG9oc3lucTBBZjhGbWRxK3hONnV6RjZt?=
 =?utf-8?B?T3E3Q1JOUm5aLzB1Y2ZhVEN5OGQ0cjRPVnQ5RFBiYzlXVE5yMzhDQ3Z3dmdW?=
 =?utf-8?B?VmwrUjFlS1JJWEY3VjVtQ1EwbHp4c29VYkk4VWIzZW9Bb3lPRklVQllTdVMr?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a1152b-1d3e-45b5-9fa4-08dc818d703f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:19:25.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dURtGTA6JAaLsa56qr4sVCMTYWeCVIDjKRkHn73CC5wDX6U7EiNyotDvCJ665Phd409AGN9tCZrIfVU8LwLM/cLpTI4o2aEhXdgQjIVfDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9581

Hi Conor,

On 29.05.24 22:29, Conor Dooley wrote:
> On Wed, May 29, 2024 at 12:10:30PM +0200, Farouk Bouabid wrote:


...


>> +  A device that outputs a PWM signal based on I2C commands.
>> +
>> +maintainers:
>> +  - Farouk Bouabid <farouk.bouabid@cherry.de>
>> +  - Quentin Schulz <quentin.schulz@cherry.de>
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: tsd,pwm-mule
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 2
> No clocks or supplies?
> I tried to google for some documentation for this device, but only found
> archives of this mail thread..

You can't find documentation for this device because we don't sell it 
standalone. It is part of our boards.

This device handles its clock internally. So there is no need for clock. 
As for the power-supply, it is so far

always enabled but I will add a property.


Cheers,

Farouk



