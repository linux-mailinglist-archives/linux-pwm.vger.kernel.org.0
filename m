Return-Path: <linux-pwm+bounces-9157-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tXkbHHIzFWqPTgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9157-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 07:45:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E29A65D0EB2
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 07:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFE0430146AF
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 05:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA83BF689;
	Tue, 26 May 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c1ZPEtIC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DE3BF682;
	Tue, 26 May 2026 05:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779774319; cv=fail; b=GFq5CEKFJ2BWXx74g+TZLP5qp71ZyxUNIxhr+CApEJNq0T2Pe+w7IRjIeCDOc0jj0syZL5Ml7s14B62kRO5k/6fwBfTLF0dOtu8cUZedFhE9TXt61VogOtWprYA/DrQcfCgz4OIqjcacO2fdkbFC+lKssw7/YFpfBsHOhT//tWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779774319; c=relaxed/simple;
	bh=T0a2vN+6i/kSBwg4ZHj/MawZQ8ZgXkYzZs7/zJLMKrI=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=H0n2ESjUo6saSb1GDHpX/VZdm5v94qHPiz9N/ArYc9jVJNBfo9xMnp5ELZ8qTz6fZxJD7QgehM1bFkt12mOU6F9XI2iZnrkRISg38j0xErvmTu6zRA+ch4XvOGnuzpePosUACq3Ho+iN4O3Pj5qLwJE++t9r1M4GNiAa1g6gefM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c1ZPEtIC; arc=fail smtp.client-ip=52.101.57.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nh3tF9CcfMRKuwHSVfnLM4rS0dwlshsxdoAMmP+2WK5vbQVksmFaiJ3XV9+aw159VNKrIZ2FYi4OcXDiaQgH5JD33/0jRbcAZEZj55urS8VzK9JCExypyjMsx6aI4hUx4c/UPnq5fsM78ZRLoVY9SnmDAAMG5m2A/aFdBSWMK8zSE/T6nx4Q//Y+QMH3Xtb7hdlNhnhZepdMQe1Uh+c30krqdN3lM0m1uii4PFhK+t44l3FyznKrVzFKq6dCX66W7IDaTqXIrmW0j2cDZHq0v1IjZNFlXgdx8j5g6RQyRwAxmEwL1nuXatKB91fSFuV+4/ORBzPwSyN/hLTYFimeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4zI7xbKY0nf5I/Mx7hfhz95pNfcSZpR6ETfwrjmmvA=;
 b=RpAHboO+EKsEiDSt87WFyEdChSOPO/3aOer6Cd4OHo2MagCyAtY67keIascPD5+6aQn3dIWm7ENbowU0WGM6UHY3vKcpxiA1+qGkwZMaLiRNb7lMCAbZsbb6eC/c2tDuUFrP1VhKx5uZnkMkgyXkhnckg9X1qHqtnqaw4OD25U6oq1m5Im7EC2BFTGLpfbArbzIoOgsdUSG+LA7zN81GAAAsNRmoGYfv4CkCslLuzwFdTLq2+hLYNi8A2v7qqfdxC8Y3I0tzp0MGDSWrfiWGVYuqOlm83Fzm6jn9DPHddv9GyB8Nkczg4FlX4xYtmgHry/Dv/dUY7PRxukWAZZ9tEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4zI7xbKY0nf5I/Mx7hfhz95pNfcSZpR6ETfwrjmmvA=;
 b=c1ZPEtICLXRLHrJC/mhPjo1rkKKI8QcGn7OwAEGSpK5PtERhdKpo/K36HSzLTKrrWQsivkAn/fisuvZxTOftgwkeOAboC+upvhL5Rk5JmxEmuXb+Xk8TDou9xoLCuyyuUBV2DoajvHR85/WzdhKlnfLzQ86eYuOm6Gcwg5rV2OeHaEo6AXH52G9OclscINdPoNSa1JpGZ8v/utBbqwlRhF+/Z1qY2FFU6ZDLPipKkGN2IZXO3nWMGjXL2+/w8wOpR67ZI9VAx7mMCoOQhT7ABaxPDTQHiaL2uhNIKslEbKmsbTBY+gYTfGUYmYISmqZBC2sJ80YYWRzLQ3YFhk3l/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 05:45:12 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 05:45:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 14:44:54 +0900
