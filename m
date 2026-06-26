Return-Path: <linux-pwm+bounces-9407-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vwtrCxWRPmqaIAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9407-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:49 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9F6CE1CD
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:47:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=OQVPOwe8;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9407-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9407-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 699F6309403C
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220433FADF1;
	Fri, 26 Jun 2026 14:45:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353773F9F43;
	Fri, 26 Jun 2026 14:45:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485135; cv=fail; b=b98A7NqgRmTFO7l0n6qMg+1iwHWsu4uUfduqSeS5izNnTnwbctmSzFUmDo93Rm0SQTXWciq07JVVaSDzVSVFYSidihsP2u1OESqHQoPfvXTwCIJJVx8mkZUMoEwSR1wl4WidFzC0CwwfG9hZyOAzAhr348h4LLuWspbE6eYFIFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485135; c=relaxed/simple;
	bh=D5Fw9TwoCkMt+yP7LwaepCYX57d5WDs5LMk//8MDd6Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OvK7gcg+mVv6l0y/RHuwayONPzIlqcf6hMvJ1kwnlqlYvG+7IxfF7P+qVAeIbuzgR5FFb2uI3NCyVKjJXVuucWeYkuJa0D8gctDwViRXpKP1kcssENPn5+wRgMbBflPzLufqrDU7AiMaunMHlIBqXoqu6lUN/1PZjxyTMs0hU+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=OQVPOwe8; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRbwAkjpQSPcOWGbh1FuLyS21ENf/wcYwTKTOsTlLVLhmM7mXVKhZWki59cEl0tC6PN6d5E/+tHH3lSGR1k2UCJiQyQAd+LWiTekjHNrFls9zSo5EefsCF9FhQn+bg1PoPYk44gqTtU88Tx0nebCI4dxnbHHPi20wxZjjuyHt8b9yAALAx+5NsMqDn3BLFTLSHjeTYIQzXFUp37pqT1nsIX9sFiK2HmxavI7HoyKpqjLUc3IdSspe2Xptd29HqgXs5EXI1JDOiiIX/LpBXEXe6Td8G9As+XEzjfwEJ6rKltce26ghhDKbQf4lTqCz4OkVG42N0GI8dDGTNWElFC05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWZ2G8D3CqR3gCX2nvEyaibZKhARAqjf05cTWG4mI34=;
 b=hwEoEtbZMx4zKi/5RMe/zheSQfeWnbuzhWl/HP0UZzS1+QvIHqMEKN+z5Ov59KxKiRmXs7xnVHCoalDPlZUC8YWTNc2VcaMp+5z0sdVwKt1hAz64xTNE2tZYz/3pDruwyA4xX/xlyFHs8WutAdcVkwE2IM1RGAZItpQ4rueTDWJA8ya8NoRBS9xm870KWeXXwOQDhCuwrE/Ob4jKhJq7gdIBplkYPvioj3eKC/cGdNdJjqE6smdy522z3cWI50j7g2QlXjUBbCrXIhoNLWzlEwSmVEpy1Iu+9o8a8AcmqWr/zxXFqYcJhKwgClht4qAFhLBixk/AY4cKcpNVX9nIBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWZ2G8D3CqR3gCX2nvEyaibZKhARAqjf05cTWG4mI34=;
 b=OQVPOwe8k90b/ztPXVITnwR427H5d/U2FOKAXKpL64zpkf7yP32R4a6QSWE8FCQGmTR/AXC72d6yYueTv6EQYHUgXHR7Y5GWAOVrEIdmYZAG6Q3V1hpSNdtsevszQv7CxUY+jJef/8Hml5gpkJjSVds4mhsnJU+UAEAQzQFugEM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:22 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:22 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:14 +0100
