Return-Path: <linux-pwm+bounces-8961-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPSDL1gqC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8961-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:03:52 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9456F809
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1244300A773
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3850264A97;
	Mon, 18 May 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="POeW0JNB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F96922CBE6;
	Mon, 18 May 2026 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115639; cv=fail; b=fAnk4F8NuyOIFibD4u8LcykOKvchBX7tlT/3XtaXx1a5YqIDMPQE/b606vv0JBEYxGcmRU4SmnknjVaz+wCZBQyPitVqmtB3BaHFNtoL6jpK6uPKfq+kercDtV/3cjj/+qBIJzkcLCY776mimVjyPgilM9wY1P0wh0RodOoFdcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115639; c=relaxed/simple;
	bh=LEO8eJQYxHD4cuS+Ldt8BNYtywbZD46Jtl8PELvrA6o=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=EaMfvmnuGw7Ak9GyHKmqZ/gZMvG4f6ZNmVLM8LE4Ol5JML8BqSw8LBW81PIAbpKh8oGO/aoAnXR0ZgSF9MWYv23lKN6gn0nIxdOSkx4/JFgDH5NszZUqWuW/ZN4v4xYoizSEPv/BtYXjcRwVWEuxQmEjHz73AwsreCGZy5qZhJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=POeW0JNB; arc=fail smtp.client-ip=52.101.48.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDaFGrNm1W3dvhqTZFKN5SSQWn4HoB348InuoweeV4sEWlNEXXmVbvsSrYV8Y2paxuvzs+j7vDQ+SdMW8hUWvGj26c0HGjO/5fSKCSFI+RXlUINIFhick3tnX6irYNqTZ66W1xJGG+UYjg1x9SkYdKdY1prccTOXiVEkfMvU3HAxFB8utNYzzSasKr5es+WqiXFHLufBBVNosgdU0habxVwleGRVgLMzjxKhuMFOJUDnva0giN9ZL6ohEJxzGcau+W0HruEwOM/nMdhmUehtH/LSqIth5PPsn6iPY82xiHAcdZ24+23UZo2TPEDt3rmfXfE7WvFWxPdcgjkXUZ7hXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEO8eJQYxHD4cuS+Ldt8BNYtywbZD46Jtl8PELvrA6o=;
 b=HU6iEcc/o9gMMMBx2bMCG+ZIn9048gKYxPWlErqx2kWwNaEeGmBxbrY5D34K4FS6nN8eHefx0zdBSehrBY720o6X747C85xK02JkdBTWrpR4C8zOBW/V6/HhBAsGAUpF4lBf4kro+NfaJl/G7Z4CU5KxqxcaMaYXwii1Xsrn/u5BcKoo0fYT4PatYUrYPEEwlW6OLWY4JNaPcRf8/SM8RRrXDUbL8IUqkWWtec/vrMnRTDqRRLxNI8SN+EFDgqHBF+jzCTdKSY2pOtKKpd0QjBmjxxg66tp/8/UTtZ5jcTckrdm+EuqEW7NWqN5NgQ9muz4Do2BOBy3G9yULz9fHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEO8eJQYxHD4cuS+Ldt8BNYtywbZD46Jtl8PELvrA6o=;
 b=POeW0JNBKmqWW+RzXUQ5KObJ7NdYAu9N3k/hB/6dPlUUTbcVbTEi69wPRw+xIPHBOMNPp8MZNlhmZ67gpcgKs8wUZpa0xFreCEPPjumtFOpuphFjmxFWUuQyWUuhjuOyn3BXCYzG0Kj2snV16874E03p47CuwzpGIbSBcOWDB3s7H+L07HCPeym4sTY/COaqvqetLg0S5gAlY4HUwyWdCtvhzaJuiij5JPqLAHr25kRhNogfpBTHSz3h91Zg99T2GH+UYKbWIeEaDgdFXLl+DgaWdelRA7H+nr2Q8MkPDa1/WeuNxO4L/uEY3Yo2Z46dv36DoHGlu+IOlLn3ngX2Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:47:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:47:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:47:11 +0900
