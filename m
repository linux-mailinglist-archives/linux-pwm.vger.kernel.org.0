Return-Path: <linux-pwm+bounces-2287-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46558D3425
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB98A1C23772
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569D117DE0D;
	Wed, 29 May 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="kUotTfrp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2122.outbound.protection.outlook.com [40.107.105.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2D17B51C;
	Wed, 29 May 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977463; cv=fail; b=KFj812qtFtG/tEGmS1+UqRCF1HE2I8Zh2FLRaIt1SHTYl379pxHXz4w0NG3mzOFVo3bLKx1Xj645m7nyPzSZyb4lPtMo0cE+UHEDDWAa25r5zYpYrrHSuZ5nmvdhZEIsNPv4VruWsdK+0Orb2+a/gqn6yj1bdGkA4/G7sxqMiog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977463; c=relaxed/simple;
	bh=acgJ9eLt5MEqg2YYyc3epGLTS3EsLW0MaWJt1OaIuxo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ufc85FXDqVSBoqi1cizJjUhNH1A9LR/LO6LXn8sGzKC8QkaUba8vcMdPJ/M+jOwTLR4Gs3MvAYXUiCcfkXt/d96v7ZDt/U3TF65bUROAyoRpR8zzL+Oa6pxeDjMWheMyaqDMsrRorwWeOaB1xejXtASKwCfstnD/isGqqYqtStU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=kUotTfrp; arc=fail smtp.client-ip=40.107.105.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+s1VfxtT+LElADHKlufzwOsjdMVe6HTpM6oYs5FcPmNQME9XXf+KLT9IalumCKGe5AQ4EBnNlNjDdMgygwLaJE0D3Nf/QE50nk0tcWHaLR1R/vSEb6dQyMAVdW2XsQEYIV5UWhN9Zss6yKgU/w9un8JMER115WEx0vpZ0jt6EmKiHZMsE2JehHOZ7XG+iP5q2ZDwRvdp74syAGWggjNYhnyxgrLMR9vcYnNMims/f4IqwaigP9dUB3k+DvBv6yHfZRXo1M9Gxva9CQJyIOlzIMbrbv8fwlWgbzwms6zioi9tmljikrES7or8JpPKzLM5FFI4HEQsXobVt2Xhdp8Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxWFOafSEWg8GVa7FIRUhdWVZTfHV/SfAVlmj0XA2tU=;
 b=FZ9aXV/W+P0J3fhiTPR0y0Dy6UaY7oPLMnBsdNQfn4yVIUHV+9tQThearPP9zUgoLccUuOdJnfO9jjsUkO3yq7ZLRG2cp1rG5hBLTFZMTwPOAuuIi4wTPHyWzmGpAroPZpupntbTeVCtDIM/93OgwS+90CWpwdcBSatN0kst8pbQcurpx+TFWFd7NA4KSfxxRCTy3fWWoQJ57WZJFfjbrxRoQhBirW8/tsw9xqMeo1e0d2dZZ9WrkRnr9Tjy1Olzdk3H/3nieLkUaCb9+WbAQbtZaNYoZ5zDpiM9RFPn4oAkb5g7w6BMSjCAf/hlj4T/9635CZT6rSFpMcpzYtbMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxWFOafSEWg8GVa7FIRUhdWVZTfHV/SfAVlmj0XA2tU=;
 b=kUotTfrposaVJkwo6R1xAxEtZcMnmXPkB5Jm/YtoGGkBQEtEC6nGKF3dh//i7tXVdK1u9K0lorKJ812Yij4C3hK05yK31kJVlrkMwu730Kf6+LTKeiw0W5Pt3Y4VjB54Q7sdEnGgrNiBfv1K4gJVFEw+FnpWsRUZSOyoDPV5/6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:10:51 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 10:10:50 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Subject: [PATCH 0/6] Add Mule PWM-over-I2C support
