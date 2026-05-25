Return-Path: <linux-pwm+bounces-9121-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPi4COdfFGrRMwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9121-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 16:42:47 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9855CBD33
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 16:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFF9A300407E
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB0C3F164F;
	Mon, 25 May 2026 14:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nsi2/rrA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A83ED5BE;
	Mon, 25 May 2026 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720160; cv=fail; b=OKMnGt2PeT3qmfZIM+aE+S5KwC2B+8rvrd3LFqdY5cYWfRhKjEOH4D7cOze+5JTo9lIaYv8JY/cDCKVg8JIvWZuQQxC6dAqWwrbQLh39XLp5tLKcOj5Hrq0+4R7tnfTBX0W5JSMVLT0JHxhhGIXEAiPkTmNMJYTqV6dTxoAWVUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720160; c=relaxed/simple;
	bh=mN+oEh6YboDuDGGwLsMunh47jnZ/8CgK3MNKOTrXqNo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=sT/EVo59S6O2mZWKA34Y0o4fc92lNW9qmwfOW/Lspc5uawA/XEtrbvSI4oMGutqGfBUydaePFzDd0f/pxMHFPshhjBR2XOZ56opYmF/tcjEg+4BdOS+RqoCSOwal6vKZhyEeJxXcsD8fZo6kf1cNgjlTk51DKRnfvMxq4aWF7mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nsi2/rrA; arc=fail smtp.client-ip=52.101.61.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODqP/wQTGUnOnWQxKy7A0Jjtf0WLkGpxmdklo3FuPbXj0Q8cfRx8GzG8XaHXuwVml6h3F6SdzPVpr9TckReWlCmbT8niC/kim7ZJOGI07DfHX9Ul1eLBYwXbWIw+8z+EUYcWM+d4A+IWuZR+A9m8CP02hlruN9/3cu6MHgYBPATTDw1NPNAlKvmW39Mf36fEZ2kT9vd4QIw17UgmlzSAA0zbngmqkV5Uhf7Q/XliOac8g9/K2Sx+uwTExQ4yEDP72VJcjaDSXnkjVi41XVHqxtIUzW30B5pun0vEQFpK+4FPEqTE5F5NfqjiuMN1sesrqAsckMK1Q0Ypn4TYybJx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN+oEh6YboDuDGGwLsMunh47jnZ/8CgK3MNKOTrXqNo=;
 b=ObFOraqkgCFpoUs2ckYRy481nrSNx9LCsYQb/eAteKmtp19V4x3J+hPCD2u7fOzokLgLN82R8Ap/zYlMozLRfe1bcCWRVBNjDjKnWJQcjw3qTywEzQsvOmGXPG2uoBPoIBVzCSnDrZk5G4NaZHIKH8tTeOwQbBkYA770EdtIp9W7wsU+ZXfhVMf8BKCUqZKDk6MIA+VaVBsyxrE+zauK3//Nvzmr8F1OnWSWUXfPXllQSGtRotVEiCLMJmJbaGQckesAz+vLSukYK7JE/DZCQ/4XBpskXopxX/Qp5Qb9JS4/EbQOCE2PdiJ41xG0miw8i65pfVl9E/F5YAuZHn2jbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN+oEh6YboDuDGGwLsMunh47jnZ/8CgK3MNKOTrXqNo=;
 b=Nsi2/rrAH7EHoCF4lee9URmuzkuhXp0vP33V8z2zZ3ylHvrWaeL3YAKQRfTs1Odqh8SnTduZ6PaSAw63AOlfCiZMd69XtUIXwcNsEuWUqmVLOUrgVEN6bS4x9WFv2QL4uQiCfF9LRg2gRgk9tx8YfKlBfUNnvV79P8+zd2PffMtkUROrfUOv1upwyrE8YWu0sLfrZjysWGODYM7cdMBmgr3LIQmessoRRRL7JIUF/EVEGyKKwBFbD+8UywCA0HSKoASdI6NJpFjHyurOaz4LUgx9bDQdvP14zDrM5kZjUFy98gUfyC6Yv63AAPdEZyMS15LAx13nLOPeyO519ZCM3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Mon, 25 May 2026 14:42:31 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 14:42:31 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 23:42:27 +0900