Message-Id: <DISDBZI6SAVQ.3TJDFMM7MLUBH@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v5 22/24] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-23-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-23-dakr@kernel.org>
X-ClientProxiedBy: TYWPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::20) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bac370d-42db-45ad-28c2-08debae9ef0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|56012099003|18002099003|22082099003|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	t+05UN6eED4hXUoh6Ao33LT6db7SL4/G8aVfoRYxugQllnyp4WpENsy1uyTfd8VZ4U3hHtXY0OJCHfvOWaeWojlOuNqLkpabt/D8I7HwiPuEQuiZFC5lU6soW4qwAhEWC59uhwS81+XnmQ6pSVXp+cco4vlLJ2KussGMZr3tNPFZgMKR2aRCw7c5tJX6L6fMLPDiSFLNW7u2O80E3Gco7+MY7k9aAD6MT3VPAxXw6wktFnsMF5EDh2dg+NA2HXm0ruIEQcs6lrYJ0H9Dahoc1Edh8BJ6vWSKm6aNNK740O+NeSuv4MSmlaMpWkIK73R1/y5mNo5avK73G7p0PHV9EpG3nfEHStvqMu9uKRG1cSIZiX8SX6nTw68gKKrRHPe3RJTPWXqB7wVoaqcQP/zL5mOEEAy9BHPSqnSpLBguF+NaNPIRtJFTUGKyPQI7jEcvLg886phzzeyvWBkWS3EikA6B5qj/ILHYkeXmYzgiOSZT+BB609vE+B6Q6W2f9TlVh6zr4MUM1UbwdSAqZFo3aTw8Vex85WpCy0cBPLKK9dMFMSmsMxFq1CxTWChi4BqyCuBT4tvLUlqb9jxM5s63ar8NBhuNyEHduuCnfiJgGrWgHWiwNW4MOAsNk+jIMeZPPtDF6gYgSULPXaDHto6lQJTQWp0Db+VIBSot3rHRkl1gHLkw5REz1VHz9uUnnlfK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3997.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejhKVWNhOGhOaG8zL2FPY2dNV3M2SlBWWjVNS052KzI5SVVBblJwR2JnYlEr?=
 =?utf-8?B?ZFlZbEVpc3BRK0N2OXFSWmRkWnREYWJDRkp6N2JBMzB1T0JTdFF4WEw1R2Yw?=
 =?utf-8?B?WDNnelBuR2VZaGFoaEtzVGxETS91cFlvRVNhQVdWU0tIa0J4UG96RlNKN20v?=
 =?utf-8?B?d3U1VmEvSmRDbzV0TUdza3diVVEzOTVEZlVjbjI5V0FEN0RBWXBqUGMzTFJN?=
 =?utf-8?B?RFVuekxNdCs2ZjNGSjRYVnMxOTFqcjRCYjJyMnJVdTg2dk1yNlZQN0gwQUpX?=
 =?utf-8?B?R1dyL2VjN0dRVTkxTWpVRDhoWjBvblo3aTlWTk04U3gwQjU5Z0ZqS0RuRGlQ?=
 =?utf-8?B?RTJMaGJ4dTdHWlNFaGgvSXpzeEN5d1h2b1JNdzROUllVZVl1L1FOakRUcWFm?=
 =?utf-8?B?WjdmNGFNRjdEUUYyQ3RZYStUTjRRbjVQeEs2L08yY09WS3JOb0ZPWFMxYlpC?=
 =?utf-8?B?eHliekJveWZvMXY2UFlER0kramdGbU53NHBnL0NTckJSVlFlNStnaU5sYVc3?=
 =?utf-8?B?K3JXSmV6WVRTNHY3a1VPQ3ZiLzFUbXk5VjQxa3MxWHJyK1RaSHlKdHNWRXF0?=
 =?utf-8?B?andSU21SVTVTVXFPRmhtaFNIOGFHU3hQcnhsMDNZSkkvMk9vd2RWMmsyOUlr?=
 =?utf-8?B?OXRjQ2srL2pyYWZ6TktUOUh4R1RVTlpiUzMzeVdMRGZ1MkVIS3hZazVLRXVC?=
 =?utf-8?B?enZLUmc0RkVreGpzYUFlcENpdFg2ek9XenRyV2xZUDhNZXJSUXUrRWYydDFH?=
 =?utf-8?B?bE9JUnI0bjREVzNiNWZUazh2b2hkbGR6Q2h1d0JZZlpIblZXczdTcXZUSUJZ?=
 =?utf-8?B?bGdIQkV0TVFZTHB1Q2t1UVlRYXZpbWdNT2VIaWRIcXdKVXNGcTl1L1pnTkpZ?=
 =?utf-8?B?bUFxakVteUU2TFJZVmV3TVNuWGVRSjJNK0V6NlB5b1o3ZmRnUmR2Q3dJQU1S?=
 =?utf-8?B?dEhuRk5QOHFMZEtCNXB1U254MHJQSlpITmMwS09CclIzaWRsVjd1T2VTOXRV?=
 =?utf-8?B?SXNUaU13bmNvbk1IZG5tS05CWlRqUnZwb3YvWVdpQnZNbW5BRTE2MjVmWmpH?=
 =?utf-8?B?SGU2SGZBOHVYUnJZeExNT3MxNS9lSkJDdG9zaElacWRGblpndFNxZWZjKytj?=
 =?utf-8?B?blRmbVlEYmhybGFkZzljYXU2SUc4eDhnRjVDZVE4NjJPYVhuUThzaFlaQmtE?=
 =?utf-8?B?b3h1dWZEell0M0d6WlVZcG91N29CTjZ2dnViN0ZlMDRLWU1qa05USk9Jc05H?=
 =?utf-8?B?eUowQVlXaXJOWFVPUTlFUDNtbFhRaHYzQ1A3bzZKT1JBUDRwTXhQck90VjVo?=
 =?utf-8?B?WjZzbkU5VjZmZWNQODE4Tnd1YS9vVjRIZlYwanZoemZhUHJieWRDT0g2Smdj?=
 =?utf-8?B?Rm9yV2hrYml3ZTcwUVZmN05qYVJUYWFINHZ5c0NMall0dXdtdEQ0VHJjRTVJ?=
 =?utf-8?B?eGlEVDFzYk9UdVpETWxSSG5xZXcrVmQ0S2FIN1Nid3ZIZHlxeEpTVWdYNHdr?=
 =?utf-8?B?aVZQQVR4V0Y4V2NyV2NaODQraVh5aEFlWWUyK0F3Z1VvRWNWVXpIU01UU24x?=
 =?utf-8?B?TzJndDZYKzlBYTdMSXFLN3BkdWVLcGZSb2lEQ1BPQitmOUwvR29zN0xTRmNZ?=
 =?utf-8?B?R0FuNXI5NnJPdDI4WWNUYkNCWkVkYzFtUUJuK0RkaXpXVG9YSVR4L0lZMjU0?=
 =?utf-8?B?emFuODNvRVcyRjZ4WitNNURncyt4TUV6eHlybU9RK05yRFYxNklUVnc5MjBk?=
 =?utf-8?B?UTlxZDBkYURJOFZLTTZldVR3VlBHNnRUUW1QT2x4alpkTkwwZU16NERJZjhj?=
 =?utf-8?B?VVZidEtVNVZ2NnFEVUJWSWNWTXhWQis5Z2VieTlBd0dHYy95VWpJdzJvWVEx?=
 =?utf-8?B?SENZdngwVEx2S05sN2JROG5IRkhtUEpiYTJRbFRtZE40TWFtNkk1RG5WUmE4?=
 =?utf-8?B?RHZSRnJRYnYvYzl6eW1tVWhtUVlMSkV1VHZiOFJRdGxRVmJmditXQ0tjdjk2?=
 =?utf-8?B?Wkx1Y3laZXo4dFNOelMvbzkwV05aaENDS2UxT0Jid1p1VTJSYmRkdFY3cEs4?=
 =?utf-8?B?UU9QNzRQYXBuMC8wTW5kZTVmdWRlTExNWk9PZzhlaXJVcDJSaFdHZHBOdWlu?=
 =?utf-8?B?N2Y4L3MwL3FIWlFSQWkxUWJYZmFxYXhUeUdSVFN4d2V5UFRHekFLc0FRUE0y?=
 =?utf-8?B?bGIwOC9wRFFuaHlHOWJkZkxTbWY1MnEwaHVJSFUvQmZ6a0YvbzNmNXgxWEo1?=
 =?utf-8?B?VWNvL0NJYUVFb2hKa0VOdG5GL0R0a0VpQWV2aklPaWpyd0U1ZnUwR2Q5YU4z?=
 =?utf-8?B?cmw2Mllsb3hPMGdWNHFiU2IxOEFHU2tvM1BRS1A2ZzRPbTRQYW5QaXZUU3dP?=
 =?utf-8?Q?ZIBZkdGeZ/saRKSELTbCpf8LqCrwhA1ubF73lpwLwAtCy?=
