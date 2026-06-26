Return-Path: <linux-pwm+bounces-9422-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id utZZJ6WRPmq7IAkAu9opvQ
	(envelope-from <linux-pwm+bounces-9422-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 352BE6CE20F
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 16:50:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="s0/id8v8";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9422-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9422-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7226C306137E
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031C8402427;
	Fri, 26 Jun 2026 14:46:03 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020077.outbound.protection.outlook.com [52.101.195.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2243FD125;
	Fri, 26 Jun 2026 14:45:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485162; cv=fail; b=IJmFtuBlQfRnsM/sQnKt88/9Aw+1SZKtal36hhWhcYp7YA/HA7qVPmE/mjKKWA6bV82pvKnsWDFCShLVw1fF+Iq1IwwL8iC1J2WhhodgGrtdWjcoLkFbzLH2wihGjF155UZxkMex6tMuaFzXPTJX4Ouny9CNuCTV5Yu6n4iG9co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485162; c=relaxed/simple;
	bh=iBnZU2g+I0s239hpq7faLrUSboVV84u9sCkoPGVo0QQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=jtS5T58YKTS/2lC/SSlo/N4kZHQaBlC2fGo/R/ROOGQWcksUmW/V1axT1KuupxjNWqlpuhb+u2pFbtS8++W2WzqDwUoyH+JbO+/tfGXn0K6ldE1cSXYZpJ+JJ6BOfIRwjF8HeJoBu127DI+H2G7a6Jpz6jEu80soJEzRIlGU0jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=s0/id8v8; arc=fail smtp.client-ip=52.101.195.77
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy45a56QEbkNBn1gg5cVfZimjsNKxcRNlzhSvk4Fc53glrtx0gnyr6IjkYvo0F2arURokJwGVxQyv1Op58kkCGiXRhjNUNO3z3MlYqzo1HcRSnkgO5ufA1xjpHsvN8cybN2o5Fh24vXrgAbetL2ro9OBW2pfUv6342+ssHyPUaVQ2WJzS9ZYDeDKdPYOfl6/mJgW70MZ580DTjsrIinGkQKrnbHtWw8oHALc0jJ9xqalM7KuZwFzUhQtSyDFn077eJPImbXLUKmUy6RbtOItSd6cofkfpJOZBAr3abR+ZQ77lQtRZiKcOwsPlk2aFkJ8G1pCB818oUw42lIYY8qNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rANiJ3JtcujZgO/kOwxS0hgOmKU2Ez/7AYI1+eKtumk=;
 b=feDo5QNySpmFl6Y1onKLDl+bbfBIZUaVtfTJsGIVxAjStIlGtfF00svvb2uqvmtKTwQOsfzFksbroRaRXz8p/iQrhbcKTPgU9u0UBbptg8JTZ75R2dxefnY2GVchX02rDe2lwNnj1igVsw8OTlnWe98wStaNX3K4foie0w3RmTRw2lhDJPECRWAUqfyTYlMTeJm2Uf3m6X8H0u6BKZ/1vRu/7qlg63tFgTfsVlCS1HDv3WfczADKT8heJG0zljUtnX5IEkUSMp3mGyZrrt1fXb8jhiEX64hPvOxAdCo4e7EvaXC2TgK4VT6kYwdNu2KgVdyk5j7XQw6RqppOZ+IvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rANiJ3JtcujZgO/kOwxS0hgOmKU2Ez/7AYI1+eKtumk=;
 b=s0/id8v8OM98gtOcqOUok90dJUV5ZDsU+Jz6bLfLYEzQHw+3IVk0ILWEDEiUOVluHRsiiohibtqi9aeR28xB/hgW/qw3BdlPb8NoHj5+rcoXMHNhE578Xm8XEmA7JOJyzbppp0yX0i826AUDFlc5wJD+b5KIDDyi3NmRP5Yzg+0=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2694.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:45:26 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:45:26 +0000
From: Gary Guo <gary@garyguo.net>
Date: Fri, 26 Jun 2026 15:45:23 +0100
Subject: [PATCH v5 19/20] rust: io: add copying methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-io_projection-v5-19-d0961471ae50@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782485116; l=15331;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=iBnZU2g+I0s239hpq7faLrUSboVV84u9sCkoPGVo0QQ=;
 b=4KA1aq5AMraSOtjNz7YQ923zRHYHjqvBC2zyT1gMqgmqhWGE5oH7mByGtNJYwwwX5EQ+C6z2c
 JwCeNjoyAGeANP3nrKBDUroI1B61wz0mfAP7T3TIRFtA9SmHfhnTTwl
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
X-MS-Office365-Filtering-Correlation-Id: 7ae2b81c-a962-43c4-abf9-08ded3918f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|10070799003|921020|3023799007|18002099003|5023799004|22082099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BbYeu9VEh1a57ng3OM+dRrRlBT89/In4dZF/YKbABT+fz7wuZUEj57AUxnJe1aKi06aKkYX2rBS4eSRiAsI10WX/UbgW+4exPWARs3BUgvOYXj77lODQ+Bf3Wt85fd2oPTTNEytVPLRxzuZXOaOnupo0xDyDpuL6PqTwC+IaKQ6Z3A0rQGkzQav9IzkKy3N0BUDuzyPa2f5VUw3VQ+byoT2PGe5JMOwodD4IfIE1JDeKJEYQv5WHBaGBCzHTy6qH4okJXDzq2MPGeeylD55u1ddWZGnjBSMaPjPK9jbVtBZWL48bpNHZhty3yUD+/TDmrZns8829IY+Y2Z3pYHMjPbV2hFE6OGTqeT9x0iZV0ZqGMTSgGH36YimetD8+ZAbe1AVo3P1AuzCHcan782V/dPP0p5jtsYA0Qi9538Gq3GqUtdrrU+D7F4KXwxf31woI9N3D7qxLH8UtRrL8fKPUDc6EPvhFV19hZphaV26SNnbaFOLXWU/F68KTxVNJVqUzLuLR3SKcQWGLKuFCkqdTtW8P909CEUANMFZRQONWPim3lIXF00KfYsgt+lr2qd6saCZYuo7lBYS2iAOXAqXmNzvPjjZ20sJ5hnO87ofzmo3tkPEIIUf8/uoYlGTz3mNy0Kt9uFGKO2cEUiAo1Yi2I+IMRQoJYvGg6Nw8pSYuMMRxjNHpEben3lOOWbFxhAPEV+zNfPsLaS8p7kX8kuXE6Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(10070799003)(921020)(3023799007)(18002099003)(5023799004)(22082099003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDdjOVVhOGZTaXRrdkZGL2h0RTdOVDZQL1RKK1lZYjRXVU5tenJXMnlIRk1I?=
 =?utf-8?B?T3FaYXNuaFhIa3B6aHZQejdzb3FqY1NzbUFxUWozOUpmSGJsRlhRaC9FVWZO?=
 =?utf-8?B?SlNmUWhrSC9oc3lFVk9IK2VmS3NJcm1aMS95anE3T0ZEcGpjd3lRU2hJS1lW?=
 =?utf-8?B?K0l3T2RYMGxlVHQza1NtOUhnbExQV3cwc2hQdW9SanJwOWE1T0lmVjhLNGVo?=
 =?utf-8?B?bTZsSGt0QjZlc3kzSStDcVdZVzdZaGhVdWp3bmhRTk1nbnB3MDVmQjl1V0gy?=
 =?utf-8?B?ZFk5MWxacWwxVkFEUndCamZiY1owajE3aThGUzlKQVI4WWx3b0diOVUyNXpF?=
 =?utf-8?B?SWxTYnRRWEt4TVNaTm55eDYwTzE5UXZ1akJMNDdDcVFpQ29TOEk5dlNZQlZZ?=
 =?utf-8?B?ZmphZFhWcEVnTFR2VzZVVDNKMHFXRCtVZEswRWVFNlN3Ym92bFpnT0dvYW82?=
 =?utf-8?B?MStKbEhXeGVEcWR6QzJYZDRUUzh4N2lJQklNWmtlRXg3NXo1V3JRR295c0Ri?=
 =?utf-8?B?aENJU2gxcXE2UHVOYUxDZC82RnlXQVVIb0RmeXRsWjRQd1NITXFaWm4rZHhS?=
 =?utf-8?B?K0dSTWp0Ync0WDkxVG55OWVtZk0wVW5VdVU5dURuVEd6cm9JU2dKYllLSDAy?=
 =?utf-8?B?Sk1IK01pM0h3U0huVXk1bWoxYXJKMnhEL0QzUVN4alVNZTlDMEwrdDRLSUd0?=
 =?utf-8?B?ajhwMng3M29KNnlaT3RpOG5jcXBGSkZ5MFU1NzZCTmVrY0xlUU5uOGQxN0xw?=
 =?utf-8?B?d2ZpWTAvRjhJZ0dJQ3hodXBKV0tKbGUwSEVzdFBvcVErZ0ZIKzVQQzdZMkpq?=
 =?utf-8?B?OUF3QW1iZVU2TEZXRWdrN0lHWUNsM2p0UmZ5WXZOYkJkdGgvbTR6UnFpcEY3?=
 =?utf-8?B?TlpMSHg2ZndXQy9tMXhVYzl3U3VNSWtDUnhpYkNsM29nY2lRa3RCSlR4QzhV?=
 =?utf-8?B?NWNaSThUTFJLSXYvRjd2UDdFTENFOXhhQTViQlBSbEl1SDJnbmJhSFFBSGJR?=
 =?utf-8?B?WTJXOGNEaTFEM25GZWxNRkdFcmYyUlhOYXJ2Y1RFQTlYYjVBcGVMZG5nSVJt?=
 =?utf-8?B?SVVvbEsrUFphVGtmZmxBNVNWRW03bWQ0QytoUXRwSnVpZFBWaURPQXA4UGpm?=
 =?utf-8?B?TFVudExCRjNFQ3I3bU5kcE9kcVJjYWJ0a1JhUU1GZWEwMEwrQXhyY2h0eHpN?=
 =?utf-8?B?Y0lRRGNWMmRCMUlzakRNZUZ6TXhFcFN5T0s0V1JaZ2p5UlduZzBmcStSNWRo?=
 =?utf-8?B?MGdmU0NGUCtta3BHcUxXeWJQeEk0bGxsMk5mK083V1Irdlg2R21NQy9kaFNR?=
 =?utf-8?B?RzdBdW9xc0tZQUsxdE9EN3FielVTOSsrbWc0Z0hRK0VMT1NBR3F6aisvYXJo?=
 =?utf-8?B?V0w1SlpkeHdmZ2ZydEd5UGNoVnNxWit0WVhMVWI0NjJZT2NpeDBTaUdTR1Zx?=
 =?utf-8?B?UCthc1VUY3A3RjU2cHpvemo2NWVLWXpFbmJBWU5OY0JzVDdwaEc2NHhUL3BN?=
 =?utf-8?B?STZwRzR0dnNOOFlBNjBDaEhtYXdrQWZMWGtWTnhIcCsrTXBDTk1SOFVSc2U3?=
 =?utf-8?B?QzkrU0VKUkRRS243NFBJSFhxam1DYVJScmpjVDV0RjdpRW54N1RpempFRzB3?=
 =?utf-8?B?NkVoWGx2Mmptdzd0aEVWc05WT01TNndFYjlSREJ0TWdDWHlDVzFTem5JQzFP?=
 =?utf-8?B?NlJaQkNLTXNubExLM2tVd2xzZ3BRVTl1TDFtSjlJU242S052ZFN6OEJTdEli?=
 =?utf-8?B?V0hkcUVPeENoZ1BTMXRPZ01Hb3AvQkIwQ1FEcnEyaldTam5CSWVoU2NITUQ2?=
 =?utf-8?B?TDkyVityZEdQdmZKanYxV0hKRlZGL214TThlOFZRSUN6dVZTdmQxbjlxaFNE?=
 =?utf-8?B?T0FqbE9WQVFsQ2RPV2daa3ZLN2lpOU5yMm1mZE5zOVp2RmE0SVJxTW9RbG9R?=
 =?utf-8?B?NEk4NmpNcFNNZEg2dDREZ1RjVVpHWG5BTld0M0E5amk2K2Y0TU5MMXhObWxF?=
 =?utf-8?B?YkY1ZFh1ZmJzZ0ttK2xGbTBJN0ZXQkN5STdSVXRXdXZwZ0hOMFBMTkNGRU1p?=
 =?utf-8?B?ZXVZMEVzcWZVK2hLSEhwcldpRm1aZCtST1JIb21ZbURadTFBY3NzdVhCQ2Ni?=
 =?utf-8?B?QU55bWxYWi91VHhBNVV2VGFKNUhTUlhMOXlpRm1zSEhQRW5aS1Fvb1c1TVpq?=
 =?utf-8?B?bUhLVlU0b1NOVUdDWnhZMEdKcFlnaTE5bE5SQmhWZENoUDUyU2lWc0h3aEpX?=
 =?utf-8?B?c0xXUnZlSVV4c3FPRG96NHhDbUlnaEJnWVFZdWJKU3d4RlV4T25uY2hWb3l3?=
 =?utf-8?B?cHRJWnBnTmdtVFpzRWFSVmJxMFFyUnVraDlGaTlYbzVibG5aeThzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae2b81c-a962-43c4-abf9-08ded3918f95
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:45:26.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HnJSHTX2Dj0vqMyYK5fn+Y3ANzodNUsySFvQ047FcC5dk4/gNYB5LQi9S1CwkYAlHvalVqJPY83XGQZhp9R9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2694
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9422-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 352BE6CE20F

One feature that was lost from the old `dma_read!` and `dma_write!` when
moving to `io_read!` and `io_write!` was the ability to read/write a large
structs. However, the semantics was unclear to begin with, as there was no
guarantee about their atomicity even for structs that were small enough to
fit in u32. Re-introduce the capability in the form of copying methods.

    dma_read!(foo, bar) -> io_project!(foo, bar).copy_read()
    dma_write!(foo, bar, baz) -> io_project!(foo, bar).copy_write(baz)

Model these semantics after memcpy so user has clear expectation of lack of
atomicity. As an additional benefit of this change, this now works for MMIO
as well by mapping them to `memcpy_{from,to}io`.

For slices which is DST so the `copy_read` and `copy_write` API above can't
work, add `copy_from_slice` and `copy_to_slice` to copy from/to normal
memory.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/io.c        |  13 +++
 rust/kernel/dma.rs       |  25 +++++
 rust/kernel/io.rs        | 248 ++++++++++++++++++++++++++++++++++++++++++++++-
 samples/rust/rust_dma.rs |  15 ++-
 4 files changed, 295 insertions(+), 6 deletions(-)

diff --git a/rust/helpers/io.c b/rust/helpers/io.c
index 397810864a24..7ed9a4f77f1b 100644
--- a/rust/helpers/io.c
+++ b/rust/helpers/io.c
@@ -19,6 +19,19 @@ __rust_helper void rust_helper_iounmap(void __iomem *addr)
 	iounmap(addr);
 }
 
+__rust_helper void rust_helper_memcpy_fromio(void *dst,
+					     const volatile void __iomem *src,
+					     size_t count)
+{
+	memcpy_fromio(dst, src, count);
+}
+
+__rust_helper void rust_helper_memcpy_toio(volatile void __iomem *dst,
+					   const void *src, size_t count)
+{
+	memcpy_toio(dst, src, count);
+}
+
 __rust_helper u8 rust_helper_readb(const void __iomem *addr)
 {
 	return readb(addr);
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 0ff4cce8e809..37bc20895803 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -18,6 +18,7 @@
         IoBackend,
         IoBase,
         IoCapable,
+        IoCopyable,
         SysMem,
         SysMemBackend, //
     },
@@ -1196,6 +1197,30 @@ fn io_write<'a>(view: Self::View<'a, T>, value: T) {
     }
 }
 
