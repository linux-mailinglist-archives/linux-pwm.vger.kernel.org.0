Return-Path: <linux-pwm+bounces-9537-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b7SwGqXRR2rzfgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9537-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:13:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B77703C12
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 17:13:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=NbwWkxN4;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9537-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9537-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70D8B3002510
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBE3D9541;
	Fri,  3 Jul 2026 15:13:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022104.outbound.protection.outlook.com [52.101.101.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9553BCD33;
	Fri,  3 Jul 2026 15:13:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091616; cv=fail; b=StOePWSIV1PiayFs68RNYStK/uKUyRWes1stU3cn8vMQtrZvMBx8mhYqEmgybVm0BwxtqXYqkaWFYN70PJYIvt0GEqJoOCaJsgnQoE6KuCXkex465FhcQU+9axFFVo4B5zRhDvnxwXuRCCbfEK+95Dx8Cs6BGk5LitibQUhmglM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091616; c=relaxed/simple;
	bh=8dqGt1mCx6Aa7VlXQfBjFj0iGnV+zSmTZ2biLOV7wrQ=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=kBGTQXvVS26Oqb/BcUaSCZGgRAeA7YcC6gffF0lLU3dXP8XRWGBv7uRa5+1I7F5GpFUnY53VUjuqajJzeYH9aE7gDDSKbHtePFI2Ms+qrG456dGSuqIiSxiXYbf+bZCOJK46cMbp59ptirX5wLJaP624pA/Zty4rVEQkG6o2bO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=NbwWkxN4; arc=fail smtp.client-ip=52.101.101.104
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6kfctgoJiNd+2BO9ja9o7+JQVwA2epkrxVOtkOfkmj0iWr3NQguoKPlk1+GxlGrxdynnnejuv8psw4YBMrcJe6SqbMxr/4F5S/9nGHSY6XM930YuCVrw1S06XcViB/BxWl62byBrD2MoxVVHGH5WpHnzjB7Vp/LMJo9rDX+DjK3NG67D6DdSs8Q3iXmPOTe3CFPdbR7UZpP68lm4SQSBb0QV7iM9EsDEcEPqvElp06AQ2hiF6S0UtJ6aYF7Fv4Iy88CmDr/f376vxJtarn54gSJ43o87s+9+kDi3hj2FZ6s8jlBn6ykJBTwtY/MDLyHsP0OAn1FKU5CDQ2ZVfxgFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dqGt1mCx6Aa7VlXQfBjFj0iGnV+zSmTZ2biLOV7wrQ=;
 b=bakWRE8x2atXkWPf+NrgbAMrFKcgFc0KLmP77bp2UfZu+4p4pqdDmdQK9hh2oYn41/bwc53bgUFEjfVcEGs0EELxgrZVBTe32oxtKB3EjHNu5dZW2dUmYyf5jiwpZL/Nlh12dGqwm0aIwREsba0jKRKxisNm6e7BOjjnT3kWVkJSjD0B1cKm3c67ZM2JhV4lLYNAEfHsZrSNn2rCPKi2fNcIUalR1zPpbM7u29swNyXVhkvo63JbqlLTPYvqBxwIqmklPEQzx2kjeTIgvdsDS4GIXMEAFdX2Jr5aRHUo3W3P4XSGyPw+on32ptddwJKslkIBTUyqtD9qmgJxpJWQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dqGt1mCx6Aa7VlXQfBjFj0iGnV+zSmTZ2biLOV7wrQ=;
 b=NbwWkxN4LsRjOIdaY07PfsW+1x806UArWR+S5VeXI0vy4hpcjrOpHPuzYlUQzpqIFPMaoBYR8H5YQsyU1MLfdpSOFn3bTsSOARk/h8PnajXTyR+qKbQ/EjdxH2MawTIHXhC1fuEL6/0k1UH0bx/VrAlwUWUN6MSh5aScpP7rUYQ=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7512.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:39e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 15:13:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 15:13:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 16:13:28 +0100
Message-Id: <DJP180IRGOC4.IWGRMGLJRH61@garyguo.net>
Subject: Re: [PATCH v5 17/20] gpu: nova-core: use I/O projection for cleaner
 encapsulation
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-17-d0961471ae50@garyguo.net>
 <DJP0N5VGKR7L.2EFP81KLCP9UK@nvidia.com>
In-Reply-To: <DJP0N5VGKR7L.2EFP81KLCP9UK@nvidia.com>
X-ClientProxiedBy: LO4P123CA0112.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 48460807-ad77-4efb-8aeb-08ded915a342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3jiRN5CUN+0e5HJRKf0f0+CIHGZ1u0CAhLwhYVTJGHcgvgzdNLuXdUS/JNzJ6kP2KwVuJTLotB1DJEqv+VHAwn/DdTiVtXQFnReDSeJfBBUqCOJsUah37AVaMguWX/5PNx0PTOpEab3lj4SAywpIDN4/20eWcrTHRQ1sr6anDBlSSfZfjfGDg6MoC2cY2p3TJGaGqwkWPPhOJKU198CREzuYwPoKPDFiKnWCMhA66cFGPqkmeHSZpr/YkcCXWKl/yG/2/I+/qB5DO/e9aNRaQC04TympwEila9ne76IW6Pol9W4qkKcgaBGXm8+OO4oASqL0l/HUUYl0j7/CET0wBT5CH2czYBUQdGEi9Gh0GNY63OBYhlRLDsyoQ5mFYJ9fxS+QEuXMRn8bsJiSGJpI+qObIHAgDSASz+f6OKPIdI/HKpIc8iII2eIbI8ZokqI3Q/y9fQaFYrIMHdaOrwSuVfTh7kQL3dqNeFlTNBiOK0y9oe77Fos9gYBI84bSAXLas0qs1LgLvQSUtBAxn20RY1ZPTopG2Rv5qnw46XkMMBaGLEcqD9MX0/+vOJ2D/SRf8VUNozm95AqzQEgbqBvAHsakfgtEOZ9LPYYASLH4J+WO2roOgjunpH5KhtHm5nwam4wbW9r6v8prx4sTib0yeSyr6kzxJQc7nnDNisRmURI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUtuaTJYdGNtcC9Hd3AycXdSbmVhcHJvemJMUVNuR1o3WUx1ZkRTcFFuYSsr?=
 =?utf-8?B?VHpuOVAwWTRDZHZzeWZyRDZxTStONEZES1JhWjhDWFQ3cDRQd0cwU2V2aEli?=
 =?utf-8?B?THI4Mk1GV3Fidy9JSGp2TG9tcFZIM3hubGNKNnJucTczVlN5bDMvNWgzSWZa?=
 =?utf-8?B?d0V2d0lFcXVlbm9HeWtLNEwyOHJhL25zZmZRenBnSGtxUk53aWZaK2ptb21Q?=
 =?utf-8?B?T2xzd2pQNDNvSWpwN0w3d0ZGaUdxQ3pzQXVIblo3dzlNSEdNcHBKRVVVMHhL?=
 =?utf-8?B?em02M29DeiszU282Qm5FUGhJbDZlNWtTemtjUk94ZmUwUDJSU2NLOGpUUnA0?=
 =?utf-8?B?b25BSysvYWp3YWhGRTQya2JVWnovdlZrVXVlNFBGaGFxM0VWb1k1a2VJakh3?=
 =?utf-8?B?SGpXRFkzZlovY1l1RCtjTHNLV1c5ZU1qYnlNRjc0bmhLTktIQlQ5N0pYc21V?=
 =?utf-8?B?SmNTcklTbFJwNEpoNW9jeVFWZmpxdlEySEl4SnJhTitwY2lHQXVOaWZib1ln?=
 =?utf-8?B?NFpncnkzdXQ1UGxQanlKKzNpNXhERDBJY3ZnR1dJc0hCK3ZZRHRkazNnZkpl?=
 =?utf-8?B?b0dDWVM2aXR0N01PMWZXQTNWMUlxZVFJdFJLd0FzNGhqQXdhMzhZZ3NJcVpI?=
 =?utf-8?B?TjhWcW1NWjFNRUpiSTFUNCtsdks3QmQ2UE9kRjZoakxBMW82djVLemhRWnRR?=
 =?utf-8?B?QlhDRnhLVU9sOEU0OG9GVGdoRWp3cStYdGxheU9nWXlDNlZzdndUUit6aFZm?=
 =?utf-8?B?bktRU1kyS1YrUmwyenRTVmxuUjFmQytraWY0NHhkSW5haU5xSkJVN2svZlBr?=
 =?utf-8?B?czdFT0kxTTdnRFFJOWpTdHE0UEo4Q2Z3Q3N3TjNza1l2dWhlQ2ZkSk8zdkxJ?=
 =?utf-8?B?RjFEVHFHYzVBcktCRzBPMDRlaDdMWS9zb3VoaTJoQkhpdGo3bEFwQWlXbHRM?=
 =?utf-8?B?L3NXZ2FTbTcvSXVFY0t1SzNhdFV5NVZlRU1INDZmeFFxNEtiZEJQU25HWlN0?=
 =?utf-8?B?WWw3RWUxNlBKRk5MTE41NFJhSW1UTzNsaG1iNGxza2Vpc2hUUXc1bm1RRWE3?=
 =?utf-8?B?M1NqWVRCcFVOYTBUOU1Ra09yTGV4Vk54aUo1ZHAwTGVQNExjamtiV1JJMFRu?=
 =?utf-8?B?dVNQYmszWUFycmNmR0xtOXFLbE1TY214WVBZR0JUZFdHRHdZaU4vWENWcGlE?=
 =?utf-8?B?WTNWMzhOODlVZWdCTlRnSnJ6V2c4VzF6aGFWU3hTbDZ3Q05BbTZvMVZybXRY?=
 =?utf-8?B?ZG15VnMzdUJQOWg1OEZ1YWx1NU1nZTVaU01IUCtHQTBjM1RJTDdGNFNpYy8w?=
 =?utf-8?B?ZHV1aHJIR2tWTHV3TjNsOVFDZFk5Q1loY0VlenlZZkNhNmVSeEtlenRkYnFC?=
 =?utf-8?B?YnNFMnRuZ2gyK1dPSnhibFpIOXZFbkVaQmw3V21MQVN2SXdOWXZXcWpBV21Q?=
 =?utf-8?B?WmJQQVVsQkxkaGkxWjVHNmZkZTFqSStkWEJOL05iNWxTcFZzVXdsMGhaQXVy?=
 =?utf-8?B?RWkwUm5wYTNpMzZlSFhZNGF5NzQrUWFVMTU0VUZUeUlyNzc1aWZreEppdXE4?=
 =?utf-8?B?ZnpUdml1TUswMm9yVFZlNTFubUovTXNXcU1VQ1FRcnFBdStDM1F1VG5yUFNM?=
 =?utf-8?B?N3hzZUJZU1k5ZUlJSytNWnNnTzVuRWV3a0Nxd05CV1A0T2p4eHhid0d2ME8v?=
 =?utf-8?B?Q2NMcWtZSTNEMVRsemRjOVAyZjY2RFR5elBab01QRVFWNzBDcVFFTHFMK1hu?=
 =?utf-8?B?SWdXenR5RzVLWFBydHkrakJaMGh2ZE1Qc2hIanlxeFdBMHBGOStvTGEzcU5R?=
 =?utf-8?B?bTJ4Q1RrN1h5TGRpNmJERTNZYUdldDFuSkVsS3NZL3JwOGEwTzBqWWd5cmlF?=
 =?utf-8?B?NGJwcFowZFptUUdRMnROTXlvajlVR3VFdlRCckhTWm5EWktlT2JUUjJhaW5j?=
 =?utf-8?B?RlhRcGJDWW95S055YnVYVlR3MStBUUtpejh4OS9CQkxTTlRGOEJHR3dZUWtD?=
 =?utf-8?B?cHQybGVkZTRTSUR6WnIxd1ltQ0ZQYUxBY3JTU1ZqQURZVDVqSktiMTRNWUxK?=
 =?utf-8?B?SDFvQStaZGxXNUozaXFqM1F1TUhqMWx4Q3FYMHNMOGFsMUlTR2trZW16Vytv?=
 =?utf-8?B?WnI2Z1ZKUmtMUGNIckRJclEvU1BLUU0zVTZTaUpIMzV6VHpNUTl1em8xOWZ4?=
 =?utf-8?B?VUFLbGU4YTBWTVhwaGtZR3hPSXNHWjFESEhuSTMxQ3o2Zms4S3JRVFVDQlU5?=
 =?utf-8?B?V0dkUGMvR011Y0N2aVg3RXlHd1Y3a2dQemNwZFlHaWloRCs1cDVvTkR2TzRi?=
 =?utf-8?B?UzMycHBwaENEbUdRUjRUcVhoSU5mVG12eUpRTUl5b0t5WEllQWlGZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 48460807-ad77-4efb-8aeb-08ded915a342
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 15:13:29.0739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Xa3Nw5lQ3PHHQ2v0WlDbuWeBzPJ5sWhMwfNqmmimXMXGWqCSf/pObIde+KLX6CgcZjlH9FMXqQ8T9/7L+Wu4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7512
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
	TAGGED_FROM(0.00)[bounces-9537-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:acourbot@nvidia.com,m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61B77703C12

On Fri Jul 3, 2026 at 3:46 PM BST, Alexandre Courbot wrote:
> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>> Use `io_project!` for PTE array and message queues to restore the proper
>> encapsulation.
>>
>> The remaining `dma_read!` and `dma_write!` is now only acting on
>> primitives; thus replace by `io_read!` and `io_write!`.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> This is beautiful. :_)
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> (the memory barrier concern raised by Sashiko looks real - and IIUC was
> already discussed before - but not introduced by this series so let's
> address that separately)

See https://lore.kernel.org/rust-for-linux/20260609-rust-barrier-v2-3-30fcc=
48e1cd0@garyguo.net.

Boqun already queued the first two patches for 7.3; Nova can start using it=
 next
cycle.

Best,
Gary