Subject: [PATCH v5 10/20] pwm: th1520: remove unnecessary `deref`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-10-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=1738;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=D5Fw9TwoCkMt+yP7LwaepCYX57d5WDs5LMk//8MDd6Q=;
 b=OZR0gDstQx63ZgYMmRIl2MgPef+vr4ltwbPmgXrJ0HDn10dRMo0DU9oe8vSM26lsNHXG3CSdl
 9JnLbe3t8p4AQtPvaT9qZW3EjY5+IgQguUDSC8/FdzOSh7a/4q0TBoJ
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
X-MS-Office365-Filtering-Correlation-Id: b45f40bc-9600-4413-7981-08ded3918ceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	oaBZzrPYl5xJYqE0M7xrREl0eUM+iAzGdeVKQowJQxIND4cusXsBuTBM5pugkuRaKw0fxZ5iiE/dP9FitAfWPXVsEPV4rFzBtYnfBlS7i+RWptTP5wPxqBDbxncOKa/Q9Prv6x/4p7z2mw3h9agVCUMX76bxDeyyECAEpLsKltebroGbmLanKaQuRXxsqU4YhkevCtphsP1G2iQqzfdSTb9WNSVNNvQUL2nq4CUT9mTrW9ZPBUWmYp3ehixzHAGZuRKcCCo3XQiKMshZVQ/MzumwZcPfmf2T9m+GAXue3/EBGpV1FPdD4SPRiWkP3thh/dn+qQzznGQc2Re7RSAf2C57JrSUmEW2gOuiXxzV9kn151QZowvwPtJeeAEt/dWk/3rzonyRwVCasJ8+2UqTdqdXWWOXNAE5rLDi5DqkNixNjku1sbRGUjfHJoaPW/oizCnqA2Zk2+9qSItvDk+sMlMrXXGEnwEyuvPRrucV7pglnBy7AKza+X4DYi6w6HqQjthYA5fuGZzH+b1rEHL5Iz1CiVHN4rYzLEvBkdjeVhyurlYnxLwCC3FPDrRhtbqzkmwnzFSvuva8ATqgJEtUPoD7cPZ+P6lJnEi4PRcjFVM4kvT07JGSL+5YVoUEHQRi+Idk0qbZyzUPQV2IuS5DSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUV0Q0tzL1pDQldBd2R1U0NweUxaQnhOdXhGdXEwYkg3YVFFa2lub3FYSTgy?=
 =?utf-8?B?b3ZWT2p4ZVRoLzJ0Z2NGczZhaG1NSm9DVzd1VHJxY2JHSTdUNUVyOUwrL1Nq?=
 =?utf-8?B?amUvUERmUlhJNFptOHpsN29uU1lVcWE4MHJzQkRHTDhPdHFCbmo0Tkt2ZVo5?=
 =?utf-8?B?aGhjL01pRHVTeVp5SktmaVREOGVTSndUTUx4eDIwMGY4R2RrZWNXU25SYng5?=
 =?utf-8?B?Y3IrNFIrTEY1cm11UWVBYzUzZTE4T2xsT0JZM1JDaE9QM1N5UzZEVUQ0V0Fi?=
 =?utf-8?B?emFTWjN1akpEOGhaMHBXRkU1dnRVVjE3QkVCcG5CUDNnYXJhQmErZEJsSHBD?=
 =?utf-8?B?MGJ2bmFVSHhhaE1GTXozWWtHYTBKWmkvYkRTUTRmWUl2YStRV09TTUgzZjVY?=
 =?utf-8?B?OFA1VEMvaFF0Nk9udWhNS3pIZ0VrcGVJZEVZdDlFVUdPYXZrYkdueGRQOWhD?=
 =?utf-8?B?bG5RVkkzQ0c2bjdwczVzcXZwcE85akdBSlZLS2dBUUM0eUx4TktvaTBRYjl5?=
 =?utf-8?B?dWd5Ky9MM2NZWVhPNzJIcUVtTkFOVStqZXhKKzdxeGhDZEMxaVE1RXBYdzlZ?=
 =?utf-8?B?c2dXR1pWK25kcDJpcUpYM0xMNDFTZjg1WDN5QjZ1MXdtZzVRbFI3dWU0a3o1?=
 =?utf-8?B?Y0pWZGpxek84K2VwRnljNUprb0hsdWd5S3VtcUU0STkvNTJ4eXU3NXo5a3pT?=
 =?utf-8?B?S0l6cGZhYzgvZS9jM0c2RExYVzJrd2FxUDhLVUhTS0djYXdqRkNmRFN6dlBj?=
 =?utf-8?B?cFdmTm5KQTdaUlY3bWFTRjhnTHM3dDNqdGJlSzJUWkJlcXJnZGtrUEZOcUtz?=
 =?utf-8?B?RzZPbVFxSDMvL0NTcTAvS053MU9wQWp1M2tramFUSHNqZGRtb0hMT3h0U3lE?=
 =?utf-8?B?SjVScDhqQ1RWMmhLTEVPcU55cVZTd1dpTXJCQ2cvWG9Ia3dWM3VTVUJyZkVy?=
 =?utf-8?B?UzZaYTZNdW5YZ0RlcGp0QzR6Y1MyekI2MEZETzVCZG5uSmtUT3h0ZEIybGpm?=
 =?utf-8?B?VmtrYXFibWJnSWduOVl0OTdLK3Jib20wODhWdzdoNnFlRnpTY0xYendWcEQr?=
 =?utf-8?B?d1lkVGxBdGRrdmg1QXJEcXBsK2o2c2JzbjFjbjRRN1BSU2x2Qm9pcEhlcGEr?=
 =?utf-8?B?WUNqSXdHWXk5RW1GanltN2M4UDFJN1JWWlBVQ2F5a0IvcG9DNlN6SFZBWmlD?=
 =?utf-8?B?ekdCd0NIeFdWa0ZCSUZ1dzFybSt3RHdvNi9LTytzQjE5QWN4SG1PMGV3V2tW?=
 =?utf-8?B?WE16SVpCL0FIQzRHS1hab0JjYUxqVWtadDVLeTBrV0RoMmx5YSs1MTNUb0JM?=
 =?utf-8?B?QTlHY3NYN3RVaG1CY041QitYdkNHN0dZalk4WmVHKzY2eFhkcXFIT0VPaTE2?=
 =?utf-8?B?ZnhIam44eW9hT2ZiMDdZZkNJYTZ2UUhsY0hCYU5qdXNCWVhXMG5HdE9oMUk4?=
 =?utf-8?B?QVVwTVkzdXRxanoyYWw4bVhybTVubEJPZ2JPc0dRSkwyN2hFT04rRzRvTzA2?=
 =?utf-8?B?ZXZMRVFHYVpqRTEvZHBacDU3bnZQUDh4UzFycVM2VGE2REFsYWNYS3VmNmJ0?=
 =?utf-8?B?Z28xYmRqYW5JN3VNZXVyMm44S3FmUnYwVXRDNGwwQnluNjVDYjE0N1VaWWY0?=
 =?utf-8?B?THRoQ3k2T2JJNUZuTHBCdFpRRHhrZ2hwd3F4OXVkeEl2MG1pRzhxcnBJb3pl?=
 =?utf-8?B?eWJiTGpIZkE5ZUJIVVBkbktsd200dG41cXlSTlZuNVowbXk2UFFaZHpwVHFn?=
 =?utf-8?B?VmdsQWJVcVZFcy9rSVA5TFNFSTQ0cFYxa01vbFdzUHpLVmdFdTUxOWhnYXY2?=
 =?utf-8?B?QTYyQklXTnR1UysvSWN1TTZLN1A3dGRvMmV5SFhENjZkdEdCLytDWjlDY3RB?=
 =?utf-8?B?eTN3RDU5ZEtMd3dKUjdLbGQzazJFNHNxYjM2Qk5ZT0N5S1MzOVh1d29odUJu?=
 =?utf-8?B?YlgvcnZwRE5ObEIyNzFuSVpRYmd4TnVqcnNSMzRSOVR6ZlhUeFdIcS9JT1R2?=
 =?utf-8?B?MnZIUy94TEtOQlRlVm5lUEVIdUFMUGk3WkhTeW8xcmNWUFlleEZHZG0va05l?=
 =?utf-8?B?Mm5HREViR1diMktwUG9pT3Z5QmNuU1NZa0RmcndoK0hiSkE4ODVNemYwZTBD?=
 =?utf-8?B?NVBpUm5uWFd3QXVFNnk4SVlET0RQN0kzU2kybkxzdU5qMTdFcVNyODNzckNT?=
 =?utf-8?B?VmJOakRKdUw5ZWJUR0RDSjY0Z0hDSHdBQ09Uem5FeWxEak41c1pWZU04aWxz?=
 =?utf-8?B?eHI5UmI0dTRaamMyRFZvdklxam5ZN1YyNlltS292MjVKYWlXSjZvV0lwR1Zq?=
 =?utf-8?B?SHdEakJraDd5b2FtTlgydG9RakQ0UEpaVkg1TlJPaEZzZ3hnQjhPdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b45f40bc-9600-4413-7981-08ded3918ceb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:22.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIzWVRW2kp8Ef4WvnwN7vi+179PPQtPy8qwzOCNZFsE4vDEZHOU0ZYdI42LEB0JINPDiiTygUUgoHtc12qkvBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9407-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5C9F6CE1CD

