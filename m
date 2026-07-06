Return-Path: <linux-pwm+bounces-9601-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BAScIH6rS2oSYQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9601-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:19:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9917112B4
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:19:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=VIe5KgM0;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9601-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9601-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4769D3305B5E
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35188435A8E;
	Mon,  6 Jul 2026 12:44:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021114.outbound.protection.outlook.com [52.101.95.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF13432BD4;
	Mon,  6 Jul 2026 12:44:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341886; cv=fail; b=Bmp3GTOLI+fQd+x2i2IUo/6klh6+gEmFb8KyuqKGkVjPiHIN3zVIcQx6NjzPHN6GPKCw7701pno2/ESZ2PB3kG9SXirA4JyfkaNOSFNpxCNjMhrO0zx6jYTVpJjA4TwrKeJ46aORSw4aRbAm8i/BhmrkpBnDmu3Izp33T39rW0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341886; c=relaxed/simple;
	bh=3QCTbAtxZ0naU8wjgAQQjSrxP8t8/OTAXw7Ybb7JCX0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Y6xijd9HNtQiAVoAHgsrNA2RuxwECzhw7X6lpICmFpGCYKDCM0flXrcds403wpeI4JBi/7XvW28jeWy9VXbL7QpkPMgfLAs9bsUPu31fA1NCSf+BJbAC+jP/f4Xw0JRCs5SdYkp26NrI3dOVa4kDWA3OcDURqqy7PjfmA/9iTGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=VIe5KgM0; arc=fail smtp.client-ip=52.101.95.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuZ1XSfoUKBHj8xrvDEuL74pVCDQsokJZuoDk3dnhNvVkBM/2oShq+Fc6OuQOctoaxRWr3P8vs2gb11wqoX5bhMd3tyhVzWO2KLgBXj9kyoQ+7HhmjqAN66/fU/JFLAjUHnCsetY4ME663iBDSZTypOQwnWAUuA/dEB0oAu5jPos5FaJ2x7saYUNrqcyL/qg/atMWS4TIEVtGXynbeIlukvPn9mbyBjAumo/3x4p05wn6n9IUOIrR4u89ZSa4LHoCVMuIE+194rVMheD86xgLRgQzLg3i7AGjv3OMHKYR0b+gxVdgodnmhBk85C9dZQi8vAjQfSKCPkcImvHy2FJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVx/es/S1pzCBheq1wfurISvfjAxx03GLq4Izmsg2Ss=;
 b=KKnS63cXE39OQT6mAG/HjJ8DGG6r+44/BWWgbKIVOpK8aEBGqeCvz77QPCcIscFGoVZqSf/YS3EY9/DC7C2MUukHHsf4mDjzAlGqrmk6AEwsC2pv4tI6L9Mcqa7NBLOP9AaQITmFRw3VHe8ZwbY2CwYA93fHz2fTHNyYIlVlwmOEUp3uoNRRXb3DX1ywpS84LchgGjB3+66aqc0Qa9/r7TnoKf+ah+BlY4pZAMq7jjuJNV/d2YP7iA85MF9VYqhSLSw+vVNgbJ0vBWg7uq5NwZm0O8xtGykwZGkb2HJO9aTaRx7SEfUGqwnuwF0eNIezsEpTJfErzEbjYcygIr1mWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVx/es/S1pzCBheq1wfurISvfjAxx03GLq4Izmsg2Ss=;
 b=VIe5KgM02eOy7x0jjYs3RRgnWAAsP1mivWCmi3uH6E9aWFD2N/Um1QR9GKKeRysIypJTFQR45aUF+aWtBpd5oSSGA4ddywo3cBfpej4JARqjUsIZJoLnOCG1e1ep7VRoPUO6kT6/A/bG6kSPtSuri/bucy38ZotexW0IcOrDPbM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:29 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:24 +0100
Subject: [PATCH v6 11/20] rust: io: remove `MmioOwned`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-11-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=8907;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=3QCTbAtxZ0naU8wjgAQQjSrxP8t8/OTAXw7Ybb7JCX0=;
 b=SMgfkfCQwhPiGXt7rFt2ngz2RhHB17lGfQ9OIuqSwikI2FWDMeccUMnIgVvYgbnSntD034i4r
 e4QLQi50T6oAvL9a3xG0XxDdzQvIlvgrYXLA5zlKlsGRzBd2zDgGdPo
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
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 8862bdbe-e8f6-41e8-21f7-08dedb5c522b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Cg7c/ikB2sXQc1av7/tP5uXUAXQD6LPZ/NOYJ/D/JGlysvgsFCt6oEzrrI24JRqoixjNAKfyBItEhg/qF+rv7w4mrjGxWHNL+LqJwWdmPMkcRnv0lhP54LhWZGn4rHuaXZh7zJiqEen384SC2NMHfbghqDWEYaskije2pVoV5J/5OC89fZiCrqsjzsgEwI/1c0BAB0zVJTE7u8t1NRItZo+NZTmFtTw4P03/ZYiDVrXfiQGRxZtXU2LkNkzJEgGxpgqO+U8sRqPZBpQ9XGAYvs7B2U+m/GUfkunvXSPzftQObXnXCeUGdi1jSnM9OkQrGXXON5Mn/9bd6cJ+A5laMD5bBQJ0/77nxgdp4jbLNhvjJxsDC4YPtBXAwOZBFBuaH6oyupEoAzEQXFYt4TWGwa/4LNEVOTtVWEHvCXs7gbu6oZDEgBkTCfaxtCNyxLeREWyKaxLEJLUI+e16/oqDOkcr1AwZSvGD1NUoxMb9hjtkteJAQkIn4t2SGeG811MhzAVoUgCz8k+wTlqWyUbI3883ryApuySbT4Y3O0mDoeFqjNjZGLkKZeuSB5L752Cr/v36GMUvjFO/CgZh5PEroEYSK3dqyVHZFiHMCS4c81g7ZoPsBAmpHFdA2nH1bz2b6IxkmRi/L/uIvNYU2XmuItnHk+cMQ1gII8SXJahRbhAUmHn59+HSurgNXxvzThvvTEiVvBciBIOTv0SiwLzoew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVQ1R25Gc3JuS3RBemJOeXNWYjk4NWFMbCtCTnZZcGVKZzZiY2l6dEdhWW90?=
 =?utf-8?B?ajlGdjJzM09zenZsL2tjUWw3WW1oaFk3VjRSQUlSdUJSYWVxQWxnR1E4ZjJD?=
 =?utf-8?B?ZU1KN3Z0TTBEbndzODl0bWFvRmdrenRHVlNKSjNsQVg3dDhDMlltTmxVdVVv?=
 =?utf-8?B?YVRabSs4bXpUU3N3eE9nenVQQmkxMkN5Y3hhcmU0cHNESmFjYWNTQ1F2U0Iz?=
 =?utf-8?B?N3BJRHFpS0VpaFhIQkN4TnppblNMMXdTcXk2OTVTVXl1ajdDcGhUdFo1UVE1?=
 =?utf-8?B?VzBJUWhTYW1WWStraGcvUURGYnRDQXRxdWttbWMwTVFrWVNFS0Voc2J3Z05h?=
 =?utf-8?B?TmxBRkNZNUV6YzAvSFR4VmgyZVZvVXBpemZLellLVjQ0dU96bFFvNlBMbnl1?=
 =?utf-8?B?eXpqeVNsMmJJZUltR2k5L0NYSkpyUGtpWWVZelJHcndET3ZWV0I0MENsNDJ5?=
 =?utf-8?B?WkJhT0JlSVIyTTNHbFpZVTFydXRmV2FmemlNejdCanc2UjV0eWJLblFNY1Y5?=
 =?utf-8?B?VzgwYXBRemNxTFEzVDFuekFGUGxidlBjVUYwNGo4akNURS9pT0VjY1o2bEVN?=
 =?utf-8?B?YXluVmd4OVBWTk43ZFZSWmpnbEt4NVM5OGVTVElxNDNiRWV4SGw1ZC8vdjVw?=
 =?utf-8?B?WGNHeWN0WWtuZmluejNuMnFDenJRbnB0U0wyOXNLNDRVQ1kra0hTTDlLdTJ6?=
 =?utf-8?B?dDNILzFZS1A3elFVcVdJYkpaR3NDRlZCTEs4YXkvQnJNMkRxSUpMNkY1cmJn?=
 =?utf-8?B?WVo1NUNFZ3RSODgyM3pvME9XYlZoRmNNVmEzUm1PRjh0Vlo3aEM0US84cTFT?=
 =?utf-8?B?cXh3dVYweXYvN3pZSEVoVXMybzNVeTh5QXR4ZVl6TEIwMm02eEVOclFyQW05?=
 =?utf-8?B?YUJFM0kxb281em5kL1lGWHdONENCOEZBVjIveUZWeURlMDhwRlA5MTNMbk4z?=
 =?utf-8?B?cmVteWI3MytBbEdEc0pqUnRvNGg4WG51bERQL21Bbm9LeEpaVlRBWmdTc0ZY?=
 =?utf-8?B?bEluY1lYNVJuTlhjVG5ucnlxMktJWlpreUFCMXJ2cXE2QzkrU003Y0NtRW5q?=
 =?utf-8?B?UllLYTB6THRZS0owZjB5Z3p2T3I2OHJjYXVISDlQbThkMUhGN0F6TnZjSW9D?=
 =?utf-8?B?OTFVYXd5bU8xRnR1MjdqTlZlZW80UzJLTjFRRWpuS3U4V01kWElCUy9ZQWoy?=
 =?utf-8?B?MU9RUkpJV3ZGSEFtNHd4VythUjRFTm9BSE1FMkp4T2hvNEdkL3d1dUlOdy80?=
 =?utf-8?B?U01zZk9iNERFVkI5Z1RWOUYxaTB1bUR0eUlnS1U0bndLZkx0VEN0STYrTk1m?=
 =?utf-8?B?Y3BQN2dmT3crTDNKTVJvRzNpbXlXK0dPS3RsTGxHSmNPN1g0UGc4Nm9lOSth?=
 =?utf-8?B?b2dldjNnTHNiSEpUZlJ2dUh6Uit2RG51RTZrYVpRdDZCZm55SUlZcHNVMUZk?=
 =?utf-8?B?ZVJtM3kwN3lQNE1SWVdwTFE1RERublhtV21uZmpibmdHaW95bmxlK2w0V01a?=
 =?utf-8?B?RE5JdWNITVdZYVJiSXpSS1J6MFd5b2RQZWhuSW1JSi9WdmpITjVHS05Pdndz?=
 =?utf-8?B?cGtrVEd1eVdrcFVHSEx6bVRLNU56TnRpaFVaOWxPR1dsdUN0aFoyQ01oeHNt?=
 =?utf-8?B?R0FJN2N3bGJoYzArcHhDbHZPcys4R0MySFZpMmlweHpDV2R4VE9hUG1qQlNo?=
 =?utf-8?B?RnkwVmdCaVZhclZMNGNCOHJvamErak1IV29WeUgreWZ3a25jcm1tK3R4VXdy?=
 =?utf-8?B?UVVxcElDRzdSSlhIWVdUZDZna1JEN3o0UmJnNFltckhUaGRYRUY4STRpNzdP?=
 =?utf-8?B?Vk9KR0ZJcm1QcUFIMGJZVERJQlhMTzlHTFp6cFZzeDJYNG1sZWJuN2hHWlky?=
 =?utf-8?B?d1ZyK1N5YWhxODR1M0pXTmg4MDQybVV4dHdlRytYcnVLdHB5eDZIT0dLOEtT?=
 =?utf-8?B?OUFRcU9QSFdlS2h3UmNNN0ZBcm12ejNqQTFWN2VmdTYxOSs3eTgzMjRKT2NF?=
 =?utf-8?B?QVpXVC9VdDZQdC9hMk04KzZ1U1EvMnUveUFBV051djNMWnZnQkhUU0w3MUsr?=
 =?utf-8?B?TXdyV3owUFU4azg2RktEQnBYeGx5UzVlVjF3QkliYXNVbVNrbTVpYWNlcGxQ?=
 =?utf-8?B?S1FwWVZHSHlHU1RsOHBNOFRsSW00M0VkTmd1aEpqcVZkeGU1YVV1S01lZXA2?=
 =?utf-8?B?U3V0bjk0NFdJTXZaNCt1a2dINDNnU3lOWTBvQUNSNlpUVVhwbEN5RU5nRGQw?=
 =?utf-8?B?d2M5QlFPOEYyTTY5d2lHRFdzNUdvbDNkdkdvOXBUeXBFakZadStKQ1JpNUJS?=
 =?utf-8?B?bUdTbm9xNk5RT3FnRmcvdDV5dmJLTHlBMEpDN1pTZWVZTHZqRllhUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8862bdbe-e8f6-41e8-21f7-08dedb5c522b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:29.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7Z2QYfvGMmT3V4s8brRxmhml8D27iZ/yTmYktA9RNWELIrcUCae1PZukN80++//doWLNBiosxaYyT7R48jFCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
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
	TAGGED_FROM(0.00)[bounces-9601-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,self.io:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A9917112B4

`Io` trait is now very easy to implement. Thus, implement it on `Bar` and
`IoMem` directly and remove the `MmioOwned` struct.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  12 +++---
 rust/kernel/io.rs     | 103 +-------------------------------------------------
 rust/kernel/io/mem.rs |  26 +++++++------
 rust/kernel/pci/io.rs |  16 ++++----
 4 files changed, 32 insertions(+), 125 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index aed0c994fd30..3545ffc5345d 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,8 +68,9 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
-///         MmioOwned,
+///         Mmio,
 ///         MmioRaw,
+///         MmioBackend,
 ///         PhysAddr,
 ///         Region, //
 ///     },
@@ -104,12 +105,13 @@ struct Inner<T> {
 ///     }
 /// }
 ///
-/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = MmioOwned<SIZE>;
+/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
+///    type Backend = MmioBackend;
+///    type Target = Region<SIZE>;
 ///
-///    fn deref(&self) -> &Self::Target {
+///    fn as_view(self) -> Mmio<'a, Region<SIZE>> {
 ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { MmioOwned::from_raw(&self.0) }
+///         unsafe { Mmio::from_raw(self.0) }
 ///    }
 /// }
 /// # fn no_run(dev: &Device<Bound>) -> Result<(), Error> {
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 89039b3defd5..c7533d605678 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -98,8 +98,8 @@ fn size(p: *const Self) -> usize {
 /// the represented MMIO region does exist or is properly mapped.
 ///
 /// Instead, the bus specific MMIO implementation must convert this raw representation into an
-/// `MmioOwned` instance providing the actual memory accessors. Only by the conversion into an
-/// `MmioOwned` structure any guarantees are given.
+/// `Mmio` instance providing the actual memory accessors. Only by the conversion into an `Mmio`
+/// structure any guarantees are given.
 pub struct MmioRaw<T: ?Sized> {
     /// Pointer is in I/O address space.
     ///
@@ -156,80 +156,6 @@ pub fn size(&self) -> usize {
     }
 }
 
-/// IO-mapped memory region.
-///
-/// The creator (usually a subsystem / bus such as PCI) is responsible for creating the
-/// mapping, performing an additional region request etc.
-///
-/// # Invariant
-///
-/// `addr` is the start and `maxsize` the length of valid I/O mapped memory region of size
-/// `maxsize`.
-///
-/// # Examples
-///
-/// ```no_run
-/// use kernel::{
-///     bindings,
-///     ffi::c_void,
-///     io::{
-///         Io,
-///         MmioOwned,
-///         MmioRaw,
-///         PhysAddr,
-///         Region,
-///     },
-/// };
-/// use core::ops::Deref;
-///
-/// // See also `pci::Bar` for a real example.
-/// struct IoMem<const SIZE: usize>(MmioRaw<Region<SIZE>>);
-///
-/// impl<const SIZE: usize> IoMem<SIZE> {
-///     /// # Safety
-///     ///
-///     /// [`paddr`, `paddr` + `SIZE`) must be a valid MMIO region that is mappable into the CPUs
-///     /// virtual address space.
-///     unsafe fn new(paddr: usize) -> Result<Self>{
-///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
-///         // valid for `ioremap`.
-///         let addr = unsafe { bindings::ioremap(paddr as PhysAddr, SIZE) };
-///         if addr.is_null() {
-///             return Err(ENOMEM);
-///         }
-///
-///         Ok(IoMem(MmioRaw::new_region(addr as usize, SIZE)?))
-///     }
-/// }
-///
-/// impl<const SIZE: usize> Drop for IoMem<SIZE> {
-///     fn drop(&mut self) {
-///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
-///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
-///     }
-/// }
-///
-/// impl<const SIZE: usize> Deref for IoMem<SIZE> {
-///    type Target = MmioOwned<SIZE>;
-///
-///    fn deref(&self) -> &Self::Target {
-///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
-///         unsafe { MmioOwned::from_raw(&self.0) }
-///    }
-/// }
-///
-///# fn no_run() -> Result<(), Error> {
-/// // SAFETY: Invalid usage for example purposes.
-/// let iomem = unsafe { IoMem::<{ core::mem::size_of::<u32>() }>::new(0xBAAAAAAD)? };
-/// iomem.write32(0x42, 0x0);
-/// assert!(iomem.try_write32(0x42, 0x0).is_ok());
-/// assert!(iomem.try_write32(0x42, 0x4).is_err());
-/// # Ok(())
-/// # }
-/// ```
-#[repr(transparent)]
-pub struct MmioOwned<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
-
 /// Checks whether an access of type `U` at the given `base` and the given `offset`
 /// is valid within this region.
 ///
@@ -957,31 +883,6 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
-impl<'a, const SIZE: usize> Io<'a> for &'a MmioOwned<SIZE> {
-    type Backend = MmioBackend;
-    type Target = Region<SIZE>;
-
-    #[inline]
-    fn as_view(self) -> Mmio<'a, Self::Target> {
-        // SAFETY: `Mmio` has same invariant as `MmioOwned`
-        unsafe { Mmio::from_raw(self.0) }
-    }
-}
-
-impl<const SIZE: usize> MmioOwned<SIZE> {
-    /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
-    /// mapping.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
-        // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
-        unsafe { &*core::ptr::from_ref(raw).cast() }
-    }
-}
-
 /// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index 8f6c257c5b8e..d9b3189d09b4 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -2,8 +2,6 @@
 
 //! Generic memory-mapped IO.
 
-use core::ops::Deref;
-
 use crate::{
     device::{
         Bound,
@@ -16,7 +14,9 @@
             Region,
             Resource, //
         },
-        MmioOwned,
+        Io,
+        Mmio,
+        MmioBackend,
         MmioRaw, //
     },
     prelude::*,
@@ -210,11 +210,13 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
     }
 }
 
