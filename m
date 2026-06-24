Return-Path: <linux-pwm+bounces-9363-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e/FPEVH0O2p8gQgAu9opvQ
	(envelope-from <linux-pwm+bounces-9363-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:14:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B87E66BF872
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:14:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VU5axAif;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9363-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9363-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67C783006531
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378513D812C;
	Wed, 24 Jun 2026 15:05:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011050.outbound.protection.outlook.com [40.93.194.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07972F8E81;
	Wed, 24 Jun 2026 15:05:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313527; cv=fail; b=YO3rb7esUTyF4u9g9GgZWo0Lerdd0fA2kwPtBfnL8AtAcvuQaMfofpjHouk3KrfIX8kbwPVmcP/kibrEXhhHZHfj01IiVhy1UepCN8Oct0XnaWEjBnnZP71OAwpyd144JLVXAegRjJ7ynL0cQ1OVG2niParHJGGsN1VdjOo6w1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313527; c=relaxed/simple;
	bh=xl9Megvk6WInbLENOM8OBsr5GYLP4lychD+4pTT09Q4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KRVH9q8WSKG+PIDrudQy4JoO/GYEr9+G5fPzrzJEwVq7X9lrQNDzIjvshoTZwDN7ccCCw5zzWRBkRisntnzq1dEV/fJ1cAiwPDUhL3GR5ealwmjuGrVs35JGulQvDKOVMIBnCIal7a0u7HQTFo4+EbkdXj8rstgjHDqtVVqFRyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VU5axAif; arc=fail smtp.client-ip=40.93.194.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzIXwC8KyOEmTZm3CDwmYBbOaq2xRYQESdNJ+QNAzEwKJjwXP+WEWFj/9LlC5Kffu0y4UamM5kGt/cKgHFjPZz159PAyqoufNo3pKgXi9JzECLckBN8rx3MdSUdvbL3SIV33NtQlb+oMpJ8Pwea67YPxFGkZIJaQOiN926k4SyuCywm5EMmtFRW8JNnClcu6fogHGIcs7H5cqrprRFKBJXH6mB8itVDx5LZouG5P0uPQvNMWamtMZYq0XMRMcOMl9cO6nC9Fa0Ba+5TgwLtjAo7S3KBmQQuXHhNpMf16vcUNNgVSu5avjQ5AnRu+Ck5K5RSb5e/hUrea31PBjZkbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xl9Megvk6WInbLENOM8OBsr5GYLP4lychD+4pTT09Q4=;
 b=XvMmQezmT5YHf8DVvGdP31YcBZmdTIIXVnnX0x3G50IOthusvk4aMKmN58E/Dh8JoA/h4sa69QXWJiWWi4nwVqXkyQ7zlkVH2w6AhKDjq0+WII30DOEv8FXCZKgWjORgWsnN/4rxWNRHjb7D4knyltO/e3JtVMD48j+uz7URGTt9ry2YYK0v79m+gVMglltDBJle6bgdPIZXUPQ5cNi2Sm65/kSP6dXT7HAszu0OgK96jYjh8F6RQkSQOdgB7GP3QCl5tFhORa51XkXg7wsRtRTXvVV4IS+X4+Q1hDDm1qmk8OE6ZOlh8MfEn5Tv9Qw8J9Ps7B6Gp2IEGzdnq/zhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl9Megvk6WInbLENOM8OBsr5GYLP4lychD+4pTT09Q4=;
 b=VU5axAifNDMT7DRPZAcwB83urRbnClbYyOxICDzG9MpKu+VXJpEey1PMYCPYCYd4Pf/nBkfix3RtWqkm4xe4hfDA92VEYZSzEEzeLmCiF32d40miuX6YxiOdv1GfRA3clQNKY1Lu02+I+YCZ1s3ncC3BI0G5RiAdHnbYl/k0yKr8VWu9ZWQ/x/gGVWV3LqC+/9C2GmX5ICJ7TQx1DXB/B2w82HRhQKax48UF9V4CTCOz/FqyHlUiRiiMXVMNBvZfYkPSqvZI84A++Bt2nayj5HlRKbiChRa0wddsTPS90i48aceTE3P/QZMrcm1meya6wzSgozZhjA7gKkdkacsQOA==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DSVPR12MB999191.namprd12.prod.outlook.com (2603:10b6:8:496::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Wed, 24 Jun
 2026 15:05:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 15:05:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 00:05:16 +0900
Message-Id: <DJHDETXG4VX0.38H7VX8YUQQNC@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 6/7] rust: pci: return DevresLt from
 Bar::into_devres()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-7-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-7-dakr@kernel.org>
X-ClientProxiedBy: OSTPR01CA0025.jpnprd01.prod.outlook.com
 (2603:1096:604:221::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DSVPR12MB999191:EE_
X-MS-Office365-Filtering-Correlation-Id: 07367695-0a7e-415f-1cce-08ded20201dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|10070799003|1800799024|4143699003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	gT9ji6Pwsk/QYtA+KlVfJgmRa5MhMC04Xw5PyUSrNRE3z0DwUweuJTuyCcJtt1+l8orZkhJ5wkTM4GwfFOKl1BiBYsYi6pu++DW61F8cVMeSjZ/WtxSoQZMC63/l6XNTCWF44QDdyvPh2jhCz+4O6JVI1uqqCC4ltsU+BWfj8HkAnXEZNEZXXwE9On0L+da2KQb3U78X7QD4fUbHWGdGN15Gqw90HDtkgPyfJUBMAx8q3uzllr0Q4RIma59jo6gVNHG6KovtDASjnQG0xNkgsFLkINR/ASio8cKFOCKwXh2cJpNq51h6pEeqm4Qoox3w6v5SKPHJdfGmEC8jF9N29NbtDUeU4PIH6tN2xlvtu6IQzRiuaoWi7z7FHn1Ll4tWGfwWCcP1IU0NFOUCrMdNDON9Ejv8q3gRIYdRARjbL4TJAMKnSm3ICvD/RNOzvMyxP87k5BGe1Fh0aC/7sAfYRBR0GIKKwZUzawWCy2Xq6GWTDL4RLdwwgvux+d4FHRUU0MgFnbietysAadQXjZq4KPSeAiexuxEFNu4/rydLhkA8WSyJeYBuITTOrEr9RfmmB4k2VfglQmy7lymZdjFEFa4wMC2PiCo9I98LvxiZ8XzUdptHhb5R+AklyVAXGw+Hg6HME5BQ6dW+mr5EvzTqQdQyuPqCT+bSSxdniOe+vpQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(10070799003)(1800799024)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFViSmVTbjBMQlB6b0ZxaFdzdUtKeS83UHQ3QzErS2Iyb3FvS2UzZmhvbjBL?=
 =?utf-8?B?VFFsYXZsU1JmWVVFVlJiUWMrTFNBai9zSEhVSWhWU0JGT2tyaE5MU0NsaDJj?=
 =?utf-8?B?VEl1NDdjRFBQcUdla1F2VjRIamdZU2ZIK0dnRy8xSXJRQXVDYUNkTkhEY3ZS?=
 =?utf-8?B?VUpvTWZKWVRPWWlhSFZjeitLUTVqZ0Z5RVk2cVRWRkpvL0xpUnUxdG9DVFht?=
 =?utf-8?B?OVVzdkMyN1J3NFp0S3pmVk5NZ3pHKzlFMVBOSGUvWFpvaU9BR01qY3M0bTE3?=
 =?utf-8?B?Qjh2NWs1LzE4amxkTFpQN0VMTHoyWjBwNVc1TEoyejFHWWpoc0pEV21HWXpH?=
 =?utf-8?B?Mk13QitsNlJJQmROM3NhMFNpNHpJQzFUbU5JMzJpWDlvMzdzUTl6Tml3QmVP?=
 =?utf-8?B?emFOZFU0U0ZkYXJOdEhwOUZZaVlyR3JDT213ZU91VmlHdFZjT3ZPN0htcHVq?=
 =?utf-8?B?b0pQVTgrczljd25Sd2FpTUdaMGZXdGRmWHNPQ2dLVmlxRE13OU1mOVpPaXlE?=
 =?utf-8?B?QnBONy9GTVlERzgzY0xPcVYwVTRSeTFXSG1lUCs2ZmdteDBxZkplcFdSM3hR?=
 =?utf-8?B?UFpnK25QS2N2dE50QytLRTNiOEJtN2pnVGxTdkZ6VmwvWG9GdnpWc2d2aCsz?=
 =?utf-8?B?THB0RnNwRE52amdaTEJMUFJRYjExOFBtaUVSSWxqQ1ZISWw0WkhQVjNPRTlo?=
 =?utf-8?B?R0c0TFd0UGJNUjY3TzVoem15ZC9xdWlZZU8yK1l6bEtwd3QrVmtUVkFvakR6?=
 =?utf-8?B?bDNUTXRET0lzMWR0c09WcG1uS0oyR2hvdi9sQmRSS3JkSzRPTlNnVHcydndH?=
 =?utf-8?B?MkZMaEtJSEM5c3VZcmVlS3V0bTRvcEc3MWFLNHdXRjhYWXhWOWloc1BSRVNY?=
 =?utf-8?B?eHhGejl3YUFhZmo3cGdhZ1dpQmdXdWY3K1AwUVJ6SENNS1gvZVVZVzlUMkl6?=
 =?utf-8?B?SldneTRlclljK29MdmJON3hTOTZSeUJjdjVVdjAvR2g5ZDN1Z2NmWkZwZEhu?=
 =?utf-8?B?K0lSRTRUTkNwZzJSY0cyZmQrdlBhSVBRbzQ2dDhzYXBjc1JLeUxVODJmdUhz?=
 =?utf-8?B?by9NQTY3NEdFRW1jMjcwK2lLa3NJRS9jN0lMMGtRYXdMblMzUHVHVU1pT2tP?=
 =?utf-8?B?Q1A3YUd6cVFUZUZObTM2RnNkOFNiS2hLcFkxdTBqZWlieWM5cm03Qm9mK1ll?=
 =?utf-8?B?NTJnUndnVlRJTDlhazUzQ1lkeHdxU0VMVXc4c1F1SU1nTDgvdk5kMXVOeXJv?=
 =?utf-8?B?VWhJWEswRGRBYUxIajlQQ3d0aG9ydm1Yd3dFMEtrVjZTdlF3NDZhb05xam9P?=
 =?utf-8?B?RHNFajJUVWVxSzdqQXFzOWhFMTdqNW9FSFJ3NDN1REtNcm9OR2IzaGJ5WDZz?=
 =?utf-8?B?NSsrRE82NnBVcEJrLzlUbERoR3BKQjhVUklNQTVTcUtTT1ZXUnlORmxmaU9v?=
 =?utf-8?B?Y2kwdUZUcVNjU2hzTGVOb3JuWHFhL2laVUIyRDAwQ2w0SnR4WVRnaitwYTh2?=
 =?utf-8?B?V0hFKzJtcGNoT3k2bFgvTlU5eHlyMUp3MUdtNStRckpaZ0svamFicUM4Mlhk?=
 =?utf-8?B?S1R2Y291WXpIWkx3d3B6Q2NVM1hoanBsclIydWo2VXN6d2xGN2ZmK2R4N0lD?=
 =?utf-8?B?NUJFY2FLWVNQYm1Wa3dCM3pUSFdsQ1FQeFErTmwyam5sN01FdHdYWm5ZY1Ir?=
 =?utf-8?B?WERueEhsSUc4dy8xdC9lR0RxTUEyQnNGWk81MVBJWk5VKzhFR3h5dWZZRklQ?=
 =?utf-8?B?akhGTDZVSjVtOW5Fc3RPTjhXY25ldVAxUzl5SFhQVVFlV0tjeHVsZWhhYlMr?=
 =?utf-8?B?VUZOU0VmU2lxbVdzRFJ6ZE1WWCtUQmNQV09aQmE2RjBJMWlNdzNINVZyNzh5?=
 =?utf-8?B?YUdxUzY1b2UyQ1NTNHNOWGpWTVcyRVF5SjBaakp4YnEwVUlsdElVUEI5RXFi?=
 =?utf-8?B?SUhXUEhsb3QzN3dKUzMxZDB5M1c2RGl0T2RQZDBnYll0b01rajFsS2FNMlM4?=
 =?utf-8?B?dEd2cjdXSDVjdXk3eithcUNpL25XcE1PaXVhcC9wYnR2TzAwZ2FFMlJmeWI0?=
 =?utf-8?B?a3FSb2xnb3NCYVFNODZvSGthcnZtODhMZ2FMOGFmMk52WEgvUGgxYm0rTFE2?=
 =?utf-8?B?aDJ0dHJKMTJGWjVpdDBqMkZpVlN3RDVsSnpKWndIVXBIRkZaSnZTNkZicEN1?=
 =?utf-8?B?allIT0tDTEJtUm45M21zOTM3eE1UdE0zRk1zUmFlL2dmaFJCWFZpRHRRZDZ3?=
 =?utf-8?B?K3pFbEhWcVFZK3dmZW0razJ0TkY5K0RQN2UrUXdiNkJSeU5qbzBEc1ZRSlBo?=
 =?utf-8?B?dEV3K1pHNDM2Y1NmeCtxY0FuK0c1TzFUZ1lCY1dmNTRQSDd1K3ZxNzI4SHpJ?=
 =?utf-8?Q?R1GcwykIPNW1xgRR3DjJG1tba7urapOkuROv4JD4xhxJe?=
X-MS-Exchange-AntiSpam-MessageData-1: eizlOkaWLvUhlQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07367695-0a7e-415f-1cce-08ded20201dc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:05:19.8180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOFfaPLe8DrCfML/kQhhyMUtJQmTA/SwVUMNcSeSWE9kyCsIlRN4X7xUFECeHAFMgN06kRFLqKfnOg/k5RzLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999191
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9363-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:dakr@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B87E66BF872

On Fri Jun 19, 2026 at 8:08 AM JST, Danilo Krummrich wrote:
> Implement ForLt and CovariantForLt for Bar<'static, SIZE> so that
> DevresLt can shorten the stored 'static lifetime back to the caller's
> borrow lifetime.
>
> CovariantForLt is sound because Bar<'a, SIZE> only holds &'a
> Device<Bound>, which is covariant over 'a.
>
> Since DevresLt::new() handles the lifetime transmutation internally,
> into_devres() no longer needs an explicit transmute to Bar<'static>.
>
> Add a DevresBar<SIZE> type alias for convenience.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

