Return-Path: <linux-pwm+bounces-9385-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nv5kNuwtPWoyyggAu9opvQ
	(envelope-from <linux-pwm+bounces-9385-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 15:32:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 705176C6278
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 15:32:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=EzG496de;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9385-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9385-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A77301AF47
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 13:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA9132E128;
	Thu, 25 Jun 2026 13:32:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021134.outbound.protection.outlook.com [52.101.95.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB497317166;
	Thu, 25 Jun 2026 13:32:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394328; cv=fail; b=Gpiw1cj4u8FbfSKt8sCUSbbxEeVEPKBXZdTCB/qtowcvz446U2jJkFzcBNNzveHpkvaCmjh+Mi9k4i70qu4J09UhaDBLh1ccKFW+Qpbqb/O7X31yoUyX1jzQ+L+vahX2RK/zcPLUGtOsCAzrQD81deqAxAYeC3b/eblYzdJY5FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394328; c=relaxed/simple;
	bh=1ew9QMwHCEr7H7yLIe4LJ/XcEZHsln/NcP7mZQ6Qch4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=D368nrcJONrfhTd8lgiW1B+mkF1mDc4NBRxtmStFOXqrJipEPxrRqfyYMd48g+iVfjU/xi/IKmQ7CxSElffPyKUUCn8opjmHcquMG4NkbxPRCTMQZXc4zkwtA0GUAaueFYTrk+8CrTvRc+Yk2Ay1VG+R+qRdHCqaE7wWw3z/8L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EzG496de; arc=fail smtp.client-ip=52.101.95.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrRJrM0vftclD9fKYoCuse0aYqBJoPKekw5FolNKN51nW7n8R7EBPvmQM1CJrevjjI1yF7BHXikJa4YnR7qrsiYnG/3Bcnnkwy+xkNDGm5C3cz1Oy8fJ0Y1xv8vq2/TedbzI30hbildIywfkZYSJNfTLA4vzw2gCDp3DNffW49VCPxdGgIb/u0VeLm1YK+eJetD51amiIMy3sKQbRaBk+4wWsphnZv8u2e1/F5jjITrMvK6ods3MuPs1jh+3P4MqFisAoQNbbBGPi/rRav5evQmmE+xDOCUb3JGPa3nqqakgqKyVbaZbcxNVNPnYpNQZQ+H1syrSgqexXdJm6xD4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHQ6guUSIGY4OOtnNLgDKLo15+iwCoCAyyi9+8zC5AI=;
 b=Ruw4Nw1BGJ6Gm9IY1v1ju59/IgvEKmTgf5sqFe7U4NB6ml1NR37TkZtduvShyCNISiWzyrLXxKD9KfELex/igQOLzqO2BnNfTmnOHNhmgh5aubtdtISHS7LqOKRBr4qAVaiRdSFhLj6xNDvjMIG8LbgbRHhl9BeFfjLTmc6IoXml0dXEP3GSvEZtq2g/cvmKUjEvadt/o6DKt5QaDEZHmj1kBcKjjrcnNMebL/3HKL/Cf+cXU0jYteA4at4lbLWKl/Fwzo9StzwnU8IeIpGMNx6M6SV/AqASDe2Eby3a0Ga+tmiP+3s4TQFW37YN2vykeldQ8tkMZxwpcj48zsZKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHQ6guUSIGY4OOtnNLgDKLo15+iwCoCAyyi9+8zC5AI=;
 b=EzG496de8O7LTbLaSHx1N/W/Liz+2iSMPVJXMWozYMJqlmeYByAqF12w2YmS9M/9f2+rBypPzPx1nBxNTjbP6WFsswCKvjnCcIt6S1jcAc9iy7mpdVubVtQo04DfifG9Y+kfRzYpICrEAJEgUQSDbqV8eoOQ/aNpNp9xaxYZL6M=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8585.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:32:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 13:32:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 14:32:01 +0100
Message-Id: <DJI61Z8Q0EUH.3Q0D4YKWP6PM4@garyguo.net>
Cc: "Philipp Stanner" <phasta@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <driver-core@lists.linux.dev>, <linux-block@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-pwm@vger.kernel.org>, "Asahi Lina"
 <lina+kernel@asahilina.net>
Subject: Re: [PATCH v18 4/8] rust: page: convert to `Ownable`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Igor Korotin" <igor.korotin@linux.dev>, "Viresh Kumar"
 <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>
X-Mailer: aerc 0.21.0
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-4-4e06b5896d47@kernel.org>
In-Reply-To: <20260625-unique-ref-v18-4-4e06b5896d47@kernel.org>
X-ClientProxiedBy: LO4P123CA0200.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: c19f4044-ea34-411e-d679-08ded2be23d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10070799003|921020|22082099003|18002099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	cGtWeyoJfiqXtXeiGufoeMFxnj/8smGV/dsHBHRINDDqgS8OfV1+uaALHyNCNQxQdj9eCQrBlVg5Hv5p6OQUqCzDckdi1TluxF9uUipnB8vYfuFjqE3E2t0RJv1t+iNBde1eX/GSakkRREDc/IhXWUXat4XFc9+gJ1nVFaUOAVjabXb6cSTlvQIy8kttsT5tj3LfPCep++HMt6o6QD8eC0j4usrHJjShaiPjZl2+RjgskRZKB0fzE2JTOvGX6NkZBxfyuhOx0/y16BukJDCEmI1HNnUCM+ti6QUX7gJOkYLzYhT7UQzB4CXSXiZPQKRWtS00EJ1+JBGY197qmKcYQu3uuP1YR/8PP4DMvHTlzIfMV0U8oLtfRrBEsuhEd9aWsPq2vyT9k0jJB5yZ5H/hZKDyzxAodAqvy/xOmwZ/lJixL9CH/0WvtUKBCi7YqLa6mFrwNfL/IsONVrGM37eqURnbbLE6/8WeTkyYAVSI26nor7PjvGZTQVw9SOgHYVS4L1wPMXZynb0CRO1+iGqqc9mXkIudQR2fZEBQshm/2fmao1p7MymYO0ifH0mIhfOps/Zx7OcSY6aj00y4Q21SOhEJSsddqsbdXvy2AbVXSihS2ZuZ9wMq4+Stf/HYqlCxguRf2+PfDJrGtjMJYoG9ZDueSc6VIHKcMw8ccK/h+wOiwc03Hp8neGMNsaf9EeHrxQ4RtCnC0nn6ns2PgOJ3Sw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10070799003)(921020)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEc4RUd5STc1NHh0T05rWTdoLzlKVEY3K2N6RVBxdXl3bHVwbVpuNVRhT21y?=
 =?utf-8?B?OWNYLytCUy9DUDMyNVZ0QTkxazduL0lGZ2JYekZsSStud3ZqeURHMnNzSWNB?=
 =?utf-8?B?VGxZSHdsUHV5QmZPemRTbUxQQ3cvSWs0Rk5YTjEySThqTWVqeE53SlNQWkIz?=
 =?utf-8?B?RVVPY0FydUlUM3J0UnQ0N3Z3TkNmaXg3TUlYdW9JNVlkalZFekhoTnNOQ21s?=
 =?utf-8?B?VjBaZ2NOUG9jL0g5MGtYWHN5MHdkNVN5ZjZEeHhTUnNrSXZNa29pL1FhSmkz?=
 =?utf-8?B?QTJnV0RobXRJSzZtUi9QcjJhMHB4RktKeFR5bWhsRTZrWFpQSVpJUHZQMmFN?=
 =?utf-8?B?VWxIZ1BjNGtuREgwaWhVakpJUWoybUxScVo0RHZDWXhXOUQ5ZXFDbVBkWWJS?=
 =?utf-8?B?eVpyMmJwYUhlcDEwM05GbGpQNlFyaEhXc1lPZWx1MWMxOFlCV2dKTElQYmtN?=
 =?utf-8?B?bElUZk9hY0RWOTJnUWtid1R6bmtLTmZvRjlUSjFHRWUrRzNqOEFOU0RrZXBa?=
 =?utf-8?B?dE1RSG9PaDREOVF6d05hamptVHlNU2pXa1VROXcvdGs4TWwxTFMzOHdnWjl2?=
 =?utf-8?B?dVVvVHJySmhsbnVpQ29od3hJSVpkbVR1aFVIRTJ2NnNqQ0pwZVFHUGhoWEVO?=
 =?utf-8?B?YzBDM0RaTWhuUlo1UGV5bWp6ZWdwV3lWajRDYzFxMFd1L0EveEtKVzR6NkJ3?=
 =?utf-8?B?cmRYd2o4ajY1WlJQRUFDNDhWQjUrankzRTRaZlNsUXJna2RxWUs1V2hvOVNz?=
 =?utf-8?B?QkllVTMvOU9oSm1iVXN0Q1FsZ01SNUpadjlwMmNETG1UOCtIaFJFNmJYc2Nv?=
 =?utf-8?B?ZXE4cjBXbHAwZVFveU9DTDd5WitYWUhaUE4ycWlrUnJJWHA4c01MZEl3QkRl?=
 =?utf-8?B?dGQzbVdDT0VpUU81c2wrYzdpRjIrUkd2ZWtBRVZrVGVrQjBUQkN6Q1E3UUps?=
 =?utf-8?B?MHRBemEwK1FLNExaMW9sbWpiMmU5TXVLS25pUWVRK0I4U3dlcjN1V0JNR29R?=
 =?utf-8?B?SEpaTytMRFBFSDFMeXpUN1ZNS2h2RG5CbnY2REZkOFBJZk1CbE1qRUlTUzIw?=
 =?utf-8?B?RTkzc0ZxM0hYZXliZ3Q0K2pOcGRZU2JBd29NNENkckg5Z3VVdnFoUnNLSkNt?=
 =?utf-8?B?MDZsSEhCQk9wamNrZkYzeFlyOGVaR1Ayb0xCM2hhVmxqWEJXSEFiL3VpcUor?=
 =?utf-8?B?MzdDTHZRL2F4K0IrQW1TbnRVaGIwZWtGMk0yZEZ3OElSUEVPeW03ZFAxaXdi?=
 =?utf-8?B?ckRpUndjMCsrZmZoc0ZXanFBWE5aZkxaZjBGNDFvMWF6NURRZU1YeUhrTyth?=
 =?utf-8?B?NzZlQnJaQ0xGMWZlRm5nVVQ3Rkx1bW5jcVdmM3dxbFlKWkMrV2tjLzBYcnZj?=
 =?utf-8?B?N25nckltYU5PbnRGQ3pNSjVNL1lONlF1b0ExQVhzNDlZbmxpWlhpSjJMd1Bm?=
 =?utf-8?B?UGlBdVdwSDZPcHJ2MkZyemFaNks4SEtBTWs0T29xQXV6MmpZUXY4amx0UzJZ?=
 =?utf-8?B?NFAwSHYzQmdzY2UzY29JRDBwMHlGNnRGU3UzVWgxR2U5TnRpOWY3L2o2Rkw2?=
 =?utf-8?B?Umh0OUpjUWV6VWN2TnB4Z1ZDRWZRWmx3b2NzZUM1a0xVOEJqQXpCQXBzTDYv?=
 =?utf-8?B?YjFSU0NYb0FOcmUyNHFPUG05Qm5seXpubGJpS2pPWW1yNVdvY0NWNUd2RzRx?=
 =?utf-8?B?d3pvdUZ5OWV0Q1RzS3VCeDdBRE1sQzJ2MXNhbE4wU3lKSXNCRGFkWklxOWE5?=
 =?utf-8?B?SkNaQnJ4WFlLbkJ3UGkwb1MwVDNhTklqM3oxcFp4ZG9QR1pXTkU5anhCczV0?=
 =?utf-8?B?Ulp4QWVPYVl6M1o3eUZCSVRhNTM3d0FvTERJRDdlNWxiZEFtV08rdDdHbHZO?=
 =?utf-8?B?TUk3bkhObmZCK0IvRXkzcE9xWEh5cDJtay9yZ1JOT2x6MWpib2VXSm9tZkp1?=
 =?utf-8?B?YXc3MWlPN05aanFLTWs3V2F0dm02VHBKR1FtYmQ2dkxpMnAyVE1xUldJUlhW?=
 =?utf-8?B?UEt6K0VtaEFKc1NGMHgwN05SaWI0aXhHL0VtYnhaRXBsTE93cWdnNkNBVU8w?=
 =?utf-8?B?VnJQc2wyeXo5SmVMQ0M1Um5Vd1NDSXJ4SkZRUWJyTE11S0FEYXNGUEVHOUYv?=
 =?utf-8?B?emhWU3kwSjcydTl3a05CVGpxU0xONlRHUHRXdjZPYVFQNHlhNkg2YXMxaTVQ?=
 =?utf-8?B?SFJnZlpBRkU4czVaTlZ5Qk1xMXlsYUpIUGEveit2QTMzK3Ird0Z0WTZZZStS?=
 =?utf-8?B?czRLdlBXVVhkTGFjMTVnV3dwZ29jRGdBVjJERU5ZaUdtOTFhT2h2ZEpqYk5Q?=
 =?utf-8?B?dmsyZzJVM1MxVUlveFZ1emFyYm5ycFp1SGE5R09sNjhEYmV2MFZRQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c19f4044-ea34-411e-d679-08ded2be23d1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:32:02.0641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ly8TGOMP25bIwz1Wmd8sYio/7TZ9lDh2MglRXrJTP7nGjoYMCuFZI3EDUj2cGpsaEfgNLMBDvmu8Jgxni133w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8585
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9385-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:driver-core@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:lina+kernel@asahilina.net,m:a.hindborg@kernel.org,m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-mo
 ore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:lina@asahilina.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCPT_COUNT_GT_50(0.00)[54];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,asahilina.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 705176C6278

On Thu Jun 25, 2026 at 11:15 AM BST, Andreas Hindborg wrote:
> From: Asahi Lina <lina@asahilina.net>
>=20
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>=20
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Nice to see `BorrowedPage` going away.

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/android/binder/page_range.rs |  10 +--
>  rust/kernel/alloc/allocator.rs       |  19 +++---
>  rust/kernel/alloc/allocator/iter.rs  |   6 +-
>  rust/kernel/page.rs                  | 122 +++++++++--------------------=
------
>  4 files changed, 46 insertions(+), 111 deletions(-)