Message-Id: <DIRU50PTFG0Q.U0UKXEY1BEHG@nvidia.com>
Subject: Re: [PATCH v4 22/27] rust: auxiliary: generalize Registration over
 ForLt
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-23-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-23-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0109.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3efdb810-1419-4b10-b545-08deba6bd989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	EY49wOcDbfUgB2zcQv8F+iexyyX2N2ae4XRCXMzeuFXUnOqgue8/DDWnWlRhBgT/IOgLvk819s+HB37Xwp911NQEsGZZAG6/84wXKL1UFaF+YUVSVA1WThyFvyCeHJ5jIVynFonhukp0DncUHnEEaIVOMf+P6jDOwbXNnKvNMxa5ZAMvvSk9qYgDlGtITv1azmQzHNiOA13JxW0Z6+wSUVoam30gyhwcx+Uq3PV4BvL8+Qjlj2rXCFPojyMXb9FiWLvP598jAlihgXfbFpCt/le0P0wglJBFj/TFkrl28vr/+zMirJXM6ubfET0HGhGWaUNMI0RS3UtsK/t5PNIpBJdqmou40WPTBX7/UC1HkryV5iwnb1IU2Bw+/bZkp5luKVqM90cR1EF3Oyhr310ouPjhABpKDdwTkCr/FydCIEn4u8M2Wb/fHFSi2R6kYMeR+oMCxniYEc4Okumuiju6dBKpVyoRfzVT6mxisl1VHowo2YfSVj14nObPSxLBQFaDrWqqqea/xRmTNY2fuqPVRlQUK3elhgUvvpKCxk+UJrVG9f9ZLYpyekm9yrkfUnBtO4HdC4UW4qnorAKXcfMSQFG3CY+Jm/P3JGrBq66uiWXIMMQbmi5GZ8gQy9TwhR2TpvxcU2udecUAYlYAmOL3e0Yanb0r6eHQsYtKFIXFHEZyWStKvYOpYiYCGhzWA8yF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhuNTNGU2JaZEpRNTRaNDVhQUNGZnZWREo4bEl1blNwTk50ZG9DVk5qaFNH?=
 =?utf-8?B?aWhMclE3Sm9OYWhBNSt0OHRmK3ZKT3VxR2hPSVFzUDJsLzhpM2JrcklOUkRa?=
 =?utf-8?B?RDRUOUhuNUtlMGJleCsxYWxOYWlwdHE3NzhYcGZVazl6ZzNWYkI0MCtBcDUw?=
 =?utf-8?B?ZUVydTdFdzNER1RrZ0dPNUV1QnhaWUZzUDBGaW5YL1pOc2VadW9sMklMRkJ5?=
 =?utf-8?B?WWlNQXI1RzlCY2hzbU0zM0RNdFd1S01RWmdjc1hqbnpRRmxaVy96dUppYnA1?=
 =?utf-8?B?cGpUOUpNQjhicUkwMytLSUtPU2VueUJ0b0FtdTFhV0hSNWZvOFR4cE4zbHNu?=
 =?utf-8?B?cVJpbTI3NjR1THZXVjNzMm1zM1MwdjV5N0l3bFJpak1Gdy9LQytXSVRrTmM3?=
 =?utf-8?B?dTN1MFVWQ045T3dsNjhBSFN5NlBreWFYd2pkOHhVcS9UcGtnRE4xUjdIdU5s?=
 =?utf-8?B?OE1zVEFHVVUxc3dOMm1mejhIaGd0aituTHozYjNleTRuMXc4QnhXaXZKVzFa?=
 =?utf-8?B?U0k1elQ4TEhBL3pBVDhiTm1kdkhuakRTTHhtR3BnWmw1OUUzZDhyanJHbE1J?=
 =?utf-8?B?dmpDcW9QeGRjaTFQaER4bk5Bb2ZVeGZLMWk1TWhXdTdXdzRjSG4xYVRnNHh0?=
 =?utf-8?B?bFFjcmJwb2ZpMlIwQnVHMUVYU1hRUE0wQkJUUWs2ZWNYSnVsZWpiYlUyMmky?=
 =?utf-8?B?Wmszbm9nYkE4dHFOUldTKzhqM3d4b2I2RFFSQ3dNbHBicFZJT2JYekhyS1B3?=
 =?utf-8?B?U1JYUUM3M0svNHFlVDJXcmFyTWplY0hLTjNCRk0raEw1RElhektLMlp0TlQr?=
 =?utf-8?B?UmFLK3pZMWloSkkzaDM4bytiTktUL1p5NnhzTEE0dFE2cGhyQmZTSm11RmFS?=
 =?utf-8?B?QW5LelQxendGRk15WXJHRHFFZ0VqSUpnMWxwRnZGaVV3VGczRVRKSFNLRCt2?=
 =?utf-8?B?L3NyODRxQmMzSE1wWDhWcnlscGhjdnZLVFhDV3pmM3hxd0JtZkgzZXFzT1My?=
 =?utf-8?B?cmVqL2k2QnZESHJrYVA3VFJjamd3YzFWR0xXTkZDcFZmQ2NPMENhZG9rNXpn?=
 =?utf-8?B?L211R0h6eUZxL0JNNm5HNVlKS0FXN3FEQlliZFBscVYxTUhUQzd0dUYvS3g5?=
 =?utf-8?B?TmFjK0dHdGZoUnhQbUQ4c1Z3ajNRT2xlWTJGU0tHaUZyNm50SCt0eXBhN2Zq?=
 =?utf-8?B?QVdLY09ZUmdTK3dvZE1USTh1c3RNZi9heFpKMWI0aUw4dmVhcnBSUVIrSmJZ?=
 =?utf-8?B?QWlyV2REbmJld1E1YkpZRVZxR0Y1Nk1FWkhYVXZLUWtJb3I5SGdGbVRUdVBE?=
 =?utf-8?B?N08rWWtrYkhmYkV6dlFpeCtqLzc3eDJqeGFLQUhvdFBnRCtPbDRRMmFqQ3p1?=
 =?utf-8?B?T3ZaZ05FaGU2SWNQTmxuUzg3eThZcmZnOHM0WnZWcnRCNHlqaGVmbk0rZHNU?=
 =?utf-8?B?TVdBb21rajlYYUhvUHljYm1kazZIUnRTakMzTzBlc21pSEkxSDhNdkNnSEFp?=
 =?utf-8?B?WFVRZzJYMkQ0LzVOYzVSSUhSWlAvQVRaZ1NWR1UrZnk0ZE9UTFFCWkFQdkNv?=
 =?utf-8?B?cStMTzk5d0dRTTdOTEZ4OFByMGdtWjdRTFJ0ODdWOVVoR1I3UE1GSEFXOVd4?=
 =?utf-8?B?Z2J5R2Z0bVgxTTB2RHRUUldjZlI3ck1FQmVHbU5sWS8yZGkxa3VCSUxHVFBL?=
 =?utf-8?B?MFg4YklGd29xdDJtVEN4ZTQ2YndaeEliRjZ5ZHFiRDRDNEhqMTBQbXloSnJ3?=
 =?utf-8?B?SVpFQmowU1lqYnYzaVNHQjNpc3h5czU2RE1ZcmNlbG8vbEgvRFZOT0RYWWpn?=
 =?utf-8?B?ZWFoUmQ2ekozemFlTk1xYXM0ZEU4Zm11aDIzektUa05oWS94ZWx5Rk5OdVk0?=
 =?utf-8?B?QjE5SmVXbEx6MC9PYVVZUkg5eVhRR1ZQbEVkbzd0US9MU29kdklhcDFLN2tI?=
 =?utf-8?B?M3l6VnIzU1BHYUpLcDljMno3MDlsMTRsa29TTG9VU3ZpUllQcGVsaXUzYzB0?=
 =?utf-8?B?NmpLRmFlOE5Wand2Lzdka1EwYXVIQkZkblZDM21KbkRHVmhJeVNVczgwS0pQ?=
 =?utf-8?B?UjZZNXVlRmpkOCsvOGFSTVh3eGtCTmZhL0ZmeHZlcEN3YTJSeGhLWHNWSFVS?=
 =?utf-8?B?TXRtNU85cXg3Tm1NUVNRajk3T1BYS0EydFVjeUI1a3RXZDExVnpSMW1DLzZx?=
 =?utf-8?B?QkFOOUlySWFDN1ZLd0NtK2FqdnVWbytEejA1RFV6L2pUUGZYLzcvYmtLTlNk?=
 =?utf-8?B?aE9oc1NpMG5JcTZ3U0MvU21pQlBpSk5ZRzJZMHZOMTlTZnEvcEtxY0k5Q3RV?=
 =?utf-8?B?bVE2eGRNOVdpL3ZjM0lzdFpXakw1cCt2czRuZTlnaVR5ZVIySldmZHdOSjk0?=
 =?utf-8?Q?NYXybxUGJAJOMhvkof9BU3K3JbObvVgVzh+Fu6bCaKDiB?=
X-MS-Exchange-AntiSpam-MessageData-1: APkPM35DHnCBDw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efdb810-1419-4b10-b545-08deba6bd989
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:42:30.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ChsOX/ET/TEEhw4sXDaCArw5B41sxCkTfENdgiQxZm0VgT9bSlc52MmBTz6haBxp+zICUjGXlRwmETuarm99zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9121-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1C9855CBD33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Generalize Registration<T> to Registration<F: ForLt> and
> Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.
>
> The stored 'static lifetime is shortened to the borrow lifetime of &self
> via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

