Return-Path: <linux-pwm+bounces-9096-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBbbKcnQE2oOGQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9096-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:32:09 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D115C5AE9
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5883D300A397
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 04:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392330E0C0;
	Mon, 25 May 2026 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EoMU4QJg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012022.outbound.protection.outlook.com [40.107.200.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D72C2374;
	Mon, 25 May 2026 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779683524; cv=fail; b=S0xBOUsJ+RQoIp5Q+vvuhn+4adT2OI7jdu0KjXDiaIW9RNhzIJCaJE5jnwDsvGskHMjV3hLResqUwInRG70IxWu/8P58j370TUWLsg22y9nXWwX5zFspJgdtrW38CyK/vXvWypyuBDdhMBEAPuqgwE4oKiuLVsXvVWgREufS8FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779683524; c=relaxed/simple;
	bh=LHqHspvOet2FXYirx8GrFQXRThyollXJF2T+hiyhcTM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jropOZKD/2QHvqgNTN+SRfCxr3HoT1m5DZVqGywB58VMrrdHfqLs6/DQmIb6WL40rfRZ8CEMsPh0J3EnZu8AmqoWF8u79Bg3uHi605/joq5LfhYsmDoKzlg9FY2oPDCyOXTHmrPDbQMb9qKPZylj5GpgEYBwuSx3gjwrdcET7mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EoMU4QJg; arc=fail smtp.client-ip=40.107.200.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvimfsWcApfYxm53zCe7EZEwAYtDv/6CJxvi57UkOPSWmYgHrLoDJ5m7Cc1IPv8OPxm006d9aHp6OzZfl0xv6EW4Tte3TJprA1Tk2CNrn9I8MrP1kW5h9Nt0IBCwkSWP+iOfCwXdDou6ebZ94vi3F78ZAq+eJUSZ9VpvH0TxxnscZL3f+rbK05h28H9+2FCKtDdZw+BS9itowzstS1dkmEB302YH1NtUKSLJA1C4kKFpBmh1WuuaqjgJZQ1iCi2Ez6PXZn6C9jwn1IlqpFUCaBTRCy333EtbJXzKUEeDTp5Zsi20H9iqwC2oCaogYK0ANs4mB3fUsZJk+2rie+HDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb+AMeqE1ptnashPqu0aIN5EMrkFKz3bdpMv6TunXaY=;
 b=f4DTLIjkpph1D/K9sOgFtAXzod3z4tle+C3xd0KNZPeIZfG+q4xMMFueETMVXdISFGYPjWuEtnzuhaKmo/WAofmo89jVt4SFktBxQH449Ulf03r3uaWu3pmClmAI14cvgNukqqIspaRvNV48Cm/AxqKQnCRdDoPaQgP3C0d5QDlq63Itq4tzV9HnloRrYeJ0HDdB0S5fZP3QFg59DPkyzh+KD/7If1JBCa9b84W9FsetlCtqI972CU+IMDj3g6RvV0q3Bn9dcFb6tywZVFjSr5mDLH5eT1DxMoUdrBIp/MB0gt/RT7mUeocux92rc+Gk4AdBQmvta+qoj0v5fWpd1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb+AMeqE1ptnashPqu0aIN5EMrkFKz3bdpMv6TunXaY=;
 b=EoMU4QJgcFK4jI5wHAHHZ8QHUYApsN22hvsy6YZMXKYaoHQqzFXQSpZAomReCsvtOpMlQ5gRg+YgywuxbDCyv6J32AjBRoazXIWOwYHQMpufMlQjftbBrQGncM0zWA0eXSr0Eno+A8YvzZS3a/yAmeKmZlE9M0jsTDhi4PR6yJe3+i+71c+I43VHrlFoNF0Qm+tIn9KbJA9dHYvar6SeT8mRHxeapWaRBEtq8AZ3pP7NDeXlSuqmHvxrfzVQ1FQ8I0ZMCgr9mL3OpIbFJatFknVIz8/ii5XRrclVM5PARRy63uxmRcAF5vZSiQmguRApEx92tjbFC/wHm/qq3tpZBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:31:58 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:31:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 13:31:35 +0900
Message-Id: <DIRH5AW9YRKI.1GHVF5PZN7ZUA@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 14/27] rust: usb: make Driver trait
 lifetime-parameterized
