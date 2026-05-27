Return-Path: <linux-pwm+bounces-9167-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDF5DPzwFmpcxwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9167-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:26:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957D5E4EDB
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 034E13055D48
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FFD3EFFB4;
	Wed, 27 May 2026 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EYyRSoBb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022140.outbound.protection.outlook.com [52.101.101.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE6C3CE0B8;
	Wed, 27 May 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887589; cv=fail; b=aadO1VePCs85MF/bkv9l4F6oy9kdwn+V2gF9pTR48HfRVd9Dhvcoytydqei8/7KMnUTp5V7ML6guAUNj6AzzVq25N5q7VciKYSAxQu1sXKosl21dOZAN3fKh/wqtoHZYIFAyWbaPJH3NyuUBXJwzHrC0Km6FzE5YSKFCiH1x/54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887589; c=relaxed/simple;
	bh=9DORoUHH8c0epgG21o5CKbqQWeId+8D+fhpl7RFAeI0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EAnugZ2pLU7o7Z0dyks5DKbfOo4N58KMoIWSGss9TEeSoFRtek9TnR4FnLWZaVAtUN4amjdS9pWc57LIllx1WJGH/Cz3TGNqIkxWz1/L5ziDeKa9If/6ymylwqeMvdk5XIuasAEi0F6MDoJg8a13HISFm2uTKg7zFkUZyM1E4R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EYyRSoBb; arc=fail smtp.client-ip=52.101.101.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNx/oSAqY63AZ2OswhSw/vOBkKmhUO7S+rMQHKOK8upRARpiiKd441qNSJ08jWMPXFp4J42tvAjrv6fjcLaus/DoHfCh/SQ4z49o/DikSL/MwoQVpgZjUdlG6xypkiYXxQiIgCaOBFnxcZ6+TQ2btkZCLrFmBhi4RivEpPXUKobddm1N1qhqnaD6jRApLYppCLeAC0cTjZ6iI1BhfJZVzZ0wY2TdVRZeVcKHywI3k7GSZISHl6F45kJUuU4/pZPypWHWQNZ+oO2rXMJKVH2fuDUMWZdCYjBYheiIYEyzl6roqRBAC7FsR7XTC/ciRHFO5P3M9SXiW1F21N1nKUHMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Yz2efpOsaj5hYOAkNbgN8/utAy3HXSEXQNxm+Evn9I=;
 b=ko/eORuX7AW0IBOgksZ31UDMU1Cf0iaVVerOVTPX7rL7iPWjXpG55UNsdhAXATeN2BNIMXxZSW8jP5bm1/2WQJdLti4mziHpT/BRAkj5J5Lr3xPvsgIucc5v7/9aDAzYPrEIQH4x4jyhoS5IV/hEwtd6xzfssVnCcjSgvDzKE1lKdyjoTYuT+IjX5XkqyT8t4DvyViHmMgWeMrzTyf4OR4WQRvmhr1J3v1L5U4CnBr4xD5BD2/+/Aw+EdtI4A+R0oKnJYJa5rDcNE+ULf+VgYUFJtAqkjSaoewMkCxK4ebh0p5ghJTaEcpHKhR2cCFp1XW7W7mBHjUAkprJ6SpXGTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Yz2efpOsaj5hYOAkNbgN8/utAy3HXSEXQNxm+Evn9I=;
 b=EYyRSoBbZsVO12E+X4WG6Q1zEoI1eblQyt7JJr95OBwrJER1FKlANkRMSJ6sRgy679erHeQvwkKl4xo6bytDtBW8MXRgfHg1bfW03cAtM/u9HAXVaEj0ji02jOZoKXejrGyqa1RbxsvhbKBrdzn4QQNvMODDDJT66J979V2re2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8687.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:13:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:13:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:13:01 +0100
Message-Id: <DITHHN0ECZIE.LHY3OLB53XAR@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v5 11/24] rust: device: make Core and CoreInternal
 lifetime-parameterized
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
 <20260525202921.124698-12-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-12-dakr@kernel.org>
