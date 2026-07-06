Return-Path: <linux-pwm+bounces-9607-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ddxIOlqlS2ryXgEAu9opvQ
	(envelope-from <linux-pwm+bounces-9607-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:53:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A09EA710D1E
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 14:53:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b="vKVoT/34";
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9607-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9607-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB9153094B49
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513A43F4BB;
	Mon,  6 Jul 2026 12:45:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021114.outbound.protection.outlook.com [52.101.95.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB94435A90;
	Mon,  6 Jul 2026 12:44:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341899; cv=fail; b=VU6ZvX8R6n1iVYxK/2KIdRGF4P+a7EYLz1oavOkTXVV/MRTFbaWq9P3Twy+Dv74A+shRgR9iKFhtUu0l4KvqpdhSVecwdNzgCLwu5JQ2BieBxTuQnFO3etRHDGYdcDCSzMf1dns5m4rlEXsPSQBVvheGc6Xi7nTtN4XSGVUVZ3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341899; c=relaxed/simple;
	bh=DZngAr33Rf7pKWSvju0Y416Sy1lWY1j3Syw+OHdOUFM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lhC3FtR4kU40IHyx758D1PCx/GFEg7f37SMOlRtVvsfy2fdyRK8nSi3qqgEsMR4S/muE+HPJk4QedTN+jxgDiPIqO6laST/WXfVgfsTIzzrDJpK54ygh2zNvhRQWx1oEeFPURfCUeJLzcnSeRoPOeDm+JSY0+lYv+Hf59y/RfUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vKVoT/34; arc=fail smtp.client-ip=52.101.95.114
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lX4z5f3gFo3z3cc+tPtp52ZiYgrc3r+aCj4plQT5DU8UV+n4NLquJeXdpIscJyIUX5J7V0s+AvOtwbygL8EkXHyjQJVD11/IehhOlM+O1eF8w9sq+A5WOyXy0jdxxMsYZoVFkPoWGRZlyFrsOFxSAxAIQct7R2xZkwyu3iIRBO84t9LXqQJbUI49FDe1fDiYSEGLxEf8CN2VY2CZPTMpCnHTYyCv5WUpptUGHOe/sDOmiwqWD76AjwlCUZWoN+Aff+gPxWTSyqxiZwzSckUrsDJdUKAAI4KSabtDqDBx21XW/5cRl+DKXPzfdb1+qdmr0ifGxsj+WQR4iYnUcVcLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axNoeHyM7y29ceF7DiKai9VCveu/Y2sESrbVhFBNmlA=;
 b=sxqoPhkJUVal/sgRQq06F2fpX/PVGOefczieFCGcaB9xBsmzv2iY1eXvHcHfuAn7zLnAO+Aq6jciw+MsTzC9KpIx8BHmRQkzqAUVmA+2593YYDnBEZD0g5csrbDWCjFOHxvy8WjJjZjggBk1MySR9jwoArpSpCyrFwxYtRgokx3u4bRXFywzs4T5KhfpS5rvuwWKWzKeJklQ7GBZfhivYSshSXWh6ThdjSGGWmrZ4pRVlQP1Bpjv+SAQu07C2JpYj7HZm1BNmqP6mDwgGjhcA/fXg09qVTCLmPc5J5wvzAbA0XBpwDAPJHvR/uFOdSTn+c7rviv/9gf4N8TULfidNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axNoeHyM7y29ceF7DiKai9VCveu/Y2sESrbVhFBNmlA=;
 b=vKVoT/34kY9FBJB9tLDujcF5sIjrMX3ZB0xqDn1OQSUqoo/neu9D/46Y4M/QkoVMKNbb0bjCf1T3Gn1sKzBMJtsN2d2RXoW8OUudfVjRevk7uXKoiHvHuEHJvfL2Aqz6amJatp/SALC40uEjzfubhYzAY06x3XRVDhZNigJPdsA=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:33 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:33 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:32 +0100
Subject: [PATCH v6 19/20] rust: io: add copying methods
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-19-72cd5d055d54@garyguo.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341864; l=15366;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=DZngAr33Rf7pKWSvju0Y416Sy1lWY1j3Syw+OHdOUFM=;
 b=FabqFRI/c0DTiR3G0S++/eUH0/HkgBngh/1cFo9tYyZEhWjAo4R5NoTQEQgF2v3oLajGQnFe9
 mZPsFPdkTTECKZ3V9IIDcUrtY4XX9vhf/vurY32Cv3H/cBq8vdGuG6H
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
X-MS-Office365-Filtering-Correlation-Id: 0d262a76-d574-4bba-c226-08dedb5c5452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|3023799007|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	DAM/hxtuqbSujjLFORpOq60BU0M/IOMtZCuy8oR7V9rfLZq+o37w/YyTww/bimku5Ho9w8YdBH6pF5Gl4TvGTATmLWb3aPOjpRFR/1HB/guKGC1kDDpa2quN9XZ7luyXBeRcFPt6YeOls8LXi2YVtk+QML5oBqz1PW50zuiSwszBjJurUfJCqheZyRSpnjftqD6ewwY0OX9jAuAxz9oWsP5YfX7yoFA+oz/OBaJ9rMPz+my7Z8dtF+mQG8iViCaDZWa3oiChqi8nwoYssyIIjsqLhCHs8NfG/D2snZ0KrfRwAFvUOCLD5aJxhNdSf+8zS1KgRZGPrzUmX/W2LL5y72/IHpfDBDLo7oCZQCNEHN1cVsQWNb58oZ6hWna4tY4tJNNaHbAKgbKqhxiErN0SFXb7OtQGDW6xqL0iwWt2rHnoI3t/nWMxLreHn/KrEuL9L8kwRiVoR+FcmXOP+nsCtZbtBruNd67HnMDwc+v23CxTj5eOR9fOIj+WqbnQtN59+zEBe8dIsi5LOGYp7L7wGS5puEuHcmW51T549RI4PZpY2GcOTAP3J6/si4Kev0/jQuSrHkgbViWihianZbSiVflCTtZjxvxgC2EjhFP2qLij96DszHuSQmq4+b0XmvuKETAiCd99U2UG8AZR06XTlD1d2f/MpUEC9JPbvZgE/grEW8jRXfQEDNDL5pIXgvkR02Wewn2aIXzaYN9SZCmeyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(3023799007)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFh3Mk8ybWhoTktBV25xTXlZckZOUzVSTGJFd3pxWDBNajZIVjl0Wm5UZTVo?=
 =?utf-8?B?N2JVMmx0QWxiVU5YS3p1ZWU4SDdWWGYxZTJIU3JhRlV5d0NFSGlvY1BldWdu?=
 =?utf-8?B?VzUrVUdIYmhhMHNnRlNqTG9pL0huUkc1aFU4NUx0T2RxckI0SEJVUXBORFRC?=
 =?utf-8?B?bHJvamVPYm9vWnZzdnc4bUNZbmVKc2FiWExMeENtb1VIZloxbWRVV0RORUVy?=
 =?utf-8?B?UTNPY2diZ0RBMzFqMkJ6TXV3SUZoRGxJOUx4Q3VpbGo5K1MzUnNXN3dXS0tw?=
 =?utf-8?B?RDJtWTZMWDA4K3BQZ05nTFcySXBZQlRjc0hWYlNpbmdTdXdERCtWRHNneFEv?=
 =?utf-8?B?cGdJWUhpUVByd3hyM0hMd0tyckZJdTdOQnZFS0xSWWQ2bDAzMmZQUkVGKzhD?=
 =?utf-8?B?czFaZlVBVGNnVDlod0w3VEZWMUd5cGZNUm5aOCtUS0xuZDFVUnlKQ1FHenh2?=
 =?utf-8?B?L2I1RThjNWVSc3lXOXRSWGJ0Y1UwNm91N3NqK2wxL21nM2FtbkpibGt4bjJs?=
 =?utf-8?B?N2NhaS94YXptQU81L0MwSlA3aG9TWDhrTmxUS2pPZkNENjU5dU5DQlM4c3I5?=
 =?utf-8?B?WElaRk5jZ0QvQ3dhVEtZazNlVSt3Nmpmb20rdFpRUURHUEluRnVGZ1ZCZ09J?=
 =?utf-8?B?WWtSZ08yZGp2US84UDJIWjRVamZ5SStXL2F1S3pyZGdyMFNyQllDMkFiR3F3?=
 =?utf-8?B?RGNDeFdOenUxTDJEMlV6R3BaRWIvTXkzNmdEREdsOVExckJNUy9kdlpkRlNL?=
 =?utf-8?B?aWdPTjY2UVpDRk9wV1A0ZlhialNUSTRva2dMSC8vaEdjKy9zcjlMNmExM0Zl?=
 =?utf-8?B?Y2FJRWh4YWlpcjNtR0dFZFpDbzlsWGZFdFlzdDQ2c3V3b2IvcnhDYk5nNWFQ?=
 =?utf-8?B?V0g1ZkpkcGpHdVNpbElXTTBBbzJhazJ5THk4bHMyTlFkTCttUXlaTmczTzho?=
 =?utf-8?B?NlljL0Z5RE1nc05HZHZzanVLNFZBQjUxaUFYMU8zRDljOUpWU1ZVbWxwYUhz?=
 =?utf-8?B?WTMyZm5QVy9LRGJ5VmNjZ0U1aDdxQVNOUitUQWZuMnB4bHJ0bThmUEs1TkRZ?=
 =?utf-8?B?WjlaNFRkQ0E3RzlJaDNFdDlYeXE4YkVpYitlcWk0eFhwL0haV2hkTis1bkw0?=
 =?utf-8?B?UHViNVpzeWVYemZsb2FOeWhYdWRCM0JqdjdYL3VWUlZPWEZHUnVuL1dZM1k3?=
 =?utf-8?B?cEViYnllL01wZEVXUHZqTUJES3RDSVhFeTBjMFVUd0p1eUd0TkZmaW1RV2hi?=
 =?utf-8?B?NGNNaGJHdVA5L3NkeGRwZk9LYlNCMEhKRmIzQURsNkdnWXpSUE5UU2p2VUVq?=
 =?utf-8?B?V3lBQnpUSCtCVTJ1U1lxOEhVRjFDVWlGdnFTZHJjVkdsb29DajBkVmE3RGZz?=
 =?utf-8?B?OEkrL3kzSmxMa2tIaXA5c1BqaHdhU0ZhaGx3d1ZtcWxocU5BZ2xvNXJiVTB3?=
 =?utf-8?B?U0x4eWZXQzIzODFZeklRMUk3QVNTUVpsVHY0NGtwUmRubDhlMitFaTBEMXdu?=
 =?utf-8?B?ZXNGb1VQSVNRYTRTaWQ5dVMyZTZ1Ui94WHNUbGloWjgrTndyS2szMFR5TmZJ?=
 =?utf-8?B?OHJpODd4YkxEeXFOZS83V0ptZmloeEpYMGkrWFlhd1BUWmRYMTlSV0prZS9n?=
 =?utf-8?B?b2JYR0tYVlNMTmRYbUx0am5qVDZzbXJoQ1k5NjJOcnYzaWo0N3JxRnlTUXM2?=
 =?utf-8?B?bWJDMURxcUFsSlgxK0Q1YWtBZERtT0kwNXBUKzZiRFdyeFZJOExuYUlaMXVU?=
 =?utf-8?B?aXRHNUtjWGRJTkI5cmdSdUNlTXlqa2UwSGZOelM5eUJIM0hvdFFpUlJtMzNI?=
 =?utf-8?B?TG5GcmxKbStTV2lsa2Z3TEZ2NVhYdjZpUkJQYmUyM242c1Zjd1J2QlpqRTVy?=
 =?utf-8?B?L0k1L285RUR2eERIRnZ0NnRvWE9jaHY5b0dpMlBJWm55QkhneGtDdzBDaW1u?=
 =?utf-8?B?SVJEV0pjZGszNnlrb2llZnhCeEFaN1AxU3JnbU1EQVVGUHlORmtXZ1c4V3FL?=
 =?utf-8?B?ZzJHdkFpaE90T3k0OUl5cDduVWx6TzhOc3VuZTFRMVEzRkg3VnlzRlV2SzQ2?=
 =?utf-8?B?ZVBJeWg5M25rb0NVb0V4cjl6SmdwajFGTHBIaTZZV3o5NWdTdUVXY0E1Rmo3?=
 =?utf-8?B?NVNvUW5RZVVsejFqZ0ZhRXArVng2Q3pDdlBUNmNpWHc2MlRqKzZBeGlxVnVy?=
 =?utf-8?B?bmVkcDVDV0p5QlQzUmFEYTVWTWUwaGFDUTEzL3A5RU54aWU0b3M4OEZPYlpK?=
 =?utf-8?B?Sm1pN3J0MnBPMy83TGtkODlDNFkrcDFBeVdjSXlEOWt4TDRuaTFqUGdDZ2g0?=
 =?utf-8?B?Q2RNTlpHbjJEMVJiTVZuYWZjbk5rS2poWGNYQnpoOTFEM09FUkl6Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d262a76-d574-4bba-c226-08dedb5c5452
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:33.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJO8GTnRjtmXmYg+lxq9Z7Xckcu1Ib7gcoOqhkitC216rHXxrc8Fc2Ix6DTtZboA8nHgJFxP+LXMfzHHW0f/ZQ==
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
	TAGGED_FROM(0.00)[bounces-9607-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A09EA710D1E

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
 rust/kernel/io.rs        | 262 ++++++++++++++++++++++++++++++++++++++++++++++-
 samples/rust/rust_dma.rs |   7 +-
 4 files changed, 303 insertions(+), 4 deletions(-)

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
index 6e7ea3b72f2f..e275f2562a5b 100644
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
@@ -1197,6 +1198,30 @@ fn io_write<'a>(view: Self::View<'a, T>, value: T) {
     }
 }
 
+impl IoCopyable for CoherentIoBackend {
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
     type Backend = CoherentIoBackend;
     type Target = T;
diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index c423125870b7..9df4e982c5d8 100644
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
@@ -274,6 +275,69 @@ pub trait IoCapable<T>: IoBackend {
     fn io_write<'a>(view: Self::View<'a, T>, value: T);
 }
 
+/// Trait indicating that an I/O backend supports memory copy operations.
+pub trait IoCopyable: IoBackend {
+    /// Copy contents of `view` to `buffer`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile write for `view.size()` bytes.
+    /// - `buffer` should not overlap with `view`.
+    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8);
+
+    /// Copy contents from `buffer` to `view`.
+    ///
+    /// # Safety
+    ///
+    /// - `buffer` is valid for volatile read for `view.size()` bytes.
+    /// - `buffer` should not overlap with `view`.
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
+        // SAFETY:
+        // - `buf.as_mut_ptr()` is valid for write for `size_of::<T>()` bytes.
+        // - `buf` is local so `buf.as_mut_ptr()` cannot overlap with `slice_view`.
+        unsafe { Self::copy_from_io(slice_view, buf.as_mut_ptr().cast()) };
+        // SAFETY: `T: FromBytes` guarantee that all bit patterns are valid.
+        unsafe { buf.assume_init() }
+    }
+
+    /// Copy `value` to `view`.
+    ///
+    /// Destructor of `value` will not be executed, consistent with [`zerocopy::transmute`].
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
+        // SAFETY:
+        // - `&raw const value` is valid for read for `size_of::<T>()` bytes.
+        // - `value` is local so `&raw const value` cannot overlap with `slice_view`.
+        unsafe { Self::copy_to_io(slice_view, (&raw const value).cast()) };
+        core::mem::forget(value);
+    }
+}
+
 /// Describes a given I/O location: its offset, width, and type to convert the raw value from and
 /// into.
 ///