From: "Eliot Courtney" <ecourtney@nvidia.com>
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
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-15-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-15-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::7) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: 09829ec0-c2d7-466a-da34-08deba168378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|921020|4143699003|56012099003|22082099003|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pDkGUKiXwqvcU4wD9UItiwNCDQ+oo1DywK3xz/wGmzi0Le9OiUsfQ38P5iBDGQDaGIFLJaDBNrEiwPqP580/lbK13SBPk71XzWHumWm4LF/xbRj1b8B4EjSkWM1M6hQJDp8TOdsu0iP8E8ZCNd/XHn5tCoZ/2HOuQOXQm0I45eSfMcvuGFPD9Vsh9c6S/QAWp9gdD1Uf6U8cuyMEdwpovt708iYOQjlq1IoZixuw06xqgFAlAv6Uf2BNW6Tt+nKSSxCOiowP+6GsBbes/+6F8CIQybe499ozH2+czQlYaTPJwzPjZuAEiW+7rqk3MwEVbfiZjgh1RnFbfwaEWYeVeKvRwqFNxnW+C2p8yaEPbjkMBVX2iwHnOdRyoKn4sIJ6BmlCt07HRTXhCeBkiyLARULd7q1HJd9cjMEyUZ8LBPPOjQYmUH3r0dJxz+Iid2QcS8TB3QGqABa1t9EMavBANS/7XJ1Zi5/fGvRnfZNqxB50EYOqG+WSkD+3jD19FYs3vIhr9IL4DbCEC/RA/oWTyNUJfj59LF9bVd8IZucMmLSsFM/NURpXAaFEM91AcXtZsOUaK6AMGOkS1HXTRSmEnjF+qZnJHskO2VKF2x4XIfp8tZUQDkVYPs7S7vTZ0lyOYOrCQoZyl3qA3VpkgBSgEt72RwVUC0mijfqxNRzLqKBKez1t3IrT0NSw62nByDPIvcwg4gJyeG1cRe8nF+QgU22RR1uBFZ7BojDvQxsRbes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(4143699003)(56012099003)(22082099003)(6133799003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFJOOTVJSkk4RnJVRzNHdkpocnRzdkUyandZakFZN0sxMlpCNW8xaXQyWEdm?=
 =?utf-8?B?NVFWSzdoUTlGeUhXOWdMQWN4MzdCeTBGYjVhNGNpTG8vZkpvL01UVU41YlRk?=
 =?utf-8?B?YWxtRThYMUFPQ3pXRFU4TGxmUkdmRGs5VVhkdnVCcTk0cjhWcDFSbUczRE5v?=
 =?utf-8?B?MEN6TkJDc0gvb1lkWmczemkxbWtTS0ttdFUzZTJQcmQrQ2crU1RrYWN1aGUr?=
 =?utf-8?B?ZjBVdXE3czFVVjZHM2FCdnZrTHFjalRDUTJTaXF3OWNGbjh3U0dhWFdkeG9r?=
 =?utf-8?B?Y1ZLQzVzcVlCcVp1cmU4T00xSjJpNEhGUUZTOE9xb0k2R3ppeHNiZDEzM0Nn?=
 =?utf-8?B?aWlrbnE4cXdTU3RhZm1kU0RmWXhlcStYUm8rQzBXMFNUa1d4SWZzNm9HT2Q0?=
 =?utf-8?B?ZzdOVjBadG9BcUkrc0lDN1o5OFpJOVNOMU80aEdCcXcwSGREK24vdGJ3ZUxF?=
 =?utf-8?B?QUk3RzRNYTVIOXl4Y1dDQldJdElkamI2RjhGc1pvUHN4U2NHRlo3d2NpWEtt?=
 =?utf-8?B?Mk9LNEJXYXVJdXJJU0FWS0hReXlBZm5laFRpVjU4TE9yaEF6V2dNR2pDRlRK?=
 =?utf-8?B?YU5SNXdQQ2dtSnpIcGtXSlVia3hlUkc3VGsvUnFING5QLzR6SlowVVppTkFp?=
 =?utf-8?B?Z0tIbGFPRmJNN3N3S1BWdDlWa0VQaldUR3VoUCt5R05OSWxJSEx5WEkwZU1W?=
 =?utf-8?B?SUVqd0NnbFJBNm5PcG1ua0dzMVFnTlBQbDhqK1N3TVpRYmxqUUlmc1F2bGkz?=
 =?utf-8?B?dW00NFhVMFBZbURkYzBGZzlqQjEybTJaakNTMGt0YlEzRzJZd0lEUzRsM1lO?=
 =?utf-8?B?K1h2RVBaS2x6bnViRlR0TlgzVXlqQ0lGTmt3OUtXMC9kU0c1V1dvZnI1TjBq?=
 =?utf-8?B?ZFUzajB4MEZPQ2Y5Q251Wmx3SnZOZ3c4cmNpdVYxbzUxNnlnemVMb2hjaDQr?=
 =?utf-8?B?ZlExc1dwMzZUWC9FU1lKSDJGanpPZE5OVGhFQVV3Z2pNRkUwY01MRTdXWnlo?=
 =?utf-8?B?RCtiWnNSS3lPU0NIMVNIY2hjaGRQVlZGTkI1NjhBSHEzcVFuczUxZ2x3QUY0?=
 =?utf-8?B?aFBabmV6dlk0SXlZZFEzR25HeDM5NDBHS2dzbTVmMWxrKzBMMFl0ZXc5NURR?=
 =?utf-8?B?NVFocHhBam8vZENDd2lZMTNzeWFoN1JRcHc1K1RxL3lSY1dCcnUxKzhxNnpy?=
 =?utf-8?B?bzlIVGhiVDg2ZWJyTXNxWUR3aERWMXM2REIvMnBVWS9ORXZvZVdHL2dwbHdy?=
 =?utf-8?B?R0ZmNnpFRklLb1h6NUd5ZUUzekwrTGZBZ1d2UWlHMk5lTGpQWXdTRXFXQitq?=
 =?utf-8?B?YzhYMWRpcENRMC9La1hLeGxVOXI2YjlPNm1WTTAwUW1Cd1ZWd3oyMDh4dUJD?=
 =?utf-8?B?QUppK1NDaWpDRm0rSmJCRWlOOTBVTk5Kbm9ZSTVZamp4N0UraFpXS2FsYk5k?=
 =?utf-8?B?SHpnZGhpTnBEdkNSQlYxYTkwQUw0VGR4MHlrQUdyV0dFRm9KS20vK2Jod2hR?=
 =?utf-8?B?QWZZRUxINVZBbHRqd1NOcDZRYjhFSXE4WXJqZlFhUGlKSjFEcjU2VFhZWDRh?=
 =?utf-8?B?eXRTM1UxZlpnUTVwYU9BWEd0Snp4TmRNbGhhN1l0NXVaUlhKa05na3M2Mlkv?=
 =?utf-8?B?Y25zb0Z5WVhNbEFFZ0kvZWZ4UWJHNjNzWWxtZzNrN0RqdGFybDBYdU9MYk4w?=
 =?utf-8?B?Yy80OVdkWDk3cVZROVhYbk5abXRINmJmc2VKRUVtUC83WEF3T3llOHBjcDh1?=
 =?utf-8?B?ajB3SVgrSGVkY0wrQkdDOHZXalNOekhrYVFuRzRkdGQ1V2svZjk1Snp3aXly?=
 =?utf-8?B?ZUNOUmw0N0dFNG1MWDJNY3VLd2xQcklBN1VzRHA1dFNyYVp2MVBMamNxV3pr?=
 =?utf-8?B?elZxNmFMcjRaSkxQZDdJQlJuWlV6aGJ1YXNVUEpJeDkrZXVVSXJDS0VFTEt2?=
 =?utf-8?B?ZDRERXJGOFhNd212M0UycVl2WGdCVDBJaHljbzhuRDBQWER4VExXaWFZN3VP?=
 =?utf-8?B?blkwT3l3bThYRVpGaHJUUHk0cVd5Z014RHRadHBFNDMvbkRHbm9GRHlQN3Qw?=
 =?utf-8?B?Q2F0bERuaXF5aTQydFErMkgxZjhCVjRPY0dXMC9lcXphaW91ak85U2lSb3h4?=
 =?utf-8?B?Y1hVYm03Wld2dUloYndTRnR5UDVHU3FhYmNUY1RiOUVDU0RCT2Fhc21vamFy?=
 =?utf-8?B?eFFuWGVmUk1ud1Mvc3RsOWhTVmFRa0tVU0E5TEYyQUcvelc3UjhaZHZtVVd5?=
 =?utf-8?B?ZjBCS3Aya1RvZnFxekhFcEowcXR6TEtsa2Y3cVR1dGdKekpFclFpYnAvcWZ0?=
 =?utf-8?B?UkhQMVpIY1l4bExRYXJzelJocGRwalZFckxPV1N2amlOQWdCaDVDTkpWaTlR?=
 =?utf-8?Q?yUWbUrCcrsnE5V5HNSgdyeyAVA4DJZIfQXnVoMjhiILA+?=
X-MS-Exchange-AntiSpam-MessageData-1: EJ+hY7PNS1l9ZA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09829ec0-c2d7-466a-da34-08deba168378
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 04:31:39.4245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2/gnm1sXOCieyLagr7mKP47c48Y3AjRe3sA9zAY9R58meBbn1B9gP5hZvjO9NLHDi3ZmSyNBS/cSJxwJuJVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9096-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 28D115C5AE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
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
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/usb.rs              | 39 +++++++++++++++++++--------------
>  samples/rust/rust_driver_usb.rs | 14 ++++++------
>  2 files changed, 30 insertions(+), 23 deletions(-)
>
> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 1dbb8387b463..616e22e34c6f 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -41,7 +41,7 @@
>  // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `=
struct device_driver`.
>  unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
>      type DriverType =3D bindings::usb_driver;
> -    type DriverData<'bound> =3D T::Data;
> +    type DriverData<'bound> =3D T::Data<'bound>;
>      const DEVICE_DRIVER_OFFSET: usize =3D core::mem::offset_of!(Self::Dr=
iverType, driver);
>  }
> =20
> @@ -110,7 +110,7 @@ extern "C" fn disconnect_callback(intf: *mut bindings=
::usb_interface) {
>          // SAFETY: `disconnect_callback` is only ever called after a suc=
cessful call to
>          // `probe_callback`, hence it's guaranteed that `Device::set_drv=
data()` has been called
>          // and stored a `Pin<KBox<T::Data>>`.
> -        let data =3D unsafe { dev.drvdata_borrow::<T::Data>() };
> +        let data =3D unsafe { dev.drvdata_borrow::<T::Data<'_>>() };
> =20
>          T::disconnect(intf, data);
>      }
> @@ -287,18 +287,22 @@ macro_rules! usb_device_table {
>  ///
>  /// impl usb::Driver for MyDriver {
>  ///     type IdInfo =3D ();
> -///     type Data =3D Self;
> +///     type Data<'bound> =3D Self;
>  ///     const ID_TABLE: usb::IdTable<Self::IdInfo> =3D &USB_TABLE;
>  ///
> -///     fn probe(
> -///         _interface: &usb::Interface<Core<'_>>,
> -///         _id: &usb::DeviceId,
> -///         _info: &Self::IdInfo,
> -///     ) -> impl PinInit<Self::Data, Error> {
> +///     fn probe<'bound>(
> +///         _interface: &'bound usb::Interface<Core<'_>>,
> +///         _id: &'bound usb::DeviceId,
> +///         _info: &'bound Self::IdInfo,
> +///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {

Are we sure that usb::DeviceId can have its lifetime extended to more
than the callback lifetime?

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

if it's guaranteed safe to extend the lifetime, or if not, with removing
the 'bound lifetime.

