Return-Path: <linux-pwm+bounces-2285-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FFE8D3420
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D752A284F6E
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CC217B50C;
	Wed, 29 May 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="k1PmCy5k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2120.outbound.protection.outlook.com [40.107.7.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59C617B4FC;
	Wed, 29 May 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977460; cv=fail; b=EHimYvHEUoaCZ4WhEoD8VgGHxHcc/CRDs7Zc6ItflUSR3bvX3qYTMVwJ5zfEI2fBDEubuHHkW5Ope3D37FmAaRo3rAjQwKuWu/4wZbPhAfJ9lky6RqUzy0Dw6IZHIDnQHWP9gTn5RflwadOo1aVPS6t7a+MagW2+6bDUo8SsPx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977460; c=relaxed/simple;
	bh=E5K88vXd+tILtU2a58j1WVwDYcUm/GaqWKAXtLV+UgY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jNo8gnQfDrhRBMCFpZB5YwNJ/+YNg96wU04ke/guQVC0pYv5GDtq+Wfx0Y2nwObzrL+dHBt0nSqxNh6IQmML4u6Du6v50xiaZUA7s9CXqHAjiOBWhWAVZJEEZpqzTzqTuudClCtzcqEBmPVKawD4Z1UO8FKO4LFshBbYswDRHkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=k1PmCy5k; arc=fail smtp.client-ip=40.107.7.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exfHCjlRG1geJKyY5AhPZzRnuQ4IoNI4iKc2gYdf8fvqzWeI6XVxpz7zSOFuGaVXPdM0ABnWvOG5nBJypQJcerTTot6kqaleWaI82voEh78f9IDyYYc8f+FB8j8+39KCKXUSO6KmVlOE/2U1hj1U7DbSFCmCRVkHLzq1Qdc7yfMuZcUOtenYadI0TTH9lu6awo97ZkBBxVwZdSRqyPOXZuIlcSOQBttowEerdPKco0LyuL4SDsrvJraoR2ACZO79rb21lXAH+VvyKvQ/hAb/s9iNMEF7uLvdxVMn0sZA1QDbnDx7Z5mzSeQaH+Y2ANqGNw2H0gj1i3HBFGjgruOibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1jJiRoiElBzJxqW+tBes1orTvu25HSPL9hW3V570Y4=;
 b=kb62oZ5+kcRM/dovkmtrOqwCAE8Zb5OSYc4QJmteBSbMRIlyi33zvetqJPQplCe/yF0tEu64fha77vPFO+wIMwWpnHG4Orp7BM5mOUYvZ3LXe0zMKQ+LNWzTF+JcLu2ITQqNRHnXX9ptOoHFD8hAzUiHwDxDAs7XPXmORlfmQYycYivsq0fZCy5IGzTPJ2s9Eswbs/mEG+eMEc5sb0z5hqS1P0Wkup0qC+hW29XQwChDcY8GE1kaFpJkjPEH85bxfS9Lnm92SaMz0STVTQRbWKsO45SOd0zXEwhYdSJshU8pQHE+bo7WALa4l7ID7R8uCeKXSHmG4tKMJO9tC2nR5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1jJiRoiElBzJxqW+tBes1orTvu25HSPL9hW3V570Y4=;
 b=k1PmCy5k/PDn+sKgY0MZa3SsP3mzPDtiIhG8/c5DcdMvPvXGV7EMBijOfEI0TLAUEabc+0j/vGBRVnxlZA+UxRm2DgnytFD39aSWmKiIWEFeTVTrJXkEiS/b2EimcpfiBu9RdADe09TwPjNcwZQ7Qoi97s9vULgHqiQpB8Ju6HQ=
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
Date: Wed, 29 May 2024 12:10:32 +0200
Subject: [PATCH 3/6] arm64: dts: rockchip: add pwm-beeper to
 rk3399-puma-haikou
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-buzzer_support-v1-3-fd3eb0a24442@cherry.de>
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
X-MS-Office365-Filtering-Correlation-Id: 387c1acf-58f7-4990-70e7-08dc7fc79e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG5JTXpLQVEwcm14b0hsOUNqR2xFTkI3Z0RndURiNFArZFQ1VXI0eE8reVhK?=
 =?utf-8?B?ZzRxTkFXZXU5a0Q4eHJqZWZuRGE5VWNMQzFsT1JZNVJodkhWNDgzcWpueEMy?=
 =?utf-8?B?UWtMZ2k0OXhYTExORTlzdVk1TTkxMkpFQVZoVkJKTFNZbGVYMGxkdGZ6cERX?=
 =?utf-8?B?QjBEUmZTdlBKc2FHemFCWkJRTlQ4Umk2U2QzbFU4V251eXZwYWtIZm45TE10?=
 =?utf-8?B?TU00VGtGdjlZM0VTZE9vajR2anhSZ2E0aEFpZXBQTk1ocjVTWllhaXpCTnlk?=
 =?utf-8?B?U2NwRnZGRWxLUTEza2pwN2FLaUsyakV1cW1DWExYa2g2ZVdoVFFZMlh1Y1F3?=
 =?utf-8?B?QVYrV3piei9IWDh5WGFmaFVPcEIvY2R2NkhsaTdETkE0QWswSmhxSDR3ZW5t?=
 =?utf-8?B?TjBBZ05RZWdSUGpBaXR5Q3NHWEZuK2pTTE1ld014OENHYlEzWjIwVk9QakpI?=
 =?utf-8?B?RlkyVjlmSVpURHdMbHE3OXR4OFRmUUwwTVFHcVkwTE5NblZtUGEyeDNrWkxS?=
 =?utf-8?B?cmt4c0xMRVRMME4vUm1KaUJMc1gvSFlYdk9IQlV4WWpjTmpHNHBzKzJTdE1n?=
 =?utf-8?B?aldIQi9KSFFGa2ZCNjNhaWtMQm9TM2tHcWhRckRXRi83bEcxWmVQakNRekh5?=
 =?utf-8?B?RDNCUU1LNGw3a2JMWkRYUlVPU2o1aUxVdUNReDZWS3FFeGl5M2JIQkswNGNF?=
 =?utf-8?B?d0FxeU16YzV0NEU5cVgvakFIOVdVSmhlaGx0TGp1SGRnVXVLbFQwSi9ZS250?=
 =?utf-8?B?QlBYRkZaYmJ4ck5xSFJ3Vk00YmFQTEZwVTR6V21VZzhZU1MzcmdQaDIwcTRF?=
 =?utf-8?B?MDYyUlBqQ0ZKRCt1QnhqRnJmSGlvdkVBYUFWbEtXa1FTZTN3eFBUVHhydGEz?=
 =?utf-8?B?Uk9NNURVL3QrUzRmc2xYNS9NMkZacnZNdXhUQkpLRGppZUlHbU14bTF1N1N0?=
 =?utf-8?B?aFJ0VW5jOHZ1WGwrZHczNVUvVTA4dGhYM2pna05rSU9CSUlSTGZCR1BXZUQr?=
 =?utf-8?B?OXBtSnZFTDZva3JMT2JPWU5Kb041bDZGQmlydXczVzQwcDUzNkk0M1JQQ25n?=
 =?utf-8?B?Mmh4K3hsVUNsNGtRbE5KdVE3MnZ1SVV3S28xUnhhZ0dUc1UxU1BRVmNuYnpL?=
 =?utf-8?B?WmJpNTh0VkhhaG0xQlQ0MCtmeFFVQ050RmMzSFJkMnpOclh2QVVFcUt3SU5U?=
 =?utf-8?B?OXZMcWIrSGlkUEEvRVpMNFlKNXcxQXRCR1RXZmk3eFp6Yjh4VUtFQ3c2dDdi?=
 =?utf-8?B?QmNYeWhYWWd1QzNiQWtQdzBVYUdzeFYzc0padlhoN3BXRzNlR09zR0s4bXVG?=
 =?utf-8?B?UEZscTE0ZjVuNjlOVUNlWms5MFhCdHNYb0JvZ3BnNEtOSmVxWEx0QWZVQnJF?=
 =?utf-8?B?Zjg4RmFDUnJFMTM5S1pId2tub2Vqa3F5RzZaazMyazZLVC9xKytTeGNmcWlZ?=
 =?utf-8?B?ak9jMDlNeG5GRzlpQnpvS29Oa004dlhhNzBxcHBEaGwzQkw3emJQdE9tZi9s?=
 =?utf-8?B?NlV1OE55aVhKUm56WUhaVnV1U2pINFMrdWEzNnpxOFAwSUdVc1hXLzF1MGM1?=
 =?utf-8?B?dG05UkRiNEtIb0JLQzZERyswL2EyejhkK25DVlJEWDRJUTJ0ZVlJT3E5YUhZ?=
 =?utf-8?B?elRxaVc1UXRoOUlSZXNNMVp4aXpnU2tNMDNobnJBM0VHVDQ3WEJheVZ1a2Vq?=
 =?utf-8?B?bDhHSkkySlhKeXFtZWJoVEdNdXZQdWlvdUlPVENjekRCSEdTWlpNU3RoaTA5?=
 =?utf-8?Q?ITQt6GtJNk8P1XZJyVKg8RDFYxiLkpgvguHcf/0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGEybkRnQlB3dCtIblZJL2xPSURQbGFXNmw2ZThmczJ2N1ZzbzArQ2l2eEk0?=
 =?utf-8?B?UGVTbURxSUlZZ3hwSTl3ckI1aXJPMWcycytFSU5TSDAvVlFhUzRsT2paZSsx?=
 =?utf-8?B?Rkd2U3UxR2drYVFsbjZVcjJobEtHTGVtc2hjMEJLOEN1WGEwelQ0Z0NPbCtE?=
 =?utf-8?B?K3NVNE14K0R4TCtFSjlDaFlLMnlQK0t2dzRhUXVnSTdOaWNKd0c0TzJ1WVVY?=
 =?utf-8?B?aUxWYk1GV1ZlS1J0MllRTDZ0V2YrWlRRRUF6T0U1TXJGOG5oQzM4MmlWR1JL?=
 =?utf-8?B?VmxRVnQzeDU2cDZ3TkcwbE1QRkNOUGVKRGxNd2o3L3V1Zis4SG5nVis4OTYr?=
 =?utf-8?B?K3NXZUZBSWs1RVUxTDM1YlA4VVYzOXQxMkI4RWVlUlE2bVZMbE5qeDBvUlhj?=
 =?utf-8?B?aHZQUndJRlk3SUN6WXdKTVFZbzAvMHRHcHl3Nmt2blJ3Y2IwTFRRbCt0YThq?=
 =?utf-8?B?RzNVVUdVQnQyKzlZdVNndnJ2NE8rNzE5MFIrelBlR2VwT1dBWXFGcDR4K3RG?=
 =?utf-8?B?U1ptM0hDcUpzL0dzUGE1MDNoKzZIbHIwdmE3S3dtVm8ycmxaVTZpeFN0Z0p6?=
 =?utf-8?B?NzJlcWtCbmsxOUZhbHhGWTgwRG1Ld3duVlFLVnhDNHFZSzY0WVNkak5RNzV5?=
 =?utf-8?B?c1J3SnRrbUQwWHJ3L3RYc0FOU2tIZmF0QXJIZGFkSHNVRVVENkZIcGFDbU9n?=
 =?utf-8?B?YjBQdWNnbGNLdnBESDRkVENSTFRUNFhETW5aRVh6aThMclRpZllvaWJvQS8z?=
 =?utf-8?B?T0k3WGVleUxLSUVOVnNIeVNPa21UTDMrTVE2SThsamhsMit5T21FNFFVUnZI?=
 =?utf-8?B?KzBPV1dBK1c3WC9PRDFuVFRUOW1aQ1cwYVA0Y1ZBZUlrUXk1T3Nobm04d3Y5?=
 =?utf-8?B?WkkrWFhnY1MvUXJjQ0hnWC9kY2lIWkFPNGZaWUp6dkxiV1dLNC9QbUNNemxO?=
 =?utf-8?B?dUx1ZlY0U3RIWXl2TitoRmMxOHJtcmdPSHJKU0RRUXpVRk1pWGJDWldJaHF4?=
 =?utf-8?B?bHRFT1dJek9HdE93OU1nSGlkeTV2Rk1hTndzajNZRDc2Q1VyZXVNL0wrZURh?=
 =?utf-8?B?b0tjc3FQRUF5Q0hZdFNBaHRyVHN3dnNUaFJQVlhxcUJqMFMwK1FhVG1VTFNG?=
 =?utf-8?B?cTZkRTNuOEMrMFRXMDAwYTFNYjlGMEtTY0gzTWtvb1pGUWZScGtkVm1JQ09T?=
 =?utf-8?B?QkVqdWpBYlpDbDNYaUptTzRaYjVoa1MrMVpNRDhhZDhQemd1dExOSExXVU9p?=
 =?utf-8?B?bkl2aWo3SXFjLzFlVll3YmVoSTNFckk5OVhicW9qQ2xNOGt6YkZnbVRBRStv?=
 =?utf-8?B?bFFodzNxUmROTnpDeG1rWlZnNHNpRXpjUmFwNzFwdHdsbVJXeXBnWFFwZkRI?=
 =?utf-8?B?ajlmWHFLWnZuZFcrTGdSOFJhZVZmOGVKMTU1amVPcTVoR04wTXJKeFJwdTVr?=
 =?utf-8?B?Q2FyWDRTUWFyR3MxWUpSdm1zUkZtOEhBcDE1OGdWcWdJeXZoUFNjNkx3cXdo?=
 =?utf-8?B?Z2toV1pMU2p0T243SC9ncHB5M0tQOWd6VURDaFdITUNKb1BEek1XR3hPVVd2?=
 =?utf-8?B?Q2lGWnZXejJhaCt5c2sycGtVeHY1RHhyQk1KTXBvd3VWKy96TzNUbythQStO?=
 =?utf-8?B?NkJJR3NZZ1l0cTZEU1ZoQVoxcTl3ckpMT3RRL21UOW00T2JzVWdpUXc0MG5E?=
 =?utf-8?B?MmdReWdoTjJ3Ynltb2kvNmxGTHNmenQzbUVBUk9LVll0S0Z4QXN2Kys2Z2lz?=
 =?utf-8?B?UThzT3JEbFYwb0xIQWluOWJBU2JueGV2UVFqRGdHZUE3WCtkdUI1dkFFME41?=
 =?utf-8?B?Z3lwNENWRXRJTzNSanFkdXRkMHQyYmVlWVdsM29vQkU3YktPQWRGaXllbnMy?=
 =?utf-8?B?a2tldUphWERjVDVvcTVJL0svdEpxNGI4ZU1yYTNIcFZJZUNJTThiR0JqN0NW?=
 =?utf-8?B?YVRCa0ZQN3NHcno3YTNDemk0d1FFOEo0UnlTQnFMUnM1bnFOUUpYUzRqdTR5?=
 =?utf-8?B?T3RISG80ZDV1cDkxWVFOa2pVUlNzdFFtdnZsMEJsdU5aam5QRmRYdkw2ZWVH?=
 =?utf-8?B?OTlwNTRnanBTZXdDWWNQc05qSTlBMGxQdU9PRTFBcG5QcTV1eWlDaHhyeFdL?=
 =?utf-8?B?NDZBbUdvQjNENXZFSTMwc0hUdU1WdkhNTSszMEJrZU9DWnpFUGQwUnloLytR?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 387c1acf-58f7-4990-70e7-08dc7fc79e2b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:10:50.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2npFpS8JbcQaPBmjObijXY2IGdRKUuf79qeygShCYXr/gPvL1iSPFAXTS4CXukiM5l/iOkungCeQSU1VfU6vQk3X8e7YTQEml+hVjn6yMXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Add PWM-beeper that uses Mule PWM-over-I2C controller on i2c-mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  5 +++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi       | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index f6f15946579e..3d57c606707b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -15,6 +15,11 @@ aliases {
 		mmc1 = &sdmmc;
 	};
 
+	beeper {
+		compatible = "pwm-beeper";
+		pwms = <&mule_pwm 0 250000>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 69b57cde7d78..e3d2d27d4ca3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -11,6 +11,7 @@ / {
 	aliases {
 		ethernet0 = &gmac;
 		i2c10 = &i2c10;
+		i2c11 = &i2c11;
 		mmc0 = &sdhci;
 	};
 
@@ -395,6 +396,18 @@ fan: fan@18 {
 				#cooling-cells = <2>;
 			};
 		};
+
+		i2c11: i2c@1 {
+			reg = <0x1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mule_pwm: pwm@18 {
+				compatible = "tsd,pwm-mule";
+				reg = <0x18>;
+				#pwm-cells = <2>;
+			};
+		};
 	};
 
 	rtc_twi: rtc@6f {

-- 
2.34.1