-impl<const SIZE: usize> Deref for ExclusiveIoMem<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = super::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
-        &self.iomem
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
+        self.iomem.as_view()
     }
 }
 
@@ -290,11 +292,13 @@ fn drop(&mut self) {
     }
 }
 
-impl<const SIZE: usize> Deref for IoMem<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = super::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
         // SAFETY: Safe as by the invariant of `IoMem`.
-        unsafe { MmioOwned::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(self.io) }
     }
 }
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e67c1e3694fb..4be33ecb4192 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -11,16 +11,14 @@
         Io,
         IoBackend,
         IoCapable,
-        MmioOwned,
+        Mmio,
+        MmioBackend,
         MmioRaw,
         Region, //
     },
     prelude::*,
     ptr::KnownSize, //
 };
-use core::{
-    ops::Deref, //
-};
 
 /// Represents the size of a PCI configuration space.
 ///
@@ -269,12 +267,14 @@ fn drop(&mut self) {
     }
 }
 
-impl<const SIZE: usize> Deref for Bar<'_, SIZE> {
-    type Target = MmioOwned<SIZE>;
+impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
+    type Backend = MmioBackend;
+    type Target = crate::io::Region<SIZE>;
 
-    fn deref(&self) -> &Self::Target {
+    #[inline]
+    fn as_view(self) -> Mmio<'a, Self::Target> {
         // SAFETY: By the type invariant of `Self`, the MMIO range in `self.io` is properly mapped.
-        unsafe { MmioOwned::from_raw(&self.io) }
+        unsafe { Mmio::from_raw(self.io) }
     }
 }
 

-- 
2.54.0


