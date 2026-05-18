Return-Path: <linux-pwm+bounces-8974-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPJdOGg1C2qgEgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8974-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:51:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2795704F5
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E316030FC31E
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A533F6C4A;
	Mon, 18 May 2026 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ni3U/lAC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240322580F2;
	Mon, 18 May 2026 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118757; cv=fail; b=UrbvetoDgtIyza4qqTfhr6hqq2iwCuo8y+h5+0pr27dugB/Ybu+G2znsect0RJKbzTAu5B0MAEGll/sfjvv3GNwffyfMnp4o26snnqaIrksIAauHnQGQgZiJM59pearlyb3WPClJpLw+Fy+pZEPYo4SnHIKSTJ3cNObDbK2sE+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118757; c=relaxed/simple;
	bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=JVIy7yIzM9XOLdWmFmJA6Y4xW3s28uMncq6E6IdxX1KlWDu7lgobD0G0ofRjs8GbkJq2iZ3fleIvvfHE99BS+wv5dXU2UzpQohwFATqgV+bf5qULAVX8nv7lfMs3102hBva7LZvYnuBKP1g1Oa+osZ7aberjillhk8KKYgxPFoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ni3U/lAC; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4m+qjzCCIuM8nmlSTZI/AWmoRRUuCoz7bW+kic89E+RwchKyDlxE2Bs/Ittth/nskCzyIi7fZO4J4GN1qvvTVoXA9kP1VrlruQPuuC8mLZUxPL62pDvWRF9Q7shsZ+gstLw4Wve151bpoXCEgm3azlEVQ/o2o0KJlxwtio9fPrZSBJODKOz6DTYTJYayxoBNMa0RIopXH5vHtYqBUAiy59eWXxWokE/TE4ghD8HtzskrmxgoPLn2sxDYPyHwf5QqnHimEzY8+XagLBEw5+TYsM9tH0dNYa8lu2xm0/tien8pc5/xPuszfTWtWXxG/NDEoC3sUrDFBHiPXh667Hv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
 b=AzHS6hbiNw5n4pEAwzgNt41GDS9KdDQYLrjZ5ERhCisXJ5seCA0x0pqOmMTwn8GpUEPE1+Q4zgjSTyrvo++3x1JsYlABGQq2+UCzp6+4RcHcawUQNhom6tgp42OnfzySQ3dgp5aPsK4Ib8JHwomu3gxin+JGbaxKZaqjsxUxfGC74StCM+n9hYOTcuGx03zIUKnAWCSUF8saMSKF2NzrPFvul+/XugMnjLHJDBpSPN3zDDvvD+Zu/4R5YwZTVvAVd4KA+nlApivsNvTHRpE5keuUgAbUQUdjP4LnRvPPSwpRPFz8FT3pUySk96wmRXvDLBCArSVJk8ep6yI/4poqqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
 b=ni3U/lACfCnV63fFqEGFm2XnlRwoWTji7PUCORYxBFN5wp6sIqXR9YNqNPRWuqt38cODCUge8bHPG95qejrzWEs8fXtCWfuiLkfdiyaHkaoLlH8q6NtQxr0tRkLv0Mw/rqRhqW7Im2GafdvOklQL0E+kfk+CZBTJg+l9cANPxBnkuBhMD5IRzzFI3c+tzY6u2KDZvvkMG5GRpouAq/DY+Qw8ozluOQlMohJRyYni44R5+Y92Isn04UtvHNWO/iPagDa7p8grnqzscmfYUruGOD/xSufiLgx2RwPHiVQb15sZwLZodHBr2Tm5PeKEgVmS2Vp8kyvsUrquabURmbitFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9823.namprd12.prod.outlook.com (2603:10b6:8:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 15:39:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:39:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 00:39:06 +0900
Message-Id: <DILWYKXB7N09.154ECUXJ92BOT@nvidia.com>
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
Subject: Re: [PATCH v3 12/27] rust: auxiliary: make Driver trait
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-13-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-13-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b3f7a9-a192-4144-f037-08deb4f39a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|22082099003|18002099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	1x6zSItbL2pOOfICIWqPtjeD98G0Ma55EcW0mCB9PO6xYsXzZ6QwQFWGm+nPErTKvnF6ropOYEK9NeijvpYPLaV9rQ6E76ruHcXwbD/iZS6gWNXLewJ+4S1PvmbYlhFw8t6AsvJI96KjLXTG3JmLKbChDng17KYLhcbHauwpWvaJ5aVYbl+kwRYOgC2XLjeqKX1IZ24XG2UedEU/orl6B0axuG/74v4Fil7vCBy72+1VfMcGyV2YRsdT003lwDwy6PwIeBgfnW6LZpBX2JDfNG/Tm1CXThKzXUDsRS31mccRCQegkQ6fTM1GwZdPCyk2N9wX9Cge5yh//fl1HHaAOjholefldWZP7hXFLwuG6qI7E6U/6WzsEPGVRUVD5iwetbSyDDhMYrCbtRayVBW42pmb7YSNV88HzaPFp9zyrv+EeykgY2ZvyFquUMZ584c8Qjfl8+H/iCeaUx3EEBfae7F60NBOmLXPkl7pniQLkYs9PoXei4zXEYIccP6zaysDI2woZt31OwdAh7fA58GpXBaZWHErUA1opo8St15cO6e4IJ+ESlpSX8j3mqtW/aVzap5mSBKDqMiqkmmkR66/aV11d1PqJyJnOo21ZZzGvJH0O3DrHgCLgQcb9rF1dQyJswoqQ6G+pnCpQ+5GTdrzCAceP6RQ/HMn/0pkqArW7Sjvc39FlDWXv09YzH5JbNVq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2JqeTdBQmRGWEhtY05ic2dTTm9URjErWXhFVFFuZXU5bUFiK0JTMHNQYjYx?=
 =?utf-8?B?TE55aDRHWnVzT21NQi9FcXl3R3h2RHlvSThYMlpuMDBCVmIzQXFVc1lTZkx0?=
 =?utf-8?B?YVNad0pWamk3WmFpL1ovVHNnNjJkb3E0TGcwUFF6b3hwT3NyWUltMHFYc1Z6?=
 =?utf-8?B?NXlKQlEwa3RzTmlsTmpSMVJOOFo2RkZKY0dzU0NMN1lodExJUGlqV2tsdGdu?=
 =?utf-8?B?Rmh5NE96UWV2SnF1QkFvZktpUG9tOUtwNGVyUzhGaVFqeGI1QjVIMDlCeVV3?=
 =?utf-8?B?MkZoMmZrTUVwMFVaR2RrcDhWdm1wVnorQkg4S0ZCSG1IcHA4WGVlbzZvUG1R?=
 =?utf-8?B?RDJlUDRPa3R2dW5hUWJjZmpVRjZ2QkZnVlJ0NWR2L253OUVHMHBrcGJKRnox?=
 =?utf-8?B?LzlRQnFvMUV3Q1laY1c0dW5VMzZORUhTL2c5blBuWlEyL0lYKytNZ285cjJ1?=
 =?utf-8?B?RUlVY21CTGxFZDBiVFVDcXB0b0gzMmpzRXdsT3pFSzhvWmVLNit1eVY3MWRJ?=
 =?utf-8?B?d1RNeGY5L2JMTkh0WWhtR2RxTnRoTG8yOU84bkxQK1dJV3NqNS9lYklidEpJ?=
 =?utf-8?B?U1dCRFdlRGRjYUNveEQ4MkZPVFpMeWlNSUEyZnp6R002SnFoRHJwNk90d2VG?=
 =?utf-8?B?VFN0bjJPTDRpaHRVT0EyOTVRMms0TDdObSt2UnlXV0doeG9QMzgrMkdVTFVO?=
 =?utf-8?B?RWJ0czQ0eTc1S25hbFJXNTRPZVcwYjgwMVJBOHIzUkN3M2RKd1VsZnNqUFdT?=
 =?utf-8?B?MkhrdFQ3TGl5WTNmTUs1NnVzZU9JL0FtZXlCZXFueU1xN2lwams3bnEvbENZ?=
 =?utf-8?B?ZER4Y25zRGNUV3FiTVQwOEhvYnE2a3dVQzhEY0NCQmtVNDljT05ZS1RLcE9H?=
 =?utf-8?B?bU5zWlNWSmFHdHo4aGJsMVk4Z1RHdXpxRjE1bzk0aWlhZjZQbUx6U0QxS2RW?=
 =?utf-8?B?dnZKcjE2L1BOTGduZm92V1RvekxtRlExUWJOV3dKOG1rOWJ2QUM3azB2T1dY?=
 =?utf-8?B?QzBvSDJXVmtuOFdtRDZOMExFaHJSMWRxUXAyNk1QQlRLNEExMVdDWjNEMzRZ?=
 =?utf-8?B?VnNKYnJGajgwNFg0NDRpTzg2K3YrTCttTVVmcllTNkJIbVlhU2NDUXVRUXhS?=
 =?utf-8?B?WDRtZWRZdVl0Mk5DWWZ0Ym5vQVRIZlM1SVpMZkdKWTM3ZUpwQ3FqWnpFcHVQ?=
 =?utf-8?B?ZlVzWThqajJwUnk3T1FMVmU2bnM3OGdnUnl1WlY0VGExMmRMWG5MYXloa3dH?=
 =?utf-8?B?aTR0OXpkYVJFY2ZyZ1U1M28xNjZLaWluV0JiZmxJZmlvM3IzWjRuMUZCS3pJ?=
 =?utf-8?B?QUh1U0hQWlVDcTljcHdBOEdYZEJEMmNSUmthL1NJaG91aUtiUnZwT1AxdmZG?=
 =?utf-8?B?R1lJMmZIZE1VSkNBbkk1R1Q0djdQYjZlcTR6bjNFclRHeTFYUTlIbHFGeVRJ?=
 =?utf-8?B?RjZzdHFvdHhpZ3Bnc28rYzVhKzVwYjg1TjBZZG5GNUxqMW55emo4Q2Rxek5X?=
 =?utf-8?B?d2pBcGplaVd6ODdWN253ZFBvZWtja0NKSFdFT0phVXpKY2Vlc3FyencvTG9p?=
 =?utf-8?B?NTVXVTRPVUloUEdsQnNiWmY4a2lhd1hOeC9aZkNZK1JTRjZBQVpPVHpZbEJ5?=
 =?utf-8?B?M0hKd3RnVHJNcmxJVGVnYVQ3eXNFZ3FraG5Zd2htSFVRNFZKNGVUdWVhM21K?=
 =?utf-8?B?WFJzdzIxblRoeWVvdUQ4Vm5MQUNibzFKTzNhWkhPd2cvdEkzaStnSmU0OGMv?=
 =?utf-8?B?cDhkN2NKZ2dFZk51ZXR1TFJNMFM1QnJXajNJdFp6NkYrZkNkVVBtSm10SGJ2?=
 =?utf-8?B?RCtrZkd1NEd4alpNd1FSZ21GN0JRY2lydHBrd1EzbEdGcUNRMEQ1ZFJXR0Jv?=
 =?utf-8?B?em1KTUZYUGl5U3V2b2F6VjBXRXluSjQxVExiQ0haWGRLd0VMOHJEWmVKVDZH?=
 =?utf-8?B?Vko2M1JVVWxXRVVmYjdEdldUbXF1SWZVS1dCcXNSSTJvS0R0RGFhVnRmNStU?=
 =?utf-8?B?YTc0TXN3bWtpYzRzYis2WktSN29yUy9ad1Zyd2VtbkhsbFE2WjNCNTBseDFL?=
 =?utf-8?B?TS9PYnJidStpRUdhQ2FkNHdGak1lV0VuOEF3NFFTNXJMM2FsVlVwd0dZU1Br?=
 =?utf-8?B?K0s4NDJvZzlLZEJIM0VaZUx2a3M3QXN3aHpZaHkyc21QOUZDR0c2Y0RFVHFZ?=
 =?utf-8?B?eDh5V28xQk11ZGZHVEU0bDZVWjY2cHBoK3BvUnhRVlV5YTFwckpLSFlObURj?=
 =?utf-8?B?MCt0NlVSWnVEMVdqQkEybVJBbW04YStDcUpZelU4REgyUEtRSllaSTd4WUhx?=
 =?utf-8?B?ZlVQL3hab1VwQ1Zrc0RsWlVkVGs1TTRiRk44dzJXd1BWU0FhT1dVaHhMM0Fz?=
 =?utf-8?Q?X3xKbTjOpg7GrLvAv0mOCmTySeJaJQC+PzZ14yRsh1ldv?=
X-MS-Exchange-AntiSpam-MessageData-1: CeR9tGqzs+ql9g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b3f7a9-a192-4144-f037-08deb4f39a6b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:39:09.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfIDb0C8n2YLAEaSGFC8u7gzv6H4DfmyZS/FvNA9uCIbmQtEsQPukEs040U8+j1qOvbcCdVOGQY9vDTonJ5C6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9823
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8974-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 5E2795704F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

