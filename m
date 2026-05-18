Return-Path: <linux-pwm+bounces-8975-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAy1CGw1C2qgEgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8975-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:51:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAA570504
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F913055BCE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0EE3EE1D5;
	Mon, 18 May 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TFRNTfIB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16813F88BA;
	Mon, 18 May 2026 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118854; cv=fail; b=MJNnGpd9nRbEQ9sfgoFG8MSdv7HIH+IM5CiGx9kcYUbZ51SjJ2dTpZvVJtk4FVHSe0F9pccopNygo2U8xVz/o+BNpiO5G6J4rQbq3CD2ImmhzqeXZoV1eNtoVLzAVUP1mHW2Xp6jMZSl0vP1r7fMPvgj66K0OStJr6a0ndd2GGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118854; c=relaxed/simple;
	bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=lE1GPrh9RQafvjXCoDZBDoZEh0KUTRGi1dRg9rC3v5F1FCAwGSDd9hvNI3Ub7w/oKJ07vSpMjGcR72q9osPQNoFfzmo+GYFZAtqAHFeTHUUcyx88DS+6brrEJgviQn7pzm5AlVRMaFI/+4QsQGDG3DkedDiAf1EsjzyvDOJHBfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TFRNTfIB; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnyQYzceOdjMiOyuJboE9y+6ljEyBYqrGv0msIO2foI4cf/Xsl9uDUbStj7XyxIyWwZT+PUfh/+/IHFVXBqqkncboW0iHGTqttZfo675yNlDAkAbS6XyRyc7QT6uii4TjjuyN/pppei1GRK9FEEbwAFEPkVVDH7MxTDZZAa2P6VwlJEgyv6xkX7Q9+XMzXutwJHNsEB+429nbRSUNAQx+QMatxQOlwtRpokZB6kDbXrdIiHhRa6Iu+8czICy1LAxR4WEiJunKQYdbqUjK810s5/GJRvlEH9r+5KXDKXqu585aDUgDp9aCOJ0manmINPo7pQrg6kOkA8bgi4cXC/Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
 b=eKulPhCEla5L4VaJsS4J6miJhghHsS8UDEwvcKs4K41jgQ2Br4Xq3TjtJDMoGorkHhTepxXzBghP7u7OZs4EBFiazv/609AiwcBQ1YLcV5zlCmRqFFsevmKzLHq5yNhv8P0WBAM6JvgtS1cYc+RyfP6hgQhQJqKlYMQg5ZfWU+EbZe7p6/DCc0bGDWxXBY8DTgInVcHAfKIJCf3lSdXCgvvhADiZp0bEqt+Z1CcwUuPB6jzfEHukmndyLkbItDOFXkmG9OFp/Rn3ae7R18RSF9XMb/XhZCzimGw3csD3AhSRs37UqiEl2RvFb0+t+nXYW6N2cXppFt7BNZ7Vawu4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+jhm9xMp9PEoKgy1p/chvasKXDb+lOKSNBgEQBOedU=;
 b=TFRNTfIB6bTRtjBWqDijVcH1bqxJkQKzipDsTot8gaLm86udZJWeAJY9AdA7oRE0M1Wl6EvEN6HY9pPhJA2CY704wUDJFdVnEB4mWb023kOhqdmpH9QqutE1adit2qd0DxvBHn46JgILTBf6beA5nY/gQ8o6yN7xUrrZxYo6ZnqtofhzsLGDw8A4ww/xXkcZx8dEKEappDU4oV6fSUOPKAgNjXzILxkdwTkbD9L2SdCHL1laf/CuSaL1H57YS4+XTWhyyyBpOPSMW+Cslj15Y5mm6YlXk0UenVWJ0TWzyerTTobvmuQTmwE8IFRR8VySvw7TXEbq5OFTswyP6LRpXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS5PPFA33D606F8.namprd12.prod.outlook.com (2603:10b6:f:fc00::65b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Mon, 18 May
 2026 15:40:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:40:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 00:40:37 +0900
Message-Id: <DILWZQRNET5V.2H4FBJ3QS6102@nvidia.com>
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
Subject: Re: [PATCH v3 13/27] rust: usb: make Driver trait
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-14-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-14-dakr@kernel.org>
X-ClientProxiedBy: TYWPR01CA0001.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS5PPFA33D606F8:EE_
X-MS-Office365-Filtering-Correlation-Id: 900ad880-c96b-4fdd-0ae8-08deb4f3d17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|18002099003|22082099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	r3U4wMszcjMREAYeQV//8S6dOuFtJxp+Yka4+beF9dFV+buyRcMsIAvUzDbI1Qfx95QxKRDmee8zrf3DRukDMGmJ/gReaZFOv3JXIQgmDNbvJ1/D10GtOsj4xPPumEksYXl6gihyCSbwxxhq8aD2VudwLhEuyRLu8wbV+nMUho94S8qthO4B79FqoxrSlp/hO82FUXZMqLrDX0/kDdzkMYtcN+IzR3Yc+Unox+OLN/YKgq0emN7MFbMP1ouvysopZfNGIFcFSP5VHixIRMUXE59w2Kk9duKIdKXcX0gmZT24B9W/t6ucLrAPfOsJVPnkghOOZC+98c9Ur81pgGByDKAA2F4jBH4mDzRgCB9HaJpTDODNRAA7182t34KA8t+n4YXXOcM6gSF5qb/Gmc0Oq2IWRI/lHOkaVliRrc5QVPAovn2CG9Y9RHRL1KhqcNW703hyP0nrc05GjhU+nqqa1URNRntxC/fmTAMAl7Lg9a2Jhpwq+vNz0bi0I1h57QBsCYd3MhIquPVT5603Aolpb+azYkvmQICklN5MbvqD1rx/vxW6sJz0Eoemip7swaWWMg6Nhcs4U1HDnWosUHxM3YfLkiVVY/7yO0TmjfAFmr+EsnHCrHHM592JEA8rq8LECf8DtlO+tgyFt4m5rd7QVL8C+wwgS1vmV0L89jYGHKb2X6hK7AATKlxZXr/LH7tq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDhZU2dOVkNsQ1E5MEhFR1QrM1NjL3VsR0wvZUV5NTh4ME9aRVp0dWhRaGR5?=
 =?utf-8?B?YmZYNDhFeHNqOGYrQ3FJdFduOVI5a3pHVWxmVmlqL1EvVXl6V0JoNjFpNWVN?=
 =?utf-8?B?MzlMZUJzTEY4VC9wUGFOSWZlazJkb0JLOW5hWFlPS0NrSDNMUTN5L0p3MTZv?=
 =?utf-8?B?eTlwR0JuTXJENTB3Z3F4enQ4U3BUSGFlWXJjR2pjS1ZTQ1VrdWVlMFlxc04x?=
 =?utf-8?B?RGJLWUpOKy9YWUVqK2c1ZG5QczQ0WFM0MVN4TEtmaDdIK0ptNzkvUERFdkt5?=
 =?utf-8?B?YW9VZ3Y2VmR1MERucUlSamtkZDBXNE5ha3hSZ3AzcXJBNEhtUVlQWjd5WUtT?=
 =?utf-8?B?c0RSTkZCNlJPOG1MRWI1K0RDQ2NxZkVSRDdYN0prWGFiU2tCYmhheGcvTnMy?=
 =?utf-8?B?MWl1U3FnQWRoNGxVOW5rZk5mUk15UlJQeisrWThONmRiMFBpWld4bzhOSS80?=
 =?utf-8?B?STdUTkpPUmdDenc5bitmUHcybFpMS0w3NERNMThDK3ZWc09MVmRheGJaVDhy?=
 =?utf-8?B?dTErdE0vRURuVEZUNkJ0YTIyUFBIdzQ4Q2RtQVVXa2ZvY3BrZDUvbVN5c3RJ?=
 =?utf-8?B?VnpkUVBwenYvaDM1bGlBb1ZTSk1TMS9QbVBKdVcrL1Bza2FNaTM2VXp1SWRj?=
 =?utf-8?B?VjVyeTV4clJBL2Q4N3gxTmlwNzBjUW9zanUwYkFja1lGbTVWQWZZaUQ5VnNC?=
 =?utf-8?B?MEhVQXhIWmMzSUY0Y3FDNTNDM25sNEk0Z3lld0dKdXh0UW1FVC9tTUkxcTgv?=
 =?utf-8?B?cy9URng2TXV6TzM5Q3RrNk1aMzNhQW1Od3pVaHR1WTNxTVpieERUblo0NGNj?=
 =?utf-8?B?V2s5K2xVY1c1clNxTm5WemduN2h5ME8wOElOTlQ5TVJ4aFNCcmNORVY4dzk1?=
 =?utf-8?B?MElQclpNU2VobzJvVnJPcDZVcmhsTDZuU3ROVHZIYnlyMTh0VWNSQWVlcWR0?=
 =?utf-8?B?c3gvdjlVUUVnR1dDNmd0UGZyOXQ0QUtXcy9icHBCdUd2b0NrVk9PY2xWdlFB?=
 =?utf-8?B?YzQwcVlOSmhYM2N5RDBrbDZrK3JPSGhLMFk3ZVFENVZ2WVgzRlQ2OTBOOWMr?=
 =?utf-8?B?eHZVeHRBT2V0WXRFclF6c2N5bVdOMytiZjFlcWdwb2tDT0F1czc0eHhrZVhG?=
 =?utf-8?B?a2dhRWh0ODdnZzZDMDBkZEU3QVh4elpscVBmbXY2TWMzN29vbkUrOENiTEtt?=
 =?utf-8?B?a3NZWE5Xei9tN2ZKZGJHQUQ0UjJXMTRuVzVSMnhVVC9FQnA1NjlsQXloU3kv?=
 =?utf-8?B?UGF6d21US3k3cy9YYmV0SmtIUFRUL3pmdUVWZU5pdWhhNENwaTlFOXp2aEJk?=
 =?utf-8?B?UG9Xa1owN3hPdlk1TElkYkU1T05WSGRkWXFXdkR0ZjVtcTFFY1BFVTlLM0Iz?=
 =?utf-8?B?T2hxamg3QWRTcldqVEZSLzNrbGIzMzJOeExaVWR3SXU0ODJRam9oMm5IaTJ1?=
 =?utf-8?B?NWZVekl1NmRiV3I4SzZaYjRXTlFITFVrVHJqR0hNeWZ5MUIrVWZJTG1QQ082?=
 =?utf-8?B?SE1xemVIM0hXTk1McWk1TFFFQzNCWmJDcjIxQWNsTlNsY04yV1VQZXorYXov?=
 =?utf-8?B?Z1V5Mkd3K1ZhMmNNWXFpWDZCNGgyKzU3clZ6dzJZR3k4OTBlUktpbm41aWlQ?=
 =?utf-8?B?WDIzcFErckNySSthaURFR0JscVI4enVGWVhEaVdmMjNDblpIZWF3T1pQOHgw?=
 =?utf-8?B?aVRmOURYcUVDaFJzSFFCUUpEajV1OUd6UkNxcEUrWitJVTBPOTNVWWFkdnha?=
 =?utf-8?B?NzhENTJ0eG9sN1c3MFRMaE5QRnV6cnY3RTlUQjdqcjBvTFprZXQrRzIyTTlo?=
 =?utf-8?B?SGQ0bi95MXJlMHpnSUExUGtXbW53V3FFR0lIZ2hhL1hUZVhpWjE2aXRzNmU2?=
 =?utf-8?B?Y05nY0dZaTdaTUptRDVsemJDeE5CdXJacU5SZmJ5d1hTSnczblFpSjVZNUh4?=
 =?utf-8?B?MEJQalBma2hRdVNSeWk1U0tGSENzOTF1Q3B3VzR0SEh0eFdUSUhNUHZ0L3Rw?=
 =?utf-8?B?UnZ1Uit3bVJaZ1d5L01EM1RBQTVXZXAxMWF1SUhneWgwV1FkVVBGZ2hJeTZr?=
 =?utf-8?B?ZFh5OHdTTUVPK3BaR2JBRXpsZjRzWmxOYUZldDJSelYwMjFEYThwZ3dyZ0t3?=
 =?utf-8?B?Y1prb3F1OVZuVXh4bE55R3RHSm91MHd0VnB6bFVWMDEycjMzWFR0ZzlmVWRJ?=
 =?utf-8?B?eXFPdmNaSmdsRWRZVkNZWnZtQnRKaDkvZWo1b3NtZ1RLdHU5MldyaWx4UGVH?=
 =?utf-8?B?TS84SlpTcXdmbDYweDVOQVVTb0t6bFBhVW5DaHpScnNKc0ZIaDI2VElGSitm?=
 =?utf-8?B?bjhZSE1LcVF4M0NPNzQ4Qi80SnEyUkU3cnlqQ0I4NGJmczVZbXZHTmVjdUEr?=
 =?utf-8?Q?vEzaC0San1XhI3kwb2jy9Gds34kL+mwZzggX/jXXc2Z6M?=
X-MS-Exchange-AntiSpam-MessageData-1: dvjthZNItVql6g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900ad880-c96b-4fdd-0ae8-08deb4f3d17d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 15:40:41.9040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQQg0tNrohiqy8xeczSboJdMA9Hqs3yzRXWUiz2emdicxWYaMFnmNwN7JiABltc5kvM5a25oQsnmY8ly0rU/TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA33D606F8
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8975-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 82AAA570504
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

