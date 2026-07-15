Return-Path: <linux-pwm+bounces-9729-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2/JwL3gkV2pnFwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9729-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 08:11:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C137175ADB0
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 08:11:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="ac8V/jB+";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9729-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9729-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB240300517F
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A037F73A;
	Wed, 15 Jul 2026 06:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9891236E46F;
	Wed, 15 Jul 2026 06:10:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095859; cv=fail; b=h3piscb9OhLjKAt+QW+juhn+Ao69Z5UZ3nfH84tOMbXBXJLj18SaFUvUnmIMtX6KVSTNcyRZ/yFIkvB3uGcT/FIawI1p4ulSeWZdwpql1GGPi1Avdxwzh7LfFkkSyZad5+Q3H0WFPZvX2/SV+PWzXJz8qeu6SrM866JJplENNN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095859; c=relaxed/simple;
	bh=IE3pUKHJYnbcntUECXSzj2JlBWFfhoHclSK/PYlBJns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZJPOxaO6s48jSKwSeRNb/e8u9OjzhQ9iqV+sXMKcP4K/4V4AYbsbtXOGZ7I5Z9FqB4OuHmNM/0S51AGWEXyF6EHVqsz0ojRH+/jmTpruWs+zQPS3I7eduPHmeQOiq0VuBFe2uQtA2ADhQDZw82+aNtpVkW2ipFWdVU3eY4Zu24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ac8V/jB+; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNAk1sCRX0uHmtDgjYtHEz4GoW//CF7C4qZDOelYqs7P6rrMlKSIlMNCWev1wHpU+LcZaCsO3a/WEZfpT06yl3fib7eiyKeY791qM/kArJzKaqKXsx1S29yWAFs7d5Z544N55X9mh6XL2urVKYOotzhxyebN9WADPrRAfEsi6BtLpd+C7cpGlKceK838S4VIBUbvcLZhwUSWhfSA2LMIUR477pJp3RX03cEZSPj0XOZdOEL1VX0n0WPSm8i1/6DzbhIWB4Hfgu5ejM/VByk7Hzoz4zorN/1hh0lTnJXIVQaKKsS1sIhOx4Qrny72UnQRkyXs4iyr1SF3cTcJfS4Ccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5s+CGTAn/U9s2eBBoqWxhH+hUekWI2AyV0LU5p0I6G8=;
 b=MwrroBh8N0fPEye3Vjb7yHoqbDI2uoZddnRpoX3k9OpcbN4iKgOl/8R8m8oNTBCfXIUQ6mp5CtrKBUR4w5jxFcU872BfaNVfu+LRTAUNu/kB8kxMlu4iMrr3GrIK53Z6uvS+BPspt7DWhLqvVUdqjQUSOP5Igdp8tFGoRa8vCgNCVtYujZ9JUzi89czgg3Q5PHlYBmZzihw5R7I8aPPtssJ84PKG1S0qc8aW4cKcrM/zBu9/vKdiU+E5KHm2u555lZbJohyRzCXM0p+cmIuf6iM7Tb91LSFT3XuBatGb8ym46zCES/6bUc5q4qcuv7fNHSFl75WfdTxtnNG7XLncIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s+CGTAn/U9s2eBBoqWxhH+hUekWI2AyV0LU5p0I6G8=;
 b=ac8V/jB+ucq/mmDxJJR+tfpLVHnDD9IEZCerOJQm/PdwvCYeKq/wun1dUK/H8GZFyw0tPUY0pKqBXmCYHcOsj6SXaH/SuxWX0x+WLiqGvI4IV5TZ1BVRd/nViRNDHg9sfUqznFnh7Oy+FFsK99FVhffpgfIShsHjmmGyXZTeM9BJlz4ZU8ahnuT8aCLFDCvfGMXnG1EmzOwc3n+lN9aBpshBZh3dNNYdJL5f4aP5oUHLr+q2rZg5fWbt9zi3ARs5gbMT+ILUeYBedIhaHPEjKDu0W/e3sIbDRQ0tgbmN/0POxZTzqOcBaJ1F95rkeBiQZVCwjse1ctWdc5SKNJib8w==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 06:10:54 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 06:10:54 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH v6 0/7] Tegra264 PWM support
