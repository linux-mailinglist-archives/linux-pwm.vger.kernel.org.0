Return-Path: <linux-pwm+bounces-9109-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G8JB6IvFGqUKgcAu9opvQ
	(envelope-from <linux-pwm+bounces-9109-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:16:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6F5C9D79
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C162430574AE
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 11:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B168537E31A;
	Mon, 25 May 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G4aSqvpx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012057.outbound.protection.outlook.com [40.107.200.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FC37DAAC;
	Mon, 25 May 2026 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779707419; cv=fail; b=IPPLH51z4mf+Jm2rgiPkw4IeQuLsqlIDo2TszjtEbw2IzcOMEqyVYtrbLl3M0JLNHAyd/cT5Uj4uhYbGk8qwjPelF8WRiAlwkSTnkhcBV5iZrbRHtl6fz+g78rCOJWhLO/e/euc5drnCMOOwGGaVD4sEKR5NrTQulVmcIYsLlj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779707419; c=relaxed/simple;
	bh=Rff2or8qxWk3Oe7AGGc2pcGmdxrsH6OgPe6fvsh2MIU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Z+SqemC9ElL4oZy5szWPbb2bXCIOg4OsmLALJemYjcSyViLwV2eAvVSFoyWLSDzuHj2AdaNPCy7xtkh4/RN6v99AAPHzWCELkaJSy79CpVf9+fbX1tPEkxakqeVtq0FHWBiXJO+yX1pB35UnSQRdeodX7PK1ENUYy0qF1VRQHus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G4aSqvpx; arc=fail smtp.client-ip=40.107.200.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDPg01FpEAqmEgvzUcAli7WHZ4fHaw5yey69SkeAC9i06IE0WUmvWyQYkbzBwaUnkYWJqwnl4Wd9fAkP855knqq69w4dJIpDDvP/DOf/EpQplISqmBzVLjiqDPcP07u8IT1UB6UaAkjl/sSyIHyviyywifQIvEOU7xreh/7QqvMIX+pjEXIqplcc3t2KbxP8Npfx7ScSQt+9qKG1VUTGyFkNnKcHwS8hLmAIKDck//D8/bpgxMUYTS7XKYHuar0lE65tr7JF7RKnBAwyEVlgQdb2grNX3N7kOs3IZutXdU5DmXl6qvIgFpNdniIHtpNrOTUydVM38G4vNMCUDNeStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rff2or8qxWk3Oe7AGGc2pcGmdxrsH6OgPe6fvsh2MIU=;
 b=muvbta5UteZtO6hBOUuYZ7WKBGvMUUamBKMqJVoJNTs5MGQkEKPK9qwCYe9uKve8S4eXf61bJ5CwLqcInnPX5q4c0/4E3zkivELzlAn7m7I1z+DvofmfJh9edZHXvva1ed75AUGz65hcSg+lq7RTfn2m5tWsGZ/uLZcPYH0KUqFxLBk+Vdkw/Rsh9GU51O4XxusVXGROx6jOVNOpVq9LH4WOcXW00eQuXp6NupZVJ6DvzQSEK2L7dvI6R0LRTVHT4DyKopwFgtq2NaFfENvEbX8hBmJNVnF3V6068IEmUcQduj/AYEzSa3yyB9imXjWjT3Dvo2+MEtm2Sl8xeppR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rff2or8qxWk3Oe7AGGc2pcGmdxrsH6OgPe6fvsh2MIU=;
 b=G4aSqvpxDGLWJQ1C3cU2dnWC9X80klTk7GWCQKzpkvA/aqvpdL1bSv/RMBUGQRA2nVh3BAu53XMY30nrxRfwj33KjjoAhisiLfrqZzsMEoKtreVW6G9ZIMfsOcnBiE+ioDcqVAR8NlYKLLy8oBorxTJaI04AVawVgmmApbNAppMGQMr4wFKNCOlPAxJuQ3ON6z+1HiqpQA28pNmfrE1ZJDraf3Hgrn1nMCquxQsajDnHMSIMLROsWDC8/six9r6OCgPZHFLjUeo5WVMgLx1vMTkHn8ks5C04NZQxN4HNdzZkxHrMyce8R/bYU+I8IpbvI9Dk1eaKtAIczTL/GTA+vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:10:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 11:10:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 20:10:09 +0900
Message-Id: <DIRPMGXM98DZ.3OQ68CH14J7SS@nvidia.com>
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v4 17/27] rust: pci: make Bar lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-18-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-18-dakr@kernel.org>
X-ClientProxiedBy: TY6P286CA0008.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d43c8f-a771-4cb8-6f87-08deba4e311c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|11063799006|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nWc8CVnaIKQFQIv/Gfcf1OKgvZzWhAAKy+LUipDUbgBZW8CK8dWwHFcS6IQe+TC78jZwBaLeM9ufKhatr3HGDnkx2eQXkg/yO/OE4gI0k/HQvdg1QJ72RtxVdUEiBknRhk3A1EhsVbTGPpo0ADVlPGoPmoiUtN7j7xpffKpsjRRMSJ3//uKeoQKtAJN7/fQG6EPfhB5d3+pDR6dSAblAbml0VZUhaLG8BI1D3EtsT0lmZAQ2a2qVt/XUGXbByoybx4qrsAsdVVe5RPTZKd3Ax6BjnKFG1/0RIL2pk3PkzQ4gYd2SmN72EX31C0fLMlbA3gqCeKasarwdym1FoQBCF9kQtu+vPbBrWsn0wsxGmX4f2WYoJyED+oNniVqvr3Rop1piLSf7M/vKYrB7viDQlzAgU/ujEj9tBPOXVh8DtCQP2MFfQ/0u2Hpw5YQkbL8K71M8Pcrdg4/xc25zQ3l5xFW5mQKkjaVMB5iG0uYnzT36IjNenrWcyu3LGVwn//o9uSi6hrdvuQTl5wDjgkbUE0GoCbJTlrmZDu5mrp6rNAU5WbAsQlb68S7I2/hb/JH4R25SfRWs4+5xqXqkDE5PQyq/VIqPjpP+DpfFZ+ua6nbuiDD8SMBZ6wwafwsJnbOaiJwgU3SHJ+TbIrPTt+B0c+/GEco+GHFL9tNESZz8G9hYhkY4vFw05HpKCkExPVBA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2N4alpjMSt6Tjh6Nm1lMmZHMHdKUUNmT0RiV3duZWw5N1pKYmo0bUl4RjBx?=
 =?utf-8?B?QURFMVFDRTRsbHBKRkNWeVRDdTEzV1hHV1JhamoxZjVnSEt5T2hhalVieE9K?=
 =?utf-8?B?MUttSWV3Mlh4cEJhMWhCSGpTTG15TDE5VUVxRFNXLzNTUGVIQmFpeXNpMTNn?=
 =?utf-8?B?T3I3aVNZRllkdHZEN2d2UzU5NGoxendvT2ZDdXFqVy9neDBVMzdqZFdmNlpt?=
 =?utf-8?B?VU9GNnB2VXhjamtIcXprb1BId0w3eGIzOGJSKzZ4M1pFbWEyUFJjenhCZFR0?=
 =?utf-8?B?dzUvSjFSOWZTZ1BQNm9JWTlaTGhLTENGd1Z2VDN3WDNCNTdCYUl1TGV5Ti92?=
 =?utf-8?B?YTZ6djZUaUlZYTFBTkFNTkk5Y3p3S1p0akFoN3NEVG9TUUlvZTdnV1RweVEy?=
 =?utf-8?B?cmRGbE9KekxuYmpPR2hqUkRnVWFuZG96OXNDbC9aRll5YmxsaXJza3RpRWtw?=
 =?utf-8?B?ZmVRN3pDc3hhb3J2RFB5c1NPTlN4OVdIbTNuVUozL21mU3VFdGlMbmJ6dXdT?=
 =?utf-8?B?YkNaNWI3YzZiQ0d1c3gwMnB2TmQyM25KZ05GWjZ0aVVLQkFJaVczcERTZUNJ?=
 =?utf-8?B?UFR6aHNPdnloSDljRW5LaXJ5eXdiK2pUMEVCbXdRMkp2cG4xTEtSTTdPVENp?=
 =?utf-8?B?L1Y1Qzh5dFNERTlnTW5zckcwL0tZNVA5YUpVdjZDcXl6YzE3WDh6ZUw5ZzVU?=
 =?utf-8?B?UHJzUUlnMVBGK0pCOFhZdmJkZWJiQm5CUGpMaXZqNnFtNGRlNGV4dUdVYSs3?=
 =?utf-8?B?N3FEM2ZNYlJTZ1gwME13Tm1NT3hodE1aNThSSTkweFg5Sm1GSFVmKzBWNzk0?=
 =?utf-8?B?S0VPQ2pmL3ZFUjg3cTFycloyVFBEd2I2Q2FadDY1dVNjQWFocE9mNEZrNTNk?=
 =?utf-8?B?NHFzeEZneUVHU1ZGWVJsdnFiT0xid3dycHVCMERXSmRmOGZFNy9pbUxPVnlE?=
 =?utf-8?B?SU1NNTIwM0RteEszSU9iOXluTHhKZW5nRkxxZ3pXcUhMN2xwcGMvdEtNanBE?=
 =?utf-8?B?eDNkQmxEdHhlc0ZGNHlrZ3JQbWtpRGxpaGlmd2hhdG5OU3grMGlGb2lIQldl?=
 =?utf-8?B?YjhOeVdLejBWWWFiU3JDcGxuaEx0Q2F2UXlkL3FuVWpQY2NoQkpvT2JiNHdV?=
 =?utf-8?B?VUMrUmRrNDdwVWhSbDBxdTU3anQyKzh2b1d4dUJxZ3hmUit5YmJTc2tTWXNH?=
 =?utf-8?B?VUxucFVBZ09TUmZzVUc3azNUcmx4bXVvTERaOElwQzMySDFYUVA5YXJrbHVm?=
 =?utf-8?B?WFZzRWlER0hCaVZZM0Z3OGovU0lYOFlXTkRiUVRzNVVmZUtORndCY3BSUjJy?=
 =?utf-8?B?NFZFdkFyZ0dVUGJLUVo4MXh0N29CSEsyMkduVXh1NFFjSFNSRVFuTnd6SkhH?=
 =?utf-8?B?Y0hGZXVmK1AwS0JrYXI5alBMMThqcFhmem1SbFBlNEsvbEN3MjFyL05EZllh?=
 =?utf-8?B?TWtSalFSTVJXQnJGQ25vdDN5NzF0WXZybXFaRkltaDBQNEtVd0p6a2twZnp1?=
 =?utf-8?B?NFpxNGFwTEg5VUFUNGJTWEZ6Q2g0NXFjbWZqYVhJc0Juelh3dkQvN1d0ZFQ4?=
 =?utf-8?B?MzNZNWlPUGltMlArZDN6RGNKOGRXd0JIcVNqSzBjNlpSb3Z6dFhkRVdpN0ov?=
 =?utf-8?B?SVN6Wkd6d0I5b0UybWZ4eFp5cDE5V3VMdDJOVkRMNGR4WWlZUXVZb2NtdnNk?=
 =?utf-8?B?WTRRdDhsem5SN0phdzdMSDNqM09CTnQzUC9OZWU2VUljNkJHRGpUL0lRd0Vs?=
 =?utf-8?B?REV3Uk5sQXZ0ZndIV0luRzJDQTdiYVd5dnRZWHRkMUsrQ3RBOTZQNG9CWVlx?=
 =?utf-8?B?T1FVb0Z2ZzRjZ1BUUENxTU43TUVEMHRHS1I4RUJ5NDk5OGVjOHJhcUJIMnVP?=
 =?utf-8?B?dWNqWmh0bTQ3ZHk5eHFtNUVhVmEzSDdXT2U2SGlweWY2Q0ZLK1pQNkVITk9N?=
 =?utf-8?B?c2xOQ1B2S2hiRGlFYThFRmVTME0vYjRWQ0lrUlUxUVRCVkZLR2hoYXFuWHNF?=
 =?utf-8?B?MFpBU3NtVjhpL0ZYNmRGT2oyeGFlVC9rTEM3d2FTdnZOMGpDSDlpSHA1YTg5?=
 =?utf-8?B?bnAvc2lQdDdUczIxOXFscm9kVDR4NHh2dWRDRXMySXpBUTZlbERsNjFIRFRD?=
 =?utf-8?B?S1JqRS94MmxoZUd3YmdBQ05EWnhIb0tmWjJZbmw5bmxkeUtNakhzY2FKczAv?=
 =?utf-8?B?d0U4T05URXVqZ2hiQTBHSWpqdXJUS2Y0YlFyeVNNRkU0VVZTbEdBRjV5WS92?=
 =?utf-8?B?YkRHMkkrYTFqUXpNc3BNd1FaZ202dVZSaHE0YWhzVDFYT2NsY0hnZTNDNklE?=
 =?utf-8?B?ajJycEVrUEd5ZWpwU0pmT3B5aUlWSUpIT1gvM284UklzZXdpbEhsYXF4a2t2?=
 =?utf-8?Q?NsMpHbfEORxrhghAM3d1rXJZHGxB5BZfd3XEDUuZeya6M?=
X-MS-Exchange-AntiSpam-MessageData-1: Kj7uLqH3Gb5GDg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d43c8f-a771-4cb8-6f87-08deba4e311c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:10:12.8815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAV5JCDhJa2OQtVmWUIpEf2dTpvx+gZy9UFa0p8gnlW1Ymzao4jm3NGsP6sElJmONkSpZRo0Ra8Djrmn07kxjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9109-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 90C6F5C9D79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Convert pci::Bar<SIZE> to pci::Bar<'a, SIZE>, storing &'a Device<Bound>
> to tie the BAR mapping lifetime to the device.
>
> iomap_region_sized() now returns Result<Bar<'a, SIZE>> directly instead
> of impl PinInit<Devres<Bar<SIZE>>, Error>.

A small sentence explaining why that change happens here could be
helpful.

>
> Add Bar::into_devres() to consume the bar and register it as a
> device-managed resource, returning Devres<Bar<'static, SIZE>>. The
> lifetime is erased to 'static because Devres guarantees the bar does not
> actually outlive the device -- access is revoked on unbind.
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

