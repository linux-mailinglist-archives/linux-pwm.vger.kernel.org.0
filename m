Return-Path: <linux-pwm+bounces-9156-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLoUFfYDFWoOSQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9156-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 04:22:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0565CFDA8
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 04:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4495830059A6
	for <lists+linux-pwm@lfdr.de>; Tue, 26 May 2026 02:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E1F2FF67A;
	Tue, 26 May 2026 02:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j5tyEtzk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359B279DC8;
	Tue, 26 May 2026 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762163; cv=fail; b=N/sM99cGOhwaPL42Kze9AMdt+He24saXvqvVLwcXRsWXHzPPGw8CVZwCyWr9VxFAjeZAPCC+dFnYqKuT9w7VwuSzSpjOK5EShC5DfrbxuG8X2vjnIjKOq+pTaGOWbJEuq3AQPqBHuPbWjt9PX7C/pP4AwdzYxOAeYBNw38JmjyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762163; c=relaxed/simple;
	bh=4ghDl9ZywN3Dy45Xmzhgfx7PG/4ruaQql6S82YbhbSc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ZxeaxSQ/O0grcrFYfKXzn7P2iyl3ZXSz+3NACC2i9N/+nJjJXFige4RHPnjQj4tggS6CpkwEfikNV9YiQ34UZKClsbilKszhk1Wb6tCMMDZCJkdCjsnbbyFqOFfmg8XOTaZz8MFNS1PWKwZOKMAWHGvo/iu/GFRDGhgnadmBmT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j5tyEtzk; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHWCnzUKvIbLGeWKUmjrqjKTC4T1a+7eg8hRBsgsznZEanqiHZd+CTHsDB1yZZPPqGWQ9/ndepY6WZ3nwWbnzmUnA3tRMUMzNrCVEznMtWTQQUx8y4oXK7ob5WcP5HXThUEH8eIdKsWhVAFnDwKou/OBjsCaHtZKhBreDN0uDhXGg40LEh3wk85K4eQdl2GrN2eVFPZDkrRwDcHFr6n06pTOaCf/sBMbn3SwKb5Vz1VLefO8nNFDm+i7E0PTtRC3e4rJB9ckaXJR8i7iuaXVK+V7Dwtfkjtg+f3GuWtwDV6Fx4W4IQGWFi5HMLOp2a8uo409AdHZa7rkFSfmr3TvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ghDl9ZywN3Dy45Xmzhgfx7PG/4ruaQql6S82YbhbSc=;
 b=l9pS5c6wxLYWpNyley9qRo2Fnh8cej6bomcQ699e37zwRvHY5OfNt5Tnd+qe1aFkHoJE6JwRD8wSYtTPPTtOIn4oSFBFxmubI2c5IgoFaBWN/HL315E0RwMui1IezKSzuxAgwwSK4NJi30Qvod9JV4Nbb9c52hezleZvYcxc11Fevth8XoAzKbZBY1Sxn50w0qenTxb0TpSudQWm3A9MbknPzjX2loTLzWPxq4UkDKVRDwsuS/xusAjy7k0u3eJrKXWbWX8+P1JJlHa30ACchtsCjdmJVOjGLp7FqzcXur7NaG70VHjqhXo1hH1jY0qAAKCaX+y7NIeRSgsN56dtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ghDl9ZywN3Dy45Xmzhgfx7PG/4ruaQql6S82YbhbSc=;
 b=j5tyEtzkBcVk07he1BEQCvdIbDT/0iwKyDijXXZQtVMMPPXeyEi1nNpqcrod9HlkFqbmiUMOeRKvkqPSP5PIKulM7ybaQZYsh96UUXagl9UnEjlE4vQRa+z9C0wE2Ra7at1W5jFdBdz4fcr0mKI5/eertLQ4pXH3FzfryAP+ou1MnUDQsRCHaePbjAlJf5D2CN+mutSIZSqsszEzz6gI4OMAjXdsNQGCi4yjC7clpmrrRYsMbB9vV3g5Ew6KVAZia5+q7Jg1wUaduA0sxNgsAKUnCpZxkXj0YK/bKY8G/sDI91JzXA5Oiu7HFjBg7+oSfo0U/PPQJVdaqjoqNvDgUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:22:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 02:22:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 11:22:23 +0900
