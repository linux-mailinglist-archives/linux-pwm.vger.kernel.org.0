Return-Path: <linux-pwm+bounces-8037-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGLOGf37gWk7NQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8037-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 14:45:33 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C52DA159
	for <lists+linux-pwm@lfdr.de>; Tue, 03 Feb 2026 14:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44C97308EE93
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Feb 2026 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25839E6FA;
	Tue,  3 Feb 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="JTkWYpux"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022109.outbound.protection.outlook.com [52.101.96.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E5316190;
	Tue,  3 Feb 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126197; cv=fail; b=LOFzMQC0J/VhgcdMg/n5RxjjLvNbawxCdPmtmQwiQ9G1oZA/VkPASV9vAZYOWuh1KyUAjdBfvQwIkNgTUefiUEiqc39qRHCHkXAS37/xnY4/HtWpq7uiyQGI2DudWfJy8cBRhR8eVbDE+Ul8amt+mQ0WMiHg2/+2eCnCDSHCTn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126197; c=relaxed/simple;
	bh=PAcNFKpnzaFFiHjo5xxJcf8w+yXTZ+wXDuClEEB/TEY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=nUON7MkflBqOI3+W4bp3WZUMAk3cOSTjhFzS+Ov8ngy7Gnqfl8ain4G6hh3BVBXSj86YJdaYpy0tuz8Rj4OMzMHxdanLHHDSia8Xq4+kTv/a3RqOD7cBW33DJ9HjfIEtH4wzI0Xw9enLbAi1Ur4/bQaGxm6SkDSIlPc+XwlMzeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=JTkWYpux; arc=fail smtp.client-ip=52.101.96.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8poCbrAdGpdCxECOSffR4KUnny2CVw5NzmLqJWRMYzapjKWAG7lRc1Cbpc8EMFMWEf51SLBf/V8iRzXHRPS4ksHPDJ+rlxNJlHCtc3QEHcOs9ys+GoyN5uSyB9LiDp8yh8ixyhoECevj/bMXGL4KQjM8n+6NjloFE3zRUeMxlIVE+ioWy/lOo4pRcTC9cWoZYyvcfvQ1PBD7Z7WKQhoDChDHXgCACjPQIamOsDdaz+aLzhm2frM5LGZKkQyXqX+6ezPs3QlI4ZkU73grsrXPqRv2YV3hNaphhAc217gvl8VqtW+8ruhiE/Kf9ujJFsRHaWin+MJzk2R1rlVVCG+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktb4H7BQ3WXhZCXg2Dl0PdJVhKOKs/BJ+VRFL6mrv/E=;
 b=fh4QWPwSFO3tLtwIX556A1bEOZ9Eftefwoly4u3Er0W4ri1Y2OyGQfwVa0MmBBpmAtYAH3x3x/Qqk6rCK0F8eHZln0u1TbQ3DTsnJv/n6dtiiTrN5IXaZGw0pXjrYqCKerbxQJk5+1aqDrxf6NQVSSPG5OggaOxN9YP0zGeqDL/hTNXoib6R5n3lorXDTIfBsyQzb4mW+1LKABZcRhXGXHXEC6sqsSyiv1aoaI1ACzjoKteg3MarZmqBr9pEFr57FRiBkWSSl6TgCeBcQ9DgQhPzvsf+1USRl6Kv34D+/xZfeHGKKu+w0Q9+LXcAGgQaas2lr5u4QC6qyWKnmJ08CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktb4H7BQ3WXhZCXg2Dl0PdJVhKOKs/BJ+VRFL6mrv/E=;
 b=JTkWYpuxx/xyJnD3ml2rch0/s4Co/6rRzylSILvnbgpOTeNh0zKRcE0LA1flV1w6PSMepASVd+ZZ1BptgsOmbyWeqXPw2RNwU+1uFW7kXyLEHESepHv3F/1Ici9ZJJyDFNlBS8ZE0UIonRp64Dax4F91DGGRSidhZ3IgRkJ3BA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5477.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:284::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:43:11 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 13:43:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Feb 2026 13:42:54 +0000
Message-Id: <DG5DCYIUHCF5.3JL8I7GQ8REI8@garyguo.net>
Subject: Re: [PATCH v3 1/3] rust: clk: use the type-state pattern
From: "Gary Guo" <gary@garyguo.net>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Drew Fustini" <fustini@kernel.org>,
 "Guo Ren" <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-riscv@lists.infradead.org>,
 <linux-pwm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260107-clk-type-state-v3-0-77d3e3ee59c2@collabora.com>
 <20260107-clk-type-state-v3-1-77d3e3ee59c2@collabora.com>
 <20260108-delectable-fennec-of-sunshine-ffca19@houat>
 <98CD0BF6-3350-40B9-B8A9-F569AE3E3220@collabora.com>
 <20260119-thundering-tested-robin-4be817@houat>
 <aW4lCfUyumOKRRJm@google.com> <20260203113902.501e5803@fedora>
 <E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
In-Reply-To: <E7286D12-0BD9-4726-B072-FE5A040312B1@collabora.com>
X-ClientProxiedBy: LO2P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::28) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5477:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3d743a-28a4-4ffe-445a-08de632a2c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2dRVkRmWGhzcFhIQzJRYXZxTTFtZE5ocWJCUDhFamxqVi93NXBRazBoRndR?=
 =?utf-8?B?a3NKY1c1eXdJaGtwQyttNXhTc2hJRlI0bnhUUjdMa05uOFUvV1BneEtDREE2?=
 =?utf-8?B?UE1xdkRNLy8rVTAzUTZndnpXNFI2Ujh4UzFNcnhaYnhMWTBUVHJwTmk2MW54?=
 =?utf-8?B?blJjRVhtRFdnSTBpTDFUNTBzUVpzTUhPcU85UVgvNXIzN3NjLzhRWnZDczZW?=
 =?utf-8?B?N1hBYUFnclRTM01FOUpDN3JtRlk0T3ZxUllMaGU0eDBtMzNtamlBN3BRbkhh?=
 =?utf-8?B?QjZURGRhQXR0RUQ5RlJyQVF4K29yZ0hxa0VMS2QxallJM1hNTnhuL0Ftc3lz?=
 =?utf-8?B?VDhRb1JHdThYUUgvYjJaUHdiMnR3YnZYUWJHZjIyR3BJbi8wVk4yMjQvdU1H?=
 =?utf-8?B?T3VHc2RLbE93OEc5MUJCbFZ1b3Z5b0xXMkZianlEV1FSOVNPMmZYTjAybU5C?=
 =?utf-8?B?WFZxeHhkeXM0anFZTnFSN2NpV0hBTFgwNVJPRXovdUw2c251T216ZzU0cnV6?=
 =?utf-8?B?dkJiQ0ZXdmIrcjVKYjBkQnlHcnNlL1k1dlVoOFJSNURrUXBkaER2QW9qUTZB?=
 =?utf-8?B?MVJtUndzUjhUNldRSnpzTGxMUDczWjhjaFUrYm9lRGpJeXBTQTN2V05WUHFG?=
 =?utf-8?B?elF1OCtwRENYWVFZenJHbm9jNEtORTBjOGRYZHN1b21aSDdQYTY1dU94elFZ?=
 =?utf-8?B?SkIvUjU0eFJRNjVtalJoVUgrVGcyWUdmMDR5M1llZ1RVMTZXL3dwZ2tFRGJo?=
 =?utf-8?B?OW9EVzhZSDE4QzJWeUZzUG93Y2YrREkrTDhIMFJDQW9ZMzNHeTZ6MWsxOGg0?=
 =?utf-8?B?YjQ3Q0lPbUZrOFlaNVdHM0Q5ZmU2OEdheDN6Y3F5aUZnUHZ3SDBEcWF3TEZk?=
 =?utf-8?B?bW50UkNNdDdzWTBiQ0dTL0FTd1pXWDI1UlAwNUlVREErajdKL3krWDZkVVpq?=
 =?utf-8?B?Ry81dWZEOWZMRXpyTmo0aDRkVk5yalMrb0pHaWI5cTFOT3hNZlZKQXhseVEv?=
 =?utf-8?B?bjRsQ0FXNkZvL05OT3EraStRaTlzL09MMk95dHZFRlZkMWUrU0Y4UnovcTlJ?=
 =?utf-8?B?NUJUU0F3TkFUQzZwRHRQNU5PSkV0Vms3Y0lobGxoQ0JWV0dKTU9WaHBSajNo?=
 =?utf-8?B?Y2NGT1VuYzBUU1RZbDdHTWZaNWZ4YmtSY1d5eVB2L3J0aUFoZ1hMV0x6djN5?=
 =?utf-8?B?MTQvcTdBRDZ6eUkrTXdyQ1k1UmFTVE5iMFM2N2toK1Y3VVNCRm9NVk1icVU5?=
 =?utf-8?B?Wk1TTXpCNFlzQXdrTGV5UUJxZGlPdUkvWFlQMzVVM3BGZlhlWVBhNzlzSlpT?=
 =?utf-8?B?MlJMZHZFZjcvT3FKUERTVDBDZTNYdW1aOVZpUWR0YXBFa3hCY0JlMWJYUlFR?=
 =?utf-8?B?NDlZSkFtem45cWhBYWdwWlZLb1lUUGRJd3J0bnU5ZG8zbDQxcWJLQWlTWkhi?=
 =?utf-8?B?R1c1bS9iVkFiUGtLU2pBd1Z1QU5KYUhBNlNKckNBWVl6Z1hwbG85MDVFZGxU?=
 =?utf-8?B?QjVwZ2lXVC94aUtzd1QzM1dJUTJLM3hhR0RCUEdNbjNWUGZrZGh1TVBGM1Jl?=
 =?utf-8?B?cTJ3MVdLSE1wRUNrTWV6cVJDN080am4yZnA3MllFRk9iOGRic3BET3ArVC80?=
 =?utf-8?B?dFBYQ2I4Z0JTWGkrZENlUGpySmxtVTNrSXN2R3dWV0hPb25HcHI1ZTQrRUFx?=
 =?utf-8?B?WUJlR2gxZVV4OGpoWEZhcGE4Qzk2RWJyT3ZSODRicEswZ1NJcE03RTVvQTU3?=
 =?utf-8?B?M3JpRENwL09uR0Z2dVEzeHlBbjhJZWZqVWpCQmdWWGFydjNIVmg1TGtPT0s5?=
 =?utf-8?B?bHVZdUorc0xvTTU3SHlJMzcxbm5qQnpsNW1IbGxhNlVVNENvMW9FajdTWTVB?=
 =?utf-8?B?RWtJaHJXOHdwZjVnRC82S3BZSEZWZEtXUk9vVkRrMjBYZTVlOFdjZit2aTYz?=
 =?utf-8?B?dE5QSmpBTmJZZGFYL2Jnc2tIT3VwLzZERXkwTTFmbFhDN0J5Q0Q5VUZMdjIy?=
 =?utf-8?B?c00yMktHK04rdTlkNDF4ZmF6TmJtK1R0SWhpZ1JkU2E4cFRkaUlsY2Q4aFll?=
 =?utf-8?Q?Hu3uis?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0Z5S1AvSEJwbnkxbzRLN3pDU09qckE1Tk1yYko0VHBQbUZHMExuNGVma3hu?=
 =?utf-8?B?a095RjRmaGZvSE45UTVEQUtwM3RyU1YwYi9tUytxck5yRU03YTR0OHk1YUFO?=
 =?utf-8?B?K3pyQ25ETStRY1BUZ0RMOEJqVVNSNjd6Ums4RnNWV0pNM0Y3bFBhY3Nwdzlw?=
 =?utf-8?B?dUlvSzd4Q1F4Sk5EZ0I0TlR3Q1pnVmpHVnB3MFc1dWZMY2FxMVg0ZHhRSS9a?=
 =?utf-8?B?VDBDeDc0ZnNjNFVqMUR4S05IQ1ZDMkdPVUFRQ3hIK1hrVHRaeElZc0htWWhr?=
 =?utf-8?B?YXFFcGlCL2J4bkhRZU1oYzR5V3dZRTdITzVoUXRqeC9SSWlWdzNVY2xTN0hu?=
 =?utf-8?B?ZG5jSTB5QmpsalJmNmRqdzFpRnB4TWxMRW5ycDdCMG1rR1NSSFVYQVJkdDdB?=
 =?utf-8?B?TC9DNFBIOFQrRS9uRW04Z3FYMno1QTV3KytDSEhkc2dFR0F2UlJ3MWZSS1ln?=
 =?utf-8?B?b2wrckN4eWMyNmllQWx1Z2N3YWJITGVrblBuTlpobE5RY2NxWkdCNlh1RExu?=
 =?utf-8?B?UExoRjFJVzZsbTBKVXFjbHUydXpIM0hMampEdm5FMHplOFlpYzE2ZFJzNzhw?=
 =?utf-8?B?eHFOc1RLa1lUUkNmaUR1NUVqYUd1T0RuM1dNeHljZUhRejI3TDg3Z08rYkZO?=
 =?utf-8?B?bTFabmlNVlZEZitRZ1dLWHFZMEN1U2djczEzcm5xNThRNVRneFZSYXl5NzdZ?=
 =?utf-8?B?ZE9QWlc1YWpJSFBRUHN2YnVRdWs0ZTFRQmhFOGlkYmdBMWlucFlxNFlRWFp2?=
 =?utf-8?B?SlhWSnE3QXNEdlJURyt2YWwxcm9ZZnk1SzlyUGF0b3JHam5jZjlYa212ekFu?=
 =?utf-8?B?OElDdWxzWHZ5UjVYM3hoV3lEbnVISnUvNGpnNzZHaEd4K1hiL1dWa3RwTkpV?=
 =?utf-8?B?ZGtpaWs2VmI4R3pBMllFdUpJT0xxajFsb1h1YUFrcTBpTzlmQmtmaC9jZ2RQ?=
 =?utf-8?B?dzFhRHlJWVVQTXdSemRqcmhsemJMSiszbmxNSmZNQ0FFZlJmakpPUFNOZWJC?=
 =?utf-8?B?SmpPUGtneUZ3TFR2Znp0MHNwVTJKcXc0Misvb1UxMVRFeEY0QXk0KzZIaS9o?=
 =?utf-8?B?cXZUTHhuT25mT0t3OUsveTRJSXNsdDBja09MbzlNNTBETUlFZDRhbUZBRHBQ?=
 =?utf-8?B?R0ZsOTRJR3BTcEErUlJtdVhnbUl3NVRPR2R2WngxNW9iRTF5bTVzOEIvdTB1?=
 =?utf-8?B?YU95cmczNjJNMDlPcVh4bThMZ3ZiWllRVE5LSHNLVVFsV1lUY0tROEFjNjFi?=
 =?utf-8?B?VVVoaU1QRzBMNkdWV0VRdWVHYmR4UHJ1K1FtTnV1bEpFOWU2SjlqdHN6NDRk?=
 =?utf-8?B?bC9uVzRaMFJwS0dyUjNDdVpQK0tsNmd4RWo3bFJ5dkFnb2VKbU1IZDdiTkxs?=
 =?utf-8?B?cjIxOFRqc0dObmRqV01XUlk2MG9KMjdNdjM2RGVwMDJ1VzF6SVlGYVRpNDg1?=
 =?utf-8?B?WGFZYTk5U3lLNWZzZkNOS3M0M3ZzMnc3QjNDZUg0WmdKVmZuNFBhL1hiZC9T?=
 =?utf-8?B?TmNSUFdBVGFUWFJ0MEt5OEFYK056UkdLUFh3MUFJV05xSGlBVjhtZTNWL1hJ?=
 =?utf-8?B?THRVQmthYUFWaCtKcnY5SzZ1ajZGQ0pJaUlFYW52TDJKYkdhZXpIV3VEVVl1?=
 =?utf-8?B?M2YyUHEyVlhxUk96YkttTDNGak9lME1TOXNnS244dUEvOFBRV3hrYzVCVWt4?=
 =?utf-8?B?SGJNekNLM2tsbXNaWjZ4T3hhM1NISDQvYkx3SzZHNFpZL3NFM1g2Uzk2Sno4?=
 =?utf-8?B?Mm1hUlUrWGdsTnlaSVUvbFpXVzlBQnZHaHdiVnVQc2JUa0xMR1FOcDNqK2Q5?=
 =?utf-8?B?M0k0OWpjbG5vOENESVgvcGlWRnUrMXg3T1ZPUDVDNmVqbTFBN2NEbGRGUStZ?=
 =?utf-8?B?OHREUmNibnF5RHhJKzNkd3VTZjY0Yk5KQTZYQXJKVVUwbW9LV1JJYkpPUVBi?=
 =?utf-8?B?ZTBXcXYyempWOHZ4czl1WmhoZlBBK0p2LzNNcVNUZ1VhcVhrU3RDTnNyMmRL?=
 =?utf-8?B?VTdpN0t5bm9razR1K0tOM0kzSWM3SkNQVDJVMTNGK3p5U2d1ZWxVanFPQm1r?=
 =?utf-8?B?K29nWnRvM0pFOVZaYTRucXBFMWZoeXlnbEdnKy9zUUU4WWltK1Bkb3pVeVo0?=
 =?utf-8?B?SDgwV2txZU8yTXEySDhoNmdMVHpUd2wwOWtRNmI3MEJSMm1HakxuK3h1RlNX?=
 =?utf-8?B?N2J1TkJZYzN5UHVsZUUrZldQbnQza2MrdmhOamhUVW9RWW9xM2c2SDZnNFNX?=
 =?utf-8?B?aXRXTkZPKzlyRmdxL2xYM1ljY3VSMjVsZUtNanJPSUZld2U0NC9LNzJRZEZ5?=
 =?utf-8?B?SkpVOE9vNzVhclY0ZnZtN2M0TSt3ekp5UVdoVjdhSWVES0pFakRMUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3d743a-28a4-4ffe-445a-08de632a2c20
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:43:11.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XekD8BKXlU2MYgWj78MdIxmGLyg+oyUueodUvliZoXkmvKnpEonIdyUGsug5jM3HJpvBlW8dI8k8sVBDTtBqvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5477
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8037-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linaro.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,redhat.com,baylibre.com,garyguo.net,protonmail.com,umich.edu,vger.kernel.org,lists.freedesktop.org,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url,collabora.com:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: D1C52DA159
X-Rspamd-Action: no action

