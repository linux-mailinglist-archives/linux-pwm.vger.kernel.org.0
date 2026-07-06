Return-Path: <linux-pwm+bounces-9600-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h/FCHlSkS2qBXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9600-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:49:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A80710C5F
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:49:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Gspwp2km;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9600-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9600-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AB996305107D
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7565435A87;
	Mon,  6 Jul 2026 12:44:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FE42CAF7;
	Mon,  6 Jul 2026 12:44:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341886; cv=fail; b=J0pUfLdjoSqZ9DD68zOteSMiYg2WhGQXqz5235AXtX//IGP9Xr5yXl8Rqehf9Uil9FPy1j7BS5uz0GUNaMIh2k7iBo6ZA3orUWavT8CydrQ1sNTa5UUu1A7Kpk0A8k/WIWNY/7lKxNax6dEyoOYgf1pUdWS57Zd6rXy0sRkC3ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341886; c=relaxed/simple;
	bh=OqMl/YNl6A2qolqH5JXlE2pz3W/cSM5Ln5OcyIW0yKA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IhL7Sr8aX1330iNuMHemhIULkNBAJpTcA6iZxXfk+uC+u7aiwya230JblDwk11QlB0y3jMkHL4d5/xPLvY4h8GwD4r7rgftTIwkBkyVFAN4ss8lYtWsmAhvEZVWVtytSAyGzvtF1csM8WPkLENadH+MwsZEihLEPyKg1zsEUA5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Gspwp2km; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d74XJLR3OvP4Fp443JYJhoY4SjwWIWsTgPeWS8WpLG7qcF8t0Nu+MmvFsZQSiTh6ntuPHQvBfKY8gSIhMiiQ2Bf260as1bwJmLnR/6L3DVp2EgRjmtYxONUxt7mNch0VbeyC/dABwmAjiKMG5p8VkXeJqqe4H0wiAejo0Z3JTPGYQ3C8/SWWS0CaYrXkZwPy0ueoZkY8ImBMdmnzDA/+gY7o7iEF6nXNiI19d6kWeOJmc2XjknDD4jRNTVSch1cGVdcWvDVtFSHya1LLDPBa7A/b3UflOCLTLWc9tIWJlVo5C1Dg4zp1WL32MyKLh7KK+EeOTid21k6qctMaA4X1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIzmf9Ib2zyFguGeQ5PLRmc89m6/95j6y5qmmU5nsDM=;
 b=rcSzOK9yM9r9aQpDGq99+BeY3yhR1hsAijaVsQCWHgC/Vpvxg8hJPHCA9hVYagJecNiUvXLkkeAI/SLYHdE+XHwHNvoSZdxdCEDy00gZ7ApY6fABB15WLxsX2aCaE4p0BssfViz/pxK8wuW2mG80qm+iqw4oW9ySaz5ov3clF/XGplNl+SYr4q3njIDOXFn1Xe7ih1TePjNNJDa0z6JnNY5hGI4+TSzoqksNbynm3hjbQIW4a7+9UXYvP4AcjWNg+SsrPGg6nLkaoQPKbRgrVTtu/eJCXlGujN+eYFui7F5yD4vVEdKuqsoYdCQ6TYRuJpFi/rnE0JuE0APlse29zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIzmf9Ib2zyFguGeQ5PLRmc89m6/95j6y5qmmU5nsDM=;
 b=Gspwp2kmCkyf+HYwb9RaKsGDniISU23gkBV/Xgh/ZMDjNPeuEtliuokirRFIMQ45/QpkaCX5aB2QX3dbhCG2ZOjBKYTF7UVrKGr/keF3KFxmDxIlhtr7jk9hxSNV5SMfwGsgKBwBKYnXESN9ItjnLjzlDbVRPPQDVn89t5xjrfI=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:30 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:30 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:25 +0100
