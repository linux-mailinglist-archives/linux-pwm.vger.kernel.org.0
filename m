Return-Path: <linux-pwm+bounces-9193-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBRwO0P/GGoEpggAu9opvQ
	(envelope-from <linux-pwm+bounces-9193-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:51:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 672FA5FC813
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682433121161
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF2369997;
	Fri, 29 May 2026 02:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ed5ymhx9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD001368D76;
	Fri, 29 May 2026 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022875; cv=fail; b=Xy6iDWyjnuGFY4WHUihKRXGAfEFLGPYzh4JlIiCgN74rLGpH6xXgD5JZZYoK9MT/z217zc7bkEFY45IS+nk9PCcoCyHXTfh27o5grSG7Xnu5KG7QrCwZqMNWznM2uIY/g0EFL99xQI/Ewm2e/twqiRgXAHxierfHgTmT4Xy0ZIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022875; c=relaxed/simple;
	bh=J30ckZVC+LVvnbEeqVB12O10Lw40acyBbbfOXpoK1nM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IbU+iPd9qnb8zKaneuHiv7NlD6deh6eVzC6vConjwCJbcJkrRk1LM0QuZcee8s4mawn7ipR6u5bsLJvzmrzhI9/vGww7UZd7W/ML24Pvsrvl2n4lm00XXhEZNAzc3felqdveyxYJq8A4yQQ0t60TM4ydPRultEQ/8b835WfpgEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ed5ymhx9; arc=fail smtp.client-ip=52.101.85.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EQ+y95be6P72DWPpGbMiQ0WE4PFqGtYVocAwlhzCxCzuFDsv1Zaw1NDT6U5J1MoBD2jW4nXFSBAv3kakDF7r5eDoZcm0ABSwsW4pzkmc1cer822qcp97KMRjJfVOOE1TGjrLhvbhRoo9UomGqDnbf2MjJwQXal5lWl1wYvc8rezVmE9CLtTu96ZEXgtYoVW8m1ETKQiCxt3d6+E1t34Ps3m4mGerkM99qx/wmU9IRfQL57QTaBsrJ96aiD4VYwaAYOtJRc/zP1lWxzJYna1uQasv4KZGwEbvin+Yf7IcpEuHHquO13IBnBx8XwEGPVz8A7UlLkL7dZ6rc3oNz6lGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATglbpRNTGolB+U6F2IdD1kP0uZX7sVZYopkSNWb5UU=;
 b=zM/sYLC8dQQSisJaz6+0Y51EF/NSJVt/ULoVoF6V3ZZyrwV+iUoTlFu/+pVW3cSeRHXiWkSvEJfY3RGqbU+tbv0LHf+NfxPwPf4wuJdmU2f9s1Bo1AV5psDTZiZRVmG63jb86EQJ6I76KV4ycAeW93DGT6+KgaCOCpbgzy3AMlMCPEAqh754YyI6Mtbxrv1oLHBTsHcW2OKwsl6k6nnFxrOf8UFISuE1oQLVprCv50PTZ27rmbFaY26H9m2JqQiNGWm7Uxk9L2WaAkKzoKj/772yN30QPGL3sSNlTWcx8wdYjlei8pKXeLWR7QSYkSZGL90T/tdOzN5+SxKUigcDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATglbpRNTGolB+U6F2IdD1kP0uZX7sVZYopkSNWb5UU=;
 b=Ed5ymhx9f8BeufeBCcQFU6X8Nla0EoV0bBx5S3jHmw4WP1/45b+boA/RfPz6ZQZsOnPHvJ08MXE3M1z3946Bhc58NEoyJTX0GZewVq+q6kKN3lcLZU1kTy2ieWTHoXpjhDj0z4Rx3fumqId/AUrbJcDZ6l+vdzjNZPAO+QwupWlZ258/EG/whZFwlLS604nThgbuwncQncn8GngaACc8daKsEypDLFWlP2vP+kCcVsnKRT6xBVJZQKj9VGfQo/fiAts3d6NtuiKN/9e16bWcdOn0yNkAms1p5uIfmyWHOB6XDRaCH2TLmA447HynIaYjTrxvSv10mjvATd4Ugj0N5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 02:47:50 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:47:50 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 29 May 2026 11:47:23 +0900
Subject: [PATCH v5 2/7] pwm: tegra: Prefix driver-local macros and
 functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t264-pwm-v5-2-7bf9e405a96a@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P301CA0048.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 819449e2-4759-4930-1d0a-08debd2cac76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|6133799003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	B3gpRUBQ5rw+q5PFUncAb/iCfkJFpdfC4hp4Fnx55vK0QMWYGhx23BIvbiVOZewZT4XcZRdgE8AkS6TenJtBuysr1McpTMesI59cndRHl8LSEkTrsrqTLbeUdP2mXB2t05qIdwJ+uJTh/V4AN34/hcSkD48mJnkVWAoqgvBmSSkTDVy1Bs1EDrjyFFIWueH5Jkk8HZofgWLzHG4ixl9Hp6Nvg7YL29RnhiXcjf19Lx+2e/GN/YqZBHS3wu3cLVlQVxSFkiqx+3QojIdVQ0YSriRNZdKtgPIahn8MVbZJ/khz53wiMAJxiHpahpvXHLu861/X/RflM55FazvHHtH1gkqFOPjvMUOEHRiHIYuqzwwu8l/6PyS0As1ZuTSb6Il0UP1RFrtyLYQyuEHV3mBTE9K6uu4wQwfnRxEihf87XvMCiJoKl8uSawF9piUjLE/cuZzHz2ClfE9pw/gGRhGk9tCtm0aBc1zfVpGwGVd+kYu/pxOwPIvVNKn14nvkC8JP9fpJNGMkGHqr8FiQ+LOl4Yw5w9H9LwDs6FdT8M5baOBjfA+kLE8FIz2VkykFmQEUzKK+jCAGwkyni7KfeW8yoZJHIt6YP5kvo5PV92cdxt273uPYKwnVvq2xSCGnpdw4NmRX+s94fCCLm/1IIWMHnX2Lcst+YtgIR0jQ03ZELL0pcruTt1etOHUHoRiDsh08
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(6133799003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk4xdWM5MUpwbDVkZUdVQ0RjWit6cFJreENTMkNLNGJJMmsxM090Z2dVZjhY?=
 =?utf-8?B?QnJ2UkR6U0NqRDl2V0RWRlNpOUpmVVNyOG4rK1h0OU8zbmNubFVSY1Y4Tmdn?=
 =?utf-8?B?elJzV3Y2am1DSEQ1N1FUUjZaWVdtRFQ0c2F1OG91S0hGclVMTGVyTzVhUCta?=
 =?utf-8?B?c3ltUnpxOEJTNkVieFFVcDdZSGRJVjlncXQ5S2hmY3VVNVNPaU5VcWpENVZW?=
 =?utf-8?B?STRiSGZHMmNVWGFGODh4bjUvRFhtN1cxdzNBZjRCRkFZMjVqbkg2d1VNKzUx?=
 =?utf-8?B?VWQ2RzBaU1VKc2RLd3JPbjFGNFpLeXpqNzZuYnU1NTIybUpZcmNLSHhhZzRO?=
 =?utf-8?B?Q2xJTkJHUXpWTFdLUTB5UHBydG4zbTBNdTVpL0FrNlU5NkdXSHVmQndiQTl5?=
 =?utf-8?B?N1A0T3VONURZc3dlQW9GRE5VRWpwa0s3SG1BWktxSjhFZ3p2VzV3S1ZTTEVX?=
 =?utf-8?B?TmZGaUxCblZWU2g2bzh3SVI4OWhxYjBYc3cxdE1yRWZqTDdwTTVDS1AvS2lz?=
 =?utf-8?B?ZkN4VzJDTlM5TUlBdm8wM3ZSNkloUlJpZHVpR055Z0lQcFIvRlJuVkVGSmVK?=
 =?utf-8?B?aVdvblFwRDRrRHVCY0JTaW9GTlFEbVNuSnVkeGVXcGlnTDQ5WHhLUTlmT0tq?=
 =?utf-8?B?Rnl6MThHRENkakNFa1czb2JPMlRpWXZIenkrV29Yc2tZOEx4YVl2a2JranFy?=
 =?utf-8?B?dlQvVnVHdUxlUHU3WnFxN3ErNlNuZE9rOG9PN0g4eUo1akkzNVQ5U3NQMHFP?=
 =?utf-8?B?akc5QUd6SUV4TVBuTnNLcGtrZGtCQklvaE5jWE9RcVI1ZklzVEFzanRyclR2?=
 =?utf-8?B?WFZydUs2eVpjR0hXcUdvMXVWRk1tajJURHdkK21JZUZjVGNXcXdjb21HaUNY?=
 =?utf-8?B?di9PZXdkOWIwbXBCa0FEYWpUK2FKMnFnV2UwRFd3NldHSDA3Z21zVzRGM0lW?=
 =?utf-8?B?WXBaOHFBR2ZOVnFEa0hyM2NUeHNYUmIyanU0Wk5OZkh2bFcyQU42bllnQU5q?=
 =?utf-8?B?T3cxWEZYbERueWFseUZWTFBjL3FibU8yN3MzelBWMUJYaGtlL2lrcitHa3Zm?=
 =?utf-8?B?dVN0eXgrWXVZQU5xcWtjTVNtVVVZQlJlTXBpdWQyRzRLYkNkS0ZjUVowTGlB?=
 =?utf-8?B?ekgyL2g0ZG1pMGJvVTNrWkI2cGJmQXE2cXhsOXp2dlY2UWNDUkF5S3h1aDdh?=
 =?utf-8?B?eVlJM2g5RkZTbjNXMWtvOC9FNDQwN3FiNHlsTlIrZlZHRGdsV0FkWjFIN2dq?=
 =?utf-8?B?WUhGa1pQN25UclFzUVZhT1J6RTFRWW1LMnhwZm9rZFVMUGprN040ekNsa2lG?=
 =?utf-8?B?OXloZXdXdTl5eXhkbHd1Z3gxU1FVcjlxN1ZzckpHY1ZHOHFQYktxTFAwc3hF?=
 =?utf-8?B?TEsvZVB0UWVKRnRrRFdaSlJMTThMeGRxLzU2K296SzBCcFd2bmZ4Y2NkY3lu?=
 =?utf-8?B?c3RTVHNaK1RPTUM5VlBsYXBmNVFxT2x2bmdubDJYT1F2TCtTUkFlTHB6YzFX?=
 =?utf-8?B?Um1XRFhmOW1yanNaallZVXVXWUdUS2FPQ0lyd2pNb1FOOXB5VG1KTkRld2Va?=
 =?utf-8?B?L21SMnBvMGNaUU1FT2o3NUh2c2h3TllXeUd6bTYvVWRnMlI1SjVVcG10MUND?=
 =?utf-8?B?clVnZ2o0cENUYTJrcXpYOTNWRlpwakkwakdxNjJHZjZMTENvWU9uaWt0N0Vs?=
 =?utf-8?B?cjMxSzBMNmhBaTY4T21UZmp5KzA2Yk02OGJGaUkwZzdNU0h5VmVhZnQzVWJq?=
 =?utf-8?B?aXc3RXp4WVQrTFhTSGlnbDR5Nk9jRXFKSTJmVW4xdS93bklrSHdYRGlKWmJY?=
 =?utf-8?B?aGpOQUpIemxqdFpkMHcveGIzcGtabXJvUWpWZjZLNGptS3NheTBQenhUWE1h?=
 =?utf-8?B?Z0ZTSHJ3T1RWVmlSZ21tbS9ibWdVUnpUeGtUWHZDaXo2RDBva3NtZWprSnA3?=
 =?utf-8?B?d2U0eEFuNDNiTTVTTnMwNHhGSXZZdzNUTkRtWjJMRVYra2dXbW9WR1FWQitM?=
 =?utf-8?B?dzRYUTRPWUprazh6cVdsd1RwYnV5TEZRS3JpNjRIQy9VVG9oUTJiRWhjdG8x?=
 =?utf-8?B?ZDhZaFZkYTlzc0NuendPUnM0Y2hnVGNEUnJZalJwdk43NmNqSHVPR003c3Aw?=
 =?utf-8?B?bzVYczZMUlpGSmg2N0NjVWJYQXhHTk5kVnFjZ2dyWlVpZ2ViWlNuSEN1TXNM?=
 =?utf-8?B?bGxpNEc3dWpyZ0pJSFVYdmhxbThVcENEeWtjMzhTVWJnNk9YMHptSWlvbTgw?=
 =?utf-8?B?ZDNJZitRNFd2VXdpU1J5RkFTMmxUK090Y3ZZUnNad0RNK21raURXL1dGRnpp?=
 =?utf-8?B?bVpvUTRIV1BLT1UxRFFic2ROOHNlSWNhQVpHSUxLeDFrUkZiQ05MMzg0QkNE?=
 =?utf-8?Q?4JF4QfxpjNpZMjK3MFurZf7A+LVmSCFvkB2BDMgFJKPGq?=
X-MS-Exchange-AntiSpam-MessageData-1: JjHOm4mr/XezUw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819449e2-4759-4930-1d0a-08debd2cac76
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:47:50.4145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyRWxeC6imcbZdGtK7MG2pUoLNL0Jga8RmwfHi1npc3APdGxCUrFYacUfSQwJEjIa6ur1z4BjwHzQRtS/p70jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9193-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,nvidia.com:server fail,Nvidia.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 672FA5FC813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prefix driver-local defines and functions with tegra_/TEGRA_ to clearly
distinguish them from any general PWM related symbols.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 54 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 172063b51d44..f8c5495a56a6 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -51,11 +51,11 @@
 
 #include <soc/tegra/common.h>
 
-#define PWM_ENABLE	(1 << 31)
-#define PWM_DUTY_WIDTH	8
-#define PWM_DUTY_SHIFT	16
-#define PWM_SCALE_WIDTH	13
-#define PWM_SCALE_SHIFT	0
+#define TEGRA_PWM_ENABLE	(1 << 31)
+#define TEGRA_PWM_DUTY_WIDTH	8
+#define TEGRA_PWM_DUTY_SHIFT	16
+#define TEGRA_PWM_SCALE_WIDTH	13
+#define TEGRA_PWM_SCALE_SHIFT	0
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
@@ -81,12 +81,12 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 tegra_pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
 {
 	return readl(pc->regs + (offset << 4));
 }
 
-static inline void pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void tegra_pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
 {
 	writel(value, pc->regs + (offset << 4));
 }
@@ -102,22 +102,22 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
+	 * per (1 << TEGRA_PWM_DUTY_WIDTH) cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c *= (1 << PWM_DUTY_WIDTH);
+	c *= (1 << TEGRA_PWM_DUTY_WIDTH);
 	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
-	val = (u32)c << PWM_DUTY_SHIFT;
+	val = (u32)c << TEGRA_PWM_DUTY_SHIFT;
 
 	/*
-	 *  min period = max clock limit >> PWM_DUTY_WIDTH
+	 *  min period = max clock limit >> TEGRA_PWM_DUTY_WIDTH
 	 */
 	if (period_ns < pc->min_period_ns)
 		return -EINVAL;
 
 	/*
-	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
+	 * Compute the prescaler value for which (1 << TEGRA_PWM_DUTY_WIDTH)
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 *
 	 * num_channels: If single instance of PWM controller has multiple
@@ -131,7 +131,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (pc->soc->num_channels == 1) {
 		/*
-		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * Rate is multiplied with 2^TEGRA_PWM_DUTY_WIDTH so that it matches
 		 * with the maximum possible rate that the controller can
 		 * provide. Any further lower value can be derived by setting
 		 * PFM bits[0:12].
@@ -141,7 +141,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << PWM_DUTY_WIDTH,
+		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH,
 						     period_ns);
 
 		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
@@ -163,9 +163,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		pc->clk_rate = clk_get_rate(pc->clk);
 	}
 
-	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
+	/* Consider precision in TEGRA_PWM_SCALE_WIDTH rate calculation */
 	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
-				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
+				   (u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
@@ -181,10 +181,10 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Make sure that the rate will fit in the register's frequency
 	 * divider field.
 	 */
-	if (rate >> PWM_SCALE_WIDTH)
+	if (rate >> TEGRA_PWM_SCALE_WIDTH)
 		return -EINVAL;
 
-	val |= rate << PWM_SCALE_SHIFT;
+	val |= rate << TEGRA_PWM_SCALE_SHIFT;
 
 	/*
 	 * If the PWM channel is disabled, make sure to turn on the clock
@@ -195,9 +195,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		if (err)
 			return err;
 	} else
-		val |= PWM_ENABLE;
+		val |= TEGRA_PWM_ENABLE;
 
-	pwm_writel(pc, pwm->hwpwm, val);
+	tegra_pwm_writel(pc, pwm->hwpwm, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -218,9 +218,9 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pc, pwm->hwpwm);
-	val |= PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val |= TEGRA_PWM_ENABLE;
+	tegra_pwm_writel(pc, pwm->hwpwm, val);
 
 	return 0;
 }
@@ -230,9 +230,9 @@ static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pc, pwm->hwpwm);
-	val &= ~PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	val = tegra_pwm_readl(pc, pwm->hwpwm);
+	val &= ~TEGRA_PWM_ENABLE;
+	tegra_pwm_writel(pc, pwm->hwpwm, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -318,7 +318,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->soc->max_frequency >> TEGRA_PWM_DUTY_WIDTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {

-- 
2.53.0


