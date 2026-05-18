Return-Path: <linux-pwm+bounces-8956-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPWyLYQlC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8956-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:43:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674456F10B
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2647B300F5C1
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F743FF1A4;
	Mon, 18 May 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ciwVaLEg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3673F7878;
	Mon, 18 May 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115383; cv=fail; b=VATfY2oSQXYOZAStwxRwQ1BBJvfeBwXVv0AQWZjg28zkPJzxjF2iDQg9UR7UBZAkLAKC4O0jczB7pLQmrqzPYEagNpoX/mpC3IBkpIg4tJIvqaSQAzRr72yoFUokP0mejryi3wF9YFreBz11CV4g5gMtNqtfNKe/EZn6zRkR2Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115383; c=relaxed/simple;
	bh=jugLrm0C5MA3rYKv6UmRhyMWy7lIEKAG6fxvvqb4GTU=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=DseanNldr17+Gt5XDu5snZs4Xrrm9E6HnBy37IfRezCz93aFQM0ZN9E3DH2uesYlwFBD6iCnXAsTHGIywbM44niCKnW0MebXz3FiANZfGNtApk7s8Fgog6oUm6cXRrbAck/YWakKjM7Esc4sb+fGk4syEb5bJ4uqud0kJF2mnfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ciwVaLEg; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lhm6x/0Sv8QG+/MhsgcMVhYAfbJLfwL6pucubtgBREyVydzqbygWsoJkAYpUvCb59GrW7vh8gVfUsLaJSKs6sVIX2QpgeMaZAlLVLcfQqzyR7EQqFAM8bCBmY5JzRLIgBhDQkAlNMV2bLOXyS5yQSdKa5dQD6Ue0WwnZPiMwG6BblSu/pzNpAQgPuqNQk9Xzxd3LadCyOnk+5pA+6xxf/Pp4tDSUeJ4VNDDO+VRgx4o+gM/ETLjua1KCo2x6/4tQKQ6Ldg55+7uUhkeYmePmMBARX6DuqZO1Z30FFyh1to8DBuDqJuPguoxbeeoo+dTUDiZkzPg6jf19VS+MF0xuFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jugLrm0C5MA3rYKv6UmRhyMWy7lIEKAG6fxvvqb4GTU=;
 b=StaJtOAR85HXgEaHPH4LVPPQHiPZGDF/3gQsgw+uKf3h2KGSZ2kwhL7HFDI0MfGASZGPoUM43d0hZ2EZ8k8f41aDAxVh4wC9XcR2xfglx/V5qeWH/KbBbBxEO9D+WYwvDQu9k1mS4ZjmsADzG2BnOfF/jUx5vGQ5VOEYYYbbV4QrM/xyiJi28l6Q8I2/kGHvjlAOKk0IpelIdHVnNLyT23+uz7I+rhDHGssCXz8ktgjK8OFA9FTKaqMMlccHBD0tJXSU4f5kvz8UKa/f8yQ2if9rrRvtVm//8BVO62646bUy5Hwuc2RrRwGTlLGMgnmXEHWZSFr2jyIrsRPqncY02g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jugLrm0C5MA3rYKv6UmRhyMWy7lIEKAG6fxvvqb4GTU=;
 b=ciwVaLEgNk6DFNVnC1mp4/TT3akQbIHuTVReMhOp5G3YC+KVi5j/Vtc/3CPc0QYxdqfj3p6EJHXyZaY3GgOEVg8Mu3x1JQH3fwTRbaaQg94Rs1wpk0qQCSTXFbG7W8Bf88Dsfr7jANSVexxiG7gfVaAxsqfIzysHnqGU60UnbbJ5XgeyIGSwuw12EGV+ZKckzMfi2wAt4vr4BANcR9GwRXxmul0Pr/WwI5UVMHSA6TR4VJWhZ6y94+ESCcjr+C6O6jT3NWnn7+b3bu//BlYWkOk4ozsp8kFoLvT2Qo8fB7gAF5Nh/H8RtYbYejzsrs8X3ZDFJn7zk8krKnZafmft3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:42:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:42:53 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:42:49 +0900