Date: Wed, 15 Jul 2026 15:10:49 +0900
Message-ID: <77Xw9sqMSFyr0_DUARXXCA@nvidia.com>
In-Reply-To: <alYBz2PVs7hCsR91@monoceros>
References:
 <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com> <alYBz2PVs7hCsR91@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P301CA0002.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: fc72b63a-aece-4fd9-19cb-08dee237d3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|23010399003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	tWJDc7Tet5RYR01oG3QpcCZbysTvR6/7uklYNhg5jMwK9j3vAoxqI6OCdA9nBdAdzlRdiGcRZQFOdoo/6LjxdOu17OSMYk3kVAcgJ1QHTSoAIxe435I8LN26z0j/rzDy8cRbvwbXLWfjpN+zev0l84qDMlTI0+id3hgCNkmASwSyR+JB/0zgugUbqlWFPX6gKa71RFC/efCyEh2YTLrSM56YJwhqsi5AqdjKCFQsO1UV/oyy0QsNHFaMy0nZvEM25MBlG2INvecO0W6mO/T1fbuBJJxIjyuc2xf3nq/ycY9osZ4MMIhYmA2GMwoFPMNrPcWRvPDXa+eJbcZCL+09zcn1z3gA4T0oiEJyJPgtV8zgGBz5uEg8+MZJ2FWaC/uApFgLtXUCNydjnMiiP486dkHLCaLYFCDczluHwxJgSn9laSyxkuH46oveNWuBrCJKysNw7e+Em8rV1eBPZm5R6f/Y3XbX/Rox74llsiHrStjEGVX7E37mc+/qIB399uYi9sscjYfh2e2rcXK7oGYqV7uy3s12lWWwfXitEQDBf6aiFgv5lHVrfBkvnW+7lFFAlg+I5epVjMGcTdTG/OBPAOfaRIAKpSVFnF+Xi82acBFkuzckQjSjLGTddsJa/lGEzAf63+iMmGIlg+DUsovzS99a5NZrW11QLOWM9hP0RNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTl6QW9pSlc1RndTMHBDb3hSWFFRWFJDQ1l0QXhWRm0vbVVGTkE5WnhTUmp3?=
 =?utf-8?B?WlVoa1Fyc21EcVFacUdXNUJGcmJRdVZoelVVRHpPRGhwTXpFQ3JHOFhwMFk0?=
 =?utf-8?B?bjVqSnZNcURWd0dFakNKOVd3dlZDekkza2RtSGVOK0hURnNUb2tZa0ZEaUhq?=
 =?utf-8?B?bnhnaFJYSGtTMW1kRml0Z0trRCtnMDNXeDd2dVlDcFE3OEpGN0VmOUlndzRs?=
 =?utf-8?B?eW1MQmNxM0VTNEZCVFlGWVZPbDFTMGJHWWhBM3FCbm43L1VlbDRsaGlJenh4?=
 =?utf-8?B?VTlxVm51OUxPR3BETVduOWxJMWRlR2RZa2M1SG1VaWF1cllwRExiZS9PeFhU?=
 =?utf-8?B?bEs1RkFjay9nQlhDUWlUaVhtRGIvQnplT1BpUlQyUWw0eWJNNDJmRUQ3Q3JK?=
 =?utf-8?B?dmx2Q1gwSWdCYm52ZkpCNHdGVzBtUnZwMDRrWWx4WG5IQVhYTmRIQnJqamgy?=
 =?utf-8?B?QXBSZWRqSW1tcThwQXg0a1ZUaXBQVi9EMTJwL3lGbUFxVGhWc0hYanR4QVNw?=
 =?utf-8?B?SGRVRFRDVlgzeEJzOGZ3b0k4YmxTbTJpUU1Qd0ZiaTlQTW80ZklZYnFWT1ht?=
 =?utf-8?B?b0lqMTdwUndkK0hjdXpHYnQxaktJM0k4VEhKNE9xV0J3OHU0WlFsUTJoU1A4?=
 =?utf-8?B?RXFnTlBEbVZzRmwyOFp4Z0NOUGVzQUZjak4rMC9NcWl0UStMYStXT3p2Mzc2?=
 =?utf-8?B?eCtBWWZSaVZzMHJwem9OcitUMTVGR01ncjV2eXVUcC9RSi9pdXdBUDVZTVd6?=
 =?utf-8?B?bTBQdGdzN0d4c3FXYW5JWXEycVVZa1V1WUVpaG1KRm1DWWQwZzUzZTRqSjJh?=
 =?utf-8?B?b29ELy9lbUYxT2Vhb0gwd095MFl1Zk1OMkVxazl0TXV0S3gvZWlDcC9hS1JU?=
 =?utf-8?B?VS9wV25hb2hWaUJTM3o1amxNc3VidHdRUVh6bmFFTU5vWlo3eU9kdzc0dmtZ?=
 =?utf-8?B?QWcvUlU0SDByN2lxUVFSWS9yeWNEbWR2S2hpOXcweVA4ei83Y2RhTzliekdB?=
 =?utf-8?B?b1p5b2NwWEtJaFRNcVJCZERQeWplZzV2eXBtTzB4N3dna2RTQ0FaNTZCbW5M?=
 =?utf-8?B?a3ZFOGhpSXRkVHVqMTFzQkQzOGh0NGVPOWk1Qk5wTjdWV3dMZm90NVB6enZt?=
 =?utf-8?B?SXQwT29tY0g0bWJrMmFhTTNaWk1FTDk5cDNLYXZISFdFNytMcU10TmlYMVlx?=
 =?utf-8?B?dHlhcWRzYnFnVXNka3dVZzR5VFlLNUJTV245dzAyRFJxbzU4aTBBY3ptOExL?=
 =?utf-8?B?dXF1cFFwWTlnR3o0ZE9oN3FrWSt4ZGJSRW9EWWhDWEdqVmNCRlhkWG4xdllX?=
 =?utf-8?B?ZDJCOGUxcUpybEdLaTFySURtRktEcW9UZi9qQ2FHdnFqaFZ5eWVVK3JNVkhJ?=
 =?utf-8?B?S0svWlpIMFZGZ0YyWjdlUmlWc2Ewdk5EODIzd1lLaDJuYk1SUzYvUnpiN242?=
 =?utf-8?B?YmxleTU5ejlmZDZVWXRQblJSVWp0aXRXNGdFTHBrUE8wKzFkSHo2TnByRE5n?=
 =?utf-8?B?cWFocmkrZVdONGtBM1ZqbVQwZm1kMGM4VEdUMGkzYllIVmdaOVlJZVhLS3ZI?=
 =?utf-8?B?dXZzdjB6WVV4NGo2azREVjVPenZRejlHdFF4cHF6MmpiRHNUVmFxUlpUbDl3?=
 =?utf-8?B?dEFtc2VqQjZMVFB4SFJCOHBSODNPekdZN1VJNTZJekplZTh1V0o4b0VVYzZG?=
 =?utf-8?B?dGRja0N0T0VtTUg1OTNZSXFId3ZhbFFQaHIzWVFRZkVuYUxOVkJqVnFvMzMr?=
 =?utf-8?B?eGZsNDJBcWY2aXAwZG9QQlQzZHhncmNaS21seDdDaXE1OUhpOW54NmNKb3Rz?=
 =?utf-8?B?QTZJWGUzUW5xMlVhV3dDdWk2ajBOOGFnL05hK2JrZ2hUSFRORDJWWnlpZTkv?=
 =?utf-8?B?WnMyK3MzZUJiNW5tMms5N1crZCtZMm9MY0JHNlpCWllaSmtpWm9JZERDWWpm?=
 =?utf-8?B?RlFWN0tCTHFGVk5BS0psMWYyZFJ1TU9BTFZpeUlwUzRDK1hhNDV2OGVjZUQz?=
 =?utf-8?B?cW5zdkZyZ0c4MjhBZDNBOTZqTmdobnRibnk3bUxPcWFUVW0yUmxEc2hRdldE?=
 =?utf-8?B?Q2lKZ1lidmlMdWZvQ3JhbnNaTmxxZFdoZUxyV0N2V2xzTkRYUXJvamhWajQz?=
 =?utf-8?B?ZUdZeEFrTi9CQ0I3enRMelBFQzR2ZkpzcDh2cnRKbzlvVys1NEFvT1RsNWxI?=
 =?utf-8?B?RU5tY1VHQXdHdEVYYlZScHVPMHNFTTllaUFOdmNWMkN4d0F2RjIyVzVVZ2Qw?=
 =?utf-8?B?ejd3M0t3aE1rbmt6ZW9acUs1THV2MitqMFNrTm9QOHhMOFJ5dWwwTXNBTlhx?=
 =?utf-8?B?bjN6VWpSZjdJclhNYU9NYktwbEpoaWFYbitMenlnQUFzeFpWd2p6Ync2VzVs?=
 =?utf-8?Q?BWE/DToBRx9H9P+49Imc27IZkqn5VncncCx13X0cGVbLg?=
