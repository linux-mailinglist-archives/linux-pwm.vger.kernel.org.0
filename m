Return-Path: <linux-pwm+bounces-8411-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNjPAxk9ymnG6wUAu9opvQ
	(envelope-from <linux-pwm+bounces-8411-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:06:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE3357CB6
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3169306EE91
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618CF3AF676;
	Mon, 30 Mar 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t5BSUKyz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159433AEF56;
	Mon, 30 Mar 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860844; cv=fail; b=bsb+wM1ABP2mg9OBuY3fbaf/ieykK4fzX2vF+rktLue6apl06S30KScCIjp3VYjHTTJp81l8yDO9kHpiW4hpX3v9oFAhq3cZY/LdXzXIcQE5PuJdTJ8ncsUHQhTUZ5bcDNEkuXCUj64JCfeEgZqbaMTvxeNdQd+UwD8oIFFNTUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860844; c=relaxed/simple;
	bh=tlrSDCUE2UjLR52l+21YO4gbwl+bv/9DTWmxc/JzFOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QJ8OTB3I/G4gWvr8dlP8EhN39bZ7sLC34YQITVrd7aI6Mgfo24/Zddt2e4VjQESkaw1lAFhQHiRrUnNsfqHIJsVpiPQqCl7QemHaCnFZ5KWImOvVfVOnfUslnjrC6Ro1ecjGjzItQMETnOf8FJUDIEim8l5i36F5KbbrexazJwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t5BSUKyz; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nglzskks1EbCqyW7J3lcG6D+QtEq8J6vcXvKfAGV674H0BUvI5OsR8wU+B/oT5QDaGcMg05som3DfQqSe4vy/mMW0w8LlxpnPPweUw2JHMpeUxOqJqwY/rGz6PaU3dpPTIPbzN03wD52UgzrQDc4AS2h3FcA9Hw8XfCB3G8UqN1Mas6ztcEMvigz4ZzDXgp7/vuwKM8pk6tTbez3fn7sLjGbhhBBeS2vKx9OZ6xbtsbK5DnGas0yBRDg30HfO6D/2/Nm/TzPj0FJ6um645XF2KJ23TXAtBBQrJRdnUEztQd108HJR5SoB3qXIHkpMc/HPlNFblrgjud5YoJsTadDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7nx+hIrS5IrKIV0i7hW7FBku2wT+Zyk1R8KJS4P0gg=;
 b=PYNJSZ7uwjs/VnkvpM1KtN8gk209w0ICuOESCZQmdXXG789IaEW2SAlVhF1XjkP1vXS2mEnkVFOen0cIQe+qZC7pg6+Qs/w7EfkLXCwvKA3n2DEdzg5BtTEuwC4NIyM5Kf8l+7ZPndEOEfqmXWvLRzS+uKIvb6cEZALLACjAC2t+/JIYVAPuAsAlnCih+rP0I5rXT11Ab1ANXTohco78kUYAn3X5gS/3qhPtNRKQ4rcofTNgq8YYzoqnnj8mLiAm/chV+jJqV2bPJ5XV36I1whaRdUojjpF7sdeIStuxh9xURyi4JrSuHVZaTHdoN211CouzJ63K22xZaca3LpxuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7nx+hIrS5IrKIV0i7hW7FBku2wT+Zyk1R8KJS4P0gg=;
 b=t5BSUKyzQMg0aRCY9gt3r+x7xJ04gFbRGHaOL+DcsHLhTdON1lA1M9SDVJRo1pKtCWMYuV/wV6B2GFpcLlF0XtnXjRe6LVAKyQq65gfNcSmr64tlDQpkApNg0mk5yZqJB0iQFbGix8qEC6xeUQSkTnRPIQS/1nZj7+l1z0AZEfw4ZuKo2da8wjmNCtHH+tVC0CMFYFlZRzHRHd00WJYygZ2qXjyGDn3JmJVOHAu1gfjJTymAlQKcjcglUlRlP2SGsqSKnYbwGW3sAcqkNBYuM0uHroD1diuqfIAg59ZGsDY9Bg9oo+O6KLzCWTpYa1Ukzrk5+5Q7qp5AeEaBpm6xOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 08:53:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:53:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 30 Mar 2026 17:53:50 +0900
Subject: [PATCH v3 1/7] dt-bindings: pwm: Document Tegra264 controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-t264-pwm-v3-1-5714427d5976@nvidia.com>
References: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
In-Reply-To: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ba4ba7-9a8b-4008-9c9c-08de8e39e20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CagBunMb4sMv05s7EwOC9AorpUAcRHfU+onrfgPrdIAxbWNnOO5bwIWWwE3PAQnTia7khiuBx07F8dBtALMsQ/AOzYMrAp81BOQL5vIb06e6jw0h2sDdNiRQLfhHb2HYMSMYngVUfkCUSeEIWgpA8xS6OW4+zLFHLoIVfRiu1iiI2zytVHMNOGDE0Olj76pFVATLQqbOQZThGAKUXPdrLp0YVSjJrbw8UOth5XX3zT5JUjDbyytMMq2YwCBa4jLDbhx2sCNDVjyujO3l5hjivJ7mrrE/Dyrd/Kc70Cb5jhEhnsJSg4iWrWqfSZu0QIG65aUF0AQer9iZ7jHsXnVuloXNRdzbn3aSV8291J/QqfHr1ePE/Xc7RfnjeK6XUuMn3FRQxNDy1423VzhWU9nOjTDh3HkELAUCCTXQyhI+gVG2rVD/ifGUCXdvvcwK18XY8cZldIrMFThRsF+RSThGYWRDWSxgS33KXVsqi/2JVT+TwyS6DoXHZlY1JmR5/MW8laLWt95Lj3EyF2+odETrVcefp4llDhX86w3XlZtxVKDgwzxyeKczaEq/EW0S4SnhM9ASzoy+9EZf7Y2TgT3Sz/LDXQ8cK+dwVgCqaXiPv+XlRf6PEq7oaGjbekXXoF0Vt0+APANSgJoqSyUk1W75QwFeqAchtt+nT8uOwbe1YPMSh63nnUNLfBFPlHgTabUWP7qtMw4fSxgHZPe81fBpihrkS4pyqFvg/1Cql72+QTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnVUL0R4bENSWU95WG5aWWFkaS9qSVZIZlYyaFJkMHN0UHVybXNLN1RCYXBM?=
 =?utf-8?B?NU41bzNveEhqbDlER1I0aXZKWWtZQ2E3UHRCWGtPSi9TZS9ybG9IQ21XbHVw?=
 =?utf-8?B?dVU5QlcwTGVaeDl2d0FYc2hUaEYyR25ZTDBTZEpSbW5iK1BlOEFKdW56dUFR?=
 =?utf-8?B?L0xaeUFMRkFMSW1yRGhoMVIxb1FXaUQ1RkFkdjA4dUJFb3hpcHJ4azdQNWlN?=
 =?utf-8?B?Q2FuV2c2NXdORU5iNnhzaTh2YXJMdVEwdjYwVnJmYitodXlscGdHTGFVRUNW?=
 =?utf-8?B?Yk4xdHlGck1aYzIrWFJvYXVLdzg3d0cwQXNxMlBXSWt0VHdvckovL2F2V3JW?=
 =?utf-8?B?QWQ2M1pCeE9RcHdYK0ZoMzN3Q2VzRVJzRldqeWh2VWJOVzFRM3hHcGRtRCtM?=
 =?utf-8?B?NE5hSm5XZzdLbXVoUmFuMW82anBldE5ma2Vnb25PNU1La0MxUFVFTEw5L0cv?=
 =?utf-8?B?ZnZBZ1EzUGxYTkNITW1YcXRpdDBoVXFIeFJ4OVRYc3NMYzZOd3lRUzdzdmdQ?=
 =?utf-8?B?SFhSYkJBVmNYUXhQZEtJSlU2cU4wMWNxRVNpTGg2d3R3NGlaVUVIdTRTcWF4?=
 =?utf-8?B?cFJIWXZIY0VFZlhYbGZnM0RGZEhnZHpqd2VOSWR2WmQ5VVIrTnppS245RnFp?=
 =?utf-8?B?WEVpVTZJU3d1cCtnWUF4QTdOMDlPa20xVGE1U3kxUFRJU0pyb2NWTEYvK3pV?=
 =?utf-8?B?Z2UwNjVpOFFkblR3WS9uRjFpTEdZUFM3Z0pQSFlDL1cvWG1zRlZlaXNUdUda?=
 =?utf-8?B?Wm4rai80dEw5VFlYUkJXUEJmdnJFTC9tY2tsbVZCOWRTVG9PMG1IcHNuY1Fj?=
 =?utf-8?B?dm5VL1pnN0wrL3lOWWNCSEJQV09sZkJRQjhzaGpRU2Z3R0NnbFAyN0R3bDJL?=
 =?utf-8?B?cEREbmhnTEIwaHhZZHdxakk5NmJlYlh3MXNKUUluOU1YL21ORGlZS1R6cjVj?=
 =?utf-8?B?bVNNY0FXcjM2TWFsa3V0VUhqeVdDc09yR0V0U3hxWUVLVitobG1BV1BkNnpu?=
 =?utf-8?B?a3ZYSGFMMW5YNExHeHNSUFZNYlR4K0ZhTzVBSGJKVmxpS05WRjFuOXFKOG1p?=
 =?utf-8?B?aUt4eGxMTkxwKzdMTzdNWjVMUW9ORElZbEMyOWRRQW1na1Y5Z0FMRURsNEgx?=
 =?utf-8?B?c1ZwUnY3ZGhnVGl1MkVWNWFkMzdXYi9LVkx0aUlYS0dEUHFjSXpnVWl3S2lL?=
 =?utf-8?B?QnFBaGtUUlNscW1UajFTdnVuUnk1dkpmK1I0VUFJNWxTOWFaK01jdThzL2RO?=
 =?utf-8?B?aUhSUDR1NnYzRFl6cHdnR3MwLzlnempVdFkvWEVkWXM1SjhsMzZ4VU96WGJ6?=
 =?utf-8?B?aE9RcmtNMFMxYTlJRDhwWGtHMWk3eDlXOUZPR2gxVy9QK1NnMXVlMmFlMW9q?=
 =?utf-8?B?RTczci9ROVVtRXowNllGS083WXNzZmRRdVczREw3WW5YT3IvMitPTFhRWDc2?=
 =?utf-8?B?Wi9QclFrRWRSNHRrMGU2TWEzZ2xXaW5wZjk3UHJ5bFVJUWVGS2oxNjhhVTRj?=
 =?utf-8?B?OW14cVoreWgxbENYMkZHWjA3aklPQ05tY0hVTm9EcGhZU1FGY1Y2UzFTS0VL?=
 =?utf-8?B?NHFGMVFqdlFLWVRXbVZBUG96bm5hb1VvNWd6ekR0OExUdks0c0RZcDVEVEdI?=
 =?utf-8?B?aU15REphdnJkaDgxZ20vRU9rVDdkajA5ZXJyQzRtaklqT1VxTll1azB0d1Fa?=
 =?utf-8?B?dForVmx0OVZnbXVYUThUQktvUVBreTZadVFtQ0NkY3BOblFLMVFpZDVNck51?=
 =?utf-8?B?azhGVDVPSGFMUkY1SERVZnpEK2g3YjU1T0k1K1dKUjRWUFRqVmtEWmFBeXla?=
 =?utf-8?B?UW44YWJoVVhWa1VmeGdYYlgvQXJsK2pKRWtkTkpBbnFjVDk5UDEwc1AvVzlR?=
 =?utf-8?B?WXF5WkNzL3RHYkdxWE1iem5XVnByU0tMbUN5YVdaM0thS0J4K3ZFQTlIVld4?=
 =?utf-8?B?SFdlM3BYYXJVSEZ2cFVTY3RxUjhyRFNIaEdLV003MUg1ZkpJV2NOdVFCUThF?=
 =?utf-8?B?K21WQmFZa3dFTGFlYXJjRHY5UHJOYjcyU3RIWW91eDhhRHVYWFc5cXl2SjNJ?=
 =?utf-8?B?OFBwcFlSNktkWEx4TkU0a2lhR1ZqTjVESG82V3o1d1dUUFlFaUh3TWEwSm93?=
 =?utf-8?B?QkJDaVV6RWZjT2RBQmsraGk5SWRVRWVNV3lmZlNvZkszUjdON2JiNFByWUJH?=
 =?utf-8?B?eEkwMW9ua3ZaWmh5eGR3dHlkeEtGSTREMkhSRDhWb1JTUEJRZzZwUXEvOTVD?=
 =?utf-8?B?NEJIOFhZQmxCRDZ6SUl2eTFsRUZPUGliRVI3V1pFMTd3aXh5aVF2UkN2dVFs?=
 =?utf-8?B?VTNDNW5NYzB5aTdwaktzUC9aRmRoR3dld3E2SlBxNlF6b1lFcXNMOGpkS3V5?=
 =?utf-8?Q?gPBejOiRdRRnwOuUgACQ5FWAba8mcQCTAS2eoQ+nBq12E?=
X-MS-Exchange-AntiSpam-MessageData-1: v0n7jYEnorcGrg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ba4ba7-9a8b-4008-9c9c-08de8e39e20a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:53:59.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hlkHi579W5/2HUB8vQ5w92cSt2qEWyjcu617KzBV+h+EaJe86QKzzSmKne7RsZuiwPhl+AUWH+jZ0ICQj3VLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8411-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 52DE3357CB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thierry Reding <treding@nvidia.com>

Add a new compatible string for the PWM controller found on Tegra264.
The controller is similar to earlier generations but not compatible
with them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
[mperttunen: Drop extra Tegra194 compatible string]
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
index 41cea4979132..cb2f36e7b5d6 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - nvidia,tegra20-pwm
           - nvidia,tegra186-pwm
+          - nvidia,tegra264-pwm
 
       - items:
           - enum:

-- 
2.53.0