Message-Id: <DILVRHP8OGRV.1M7JLQ52LHY2H@nvidia.com>
Subject: Re: [PATCH v3 02/27] rust: driver: move 'static bounds to
 constructor
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-3-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-3-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:604:258::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 55b385b7-1f69-44bb-4e0f-08deb4ebbe4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	hU0W8fKdnGG7xj9C4t1aVxgt5u0/MUKL0welNyebysLAlkUemxxqegnbZHRNeUQpHV5AIwDPcBUW7s6oUnoOMkGqKoAPr6DaSJlrIBZRX+g44UvD+g9zR1i1TbGPxXM2d+GIUlDGWSAG5+ZMfHNSUUo+Z0Po+sC1nK/8Uq6rSf05FVZkRBJE0I3QNo/X5eLAXOdJMySMyF9Qf16Yys/fYLik5T0G4mmrJ0cWAZCHQkcHdgSGQQD5xqe0c/yq/mUALPTk12tmo5E8GmZ6l4WgOqQQ567ZRWwHDFqCKXuoq4q6xG3Xg/RNuTqbtwpLap+k5mIv0mEZshgfFgowrk+42cHf6MRCeaEYcUPk2iPT5AiGBP0t6s4rYtr4jcGqk51S7XRpAcKhfuj6YBRAAoS0Ouieuf1UZMJI73MgIZRirW6pVN+ZyoIqwP9n2pLLXtXedShJcYvNB/46MgZ6PbN4xGEXTuvZd9/OsrKpmva+cZlYV95h4iNNLo1h1AW78kum6L8UKq7KcIVlJL/RR74DoW8fEpBQaKNWLBTLOvC+8UQRt07aCKTINL8VDfu2ynOoTpxwWpJNcQK/AeH0bbG0CoY7qo+1oAbqm6Ylm4UmtU9rVQI6UqXsoXMhVQpK0Xe2ZlqEQsttKfvbL2BOv7DOrcC+3OJ9j5AFBhmSdb5q+/Ze4XH//uKNE2LGWaD1mvw5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUpib0RDVkxlV3pGRnJOMWVRRUF4RS9saHphbGRjWnhrRnBpTllCMUUweWdU?=
 =?utf-8?B?RC9rMm9rSXVHVzNrMG54T3ZuKzRGMjMwL2VTWjF6YWlBQ3RVdmpMVVBRNkJ6?=
 =?utf-8?B?VVR2Mk9EK2hFaE1RT3pFek8vNDlhSzBXWVdJVENtZTJqaHkwSWN1eEh4K1FH?=
 =?utf-8?B?d0lzV0YzN3hhbzRtSHB1TUtORXhxUkxvRzJNamZkL2hBdzdQY29PaERnSHJJ?=
 =?utf-8?B?ODNtMFg0Yi83Vm8zZVFxWGRaTDBIUGdyM20xbGF1WEVpT3VOL1I0ZnFlZFpJ?=
 =?utf-8?B?dHl3UTBTbFBGWTdkTDFlU2FwWUlRTFhVTGxYM1RFdlZtYnpzNmErZ3FqMHpF?=
 =?utf-8?B?MjZjMXJ5dVZINGw3aEVtcEtNVGVBc010MEZseWU4NVFhRVkwYXNHNFpZaFZ1?=
 =?utf-8?B?UlU0K2ZPUDZMZWxJNFZ1dnliU1JSR1l4TGFOWElLTURyU1l2TDE2c3JaSmFT?=
 =?utf-8?B?Um9jWkFSZEFXdHJFRlR0Y3ZVcGFkOGNXVnJMWE53VnBRVzBkL3RNNDhyb2tF?=
 =?utf-8?B?Lzg0cDY2R2FrMTBlaEVxVlNCZjlrdDNZUEtFRG1mY3psbU1pKzNjSzRuT2Nk?=
 =?utf-8?B?QWtzR0VLQk05bWI0MkNTTjR3cXVFSG10UXlEZHF5WElDVnFJMWc2TUpINVpY?=
 =?utf-8?B?T0FnQVl3WXBLVlZCTi9zVGRvQ0R6d2xBNURacmJJdGdoRHYvMS8xOFFDZ2J4?=
 =?utf-8?B?T0FwNm5VNCtnRm1GdWx2enduUG5oNDhMTktVOWppZExJKzFraFJsQlRpazkx?=
 =?utf-8?B?TnM1SzlNRjJJYU44eXpaanpyR3p2NWtyeDRGSVh2M3FhanBZNHk4K1RUSEZE?=
 =?utf-8?B?cHcxVVp5bjF2enJ0ZytSWjRXSVpWSWgzc2RjTlNQdTRjS1JRUGVHbFlkbkI4?=
 =?utf-8?B?eDArQ3N1Z0RzcTAzQUhFREJXNklZbUZlSCsxYVF2UlNSY29LZ2lEQ0R3Z1JQ?=
 =?utf-8?B?c2U0dGxoUU5oSWVZQXRlTDZJQUxsSnJNTlJsK3FhRGZuMTE2V3pCa0NkaXF6?=
 =?utf-8?B?bzJ0Q09xY21STE5iYTFVY3gwM2Q4a0pXdDJUYmJmTVhUczNzZGVxUkNuOG9W?=
 =?utf-8?B?ZVlkY1Z1UnJtUVpsbUREbGJWTnYwamo2Nm9yYWwzMjVybzk0bjNOTXc1c0Jr?=
 =?utf-8?B?WW0rWUpxMDVRRU1vQUhOaUpRZ2xMM1lLTm5DUjFNZjc3ZTYzVFoweEZCUDdZ?=
 =?utf-8?B?Nk9GZmZOdHY5LzhjYW9hSE5tMWhaZGVScVJLRGlmNG0wUmoyL3l2UFNVbVg1?=
 =?utf-8?B?RndMZzZxbU1jNU1TWkJYZ0Q1ejJSeS9VQ0JDR0F5RXJVdUhOYktlZHptdWNQ?=
 =?utf-8?B?R0owMFBEc0Y0aVhVdTZrem9LK2YweGNVQUU0V1pGN2F2c1JTRGkyYlhMNSt4?=
 =?utf-8?B?ZWNzVGloVlRCdndiaXV6V1VEZ3RjN2hjUCs1VVl3OFhnY0Z6MmcwTGludnBi?=
 =?utf-8?B?U3JPVmhKZWZiQlZwV1d3Z1p3ajFSUG9hdmFsKzFNOU1mdGl1QS8xU3pCa2Zi?=
 =?utf-8?B?QzluS041SFlrM0Uya21MdzZzcUlVd3AvcTVRMkpqaHp5Q1U4OVE0cW01dUlr?=
 =?utf-8?B?NnNrYzJnVzFjYU1SYm5Ic0RsTWRNTDREdnpyYXErTTV4UmlaZFBJU0RCNS91?=
 =?utf-8?B?QmhzajlMNmZqMTR6OGpJL0czK2grZlZqRld3ei8zemR0WG0wME4veUU3STRD?=
 =?utf-8?B?MkFJYStzYVV1Qmc0YjVMRFRDYy9SNHpXT2thRVJtVWloOEh3alA0WVpiWjZn?=
 =?utf-8?B?SlVNcWN4a2lTaisrSFA1Z25LSGdRS0xwcnBGM3JNVUp1NkZnMTZMNy9YVEJp?=
 =?utf-8?B?Mkd4QTlSMnpEL3ZFamh2aVhqOENuYXY3VFl3QU44RzlCZWw5NXRkVWYxNDNE?=
 =?utf-8?B?NkVyMGxxYmNWV2RyMm43ZU42QWtPaFZvZUpkN0tGRGVIVDlVM2lPQW9aSC9K?=
 =?utf-8?B?aXR0ZU5OWm0rWFJveTAxTzZZUUtOcDVkbTJ0RUJXQXBvTkNCVjNjaUhsczdt?=
 =?utf-8?B?ZURBU3E0blRGbUx6cXZOUUJHUzZIeVBCNnptNGNIYkY0NUx6SzBpdHZmSTll?=
 =?utf-8?B?NDVqWFd1eTcrTzV4eWFYY1Y5U2tQSjlPc01lWGxOeXpwV3Ztc2VMMTZjU0FV?=
 =?utf-8?B?ZWFvNXc5MUxiUitTT1ZJWGlBNmxuOVdDck14WE9xZDZMSG1FT0N6aWkvV0Uz?=
 =?utf-8?B?THJhMERUTDZYWkhrT0cxd2pES2lWbXFNR0hXQVZFemdWVkIxNllDUDl0N0Ur?=
 =?utf-8?B?b2xZaXZ6U1YxZVJLZVBPZGZZSDVMTG1pd2RobnBrZzRFV3BpUGVFcG1hV2Vr?=
 =?utf-8?B?YjQvVmIyZS9GUUNCZ2JIeU9zNEQxMDVQUXovRWppUEpDOGNBMG5uZ09ONUZr?=
 =?utf-8?Q?+t2bJXxUVidXEwrcabeTVqUx5z85sAVdrN1Be/NXtxQUF?=
X-MS-Exchange-AntiSpam-MessageData-1: cQdcINywFLOiyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b385b7-1f69-44bb-4e0f-08deb4ebbe4f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:42:53.7691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x/8kiiab4GsIinckC3b3SgJrMJzIDtuByCn/r5QpNz9F1LXNK44enceV2sNRt0zdebZjHVw9OQneaJ4vp4rrug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8956-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,garyguo.net:email,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 8674456F10B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> With the ForeignOwnable lifetime change, the 'static bound is no longer
> necessary on the drvdata methods or bus adapter impls. Move it to the
> Registration constructor instead.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