+impl IoCopyable for CoherentBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // SAFETY: Per safety requirement.
+        unsafe { SysMemBackend::copy_from_io(view.cpu_addr, buffer) }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // SAFETY: Per safety requirement.
+        unsafe { SysMemBackend::copy_to_io(view.cpu_addr, buffer) }
+    }
+
+    #[inline]
+    fn copy_read<T: zerocopy::FromBytes>(view: Self::View<'_, T>) -> T {
+        SysMemBackend::copy_read(view.cpu_addr)
+    }
+
+    #[inline]
+    fn copy_write<T: zerocopy::IntoBytes>(view: Self::View<'_, T>, value: T) {
+        SysMemBackend::copy_write(view.cpu_addr, value)
+    }
+}
+
 impl<'a, T: ?Sized + KnownSize> IoBase<'a> for CoherentView<'a, T> {
     type Backend = CoherentBackend;
     type Target = T;
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index aa82736253ac..b5ac3ac86bbd 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -5,7 +5,8 @@
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
 use core::{
-    marker::PhantomData, //
+    marker::PhantomData,
+    mem::MaybeUninit, //
 };
 
 use crate::{
@@ -271,6 +272,61 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// Trait indicating that an I/O backend supports memory copy operations.
+pub trait IoCopyable: IoBackend {
+    /// Copy contents of `view` to `buffer`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile write for `view.size()` bytes.
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8);
+
+    /// Copy `size` bytes from `buffer` to `address`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile read for `view.size()` bytes.
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8);
+
+    /// Copy from `view` and return the value.
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        // Project `self` to `[u8]`.
+        let ptr = Self::as_ptr(view);
+        // SAFETY: This is a identity projection.
+        let slice_view = unsafe {
+            Self::project_view(
+                view,
+                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), size_of::<T>()),
+            )
+        };
+
+        let mut buf = MaybeUninit::<T>::uninit();
+        // SAFETY: `buf.as_mut_ptr()` is valid for write for `size_of::<T>()` bytes.
+        unsafe { Self::copy_from_io(slice_view, buf.as_mut_ptr().cast()) };
+        // SAFETY: T: FromBytes` guarantee that all bit patterns are valid.
+        unsafe { buf.assume_init() }
+    }
+
+    /// Copy `value` to `view`.
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        // Project `self` to `[u8]`.
+        let ptr = Self::as_ptr(view);
+        // SAFETY: This is a identity projection.
+        let slice_view = unsafe {
+            Self::project_view(
+                view,
+                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), size_of::<T>()),
+            )
+        };
+
+        // SAFETY: `&raw const value` is valid for read for `size_of::<T>()` bytes.
+        unsafe { Self::copy_to_io(slice_view, (&raw const value).cast()) };
+        core::mem::forget(value);
+    }
+}
+
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
 /// into.
 ///
