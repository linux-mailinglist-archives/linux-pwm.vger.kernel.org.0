Return-Path: <linux-pwm+bounces-9174-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG46GlLyFmo3yQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9174-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:32:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F27255E4FF5
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 747DB3194BB1
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6683413241;
	Wed, 27 May 2026 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kN6DOvDk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020091.outbound.protection.outlook.com [52.101.196.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AF413255;
	Wed, 27 May 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888301; cv=fail; b=tFVBEw7c6LaDClA0i+JqQuCzAMxWec8IpQXwQw4scFN65aWwPzl1eb0ZgZDAwJTW10OuAsb6YS50um9bl2nUd/NEkfAqqZMSJQLAMf9eU2++eLkgt1YDeSLKjssBzbAQ18uvhEk77TMulpF1tH5OBh6RRWuJV+Q4a0zJmP8oyC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888301; c=relaxed/simple;
	bh=WV+lo/Ul6TjhYDEOke8MKDxMMaBwn3SksHFV1chHgIo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KD8a5GjRatVTrhoNGEc513N4Jnrevlu42SixVypauSWCDfzwHRmHOTczjSebTSbfXHif545M+ggfPM5QAZdSH6SJRzwNrGs6l25viDFPyFc64dyzDS9xedG7Uni5yw8nPvujN6K6gBqF0D1oX0mxiRuThScLuyM1tA1dxm1OHLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kN6DOvDk; arc=fail smtp.client-ip=52.101.196.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNth5InPORjIGkHWbkhln/Suh/0yWA+k6YBMDltP0AoxlRLkZoK056P47ZrYHo8HWKZuUvkKpCMuHldxid2avTcaQ0CV6pmN7/LBOVcgzx+Kx/0/rvji44uY4s4PvEsnDzZjK9ilZV+HOmQICSaBiv6iuQLYCCrkvwLGv0WzwYpxZcff79c95gbyLVzg0WHvDsesmwciSIUBcj5PArawO1ZAoEkmKnqlJ8Kzz6liyzkHJFHjSIXxWPVDR3e4/qI9pG6x6iY1yrsVfPjC1mD/kQYzyzpD/Xcdqu3jmxJjUa5m20ATTfH1c3V/sXp+rdeiukhQ6FVadKNgR/d5jCoIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47ErLyJcUSg6vNN/ZzBNQ09P/h56UZgtDOVSL8G4J88=;
 b=xK3CAZloxHfeLFRapDyKWXH1rEmyP79ZfbmWeejFLgz0bXF+hmUWiGsHUz4Zql2btMpgdo2gAvr/VEuwa8rNxUIZkIDtrqKO/92wMZtcFFEeYR2czeJ4DoCTNS8yUV9CjdFWCN3kxichjW8ppwhvICcdED0uQKjP7nley1cdUsrvgGHT4fk3ZkusPQIb9r5sdMSny8sUKDfcHrpZxgDkkJVKseGAQuanpKGJLxG7W/7Ife/LHjRbKNnuYF9YGh7ANM/Qh/avL6s8yo/kHbn7nnVq1vVaIrh67b3fSS8SvrPGxwrNRD3aDDbckUorFKF4D49+H30nmT60CdK2b5/AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47ErLyJcUSg6vNN/ZzBNQ09P/h56UZgtDOVSL8G4J88=;
 b=kN6DOvDkC+/cl2Ymr2P32aA5vHSqDq8EZkD0Av0/0iyF4Z7x8QiFWnAN4rPSeklT8639DQ60sVgV2ySpSnYLMgpbgV4TmDIo2Amj1H0bLACW6ONEcabp4uL9DEl7asXw/7mCf6Noxl9+iX4IPhLQxtX1ISD5zdPHImSvlia64OI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5882.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 13:24:53 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:24:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:24:51 +0100
Message-Id: <DITHQP6MHPVS.3ADAD7FI4IMRV@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 17/24] rust: driver: update module documentation for
 GAT-based Data type
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-18-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-18-dakr@kernel.org>
X-ClientProxiedBy: LO6P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cca96f1-a92b-4389-5263-08debbf35665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|22082099003|18002099003|921020|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	FktqE3LvU0L8SCf32XcyYozBHqNHYxPsNx5fAwKEL2TxcHfXCR32jZBMfYMV5FLDXsQdtStdyk/KV1hQcs468mF+574Z002S0rzN6cE1gpDIWZ6/vtZVFioW5GMJfZLt1b6StgaUxg6tSYNCEnuc/BLQIu3ymu3cCs0Uh0MWwCORCHTBRW9hTy38SNEc6tqs3Irz7m46p2BlUVK+r8EMVjCVt0BdV5ZWxX6uryU7fsRtGOC8ZL4gSaOuR538GD8GjIoRO0ZETubSJzf5O4RkWXE0GnrXW/UC5lnw7WQacd8ukX/6SjLkTlrhhWeQgeLIapA16zGico1fcV+M0vTmA87mg6HOcWQb9JMnUhymftzdCYsXnOtq/3Nb+Rn/hvlccQB7kNRz47bMVnKrZ1UDSo2ax1u85DVmqlWTrhFVG5xmiMcLeFgd1onTTXim8ApMhlM8dcg2gv6UPj4TiZ443nB6fnshX7go51Ga042rlMnuVXT3QzMwcCoXm6ZOdhQIu+7JaQWnzruTkNyhTJWchfP6VzEP7yGn7jsRNzBBCnq11FtpY83NvF+Y01d53CK5ZQJpxXyjz95Lik/O9N7XxOpbwp0JiMJMBWyq8LYPYHtCGT21nMaL/ebYNw/xfkMwGNTNi+p9w28NUp9qIxH5ih1ke/ods0FTeRS6Ds4qHaz71rgRcB/0Q9Y++XLgaW58FBUofKpgXDUEk88/hTgi+dgFPpqUEogYcy1bUYgKv60=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(22082099003)(18002099003)(921020)(56012099006)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGw5VkE0elhtMGhnL2IyckdBdWFHZEFLbHg0MnpnVUZHaWdORFhRMjYxczNq?=
 =?utf-8?B?RUFDTXh4WGZ3RWdWbzAydERjMkI1N25PMVFRWkVVazM5V1I1TEd0azQ2UUtr?=
 =?utf-8?B?dlVWMlNMY3RWQVJUUThLMDMra2dsbTVNbUNxWjF4TFl3L1dycVFhOHN4Q2RN?=
 =?utf-8?B?eGlmc2UvcTB6T2RKdVJFYks3SVFGNWV5WEI4ZTNTOXROeGw1cmV3bGU0V3JK?=
 =?utf-8?B?KzZ4ZkRDdldreFVBeWh6TXFVWDNuZHpZYVpSazFwc29LWE5QZDQ4VkRMWXFa?=
 =?utf-8?B?aGN5c0RCWm15WkVxanNiZGFaNDRpdXJQbkYyMFZwbzk2aFVCK2QyZkdvWFdE?=
 =?utf-8?B?b21VNXpOd1hhYndzMFNiYUVMdk9wVmswZHo4Tk5Ma3JmbDdTWHVLQm1kN1hL?=
 =?utf-8?B?LzdkRTBndytGWEtrRnhvMERkNDF0QWcxV1JHbjlHWFR0K0dzcXliaE4rWnBX?=
 =?utf-8?B?MkQ1N1hSQkpIS0FSc01aVFRYaWRBcGd6NVgxS1B4WUw2OHhyTE1kOVg1bTc5?=
 =?utf-8?B?RCtQQmhiSGd1VkxiMkxlQVBuSTF5UmVXRG9CYjBMdmc0Z2hjcktjWVB2QSts?=
 =?utf-8?B?eTBQdFk2NWI5TmpaWWllbzRVbWIwZURLdkNyTWVBdklTaEdsZFZOU1pCZ2hi?=
 =?utf-8?B?cXBRQWg4RnVHWVFWUHdneVF6TFo3ZnpGY3JoanhaZEZFUHVxQzNSSDFUazZU?=
 =?utf-8?B?aXREYVhoaWttVGpqeElOS1A3blJXTUc5MDNJODduWlNEam15Njdtak1KOGVr?=
 =?utf-8?B?MkRac3FUdkpvSElGb3J3V29GYisxT1BSaEQwSGlyTzdZYW9TSmlLQnlYTUcv?=
 =?utf-8?B?UFlvNDFjNlZqdElpaklzV3NySDU0aW1nTFY4QTFPR3JsdkhKemh6YzdKSVgy?=
 =?utf-8?B?RTRkMUNJYW91Z2NOckc3NUhSc3dURDFQZGo3SitFci96ZU03WWtIZDliam1M?=
 =?utf-8?B?L0pLUm9TRTBRRVQvMWJsdkhLdUVzNFdJNHBmSVIzZUlwckpSOUdKSlBPblFR?=
 =?utf-8?B?OTVDZDFhcTN0dHU5YVo5di9pU2drWGNyVXBpV21zaUhuWFpYNE0zOFZSR000?=
 =?utf-8?B?SmI2Q3BGSFNJVmw2MXhoR01CWmQ4QWl5azAvOG10OXFiUGdEcFJpU1RVNm5j?=
 =?utf-8?B?N2dOZFNyYTNYb1RKQ3hyNC95QlVFTzZpNU9PcVNOMW1VRXZHRFhDbmhxbGRh?=
 =?utf-8?B?WVJwWk5CM3Vwb3NkRG9MbGRxdGNnRnY3YXZndVFnVmNTV2xmalF0ZXRvV0tT?=
 =?utf-8?B?SVF6UW5DYXpEZDdsbEVISjQ0U1M0U1NrQnJ6VnZ0R09PRUxZMW5PWFkxaGFX?=
 =?utf-8?B?UXJkZ2hYamNFVTVxaUtsSHFlMFF2K1JOQ242NjdjWm1yelBWTFZ5emg4bnVF?=
 =?utf-8?B?QlNpUTgxU2E4Y2VoN3RORUNjM1ZDczBIMjRway92SXVwQWVwVStxUWxVa3dh?=
 =?utf-8?B?dEVDTjZLUVZtRDFUUkJZa2JuVStqSUUySWZ0cDFJd3dxTkZ1VGlqNjhHdVdh?=
 =?utf-8?B?MkxhMkxCZjRENkFObXNrSXgvcHJiUUhJdlFVZ1hpSWhEWG5CeXE3KzMvclhC?=
 =?utf-8?B?NEVHdzkrNG1RTnNDUlEvY2VwSmVscnFNdHZCWDlTbjVoQUppZnU5OGNlRzEv?=
 =?utf-8?B?V3l6endhaGpLKytMNlV4QTRXcnVZaTlhSzRCbWlka2ppS3ZkQ1hDY0lZNzh3?=
 =?utf-8?B?V1I0cld2NUhsbHd5ZDd6a3l4bjBWRWVtTnZYZHExUFlGeTg0eGJ2am15cVBk?=
 =?utf-8?B?SUIwRnljUDgzZXJ1NHcrUTZvcEFqZVd1YWJ6QUw5SUpUaFd1dm1jRUMvWDdE?=
 =?utf-8?B?cUdtWlY2dXJkNzVtS3RoL3pTM2xGVlliVUdiZmRSZHR1U2lKWVdQcEFTZk5M?=
 =?utf-8?B?YTlFWms0SG9haGFwWGNGV2d6TE1zdWJlYWt3TmZBVVRZMHZVbWpIN0hEZ1lN?=
 =?utf-8?B?dU5KNWNyWXVod0RNOWZmTWhuNnRHNk9XeEQ0eHVlOU04M0dWTnVQdzh2NFEx?=
 =?utf-8?B?NWdwQUxzK2lNeHV2cGs2VExTYy9pOFlOK2hObks1UVQxdkxxY2tVajZOcTVv?=
 =?utf-8?B?anI1NTVhNTZCbE1OdkFsL0poZXQ1alpZZGd4S2NhK2VaUWhpYkxHS1BCVnNG?=
 =?utf-8?B?VHIzdzNnQU5PM1M2YkxhVU01RjB2bjQ5dWc2QWdmZmFPRU4vaFFmMVh2SGto?=
 =?utf-8?B?bm9tNmxvWjZ4TTU3ZWs3TzFrQk0yQVFmaWp5dnIrZTJLV2ZqbElSSFl1L1BX?=
 =?utf-8?B?NzRhUEZhTmpZaisvRXpaYnZXUFhQN3dsNnllbHE1OVRGRFlrS3JaN0VXWlBp?=
 =?utf-8?B?aTVDOGJoenFVdG5TN09LNTdwZWlUZzVrR2IvOEdxcWl2aEk1UG5DZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cca96f1-a92b-4389-5263-08debbf35665
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:24:53.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hAASpyneWh9VR5o3ZMmqXLc0mbekc7hWRiIK60+VtV25TTcJfd8Ao7PNRqKlE09COfzxaw45+NrnI4s57x8+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5882
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9174-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:email,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F27255E4FF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Now that all bus driver traits use type Data<'bound>: 'bound, update the
> illustrative driver trait in the module documentation to reflect the GAT
> pattern and lifetime-parameterized callbacks.
>=20
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/driver.rs | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)