`Deref` is automatic and should normally not be used directly.
Also, `IoMem` is going to be implementing `Io` directly, so it will no
longer to be implementing `Deref`.

Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/.E2.9C.94.20Projection.20in.20dma.20bus.20address.20space/near/606672061
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/pwm/pwm_th1520.rs | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
index 3e3fa51ccef9..022338d17218 100644
--- a/drivers/pwm/pwm_th1520.rs
+++ b/drivers/pwm/pwm_th1520.rs
@@ -20,7 +20,6 @@
 //!   this method is not used in this driver.
 //!
 
-use core::ops::Deref;
 use kernel::{
     clk::Clk,
     device::{Bound, Core, Device},
@@ -213,8 +212,7 @@ fn read_waveform(
     ) -> Result<Self::WfHw> {
         let data = chip.drvdata();
         let hwpwm = pwm.hwpwm();
-        let iomem_accessor = data.iomem.access(parent_dev)?;
-        let iomap = iomem_accessor.deref();
+        let iomap = data.iomem.access(parent_dev)?;
 
         let ctrl = iomap.try_read32(th1520_pwm_ctrl(hwpwm))?;
         let period_cycles = iomap.try_read32(th1520_pwm_per(hwpwm))?;
@@ -248,8 +246,7 @@ fn write_waveform(
     ) -> Result {
         let data = chip.drvdata();
         let hwpwm = pwm.hwpwm();
-        let iomem_accessor = data.iomem.access(parent_dev)?;
-        let iomap = iomem_accessor.deref();
+        let iomap = data.iomem.access(parent_dev)?;
         let duty_cycles = iomap.try_read32(th1520_pwm_fp(hwpwm))?;
         let was_enabled = duty_cycles != 0;
 

-- 
2.54.0