@@ -350,6 +406,24 @@ fn size(self) -> usize {
         KnownSize::size(Self::Backend::as_ptr(self.as_view()))
     }
 
+    /// Returns the length of the slice in number of elements.
+    #[inline]
+    fn len<T>(self) -> usize
+    where
+        Self: Io<'a, Target = [T]>,
+    {
+        Self::Backend::as_ptr(self.as_view()).len()
+    }
+
+    /// Returns `true` if the slice has a length of 0.
+    #[inline]
+    fn is_empty<T>(self) -> bool
+    where
+        Self: Io<'a, Target = [T]>,
+    {
+        self.len() == 0
+    }
+
     /// Try to convert into a different typed I/O view.
     ///
     /// The target type must be of same or smaller size to current type, and the current view must
@@ -437,6 +511,115 @@ fn write_val(self, value: Self::Target)
         Self::Backend::io_write(self.as_view(), value)
     }
 
+    /// Copy-read from I/O memory.
+    ///
+    /// This is equivalent to reading from the I/O memory with byte-wise copy, although the actual
+    /// implementation might be more efficient. There is no atomicity guarantee. Note that for some
+    /// backends (e.g. `Mmio`), this can read different value compared to [`read_val`] as
+    /// byte-swapping is not performed.
+    ///
+    /// [`read_val`]: Io::read_val
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_read(mmio: Mmio<'_, [u8; 6]>) {
+    /// // let mmio: Mmio<'_, [u8; 6]>;
+    /// let val: [u8; 6] = mmio.copy_read();
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_read(self) -> Self::Target
+    where
+        Self::Backend: IoCopyable,
+        Self::Target: Sized + FromBytes,
+    {
+        Self::Backend::copy_read(self.as_view())
+    }
+
+    /// Copy-write to I/O memory.
+    ///
+    /// This is equivalent to writing to the I/O memory with byte-wise copy, although the actual
+    /// implementation might be more efficient. There is no atomicity guarantee. Note that for some
+    /// backends (e.g. `Mmio`), this can read different value compared to [`write_val`] as
+    /// byte-swapping is not performed.
+    ///
+    /// [`write_val`]: Io::write_val
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8; 6]>) {
+    /// // let mmio: Mmio<'_, [u8; 6]>;
+    /// mmio.copy_write([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_write(self, value: Self::Target)
+    where
+        Self::Backend: IoCopyable,
+        Self::Target: Sized + IntoBytes,
+    {
+        Self::Backend::copy_write(self.as_view(), value);
+    }
+
+    /// Copy bytes from slice to I/O memory.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
+    /// // let mmio: Mmio<'_, [u8]>;
+    /// mmio.copy_from_slice(&[0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_from_slice(self, data: &[u8])
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+    {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY: `data.as_ptr()` is valid for read for `self.size()` bytes.
+        unsafe {
+            Self::Backend::copy_to_io(self.as_view(), data.as_ptr());
+        }
+    }
+
+    /// Copy bytes from I/O memory to slice.
+    ///
+    /// The length of `self` must be the same as `data`, similar to [`[u8]::copy_from_slice`].
+    ///
+    /// # Examples
+    ///
+    /// ```no_run
+    /// # use kernel::io::*;
+    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
+    /// // let mmio: Mmio<'_, [u8]>;
+    /// let mut buf = [0; 6];
+    /// mmio.copy_to_slice(&mut buf);
+    /// # }
+    /// ```
+    #[inline]
+    fn copy_to_slice(self, data: &mut [u8])
+    where
+        Self::Backend: IoCopyable,
+        Self: Io<'a, Target = [u8]>,
+    {
+        assert_eq!(self.len(), data.len());
+
+        // SAFETY: `data.as_ptr()` is valid for write for `self.size()` bytes.
+        unsafe {
+            Self::Backend::copy_from_io(self.as_view(), data.as_mut_ptr());
+        }
+    }
+
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
@@ -995,6 +1178,28 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
 
+impl IoCopyable for MmioBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // SAFETY:
+        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
+        // - `buffer` is valid for write for `view.size()` bytes.
+        unsafe {
+            bindings::memcpy_fromio(buffer.cast(), view.ptr.cast(), view.size());
+        }
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // SAFETY:
+        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
+        // - `buffer` is valid for read for `view.size()` bytes.
+        unsafe {
+            bindings::memcpy_toio(view.ptr.cast(), buffer.cast(), view.size());
+        }
+    }
+}
+
 /// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