X-MS-Exchange-AntiSpam-MessageData-1: c9hIz/eqZOh8Lw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc72b63a-aece-4fd9-19cb-08dee237d3b8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:10:53.8010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AL+R4sXVAL3p2hIbihFVSMnSepuBZOTskxUKRnB1tASTvby+D7ACRXCfM0EtCyb6topPO0Grp4otrD4w/PTyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9729-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:thierry.reding@gmail.com,m:jonathanh@nvidia.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:treding@nvidia.com,m:yiweiw@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C137175ADB0

On Tuesday, July 14, 2026 6:35=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Jul 01, 2026 at 12:20:29PM +0900, Mikko Perttunen wrote:
> > this adds support for the PWM controller on Tegra264. The controller
> > is similar to previous generations, but the register fields are
> > widened, the depth is made configurable, and the enable bit moves
> > to a different spot.
> >=20
> > This series adds only basic support with fixed depth -- configurable
> > depth will come later.
> >=20
> > Patch 1 adds device tree bindings for Tegra264 PWM (compatible
> >   string).
> >=20
> > Patch 2 prefixes driver-local macros and static helpers with
> >   tegra_/TEGRA_ to make their scoping clear.
> >=20
> > Patches 3 to 6 contain the PWM driver changes for Tegra264.
> >=20
> > Patch 7 adds device tree nodes for the PWM controllers on Tegra264.
>=20
> I'm not entirely happy with the driver (as already pointed out during
> review of earlier revisions of this series), but it's an improvement.
>=20

I agree.

> I'll take a look to improve the things that annoy me in this driver and
> I didn't want to do that on the current state which would make it
> necessary to respin your changes.
>=20
> So I applied patches #1 to #6 to
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/f=
or-next
> .
>=20

Thank you!

> I assume patch #7 will go via armsoc? If I should take this, too, please
> tell me.

My understanding is also that #7 will be picked up by Thierry.

Best regards
Mikko

>=20
> Best regards
> Uwe





