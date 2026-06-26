Return-Path: <linux-pwm+bounces-9417-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id trU1Jr+RPmq+IAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9417-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 944EF6CE21C
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=BzV2OBO8;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9417-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9417-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55B88304C8AC
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F88E3FE667;
	Fri, 26 Jun 2026 14:45:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022126.outbound.protection.outlook.com [52.101.96.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C7A3FC5C4;
	Fri, 26 Jun 2026 14:45:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485151; cv=fail; b=h6bs5Sj/7PM216X2fRisuTtH8qFuetwAE/3r3Xuc97IJvZYoHzj3kAXM9vEpWupRyep909naqGtKh4RAHRQsll01h9zD+Ti9nCQir5v4cOhr+eJmrFEwAsyOuNQSY9dPVjfqDzZvJJAPz73JjQCpb5acpAwcg75GZdVaFFTuxmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485151; c=relaxed/simple;
	bh=1KDVAjQDV95PM3cfyWvcXgbs2vPjx8HAx1il87YdtO4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gC7Esa+/a1wkBn8oql18swHvgeLVVh+PP1EYS686L3xXpVucJduAX54f/My8h8yk3r+5PyIs92jusfoDpyw52tla6ITQ5T6TgOsUV+0sVdV2ElKNATD/bRqLSXea57LWETaUy4IdVL+cjVkrUCB4zYf0xuaaWZ8/2IqzHq2VCY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BzV2OBO8; arc=fail smtp.client-ip=52.101.96.126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO38+Q1yocQ1KrJcHzX8PFsS9/D/tgnm4SC6rK6LG5wjHAE/AVXyIOAs5O/IRL9iRI3PlQNdogTNMpKV/n0F7+HKzlyHTmFisAm0rRv/7k0EPwlqBorj8KilOX4fp4cgEfZVNU90DbAHv7vf8PxD8SFclu2I4dAmD1hjHAax4kcJuTWwThtblYZ6uQb6VwQVzZ0CQ8129rbGxmp35e2Zi7mNUK8GmhrLfP40GrZhKRINjaVhSrboZu22H1JKM52OJQp47vzOAMWIbidM9hFFs9xzJW1BjCqqjxshnfnFSzEIZH18D2q3Ynwu6VAP/BDhDvSLjVwspvM0mKIL/ZUrJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFdRUcJQKUmV8oOcbV0z2r4i9Jy5D1L9pgQmGTpA1mo=;
 b=Dsk/kIxVR6F/kY8R5RwqJmJdH3PBp61AM8COvH/zWtEVpslqdhgMpvLD0wxUoGC+u5yS6HmxhXw5Cvd2Pw7uwK5CJqRlLHV/F6RMSqk1n+4ueudD2BVoEq4oNTnQ5CUaRI4zt1UKAaiXHC8925WB9kZ9OmZknsm+pGjQI2n5leBr5Mo7/Jhza2Sc/lbMkfc/I7F8vRC7bnGznna5fGbZDiXueFR+2GzXxZMAGL/J1BLrPanm9fMsvFIvgP7HPNJdzP8vSX/ZeaRSFcAvfniTBINRuCiNtuVfCFMblUfib/WkKiCgtkB2ffBcXMgwNmjGEbuuL58qNZNQfTE/miGuWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFdRUcJQKUmV8oOcbV0z2r4i9Jy5D1L9pgQmGTpA1mo=;
 b=BzV2OBO8ujTmnP6+BvvHOX9oT3TgtSlQBAfZ8CA6m/GAADvW3Om0JEacltUhQ6kfia12dcQLqH3Q+sxd5RSjJZ8KD3ejvNNMkgCiuFUmg4sO/minTzdKZlLGg28YditwRH9mG96vQ8Ywb64QT6VrHe17OAWWJNGVLV/sSTBXSe4=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:24 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:24 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:19 +0100
Subject: [PATCH v5 15/20] rust: io: implement a view type for `Coherent`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=5630;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=1KDVAjQDV95PM3cfyWvcXgbs2vPjx8HAx1il87YdtO4=;
 b=LaKubt/EZTUDPPFY5qsCZchEY0E7Y8Q1fud91J8KryUwUTnh192oUBZ982nWrnCGVaD/C03z9
 HhUTN2rjkptAdT3sVaWff6pfdSUogsOJCx+O/gimMockxH+FTtpCRHE
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2694:EE_
X-MS-Office365-Filtering-Correlation-Id: 650583c7-30f7-4adf-676d-08ded3918e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	LkVqaOMD1J6zqNmEtdlSmd39Vwz7jdV3rJJQ4J4m3K5E1O7lA7F52jLRjrXadHsnFFh8oyJoS6gLzCq5/qerSdCHkWrHUMZClXnnr6syy87e62NUx4ZiQ4Emf8YCMZcq1+db0IHaJH53tjZZW5eMrvUBMRIo6TQ/fa03M0aXm3F/0cyKD4xgeSiO+tKm/k3BgW2rBdBOLhURglQ1neVTddQ8aw1aBu4giOoPugdwtmj3Z8oPbyso8rOPH01ZHzf+a6AOgS0rtwRjt9/PjSVmtpjdvI/6p2HHFH8v3tLDCu256bFgxWsWaR4A8vaztlKgLyleLAq/gLLoFP09D64ie/MF2Pl8IumDLoLkkaoniJ8eLH7P016gN5L+Wt8tYuoGFf6BeDetr7XPZj+Rj6dc9xyobbijjgISPc8LmDOHlDzG7QNL0H/f6FenCF96/FOGmmU4a9ye62XZ033xUVu8+e5+1bLX6GoVjriqFCvAjN2a6MM8ySM4Gs6alr8XMpbKmnyyF1SCE7BTsR/0g74HZCJAA0//5fX9eHH48R8Oz6yeyXcuUjIpGOURg/JbnWQ69uznDIF8nKmL5RiMiX/oK688jxgOa3t8dpJN/rHhZqPpfFlP4ylu70EtJ4XbtoEMCykQ/olo8zLRDDZ37udkGGdHIRyKpEQfVDuAID3M/QpSMcgZ+dJSVS9I5IYWuWVbyUGeo28gWh+/FdWbX4TVog==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjlQQmZ2Y0RrSmc3enNueHJ5Q2wvYlBnUWkwZ2EvOGhlS2kyanRGVEk5ampj?=
 =?utf-8?B?SWxaTE5VYWdDaEk3WFE5elcvdzYvaWRseU13OFYvUjdFNko3WEVsWkNQWU1a?=
 =?utf-8?B?MUFCUm9yTi9zaUw4TlVFZ29FR3lYeFY3bVVFbHBRem51RFNxcHJFV3FYS0hs?=
 =?utf-8?B?Tm1lLy8rZkt5VWpGaEtab01lVEhIekFUYkRzNWh5eHNWOXhleXVVb2RUb3ox?=
 =?utf-8?B?NHpBUThxTXZJd21hNHJZZkE1TlNpS0RwS003SHNFd2JyNzhHdW0wdWRHQUcz?=
 =?utf-8?B?RXkrYjQ4QklPMDVWbzBNekNXRE9Jb0QrcGV5UnR5Mk5ocVhrenM2MnZhdlJs?=
 =?utf-8?B?MEZyNUFKeUU1MTF6V0JkZDV6SkdFYXZXZE9sT2N2aUVtSXFvVkd2NWdmV2Fx?=
 =?utf-8?B?SnBuRlB0VGFsaWJnWHEvdFpYdk1KWGEwSFgvS2hpRG5EZFhvNkViOXl6UWZt?=
 =?utf-8?B?dDNXdmFEVkFVZStrcEl6WG04ajMzblU0bG1KRTdwa1JPYUxvRmZ0ZjN4aUlW?=
 =?utf-8?B?NEZaRjh3YTJweldjQXZ0dDRicTdJbUlhS3pQbnkyZ0JDVDd4S016Q2dlZ0tX?=
 =?utf-8?B?dU1IWGZacURnYVc1UGd3SWN3VzY4aTZiVEJQTDZjSEswYzNNWHhvbVkxV3RU?=
 =?utf-8?B?aWtYZ2lSaTZvekVsN2o2QVR2Q0ZDM1lIMlRkbmRHdlp1TEc0azJGMFhyNVdk?=
 =?utf-8?B?TitGNXkyMHdGL1p4eC8xSDVZQmllZEZOQkFKWDFiWXNtZ2hGR3k1cE9SVHJh?=
 =?utf-8?B?S2E2WThwejgyeTRyZ00wSVdyNVJhT1hjM1FqZERaVGlzaW1iSklVeUNMTnpU?=
 =?utf-8?B?eWpuYWxyY2JzN2RnWWR2UFVQVTdzQytLbXVsU2hCZXRLYTVXcXlEK01SdE44?=
 =?utf-8?B?RkY4YmtwazBMTmN6RmJUdWp1WVIyWk80OHlmWGV4NmI1Z1I5WjhPRWk0Mmp1?=
 =?utf-8?B?MWJRcXVjd3RYVkw3U3IwVzFGZnN5cSs4eUJ2R0dLeXFIbi9RdUlxakUwYzVv?=
 =?utf-8?B?US85QmltUmxSVjJnRkdscUZocTU2d0svYkF5cFo0cVdZcjlBWlFpa1pJRHhm?=
 =?utf-8?B?bU5reUNBaU5odnJTZENjZHkwbXB4OFRsWkV0dmozcFF1NGJUcUozSUxqYjlD?=
 =?utf-8?B?NG5TTUIvV1pHMkNFeWhWWGFyaGZ6cTNGMTRkWDNjR3I1UVRaZjJMYnNXdURq?=
 =?utf-8?B?WTFINnF4NEd1aXRkMmlqekxRdGt2N2dVL0N2U2pSNng5Q1k0L05BV1A2QVho?=
 =?utf-8?B?eDVHNEVQR1VWL1F5TXNlU0hFK2xyVTQ2N3FzSlBWS1dEd2I0LytzWFVLbVlW?=
 =?utf-8?B?b0RtckJ3anRXZzFOclVrUnVtcXM2TDVkKzcrY0tWL2t4SGt6dTZMK0lrVG1h?=
 =?utf-8?B?NVF5Vjdjcys3WmVOWUl4NW9BT0ZjYUwxUzFPMGR0eG1PY2g5cVFSVHBpcFdW?=
 =?utf-8?B?WHNIOG1lWEFXMWIvSm1BSmVEbGkyQ2tIbjlyTisxTCtlY0VOSGgzeEw3RWtm?=
 =?utf-8?B?MHNOL1NlM3J2aWJvelN2c2xoS1JYWWE3K1V1UTE4cnVDNVBJWEhyVXVpSEh4?=
 =?utf-8?B?d29OT2NyaVJsR05iOUg5VnEwWWhaeUM5L2N6NU5lYUxjZjJ3bHVnR29BdEM3?=
 =?utf-8?B?TDN1ZnR2TjFndTVUeW1lb2JMeXBpSGYwbHFDbTYzLzBjYVpQdFQ2V3gxeW13?=
 =?utf-8?B?UGFUa1NISFpqcFRWZklJOEZmMng2emJ1YWJXeGxBVzl0WXBZZ1c0ZkNxcHRz?=
 =?utf-8?B?UGI1OTZoYkhNOG9EeFc1dldjWVlZcU83NU50U0xBY29xREpWM3ZwdWVaS3Uv?=
 =?utf-8?B?amFxR28rZUt5QzV0T0l6eklsdXViT3lkeXgydHV2ZXBIMEh4Z09DWXRjMHVz?=
 =?utf-8?B?U2Y0UGExdm1FWW9RYmNKdTdzaFhKalQrajhFVW9UOWxMSHNuUDNlUmRYdHh0?=
 =?utf-8?B?K1JIclNkNjZqYmZjZ3VPSUltN3ZZK3NZengvQ0NGakRZR1VJNlRiNGxKTlBC?=
 =?utf-8?B?WGovUlkwQW9OR21QRktaVG4wRSs1STFpU1kxTkQyUWJ4WCtSSHU3NXdIbGk2?=
 =?utf-8?B?M3VkbVJ3WUdTcGJNc2I2aDB0YmR3YmNZTnlKQTErN3JyTW1PRmJoSHpnOEJz?=
 =?utf-8?B?dU9wRUhiTEhyVkd4ZTRlc0VLbDVFN1hkWi94RlpxS3lpZVJTRGpPcjNBRHpZ?=
 =?utf-8?B?aTdaZUFJY3hsZ2p1aEQ2M21jT2UvRXVaWG5wYTRLaWxEaEIrRVVNUW9IR25U?=
 =?utf-8?B?c2Y4VC9nUWJQQkZFWHpEMzd5Zm5TaDdHKzhrNytKQXlFODI1RjRhUWdDUXkx?=
 =?utf-8?B?NFNnNHJwKzZzMm9rZUdEdzJJS1dYVllya1dpcGhjeWlvUFVsM0orZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 650583c7-30f7-4adf-676d-08ded3918e67
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:24.6779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbfoKx4c1Ut70x6u5gZL+IXUfhe1fGNzAYU0ee0Z4gyODSenjOSUvp0lFVomGkzAgucYP8gZzsehC3iGaAcNeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9417-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 944EF6CE21C

Implement a `CoherentView` type which is a view of `Coherent`. To be able
to give out DMA handles, the view type contains both CPU and DMA pointers,
and the projection method projects both at once.

Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
method to erase the DMA handle and give out a `SysMem` view, if the user
does not need the `dma_handle`.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/dma.rs | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 200def84fb69..ab6504910e4f 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -14,14 +14,21 @@
     },
     error::to_result,
     fs::file,
