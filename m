Return-Path: <linux-pwm+bounces-9166-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFnuOovcFmofuAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9166-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:59:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 963525E3C27
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1093130058F6
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 11:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200D23FD960;
	Wed, 27 May 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LaqViX3w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D13A400DE4;
	Wed, 27 May 2026 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883145; cv=fail; b=u9cDBIp9KibN7hZlXSk+4wdBtbZ0sJKOcKwcZ4hh42thR806HbrijTvcXbK8kVLuZvnExujJmjWlyRv42HLZUV2SVbV2smeHJUTNmR0EvNO81PlwM44e0WM0ZxAZpYUdr2OMyuXxu/zA/qV4HN8W7Afp9/VSbyPIIWVzUEjp5uQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883145; c=relaxed/simple;
	bh=77XWhYqZCR856Ui319RzPEIk6gO7v33Bp446FjbaKs0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NuVKRV1kSt0kBX9KR/SSqmoHvHkR5YC0OGDA6k+N+3Be1W8HEyXyWA4dxxX04CJTFBTQ7/gGCTojncFLfihNOXY1GuD5GLrTMTN39mJ1NPFs+fWfWoBI1GYKxnjhIhudYaKU0Nku+Z+7hhbV9aPfITU8oiaZ3qrDeBQxg8yc2dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LaqViX3w; arc=fail smtp.client-ip=52.101.196.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e83HYpFfIMPVkPeKCbpMMoFlOO6zZzfIWxrNkwFtgH3aZ7xuOx8WilirFYOnC8olWyJPzvfX6mFJj1ES6zZYxpFEXY+6zqa35RHiK01+wu7jW0UUi2OyyKHPuc3baGkwpBtZP6eSlB0kX+rp46hnhq/mwRYcp5uvALtX1W1ztlA3R037eFv7ZkP77txnztU3xcikBwgwwgowcwM+p01JkmJyu287bzzjcwmQ3BEVKtk75u+OHCSICe+PuliJI5fFtkeJN2pmW7XxnqmW+wvDDnVUMOuIFTMM8dMyIIgyLm5R8kF2cKJXLkoVQZGxmiGplRw34m4UuAmvQ6Mj2JZP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fsrDmowFUMYXILZotlarITJd8qSx0wAIwhDA3Z6Yfg=;
 b=NHUc3Xjd92midutasbhtwXZkKpi2knaPvcQVy+MiI4i1Elm0LGwTsMbXOiGR1UKwh5RDP+eSbcW6EShQUGvN4YDbTmYo3pWYR7VGBEDb/s2y/oGa9z6Zb2tjGsSx/k0hlnhdDbU/fWW5m5kn/ZOlZ330pWk7xkhLjrxtqsQYYpyU9lYzWRyPOYbPCZiZa+M1OktJHAIWH9AG5PmqkC401XNi1DnQgbXoKWtthIZ0ET0yy8EfZAxsDW7sWeqK8SiNpUjZ4lW33et2xnUAPAbqUEzk6LhNVoruDqZMi5PfNJxpN01O1jOQyM0IIGuZWV5wJAGmU/sMyDpVDlpzmRKrgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fsrDmowFUMYXILZotlarITJd8qSx0wAIwhDA3Z6Yfg=;
 b=LaqViX3wx5xT8i9Bcvvhv0GWy6lIiRC+vLago5U6cRmXgrPO9+B8nznpC9x2mTe99DVRr2ZwXuXJm6G37d+HsUDkuRjMIzIftfbHeoQerWOTuMUeuY+MgwCROuHY2+3clulC82Dj/aeVfXHfl0wLJB28NQ99BwwH5IrHY6m/NbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB6208.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 11:58:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 11:58:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 12:58:57 +0100
