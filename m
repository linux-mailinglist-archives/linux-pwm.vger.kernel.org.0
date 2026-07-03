Return-Path: <linux-pwm+bounces-9512-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2GnwEzgtR2r1TwAAu9opvQ
	(envelope-from <linux-pwm+bounces-9512-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 05:32:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 978246FE36B
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 05:32:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="eZ7Skjd/";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9512-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9512-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DFA4300F9F1
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D547830594E;
	Fri,  3 Jul 2026 03:30:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0236830648A;
	Fri,  3 Jul 2026 03:30:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049427; cv=fail; b=X8mIVCPhtnr89J7L8dXnGv7nHXPlXGny2sLJZDZzwDzb3QMnEsO4S1Uw3O0YU1bQwrnW1M78alMxQuuJgfjKuL7/hHqykCAC/mgpVhCEhzay9QiyYPJyGR9nLwCcgP/Sdta5N1HVSSiryiIIconH2f8l4HNQ+59IPKAtrHxsarA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049427; c=relaxed/simple;
	bh=ssTZKeKhpQU73D9kl8UkBS7dPegsSjfKPMoqQr85hA0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=HWW/t7K6xzom0en9MRBn0E5iUZKz+acQah261fcxgnn/lPwnQFcP+7YZ7abm8PlDn/jgHHrCe5vz9G41SB7Rc/lS4nIF95HWfIHSqG0Dk60igQt04rbZnJ8V82OyXJtljgzyJ+kmWdF59fcnjl2pplSy2MCQ32rnQUifyqmwJ5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eZ7Skjd/; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c468aAByEot6gmrb5D9upBZJ7OWKPO6QfSuKs4+H4OIaExpSUFonbFUP4P6pvj0gB2HEcC4xDPDdybseeLvfRAVy0IbqH2QvttYGQmbv4kb+oncMMAdWLwCunNrJZzH5fSUsecvs1A9e0rm6JyqluI9ZCdBfO0RvaHt8nti5Dq1wGVNHdr37xaS4Yv/r7dN/KH0B53iWqL8eCgC0A/1GWfq+YWgUfHcYvvhA2roMw2xBZW1T2ZJo+DrixRAisDZeFwa19IkyLm0g0LkSAxc0DqmAn4h1o1oR4AoXPMaAX3THlQfb62xaI3c4rn/JrwvXzrgEDQfc+QFnalgl0lpfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssTZKeKhpQU73D9kl8UkBS7dPegsSjfKPMoqQr85hA0=;
 b=xizP/vIZdRgy9AfUKmyIn9D0UppI33AbSMUWb54T0J+yP17sEGfzNDP+8Mpp42tgbo6EVjR4K1Xu/TaaqRUcUV4gtuxG65fATDzUuK45dQcATMDf6RTlNul86ZNNFZOAxuOASTOChcC9P3UYyQ8gYZUxsKDk2o752mAX3LsJ3XqIBmPopwxVqCDU/kgm+gPQ13xHHRZ5/MKxkw2v6FmdROct3twY6DAwYFeQGuCCdJIrH5lUXXqob8QX4v16rkLW8/XkpOetd678W3ZFz4BzjIsiDnIWAkmf9FWRMvaFglwvQR9K9ULUWGnge8S2dCH0eSnEsqcKNSGgNyKY4buvUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssTZKeKhpQU73D9kl8UkBS7dPegsSjfKPMoqQr85hA0=;
 b=eZ7Skjd/bSLvzHLHbm44Gekmth+OzkYiSO4WcowQgb5IWzjfPGgY0nnSrfDFjF3UEiyqO8XJaXr5fpamoX2cpxfVa7LJWNHi7aHRv7VXe1lsZXQ5y98dwoMv0zmem0+D46xB2r04k9oQAOZbtf/t7C1j6qXd0rcngZf2L8dKqQAfKgBNRAAsJ18s2H0GxpN7PFj5xjfP67J2peZWqdXFqn6jh41Z/638Ilsu91ozHo4gUVPQ0ljXlbGRGnZr8TmiD7X51gyZ00gKBVDE41DdzToSvwEdGea5DtcaZoYw1gPaKTYAZtY7Q94XhY/BHKqZ/F/3ODfQA9oVoqeB8PzIlg==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 03:30:13 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 03:30:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 12:30:09 +0900
Message-Id: <DJOM9IIMKV65.1BNIGAF989PG8@nvidia.com>
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
Subject: Re: [PATCH v5 07/20] rust: io: implement `Mmio` as view type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-7-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-7-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TYCP286CA0339.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: b9457f3a-3e71-4a74-08e3-08ded8b3644b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ggjLHETRbnNMqj99KFGs2bALoGdGQxxrqRs7q7bp6IsXhGi9w7jrGgAfZwW1WoJaBu1p3Qpb7Or6hkqf1ZVFDTf7NkkqVhdpIq2WE43rlUwaVf0pwgjTr0YlvANrdWhYHoND9CpUSeSJDHgcPE9flhmMk2y6dxgvFufJ7/6WPgvmn/0XjtpxJhiLzY3OYZ66mmJneNXdCQHwXsV+wx2apwZUKVvnsmVRuvdSpRO0JTOT/4sx+Mh/MkE4fOPGNV/MX9YwCOst+xiGGAY4HyZebB7xumktby1YXQAThvrvxn3y0KKXB9M8YvvhW020XF4Wh9jiaXp1/nKEpBogma3dNCbPvzVdiVYczimZRXFq/zJnsP94sTZZ/Vlopz0jSxx8ipwoU5rwWp7ohp45GVlSxix/Hfuen1vdnJido4+qZ45ggTlYOM6YIcZtWrHJ6CWJifPiurPSqojXQqU5coX+5oPvTsr31ZK/5NeqAwBigK4Ue2GPXMIdSMRD6su1fHKdceJjWVZd8ntI5Xtxi1fMo3H046L+4M1V/4o06c4ZMKcIUCAdXJwQg8DxqmgYRdS98Jy0gfu6L5fCUPE6E56PSI7qqRE+hWXyg9L3O80kbX6Mk7SdV4+D2fLTH3z4JrJm6chzfOdDAUUrORWaPNy0ahg+6V9yPldrBWphOOH5Xwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJucHhla1dUN2JPdVFiMmJyakZEOHF4amduYmFtOTB6TFpidVhVUWxoUURU?=
 =?utf-8?B?dWJveXp0WGNjTkFYYUhrUVpQOXhsaTlaUmJrblhXdHV2bkVCOFdJS0lQbU1G?=
 =?utf-8?B?aFZDNE1YQlM1Z2Y2VlI3OE1KWFhVSVpOSW9XMHRBL1FuUjY1dDNaQ2xidFFH?=
 =?utf-8?B?R251Z290NURWUjBpcDBZL2VMM3h4cE9YNmRENGtFTTJZZFVGdmVqWlRvSnhZ?=
 =?utf-8?B?WmduSTBlVUJLVWpkUkhvdS9JTTFxdU54NlRScmhMdCtyOFpiZ3l5YzVkMmdP?=
 =?utf-8?B?dU9XU0pyZzM2WnpQVlZmT1RpVmFDTk5zN3FUck9uWllqQ0JsZm1CWVBJdzhH?=
 =?utf-8?B?UmZEZU1UbG5xL05sT2F4cE1pdUdwcDdCVnU4VW5YTFcxVGFKSENCZ2FVRXJI?=
 =?utf-8?B?T2cxVVpJcTRIZWNOKzhHZ2R6bmUrcHlYek11cHdORnQ4L1Z3RTlLelQxWk1Y?=
 =?utf-8?B?bDhvdEw4UkxtVkRPVmp6RHcxRjhGWkM3RC94ZzY0REVwQW0rTFNodmZUcnZ0?=
 =?utf-8?B?bUJKV2xkam9FTHpCMktQVld2ZXJXdlNlaWRweEtDVWtaVnBGYW5GQWtOSVFu?=
 =?utf-8?B?a0lOa0szTTdqbU1XMng2N3FjUjA2YjFGMXBmaXdaN2xxMm5BSHZQS0ZJL0gx?=
 =?utf-8?B?R3NMOXBSSWFYN0luRU03bkpoZEE2N2hFazE0NGRpMEJ5MmhpTFMwbzhLWk1Q?=
 =?utf-8?B?MlkyRk5VNHI4MFhqUDNmU3hvMFIyS1ptL1pYOTYwZkQrZlRYbk9XcmpZOEhP?=
 =?utf-8?B?R0FJcm1pblQzVlhMU1lpTmh2dEdzbHlSK0FoK0FvMVpERWNzOHBUemZ1Skxo?=
 =?utf-8?B?TCtkRk9XT0ZQUmI3NXdodDRUV2NmbFdGUnEyNTlVUVdlbWpndE42RXpOeCtV?=
 =?utf-8?B?TUJoVE5zWXJVOEluNjFIaVJKNWFQd3VHeExNVVo0ZnpHTkRmUWVKZmZlWk9i?=
 =?utf-8?B?UnR1UE13ZlFKTWtPMXJwRzZUWXc5ZEo2NXVIMExLVzdDd0syQk1wcjM2L21H?=
 =?utf-8?B?WHlxd2tIZy9wSU9OZDVhWlFjZEhhMVRjclpCUHVKLzJObm1tcENaSHBqWGxG?=
 =?utf-8?B?YmxUNlNNQ3hxa3VXZnpDSHYzM050SzN5TTlCVHpvNXp4K293QzlSZFB3NmtN?=
 =?utf-8?B?OFVBMnBnSkRMVG9yZXZnRUMxKysvb21sLzJseVhEUEF0MVFvWFJQK3BjR3R4?=
 =?utf-8?B?dHErNE1MZTQ1cTl6dyt0NW13NGZRSml1YVRPSGo1ZWw3L0pab1RHdS8wZ3BN?=
 =?utf-8?B?NFJhb1FxVkF4cC9hUFZTcDY2SG1uUHJWeGR1Z1BkZFRqZnQ4Z2N1WTI3eVJD?=
 =?utf-8?B?ZlNOYTkrMnB6SzFhc2p2RG5reXQ3QkVGayt3M3p4L2g2bk03Z0QwcGFscFdC?=
 =?utf-8?B?bWFhWW9wMW53WmFjcFl5aVhoNEJRYjRQZ3NMa3p5UzFDcW9PRlVWb3lvRFg2?=
 =?utf-8?B?WXpLZ3g2bklyaHJEeXdtMHVYUHFZYXZ5ZUtuYmpvRTZWSkZydHNjbUtFMy9t?=
 =?utf-8?B?Qk81RjcvVS92UDVTZjZWQVo1eXhXQ2c4WjRBTllNSk5samVDUnF2YUhBLzFp?=
 =?utf-8?B?MVBGMnpyRTF2SlBCbFRTeEp1M3hqNFJHOUZrQjkrNFpGaFAyU2JlditGVnV6?=
 =?utf-8?B?MDZsNVlNTHVoVEZuUVBLUEovQzBlaFFFVzFUQTVKRFFYakQ3aFlpcFl1MW1u?=
 =?utf-8?B?YlRHdXB2akl2dTdSNks1Y1QrK1pHeERib2E3R2VDTzVaSDNTSU05Z25kOTlD?=
 =?utf-8?B?TnRHbGRrSDByOEhESWhPYTZ0d3c1ZGh0TVNsNEhYRlB0NWZObGV5dHdIVnVy?=
 =?utf-8?B?WmYreDM4Sk1VaFRtVUZBanc0UDRJS3V0SWdYZFErTEJNZklZZGdRbXgvd1lR?=
 =?utf-8?B?MUNqWFI5NlhtY1MreTVaMVlTOHhkNEdST2JHY2lEbHM2WTF6MWZ0amwwZkpZ?=
 =?utf-8?B?ekMvbmJUMkFpS1kzcDM3WjlHU0tUR1ZOQUFIbVVYVHJFSkY5b1l2Tm4rOGth?=
 =?utf-8?B?UmpLbG1zaGFiaVlSNDRmOFh5aVorN2JVb01abXU5dnREWEczam0wYVVPMlBE?=
 =?utf-8?B?cVlieFpCYnd4YVE2aVVsWGpIdkVVZjQvZGZEYkdZNzN6RFhSdFI5NzF2dmky?=
 =?utf-8?B?SGRqdTNaYW5XQnlIOTFkRDRjVVU5U3RyZHV0eEc1cHNKSU55Z09WdVpyQlN3?=
 =?utf-8?B?WTFaMUo3VVUzaEZaaTZ2bGZHQlZzN3R5ZGF1ZktzaGRpWXhqME5oL3RJRWxS?=
 =?utf-8?B?R2tGU1JPOXQ5a2ZvQlVvbVJSSGFwMmdMRTNmTnprY2YwaGxpWDRyN3JqVjly?=
 =?utf-8?B?bUJJUkJFTkFyaGNVQ1BMYnRjMzBHYzNTaHZVT2h1SFNjZ0cvbTlKWE9OcFIr?=
 =?utf-8?Q?adQNkHBNUx2IQZSrbTY2mwaHzKYcYV/MKNwqIK5q/7H/0?=
X-MS-Exchange-AntiSpam-MessageData-1: ZGUQ89pdXK9lzA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9457f3a-3e71-4a74-08e3-08ded8b3644b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 03:30:12.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tiB+6UQ2KvyN5xRpHUJ50Hxa79F4lDX/WxRuYjZJKQeHupNPxtE0yIRpb1YnIDOKaGxiEPW2Te9of4n780bJWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9512-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 978246FE36B

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> Implement `Mmio` as view type and convert `RelaxedMmio` to view type as
> well. I/O implementations of `MmioOwned` are changed to delegate to the
> `Mmio` view type.
>
> All existing users of `MmioOwned` in the documentation which do not
> actually reflect the owning semantics is converted.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

