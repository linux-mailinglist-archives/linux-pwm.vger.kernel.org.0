Return-Path: <linux-pwm+bounces-9015-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG6hOjJdDGrMgAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9015-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 14:53:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5648B57F0A9
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 14:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9A33077C20
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 12:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2F4BCAD7;
	Tue, 19 May 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rKjTFYk1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021130.outbound.protection.outlook.com [52.101.100.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A545107A;
	Tue, 19 May 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194860; cv=fail; b=DLo85GRr982xeSxhyYTvTG48WXXqicyXc4cfKyukRGcEaA6LfV6G9t2/k86TUPwtMM80M1Kl6NhCROUIcfvmTmvEgNmHdOG9x9Uak2CH2l9k9cp1k+rFJ3yaj/LajDP4Dcr7kYcJJMfso4+hQoGASy8rr7/XaXkOQCq4sE1GX3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194860; c=relaxed/simple;
	bh=fA4Ig80fZ25cn1JTGDIME4spac698o/L/cEDJtNt05U=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Ao9nsga24UGKnm42Zg9RevrG6CerkJQndGVlhxn5k9Gx/1WbYtYbvWWN8O2JnkOyZHWrJfuVYHpbNh4zpzU10J5uC6QGRynj8F4Mi+VsIQFb5CPB2fj7/90OZmacIzrs8ppiw2h7iQRAWDgg/OzktusTM3EfoINV+MxwOremKE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rKjTFYk1; arc=fail smtp.client-ip=52.101.100.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rxlCrhMYXAE45+YPvXNJ2mVu3kTQDsWP48JOC5ccWng9YQ8gChMu3t3TkcDK/QCD71iUMX/wO4ehv1d9UJX9MBSwV3HaQ6PvyJNZsxTGE9xxA46u3L8hcyaqNXRtfOnxBqnZ8/dGyYMC0NU52pfI3qmSsLuwTruy1ei4/sji0Rv65kHicS+AoRsyRS9LMC9oNSpTTpWJvxJmViTvfP3K3bsoRljZEG4oaw3sxEpz4/48IW3D8EhuZ2n8PGF1Hz95z8ctADZniZNdutupYkgoJe13Xt5ZqJUXd+PI81igdev+iV41GqtWwLzLovICnIWMwOXoJym+QeDbJN3Rked7HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld/otdAD4WsAh1XYxTXsHMScyFQMkq/DJK9eg01P2wk=;
 b=eDr2Fy57DjTqjk8kVO/cLnnVzA6CHd4trt5RbJrL94vXpvh3VxdXPDV2o43FBX6ElkxpRGd9S0OqvfkUT+7Ua5A4kudZqLDt2lx2/uLHDgtMWo4eTf8mTjoWknQ2FMpWAWHuxhN44NMrLNRWn1+MqfH61oG7IRpClnUjYvq9RLXSpOVyUN5/D6mRL6MtYWkqL+36U2SHQWFZXq9kdFVrG3NW1vT8pW7ac2Kj8qVtw3Qpw4TIFzB4FmDU1AvoL8pyLQdaL4nK7ClJGrtqo6TvXKDQLSpyIZJ6PVll/NAYl3/WhGrkw4JocRHoBxQAYC1lo3YC6c3/n5tZO6CkGM2GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld/otdAD4WsAh1XYxTXsHMScyFQMkq/DJK9eg01P2wk=;
 b=rKjTFYk1VhLK4arScsDjW1ZBdnLvjii6br3WQ9SHUVuWCvJ9Ay1795V3B/QOEl39bc+m7/Mh8uqrJCm0vjIEgl77CPiGHCSp9sRy8hX4/eS5tdgsBHRLOS/UeB8HRtJBB20sgvsn26CCNDj3nTLkQNC8b8MqNpxmKYK9XvBgqlg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB8966.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:498::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:47:36 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 12:47:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 13:47:35 +0100
Message-Id: <DIMNXSX1MADQ.2FKCD6LOB1SP2@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 04/27] rust: driver core: drop drvdata before devres
 release
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
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-5-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-5-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ade7bcf-fd42-4386-8ab5-08deb5a4cd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|56012099003|18002099003|22082099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info:
	ajyzLDqN185pVN9YK23OGfKfRDBpa7aseeYRJz0+SGVTnULNpfRnaf544PV1g9E2tjJwKH7ahgOePJqx8jY8de24zFhMk7cUBczvBOME0+NXfEYMVQKs9t+3gSLzyPHG9w3xinhCFj9X33f5R+hHAXL6Kk2YAITgWNSJCgtzs/PKpwvRNVm2u9mUqvayrAfUOnN+YqORxzVTrch31DRdVoVPg4NFJMcaq7FLCY694IpkktHUHjocZy37a4/fV/i2lYB7ciFv3Mp1nNumke31F7GJSDrGyvNbyHfjehfTLy6vwPlJPaT7I3vh6rEV3bE1jTG0hNmDIq/FxIZo94RdEvMnN5lba9ke7bHHU8PArxIuVA7eqJgmBVOJ71sZtUIP33mPk9TINWtkGJ7OQfq0JKSR9tIia6zYveFO1z6osRz+IYJWzO0am9InFAWyYHuHXl9hQapkTUUJfRibLxWj7Z/ekoJu7DkmcRctoIsx3/L4DXqpWI5nGMqSWJjZbdhRV8OLBKK3tKmSaYmvCzDiaLwI/tdlwOI0SVLQZHpXarIpennCWiTfkQaL6vGE2eEj5A6/VoTrKKrAvPrViCmtGBS1PVM4oYx1uXxOEmUL+R05vZMT+5y03Y4nKmzhTbI+UbFZurMO7ETBbDlxNZ5832mwq5KOqyWqsY1qLkSSPyMJkPXmUzJiKTEYfiwF6CJTaUUt9+gwpUoCWmQap0IxB4EZZZzhYi4MNFIOdl8dHuc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003)(921020)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDlBMWxXdTVTMTIxcUt0anpzbmpHRlhqb29La010MmZEbVlGZmc2Qm9VMExt?=
 =?utf-8?B?allCeEJaVW5TRXhwa0xxa3RxeFBiUnFzbHNWZGYwMkNudUNyQWtpY1MxSERs?=
 =?utf-8?B?eDBrdnJUS3ZqYlpQOW1LWjQyMWtBdkN1bXFCeWFPak9tMU56ZVRSVUp1YlVw?=
 =?utf-8?B?UjRPaGVxQlYrRlEyRmFZQThDaE9HYmFucW1SWkljL3RTT0tBQU14RTQ5NFA3?=
 =?utf-8?B?QW92MWZIeXJzcVh6c1IvK0ZDcUdTSVcxYXNaMnI5Yi81ZU9pQ3dadzY0WDgr?=
 =?utf-8?B?akpaUVIzQjlKQzIyb1FaT3YwcVo2K0xhblJGak0yZGprUUhxNFkyYTd4b1hW?=
 =?utf-8?B?WGprdDdJaTlXR2lRNXdXclZaVjBMOHIzY2c0Qm90eFZ3S094ZDRxTk9tRU9t?=
 =?utf-8?B?eHZFNTNNQk41bm1zb1VKRWtnVU95MDlobWdVRmlxM0ZjdWRGZ1gwM2pvb0xT?=
 =?utf-8?B?bGFQcTg5M1NNNTVDWDl4cGs4TmFFNndUWEQ3SU8rdU41VU9kSHAvWXI4MHo3?=
 =?utf-8?B?S3BqUmRMOVd4bXB2d0psd3FpTjc1NXhybU00YnliTmJWUkZVam9TRWJLbHJL?=
 =?utf-8?B?QkY2YjVLeG1pblk1bUU4WndqWFZnRTVSU3FWTXVtcnkzU1FwQ3JLcmllSW9k?=
 =?utf-8?B?UHh3UGMra0srVXU2S3ZUbnFwTDNvK3hseFl3NXhsTm9VUVBaM2hpbWFaRzdJ?=
 =?utf-8?B?WHFNUWEvQTRkbG1tUnRwUm9UK09lemdBcFNLbk9DWGlYVWhXM1h0MmRTK1Rj?=
 =?utf-8?B?VDJNNXVtczZBMHgzN0tpeWZUeEl6VnVxdDFjQ1AyQlphdWJxOGR3Z0FtOXNl?=
 =?utf-8?B?SzI3K2pCS0l0QkhKdm41Y2NTNWV6aFVCMU5DOHVGTkxLQW1TeGNrTEMrZHV2?=
 =?utf-8?B?OXRjUHh1N01aTHRNUnk4ZGFBcldBaHVnTUdXSlZnS2VPV1FvVTl3RThEN1pT?=
 =?utf-8?B?eXpyaTFFdHVsYU1BazdzM0g5REpGQ2xRVnFCUE1YYndZN25nQ1o0VEdLL2pJ?=
 =?utf-8?B?cmplaTZiTlpjNi9IVG5jWEtMdWVCRVRWbFZicnhaNVMwTW0wajBMNldaK0dH?=
 =?utf-8?B?LzFJa0RoSFpyekYreDJuYzJjU2t1TUtXOStOZTU5VXJGcHBIS1F4Sm9MZjFR?=
 =?utf-8?B?ZDNhRm8wU2tEWWkzYlBLWHR2TjdTdm14d0FLUFVBd2lQdjF3T1krVHlDSjUz?=
 =?utf-8?B?TWIyM2Z4RElMUkhPZm1tVjNnSmFsTSt6cGtlRkdyN0w3QXA3dDhtR2E5ZzFi?=
 =?utf-8?B?NUZLUzNtQWUvdnBiNHlsY2JUeHZCMWlwc0h4Uk0vYktoT3ZkcGpyVjQrYlpn?=
 =?utf-8?B?eE5hMk9xUFNpMTBzYXVvV0VWM1RDVUxiRmF0NjQ4US93MjFQSUxyVTlpSUpD?=
 =?utf-8?B?ZXpmN1FDd1lLTW1ZVCt0dHZkWGQxcmhCc0hWZVdqRW5xMTBXY28wMG42bzlJ?=
 =?utf-8?B?Qk54RVVCdTB2cUYwL0tHYmtHbTM2QTJlc0pLaktzMy9vUGU3SnVTNlBWRW5k?=
 =?utf-8?B?Mm9lcU0ra3dheVRBclQwbTA2UnA3YXJrVkoyTFg5MDJsKzZyQnp5d3UvWTVH?=
 =?utf-8?B?bkw2NnUvUVgxUERyZ2hsYy9MdmJrMzBycGpVZjZPV1RXUnJKMjhVSFllUndZ?=
 =?utf-8?B?RjEvbkhxNXVFNmZGYTNJKzJESnVzbTlPRnBiR3ByTzkvZ2xDVmNjMnp2dHNI?=
 =?utf-8?B?dGhuYXE4THA5RHRaVzRya0RwaXpFVUJiMHBVSHp6OFRlYThrWk43eU5LY1Az?=
 =?utf-8?B?SnRTSE1PN1gvNzFFalNZWFhyTUdJWWU4NWZuOU5CdE9Pbno4cys3aWpMd25r?=
 =?utf-8?B?NU5RNTlQZ0g5aG8zOHdtUm1RR01WaWduaFJsdi9YM05EcWd2eGpSMjFNQzJW?=
 =?utf-8?B?OEhKUTg0aEdYNHBSeHFkRG92cXBtbm1oZUlBUVk4V29pUXNXOUJiL3dnbGJz?=
 =?utf-8?B?T28vdDdXZ28xT0JnOXBqZWhNSmtFWk82NnBBd1dBb1lxTmxTcVRYUnNWTW52?=
 =?utf-8?B?T2hDczI0Uk04TEN2bWV1emxwQ1hLeEFtVVpQOUdLek1URTRyZlByY1RUNzlU?=
 =?utf-8?B?eWxLQ2V5RGUvQWIrUGFUNVhyc1RLVm1VWXVacHgvcFRlUzNSUTc1cUNnVFZu?=
 =?utf-8?B?UnhtaWdqbGc0Unl4bFVsclJYT1FwUFE3R3MveEswdDZxdTlJMVVhdHB1TWkr?=
 =?utf-8?B?cmVlUUc4VnVDSWFGYmR6cVVVbzFucS9VZEY3NDE4L2xDZy9FNFpENUg0YjJm?=
 =?utf-8?B?Q3ppRkZicHJROGNHTUNjSVNMdHU5SFlWY25zWXo0bTNVcWIwUkN0U3g2b0p1?=
 =?utf-8?B?WVR5UTlxUHBrcnRBb0FuVHdWTkpYbHErZU1SMTByeE90eVc0amVpQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ade7bcf-fd42-4386-8ab5-08deb5a4cd7c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:47:36.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71c9eThv4YUR8YNs3YTNwfxBPw0h/bgryHy38Vwt5H5xYfWARNkJP4+M7QAI7W4AOb07DIXov0CKanhRD1TBHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB8966
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9015-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5648B57F0A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:00 AM BST, Danilo Krummrich wrote:
> Move the post_unbind_rust callback before devres_release_all() in
> device_unbind_cleanup().
>=20
> With drvdata() removed, the driver's bus device private data is only
> accessible by the owning driver itself. It is hence safe to drop the
> driver's bus device private data before devres actions are released.
>=20
> This reordering is the key enabler for Higher-Ranked Lifetime Types
> (HRT) in Rust device drivers -- it allows driver structs to hold direct
> references to devres-managed resources, because the bus device private
> data (and with it all such references) is guaranteed to be dropped while
> the underlying devres resources are still alive.
>=20
> Without this change, devres resources would be freed first, leaving the
> driver's bus device private data with dangling references during its
> destructor.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/base/dd.c             | 2 +-
>  include/linux/device/driver.h | 4 ++--
>  rust/kernel/driver.rs         | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)