Message-Id: <DITFWXKH2IMU.21KBH5CCYGRK3@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>, "Sashiko" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v5 01/24] rust: pci: use 'static lifetime for PCI BAR
 resource names
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
 <20260525202921.124698-2-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-2-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0135.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: eb09d8bc-1d39-417f-3913-08debbe755eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024|921020|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pz0AQaJt1shm0AGz6ikf6HheeS0g11czbcAIGEinVXo80lbn63bH46dn+YdwOAd9bk2IG3VcnMOEIeK1LogvAzyeWFOTAQmtgtBbvjSoAllMysjqwYVhrNFm/mfwT+JojLQPMP+pZWLftqtalJlEJB71NQS0hWZGgux+XFv5AQtE0kvHqDmOWE4bOQ30z672y0KZ68iaGhO0uAe5vnxpzUkWsJoQYShbGyiQcLxyok4FuaN//fn87iaEKaFu/dxxPe/WFALifal9qAg4zC8DKDBfBWPO7V98DO7DFiZ7aUJdbsimdzvxkv9FN8crD4cXu96l2OdhlBZP58qEoMB3ic6cVeXGYzB4JXiMHSQivwUWsUY9VoRt8QCUXeO+/u90hQzS0zPLAeQIyBiH+cv+TaFs2ijGntse+GWIkMbQDggqjBXPNVoExAXO9KA+9pLEw//EFyUIQCzzmqSfBWUU/EdQBV/GM/Oa6/jjtRo3RqMFaqDQrX9+FLTENtvrmKjHwovhJbboH9b6veDmkr+9MWVEC3RUUgTV8WaxqIP3xBzOrDmB87gpGi3xyn5XJB/P4vCzz0VyxZiUty6OMbd2Mzbh5+PjgAiwCMoFNUQbyWM7I7eVb/LMeXA3/tw6QQ37RH0UGAPW9rtm1kF3fhpE4H0jx3HoKBJ1PJvJhDR9U5prZnL9s+QJlpuTXUuzuSTZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(921020)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXNPczFqV0xkZEJCUkVqaVM0NXpPZVNFazE1SlJuNTBLdmJxYUhGMkxHMENJ?=
 =?utf-8?B?Q2pzSWdhSGlSYmpLaFJmVFpwUmd6d1lZbXluUEJpbFpKTnJTczZ6ZDlCbzY3?=
 =?utf-8?B?YTk0N29ObVhvVG9SMHEzaWlRMGMrc01sZy9DVnlUNVo3VHYwKzlQS29ZcmQw?=
 =?utf-8?B?UWVueHV5SlFEVlFmM2VkMjFSalIxK3d4eS9LZ0Q1eG0ycnRNemVJQnR1QTJU?=
 =?utf-8?B?MlI1SnZ2TG9RcmhuTjdGL0Y5ZlhrSUYrOVFsMjFvK2t4U3hmaHovQ3kyYldi?=
 =?utf-8?B?SU9WZHRWdUxmTkIyM25JOE5PS1MvUE1jeGppWGFFSkkwTU5wYVNaS3ZkM1dr?=
 =?utf-8?B?aGlZS0dvdUpOV0V0SjkveWF6STNCUjVPQkRhR052QzMzZ0Z3aFk2cVgrWU10?=
 =?utf-8?B?RGdsM3pyZitHWXowbDFTNkJxSDNyaHk3a2VjcGxhYjZoVTQyS2VWeGh6T0tK?=
 =?utf-8?B?UjQ5SXo2cENrTndvSEJwYmtvWlJLVVFzd21NNHhrNTB1Uzhwdkt4LzFQVDRh?=
 =?utf-8?B?ejh6YXlTQk02VW1zS1hiYXRTRm5SRE5sY2xhcVJBOWdHc0E2TkxYOS9rbWIx?=
 =?utf-8?B?RmdrdGJIQUE0Qm9BNkI1dEJuV0NFRU5kS0hXVzkyK1Vkd3ErbTVweGcyRmVH?=
 =?utf-8?B?Wm9nZFo4Q1kzWlhVcHI2M1k1QWcvTnc3ZDJZNHRhaU42SXFoeHAydFc4YXU5?=
 =?utf-8?B?UW5yVGt0QWMvZXJncDg4N0tPU3hQYmVxL01oRXJNWHFGaW1udUxicGg0WTRl?=
 =?utf-8?B?bG5IQlJWMWVycHZhMkFBaHhoRHFuNXAwWFZHN3VLK0dWeWFuRndtbU11d041?=
 =?utf-8?B?bHMxc3NLcTZVVFRGcVVXeDhhNWJDVTBTRFdPQkNwclpiYmwvbHlaUEdHQitv?=
 =?utf-8?B?WU9CbkxpZTZWV3FuT2xmNURHd3c3MGQ5aklRMlpCNml5d0VLYnhkcFU2bHRF?=
 =?utf-8?B?U3JVK0VhdUI2YnRVem1QbDZnOHU4MlZyZmV1TVA1VWtDcDBiK3VwRGJqTkYr?=
 =?utf-8?B?ZzRvMWgrM0hkRWVWTnUvK1krcGRpZlFVTDV1ZWNsUHM1OXpBOWowYXhtUnRI?=
 =?utf-8?B?blYxam9CNE15eHpFWDNZZ2paQzk5U01neWNDakh0bWlxcWpRWDN4UTJEYWdI?=
 =?utf-8?B?WkRWWHFKZFVXRndkUVhna2NpbnlJQ3ROQzdrcmdNeUgxaEJOdUNZUXd5WHo2?=
 =?utf-8?B?SDh6eENnUktLL1o0MmlPS1llQWdOcnIvcGc5SExjNlhMa24wQWozRWo4a2Nr?=
 =?utf-8?B?aXc0eS94NHZ5ekxzTDJaUklBQWxiUlRTYWhudUQxRWFjZnAyRUVkM0hCK2xu?=
 =?utf-8?B?amZ3OWJteHFMTFhaUmhGQ3QxdXNFVUNRei9pS0hRWTZnMFF0ZWRsZXE1THhh?=
 =?utf-8?B?ckV0alBhWDR4Z3YrbFBWNnlpaExmY3Jya2xMRU82azY4ZyttRlJQTUtrMlNE?=
 =?utf-8?B?NDVqeVJyUzAzSXJLN09KWkFLVCtocGNiTWh5YTVqbDVYNCtSMFNnYjZUVkx4?=
 =?utf-8?B?amlFQTN1eGNKN2hQZmpsMXhPcTVZM1h3VXJCVXlOeWRlUld0TFBKVHFaWmxL?=
 =?utf-8?B?WldmQmhoYzlvM1l0OVFxa3BiK2Z5UUdXaUJCaC9hMHNxU3p1SXVuRG1YTmpG?=
 =?utf-8?B?d21IT0RuRW4wemVCVnNocGM4MlAyTU1Tc2U3TlJkS29TaXBoRUpDNTR1RDAy?=
 =?utf-8?B?T0IxQTZGckw4VlpuWTZTdUczTmZ5TUNjRm1pVnltdUZHN0t2OEZhcHhmSzdo?=
 =?utf-8?B?cHFENUl3Qk9NVEI5L2NPR0JPSzlBaFdYQnRtZ2ZqdGNqVitOYUllaE5XR0Jq?=
 =?utf-8?B?REtoaERiNmVieDBNNWRmNzZmRGdZMWdTRFFOZ3kzanJVSGNoUmNDT1NOV092?=
 =?utf-8?B?cUorOGFXdTRjR2lqa1ltNEhQODRDWnE2K2dSU0gxQThob0p4MUc4Yk1odzNi?=
 =?utf-8?B?VjV4RDMrRUVUTUFOL0txd2R0R0RlQmZrM3E1ek1jRjhRZU13TkJjMzJIV3o2?=
 =?utf-8?B?VGF3aHFNakZMZUFVOHVkSVVJYU1WenhKMk03TlRlK1pCU296UC9TRHlvaWpQ?=
 =?utf-8?B?c3hqaURsdW81dnVXTHQ0M0E4bzZCNDJFODRMVWVsSmdOUEFYMElzT3pJRkdq?=
 =?utf-8?B?KzU1amEvcm5lRTl0WDdVUkZZeWUwVTVISUJwT2tKRXVUOUhJQkh4ajlMa2RD?=
 =?utf-8?B?YU1tSzdSS0Z2eHM4M3JDTml4SU5MUUdtWU9BZVJKT2xEZTRmOW9BT0FzWVl2?=
 =?utf-8?B?M2lualFEUTA4aTNxelp0OEFRUmlMZDZONnkxQ1ZqSzlXSlZKRUFhSlNlbENq?=
 =?utf-8?B?WHRkdWw1TUkvNUV0a0NTcVlDUEtyelBqV0lTK2YzeGpUbXZ1eTNvQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eb09d8bc-1d39-417f-3913-08debbe755eb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 11:58:58.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pf8LVUicx9ejqyiPJVEal4sbqKw0JCDR2yQkU4ouCmqeJwrFl2cA4TkAaPz6ylEbP5PD+uR425/krDni6s0EFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6208
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9166-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 963525E3C27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:20 PM BST, Danilo Krummrich wrote:
> pci_request_region() stores the name pointer directly in struct
> resource; use &'static CStr to ensure the pointer remains valid even if
> the Bar is leaked.
>=20
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260522004943.CDA7C1F000E9@smtp.kern=
el.org/
> Fixes: 3c2e31d717ac ("rust: pci: move I/O infrastructure to separate file=
")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/pci/io.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