@@ -1138,6 +1343,47 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
 #[cfg(CONFIG_64BIT)]
 impl_sysmem_io_capable!(u64);
 
+impl IoCopyable for SysMemBackend {
+    #[inline]
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
+        // Use `bindings::memcpy` instead of `copy_nonoverlapping` for volatile.
+        // SAFETY:
+        // - `view.ptr` is in CPU address space and valid for read.
+        // - `buffer` is valid for write for `view.size()` bytes which is equal to `view.ptr.len()`.
+        unsafe { bindings::memcpy(buffer.cast(), view.ptr.cast(), view.ptr.len()) };
+    }
+
+    #[inline]
+    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
+        // Use `bindings::memcpy` instead of `copy_nonoverlapping` for volatile.
+        // SAFETY:
+        // - `view.ptr` is in CPU address space and valid for write.
+        // - `buffer` is valid for read for `view.size()` bytes which is equal to `view.ptr.len()`.
+        unsafe { bindings::memcpy(view.ptr.cast(), buffer.cast(), view.ptr.len()) };
+    }
+
+    #[inline]
+    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
+        // SAFETY:
+        // - Per type invariant, `ptr` is valid and aligned.
+        // - Using read_volatile() here so that race with hardware is well-defined.
+        // - Using read_volatile() here is not sound if it races with other CPU per Rust
+        //   rules, but this is allowed per LKMM.
+        // - `T: FromBytes` so all bit patterns are valid.
+        unsafe { view.ptr.read_volatile() }
+    }
+
+    #[inline]
+    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
+        // SAFETY:
+        // - Per type invariant, `ptr` is valid and aligned.
+        // - Using write_volatile() here so that race with hardware is well-defined.
+        // - Using write_volatile() here is not sound if it races with other CPU per Rust
+        //   rules, but this is allowed per LKMM.
+        unsafe { view.ptr.write_volatile(value) }
+    }
+}
+
 /// System memory region.
 ///
 /// Provides `Io` trait implementation for kernel virtual address ranges,
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 6727c441658a..b629acc6d915 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -12,7 +12,11 @@
         Device,
         DmaMask, //
     },
-    io::io_read,
+    io::{
+        io_project,
+        io_read,
+        Io, //
+    },
     page, pci,
     prelude::*,
     scatterlist::{Owned, SGTable},
@@ -35,6 +39,7 @@ struct DmaSampleDriver {
     (0xcd, 0xef),
 ];
 
+#[derive(FromBytes, IntoBytes)]
 struct MyStruct {
     h: u32,
     b: u32,
@@ -74,11 +79,11 @@ fn probe<'bound>(
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let mut ca: CoherentBox<[MyStruct]> =
-                CoherentBox::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+            let ca: Coherent<[MyStruct]> =
+                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                ca.init_at(i, MyStruct::new(value.0, value.1))?;
+                io_project!(ca, [panic: i]).copy_write(MyStruct::new(value.0, value.1));
             }
 
             let size = 4 * page::PAGE_SIZE;
@@ -88,7 +93,7 @@ fn probe<'bound>(
 
             Ok(try_pin_init!(Self {
                 pdev: pdev.into(),
-                ca: ca.into(),
+                ca,
                 sgt <- sgt,
             }))
         })

-- 
2.54.0