Message-Id: <DILVUTZQMI3L.4SWI6KWI7YP@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 07/27] rust: auxiliary: implement Sync for
 Device<Bound>
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-8-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-8-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0142.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 98345ff9-4738-4983-be15-08deb4ec59e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	wU6FR1X0KK4EbhDMr49By0zHnacUrZyQAcJTSsgRCEBsWLPYrpLI2X9DkSHyKJeuUEIsCwe312aqpMHGZP5RUHfjH4GX4MH0fWWoBnDgChz0cTVhdlPw/NkNTx2Mxp9JRXn6+5iRjHjpQde2ZQlpDgg7kk6sl+GZxMj3YsRNepv434Uwmmap1GAXBQyGCi8PPNF+RsBI44yjnpVN6PDobe+Pkefwx9PE688RHIMJUaW5iTZqkycRao2iAtAAXwV3BZMFQ3HE9BCEdAmtqpwZQTScsW7RWIyr0IG90bUnUEdYkiygUHtCMqd1mQuSGzBACx/JEiMlQldjH3Vv9imgazI8zXsYnFyh6u25cXt6QbmbhNRbA0Pl1ZgOpNxGt57ZXEt/jG11hHB0UQtFenumcAMHnT29yoN9+O0NKujvW0nznRCfJ2AQekYjVJObkagUaM9bLwYiO+Tv3ZO1j8eBbNEvcRtmS9kNSuJk2jvnpg3NK4PkxLhbl5GBfVPWVxJhjD+5stLei80nO2uxSssj7x6OtvDRkyZJq/vTDrOIHrxk6z8IZ74n5PjTbMmyljqhW7Z91JbyMGU+01+LFUvOsCCEBYwEAqC/UEAtgU4wCEAnlZUq5r0k3ORYkHhlT86TmWjpegyFoSbGBdYU23d9VKKm3UFxVhdMEdQBxmu2iY/PydzC0f2M6fuTBVnBJZgS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTd4RnpTNkhlU3paMklCaG5CaW45WlR1OEplQmE5RXZ0bE00Y2Y2dXg2alY5?=
 =?utf-8?B?ZFU3Q3llY0JTcEYvOUNtU01vTk1KYytsMzl3TE1xMmdvRUZDQUNycSt0akRN?=
 =?utf-8?B?Q2pFTHpPTmc5WXN2M0R4VEtOQjh6anFXSXRMRENQUzJVczlYSmVaY2ZFNFZj?=
 =?utf-8?B?eTBUaHptQUxWUStOL1RRbFZZd0szbWJiOXZ1UmErRXFNenFmdExuL2J5c3Zw?=
 =?utf-8?B?a0ZvVStkS1M0NHlYWVR2UmZDdlVkckJXdlVPSTE5dXhpeFg5WUN4bGhOL3Jx?=
 =?utf-8?B?eDlkbUlDRERPODVpRHZBYmdVRDdzUHZlWFhnL3JkaTJNK0ZSYUNlcURHWC8v?=
 =?utf-8?B?WHE5a29jNkFGRFpGQnJXbFZCcUdTSGg0bEsrbWMya0wzZjM1enc5WHF3azlD?=
 =?utf-8?B?Z1dKc0U4ckRuWjBXdmZSWDliZ3RxWXg0N0FEaFZUbGVDRDlZaXh2MkJvdVMw?=
 =?utf-8?B?THhMN3FnSjBMaDBnakFla0duYjdhd3A0VkM5V2VBaWVFOU45NjE2UWhUTExm?=
 =?utf-8?B?NXRTZnRDNGJVYXVST0VLSWV5aVpNQnJSN3JsNEFiendzL1ZRakYwaTRyZFFw?=
 =?utf-8?B?SWNYVGltMTJ6MEJGTm15bnNRbzJ5UFVuaTdjQmM0c3NodGJDdVpHZUNLT1VB?=
 =?utf-8?B?d1dmeW9Xa29sNlJYUjNRY0EzR1drdzRtLzRnaWNNVTZ2U3d6UTIvTVdLT3dK?=
 =?utf-8?B?dlpQcExHd21SVkt1NGV2Y1J5MjNNOERwTFIrQzNJUnlGdTY0Szd2M0svV2VT?=
 =?utf-8?B?SDNSa3pmczNGUUlhUHhtSVQ5WUx2Q2o0OUs4QXU4eWVIbUJhdFlPSUd0eDdp?=
 =?utf-8?B?cUllallxT2ZmYzltcldUMGUvWThuZ1ZTSlF2aVdoNzVRSmJiQ1J2NCtFbTBp?=
 =?utf-8?B?L2JTK2R4aUdpSmd5eU8rUWRMSjU4emczSHYwZlI5N2M0UnBkVkgvUjVxb2pF?=
 =?utf-8?B?Q1daeWRML2RMV0gvNTArZXRtL0t2bmF2Z1pBZ3dCVW4yV1NXdkcrd3Z5WHhL?=
 =?utf-8?B?L0tBU0syNVlvYXZIZ29HMWZFM0tuUHZNcHU1eWloRCtscW5kSElsWCtvTjlI?=
 =?utf-8?B?cWhOZXYvbXFJejM0eHZnQTIrTU9kb0RkK00xTWN4RVBZaWExZml6UTFWZENJ?=
 =?utf-8?B?RUhJNmdTemwzbnVPTURjYzByNVNEN25MMlVFUG9ienV2WnRIZjRMN0VSVlpR?=
 =?utf-8?B?UWJxbEh2SGlRZE05WE1Ld3dwV25jUWt0cVIzcmRBY2VweTRsRk1kYldqZFB1?=
 =?utf-8?B?dGdMYUc0bmlDK05jUkUxZGxBVmFBSXMvaDlRZjNMWjkwcVJQZlJnR0QxNm9X?=
 =?utf-8?B?bHhURTFIYzJlUGlVQUIrc1E5VWRnYUxuSkNrSGJYRzdtTi94UUd4OC9NeFVy?=
 =?utf-8?B?L0VQdlFXVDh1Mkl6S1RkeFd6MzFYUnAvR3UrdVdBUDJPL0NCME9Ma3AyM2t4?=
 =?utf-8?B?azZxWDFrL0gxWmRrWDRQVHk0VGJRYlo5WGlqeHhGM3poSDloNHFPSmhrNXd5?=
 =?utf-8?B?endoWVpYZEQwOU53dmgvVWlQL2J1dkFSc3VlWklQVkd4QThxV092ZnIzVEtU?=
 =?utf-8?B?bGtXa01CTEo3ZEc3VDVwTyt0MzZjZm9aQUhEVTNRQXRYOHArSkRQVEF6dTJU?=
 =?utf-8?B?Wi81TkhKR0g2d2I4RmZWZEl1d1ZzYjc2U1FyQkk3M1BWbU5VcG5UTVBGZFRV?=
 =?utf-8?B?UC8xWWQwY0pJbStXT1FYQTRUUWc3M3lBTUk2OVlyelkySStUZ2JsOXRtbksw?=
 =?utf-8?B?UnNuTmR2SElHcUcrVVBXcGRuTC9KSUJRU1pJeTNmYVZPQkE0a0MyNjR4OGpr?=
 =?utf-8?B?dkRxTjZJMjlLMGladXFDL2JMOVJWcUkzZGU2TC9oQXVSU3ArbjNhcHFPWmFE?=
 =?utf-8?B?N1RoMkt6Z093R01qM3lWcURFb1dsQ1NBc0E5Qk4vRU1pc0QvK1VFUEVqZHVB?=
 =?utf-8?B?VXpjRzY1TERYVFI2cW1NVTBVUlA0VkxRRjlBVTNweTg3bUpQN3c4S0xJTy81?=
 =?utf-8?B?MnZSai8zelA1UXNoSDJwRXc2VzZ2czRIK1dNM0VLUjhUQ1BHTTJ5aENrYVdI?=
 =?utf-8?B?R21nQk9jN1pQcEpiOXFCZTA0ejh6M3BuSGQ5UnhvbmlvK1pGNGsrUkJCcm8x?=
 =?utf-8?B?ZkE1VjhHM2RDN04wSWtLbHdvZnByb0NlUjF4YytaQ3dKN2NGZTdZM09kRG5R?=
 =?utf-8?B?cTBZQ0ErNlVuZW1DeUtjSmpYQ3VyZkpPZXE0Qk90ZW4ya2ZNblZEaEttTHFn?=
 =?utf-8?B?aVFyc05ER3N1dUxmR3pERlc2aklhWTQrZlRSSjRobTJPUWJlaXk3THRHZHFI?=
 =?utf-8?B?MHZibzFjaENaRVNndnYxdHhHc3o1V09tZVB4T0wyM3gwTzJnWElLbG00d2RU?=
 =?utf-8?Q?d0QowmOsVC0A66XT1WSRZ5sbinZsHVItrlIOBImTnwFAo?=
X-MS-Exchange-AntiSpam-MessageData-1: yPFlgomRuaRi2w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98345ff9-4738-4983-be15-08deb4ec59e4
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:47:14.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajm4ARb8UVW6kH/A06qtXLUVp9NVeB6TVFlKNemGHw3Tpm3MQ/7UUVUvo2yxU7UicFOf8xEaR+yneWdU99h6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8961-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 63B9456F809
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>
> Device<Bound> uses the same underlying struct auxiliary_device as
> Device<Normal>; Bound is a zero-sized type-state marker that does not
> affect thread safety.
>
> This is needed for drivers to store &'bound auxiliary::Device<Bound> in
> their private data while remaining Send.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