Date: Wed, 29 May 2024 12:10:29 +0200
Message-Id: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABX/VmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDU0NT3aTSqqrUovji0oKC/KISXWPjFEvjZMsUgzTDJCWgpoKi1LTMCrC
 B0bG1tQAqsYyYYAAAAA==
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
X-MS-Office365-Filtering-Correlation-Id: e8480373-6d0a-4f9a-348c-08dc7fc79db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3orMDVLeG5jN2R3c2pWT1dzS3A1Y1BwMVZWWHNUYmRBRGwzcjRkY2ZCL3R5?=
 =?utf-8?B?NWYvUTRDWkxQUXAvZ1U4Q0NySjA0dE54L0oyM2lzbDA4RWVkRHpOU2lwMTlj?=
 =?utf-8?B?U1d0VlRZSElwUUtOTjFuZVhCSmhtelIreVdpeXd6eks5aDVMblUxcEtVeHFI?=
 =?utf-8?B?T3JON2ZHaWN1N3d3WDF2QlRJMmk4Y1JoYklYbk9PVjdpTml3OGhHS1hNT29v?=
 =?utf-8?B?SnNhNGIyQXZjT0FNdDZhWnBRdk1jdnFqMjhIb3NOcjRSdHY3dS91UWEvYStL?=
 =?utf-8?B?dHB5U2lLcDJ3dzR5eEVUd2MyUldqNFdMRERhNnBlTExqYm83djlHUG05bUov?=
 =?utf-8?B?eWxCMVE2UEtJRDVWOEVwVm9LRnQ4MStCL2owZllmdGlLZ0VuazIxNVVjNnF1?=
 =?utf-8?B?eUxoZzJ1OVZXeFVYZk1ZWE4wQ2xsV3JJcnlFRkpacWdlWWpqdU5IdkNJY0x2?=
 =?utf-8?B?bmNmdXFQQWtzUnY1SU1Pcll3VFNsMk5mNzlYbGxKL1FTQXlKeVFnQTJmYzdQ?=
 =?utf-8?B?NWdVL2Y0bGVuUEJRMERWZ1lCMVZzTHVjMGp2dDRCaUFhbmV3WVZvRkxrMUJ1?=
 =?utf-8?B?a0tLQ0Q0SFAxQmZHRUZlQlgrcGc4N2ZycGxucGQydjB1cXFOZHNNWVhwSXY0?=
 =?utf-8?B?M0NKZXYvbFJlRE9SUUxyWjVZNnZGeU1pclRoYnZxNW9JRE5WS2ZEbTdYTkVv?=
 =?utf-8?B?QXJGN25GVFpxVkMyL3pkK1FkYmxydWhJTE10aTN4YTJZM3VOM3dsSHBSSGY1?=
 =?utf-8?B?YXFVV2FlTEFZMnRYM01pdTd0V2V4RldvTGxOQzlSbFVkdEVwT0ZtemxQYjAr?=
 =?utf-8?B?R2xhUGFQMUR0ckw2RjBvQ3lyQzFYRUxrMUM2U2JWU2F0dzBBNU8vRkZ3RVdV?=
 =?utf-8?B?a1dQc3NFUzFsdDhVaTRDWTIxOEdHSXRJeWRRODc1NWptRnJzUFdIYktEY2po?=
 =?utf-8?B?eW01ekFSUUZURE9EMnZ5bDNNeDhyVk0ydDJlVnpObjB2cnRzbFJEeldTdkVj?=
 =?utf-8?B?UFNoQXIvVmtDNVdITDVJeXlHNSs5MHdNU1ZXbHZ4VUlEdVBYdlZaT3I2ZnZt?=
 =?utf-8?B?ZDZDUmVINFJCQ3dYK1JmeGE2UnFMQUNoem50L3ZPN2xCZUIzVnlzVXE1L3da?=
 =?utf-8?B?WVlzWXdBZkVvemlJekNnZDJMMGNDTDhLVjZSV0oxTEZNUXorMkM0RnMxOE5X?=
 =?utf-8?B?aEpncHArbThMbWIyVXVFQ2pNSk84QVlRSlBibWJLcUhPQ2tBN0FDdXlJb29U?=
 =?utf-8?B?cm9QR1JqY21jb2NPOTZGaTA3Y29oY1c4N2VhQWI3WVhQTi8ySTNVOGdvQms0?=
 =?utf-8?B?SlM2eUV6c3hndlo4WmZndzU5RXBQcEtBQW9NQ0ZHRmlPeWEzcVNhcXBRdVJt?=
 =?utf-8?B?czVZMXlMUStQVHhncFNPV0J1OXNsWnQ3V1VHTkNrd0h6d3dDZEdPYWdHeU4x?=
 =?utf-8?B?dStwZldLR3N1QXhDOGhXVDlYKzA3cmxFS3RGRnl2b3JBWWZOSnBFa3cxc1FY?=
 =?utf-8?B?YUxFRkNyNlhhRmg0TTdyejNoanNWbGk3TmNNNnhJUGNrUjNPZDNKcHNVdkQv?=
 =?utf-8?B?TWxUTWd3RlZUT3JoeFdRR2pjeHV4VUlkZXFjV0JIRUxZSUx2QnYzVXo3STJ2?=
 =?utf-8?B?RERFMzBzWStZVkt1dC9SZFhUUnFRL1RTcWdJYTg0eC9HMHZ4RFVSWkMxcmZj?=
 =?utf-8?B?K3NTRzZYRDJqRzM1Rkc5ZWkrbHdNSWI0Y3B3TkdhUGZ6UGZ1dEZabWpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFBqMXNIUVV0dWliQkJ6VnVLcnI0MzA4UmhDcmdYUWY2dFFqcm1NcGdUMndW?=
 =?utf-8?B?ektwMzFaNFhrYzd2R3J2a2R6M0FxY0NCV3lxRjl3ZVlDdXNtT1FCK3g2L3N6?=
 =?utf-8?B?dGtCOWFuL3UvUDhtKzB6bW11d2JiZng2QmVhdGJHQjYrZW1yQlNGSVpMSWhW?=
 =?utf-8?B?cnR1R2R4MjltVzNtMnl3Rk1BcTVIUGg1cGIrUFdYekxhbnFvMzEvc2VrbFpS?=
 =?utf-8?B?QkdJTWJEbENJaEVZR0JVYUkwd1UwSUlYdnpWUUtEMjNVeGtHbjR0TFZLRXRw?=
 =?utf-8?B?Qk9wY2gzWW9FZkNZaHJpMEQzV01wZ3FaS2VaY0t0bGdHZnZ5Sit1YS9BbXA0?=
 =?utf-8?B?L3VERkRFVVd3TTRGWFQwa1dOM0xhcDhoZWx1aTN0cHdidHhiMVRranhWaEwy?=
 =?utf-8?B?QkE2bjB5QWQreE5RT0V1bVpqUnIrc2JvQTJiV2kwaUJ4Tm9PQzF4TTlROUZH?=
 =?utf-8?B?YVBleHhTeXJrTnkvdU95NUtHL0RpSmlyeEp4aFNqV2UzQWZNYlgrRDdiTTBM?=
 =?utf-8?B?eFp2TldNZldlVmRoR3pyU3FTc29KUk9JQm4wcXZ1amhwNks1azVHODhKMGli?=
 =?utf-8?B?ME9GaGQzRWlaQkZjNW5HeVcyRlNmcS80VWZSd0I1WUEwVXFZMHlranJOdXRK?=
 =?utf-8?B?ckk4bDYwOWJXNVd1NXpxdDRnZlpRb1QrMTNYYmRPeXdOQk4zV2JtdUpLQy9O?=
 =?utf-8?B?NFF2WXNkejZ5OXIzVnVJRFZaZGdlbVhzZzVrcHNObUdlODB0T0ZCNml1aEhJ?=
 =?utf-8?B?Y2pyei9waFZuYnliaU4xcjBjdklwZ2xrS1psdUVqbFRtUk1EWnFXNEdCUVZS?=
 =?utf-8?B?THBrdVV6Z1B6ZUpHNGFpRlBlSGgyWXYrS1FWVStiRnpXS0NrOC9PRGs4T2tw?=
 =?utf-8?B?NFpqQ3hUQzdZRSt2bTZtc0ZIM3pBUUFjTEc4dEdZU3ZWRU5WdXB1NG1KcVFN?=
 =?utf-8?B?SGROQmsrOFdXcTN4bm1ibGVnOFI1eUlNbEg2a29OMWxuK05UdUIwd0dhemNG?=
 =?utf-8?B?SHk5RDRaaGxvVUtMNlJlQkRrL2dPdzlWMm1zYm82T2ZQN2szOE1aa2d6blVh?=
 =?utf-8?B?eTJaSWV1OVJuMkozdlVuc2VLNElnSTlQdGxDZjZKYTYxVnZyS2pGcXFYODB0?=
 =?utf-8?B?OVRDaklTUW1xeUVpclVDRkhaelprTWFDYWc1U0JtWmozWldYNEJBUHkxQW9y?=
 =?utf-8?B?S09YV3RIcnZwQWVORjN5cDJRKy9sOG1sWU9vRndrSFNyRnFXS3FoV3RWSHEr?=
 =?utf-8?B?WXhzVklNMkp3YUlMVEtVSzE4SzRHRTFCZEkvMG03cWw1bk5qQVdqUzhpTDFQ?=
 =?utf-8?B?dG0wSFhKVVRQYTdTMThmbXpkUVV2aFlUcnJET1lUdWJnaWk1ME9pa08xQ0JR?=
 =?utf-8?B?K2hoSTd1K0RxTHNwbUFBQW5HY3pIR3NId1NOVzdHRTF6TDdETWE2bHZKRjBp?=
 =?utf-8?B?MGYxakNrdlJKWHdmanF2OUNJK24zMlBLMTVzM2tpemhpdk1xV3hGUWlCN1hs?=
 =?utf-8?B?R3AvUmpZMXc0SGNING9UY1Mra3FDd0ZOTmdYbmlVam5vTFZxaXFQTnRSSVUz?=
 =?utf-8?B?dzBRMC8vbnVtblhrZDVoYmU2c3lPUU9lOWNIQjRoRk5yTnI1WFpNMGtPeGVx?=
 =?utf-8?B?cHdWd3lmUktaTmVjd0c1L0VOMG5NLzFPSjlmTjhaWTVLVHF1SzBzWEk2anpO?=
 =?utf-8?B?QXl3MzZkYytBc0FURTIyWGZlVkVVN2VQTElUSUdib0tock9YYlcrSFR1Yi9p?=
 =?utf-8?B?bUZwNVgrUllTdDJSVzZkVFZxRTVGRE5IbExrcTBqY2I0alI5V1d6OUJCVkxr?=
 =?utf-8?B?c1NzL0RFalpkU1F5ZmlMb1g3ZjdPS2lnOXVocGNXL2RpZXd3LzIxMDVzeVRJ?=
 =?utf-8?B?dzVTVjZiaExDTVByWUt1MjRseXRIWTkyTW9OZCtiSEhDWFkvT3VvYjFhMXJO?=
 =?utf-8?B?ek1vMEx1Mzg5T2xLUHJQdVRDMHE0dWF3WElza2NBLzN6QVNEY1J5S2V5VEpj?=
 =?utf-8?B?MzBBMC9RY0wzT0MrcEtCYWJSQ2ZGWklkbWJHTzU1RnVWNFpGaGIvTlJ6bXlV?=
 =?utf-8?B?SUV2OFVqL29mVHpyWkpYbEVHbVA3TUtNZkJidXZ6L1lNcWFPQ2ZEMDB6Zm5N?=
 =?utf-8?B?TVJnbGhxVVNWOGhZRnZOblhvbnQrd3RZTjBBUzFYQm5pSFF3NEZXdDhyNzg2?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e8480373-6d0a-4f9a-348c-08dc7fc79db2
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:10:50.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjZUB+x1YcHSL8AlEsUsAQhc8R1su1NeHj5BfNjjgYlSQiv84zPw24gla2HfJgt7RHP8eI2fwzoePwn1iH9jhv1vKcdVHDtc7UiXu1iaXgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Mule is an MCU that emulates a set of I2C devices which are reachable
through an I2C-mux that is implemented in a different patch-series[1].