X-MS-Exchange-AntiSpam-MessageData-1: /oKQAdb0wHEEEQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bac370d-42db-45ad-28c2-08debae9ef0d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 05:45:06.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHAZr3AHdyMfYb/a7GjKOPqoG9qTFaCi8MfL/iO2gz4UqFstaEqA784R1ka7sHqbHmELSZrABd2TmtU8pSyPMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9157-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: E29A65D0EB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 26, 2026 at 5:21 AM JST, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> There are a few cases, e.g. when dealing with data referencing each
> other, one might want to write code that is generic over lifetimes. For
> example, if you want to take a function that takes `&'a Foo` and gives
> `Bar<'a>`, you can write:
>
>     f: impl for<'a> FnOnce(&'a Foo) -> Bar<'a>,
>
> However, it becomes tricky when you want that function to not have a
> fixed `Bar`, but have it be generic again. In this case, one needs
> something that is generic over types that are themselves generic over
> lifetimes.
>
> `ForLt` provides such support. It provides a trait `ForLt` which
> describes a type generic over a lifetime. One may use `ForLt::Of<'a>` to
> get an instance of a type for a specific lifetime.
>
> For the case of cross referencing, one would almost always want the
> lifetime to be covariant. Therefore this is also made a requirement for
> the `ForLt` trait, so functions with `ForLt` trait bound can assume
> covariance.
>
> A macro `ForLt!()` is provided to be able to obtain a type that
> implements `ForLt`. For example, `ForLt!(for<'a> Bar<'a>)` would yield a
> type that `<TheType as ForLt>::Of<'a>` is `Bar<'a>`. This also works
> with lifetime elision, e.g. `ForLt!(Bar<'_>)` or for types without
> lifetime at all, e.g. `ForLt!(u32)`.
>
> The API design draws inspiration from the higher-kinded-types [1] crate,
> however a different design decision has been taken (e.g. covariance
> requirement) and the implementation is independent.
>
> License headers use "Apache-2.0 OR MIT" because I anticipate this to be
> used in pin-init crate too which is licensed as such.
>
> Link: https://docs.rs/higher-kinded-types/ [1]
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> [ Handle macro_rules! invocations in the ForLt! proc macro's covariance
>   and WF checks. Since proc macros cannot expand macro_rules!, add a
>   visit_macro() implementation to conservatively assume macro
>   invocations may contain lifetimes, forcing them through the
>   compiler-assisted covariance proof.
>
>   While at it, fix a few typos in the documentation and in the commit
>   message. - Danilo ]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

For everything but the proc macro,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

