Return-Path: <linux-pwm+bounces-9172-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOkzLtfxFmpcxwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9172-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:29:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F725E4F99
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97CA230C40F1
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029940B6DF;
	Wed, 27 May 2026 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="CM8YV54e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021134.outbound.protection.outlook.com [52.101.95.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1D30F80C;
	Wed, 27 May 2026 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888204; cv=fail; b=dmHoR8v6/E3eAFxJS3stpFKxFoDZGktCldIVJIQqi7um6MScIETC2WMU7+34rRWAu6RGJYS/mehZD/6H/SXC9EMN0XeFLiedJ3KdROJEYYT4Rl5yUuHJqzsQ02dn4WE7xhy7OEhmZ9qErpy6iuCG4Z48cIDKPFFdRlLHr8uwRPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888204; c=relaxed/simple;
	bh=SdbEQoxyrK6hP4HDn2+PPnhWu3fZ2VQ/A0toRDxSArI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KVJKctohjZStNROD//+3vpi95h5/mKFEYKLwddvCB7p8AweC7JjEEz2IxNgRa35ZFPjQRZ2Ct0WXK8TCwaTivU0ptQb08o13romzEcE7ztNUsdgiBw22BVuEBkF/7c1jErmwflTbVrE4Y7h0ZZbL+m0rvBxnDSjw/JzPY4qPrQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=CM8YV54e; arc=fail smtp.client-ip=52.101.95.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1cws7IMGdXi9P9rUQU9//4INlfUE+Nk3xf/rzOy52sqD6sv294tK0WDjcIdHpfITR3S1YKqxB7gAW6nZvcaprXCJHs3AjVJJ0dxvxzP+yzWp3g1v9ilvdBGPoW5yWk7TUH36aoKI9lD+BjjlQ8SY5D57V6jhX7PByphjXUb2eTp4gknDEAVmcdC/YSHxQMkaw7f9pUMJSunJqHoouWIMmOq805TD8C1lGvjgOtVSbVxZxQLgyMj6gB0L2jIzUIVYKWHgLsS/OtVYzoKPEmwdpITnCd8ZZ0DUgAanyKooPHCmONicuhzUT1ahRvDT5IWuz7lRfLcpqr8XhQb4lOb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKQx/7mfK+0LabQS3Ze1UBKKCgO8G8ALsPnOSpCv9T4=;
 b=OPVv25Og/CzRkQjXbFDUg/aC8F5P2ejL9hM78vnbjACm22l1stZ7cAYquryxCornLmOKj9kcUvy+XSOhIR/diJZyKAJaN7u0gLEJggzexc6kyVdWMpCTsV2XnODKOIB7iz+GNBuzrTNxoY/3P7ZoibA6H3XtWzjp/eziMw+IrM0JkmqC8RcwTc7RZx4voJ9f8fh/+CoB8gBxYMgQPiXVLKEU5hE673CKhu6AdKHcb+aCCswqydXxtZfStNqwGARYaKWn/RENI3vWmbveZEFTbAseyGJZfWuLMIpE6kB+ZfVAVVM5AmPsws3E8WaSGPN/yg9d2BRcIyxr0kZBuElNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mKQx/7mfK+0LabQS3Ze1UBKKCgO8G8ALsPnOSpCv9T4=;
 b=CM8YV54eqxDOAzcMs3+0SlE7rXYuqDAZu00zECqaLtS4QGt801Vp1OoEL0nchHJw3iqvi8FjWgV/Akc941oKPvyPJ+2wVsJ7oqMeM/0dQUegvAlf1uluZzRtsjG+i+eKdcSvyiWKfFcFmUbGk3JPeFIw9bMK1yj/I4ZJr7g8o0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5673.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:23:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:23:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:23:16 +0100