Message-Id: <DIS90XGZW4PR.221FUGCBU7L3B@nvidia.com>
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 01/24] rust: pci: use 'static lifetime for PCI BAR
 resource names
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-2-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-2-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 9abd103b-4306-4b0c-f714-08debacda0fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|4143699003|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	u9NIl+IaFzha89w6TAbesnkN61Y3Kyvyu6HnFlnF93tk8VJKFc9FUuynbdiCqnr0SiHXX91MRY/HCuP67xooabxZv07bs1VqijgPm99y8LmaT8AZ/7OxTpJhDeOFbWdU4vJbqyGM//rD0EZsjTTKkFkeTrwXtTWmLlewayXhvOyCLxnQCHgP85Nq6D5rTwsHX7jcUc5+eGsUdlBkX0+zDFiKHR13v5TIJnzS0kIsN9ZEG02IdtJyGVsRzTQpGUy9NccPSOCJKaZ/mRx3/pxMtBPE38rLvSlHqLS90CPVvtmtaNGIsvdI1S/ihKLH9jMLqY6XYHyuL10i1rC7WCcv05KwmMXGDGPQgUWtPWCwwSVymZH+0L7ib1x8+SvEoYGzQUhyAin0duGTcraoa4u/HPiEsUdzYiGA+EKdxcVQFrupEMbG6zUevxQvuMGOHy93L2ZT27X7S7ZzPI+ZU4EDD3SNHK4gMwSNAQK7Iu54OOZc5mR0f7hdOaXfsuxUTIMw44LbFWAuVZ5D1+mGiu2OFyJ+TDZn4epf8tMr5LarmHbvbyaISD2L2tyvfDuHrqtdFMXQGVJi2XpqI6//FaVdzye/dsJ0p+WuV+7tpJRSxQalJ83xmMSNGGGsbh41gqEj1zWwrwxOcJ+sxmjLicwtLAnj3jJC5ZFPO1v2OItcdVy75toXP372Y6P69P6FNfLbQBOd+69bauNvqbrhKW2RxQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(4143699003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1JjWUt5aHV2MHBzMlFCcXJVYnVBMHBNY25Ga0hCMHY5aVRkRnU2UndnVjJE?=
 =?utf-8?B?SmRqeGhxL1p6WEZqcExHVVFWSVBLc01ySFh1U3pGWmgzNXczYlZxd3gxcjRL?=
 =?utf-8?B?WnBqa3hDcVVoT29yOTVjNk45dDJyMG5lTjVUQmNOa0lBY29tMEJiNXl3d2tC?=
 =?utf-8?B?QWFuZkN1S0ptUW53Zi9YUnQxRlRwNDFGWW5RZzdDbWQ0UGNNZnBsTGFqQ0Yx?=
 =?utf-8?B?UE43NkV0bFB0K2hjalZsMzlXYlBZTUg0UzN2TmkzbDNTMEFjclhPZHcyNGsx?=
 =?utf-8?B?bzlXSDFEOUhzRVJDYWE5M1FiZGcwM0dJMUdnQ1pWWS82dmZwd1N5eitZMnpJ?=
 =?utf-8?B?c0I2Z1IyZ2dObE54YTA3eEZndXdTNGVEMGEwZVVGU2tpc2hzT1MwSGNwYVpP?=
 =?utf-8?B?aU1Jc29aeGVhR3g4dWJPU0F6bmU0VE5ZUFFvYzJBRVdyV0M2TEE3aHAwZHlE?=
 =?utf-8?B?SEc4MjRZVTBMajJ5enhsbjE5dHFJa3lyUWJuZzhuK2JrMHlnRFF4aFdpblF4?=
 =?utf-8?B?OWdSdFBONkRUOGVWSUt5K2pkQ0h6VTRhN0Y0UVpnZTVsNm82UnB4S0RXQXFY?=
 =?utf-8?B?Rk8zKzIvc01QRC9ZZDl5YWFNWno2dnl6alFsSkVQR2xURjRzY1c0V0oyclM5?=
 =?utf-8?B?bnVDb0U1SEM5Nkx4VHFsU0ExbTErVGl5U3BobmdKRjdYSEQxY2dGajFzQ3la?=
 =?utf-8?B?aDBjSWY0UFhCa1ZGL3dINDdaak9zWVBsRTFFbUhVVElkVm1HdWorNVhLZmZX?=
 =?utf-8?B?akY3UEN4U2Q5eHRrVjhMYlRubVdvS3RiUFJtNC9EcUhlanZhcUR1Z0l6TDAw?=
 =?utf-8?B?NlVESURWUmJydjJPZ1djYTlCcTBib2xMNDk1YWthVlRUWnd2K1IyalNiQzZB?=
 =?utf-8?B?US93ZkdBYnRMemdpaGc4V0NBdkp1OWM5Tlhab2pNeXJZVkhHVVQwbmJKK3pM?=
 =?utf-8?B?SEE3TXJLdG9pa09JNVR2RVcwUmJsL3NVWTFKUHFITjJnQ1B1S2gyUVRRVE8z?=
 =?utf-8?B?VmFOSHNkV2crM05rODZ0M0tQZVFyeDBSUHZ3QUxURVdIcUtBWFphSFoyUFdi?=
 =?utf-8?B?MWZ2cTEyUmZ2aGFtbEEwditQWUpkaG9VM0R5Sk9UODE1QytTT2ZHYXA2dUdp?=
 =?utf-8?B?UjJxbWN6U1pEYW13MjJZSm0wN1lpMStGdnpaek5mTTl4ek1HOGlHVm1YOHJB?=
 =?utf-8?B?dzl6anArNXdKcFlaWjFKR01yVEVaRFc4anNsTDhBa1Rlc0JibEloQkZWQTJn?=
 =?utf-8?B?Qk83cjBNU3Y0V3JmSHJ3WW12V2pWemF6SmkxcmJNZGRaTjlFd2hjZWIvb1dT?=
 =?utf-8?B?ekZGSWF2QmFmaU9TcmhJUHRYUmc3OE1iNnVINHBkbjAyWkJGWDhrVm1oTU5O?=
 =?utf-8?B?U0lPSVdDM0czYjQyQVRJY0RnVmFWWWc4M0RLbmMyWHk0S0hQdUsxdjlvaHJE?=
 =?utf-8?B?cFBaQzNKdlVSTlBBUi9DQy9BbGdCdnpkL1dvdlloSldaV3lLQXQxcDc2Tjd3?=
 =?utf-8?B?WlNYS3k2V3Q1SVllQTZvVjVqNFpYUEp2UFRXK2c2cFdmWmVOU3dYMWVwRTZI?=
 =?utf-8?B?aFNORlBPZGt4NzdadVRBcU0xaFExWVdTbEI3THRPOGlqb3NFeWUwSUJNVHRP?=
 =?utf-8?B?Mm5CWThLRkRHMXl5M2RCLzcxWmM1SG4wQVo2V3YxTjhqMGRyRlErQjlVdDJa?=
 =?utf-8?B?R3c2WStUMUhrTG5LaFF0VCtPdWNRbUdrUE9COUkvRS91dmdhdGFRM0hPVGI4?=
 =?utf-8?B?THllMUdwMWRiMjJrS3QyOU15OW1lYjI0YWMvWUdiKzV5Wnl5WFVXbmpXY3RM?=
 =?utf-8?B?aGpDaW5wY3kvNGptb0JvZVc4Uy9IVm1OdFl2WENNZTFheHVNU0prYkYyalQ2?=
 =?utf-8?B?SmRNU2JocDkvdWNDWnYxMUFnNUdWYi8yYlRXYXNWVUppTmU4ZHcyQWJyYU9X?=
 =?utf-8?B?N3hEa3k0N1FTR3VsWFg1Z3N4RnNjUk10UjUvYnNTanlxMHZVcjFXcDFRM0M4?=
 =?utf-8?B?Z2swY1FOTFAvNllHUFdTZlV5bENLT3lzeWljUVQrbXk2QTRPYndZd1VSL0NB?=
 =?utf-8?B?YWJwL0lmZkVuOHZ0amhtSldiQnk0Tm9WbHFUWDFJSXhiWkF1UVE2c3d1NWNX?=
 =?utf-8?B?enkwYWF1WTU2UnVzbVZ3TkV5VTI1OHZ1Q2MyQktJdHk2S0JXOHhOWHh5QzQ3?=
 =?utf-8?B?WndQOURUMEF6dDQ3bjFYZ2IxUnE2SS9LSnVtUG9vT1JLa0FBcTJybmtpWE1V?=
 =?utf-8?B?b3dNcDRGbWs3c2s0S0FRbnp4RmpLRXh1NG9TcVRLd1FIQ0NnOTVZN0p6dG5I?=
 =?utf-8?B?UXIrTHM2R3RWUnVDZWlXU2xJM0ZBV0QveS9SZVdXYmRPa1I5S0NzNlRiaWti?=
 =?utf-8?Q?YgRBpXMr+oO6EWBDuFt9t50XpP5GPvM9w5y/dqyRjwJaI?=
X-MS-Exchange-AntiSpam-MessageData-1: j+paPwrHA5eEkA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abd103b-4306-4b0c-f714-08debacda0fb
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:22:26.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xt8hujyubJ0g1YVzjgaUU+Hs+GyvupZdzyZg6ZkaqKivlnKWZQ9VKwBsfj9229ZbSsxKIxpSsfYWyALhIo51CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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
	RCPT_COUNT_TWELVE(0.00)[35];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9156-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: EA0565CFDA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 26, 2026 at 5:20 AM JST, Danilo Krummrich wrote:
> pci_request_region() stores the name pointer directly in struct
> resource; use &'static CStr to ensure the pointer remains valid even if
> the Bar is leaked.
>
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260522004943.CDA7C1F000E9@smtp.kern=
el.org/
> Fixes: 3c2e31d717ac ("rust: pci: move I/O infrastructure to separate file=
")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

