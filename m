Return-Path: <linux-pwm+bounces-9003-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOgvIq5ODGpIeQUAu9opvQ
	(envelope-from <linux-pwm+bounces-9003-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:51:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F3E57E096
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B75302E8CE
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA25481253;
	Tue, 19 May 2026 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="nic+UDoC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021128.outbound.protection.outlook.com [52.101.95.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4335201E;
	Tue, 19 May 2026 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190783; cv=fail; b=WEd8LqdHnFekfh8pJKxtwbOjBBpi6r5sl73tzsxAyPYmZWCw4ANpR1PjZNYJoh4T0jErLy56vw6qeGXnfLpbC/VX+UqoS3zO7wm57wasq+nW5zK9xCKH07Vm3biM1VkSJX4ZYudfatwyDZ9go0uqRvEetO2iVvUsP4z9rEPA85w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190783; c=relaxed/simple;
	bh=BH5FcTYjH8aNgVTm0q5jGbNBjrS8ea4RYrwENJbhClc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=n16COgEv2Hr2Ngrt7+E7ZeTs/uwh+mkeT3oXRzpnwNZbFCYtoRWb5slm/wpZ4OHlf0YXStg9skck6KQbT2KpxF9FCpCzYmM1MKpqcIZ4sdZdY8Gov0vo1WBVHiN1ideUL2tLJo8KgJ6LkvHdcvwH8gpORAAoOY3TkUuDlkRkFlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=nic+UDoC; arc=fail smtp.client-ip=52.101.95.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4bfYz2OmZQLXN9gZTXGg4DwtIaJ1XbCI2K/06uAOQf3GImK2Ll88Q/Acn5uoohibofwDH4JatKTec+PuBH4tVbSLD2JTUVLTWoyELYRAKzqyseFBblffZhoBFe8sNdgnaUw5qj7hKXQuz0OJS6V6QbZZTrxEoMIyxofX0cipCFOBwJ4RLEV+pOZCQBQLu+vCLflviyWFW7XZyhM1VcQaXop+Ns5/An0ujzFAvSkHWtKaEaLLuwdpXeh2pyN396GGOWSTFwxtcV/1Zqb3+0sA4+rgeNd1Hcdl/E6NEgP4xqcEFLNMntkgRq3imEh+FvxAuFee6DsA48ChKSZxd75xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FurdDLuIo3gHJoVhG2iUKfr0i5G9Qt0XJ09HBI9em64=;
 b=oiSb3EZqhnNehzcBknBydUlwLeqj+LUBfHQkLxweLWY7aL8fLJZDiOj1DkiqAp2hESL3K5avYZSa+RrkCqbzo5BPDaghSF4GEOVuYTtdRTPtjSriL17nt4bIjCjsGNVVDt1E1s78BqcYgZ5/Sr88Jgfcd1J/fQ6AMrWReILdUBFmBZH6ccJYk76nkRWKzKfQvFOq4B66ePY38VCBJ1GsqQZptWcFud6k3Am+0jIOr29Ilxkno6yDFdhVD6EJxVl8smcdecjxbtW24rumlG/jsELCNrpQybJ7L6OIqJxgxvg9xO+YXkrpscPp+qzl4wMHe0kAMYGgnuPdHF251wJwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FurdDLuIo3gHJoVhG2iUKfr0i5G9Qt0XJ09HBI9em64=;
 b=nic+UDoCgX6uFEz9YXhloSb4mAjeMAhTV1L2HvagCWvPntvYlJ/M0zWcrRTQMYzAFRiLRXbhREALtZihimWnKxYz/L5iCQGqkWhh8pggO37bp16wlPJtSMImsy7OqUjGTGYBIUEDpN/HjylgiLHrimtPPqYiyEI/BVgWLxVz97E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3625.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 11:39:34 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:39:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:39:33 +0100
Message-Id: <DIMMHPLUV2LK.39WF9SGO8TLK5@garyguo.net>
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
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-17-dakr@kernel.org>
 <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com>
In-Reply-To: <DIMLSVG1IO07.28UMFL4GTCQG4@nvidia.com>
X-ClientProxiedBy: LO6P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb59d66-fd11-465f-dd74-08deb59b4c4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|22082099003|56012099003|18002099003|4143699003|3023799003;
X-Microsoft-Antispam-Message-Info:
	H7DcSUdwiO7vybdcLqi9ir3c3sRviuYwe0G9KmzYRcBCYEzijrpb0E2UScs94KSDIXSyLkUFNL3SgrR2LiM0I05fbkRi/zyHVqda48dKpzjRQHOJNJLEOtXWKA3VxWUrL0u0w4b2WR8hn+gjejzaVp321TV2WlkfizHgC5LlyBxPbkVe4aAKyZ5NTJ3Vd1zLuHmIq3ZEe30fNZL306VndbuwcszLifr8JDOryRLOEqAHqf2MfYnpZ5A/EiDkzeitP5MdJVnBlO2v82Fr+l3A5drFqg4/PPvDTJMvO6Et//Tn2LET54mLoqPYoVS1WJcZ8vYeWBdcqbecPE1V9Iy2721NsLlPH8ebdmBoB3jI3DE4nntwFF7LFEq8zR7uXyEeh+/R1RBUR3n71ZnKw8vORXOy8VTeI1hVj43Tl3DRgx+4GbOedcQITVHXQNWzFxT6vxdPZJT+tvIIjnI3RMxD0WCGZoALivSMmnEBVoQdmYeb2Duhq1r+GGN5GDhh/TUqmvilqEs2A5nQFCJ6b4KHqA8OfTWJtFjHyBlo32xlA+CsfGSw+RxDEOfJNMeC2OXxXb768qvOomPZaaC4adgctehTx61L+iLGL5y0rMA99LC1r+/gSLQTmzo5SuBd+g1kcC9EKoNuu6sglzJevdx1LFK0ym04MnRGjVrNqQewOur7H8AYyyAZmFJwuvAiaBn/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDV3TmtDMWlOV2NHRXVvUkZyanNqcGlrdHNmUEt2VXpJbjRyamNLUDhmWXJ3?=
 =?utf-8?B?cWN1cTdGVVBsVFBpb3c0cHpJQmxTUUtaZnpXUWtMSkc3aHBjS01CdXlLOTFZ?=
 =?utf-8?B?dUdTaUN3QlFCanZleGhiWEF3enBBMDJPS1NiTDdPTkJiRHE4YVhZSEdWNGNo?=
 =?utf-8?B?bGJpNnk4d2tja2pkczYvci9YSGRFTFA3RE1sbTg1dEpuTXhPUTNqMWdxTXZH?=
 =?utf-8?B?VkYwWGJFbGNPZUczL2lCR3JGRngwY2Q5RHVtZXg1WmUvbG0zVTJmRlBSRG1l?=
 =?utf-8?B?b2t3S2FyUnBNbmVWNHpYTXdNWjl1bW9kcGhmS1RWNi9BVHpiZ2d1dTdXRUwy?=
 =?utf-8?B?T0NteWI2RFMrRm5rVHRrTDNqZjNHNkI0VG4zTHRubm9ZUnhoV241VFFKclJO?=
 =?utf-8?B?Tk9MU3NnK2R0NVRtanJhQzlDcWZmZDI5ZElNN3FmbEpTR2hsdHZpbXFWUDE1?=
 =?utf-8?B?ZFhGUkgwOXM3bG9ucjI5VlZxR2t5MUl1UVBsWWI3TXk0MHZwODB4cXRoMU9V?=
 =?utf-8?B?OFVxb1NFYWxUSFJiRDR6WWcwM1hxZ082ejRDQ0ZJOTM5UjR2eFhnaTdHQjAz?=
 =?utf-8?B?bnp3c0RNVmxQd3BXeW1XMk56MThyR05rN3hmSDR2emJGV0VLVHJtZGVkS3Jl?=
 =?utf-8?B?VkZLR2VBOVB6UEZYZ3Z2dEI5SW5hOGZkbFk3d1l6VDdCV0R4YW5BU29yU1pS?=
 =?utf-8?B?VUd4a09oL2hXQVpzK1Z1Q21CTFVCVzNFMnVjcnpxR2xrRCtpZ0oxMHhsKzln?=
 =?utf-8?B?UHdKMFhnVmMrbmdpYVNHY0JTWDk4ci80UHpzYXprb2tkZC93ZWhyZVdRVy96?=
 =?utf-8?B?SUtjNVl3L0hzMUc2aDcvV0o1Y1lCa3ZyR01EZ2Vicm5DZm56QzdKZmV2NktW?=
 =?utf-8?B?bXBpTnNIUndqdE4yRjRickFSbGRKbC92b09GQ3pNbm8wVklQN1NXZEhSUEI5?=
 =?utf-8?B?NFBuVk5DOTRaZ2VhS0lJcmVSYXJXaSt3aldxcysxeFBtdnlJRU1paGNwY0RF?=
 =?utf-8?B?ZGxxY0tRTHkrREtpbUFZck51RUpOaXpMU0pXYnh1ZnJVMFFxdFo3Ny9lNWl3?=
 =?utf-8?B?ODlQSjJaa0ZibERYTmdtcU1scUx6QUgzaGNxWEFXcFBOU05xTVIvMlBrc2NY?=
 =?utf-8?B?RDZvM1preGxvQ0hTYUs4Mm5YWGtFRWNqclBoMXpDN04wNExaSlprdnJvYzQ1?=
 =?utf-8?B?cXZnaGQ5NnhrYXZNb1RGMHNjdlRoZ0VBVHJGcTJBeEFoYXhFMTQxSUFxY3dR?=
 =?utf-8?B?MmtUVlJ3U1JXT3NZdVh3djh2czR3L0FIcG9hY3NMWVNJWGZ2dXIyTWRGTFJL?=
 =?utf-8?B?NnFRZm1NaW9aN1FvNDNnVEN3N1J6N2M0WnoyTVVMSlVPellhZS83c1dKSGF1?=
 =?utf-8?B?dTJYNmIzTDBLRnF0TnBlWEwrSkdtelNUZ1NzTFd4OHduRnJTaUJwY1dZQzhH?=
 =?utf-8?B?MUF3S29PaTVpU0VpbGpycWNjcWZWOU12SVlBQm52d2gzSkxlVytVREtueTg3?=
 =?utf-8?B?dmU4YmtuQW1oTExhNm5KMjdnejRVSEVRK2t5cm83bmgyb1pocVhoeUdmL2Qx?=
 =?utf-8?B?ZXoxajUwSkhOQm96ODBXbTlyeFNFRVorbjR4ZG1RczdMdURTOTNEek52QStU?=
 =?utf-8?B?Y2ExMlBDaVR6MmxjZmZwZkVqY2RiWm5JbDh3MzJoQzJ3MGNjK0xMQ3ptYmxy?=
 =?utf-8?B?K0REY2ZLUDMxaUpaUWs1Si9TQVVIaW5QNk5xWFhQL2lNUTVVZ2M2UkcrR2RG?=
 =?utf-8?B?Y3R3ZXQycThCa25haENRU24wb25RczJ6L1lZUHQ0bnBPMFdvZjQxeE95dXVT?=
 =?utf-8?B?KytWWmtCc291dndMZDNrVVFmZ3FxYnVaUWRKcys4NEpNWU93QzRpRVJkVUNx?=
 =?utf-8?B?MHVTU0d0U0VrWE5rRzlJNFh0eGR5WWdSQTJMSlVCWjZsQ3dDa2hGOUxEeDg2?=
 =?utf-8?B?K01TMEZtRG9RQXFHUDBoNHRXOXlwdy93UjF5SXpNVHBpa1JPUmQ0Z3BTc29i?=
 =?utf-8?B?T2RHNEpxWFdFcTVjVjl4OU90WEpTaGRvYzYwNGJsS09LczgvUkloRHZGSVYw?=
 =?utf-8?B?aVpJMzFqUHdldzBuTWVEbExnMHJ4S1dKeXNabEx5K1dJcWc0VkgvQks4ekMz?=
 =?utf-8?B?NWdlS0lpVmVOTnNBaHBIWEdaWnlUZC9jaUU4UkhCQlV4UVpqUmFBc0w1UFQ1?=
 =?utf-8?B?VXdKZ1licnRJNHVMUUxiSWlzTEgwUDV2dEhNeG5JdWZ2a2ppYk1oaHl4Qzgx?=
 =?utf-8?B?bjB0SDNJOGRwdmVpbmYwUUpUM3ZsVGRTbEE3NTJ0QWcreWRFY1plQ3k1T1d6?=
 =?utf-8?B?ZHRrRytZbTlnQkhob1UxWG9LWm14eWhNdUtNQVBtZ3JHYlN0Y2dHZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb59d66-fd11-465f-dd74-08deb59b4c4e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:39:33.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhuioIswpgT6mBSJcOUAlb7bQw2uzhSgg1RCr3hkHFyvFtJiIQQbCUvL0GQmZ6SpgguPFBshe58SPaRUQcHUpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3625
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9003-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73F3E57E096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 12:07 PM BST, Alexandre Courbot wrote:
> On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> <snip>
>> +/// This is intended to be an "unsafe-to-refer-to" type.
>> +///
>> +/// Must only be used by the `ForLt!` macro.
>> +///
>> +/// `T` is the magic `dyn for<'a> WithLt<'a, TypeThatUse<'a>>` generate=
d by macro.
>> +///
>> +/// `WF` is a type that the macro can use to assert some specific type =
is well-formed.
>> +///
>> +/// `N` is to provide the macro a place to emit arbitrary items, in cas=
e it needs to prove
>> +/// additional properties.
>> +#[doc(hidden)]
>> +pub struct UnsafeForLtImpl<T: ?Sized, WF, const N: usize>(PhantomData<(=
WF, T)>);
>
> Although the documentation makes it clear this should never be
> referenced directly, doing so is still possible, which creates a
> loophole for breaking covariance using only safe code.

I'm aware. That's why it has `Unsafe` in the name. But there's no way to cr=
eate
unsafe-to-name types, and without adt_const_params only integers can be use=
d as
const generic parameters and thus I cannot use a unsafe-to-create const
parameter for this.

>
> For instance (untested, and based on my limited understanding of the
> patch):
>
>   type Bad =3D UnsafeForLtImpl<
>       dyn for<'a> WithLt<'a, Of =3D Cell<&'a u8>>,
>       (),
>       0,
>   >;
>
> The blanket `ForLt` implementation applies, and now we can store a
> shorter-lived reference into the `Cell` and potentially observe it after
> its lifetime.
>
> This could be worked around by defining the type implementing `ForLt`
> locally, at the cost of ergonomics since the `ForLt` type would be
> declared separately:
>
>   // Defines `DataLt` and implements `ForLt` on it after emitting
>   // covariance proof.
>   define_for_lt!(DataLt =3D for<'a> Data<'a>);

An earlier version of this series have `ForLt!()` being quite ubiquitous, s=
o I
want to avoid this approach as this'll be need everywhere. But now we switc=
h to
use GAT for driver data, so perhaps this isn't too terrible anymore (only
driver-core and aux device registration would need this).

This could even be extended to support generic types, such as

    define_for_lt!(DataLt<T> =3D for<'a> Data<'a, T>);

This does also have th benefit of not having the `type_complexity` issue.

Danilo, what do you think?

---

I suppose If we're going down the new type approach, I also have some idea =
about
generalizing this further to a generic utility that annotate GAT about vari=
ance.

    #[variance_check]
    trait MyTrait {
        type MyGat<#[covariant] 'a>;
    }

    #[variance_check]
    impl MyTrait for MyFoo {
        type MyGat<#[covariant] 'a> =3D Bar;
    }

Then the expansion of `define_for_lt!` would just be

    struct DataLt<T>(PhantomData<T>);

    #[variance_check]
    impl<T> ForLt for DataLt<T> {
        type Of<#[covariant] 'a> =3D Data<'a, T>;
    }

Best,
Gary