@@ -353,6 +417,24 @@ fn size(self) -> usize {
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
     /// A runtime check is performed to ensure that the target type is of same or smaller size to
@@ -442,6 +524,121 @@ fn write_val(self, value: Self::Target)
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
+    /// backends (e.g. `Mmio`), this can write different value compared to [`write_val`] as
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
+    /// Copy bytes from `data` to I/O memory.
+    ///
+    /// # Panics
+    ///
+    /// This function will panic if the length of `self` differs from the length of `data`, similar
+    /// to [`[u8]::copy_from_slice`].
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
+    /// Copy bytes from I/O memory to `data`.
+    ///
+    /// # Panics
+    ///
+    /// This function will panic if the length of `self` differs from the length of `data`, similar
+    /// to [`[u8]::copy_from_slice`].
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
+        // SAFETY: `data.as_mut_ptr()` is valid for write for `self.size()` bytes.
+        unsafe {
+            Self::Backend::copy_from_io(self.as_view(), data.as_mut_ptr());
+        }
+    }
+
     /// Fallible 8-bit read with runtime bounds check.
     #[inline(always)]
     fn try_read8(self, offset: usize) -> Result<u8>
@@ -1000,6 +1197,28 @@ fn io_write(view: <$backend as IoBackend>::View<'_, $ty>, value: $ty) {
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
@@ -1143,6 +1362,47 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
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
 /// A view of a system memory region.
 ///
 /// Provides `Io` trait implementation for kernel virtual address ranges,
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 4af46e99d2dd..b629acc6d915 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -14,7 +14,8 @@
     },
     io::{
         io_project,
-        io_read, //
+        io_read,
+        Io, //
     },
     page, pci,
     prelude::*,
@@ -38,6 +39,7 @@ struct DmaSampleDriver {
     (0xcd, 0xef),
 ];
 
+#[derive(FromBytes, IntoBytes)]
 struct MyStruct {
     h: u32,
     b: u32,
@@ -81,8 +83,7 @@ fn probe<'bound>(
                 Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-                // SAFETY: `ca` is not yet shared with device or other threads.
-                unsafe { *io_project!(ca, [panic: i]).as_mut() = MyStruct::new(value.0, value.1) };
+                io_project!(ca, [panic: i]).copy_write(MyStruct::new(value.0, value.1));
             }
 
             let size = 4 * page::PAGE_SIZE;

-- 
2.54.0


