Return-Path: <linux-pwm+bounces-2286-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A28D3424
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1689286395
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD2B17BB15;
	Wed, 29 May 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="X+NvYrjC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E67417B51B;
	Wed, 29 May 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977462; cv=fail; b=PwVwWvH3pALPDXqc/PB3A3udvNyQMTEwMJgNZ0adyNmkxCD2eFt817zvsnbS4H4+/2ShkWN2HtFrSC5RAfQjyxrDMPQPNpsAfCnS2KRGBflCt0arr17CxHzIQjwuvP89YCSCB1InuoNGrmiYC1xQ64DN8evmclDGPcH42O/4DU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977462; c=relaxed/simple;
	bh=QKCwY7xIPXrJHg3OR2Kbj5Gqm+QEGdq6mux2ZACjrM0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oOU8qmtiTeE8dUesp2BDaufKfJM+7C4vef0uW/ZqCQ9VmKAS8ipIfP0/FXybvSYoT44LJraVn9FerYcSo50UbJ5IF4Rse7RbsWWQ7P8aeDlgcFbCx6+ePN2ACGEDNVYIVPMp0p2IU1ybIZ1LuoBrut+asqXCHZ0LH5e5bsG8N1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=X+NvYrjC; arc=fail smtp.client-ip=40.107.7.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtoVfnd/Veu0UvQ4pZFXYWuUO3sktgNHV10ELzS+rW46oN+Jxsdf6APz2AkbFhX+i9uv/Uk8/c6EwCPY9YtLNGgtcGZ6xJUX2WTnY1thMjc+3o34Rl2OV6G9THIxZNgK5/HhBUnbnIeNITFHPQAcn99dIxluFzEs0fiVZA7gkGTfI0ShDeMhgcP3ZQnL0OyoSEfjOp7u1s0wo7qamEBLAbPv0jZtB8sgPgP0i8Lg7AcBE1Zn6EMjmaDlV/3/aNRwbJGCCI4t0U71z0DN1UwWhjUzRC9aFZ6V4xqlC/zheN2huK1qLZz5m9gOddmNkZKGRQI5pvwTtvbJcfX14hyneg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW/oIU6gplpCND+scqdT0ht7jRnXkj+EfCZev5q34yU=;
 b=kyonD4dQeqntH5CBcJ6hPKpL7AGfXK1gbIhOZi3WU9xB+FBmqvdFnBfSRAiW6nhYOOph6fQVaIALC2+ZjUdFKPYTI1Y76qDwZPS90t6Ue0MdfPklBb/3dQok+Wf/vMBC9zm+h8NuXIgJkR4Y0RYiMnQnTny7yeOkg4kudZaV3+eG7qEhZE+I9hIKjAsz2mJO/vdpISsV0kG7ah9AnCNgHmUgaU2JltjXWD7oDWW1Kh48rkKuZBMPqMegq4Bp9vkrk6O05sHIfsww4l3/WC4AkSrjG8oFhdtwDKGC9MYoOpKVHCOZFl1KLBSZeRqk+NxbT92sjc8wqclc28DdiWU+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW/oIU6gplpCND+scqdT0ht7jRnXkj+EfCZev5q34yU=;
 b=X+NvYrjC/rH5xpIEBzjDOhZTxDAdV5V7FdrE+HlhOaB062gsE780X8FG+dICsClcg6GcMpJXBstC8lOYiDx9ayC0eg7dN38R50kfzFHhKbhw6GEghw2vnrzEUpzR9PWJRmuHtNVGrnSQphNggylC5tAzhE/oaIv1maBc5YjbaIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:10:53 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 10:10:53 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Wed, 29 May 2024 12:10:30 +0200