X-ClientProxiedBy: LO4P302CA0024.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: 657549bc-3d59-4847-c5c9-08debbf1aea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|22082099003|18002099003|921020|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	HS/iQkr9C+5UvxBcpSzCVITn2u8Uqsppyk81wXTDq+FQt6OdQ8J8nWsi0LDDRsE07tKB+Mm2VWd6oY9oA8ZDvJEjBJZGce0WaAR17Ojohs35zXsq1exRljImq8H78bM2m+i4w/qKKRC03pVOZvpSJ50YM0Tt+MvqxcMGTko4GVblgiWe/i9YQJ2tsao78shkSDiFimsF39JPoEyqeDR5eZbWzbGpYQzC1bivc9RGu0raFoqswH4UyaUVPSe3qpsRlh9rwzmqlfDCMoWXV2ODmh6VOOEsAockVl2EuQX2ZhNzVJx0XFYCo/CvbsZYvo7QORbJ9Eyebkx3rS+em5dkGTSH/UxF63HpMJORX83Xjs6qyfeFGj0tmMEveQnaCDM8dYSEgqrSzLpv/D0TuN2E/aeog15V7k2notTHa0/3C6N0Th6aDwe4YjOD9OzpzuIHJdUuqAB8/0/8BsOV6z8yo8CaHag7MC5vhOpVj6aUb2/Txg4cxvgtamprJ+JZgklCPNPb0y/S67r1S2YbPyWAupIv0ZbgXWxy96N4OQ8uDq5nn/p80Y3kda1MlWFzhMwSu5qQL6bt5UHIh8POPTfTpZ///yfvZVsIZZTRlSDwkg102nTonDtCqeezuJvDOsZpvz3QKL6NTJk3dcMLBvDp9LAschR3PhDejNBjAWNTox+il4Qeo5GmzG7csKpv0qZQ9L8V9RZjK5JbaYPmW4AKaqUKpBIz8zlZIEroznbxGag=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(921020)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWxKZ3JBb3RrY1FQaGFxTlFmNitQejhpNVdaNDN3VGU1M3ZWKzBNdWUxMHBk?=
 =?utf-8?B?Q3pObTBmU2Qya29IMFlSVzBrNnM5bkZmMk5NUSt3MGhneWkrM3pJZkl3S0FF?=
 =?utf-8?B?VUU0SFJuQUhKbWZOWWVaaDd2a051dE9McjE5QUdSMHI0V1ZsK3lUOUp6SURQ?=
 =?utf-8?B?RmY0QThPSDl0NitEWG90REQ3L1lESGw3UnA3aUxnMU52ZGh2VHlnL3dtTnRK?=
 =?utf-8?B?QitIc3Q2VnlnR25wL1Fsc3JtUjN0dy9wWU9RTy9LUUlpSkFpQ05LQ2t2NjdO?=
 =?utf-8?B?a28xQU4ydkNFNW1Na3dqLzFiZjVHQlRkRDJ2OEIyZS9GODB3VmFEVG44N245?=
 =?utf-8?B?SjhYOEMvdTc0S2tSQzdtS3BDQWlhQVFMQytma0tlcXMwV1lXVU5HaERWenY5?=
 =?utf-8?B?T2hEUzhMYk1zN0RWRWhnTTZRY0I2bkQrZHN3SVp5K1hZczRsQXV2TVlRNE5n?=
 =?utf-8?B?WWxKd1grY3JHd1NIQTZkYUFPajJKV0IwWHBRQk1uNDVxZGZ6Q2J5L1pWQ1po?=
 =?utf-8?B?a2llaDJpWkxBQnJKV3Qvd0tRQ2ZYSU12SFdlUjNRYU5jZmlFbFlrWVVxNEVj?=
 =?utf-8?B?MklCQWVoYk8zZnY3ODR1ZHBxVHRoU2tlUFZrc0dQenpBWFN1Mk92cXRBTmVn?=
 =?utf-8?B?R1FKaWxDRmx4WmhLWHpIVnoyOUVFOWorWU5qT2RtTHBUVHVzblpaYjRCWWlO?=
 =?utf-8?B?bnpQeU9ydkg1Tm93cHZEaDJlNzI0ZGsvMWtmSjBpZWJjUi9JUy84WkFsQ042?=
 =?utf-8?B?VWZmQXNJcjE1WkdCUmNoRzlPRmhQVTh1eW9YZ3hxNE5RMVBTNnh0SUZNT29r?=
 =?utf-8?B?ZVpSaThBbDJFQnpNeEdwQ0pCTVkvN1M5b04zaURKcDY0YTJjYkxzSTR5TStU?=
 =?utf-8?B?NkVObm5tOWI2eDdwRDlPeTJXUndzdkgrcWxSUVNkS1Mrc28yeVBkQTg2MWRq?=
 =?utf-8?B?cnVlYTNZVEFiUTBaejFPdVNEdEVwM1RsZUlaeWhCZWRBSEtzeVdzTG0yTXds?=
 =?utf-8?B?MEZjdlNWL2kvdFZGdkt3aFgxVW1TUlN4WjZaeXo2K2dvZDlrWmV5WHRONm9M?=
 =?utf-8?B?cjBaMGVBQ0FXSUNkOGlUMllUSHU1b1hpNVYxVDhMbS91clZoMmtHUGFucHdq?=
 =?utf-8?B?OUJOUy9XL1VRQWludXFOUWwzVkhyOFVLL2lVMFZBTzZIWGZyUTMyNUxDdXo5?=
 =?utf-8?B?dU04d0JSOXRMV2p5MERHeEIvNDg5SFpYakxZQzNrUnpvdzFxNjJTankyclZU?=
 =?utf-8?B?dS9XRlh5U2FwUUljVnhFVnduelYxd0E0bXN2Rk1wUVdqSlRjK045ZTZIRCt1?=
 =?utf-8?B?MUlBZExqMXNNTVpBOWxFK1daSnBGYXplR1oyRE1rSjI3LzVpQ1ltdUxGWWlB?=
 =?utf-8?B?SmMvYkZwdTJhZHBoamE3T0tCOFovSHBya0QvbkRDSTFVSitVZzEyNFJVUGVw?=
 =?utf-8?B?ek5qUXVRU0l5RXZoeHk2NHNieGY2NXhKZkdxc0RJUzVOSjczUzBoZWFSVFlI?=
 =?utf-8?B?elBGTEZBWWF0UUxIOUIvQW16RC9icTBTL3gweFh1ckYvSEVoRFNvRUl0dUsz?=
 =?utf-8?B?ZVNjTVVpeWswb3NRaE5lSGxnMStqWllGTGF4YVhxQktlUkJ1eWs4RVlHL21O?=
 =?utf-8?B?L2o5VUNCNzlPOXBUL3FSN2tibjhvZjlUTzhGRThSNlcxNDRUZ3NONkhmQjdQ?=
 =?utf-8?B?cEowd1pSRUZRM0ppbllTempoa2p4bzlTY2pqNitjdDlPRmhGTHAxTys3M04x?=
 =?utf-8?B?L0FPUHQ5TURFckkwUzlURkRpdTRESlpkL2Mvc2tIK2Nlbk0yWEJiQnNBNW5v?=
 =?utf-8?B?ZlJBcGRzMkhTSTNiaXNRejVBSTFnUUJXUnNEUGNwZThhU1ZkNzFDdXhmMkZw?=
 =?utf-8?B?MW9mMHFYSXpHZ0ZBTGVpR201bWloQU55V1p5cFVzZXcxSW1ZeERKWitMOXpp?=
 =?utf-8?B?K1IxSHBZcVkrWDZWcTI1U0c0emFiNThJbHQ2a0k3YzlDcEZST3labmVXSy82?=
 =?utf-8?B?ZlZMZXdQZG1keFNsSTZjYitYa0srekNFNkM1Y2duMnVJQTE0Zm0xZkk1MzFW?=
 =?utf-8?B?bGgvb2hPRUZwd2RMbFRYOFJQK1J2TG0yVGorWkFMNlF2TnZyTVBJbFR4a1F0?=
 =?utf-8?B?NXdaK2l4bXFrV3BzNTRxWmE0T0dDeE9Wc2J4VituMU5GZ290bmhxSWE5bmFD?=
 =?utf-8?B?NlV3Sk5uZnU4c1cvNkpnRjF3MEdJd1VlZXd6eXA4NmE4eURWRUVOSzkrMGRN?=
 =?utf-8?B?WE9MVW1lUFEwS1VvZjhmNFg2QlNtUytoLzkrQm5WZHVMVWxTVzRlVlo3R1VQ?=
 =?utf-8?B?MzJCdHhCaGNPb2lYQlpGZ2tzYWtEUUU4NzdHZkZnRkdzWUJjakF3UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 657549bc-3d59-4847-c5c9-08debbf1aea3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:13:02.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63SvK01cqMUCy3A1r7FjT9J8Jod/31fGviMLNOiPRkFhzNAT1wHGK35fWHjdLGmICrxR37YaMubXZr81BOTVJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8687
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9167-lists,linux-pwm=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,linuxfoundation.org:email,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 9957D5E4EDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:20 PM BST, Danilo Krummrich wrote:
> Device<Core> references in probe callbacks are scoped to the callback,
> not the full binding duration. Add a lifetime parameter to Core and
> CoreInternal to accurately represent this in the type system.
>=20
> Suggested-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/cpufreq/rcpufreq_dt.rs        |  2 +-
>  drivers/gpu/drm/nova/driver.rs        |  5 ++-
>  drivers/gpu/drm/tyr/driver.rs         |  2 +-
>  drivers/gpu/nova-core/driver.rs       |  4 +--
>  drivers/gpu/nova-core/gpu.rs          |  2 +-
>  drivers/pwm/pwm_th1520.rs             |  2 +-
>  rust/kernel/auxiliary.rs              | 12 ++++---
>  rust/kernel/cpufreq.rs                |  2 +-
>  rust/kernel/device.rs                 | 49 +++++++++++++++++++++------
>  rust/kernel/devres.rs                 |  2 +-
>  rust/kernel/dma.rs                    |  2 +-
>  rust/kernel/driver.rs                 |  6 ++--
>  rust/kernel/i2c.rs                    | 16 ++++-----
>  rust/kernel/io/mem.rs                 |  4 +--
>  rust/kernel/pci.rs                    | 20 ++++++-----
>  rust/kernel/pci/id.rs                 |  2 +-
>  rust/kernel/platform.rs               | 12 +++----
>  rust/kernel/usb.rs                    | 16 ++++-----
>  samples/rust/rust_debugfs.rs          |  4 +--
>  samples/rust/rust_dma.rs              |  2 +-
>  samples/rust/rust_driver_auxiliary.rs |  7 ++--
>  samples/rust/rust_driver_i2c.rs       |  6 ++--
>  samples/rust/rust_driver_pci.rs       |  4 +--
>  samples/rust/rust_driver_platform.rs  |  2 +-
>  samples/rust/rust_driver_usb.rs       |  8 ++---
>  samples/rust/rust_i2c_client.rs       |  4 +--
>  samples/rust/rust_soc.rs              |  2 +-
>  27 files changed, 118 insertions(+), 81 deletions(-)


