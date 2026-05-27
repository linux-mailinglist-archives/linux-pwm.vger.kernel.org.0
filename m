Return-Path: <linux-pwm+bounces-9180-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNwtFWP4FmrUywcAu9opvQ
	(envelope-from <linux-pwm+bounces-9180-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:57:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC25E56DF
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C69453014C40
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4464C3DD531;
	Wed, 27 May 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ENeD3CeP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451163D3337;
	Wed, 27 May 2026 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890120; cv=fail; b=OVpBg7XgDF1BS9vjcb6fbhAO258RJ8T0Dth3rNhhwYlyDcStLgz3iW1Bd7Bmec3iNAV34h2U/K6lC54buTADHKA39e0CX6tLH3rmccSbJc1fKEy8/SSBbrZkf5Rx7MMvTFc8s6G59pu+s5NheFRt+84kZj7O8sILxOB3BwygzF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890120; c=relaxed/simple;
	bh=2Nky9SNyaE7SF2VKhj4glq0lKMaADJYyFaeqv87tVeo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=MAaR0SdvEICamtVh0tRatFJrZOn5N5PWEl3cjo/y99TyUY/InB2tJS5XpUfbta5gBHn6UwYLxC0/Y2Uy2IRP7wVnYawb3RdcDeszsCcLfdJxI0WZnqqdPwtE5B3YfPYhSx2LVleAgToKeRM3YOgTrB5v63hYXBF7fT0RvdG2nlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ENeD3CeP; arc=fail smtp.client-ip=52.101.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5WLpgQis7Bre43lQpj8Jg21+YdFTK3TCEmm/RTI3gzQ7a/wK8B2KXoWUoVYCbmKUVdk2+92yxzNr7p7l6d+M/1N8B72xbDSPuCPkJtLTvijpvb3ae7V0WMrr2CfoDBThtIloQsabkf7ZxY9a6d2gvMAiuGiE7d/HFg01aKmS/jVefDXr2xryYP0FGIE2Mp69nAcgcpNr/1EMzfj/z8ARiHolwNaS8LQOPvwL9cSszdr9M1OypPFQyJ81Tx76ez9DK0aSqVkUMgH03aJhxsTrZ7joD2iZm2o9QoM6KPUKeVHmmaPmZDkTo4FcUfsjS9B7rgeEOm3HNNXnSw504mJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCXnzWGnQaS5keQreaekkqdBAGkV91jRZfNfegEyROc=;
 b=u7QxNly0pjUaS0j+C6i1wzOqTD+L4Oovh0RsV/8l/KM92tMT5XCvciznwHXb94yyreI/m5d9sdaCnDYNPj1K0I6v1DAXpVzmFGhc5jVe0CH+cilVgoaqzbfnu4OQobEMOyP79dJgqO2sfuGA4DdyZ8AX9+DGKc83F0oupDtctA5uLgkP7SjDfUtZg1AYahJSYxXzmtBALEkk+TXIRzahNAb3+AGoDHKBnzdE8IAUJIi+psRMtQwuAWMdHHeVLz+uTMF0nqIiEK7FiCRZCYYmDmDC6nThNRD6IEifzKu8Pv305kdSjzxaZjlW0jNZHX+UM67nV3Meep/l79tUZaRP4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCXnzWGnQaS5keQreaekkqdBAGkV91jRZfNfegEyROc=;
 b=ENeD3CePsXjsUl6WOdK4AgM3flf18QpqGEVsr3bZHgy1wI/ircuJPkkpKCbRWThbBLHJX5FJXrSvXw21x81SoftEV1iCQBGMSXrg6IfWC2CgjxfQ8xrVOEFUSqMweh035HhwLNK+5UhW6S+9dQO0m85euixB5Pze83lJv56yqZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7358.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:55:14 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:55:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:55:12 +0100
Message-Id: <DITIDXOEZ54S.2PU9VU9UGTSZP@garyguo.net>
Subject: Re: [PATCH v5 23/24] rust: auxiliary: generalize Registration over
 ForLt
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
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-24-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-24-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 412ea84f-4a13-4709-f794-08debbf79388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|7416014|1800799024|921020|6133799003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MZmvuZ8wePepvsKimDN5DQ0GtCc2ANK1woyEvWKmo751KHoz+zuLOPYDgBgATJTl8tHN8aPAnUjsurEkjmv/RAZ93LorwxF/kuZVEPmAsXdUd9EPxXZR4IyLeobO+eepELCmkS6lHDIvIDXcUX7ngVe6PdQat/O81gfwcTaNucUVZau/a5O4RmHs6uWB6n+gxrQrAGyDxIxA37NLvBSn38r1slaKcrbS7CNx/9PIwmfOQmsQEH1DM7G2IYFqhKM5XdtDUvW4LLPRlUdGCnzPKBgOqSyiibU7ONhpL7gFhNDSVj/eKg1K0x4NRMuBgHolGr+pAW91qLqWQtKiOHSO7G68/cv42FsVZtMfrDGegDE2CKdrb5VA5bfg4PWw0UDXHJGD0/o6QLP3bM8BMScX+xJ1zFzUll/2c7W8nYopsRJMRUynNUxAIsI4JPwc7Q8SGCboLzdSb48C9vXan2nd0zqgQNDNkPtV7G1ya+lXZHVlRxSpEax23quOQJrEBrqZcOiAgDUrSKRgJOKa1yV0mRQ5c7XdlhaW1DUOoOmfT3vVcBS0rd7evq3J0DWXg/yG+xDTkp888+RHAeoK02F4ap08OAyq35k2s55chs162u2kCeaoUmrfv0Mpfgjh9zPZEY2saT82ZVSaxny5fi6fjTH9wcbkeNElFbI/1oPc9t6LxUjMbb8HsFBdEczOnevx1Dx9EqS5NWG8lcoH+zgR7LOhvpYljMZe5euJjnXi+p0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(7416014)(1800799024)(921020)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkZ4NnBJWVNDR3kzRldqYkVUcEpyUk1FQXBraDVidng4L1VqMXJxZHFiVVlL?=
 =?utf-8?B?QWRzS0dzNStkTk9hUzhHd0FVZitaaVQ1QnFsTzliUU95ZVFFOGNlQ2RvS2ZG?=
 =?utf-8?B?RGxvVDJCUGsrVWE0TXMyeVdwbVczb1cwN2tYbk03eGFMdklHV2FrRDVjeVVJ?=
 =?utf-8?B?bXRSL3RqclViT2dibW81STBFbWZuTlB3M01HOGhKSGU4QlFxdkkxOVFybEo1?=
 =?utf-8?B?TWhiRVV6cGlIazJzbHRNOFN0b2hqbkpwQWNjSjhFMzFUYktveFYrTlFXNmRL?=
 =?utf-8?B?bkt3UkJDenVVZmVad0JEWVYwU0lzb1dWNDdPVFNhRGFtV2FxOTlmSUhTWlpG?=
 =?utf-8?B?VUlFNE1HV2ZGUzI5V0VFdm05QnRha293NnQrLzRKcDRDV1dGU0Z2aUF1SDRh?=
 =?utf-8?B?dmxQbDh2VXg0NURBQk5HNy94UXcvRlo4M2trdmhBblZ0WVkyajJGRXVNWTFH?=
 =?utf-8?B?NmRkaklWOFpBZEM1VEJUdEF3OW81cm5QZEE1Y3FTRzgxM242MTB0WExoTmFu?=
 =?utf-8?B?aGJYN1AzRjZIMVNGcGJKVmRpWFlqWUhWNWdhSFNCRkRnQ0IzQzFwZFZTelNH?=
 =?utf-8?B?bUVibXFjWjFPSFFKMEFlcW9SUDIrckFEY01xcGJuV2hrRkdIdDBkZ3lxVTJj?=
 =?utf-8?B?Y0xHVjM5RmlvTDJidU5yTzJNQ0FXUm5kR01Rc2FpR1pnai9BMDZONXNoRXR6?=
 =?utf-8?B?YTVxOCt3SmNrMWI1blhTd2V0aVgrbk11b0ExUUxKZHBib1JVRkc3L3EwTVlh?=
 =?utf-8?B?T0I5cytnbGZPaVJFVkVaU1I3ZGFBTklGNVdwR2EzZ2IzeGlUdW5UeDlJcnJn?=
 =?utf-8?B?cVNSVGFkSGZKNlRzZU5FNWI0Q0JUNjJJT1lTWFg5QkVqQzB4UDhNa0ZtN0xI?=
 =?utf-8?B?YVJYVmtZVGhlcXdCRml6ZGgrb0lLRXZXRnU4TG9FZ0R2TTRCTVhxejFXeVFx?=
 =?utf-8?B?Q1BTRFpnWEI2eDlYbG9mU252RGJ6WndzcWl3ZGlsbjMvMmQwY1RLUHBmYVJ6?=
 =?utf-8?B?TEkyU1MyczQxUzVoQkhmNGRuend6Q3Y5cDF3cHJRZFNqd0FnbXB6ZEJnNXRw?=
 =?utf-8?B?M1c0RGdsaU1kL0MwcVBPeEs0djlHRFAxRTFRbFdsYlQwY1lBdTJnc2tRUEJy?=
 =?utf-8?B?ck5YOS95MjZqdUJZMDBER05veGl3WFNObTNsa09LdUxzTDV4bWFQRDFzUWtr?=
 =?utf-8?B?YnpGMU9GNHF3eEFLc0hCYytJeFM4Y0J1b2hRdnNDd0FpUk1yR0VFdEhMZHNy?=
 =?utf-8?B?WE1sdXRiQkkrWERvcGJ6M2VMMCtRSzNSTXptcGlFOXoxWUgzVUdCNTNmUDFT?=
 =?utf-8?B?dTNqNlF6a3J1ZUw3MkNscmFCTWRNVDVCcWZranBvUW92MjBCTlMvMk80U0Iz?=
 =?utf-8?B?MGRwUnpwV3VzZm9iNmNvRXl4Z0JIcGZLV0FmMlA0M0JLNVJQODlGSHN4UnNy?=
 =?utf-8?B?TjZ3cC9HaTBJckZWMHlLU24vQUlMenZ5TDQzVkJMVDlVeFo1Q0lOUG5oOWZp?=
 =?utf-8?B?UlhZMTVnYUlmWXp4TW92aGxIYjJWenZXS25Db0laSmdMUHV5N21pMWlleVBW?=
 =?utf-8?B?bThEbUhIVDdvUnM4Z3JOWWwzbDdWdS90TWtEbExvYjBEY3NLOTgvTzJtd3Fj?=
 =?utf-8?B?U0N2UDE5bElxell6TGZLdGxCaHZqTVVIdFRxaFNpVmZBbzIzSnpORUNDcVFn?=
 =?utf-8?B?VGQ3OCs3NEk1Uldkd2ZyT1h0Y2FIQnVPZjVjVGNaVFg0V3B6cUl2bEtLSXY2?=
 =?utf-8?B?RDRZY1pkTncxMWtGWVZZemNHYzNKajFmNnJnUjZZdkVMMzV6Z0x3N3hLTjhU?=
 =?utf-8?B?ZkFia2YrM3dtbDdabGZVYzE3VFZBWFdBNXJwM1Z4MlNiVXZ1VHIxTlRpUUc1?=
 =?utf-8?B?S0ZnakdvdUVmV200dnlzcGhWcW9uVkxhNGUrWVVQMlJTT1BJWDNoT3l0SjRM?=
 =?utf-8?B?RklVT0dnQjhLN0hiaFNBSlNqa2QyaEJBdjJjSjdBakN1RmdsMVZEdlczMncv?=
 =?utf-8?B?TFI4MFd5ODhuZk9oOWxGaThuQ0dPRFc3NG1ZK0QwcUcxZEdnbkx4a09nOERh?=
 =?utf-8?B?cHp0cGE1b25DQlRRbnFJTUdNWEhVT2xmNXFvTFF1R0p5Y0VlR041YnNlUGo3?=
 =?utf-8?B?ZHdBU0d1d3hrMldNckVyRDVOOWhoR2JvOXZOcFdSRFJOZzVFT1BTUXR0Qzha?=
 =?utf-8?B?VGVKM3BLdU4vY1E5VVRLcTlsd3BzQW9GZXVtRkQ3Z01senkyc0J3YlZUY0R6?=
 =?utf-8?B?NUhvbitZcVlYWUdrbmQ2UDhyZTdac0RaaXB0eE1qTVlaUWRJRkYwcmhrL21j?=
 =?utf-8?B?UnRYVnJCN1JRUDVlb0RLYm5rUUwvTjVuNkVobWhrbDJLeU9Td3RIUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 412ea84f-4a13-4709-f794-08debbf79388
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:55:14.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaEjOSDe5vWE6MicTvYFRH5iARDK0X5AG2qcGedCz2d9CruaUqGpxmtPlxi7aeHO8XxUOPaj13T0MVOqHrAfzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7358
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9180-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,forlt:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: BDCC25E56DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Generalize Registration<T> to Registration<F: ForLt> and
> Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.
>
> The stored 'static lifetime is shortened to the borrow lifetime of &self
> via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs       |  13 ++--
>  rust/kernel/auxiliary.rs              | 108 +++++++++++++++++++-------
>  samples/rust/rust_driver_auxiliary.rs |  19 +++--
>  3 files changed, 96 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index fa898fe5c893..d3f2245ba2e0 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -3,7 +3,6 @@
>  use kernel::{
>      auxiliary,
>      device::Core,
> -    devres::Devres,
>      dma::Device,
>      dma::DmaMask,
>      pci,
> @@ -21,6 +20,7 @@
>          },
>          Arc,
>      },
> +    types::ForLt,
>  };
> =20
>  use crate::gpu::Gpu;
> @@ -29,10 +29,11 @@
>  static AUXILIARY_ID_COUNTER: Atomic<u32> =3D Atomic::new(0);
> =20
>  #[pin_data]
> -pub(crate) struct NovaCore {
> +pub(crate) struct NovaCore<'bound> {
>      #[pin]
>      pub(crate) gpu: Gpu,
> -    _reg: Devres<auxiliary::Registration<()>>,
> +    #[allow(clippy::type_complexity)]
> +    _reg: auxiliary::Registration<'bound, ForLt!(())>,
>  }
> =20
>  pub(crate) struct NovaCoreDriver;
> @@ -76,13 +77,13 @@ pub(crate) struct NovaCore {
> =20
>  impl pci::Driver for NovaCoreDriver {
>      type IdInfo =3D ();
> -    type Data<'bound> =3D NovaCore;
> +    type Data<'bound> =3D NovaCore<'bound>;
>      const ID_TABLE: pci::IdTable<Self::IdInfo> =3D &PCI_TABLE;
> =20
>      fn probe<'bound>(
>          pdev: &'bound pci::Device<Core<'_>>,
>          _info: &'bound Self::IdInfo,
> -    ) -> impl PinInit<NovaCore, Error> + 'bound {
> +    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>          pin_init::pin_init_scope(move || {
>              dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
> =20
> @@ -115,7 +116,7 @@ fn probe<'bound>(
>          })
>      }
> =20
> -    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&No=
vaCore>) {
> +    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Se=
lf::Data<'bound>>) {
>          this.gpu.unbind(pdev.as_ref());
>      }
>  }
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 7a1b1a7b7ca6..75ddb0220748 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -12,7 +12,7 @@
>          RawDeviceId,
>          RawDeviceIdIndex, //
>      },
> -    devres::Devres,
> +
>      driver,
>      error::{
>          from_result,
> @@ -20,6 +20,7 @@
>      },
>      prelude::*,
>      types::{
> +        ForLt,
>          ForeignOwnable,
>          Opaque, //
>      },
> @@ -271,12 +272,16 @@ pub fn parent(&self) -> &device::Device<device::Bou=
nd> {
> =20
>      /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
>      ///
> -    /// Returns [`EINVAL`] if `T` does not match the type used by the pa=
rent driver when calling
> +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The=
 returned
> +    /// reference has its lifetime shortened from `'static` to `&self`'s=
 borrow lifetime via
> +    /// [`ForLt::cast_ref`].
> +    ///
> +    /// Returns [`EINVAL`] if `F` does not match the type used by the pa=
rent driver when calling
>      /// [`Registration::new()`].
>      ///
>      /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
>      /// registered by a C driver.
> -    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
> +    pub fn registration_data<F: ForLt + 'static>(&self) -> Result<Pin<&F=
::Of<'_>>> {
>          // SAFETY: By the type invariant, `self.as_raw()` is a valid `st=
ruct auxiliary_device`.
>          let ptr =3D unsafe { (*self.as_raw()).registration_data_rust };
>          if ptr.is_null() {
> @@ -289,18 +294,23 @@ pub fn registration_data<T: 'static>(&self) -> Resu=
lt<Pin<&T>> {
> =20
>          // SAFETY: `ptr` is non-null and was set via `into_foreign()` in=
 `Registration::new()`;
>          // `RegistrationData` is `#[repr(C)]` with `type_id` at offset 0=
, so reading a `TypeId`
> -        // at the start of the allocation is valid regardless of `T`.
> +        // at the start of the allocation is valid regardless of `F`.
>          let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
> -        if type_id !=3D TypeId::of::<T>() {
> +        if type_id !=3D TypeId::of::<F>() {
>              return Err(EINVAL);
>          }
> =20
> -        // SAFETY: The `TypeId` check above confirms that the stored typ=
e is `T`; `ptr` remains
> -        // valid until `Registration::drop()` calls `from_foreign()`.
> -        let wrapper =3D unsafe { Pin::<KBox<RegistrationData<T>>>::borro=
w(ptr) };
> +        // SAFETY: The `TypeId` check above confirms that the stored typ=
e matches
> +        // `F::Of<'static>`; `ptr` remains valid until `Registration::dr=
op()` calls
> +        // `from_foreign()`.
> +        let wrapper =3D unsafe { Pin::<KBox<RegistrationData<F::Of<'stat=
ic>>>>::borrow(ptr) };
> =20
>          // SAFETY: `data` is a structurally pinned field of `Registratio=
nData`.
> -        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
> +        let pinned: Pin<&F::Of<'static>> =3D unsafe { wrapper.map_unchec=
ked(|w| &w.data) };

I think `'_` is sufficient here?

> +
> +        // SAFETY: The data was pinned when stored; `cast_ref` only shor=
tens
> +        // the lifetime, so the pinning guarantee is preserved.
> +        Ok(unsafe { Pin::new_unchecked(F::cast_ref(pinned.get_ref())) })
>      }
>  }
> =20
> @@ -389,43 +399,61 @@ struct RegistrationData<T> {
>  /// This type represents the registration of a [`struct auxiliary_device=
`]. When its parent device
>  /// is unbound, the corresponding auxiliary device will be unregistered =
from the system.
>  ///
> -/// The type parameter `T` is the type of the registration data owned by=
 the registering (parent)
> -/// driver. It can be accessed by the auxiliary driver through
> -/// [`Device::registration_data()`].
> +/// The type parameter `F` is a [`ForLt`](trait@ForLt) encoding of the r=
egistration
> +/// data type. For non-lifetime-parameterized types, use [`ForLt!(T)`](m=
acro@ForLt).
> +/// The data can be accessed by the auxiliary driver through [`Device::r=
egistration_data()`].
>  ///
>  /// # Invariants
>  ///
>  /// `self.adev` always holds a valid pointer to an initialized and regis=
tered
>  /// [`struct auxiliary_device`] whose `registration_data_rust` field poi=
nts to a
> -/// valid `Pin<KBox<RegistrationData<T>>>`.
> -pub struct Registration<T: 'static> {
> +/// valid `Pin<KBox<RegistrationData<F::Of<'static>>>>`.
> +pub struct Registration<'a, F: ForLt + 'static> {
>      adev: NonNull<bindings::auxiliary_device>,
> -    _data: PhantomData<T>,
> +    #[allow(clippy::type_complexity)]

Is this acutally needed?

> +    _phantom: PhantomData<(fn(&'a ()) -> &'a (), F)>,

Could you update this to `PhantomData<F::Of<'a>>` please? It matches better
what's is actually being stored.

'a also does not actually need to be invariant here if `F::Of` is covariant
(which currently `ForLt` guarantees). (Although, lifetimes will still be
invariant as it's used in assoc type by changing to `F::Of<'a>`). Variance =
of
`'a` is not what matters here; the covariance of `F::Of` is load-bearing pa=
rt
for the `registration_data` method, and the !Leak requirement is the
load-bearing part for UAF protection.

Feel free to add my R-b with the change.

Best,
Gary

>  }
> =20
> -impl<T: Send + Sync + 'static> Registration<T> {
> +impl<'a, F: ForLt> Registration<'a, F>
> +where
> +    for<'b> F::Of<'b>: Send + Sync,
> +{
>      /// Create and register a new auxiliary device with the given regist=
ration data.
>      ///
>      /// The `data` is owned by the registration and can be accessed thro=
ugh the auxiliary device
>      /// via [`Device::registration_data()`].
> -    pub fn new<E>(
> -        parent: &device::Device<device::Bound>,
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must not `mem::forget()` the returned [`Registration`=
] or otherwise prevent its
> +    /// [`Drop`] implementation from running, since the registration dat=
a may contain borrowed
> +    /// references that become invalid after `'a` ends.
> +    ///
> +    /// If the registration data is `'static`, use the safe [`Registrati=
on::new()`] instead.
> +    pub unsafe fn new_with_lt<E>(
> +        parent: &'a device::Device<device::Bound>,
>          name: &CStr,
>          id: u32,
>          modname: &CStr,
> -        data: impl PinInit<T, E>,
> -    ) -> Result<Devres<Self>>
> +        data: impl PinInit<F::Of<'a>, E>,
> +    ) -> Result<Self>
>      where
>          Error: From<E>,
>      {
>          let data =3D KBox::pin_init::<Error>(
>              try_pin_init!(RegistrationData {
> -                type_id: TypeId::of::<T>(),
> +                type_id: TypeId::of::<F>(),
>                  data <- data,
>              }),
>              GFP_KERNEL,
>          )?;
> =20
> +        // SAFETY: `'a` is invariant (via `Registration`'s `PhantomData`=
). Lifetimes do not
> +        // affect layout, so RegistrationData<F::Of<'a>> and Registratio=
nData<F::Of<'static>>
> +        // have identical representation.
> +        let data: Pin<KBox<RegistrationData<F::Of<'static>>>> =3D
> +            unsafe { core::mem::transmute(data) };
> +
>          let boxed: KBox<Opaque<bindings::auxiliary_device>> =3D KBox::ze=
roed(GFP_KERNEL)?;
>          let adev =3D boxed.get();
> =20
> @@ -455,7 +483,9 @@ pub fn new<E>(
>          if ret !=3D 0 {
>              // SAFETY: `registration_data` was set above via `into_forei=
gn()`.
>              drop(unsafe {
> -                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).r=
egistration_data_rust)
> +                Pin::<KBox<RegistrationData<F::Of<'static>>>>::from_fore=
ign(
> +                    (*adev).registration_data_rust,
> +                )If it's un
>              });
> =20
>              // SAFETY: `adev` is guaranteed to be a valid pointer to a
> @@ -467,18 +497,36 @@ pub fn new<E>(
> =20
>          // INVARIANT: The device will remain registered until `auxiliary=
_device_delete()` is
>          // called, which happens in `Self::drop()`.
> -        let reg =3D Self {
> +        Ok(Self {
>              // SAFETY: `adev` is guaranteed to be non-null, since the `K=
Box` was allocated
>              // successfully.
>              adev: unsafe { NonNull::new_unchecked(adev) },
> -            _data: PhantomData,
> -        };
> +            _phantom: PhantomData,
> +        })
> +    }
> =20
> -        Devres::new::<core::convert::Infallible>(parent, reg)
> +    /// Create and register a new auxiliary device with `'static` regist=
ration data.
> +    ///
> +    /// Safe variant of [`Registration::new_with_lt()`] for registration=
 data that does not contain
> +    /// borrowed references.
> +    pub fn new<E>(
> +        parent: &'a device::Device<device::Bound>,
> +        name: &CStr,
> +        id: u32,
> +        modname: &CStr,
> +        data: impl PinInit<F::Of<'a>, E>,
> +    ) -> Result<Self>
> +    where
> +        F::Of<'a>: 'static,
> +        Error: From<E>,
> +    {
> +        // SAFETY: `F::Of<'a>: 'static` guarantees the data contains no =
borrowed references,
> +        // so forgetting the `Registration` cannot cause use-after-free.
> +        unsafe { Self::new_with_lt(parent, name, id, modname, data) }
>      }
>  }