+    io::{
+        IoBackend,
+        IoBase,
+        IoCapable,
+        SysMem,
+        SysMemBackend, //
+    },
     prelude::*,
     ptr::KnownSize,
     sync::aref::ARef,
     transmute::{
         AsBytes,
         FromBytes, //
-    }, //
-    uaccess::UserSliceWriter,
+    },
+    uaccess::UserSliceWriter, //
 };
 use core::{
     ops::{
@@ -1133,6 +1140,132 @@ unsafe impl Send for CoherentHandle {}
 // plain `Copy` values.
 unsafe impl Sync for CoherentHandle {}
 
+/// View type for `Coherent`.
+///
+/// This is same as [`SysMem`] but with additional information that allows handing out a DMA handle.
+pub struct CoherentView<'a, T: ?Sized> {
+    cpu_addr: SysMem<'a, T>,
+    dma_handle: DmaAddress,
+}
+
+impl<T: ?Sized> Copy for CoherentView<'_, T> {}
+impl<T: ?Sized> Clone for CoherentView<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> CoherentView<'a, T> {
+    /// Erase the DMA handle information and obtain a [`SysMem`] view of the same memory region.
+    #[inline]
+    pub fn as_sys_mem(self) -> SysMem<'a, T> {
+        self.cpu_addr
+    }
+
+    /// Returns a DMA handle which may be given to the device as the DMA address base of the region.
+    #[inline]
+    pub fn dma_handle(self) -> DmaAddress {
+        self.dma_handle
+    }
+
+    /// Returns a reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   reference is live.
+    /// * Callers must ensure that this call does not race with a write to the same region while
+    ///   the returned reference is live.
+    #[inline]
+    pub unsafe fn as_ref(self) -> &'a T {
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &*self.cpu_addr.as_ptr() }
+    }
+
+    /// Returns a mutable reference to the data in the region.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that the device does not read/write to/from memory while the returned
+    ///   reference is live.
+    /// * Callers must ensure that this call does not race with a read or write to the same region
+    ///   while the returned reference is live.
+    #[inline]
+    pub unsafe fn as_mut(self) -> &'a mut T {
+        // SAFETY: pointer is aligned and valid per type invariant. Aliasing rule is satisfied per
+        // safety requirement.
+        unsafe { &mut *self.cpu_addr.as_ptr() }
+    }
+}
+
+/// `IoBackend` implementation for `Coherent`.
+pub struct CoherentBackend;
+
+impl IoBackend for CoherentBackend {
+    type View<'a, T: ?Sized + KnownSize> = CoherentView<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        SysMemBackend::as_ptr(view.cpu_addr)
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        let offset = ptr.addr() - view.cpu_addr.as_ptr().addr();
+        // CAST: The offset DMA address can never overflow.
+        let dma_handle = view.dma_handle + offset as DmaAddress;
+        CoherentView {
+            dma_handle,
+            // SAFETY: Per safety requirement.
+            cpu_addr: unsafe { SysMemBackend::project_view(view.cpu_addr, ptr) },
+        }
+    }
+}
+
+impl<T> IoCapable<T> for CoherentBackend
+where
+    SysMemBackend: IoCapable<T>,
+{
+    #[inline]
+    fn io_read<'a>(view: Self::View<'a, T>) -> T {
+        SysMemBackend::io_read(view.cpu_addr)
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        SysMemBackend::io_write(view.cpu_addr, value)
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
+    type Backend = CoherentBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        self
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<T> {
+    type Backend = CoherentBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> CoherentView<'a, Self::Target> {
+        CoherentView {
+            // SAFETY: `cpu_addr` is valid and aligned kernel accessible memory.
+            cpu_addr: unsafe { SysMem::new(self.cpu_addr.as_ptr()) },
+            dma_handle: self.dma_handle,
+        }
+    }
+}
+
 /// Reads a field of an item from an allocated region of structs.
 ///
 /// The syntax is of the form `kernel::dma_read!(dma, proj)` where `dma` is an expression evaluating

-- 
2.54.0