Subject: [PATCH v6 12/20] rust: io: move `Io` methods to extension trait
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-12-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=7040;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=OqMl/YNl6A2qolqH5JXlE2pz3W/cSM5Ln5OcyIW0yKA=;
 b=B3OAdTjEdoyosfonNviNcB+VBeY/tA1kbhLB00VUiaqDBChlRihEXUF6cvgZ8z8AgTcnWeX5a
 Qq6Fuk8yYAZBJB9sC+r7695mO4PIjm1VgFQLjaLiQuT4T19PkSJhV6D
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
X-MS-Office365-Filtering-Correlation-Id: d64cf267-19f7-4b42-b932-08dedb5c5270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|3023799007|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	6HEOXxG0N1XL+hGD6OgixhBtEMkawbJngQq6sTqOqBHu02tyFLWyHjyEPePl/HwfURJ9uV3jIMgulQr1GSHeZBC6peBdqmsISMurWEC6GxeFkuBGoalFuHEaLEsXNYebMdpKH5heJyBqZ03bsnOrRgn06VDdzEe9RZYI0BYW9V++liupxpzFZbQaqRVRclS5Vc9G1roalIVX/azfS3agHQA1JHeq0iGADzRcLTfC4Ur7IG5T/hlH3TlPGTgejuiFRMP4BoBQxgZwXnq/HmBkhRv+CEZFE4GLk2mCxVJW8z1zpHZDhkoKmU8B0MZM9iJ4i1nlAz2uANw5+ypD/15DGDcYwmd3T1VKbP3qNS1dqX8QJXNjJk0F2uCuMR5202pteDlQa6iHiUYt/HjexXezN5p9K3Hq4U1uYCOeusDcf5lYoUl6dvIo3Pfe4oQHuKmL2VaX2TNKZ3AZvKiu5D8rpCYdE8oYEQIC5iNvCJEQuNQC9HQHXBNcYkLOTCfrn5N8df34Hs5psYiTkgXKEEtQBeJUEKWNQumLU3tTCfvbQrgHXo8rPljmOVsz9cGRaHZFZrTECEk5HZcpDFYSfvU8aUro/s7pkyruUMH2tM4cuzBWiiQO65+00dWDR2G4tzgZD6uviaoQApynVPQQ+lKkfIdqqf7EBhEYw340cHrdKtq6HHCkQZnvb/pG5RTRLY2/WLt/5Qn1nE844RENBjm4FQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(3023799007)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEthVXFXVkUwWUQrdVEvcVlUNnFEd2Y1ZnJscmVyL3FRWE5UU1BNSXREUEdh?=
 =?utf-8?B?eEprZld1dkNtSnlUMlBCTzFCM1B1NHJBbkl4anZsc2ZOVk1UTEhKRXQzaG9i?=
 =?utf-8?B?N3BYUFhzTkxvQlVuTm4zcG5FUU1sMlM3VlJyOG5Cb2Yrc1NHYVFGMVJzSWhJ?=
 =?utf-8?B?VU82Nlp1MkpQQndBNVpZMHhIT0NSYS9SRnU3OS9GZWQrL3FCOFAzTXVIeUFv?=
 =?utf-8?B?OUJIaWpqckNtMTc4K053VXM2NUVJQzlyekFGQUprUVlZOG0wbCtLYmtQeDdI?=
 =?utf-8?B?cEFoaFRBbmFvekJXcU8wY1pNeTV5RXVCZmJNalEwZ2xOMXR6V2FIZGkzSEdM?=
 =?utf-8?B?VXkxOHB4TWFOOXI0bEkybHgraUZqNHdXMUMwRlFrTjNyQWhTM3pVTEFUaWUw?=
 =?utf-8?B?d2xvUTlFSFM1UnorT3ZEdHlObnBjYUFnd0h2OFlGUGxEbHZtN1JGQm5ReU5Q?=
 =?utf-8?B?cndpTkpoV0VoeWVTTk1ibHFSMytNWXlZdDFacEtBbkxZNWhKdWJqb0ZNcnE1?=
 =?utf-8?B?NmkydTRmWldSeHhIV25UdW0venBZN0RvcGN0d0JiUW5XK3dxamhUYWZ5dnI0?=
 =?utf-8?B?YldTUTFrZkhDR2lKdmVZVDFjdUhYUFMxZlZOR2kyRm85RVg3bUpZTU9VNVph?=
 =?utf-8?B?Wk85MklyWHA2bkRvTnBIUC9HRUZ2Qm1VM0ttSEdwL1AzSnBBT1FwUHFXNklo?=
 =?utf-8?B?bjMyVTgxdHRrelRUeFM3TmZJeW5QN0ErbzRCSHNnbTZIOWN1WDhnMGFnOUNz?=
 =?utf-8?B?b04wTmlMVjVxKzNNZ1Z4VzAveDUvd3VOSXduaWdIci95b0xWRmpxUVhnSm9p?=
 =?utf-8?B?eDkrbHZ5MzlFbFJlZVozamd2bFEvdFd4V25HVkF2d0JDZS9obFd0N3d5NjFo?=
 =?utf-8?B?UkorOWczNGYzMmdpT2tkWHVHeGl4R3ZUU002YVNaNnlVbUdRb1VxTmJQVytR?=
 =?utf-8?B?TjZ4SE5SN0t4M1ZsOE9JRU40QkphMXV5dFBzUWM2N2kxbUM2Ry9TMFV0aXQ0?=
 =?utf-8?B?eGpiUmJlSWwveEpXVHN4ZFlEaGFURmlMY3pqdnpZN2N2RWRZcmh1YnQ3bkd1?=
 =?utf-8?B?MVFENytpbVJPa2JCOTlCWlp0b1VIMlRJbW54d1BVWW1zRkVqT3pvTXJNVll2?=
 =?utf-8?B?ZjJvTmFqTUx2MVNJcnJaL1B5SjlYeHIvN2p5c2dUWVozeVd6cmp2UmNQczJQ?=
 =?utf-8?B?b3RvdkxSdzBBbWRUaDBPZFhMdktyNE40SjVPU1lSTzlKekcrUlNXRTlyRk00?=
 =?utf-8?B?NVRkWVlzU29UZENhRzN2ZkpNK0duT2J2MUFVQlBUVzBFRmMyTkh1eS91Z0F3?=
 =?utf-8?B?MXorY0ppNm94ZklVbkpvZE1EczIyczF3dUFvVG4wYVZUTHJtUjhBeFZ2K0o3?=
 =?utf-8?B?dkh0R2lEVXh2WURFUFRJb2hBVlE2czRsdG0zRXZDM0kzWlNLMFdPQXQ5SW1H?=
 =?utf-8?B?NkZ2SmJGMDBpamkwUWJ3ZU5sVGF4d2lMNTcwWmRuQnhocWg5czNuaGNEekV0?=
 =?utf-8?B?WnYrYklpeENWT0s1V014N1JFc2ZQUDRtMmdMZ29PbFBaYm5oYk53N1FJL1Y5?=
 =?utf-8?B?THlMUkQzdW9xeTdHaEhLVXFkMVdpMW1UbzlSOWVuT2IycFBOWjd6YlNpTnhi?=
 =?utf-8?B?NW5sNzBYT0hjMUpqNGtXb29iTzgwNkpsZXZ5eDU0Vnc5ZkdiQkg2QmxmcUFa?=
 =?utf-8?B?R3hEMWZObjlqZW1kZC82L1RGQUh6alA4TFROdnlPWU9XcS9oY1JGV0drUmlm?=
 =?utf-8?B?WVl0R09Qc3kxS01KdjVxbEZyZHpLK1VhNVVnQjhmU1FXUUtoTzVnR2c3QXRo?=
 =?utf-8?B?UGZVK28vTjIxWUNENVYvVUtaTHBOQnpYQW9hZkRCYU45OFNCck0rZWN5TlN1?=
 =?utf-8?B?UjBwcTVBcG5xbEhSSC9haVRGam5EU3crUDlDWHlSQ3dKMnlLQWhwdzh0SGJD?=
 =?utf-8?B?VUNXM2M2L1I5N1pleVBpUVdxaVZWOEJYYzJTL2xKYUdtRVFGUDZPblczbW1H?=
 =?utf-8?B?ekNGYk1pQTBka1JUck1jRkpzT3V2Rnc3UGFUeldNMktNd0ppK1dwc0tvOHYz?=
 =?utf-8?B?SHUwRjRvL1ZTZ0s4Q2JUbTN1eVdjREtHUkx1QU9oOW4rclhTVXh0VVk0NEVC?=
 =?utf-8?B?M21tbm5DZ0VDZlgwS1hhMkg0K3NlNThseVpjb0Fwa3RYdGlhQitGbVJYeGtK?=
 =?utf-8?B?Zmh6Rm9lWFE5Q0NxY1JJYS9VenR0M05MRzY5QWJGd2VKdHVQLzhXQUE0SVgz?=
 =?utf-8?B?MllVU0tSeTU1MTZUVmsvWjRoZHZOWmZNaWZUT1Z6RzJpZnRCTFpDTzhwLzNl?=
 =?utf-8?B?ZVRwQ2puNldTdkd0RGJ1bWxsWFZaczJ6RnRrZ3VrVjRZM1hBMER1QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d64cf267-19f7-4b42-b932-08dedb5c5270
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:30.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWINpdcaA8ZmuAlbyG1xdDAGqhuikf8DYHVmyWgFR6lFv8ZoznXXxyWmlVdFosYloBWIvGp4vr7brTuGnc9n2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
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
	TAGGED_FROM(0.00)[bounces-9600-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28A80710C5F

`Io` trait now has a single required method with many more provided
methods. Provided methods may want to rely on their implementations to not
be arbitrarily overridden by implementers for correctness or soundness.
A good example is the `size` method, it may be relied by unsafe code and
thus must be consistent with the metadata obtained from `as_ptr`.

Thus, create a new trait to host `size` method, extract existing provided
methods to the new trait, and provide a blanket implementation. This
pattern is used extensively in userspace Rust libraries e.g. `tokio` where
`AsyncRead` has minimum methods and `AsyncReadExt` is what users mostly
interact with.

To avoid changing all user imports, the base trait is renamed to `IoBase`
and the newly added trait takes the existing `Io` name.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/devres.rs |  3 ++-
 rust/kernel/io.rs     | 34 ++++++++++++++++++++++++----------
 rust/kernel/io/mem.rs |  6 +++---
 rust/kernel/pci/io.rs |  6 +++---
 4 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 3545ffc5345d..6e0b845b229b 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -68,6 +68,7 @@ struct Inner<T> {
 ///     devres::Devres,
 ///     io::{
 ///         Io,
+///         IoBase,
 ///         Mmio,
 ///         MmioRaw,
 ///         MmioBackend,
@@ -105,7 +106,7 @@ struct Inner<T> {
 ///     }
 /// }
 ///
-/// impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<SIZE> {
+/// impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<SIZE> {
 ///    type Backend = MmioBackend;
 ///    type Target = Region<SIZE>;
 ///
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c7533d605678..ab970e8b2e78 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -223,7 +223,7 @@ fn io_view<'a, IO: Io<'a>, U>(
 /// operation.
 pub trait IoBackend {
     /// View type for this I/O backend.
-    type View<'a, T: ?Sized + KnownSize>: Io<'a, Backend = Self, Target = T>;
+    type View<'a, T: ?Sized + KnownSize>: IoBase<'a, Backend = Self, Target = T>;
 
     /// Convert a `view` to a raw pointer for projection.
     ///
@@ -309,15 +309,12 @@ fn offset(self) -> usize {
 /// Types implementing this trait (e.g. MMIO BARs or PCI config regions)
 /// can perform I/O operations on regions of memory.
 ///
-/// The [`Io`] trait provides:
-/// - Method to convert into [`IoBackend::View`].
-/// - Helper methods for offset validation and address calculation
-/// - Fallible (runtime checked) accessors for different data widths
-///
-/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+/// This trait defines which backend shall be used for I/O operations and provides a method to
+/// convert into [`IoBackend::View`]. Users should use the [`Io`] trait which provides the actual
+/// methods to perform I/O operations.
 ///
 /// This should be implemented on cheaply copyable handles, such as references or view types.
-pub trait Io<'a>: Copy {
+pub trait IoBase<'a>: Copy {
     /// Type that defines all I/O operations.
     type Backend: IoBackend;
 
@@ -326,6 +323,21 @@ pub trait Io<'a>: Copy {
 
     /// Return a view that covers the full region.
     fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Target>;
+}
+
+/// Extension trait to provide I/O operation methods to types that implement [`IoBase`].
+///
+/// This trait provides:
+/// - Helper methods for offset validation and address calculation
+/// - Fallible (runtime checked) accessors for different data widths
+///
+/// Which I/O methods are available depends on the associated [`IoBackend`] implementation.
+pub trait Io<'a>: IoBase<'a> {
+    /// Returns the size of this I/O region.
+    #[inline]
+    fn size(self) -> usize {
+        KnownSize::size(Self::Backend::as_ptr(self.as_view()))
+    }
 
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
@@ -779,6 +791,8 @@ fn update<T, L, F>(self, location: L, f: F)
     }
 }
 
+impl<'a, T: IoBase<'a>> Io<'a> for T {}
+
 /// A view of memory-mapped I/O region.
 ///
 /// # Invariant
@@ -819,7 +833,7 @@ unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
 // SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
 unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for Mmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for Mmio<'a, T> {
     type Backend = MmioBackend;
     type Target = T;
 
@@ -920,7 +934,7 @@ unsafe fn project_view<'a, T: ?Sized + KnownSize, U: ?Sized + KnownSize>(
     }
 }
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for RelaxedMmio<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for RelaxedMmio<'a, T> {
     type Backend = RelaxedMmioBackend;
     type Target = T;
 
diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
index d9b3189d09b4..e95b769ebe47 100644
--- a/rust/kernel/io/mem.rs
+++ b/rust/kernel/io/mem.rs
@@ -14,7 +14,7 @@
             Region,
             Resource, //
         },
-        Io,
+        IoBase,
         Mmio,
         MmioBackend,
         MmioRaw, //
@@ -210,7 +210,7 @@ pub fn into_devres(self) -> Result<Devres<ExclusiveIoMem<'static, SIZE>>> {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a ExclusiveIoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a ExclusiveIoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
@@ -292,7 +292,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a IoMem<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a IoMem<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = super::Region<SIZE>;
 
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index 4be33ecb4192..4d1d0afdc491 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,8 +8,8 @@
     device,
     devres::Devres,
     io::{
-        Io,
         IoBackend,
+        IoBase,
         IoCapable,
         Mmio,
         MmioBackend,
@@ -144,7 +144,7 @@ fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {
 impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_config_word);
 impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_config_dword);
 
-impl<'a, T: ?Sized + KnownSize> Io<'a> for ConfigSpace<'a, T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for ConfigSpace<'a, T> {
     type Backend = ConfigSpaceBackend;
     type Target = T;
 
@@ -267,7 +267,7 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, const SIZE: usize> Io<'a> for &'a Bar<'_, SIZE> {
+impl<'a, const SIZE: usize> IoBase<'a> for &'a Bar<'_, SIZE> {
     type Backend = MmioBackend;
     type Target = crate::io::Region<SIZE>;
 

-- 
2.54.0