Subject: [PATCH 1/6] dt-bindings: pwm: add dt-bindings for mule
 pwm-over-i2c controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-buzzer_support-v1-1-fd3eb0a24442@cherry.de>
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
In-Reply-To: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VI1P194CA0043.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::32) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AM9PR04MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: cf285f66-809f-499d-d025-08dc7fc79de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFlURk83VysveXJHeldIdUpIdTdxQmtDajh3QUpnZkxZSkcxZGMrenByWStP?=
 =?utf-8?B?a2VabER6ME94azMyYk05S2ZyanBHTXZFdkdaMkpONVk0WlVRZk1CZEd4bERy?=
 =?utf-8?B?QVlDUU5DS0dyT3gyZ2k0eHVjRENSblA1bUovaThKbUlHR0Z2Q1dLbDJQaHor?=
 =?utf-8?B?MWQrN3VDUjAzVytrelc3UVhsZHAzQ1Z6WVFSTGhPekZhUE9NOTZIZTd2aVRF?=
 =?utf-8?B?cnVKRVVlRzV6T1I3cm1IU0RuVDBuTkJuME5MM09HdVdOSHoxcFdJRzU5QURw?=
 =?utf-8?B?amtPeXFteGlQLytZS2ltWStUWnFtUFZwcjFKRGdOeVFvV2NTSk1hczdUUW02?=
 =?utf-8?B?U2Zka0FnTGRmcHBNTWx2dk5mQmhzbEgvNXJ2RHVaV0F4bUhQditrNmpUYTNJ?=
 =?utf-8?B?TXVicGJpanA3aFpGa2ppZjg2T3JkSDFTVkNyS2NiZitBK1hiU0pqZHBSOE9V?=
 =?utf-8?B?U3NNMG1zNEo2ZlkrUVUzRjNScFZjUWh3djBETjM2WFM1RWVsdGlVZE5na0dw?=
 =?utf-8?B?MnVkKzgwTVZCK1dHMU11UHg3ODZXbHk5czRQUFVlc2oxSmhrNUVuK1cwaG04?=
 =?utf-8?B?QnE4SkpsRXZobjQ5cHZsb29CK3pKSWRvTVJTd1JETHM2Rm1mNEpkTHVOUVdh?=
 =?utf-8?B?U0hEcVk5SVplZG9kclZkSnJETld2MndVYktKalRDMWxDZkdMRFVoOGRJZFBR?=
 =?utf-8?B?VCtVclh2d1dUOUsvck5LOVNRcW9wT0psVXg3L0RLZEtTS29pZlhNKyt1dm0w?=
 =?utf-8?B?azdGRXY0LzEvakk3ZmZRaTYzVXg3S1FwMnpDYW1wQUN1cWZGRjh6MmpMYlZE?=
 =?utf-8?B?Z2V1S05zelVRK0h5RFc1Vy9HZGZIKzRwRzE0TisxcDZoa0QvWUI1TjN0eGw4?=
 =?utf-8?B?ZHJLSGU1MlIrQTByRVFQMk5mK0VLODZIM204YTZEQkNacG5wVWhRUDdVUG9T?=
 =?utf-8?B?WlRWd1h6SXpjQWxjWDdhZm5mRUJKRWlib3IyMWVqeU9VQlZVNEdKVUJOUlNE?=
 =?utf-8?B?YVpFOTB3OWJMSlpyalNtQUcvc1ZnekE2MmoreEtwYTF3TlJQSy9Oc2RDdWF3?=
 =?utf-8?B?TEh5cy8rSmcvSTZ4OExZaXQ1Tk04V2I1bFkzdHdQVzRGbHNSSFdMMWlJc1Rx?=
 =?utf-8?B?YTdybnFMYW9zSERUUDNjdWZtS0ZtN3VsZXVqV3k2S3diNEowWER1STBwOUk4?=
 =?utf-8?B?Y3hJTkpOcFNPM3pIVE9YbjI2bUhhY3RmT0NZamFJekR2R3ZGVlltNDZiM0I3?=
 =?utf-8?B?Yy9jMkhWcUlRdmtBTHhRK2RSb2RKRHIvNG8rNlFQWVBoeHE4Wkx5NlNWNllU?=
 =?utf-8?B?Wnc4ckdwKytsYStCTEcveFNnNlNvejI3S1Jodm1Bc0tBbjg1bEZSNDBDNExw?=
 =?utf-8?B?V1JSYTZLM282MmwwZWFZYTQ4d1NZVGlxRzRnMDZrZHMzTE4zbmg1Z3oxQkpo?=
 =?utf-8?B?OWxINE84Q0Z0VkxmR2RIT2VEdEJqTmFWSk12SnlmSkRVSXZOUVdZeDkyTHp3?=
 =?utf-8?B?ajJuSWhNVXIvaVkxOHJuWkxkMXQrbE53Y2wyUnVlZlppM01XZ1Y5Tk5WVFly?=
 =?utf-8?B?U2JPVkYvQnlWeDJZWThiQVdKcXZuUUVHNW9CRUFicEw0WDJsT01FaDFNVVRz?=
 =?utf-8?B?TUoyanhFRjYyRzErcHAwb25kNVNNU1JWUlJ2NGVCeXFzbk1Fa2dBeW85dEI3?=
 =?utf-8?B?eWtpWW1JMXRhOHc2cnBiWXdWTTRxRVdvVHFRbGlJSEM0U2Q5OGVoTUp3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZrVFRsWWl6VFBjdko2THhCbk1DRlpCVHdGUDRpVnlkTll6YWw3aWE1Q1hn?=
 =?utf-8?B?SzV4c29weS9kRTN1dmJHeVJMMlVaSDlRaTFkZTlWV3A4SjlBQmNLTnhUL29z?=
 =?utf-8?B?RVlMRHpGQUd4OERpY0thbjRoTzhYTmFZUkIvZUY1cExrZS9KY0s1MnBuVzZy?=
 =?utf-8?B?RllyTTRxQ0RIUTJsaUdldEJVMDZ5U2lhWFVxL0RTZkhXYWRwYVpIUi9BS1k3?=
 =?utf-8?B?b0NHQmhJcU1KUTlkcE5JekVuR3gyQk1CT0JzamRsM00zSzE5MUlFWjdvWjJs?=
 =?utf-8?B?TzRGVm1VaG5hMG1TZlFSS3Q2aEdpTUhUbC9TbmhaWVNISE9ZUS9VUVBJTjRS?=
 =?utf-8?B?Q0hONTFpd3ZHT0cyTGU3MXpxZ2hLRGNnSWFTcEZTQzhiQm54UXMyeHh4bHhZ?=
 =?utf-8?B?NU1kNEdFVUxsSHJ0bWpNcjdDRGJHbVdPdlcrd04zYkQ0T1dLTmNaUzhUUDNI?=
 =?utf-8?B?ckZLbkZTVHcxNDdpOWJyUldzWEpZaU5sRkxWZ29hMFlLY1FHVG0rcEFRTWg1?=
 =?utf-8?B?YkdOVWRpVmpQRENJOTdXMWZsTlM5RE9iSEZuNEhpU1VKVDg1SlVKNGEwQko5?=
 =?utf-8?B?QzJ4UDgrRTJhVWNzU0dTSFB2Qk16SEJpbi92djBrQnUxbjVKR0QrVXVYZTcw?=
 =?utf-8?B?b0R2TFhpL1dCaitZbElNNUZ4TENiSUtKWlJUN2oveE54b0U4YlJ3RjZKMWRK?=
 =?utf-8?B?REkyY0d0bXJtQWNiTHI4ZU03L2RXYlZDeW5aNmFWaUtXUDVxU2g3UStGQ0kv?=
 =?utf-8?B?UHhmZDA5QXJnWTBGSlpjM29yVDZRMHdKQXNSQTJ3THUvMDBnckI1T0VCd0dh?=
 =?utf-8?B?WXB4MndwSVlKR1RTMTE0VkF4bUxnNUpuRTZCZnhvREc2bmk3YXZIUlFMelVs?=
 =?utf-8?B?YjhMY1pwejMvOElMaWZrdXQzMlBmMDlQSkU0VDZ1Y0VVSEhLbWFxczduZk1z?=
 =?utf-8?B?ZzhJSFZSclZUTFBEWCt4WEVpSTBjbjdGVHpBWjNjMmtXRHdWaUtPeHI1d3lR?=
 =?utf-8?B?bGRTb1hwT1FTY01adzRSb3FmWkE1cFdQV1BSMTYzN29nQ05Ka28rb2VUSWpE?=
 =?utf-8?B?OG9xRFB2bXNkQUFaRTBMdGtOWmRhSVdTZTh3OFh3QXR3UGFNVGFaN3lqZWpR?=
 =?utf-8?B?cWQzR05wMEZ6QW9SWTBqUktwbmZraFFOeFg0MDE5TlhVaVgzWUZaVEVEVGxk?=
 =?utf-8?B?ZGZ5Q1BDWHk3azNGMXZoSUNkZGJKdTBieVVnRjVvbklBVDhmTnFmb2tBcUVC?=
 =?utf-8?B?OHVJeTNrME1yU2FTUEd5REJIRWxGaWVVcFJSQTk2Z1ppL1BlcEZHT3pkYk5F?=
 =?utf-8?B?UEdTTk11MDZiK1haZkFPNm5LNEJNMVk0aCtZcmtKeDZ5QlJQZTdhVmtpbVV5?=
 =?utf-8?B?NWNScVBCTk8ydzdoWDEvNjhxQ29GOU96Mi92STI4MzNxMWxucHpBcjlHR0p4?=
 =?utf-8?B?TCswSkpmT3VyZktvckpHVDZYb2lBUEEwcENWYjU3cjdIL1M5dG5HczFHZExQ?=
 =?utf-8?B?b0VWK0ZldWhONHRPWFU4MlpxeTIvNm4vN2prRkw0dU92MmlxV29udnUyU01R?=
 =?utf-8?B?K3c3N0dlNjZobzFTNXFicGs2N2pHajFpU2cxNFkrSSthMWtoekluYWVhbElW?=
 =?utf-8?B?N3FHWTFXYlJzcTdMUkU4aDd3bDUreEtYalk1aVlpaFErL3dYU3Uvd1NwSnRY?=
 =?utf-8?B?TmxtQ2FQVTlHMktuZENFazZyUlNRbUdTN0NwZ3l1Ti9ONEVadURsTjJvWURz?=
 =?utf-8?B?dWxMdDUzSnZvenVxbVZuTFQ5MnpQbHh2SExuVjZ5eUI2T2VzMlk4cWVsamVy?=
 =?utf-8?B?WVgrcyt5dCtGU2wyQjZ6ZUNrV3NnOVl1ajF5Zmt2ZkxuYnRpcnhMd2t4V3hW?=
 =?utf-8?B?KzlaMzhyYlUrVUF1SEwyYmNrYjhlYXNDOHNzY3RmWm5UenlJTGhLRTA1ZUcx?=
 =?utf-8?B?MXlqenlLTWRHME5pNG80TWpRSGI3U1pOVDZ2RW9Tek0xYmV5NnZpbmZaV29m?=
 =?utf-8?B?WlJjaWNWUDh5RDQ2Y1RLMUJtUlFzTHVLUlRKcGJ2Z2VuTkZOK21rNFd2Sm1O?=
 =?utf-8?B?bFlmUW1WY1Y1N09ndDR6ZVhZaTBrRmhzTzJRaEZPcTZYY0psZnk5cTlkOUdl?=
 =?utf-8?B?MVMwcmFqVmNJZVBZd1dkMnowd0tBd25KMmVCQW5xOUc3akg4YmIyOTYzaUEr?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf285f66-809f-499d-d025-08dc7fc79de2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:10:50.5013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeGRL68mkUo1E65yp8dBtKxzAsfM3rTYYt1LpkMskNfchjslELQQNom1TIOvMlA2pZRRtasR2hC3lbh8+lhpJiljVbO2lqq/GtzmUu1vLxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Mule is a device that controls a PWM output signal based on I2C commands.

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 .../devicetree/bindings/pwm/tsd,pwm-mule.yaml      | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/tsd,pwm-mule.yaml b/Documentation/devicetree/bindings/pwm/tsd,pwm-mule.yaml
new file mode 100644
index 000000000000..71a940a2a644
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/tsd,pwm-mule.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/tsd,pwm-mule.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mule PWM-over-I2C controller
+
+description: |
+  A device that outputs a PWM signal based on I2C commands.
+
+maintainers:
+  - Farouk Bouabid <farouk.bouabid@cherry.de>
+  - Quentin Schulz <quentin.schulz@cherry.de>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: tsd,pwm-mule
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pwm@18 {
+        compatible = "tsd,pwm-mule";
+        reg = <0x18>;
+        #pwm-cells = <2>;
+      };
+    };

-- 
2.34.1


