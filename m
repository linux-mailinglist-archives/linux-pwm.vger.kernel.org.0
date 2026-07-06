Return-Path: <linux-pwm+bounces-9602-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4wN4JmyrS2oOYQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9602-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:19:40 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6427112A2
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:19:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=scPapFyr;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9602-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9602-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 324013576C8F
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20CC434E2F;
	Mon,  6 Jul 2026 12:44:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021091.outbound.protection.outlook.com [52.101.100.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6094314B7;
	Mon,  6 Jul 2026 12:44:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341888; cv=fail; b=Qft72d7p9lDrByqRyzmuruUvWr8A9/aiJ4UXAumJH4TBOH9cZjnoDJj3NkGJdl7VyOWA8cErvGTIvRbl+yxatVYaXRnl/3h7GM4ciruvSEmivFP5UqToaMn/Ru7PFc0QMrYasxwtc2+/dqJLMCKIm8/CpUu8OdaVChf9vc8lPz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341888; c=relaxed/simple;
	bh=f40x2uAgYkZFTkSBXEl7NLxZFkKxwyMRylJreq/QsEQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WNpkAkAjZ0Fu5iacpE+VKm9QGDtJ95+VEao7zG845mwzN6iy7s2zEQiV5yWTb5gKUshsS9LA9jQbQbpOeF4wocQUMlJMBBgLIa7DOJURCpYqqDug17JuiPXHUJAfZkCl4XKUT7GjeWEjjQDQNj/ABB7WZJacuTzu7KK/WqWca7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=scPapFyr; arc=fail smtp.client-ip=52.101.100.91
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LhCRDy7mAzaKL1zJMJdXwpznYaAM16mM8AFqNai3ZnP0l3yGqi2VK3P2dNYaUJ8gDcvPvKw3Rfbm+aiTX4ozlV1gOJxYC15HyPECgisvquOftK34Wto7yHqWScPRpC9xl+tS/Xr+qYR4CYt+WwT0c//ZF95zHUNIE0TXPWR+uaXww9mJEGanCCo1yHwoogbfK8ANWIAOSzscPLDRGYl+MInT6hfZLW9sW83A1rL7SwmCQiecJyV4wtM21sx6ABau7Edu4q9ccnrcHM7tslugU+gx7Fv5Ihj03r866ciDffT52D1UwSFb43Weyrifvh5hMNzahZOK7bluJlB8RlA6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX3mB9fqNs2fzdtIUwXeB9H7h4f0nVPMqbsdwwZUth8=;
 b=Z+dEbnJMd3gFtZofQ6rnEeypuyHat80rvSfJ36t9xlKlRMU97lWOn4VBOVOP7aaQzrAW6P/JQDHVouT0h+f+2TEXYZtWkx/lEmk8IFKdgHG6Fpew+GUjEvOcQA7DsrF6nn3jVmOebLw0s5/yNDP7uQT9+9UOXSC+aHgBogcT59bbrf+u86IjuknEwrQUQlCJ2c7qM6k3B0+DPdmuBDjP+YtQ5Zz5WIgfhKFoLnNpvXq0uSHuLI13N8ujRf90XqAe5JmlpnvZ8QSW4kvxXDSng8hURp0PYtKuW0xQL0vG4WKElfgQ3izw7nRKYZZ9zpokce9e2MguaA1k/BSwogfYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX3mB9fqNs2fzdtIUwXeB9H7h4f0nVPMqbsdwwZUth8=;
 b=scPapFyrP4n8vSjeY0vQCupGN3x/4zJ3YEZ4Sc0jHotCikXNPBEu99z3ZF9FirZTrJXx1kHWuwGDAW+T+g6yHKjjGN4YFhlC69lYuXXcMCjBhe4rNXi6fsDxijqesl6LcOKkiUEx91eqHJVMJ0MqVV3TL8lVZ2xHg5Obm9i0cLM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6188.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:33 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:33 +0100
Subject: [PATCH v6 20/20] rust: io: implement `IoSysMap`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-20-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341864; l=5604;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=f40x2uAgYkZFTkSBXEl7NLxZFkKxwyMRylJreq/QsEQ=;
 b=9Ou0aepdbSz67RBYa+t07D1TYuA2OCtKfvPTgNCuD2Bpidh/xyMMQ2BFkzCZXoopi65PKjdKD
 IuUHVEkPdXTBlDztdvIBReAVoTl0PWQ7fGMVpa5mMusOf3GtzVcUCfc
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 29cd8c6a-efdd-4819-295e-08dedb5c549f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|22082099003|18002099003|6133799003|5023799004|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	9rotePqCEXRPjyxjsScaBj64tCCoQs0Z+o0W19uhCjpl2QiOxuTTum9Org2jyPGR0s3wRCtKI7MLmE2thM9QoJJIsX9CkWMgzvIN+PU99QslgOmsgJ5ieaPun6eoGo49+81uEWdTMtkR97OfEdeCwWHHVs+1E8dXNSx7FagTgDF5DbTm/ltWW1eSz84l4GrI9SVuUzFwk9g/bCRRZiXNQQdSU/ucuxgl2KXLbqa9xAfV27NSMTUyNUG9nTIuMsyJ0uZTKWzb11adTG0VvKKzQ9BHTU49TegvP3oT0iUkpg2mXb7Aw+Qz4NesVw6ZhJ1h8ZTsVyQ29Ft6PjviJcKm/B2UmAZBu4jmlx7In7KLdBqPN1YuX4VfIRb1C5BNDOfGDG+Ull+hzKjNlG4eDjc4BXUKbeEiN0MGHMb9XreK8fN55Rzxy4j57ytIPZXICTjUn+IHLt+uW2MkcTvwt7eXj+dTD1CWuld95uKYIOqYGCnQMvRlJ/sFMHIrIe8QflpYvoaKNvE8FauO7nVx2I2a5/dkLFBorT82YDg6e5m86I7IAMT1+xa681+G8Tk9RbGWxSCCgNUHy33fcGvJ5/j4+iQPsy6qcNY7WaPY82HJSqY+HbEt8P7iVigBR2hhG12cmiI+v406To6QIxq5NjMSplG7VRlHYSW6cLkNZkVh6h0rv3+1L1tLNDYWPmLCg0MkBo5R4HlkHFFBtOHV1TBw1Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(6133799003)(5023799004)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUdDTmM4a21HMzB2bHpqNnlHRGMzVFN5aXpzSDJCcmRpTGdRREo4YVNtZENq?=
 =?utf-8?B?REE0MkVqTXY4dDR5QmNLTFZ0UjNIZklzMGs5TFUvdnZYSFo2b3FzNEY0WEZj?=
 =?utf-8?B?Y2Vhb0pUU2Q2YUkwOG13dXlDbk1CSHFUOVMxR3NLVVM1am9UdEYrZHJUNzVy?=
 =?utf-8?B?S3R6V3AzQlJ4MW1KUXM0M3JGZ2NkN1IyVnJ2QTRTSWxNTzdQR0VXTlBmNjJ6?=
 =?utf-8?B?V2xOWS9DQjJkMXloT0l3Z3ZjOVh5cE9mZkYzMWovRm5zbUt6TU8rR25uV2t4?=
 =?utf-8?B?OUt5Vm45M2w5WUxGQ2tGbXJSVDNGd3lJVjlES1dHSGZTN2o3S2p0S2RKczFa?=
 =?utf-8?B?dXVXSGF0blI2QTg2TlNOVldnLzc0R1Jrd042TmhkNnZ4b2hsRzFZaDdjY21S?=
 =?utf-8?B?S3lsNzRPVXUyREtSTzloU2kreWhZNkl0MFdXWE1LaUJHWmc4MENTcnZKd2RF?=
 =?utf-8?B?eGJYQWZ1N0RCQkt3dWJSWXNLajVESUN5QWdCR0w3eDlsajdHWkdIMm10bGUv?=
 =?utf-8?B?YjdlMlAvYkNwZ2g3SUZRdXZMU1ZvRDN1bUxXbk4ybXhQQUY5bmp2clBFUzhZ?=
 =?utf-8?B?WTVJVktuY3dteEtWWnhLaEIyMFRNWjN6ZEpzdVNsdkx0WDkzZEpleE16b2hJ?=
 =?utf-8?B?bUgvMVZIOVlvVXljSE5uYUpqc3VMZ21yWXdOOEE3TnlZZmFRQnpBbHNOSzlT?=
 =?utf-8?B?Q2I5dHRhQmVMa0Q4Ym5NTFFWVWhwZTJmTlJidllSVnlrRWlBOVU1T1JteEFV?=
 =?utf-8?B?L1NsanlZTDdVcUYycTBZbXFMV3hiWWRjRWp4MndBY2huMEpLQmo5cC9DV0kw?=
 =?utf-8?B?MzZaZy81MVpjT25GTlY4aEkrN09aOVJLUHRMdGU0eDB3QmRTenFlVHNmbHNl?=
 =?utf-8?B?RDBhNzFTejRxWkFnREFsVUhSOEdjb1FKbGVyNk0xc3BKbUJxNmcwMXVoRm43?=
 =?utf-8?B?UUdXeW1JSVo2R0pXWkZhc05XM1NSQWF5cVh1azhuUkh4TnVJQ2xHK0hYOHh4?=
 =?utf-8?B?STdiTUxIZnI5cTlJOERKRmlQSmVDbjZaTkZwYzRJVUN3WFdINGRBVldmVi9K?=
 =?utf-8?B?dXJVYUp4QjA4VzczY1c0anVOZzRnc3gyYm5lOUNIdTlvMkpGQURFYm9xbDBq?=
 =?utf-8?B?VmFIbDRLMFlYazI3VldBeEpkbTE1MnlwYkYzNFI0VVhRN2FsVWxxSHc1MHVI?=
 =?utf-8?B?ZHpDdkhwdjZkL3VEaDVwdmlkT3E2bkNCQTBCWVBTZkFHWnBBWGxGNWt5eWJB?=
 =?utf-8?B?YURKdFBSVHphSnpDUjBvL1ZLV1dqV1dPUjQvUlJvbTArcURXTTR5WjI0MEFI?=
 =?utf-8?B?YlNvK2FNc0c5WXBneTdqSXV6MnVCV0xLSDNsdC8za09ib2VxSGdaZTJ2Q0Rw?=
 =?utf-8?B?c0t5Y2k5cUV3WEtyZzBDcGJ4b3JYb0xDY0ZGK2poVVdDaTZKN1d2a0FYNkNr?=
 =?utf-8?B?ZEx5SGgyYkhJNGVLU1VlU0kweGs4M3QxNFlxTUZtdk9FdnR4cFdQUG5WQ0tO?=
 =?utf-8?B?ajZ5K0pTYWJ4K3FaeWtkd2ZER0xUMUkvTVBVeW4xZWdncUZ6cjVBUVl3dVNJ?=
 =?utf-8?B?TUZhaDNCS1JjWVU3Sk9sZUtycDFURFcvMmUrU1Q0TWpDNGpuZFRrR1NsSTI0?=
 =?utf-8?B?UWpYZlgyejFuVS91UGgxTmxHaVBpWXlXUHQ5WFlBOFJlQ0dTK2ZTM2k3ZE1u?=
 =?utf-8?B?S29hMGVLSGtETVY5Q2w0ZHZmdjBPRm9hRjJFSVFZc29PcFh1QUhaOUJLRGxF?=
 =?utf-8?B?b0h5U215OGNmNDRvNitmbUZYdUwyVk1qMFBsMmhRRlB0SU8zWUZsRE83QnZ6?=
 =?utf-8?B?bnIyaHR4NGxYc2JRNzZtdVh0am95WWl1SDd1YTBzZVBwQ2tBNk1hbTJoa2RN?=
 =?utf-8?B?VXFrOFRWQ0psaVN2ZVhHeVJqd2lOaTVHRmliY01TM25EMmIwRmxDaVMxVGF2?=
 =?utf-8?B?L0RGalFwVnR2Zk5jb0trem54OFovRWF3SGkwdXNSY1ZTTXE0VjIxR2ZRMHpI?=
 =?utf-8?B?TTdnSFFHOFZJamh6d3ZrcWM5MUFrZ2FtUS9hVHFnREl6OFhLaWhMSW1JWGIx?=
 =?utf-8?B?dzUvNHhnWVJyeWJTNmVQVWtHY29VMjBpTXdNeWNjblFLd1pBL2tkeTlUYjg3?=
 =?utf-8?B?RGhGUjhpbHA5L2xvYnZxdzhQUlFrMkIyc3YwYk4xdndYM2wyc2p3amI3MnRY?=
 =?utf-8?B?QjdTMmpZMzVFT3FnSkZwTXFXVTlpOEpVNThwS21RVXBaQlJMaXRlWklzdzFy?=
 =?utf-8?B?T01HVVNPSEtDUHpsMGJlVTlLNzZ4cFZQbDYrdzdKUWhQdFIrYkw4L2pEZlBK?=
 =?utf-8?B?WXZCQy85M05JR1BLY3NUZnZieVlMVDk1M3NxTk1paDladzZJbitwUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cd8c6a-efdd-4819-295e-08dedb5c549f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:33.7138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zR0n9a9KyfZINkeJgml1x2Yo++LMIOY/pJAJWJenfAJeSYhMBOy/1wV6s1SdZRfF1Si3QkCBqPUpqMLRWShaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9602-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA6427112A2

Add an enum as sum type for `Mmio` and `SysMem`. This serves similar
purpose of `iosys_map`. Thanks to Rust's type system, all of projection and
struct read/write can be handled by the generic I/O projection mechanism
(i.e. `io_project!`, `io_read!, `io_write!`) for free, and there is no need
to provide things like `iosys_map_rd_field` or `iosys_map_wr_field`. An
enum type also makes it very easy to construct or destruct.

This could be made more generic by implementing on a general purpose sum
type like `Either`; however this is kept specific unless a need arises that
warrants this to be generic over other I/O backends.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 9df4e982c5d8..7c9f7b85bca3 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -1465,6 +1465,143 @@ fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target> {
     }
 }
 
+/// I/O Backend for [`IoSysMap`].
+pub struct IoSysMapBackend;
+
+/// Either [`Mmio`] or [`SysMem`].
+///
+/// This can be used when a piece of logic may wish to handle both MMIO or system memory but does
+/// not want or cannot be generic over I/O backends. This serves a similar purpose to
+/// [`include/linux/iosys-map.h`] in C.
+///
+/// This type can be used like any other types that implements [`Io`]; this also include
+/// [`io_project!`], [`io_read!`], [`io_write!`].
+///
+/// [`include/linux/iosys-map.h`]: srctree/include/linux/iosys-map.h
+pub enum IoSysMap<'a, T: ?Sized> {
+    /// The view is I/O memory.
+    Io(Mmio<'a, T>),
+    /// The view is system memory.
+    Sys(SysMem<'a, T>),
+}
+
+impl<T: ?Sized> Copy for IoSysMap<'_, T> {}
+impl<T: ?Sized> Clone for IoSysMap<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> From<Mmio<'a, T>> for IoSysMap<'a, T> {
+    #[inline]
+    fn from(value: Mmio<'a, T>) -> Self {
+        IoSysMap::Io(value)
+    }
+}
+
+impl<'a, T: ?Sized> From<SysMem<'a, T>> for IoSysMap<'a, T> {
+    #[inline]
+    fn from(value: SysMem<'a, T>) -> Self {
+        IoSysMap::Sys(value)
+    }
+}
+
+impl IoBackend for IoSysMapBackend {
+    type View<'a, T: ?Sized + KnownSize> = IoSysMap<'a, T>;
+
+    #[inline]
+    fn as_ptr<'a, T: ?Sized + KnownSize>(view: Self::View<'a, T>) -> *mut T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::as_ptr(l),
+            IoSysMap::Sys(r) => SysMemBackend::as_ptr(r),
+        }
+    }
+
+    #[inline]
+    unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
+        view: Self::View<'a, T>,
+        ptr: *mut U,
+    ) -> Self::View<'a, U> {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => IoSysMap::Io(unsafe { MmioBackend::project_view(l, ptr) }),
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => IoSysMap::Sys(unsafe { SysMemBackend::project_view(r, ptr) }),
+        }
+    }
+}
+
+impl<T> IoCapable<T> for IoSysMapBackend
+where
+    MmioBackend: IoCapable<T>,
+    SysMemBackend: IoCapable<T>,
+{
+    #[inline]
+    fn io_read(view: Self::View<'_, T>) -> T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::io_read(l),
+            IoSysMap::Sys(r) => SysMemBackend::io_read(r),
+        }
+    }
+
+    #[inline]
+    fn io_write<'a>(view: Self::View<'a, T>, value: T) {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::io_write(l, value),
+            IoSysMap::Sys(r) => SysMemBackend::io_write(r, value),
+        }
+    }
+}
+
+impl IoCopyable for IoSysMapBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => unsafe { MmioBackend::copy_from_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_from_io(r, buffer) },
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        match view {
+            // SAFETY: Per safety requirement.
+            IoSysMap::Io(l) => unsafe { MmioBackend::copy_to_io(l, buffer) },
+            // SAFETY: Per safety requirement.
+            IoSysMap::Sys(r) => unsafe { SysMemBackend::copy_to_io(r, buffer) },
+        }
+    }
+
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::copy_read(l),
+            IoSysMap::Sys(r) => SysMemBackend::copy_read(r),
+        }
+    }
+
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        match view {
+            IoSysMap::Io(l) => MmioBackend::copy_write(l, value),
+            IoSysMap::Sys(r) => SysMemBackend::copy_write(r, value),
+        }
+    }
+}
+
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for IoSysMap<'a, T> {
+    type Backend = IoSysMapBackend;
+    type Target = T;
+
+    #[inline]
+    fn as_view(self) -> IoSysMap<'a, T> {
+        self
+    }
+}
+
 // This helper turns associated functions to methods so it can be invoked in macro.
 // Used by `io_project!()` only.
 #[doc(hidden)]

-- 
2.54.0