Device #1 on the mux is a PWM controller that allows users to I2C-configure
the PWM output signal.

On rk3399-puma-haikou, px30-ringneck-haikou, rk3588-tiger-haikou and
rk3588-jaguar boards, this PWM controller is connected to a PWM beeper.

      +-----------------------------------------------+
      |  Mule                                         |
      |        +---------------+                      |
    ----+----->|Config register|                      |
      | |      +--------|------+                      |
      | |               |                             |
      | |               V                             |
      | |               __           +--------------+ |
      | |              |   \-------->| amc6821      | |
      | |              |   |         +--------------+ |      +--------+
      | |              | M |-------->| PWM over I2C |------->| Beeper |
      | +------------->| U |         +--------------+ |      +--------+
      |                | X |-------->| dev #2       | |
      |                |   |         +--------------+ |
      |                |   /-------->| dev #3       | |
      |                |__/          +--------------+ |
      +-----------------------------------------------+

This patch-series add support for Mule PWM-over-I2C controller as well
as the PWM-beeper on theses boards.

The device-tree patches are to be merged after the other patch-series.
The dt-bindings and driver patches can be merged regardless of the state
of the other series.

[1] https://lore.kernel.org/lkml/20240506-dev-mule-i2c-mux-v2-0-a91c954f65d7@cherry.de/

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
Farouk Bouabid (6):
      dt-bindings: pwm: add dt-bindings for mule pwm-over-i2c controller
      pwm: add mule pwm-over-i2c driver
      arm64: dts: rockchip: add pwm-beeper to rk3399-puma-haikou
      arm64: dts: rockchip: add pwm-beeper to px30-ringneck-haikou
      arm64: dts: rockchip: add pwm-beeper to rk3588-tiger-haikou
      arm64: dts: rockchip: add pwm-beeper to rk3588-jaguar

 .../devicetree/bindings/pwm/tsd,pwm-mule.yaml      |  46 +++++++++
 .../boot/dts/rockchip/px30-ringneck-haikou.dts     |   5 +
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi    |  13 +++
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   5 +
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  13 +++
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts     |  18 ++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts      |   6 ++
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi     |  13 +++
 drivers/pwm/Kconfig                                |  10 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-mule.c                             | 115 +++++++++++++++++++++
 11 files changed, 245 insertions(+)
---
base-commit: fd8c3f3cd1b029f1851393839f7ce558db9cf202
change-id: 20240515-buzzer_support-33d93c9d0f1b

Best regards,
-- 
Farouk Bouabid <farouk.bouabid@cherry.de>


