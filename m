Return-Path: <linux-pwm+bounces-9122-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHGuGmFhFGqgMwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9122-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 16:49:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A4D5CBEAD
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 16:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D3C030054ED
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B293F2117;
	Mon, 25 May 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ByUOr0TP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BB382F14;
	Mon, 25 May 2026 14:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720541; cv=fail; b=QndfTA86TCRXM824ZtBWI50kzTJZYyaVqGVbJKDvKC0ABqWOejVU6L6gn25D7T6evaN7RI2rVnFPuMnV+Gn7Gu3UfdOJLQeleumCssqjeSKlnfoqjWFkO5NRcH24E/DvxRlSFRX1hv8zcKV4NRdxfDDRAQ8f+3oBLsc59mfLsDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720541; c=relaxed/simple;
	bh=NcaiTPuLca6mUwlM3j/eZKW13G2ttwV5lPdPzwOOHgk=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=TdjspUdxMQq5pvAmTd1i+kBbueVopeZXRxC34hIgDcx/3fyXTUq7a8YKNGdzVHXuXN1S2IX4BOS70y4K4J2pNIljJ64EqnxevisyODb5FBOSz3no00EeliISdAhxRqls+u07sLvyRO4/iCCohDlUDdD27+93P8unrI5MmkyDfas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ByUOr0TP; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3dKrQhEwOHbQYiIgJ+LLbxcvnV58zXFU5BeT/5ZBlVqbCyu/EADNcYoOyxMmp0RGg6HfDpHobSpLXhOHXCapOusc5s1esgLUevMVtd5grLjOGpOFMA9UWwPIIM2Wf6/xMpYvmPGrImVl8+AKGJZaMLsCWUea5PEoSyieoBi1fUEh1NOEo6mqJvADUVB+okHGS51029Va++AWSOPBMUJ78M6nHUuN57zJn1NQCHSBd08JXlccjd4JGOgja5zKuxyAC6CTYTKLBWTFzvNKFGMYmI5rPpy5EbvJnHcqq1LZ3+MaMlP707Xt3ArwC0YyuN8WTm5WnTTgkgG9R2umfdXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcaiTPuLca6mUwlM3j/eZKW13G2ttwV5lPdPzwOOHgk=;
 b=Qjkbd/f/Eh+CCoJwXYgckRTnXYfYY/rBA4wHNg+RzTxkw1say6koYo+ysjzjBwStHMUjRxJslWubY9oxZ/4+ZNr0IYqOIQbYFQ6CNbQjWvJXbZMwmSggSpu114xeXE/Ww5eOTEamqEMa73PmfVvYBQBMxELi8KE5e7hCxRH/M6zQueeBeLg7sLoKnTJNpbETpezb7osWyAtDpWnidYeC7pIp12DungykwhyPHXHRQsLyr4DkJ+uxae9nLC771ztC65YCHdkJ+eGQr2aOB/KztWPZ38GSEkn2EcmrFpPEFbN/lIRs9iv15VrHLq22mDM4c4F9AEzxFzFsyIjNDQDgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcaiTPuLca6mUwlM3j/eZKW13G2ttwV5lPdPzwOOHgk=;
 b=ByUOr0TPrvQQ0zvnx3Z3BRSNgktoWdAZZdr/Lui47TEL1zelUPJ6Jd3AZnIlCwSVjZ0rOVn6941NUhuPdK1yl/N0hBujfBpmEDZxOV7vpUJ1R4Pc22VrCq1u7rkvXhrET5g0X87RHbASbY0WgXQTeT7m7zQhV5bmrxxON9rNReu3o6HG2IK/zFT3NZQ7absS5bEa+Rw0mnT9HZyfUPZbAc1ciit0mOMzW0qXdfXcVkA5e0tU50BUIRcsG+cV7s870Zn3kTtunoMKbYkeSxdLOXmxAJzB+08OiWISIp8UgBSaeyYk3u2F3edxyL6B5Zkgg209KPuOxqmMEKpjJdGz5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB6133.namprd12.prod.outlook.com (2603:10b6:8:ae::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Mon, 25 May 2026 14:48:52 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 14:48:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 23:48:48 +0900
Message-Id: <DIRU9VTRQ859.JVUU1JZ3TCP5@nvidia.com>
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
Subject: Re: [PATCH v4 23/27] samples: rust: rust_driver_auxiliary: showcase
 lifetime-bound registration data
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-24-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-24-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0211.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: f90172d8-f19c-4079-447a-08deba6cbca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|4143699003|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0HCmdl/fHCz1FRXgntGjYEFl7uTBxcNvYQTgrb89OacqiMCor+uGPiylajUqI7DTULbPwWStR+ind1c99uinHxJ44uVeZg46PPI6U+jqsjn0IFOmUs13obYuYy9nC/VtLqGnrrysgeIaNF8ck0S5RpYmBLQRs1sl4LX6lxNGdHb7mTscveN1IMBmmPoNfVdTfD4X34uELX4yWtgTGnIhHuvXzwbz0alJxudjLQpZONs+C4NUiNijYmHqY0d11p+sfl57uiLKs/pVhWURFfrfvqqyNfBVA0YYX1XwY4Uf6IO/FaxvxFEFkBWJkIEKf4jT8Xg+0OTcf/aStzyv+L9uFxk6jT5H/mSAKNjdoVU/7Lb1qam5V8dO25ebk7Sr2060gMn4D7vcLTkMmxlKw0mQWhMVprO1XJ5KdAp7oJTFaHoDI7dC6ANRrhPW3K8UypdT1U7p5nmXCaddp3/lwVXKeVAP9+cCkT1iGIPkJCJkmCqHZuuzoP5luZ3aQ+h6mr8crE3GqHTJIp8vO+ctlopCuM8PBkYKEiXLuskyVwDH/9P/9BvRWl5Wr37ruOaEUvJy2aEH5UiT3Yf5Mv+tt4Ryk3ekZlAqyyOuATI2bw7SWFTGqFey9dxyZJUSDXKKLwcbUJtnwkonUN9l+vYyaE7JfdOr/AyEQkrSzJmWbrpW8b1b1IQZkvWOHTQcA5sJPWIE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWFLdEFpaWJMUzFzTzdLN0NzblY3dWpWNHpYb2RKNTNhWWJCbFZNVXQ5MTBJ?=
 =?utf-8?B?T0dGdmhHeVB3RGQ5RlJzZ1ZrcHp5NkdySFhQaVFyT0l5N2NvWUc4YTl2QlU1?=
 =?utf-8?B?ZC9TMExJeHBPcUVkelhDd1hMYW43SEFqdWl0Qy9CUitlUTU5ZlhmWHdWMEZK?=
 =?utf-8?B?akQ2c05iOFd4bVhPKzVCZll3dGcyZHEvb1NXZmhKQWRhbUE1MGU5eVluYVdp?=
 =?utf-8?B?bkNHSk40ZURpSDJSUFJNT0JYWm1xSjhjZ3NRYlo1YmN2V3BiSThPcVNyYmsw?=
 =?utf-8?B?bTJFZzNTQzFzSXA2bnhRTTRkNnIydDAzUWlCOVBwOFlyS2JTY3dWblBSWnNF?=
 =?utf-8?B?bXcveTV4NkhKWmJCcE9CUnJyckFmME1Xd1dHRXRKeXNjTkxVYkhHb2Q0WGoy?=
 =?utf-8?B?aWovTllxb0pnRWlQZGttTnpYMWtjUTlJQUIyU1k1N1ZvcitidU9HaHBRRk9W?=
 =?utf-8?B?QkYzZFZaK1gwQmZ5bis4KzBGOXMzS1RCaW5NbkRkSG1DZittK3B1VVBIL1dU?=
 =?utf-8?B?WFI3UGVTRENrMmdVMFdQdi9kSXg1SFQ2c2xaVC9oSGlxV0tMalV6eVFzaThQ?=
 =?utf-8?B?bGNGL0t4eUxvOHJGOXR2ZmYxMktsZlp5T0ttbkFEa1NMUnNxbjNvT2xCNnJC?=
 =?utf-8?B?aEhsSFpZZVY2bGl1OGErdVBrVXdKNUxINEJObUsvL0o2UlN5Z2p6R0xhV2RC?=
 =?utf-8?B?eDlDWm52MkxxVXJ5NE44cll0aTl1YnZqVmZ6OUZka1orZ1hQb1RFQ29SUWR5?=
 =?utf-8?B?aER0aW0xZzFOay9zNmlzdFdzdG5ObGtmTytNY3FJQzBER0JGYUZRTHRpcEx3?=
 =?utf-8?B?ekRBc2J0TFlNWjIrZlhwcXA3UVlRNkJLdjJPTWRodHFWUVdQMnNIUytTUUgw?=
 =?utf-8?B?YmdBUy9HNHdRVjFCazZ4QzRURnZvSUhvOVVzcHlQT28yUjRFcG1uSDcrMW43?=
 =?utf-8?B?OW0xTVIvNC9jU2NwcG8zK0hJZVkyUWNMdjNWUE5kTUpJOVQ0VyttTGN3Y29k?=
 =?utf-8?B?bWc0ZVI2MmJlQld5Nms3MTdBOGpkNXJmTzZ0Q3g1d1pCcjFLRWFTN0N5ZlFq?=
 =?utf-8?B?dUIvMHVucnZQanZqa0pWNEpNdGhTS2tyeUduNWxaOWs4eTQycXdlWXgxSFY5?=
 =?utf-8?B?U3ZpSE9ZQURIb2hwdVVSdStpQTQrdjlyZzZWdjBXU0RwNnJ4a3FXRUExanBT?=
 =?utf-8?B?SGd5SklHeGEybzdzTERxN29ZZU1zZGNlcGJKcTcxNFdyTlBReWw3NjJ4T1Vi?=
 =?utf-8?B?bWlwTXpNb2hMWW50SGhDNGxUVllGaEhtZldabWhGMlorR2lQL0pEWXdhdTRq?=
 =?utf-8?B?Y3Q3akEwYTNwOXBQL21Mb0VnTzdGZHpxZDNBaDI3T3E0VnVEU2IrWkphd0tD?=
 =?utf-8?B?WDM1amFwT01WMldLck8vZnh4bUlJWnZIcFA0SDM0VDJFUFpLcmVndWFSR0pp?=
 =?utf-8?B?c2NwcE4vdUhWdlptS3JMQ1pSbG1yUzFmUExHdzEyZWdmV2M2YklJSDRZMXFL?=
 =?utf-8?B?OERzKzgzRjR4Qjg3QThOd21aS2kxeVh6V1BQVEZqaUFCOFJ1NkdNRXZBSTEx?=
 =?utf-8?B?ZUhMK0M3N05xR3Vmc2xFVkxxZFJRVUxuNTQ0a2wxakZ0T20rTmxJako1cUFS?=
 =?utf-8?B?Sk8wZmxFb202MVdrYjFiUDUvK1hLV3kwdERwdFZPZTNWUTlRSTN6cWhLWGt3?=
 =?utf-8?B?Z2wyTGVJZkowSXNuYktGeHNveE9Ib3A2WVpBazQrZnpRSUNtcmI4UE5JS3ZV?=
 =?utf-8?B?U2JLQk85SzZnVUNDZUMvRWdWWjN0RmdLSHRyOFdRd3d6STFxTjJVM3dmS01y?=
 =?utf-8?B?UXhLbVZYK2J6aUkrR1dmWTNuenFpVU5tM04vMEF0bjFnTmRoU3M3bFBWTHFF?=
 =?utf-8?B?TFJGS21OMEtSZHY3RmVoM0RkSmI4c2x5QU9xdGlrdExpcTVaWForVWpVMFpn?=
 =?utf-8?B?ZmhuM29YcUxyK2hrRXpTTHZFYmUvc1VIaVRnMHlzbStIeWN3c3ZRNkx4ODhs?=
 =?utf-8?B?dXhJaGtTT20wcDBHaCt2Q09JRzhmMFFYMVZSOFhXWDlST3NnVS94RW4wNzVY?=
 =?utf-8?B?S3lieExCZVpML2VwZDRBMzhzS2lnR2w2c3dPeXNZVjNXTy9oTlRUTzZ4N1Rr?=
 =?utf-8?B?MUdUU3o4NDdSRXYrZkpXOXFMUGJLdVhjbExtMjZSKy9iYXdHQzZ3a3dFYXIx?=
 =?utf-8?B?TEdteWxDREpySU84YzB0UmJ6bkVOQ3JZdXFxdWt2d1ZYc1BPV1hsRHdGRk9M?=
 =?utf-8?B?dDAxd2FyUWFjRDlYTnI4RmhkSEpZNFd5MVlUZ0dJZ2FyWGlyN0FIa2xSL1ZV?=
 =?utf-8?B?Zm9wKzF6OGVXRThDQXhUbjN1T1kvVHJMbytpOUNQRVYzQytRUmoyL3hBVk14?=
 =?utf-8?Q?9FDiGUA5jAZslpqk0HuacrqhRfaeq6iZNwYO1gH67AvoZ?=
X-MS-Exchange-AntiSpam-MessageData-1: XsQ7uYkl5R2/sw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f90172d8-f19c-4079-447a-08deba6cbca4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:48:52.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg1PL4bbx/SVtDzA07+sWoDEr8fx3OT7lX9nHRut5FOGDK9ZmSjNzuN3eeYGKORP/Hay5lbYNBH7ufLddvQLeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6133
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9122-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,nvidia.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,garyguo.net:email]
X-Rspamd-Queue-Id: 09A4D5CBEAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Make the Data struct lifetime-parameterized, storing a reference to the
> parent pci::Device<Bound>. This demonstrates that registration data can
> hold device resources tied to the parent driver's lifetime.
>
> In connect(), retrieve the parent PCI device from the registration data
> rather than casting through adev.parent().
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