Message-Id: <DITHPHK8WS4B.17ZUFK4LNN5JT@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v5 16/24] rust: i2c: make Driver trait
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
 <20260525202921.124698-17-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-17-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 65de8bd2-b67c-42bf-56d8-08debbf31d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|22082099003|18002099003|921020|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+gcSBWF9QezrjOPgL2PpYo6edsM6DI7/e+F8+c8phT4+DiMrfhlQ32y+6y+vDnQN6HDWjeuT09MAKoPQgbHc5+mZ2YonerZ7ETyhi42dKCW6YAQY90KpRpfKk7IUSLw/tMU0jov65o+rWfhdZb64UmkEuUA7G/saXN6kgCThkd9R5NjMQ9nDYGNDgFD3Hfm5Za0V7jpADYy58vCkqS0y/Fg99KHBSw2/xHvkWrGUT4WaxQHVLnQw+jQHkFajLzEH9UVbfBZjJOvM4XAJxGPg/d3jp6o51GBKvSKMW8QvwoGLY0dZol3+7jy8948ow/SaBJd9QAxJkupr2QIghzZPDwdYZsNDMfE3YWfELRIKSczwdiIAvF6rsxVZUT1kyxK42hHAcME0jUMGjwFS03itx5adJ/lrzonuhrli8ghHcoq9jZRUutRyhmiSyuD8upB/s58YIFHpijmqGNJPueOovxbXdzDXffAp2KSu2oWUpdBbLaD5vfRJOlZYLrvwrGW9PYdT2qUFmKXxlRubgZw0Q9pX+b3BZlQS9NWOI3dckkg20k2BDzSEDq6K6bgeI/6ku5sbzCufa1x9ciiO0FIy/nAnVArkuiTmKHJUv6X3W8aq7VubpUi2pCSJrEgRhh8weN7qkw/Uc9aKeibi8qFEfvAbGEHN7o/OCBZWUeTzlP1sN1Jx6lg/NNTldwCTq4gGLy4L0lzZdhgaO7a5tERTyaGIbI4FIHn/HLhWhJcTmRg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(921020)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFWNG5wa1RycDVMR05zV0xNalZ4Um5IbTkyQWFqMitoZkhEYXVnQ3FaZERK?=
 =?utf-8?B?Y2Q1L2VhOExjeHR1bzJQQVZHRm9LZU0zMEE4RXVKK2lER0dYTXFUMXJCeVls?=
 =?utf-8?B?cis2YkZoc05ZV2dyOFh2YmZQckx3VWZ4eUZjak5wUHMrVlNoL0d4SGFXOGFs?=
 =?utf-8?B?MWl2d2RvUHJyOXFBa05DczZmQU5xQy85RDFCMmR4Wi9jNHVqNERnc0V5MHI2?=
 =?utf-8?B?T1dIVHFVVDkvNG9Qbi9QY0NOVVpvUi9USTdqYkx0OE9PWU9LNUVLTHZJQ2h3?=
 =?utf-8?B?VjE4MC9pdGdtR1BsNGMyTzQxSlZNQlMyQVhqU2Z6RWdrQVdhNFM4VUFDcTZu?=
 =?utf-8?B?alVhUWU2UGdUN2xoSnJEblJXSmMyNlpxdmpRM05XOU1tNENhQklBYWMxRFJi?=
 =?utf-8?B?Tncydlhxb0tzK0dHNUtMbnMrR1hkT2luY1E3M2VlUzZlR2NnaVlhZVNGSk5R?=
 =?utf-8?B?WWtHVXZOZTJNQUZrcFQ2QktFZTJsZDBzSnR2UU52ZSsyZnE0SGlseGsveFkw?=
 =?utf-8?B?YXRhb1NaVXJGOW9tSG8yMTdRVTNwZEYrbE9taFo4SjdDNXNxTHo2cFJTMHlS?=
 =?utf-8?B?bkEzNC8vdVBzTEJGdVYwc0wyWWxJZ0MvblZDTGlLOVFJV3luSGpVc294Z1h0?=
 =?utf-8?B?bFkvbEJqdHhKSHhVSGpWL3QzMDMvZFpFVnBMdmlVY1F3RFZ0NTdrYng0eTIy?=
 =?utf-8?B?dWVGeVUvVlphZWM0MFhDYkhzTi9jZUhacmV4QXVvZG9mL3gwa2V5dzFYNzBs?=
 =?utf-8?B?VzlDUWlxbk04VDV0bVlHa1JKeTZxSkRDekM5RHFwWk5LWFFsYTBUSzBjdWE4?=
 =?utf-8?B?WmtzU1Rzai9paHVZZGI1OFlhM0FzcmJIdUxuUTJqc3VTTTBnSzBBSFo0UFdF?=
 =?utf-8?B?cmwrcVYzZTYxZHhUMlNVdGcwc1ZSUEM1S2dlTG1qWkZkTmdlYzAwdXBnN3J5?=
 =?utf-8?B?bWI2UDdWVWJXdndNR001blI2emV5TEw0Vm5hWXlKSXBQR05WVFR0eEY2YVlO?=
 =?utf-8?B?UzdtbzdkeTI0ZU5JU3lzd1FralY5VkNIS1NicGdmcGRYWnBlbUxyc0dQZ2VO?=
 =?utf-8?B?MW50bkNTeW5PdC9oZS91a3ptVXprODlEK3NMeWhkQjR0K09LNk9ha0wvcXZX?=
 =?utf-8?B?emorRXBuZmZ5eXNMYzhOYzFweE5sZ2dyVU85eFpzMm9sSVlYbUZsemlIcy9M?=
 =?utf-8?B?U1VMSEZUdWkra2FRQUd5SFI3V3VQVnZHYWZiWWhOSGZFd0ZxVkNNNU8rYWJr?=
 =?utf-8?B?enZEK0hybHhoZFNBNXlibEpNMVdHVEo3NGo3b0pubU1naUdGVUNuaGc0Z0h0?=
 =?utf-8?B?THU3c2ducFN1VVU2ajNBY2ZMVVdCWHM0RGFQMW1JMHBIRStsRCtadm5sWEl4?=
 =?utf-8?B?OXJPVHlPeTVtSWR3WkNncDhUVGsyS3h3TXB5Q3pvZm5UWU8raHNvODdiZmZX?=
 =?utf-8?B?bk05bHBOVlJtYXJoODdWRGo5TUhLSHYvL3lodXowUG5zSk9NNEhXM0ZEY0U1?=
 =?utf-8?B?SWd5QUhjZUsyYWxGMlZnYU9YRCtOWlAxTHR0aUtzRkxuL3FFTkY2UEt0WmJQ?=
 =?utf-8?B?aDYzYmxNMVRKWHBrdnVVV0lpTW5xYVRGRU1FaDBXejBMdC9UamNnVW9kdTBi?=
 =?utf-8?B?QWRQd2NON3ZGRS83c3BrTFJZTDh1enJhUmg0ZlE5bHVSclRHdHduQWNBQWRD?=
 =?utf-8?B?NUJNS0d6VlJhbW5IeUhnaHhSRC8xSlNrNk1hb3RITXNGcDgzUkdYc0dOclJl?=
 =?utf-8?B?ZVRONENPVnUxN04wSDVMd1Ircm5SbDdTaCtBcDdEOFRSSnhxVVA1bUVaNUM2?=
 =?utf-8?B?N0I5bGpEMHJaMWg2SWlzYzlmMC93R0tmbE5yWGpHTk5jbG5Ydm9ybzFGREMr?=
 =?utf-8?B?QVBWUzBuSkxYenJVNWVMYVMxZ0RGQUNvZXZzVGJBRk9TMS9QRDV4SlpCOVFa?=
 =?utf-8?B?Slovb3lnWnBGU2NaTElUWDZzb0tTQ29uTk9hYm1tM1N0MzF0ak96V041SlEx?=
 =?utf-8?B?SU9sVmYwQVFRZDlRWXNqdmlWSkxLZlVlblozeU1hTzJGTzFzb0NqeGU3RzMx?=
 =?utf-8?B?WUdEOXNiRGRoRFVnL1ZMeXRZU0p1V1ZQTkRLNUowU3RlTG9sT0lkZnhVWmdC?=
 =?utf-8?B?ZnZyOEFqNzBwNndQN2xVK09IK0Y1R3RQdFRpVzdDMTMycFUvbzJZUU5NcU9v?=
 =?utf-8?B?WHlxcTB1NE10N2pPcWhpWDFZcHF1MzBiTmlTWHJUMUpEaTBSRmp5Slo4VHhu?=
 =?utf-8?B?bXNkeXdHRXpmdzkrNlFGZGswM0swcmo1TjNONjEyNHhaMS9XV1ZnbmlBR1dq?=
 =?utf-8?B?UnBYMmhYM0JSQmVpNnBONk9yOEtnZ3FXZWM0TFNmdk5rbXBKSzZaQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 65de8bd2-b67c-42bf-56d8-08debbf31d31
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:23:17.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoB1nfNpsb9WpBPn+wia7LTrx1lp6LleVlNmJVBXlTNvGmU7y0eBL9ZqXtLsP1I68giqBf9Jv1Kq/ZF8/PLMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5673
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9172-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 33F725E4F99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>=20
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>=20
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>=20
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>=20
> Acked-by: Igor Korotin <igor.korotin@linux.dev>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/i2c.rs              | 39 ++++++++++++++++++---------------
>  samples/rust/rust_driver_i2c.rs | 14 ++++++------
>  2 files changed, 28 insertions(+), 25 deletions(-)