On Tue Feb 3, 2026 at 1:33 PM GMT, Daniel Almeida wrote:
> Hi Boris,
>
>> On 3 Feb 2026, at 07:39, Boris Brezillon <boris.brezillon@collabora.com>=
 wrote:
>>=20
>> On Mon, 19 Jan 2026 12:35:21 +0000
>> Alice Ryhl <aliceryhl@google.com> wrote:
>>=20
>>> On Mon, Jan 19, 2026 at 11:45:57AM +0100, Maxime Ripard wrote:
>>>> On Thu, Jan 08, 2026 at 11:14:37AM -0300, Daniel Almeida wrote: =20
>>>>>> For example, it's quite typical to have (at least) one clock for the=
 bus
>>>>>> interface that drives the register, and one that drives the main
>>>>>> component logic. The former needs to be enabled only when you're
>>>>>> accessing the registers (and can be abstracted with
>>>>>> regmap_mmio_attach_clk for example), and the latter needs to be enab=
led
>>>>>> only when the device actually starts operating.
>>>>>>=20
>>>>>> You have a similar thing for the prepare vs enable thing. The differ=
ence
>>>>>> between the two is that enable can be called into atomic context but
>>>>>> prepare can't.
>>>>>>=20
>>>>>> So for drivers that would care about this, you would create your dev=
ice
>>>>>> with an unprepared clock, and then at various times during the drive=
r
>>>>>> lifetime, you would mutate that state. =20
>>>=20
>>> The case where you're doing it only while accessing registers is
>>> interesting, because that means the Enable bit may be owned by a local
>>> variable. We may imagine an:
>>>=20
>>>    let enabled =3D self.prepared_clk.enable_scoped();
>>>    ... use registers
>>>    drop(enabled);
>>>=20
>>> Now ... this doesn't quite work with the current API - the current
>>> Enabled stated owns both a prepare and enable count, but the above keep=
s
>>> the prepare count in `self` and the enabled count in a local variable.
>>> But it could be done with a fourth state, or by a closure method:
>>>=20
>>>    self.prepared_clk.with_enabled(|| {
>>>        ... use registers
>>>    });
>>>=20
>>> All of this would work with an immutable variable of type Clk<Prepared>=
.
>>=20
>> Hm, maybe it'd make sense to implement Clone so we can have a temporary
>> clk variable that has its own prepare/enable refs and releases them
>> as it goes out of scope. This implies wrapping *mut bindings::clk in an
>> Arc<> because bindings::clk is not ARef, but should be relatively easy
>> to do. Posting the quick experiment I did with this approach, in case
>> you're interested [1]
>>=20
>> [1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/d5d04da4f4f6=
192b6e6760d5f861c69596c7d837
>
> The problem with what you have suggested is that the previous state is no=
t
> consumed if you can clone it, and consuming the previous state is a prett=
y key
> element in ensuring you cannot misuse it. For example, here:
>
> let enabled_clk =3D prepared_clk.clone().enable()?;
> // do stuff
> // enabled_clk goes out of scope and releases the enable
> // ref it had
>
> prepared_clk is still alive. Now, this may not be the end of the world in=
 this
> particular case, but for API consistency, I'd say we should probably avoi=
d this
> behavior.

Is this an issue though? You cannot mistakenly own `Clk<Enabled>` while the=
 clk
is not enabled, (and similarly for `Prepared`), and that should be sufficie=
nt.

Having `Clk<Prepared>` makes no guarantee on if the clk is enabled or not a=
nyway
as you can have another user do `Clk<Unprepared>::get().enable()`.

The only guarantee is that the state the clk have is going to be greater th=
an or
equal to the type state, so allowing cloning an intermediate state is no
problem.

Best,
Gary

>
> I see that Alice suggested a closure approach. IMHO, we should use that
> instead.
>
> =E2=80=94 Daniel


