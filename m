Return-Path: <linux-pwm+bounces-9478-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eWcyIkqDQmqH8wkAu9opvQ
	(envelope-from <linux-pwm+bounces-9478-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 16:38:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E96DC23D
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 16:38:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=tqbBWUdj;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9478-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9478-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E751301FFDD
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jun 2026 14:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BCF41B35C;
	Mon, 29 Jun 2026 14:37:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020102.outbound.protection.outlook.com [52.101.196.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B24192EF;
	Mon, 29 Jun 2026 14:37:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743863; cv=fail; b=O/JJ23x1AyzGUVD7Ib+vYDx94azyogKAbFpV8/X2lqoJtebBmr3LQ5QyADsNeeps+xQstx6dHXV1PBcHjiVraw8A0y3ReK7OucbxTDz2vYJAKkE4JbI2plkgnyxyaxbqXMNB8uJ33zxqvL0k1X/ZlZM4/aNwa0MW4xpOt8F3ZQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743863; c=relaxed/simple;
	bh=j4mT2HZYkf+LLSRAm5Vo3lkEWRh7AkIMlRUf8GrtBlo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YMcyicv1qH+aDwZhq+0GI3KXhaSCDMvwD3bhs+jfpTizLyADpoyUXIsfFI8aieCvA+uZwP+JBWPcPm6zIqZso7c+jAMKKrwTaJnggXYjpcZSwR2UbmG8CsMxqWAwIdTWKnqBJIu+a/GYTYoM7d/A+CFRYNDHhCHZYtglW25dtIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=tqbBWUdj; arc=fail smtp.client-ip=52.101.196.102
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfpQLrjnCsss0Y49a4PJzrP6ngLQ3DEKp2TZi36gKAZTgCci0X1BEoVhHpNEudcLq63gAUGYDz3ohVmF528LKQKArvLP1jujYx7TbV2Q4SFmqbifS6ojC1Dlj/lyK9MwU3ZG8/Zv3v4imn6mLusm2m8dMDqMXWUtB1uiQ+2bogvco1JtsfiN+P1Xldpu8RJontSXXcP/2D/FXjQkSThJ9mG561f4erE4PrWpcFAErWeqDpAL1lr2aOyH2nY+s5H0p4hQztfuwESJCUH4M1dLyZZpxJT8te781Pjcs+bIJxf3KHlLcCq8YAjdMyQSf2MZNxQNzxh5ChQ/HUKir5Gq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV7oZKbABRxxMwpZXqVthvBESnI21SFwDJM/ql3zJvw=;
 b=pXL7ZDq0NxmeJqEBQnmqiGAjp/tSFpdj8Jx6NeKlwLwc7/RjnVlMTkoF1mECxg3flT0UXamDYJVgpStEtqUcyzA9yG/7G5G97uQIt9H273zJp4O/s9s5YAj3YIdY/+T7tdnCq+UHCl7hO11EWlXP6bcaE+UveWQIyxqeboasxzOuWcoQrJXByB+McpPS1utIxee8eY+bhArQDozV+gWX5iFSlIl/h9x+ttKazfSAVNFzeOpKc3697rYMGUULPoxdpV8Me5CPIFZBuA2eJUwX8Pryo32ep4gJ5/Dr7uoO8iNuZGqrZSxDZko3Kq07kddkkuPmpMsadC5biNCElcug0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YV7oZKbABRxxMwpZXqVthvBESnI21SFwDJM/ql3zJvw=;
 b=tqbBWUdj5vka7a9zE3S8aiXnqyDJe+nELzeW5EaC9/FgWMUY0Fmve+FBc5/DPRMFUGtuFCvpdxjAJ9jplETJLMRo/YK745zKQ7UNFHQXqOcrFLm+8gKTVwEk8U72pduH53w1kFaGsIqeGc0VhPYfM4hPJdFCuuEYUhMt3sv5/TE=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2662.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Mon, 29 Jun
 2026 14:37:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:37:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 15:37:34 +0100
Message-Id: <DJLLYCLQEBV0.2L6F55OJ8A6B@garyguo.net>
Cc: <david.m.ertman@intel.com>, <iweiny@kernel.org>, <leon@kernel.org>,
 <bjorn3_gh@protonmail.com>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <sergeh@kernel.org>, <matthew.brost@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <jack@suse.cz>, <ljs@kernel.org>,
 <liam@infradead.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
From: "Gary Guo" <gary@garyguo.net>
To: "Trevor Chan" <trev@trevrosa.dev>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <dakr@kernel.org>, <ojeda@kernel.org>,
 <a.hindborg@kernel.org>, <paul@paul-moore.com>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <viro@zeniv.linux.org.uk>,
 <brauner@kernel.org>, <igor.korotin@linux.dev>, <vireshk@kernel.org>,
 <nm@ti.com>, <sboyd@kernel.org>, <m.wilczynski@samsung.com>,
 <boqun@kernel.org>, <gary@garyguo.net>, <axboe@kernel.dk>,
 <daniel.almeida@collabora.com>, <shankari.ak0208@gmail.com>,
 <lyude@redhat.com>, <j@jananu.net>, <lossin@kernel.org>,
 <acourbot@nvidia.com>, <markus.probst@posteo.de>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260628095132.47753-1-trev@trevrosa.dev>
In-Reply-To: <20260628095132.47753-1-trev@trevrosa.dev>
X-ClientProxiedBy: LO4P265CA0123.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2662:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c89eaf7-5e09-4c01-cf62-08ded5ebf5fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003|23010399003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	lfW4LtejC5NkcjQrS2K1vSbpS1pcuHsaPqK5i1eH9LtK2wbCFOGhVTxv7q9bE6LOk9j655n8ggoEoITwmAnao0fxye7284u1HQWHOYMpa8CCnomhFe5ptU0pbIox2yiOXylK8AXRNoSrfv7/7yF/A1B5bbnvmRyRdv6R36hMrBxqrr0I82vHKxgvYkgddXkx6GzDglVHvNghpfOhapPIdjoWyrtbraszhhWkM0Ft895aV6+/Z5z45HTpbRdR6aj9IyborTscsCvavF93tonKUfqe9tSbHMPGFYLBK/9PaTAwnu6/ggVGdjKmJokKmziQs7KfuG22bUKYoWphXoZfTerRhpaKg2c5ZeITyG8EqERBfVrcLxKs66V2k6k1lELdidkovWPVLai/Qhffcibunylfz5o49Aud+BE+vTIgERV5SQ+Xa1zCKUu8pGG7f5FmCXcluaFuXIbk+abpa0uGwYMSZSjqaEiE+HcEzEfOvU1x4Pb0VH67KMwa6kLbtW/zDesvnnuvJ20TjDfCMzZJjHNes3zBBc4Q/PJnlWPXOrBoB02J/vUKja818VzoDwKI10WrLQ4sfB1z/pevlyJw+wiHgd0dha+SAJZXrN5h/V0HPngzZxWkCWVf7XudU9d+V/0sQ/dSUqHehB4r/jOtNe+bdifAoWyj+Cib0YBMaC+qqnF1eXxODXBoKyhc2+wTDH123y93izlTXqRK8xqNrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVRZbGNLTXl0clh5b0ovUTZJREpsTXJLeFRheTBIV2lpZ2t6ZmF2OVY5L1Q0?=
 =?utf-8?B?TjJ6OXRSWVVNMzhpTHlMSWxaY3BFb2tWNzJUMXVuWlgwMWlYM2pzdTNMbkY3?=
 =?utf-8?B?akRZRFdQMEFnQys5Z21HRXkvdS8zUGxTWC9Ody9yeExNZlJ0eCtIdVJLWW9L?=
 =?utf-8?B?c1ZCV2IveHhudk4zSERabjFQdXIzdGhtY1czMC9FTWpBbnhPeXcrem1HN3ZI?=
 =?utf-8?B?Q2F6WStDTmJEMk1YNjBnWXUxaUp0NVRmVU8vSCszYjNPd1phVDhkUjdtcnpw?=
 =?utf-8?B?UmZERmRicTRwWWlyRU9Va1J0bVdnT3IxZmE0NVd4VytSbHZGSWI1Y2RmQTlL?=
 =?utf-8?B?UnFlR2J0ZkhneXc5Uzl0Y2l0ZW5hdVZQcnRrWWw4UWpsOTJ4U3B1cFZNcnlR?=
 =?utf-8?B?dzI5Ky9jTFpWazlUbkQ3bC9yY0FRR2N2aTBtWXBMVHdRbXVLTkcwbU9WWmlo?=
 =?utf-8?B?TkdkOUx0ZTVjbEpYdFVMUm9Da3poQTFud3dvTnV3TVpWZW1YdDdCSzNXa2tO?=
 =?utf-8?B?LzBwcG9DUXNtZ1NkeXdqVExycWZLZkkyaGJ4L3ZSTWV1V3FoT1o2ZGd5UzBw?=
 =?utf-8?B?VFp6eE1NVEhOek1CZ0t0MlR4Z292a2ZtWjN6Rm5KU2ZqSnVDUmZOR3JFNEVI?=
 =?utf-8?B?eXJpWGw2TUx0RENmaUNLbTFESnduQlRlOHlUMSt6b29uTTBmQ1NFa0lnNE02?=
 =?utf-8?B?cFNDOWRJRjdaVnVrcmFQYzJ2YTk4Qk5ZVmczS29yU3ZBNkkxNk5BcXhFZW5k?=
 =?utf-8?B?SzNqSGNiN1QwRDcwOUlwQlBwQ0hpSlB3MU52azBBSHRYTEdNUjBUYVlKWEph?=
 =?utf-8?B?SnJGRXZOZUlOdFFrL3M3Qnl4Vis3Nld3N2hFYndTOFptaEhxZUNweVFaS21u?=
 =?utf-8?B?Y3NDTzNtb0hEaE5TWkVyUDJNdE41Vi9TNzYrdkdqU2x4M0g0UDIzTTVwK3F0?=
 =?utf-8?B?OVlOaTY0dVA1OHkyWVYzUjNmNXcrNTJzSXh4NEZFbWxLK3FxRlI1Q2xoMkkv?=
 =?utf-8?B?eUdlbld6Q2FQdHRjMGF1UzNKajdrdkRJR25yNS8rVkI0djZpTzdNVVdiU2VG?=
 =?utf-8?B?UjVsRHl2OWp5bTk5N3htQkJNUk16NnRDWWdmRHNIWXErbE85aUFUR2RjTU5i?=
 =?utf-8?B?SDNSNWNVK2NrRmtVZEV5ZUtlbUJIbko1WXBsVkNuWUFTN0xPSyt3dzRLdWFK?=
 =?utf-8?B?c3VJOHF4SHRhUXhLYWJyNTFsZ0FwVkVGanVPNVNCeDBXTG5OL2xWUkhuYTZ3?=
 =?utf-8?B?L1VNY1o2Slo0MFRYeC9YVHRKU0RYbkQ2QndEVnZqYjVWc0p5eDMwQTV2Mm9J?=
 =?utf-8?B?L0xPMmxOZklYQWExUjN3QzdRYU5kMmhvWW5WeXQ5aStlLytmUlBPYk1wQ2hm?=
 =?utf-8?B?TUxHdmU2TFdOODQra3lJTmVpb2ZEcVFUcGlsQ3poTTFMWHBiR1d1NnpldzJ5?=
 =?utf-8?B?Z3JPbUh5TC9BRlZwdm5OUG5xRmpkWWNzd21DL3ZWaEViTnh3TDIzVGY1Qzd4?=
 =?utf-8?B?Y0pkZUZwWjlJb2RCekROd2RRR0kyK3NkUkkwZnVFdFp6MFhhUnoxWFRGUnhz?=
 =?utf-8?B?empwWldNVWhZYTVSWjEvU1NoQnRmQjQvRzErMU1mWXdLUVZaaW1seEFpcmY0?=
 =?utf-8?B?aUFPd21TM0xjcFlHVnRjcE9XMnBKa2JlRzFPazBhb1RxWE80V25PTkN4YXFH?=
 =?utf-8?B?R1pLRFpSeUNEbkVzMnlHV2J4QUdYSHpDQmZoRnpGc0F6cUJTMDAyTkJtU0lQ?=
 =?utf-8?B?dWhianA5NTl6WnV1ajZWakpJUEw5VHNCRzdodlhiZU1sSCtPVzU1UjR4RGVT?=
 =?utf-8?B?eVFsUHg4SEMxUWlqd01WZzZJYjdFS1NGV05jZEJzN0ppWUFZaEJHYVBCREFk?=
 =?utf-8?B?U04vTkZBem8yVkcyWmxDWTZ2TFJoOFNrMEN4WFhldEt4aGFWQ0pEeDNNUnRz?=
 =?utf-8?B?UVNLVVdIV3dVRUxmNVlNcklCcWMzemNIWkpHWmlweVlFZWdjYTJONk5INmNW?=
 =?utf-8?B?RUFLWkFIakVrN1JnaEVYcTF2c0t5TGRUSXB5SGFJTURLaFVRdW96THViMm5U?=
 =?utf-8?B?VjNQdUhFSHhlT3lBSUtLcTdVbWQ1eFR4MW54ekR6V0RISTR2YUNkVkU5RWs4?=
 =?utf-8?B?bUF4SVFoNFM1NVVueGVCNnNXR1AyQ2plUXJQNVVWbnBlYTEzTU1iTzdCTys5?=
 =?utf-8?B?S2lQV3JMaDQyZTlvUURmVVhBb3RRdGRpK2ZVb2VTc01TcE5HcFVNV0JFSVJq?=
 =?utf-8?B?Q1hEcTlpaVhwQU9nUkxGaFo3YjNTKzZDVzVEMGlkcFc4ajljYSt0bXZCQmYz?=
 =?utf-8?B?YjZzd2VhRm5DSWlab1ZoSVFhM3pkdUxGbGVMdEVVbFRzOTdzQUM1dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c89eaf7-5e09-4c01-cf62-08ded5ebf5fe
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:37:35.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvHVrIKuuKEsO9lOZwHVhmz87YIOzMTcCr0HOXMSvWCP0EpcNCwWzsmCYhrSA7sxBt/kbrQGtt7mcGJ1ttb1sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2662
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9478-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:david.m.ertman@intel.com,m:iweiny@kernel.org,m:leon@kernel.org,m:bjorn3_gh@protonmail.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:sergeh@kernel.org,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:jack@suse.cz,m:ljs@kernel.org,m:liam@infradead.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:trev@trevrosa.dev,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:ojeda@kernel.org,m:a.hindborg@kernel.org,m:paul@paul-moore.com,m:aliceryhl@google.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:m.wilczynski@samsung.com,m:boqun@kernel.org,m:gary@garyguo.net,m:axboe@kernel.dk,m:daniel.almeida@collabora.com,m:shankari.ak0208@gmail.com,m:lyude@redhat.com,m:j@jananu.net,m:lossin@kernel.org,m:acourbot@nvidia.com,m:markus.probst@posteo.de,m:driver-core@lists.linux.dev,
 m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:shankariak0208@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[trevrosa.dev,linuxfoundation.org,kernel.org,paul-moore.com,google.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,linux.dev,ti.com,samsung.com,garyguo.net,kernel.dk,collabora.com,redhat.com,jananu.net,nvidia.com,posteo.de,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,protonmail.com,umich.edu,onurozkan.dev,linux.intel.com,suse.cz,infradead.org,google.com,virtuozzo.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCPT_COUNT_GT_50(0.00)[54];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,trevrosa.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 179E96DC23D

On Sun Jun 28, 2026 at 10:51 AM BST, Trevor Chan wrote:
> `AlwaysRefCounted::inc_ref` is a function that shouldn't be called lightl=
y.
>=20
> To prevent accidentally calling it, change `inc_ref` to be an associated =
function.
>=20
> Modify all `AlwaysRefCounted` implementors to work with this change.
>=20
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1177
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Trevor Chan <trev@trevrosa.dev>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> Changes in v2:
>  - Don't word wrap the patch
> Changes in v3:
>  - Make argument name of `Empty::inc_ref` consistent with `Empty::dec_ref=
`
> Changes in v4:
>  - Rebase to new rust-next, change new implementors
>  - Reword explanation for change in `AlwaysRefCounted::inc_ref` doc comme=
nt
> Changes in v5:
>  - Change commit message to be imperative
> Changes in v6:
>  - Change all the implementors
> ---
>  rust/kernel/auxiliary.rs        |  4 ++--
>  rust/kernel/block/mq/request.rs |  4 ++--
>  rust/kernel/cred.rs             |  4 ++--
>  rust/kernel/device.rs           |  4 ++--
>  rust/kernel/device/property.rs  |  4 ++--
>  rust/kernel/drm/device.rs       |  4 ++--
>  rust/kernel/drm/gem/mod.rs      |  4 ++--
>  rust/kernel/drm/gpuvm/mod.rs    |  4 ++--
>  rust/kernel/drm/gpuvm/vm_bo.rs  |  4 ++--
>  rust/kernel/fs/file.rs          |  8 ++++----
>  rust/kernel/i2c.rs              |  8 ++++----
>  rust/kernel/mm.rs               |  8 ++++----
>  rust/kernel/mm/mmput_async.rs   |  4 ++--
>  rust/kernel/opp.rs              |  4 ++--
>  rust/kernel/pci.rs              |  4 ++--
>  rust/kernel/pid_namespace.rs    |  4 ++--
>  rust/kernel/platform.rs         |  4 ++--
>  rust/kernel/pwm.rs              |  2 +-
>  rust/kernel/sync/aref.rs        | 11 +++++++----
>  rust/kernel/task.rs             |  4 ++--
>  rust/kernel/usb.rs              |  8 ++++----
>  21 files changed, 54 insertions(+), 51 deletions(-)


