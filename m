Return-Path: <linux-pwm+bounces-9517-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qNwQIFxZR2pbWgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9517-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 08:40:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10A36FF232
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 08:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UgxMte0y;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9517-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9517-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC613305355B
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 06:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A116384235;
	Fri,  3 Jul 2026 06:39:20 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012069.outbound.protection.outlook.com [40.93.195.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856F2383991;
	Fri,  3 Jul 2026 06:39:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060760; cv=fail; b=FjwLXldM691+7MzdSLNA4yaVRZSeAOt65nX1IFM7NrrCKExrobYthkuEGXffybp75w71T6oaM7jIMSWZ3LpIuYyQKGPha+l2rcrblM5KbwbmEwoKW4U+JIkxdRJHiyujC1HBx8JOST+8YMYLL9OylEg56mR6S3B+NbcR2HWFjyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060760; c=relaxed/simple;
	bh=3gma7G7+GaF9cUf6bVeuM7JT9v0h9hLD3852ncQlEK8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=AlVOcxkZPOMU5glS76YWoIAgFwdyflRvzXsNxIdklRkUjwKObj3xrkW2+1SE1zL22ZBfLYjZXlha3uXLn5HeEdc9kLPYTNxS6YIPKroMe9Z/Tyi/Rzruo7lTcxEHlwce/aH8PALVL2jlrGTcPJIVjsB/Y2jdBMs3QZj0YlWEFzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UgxMte0y; arc=fail smtp.client-ip=40.93.195.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYyyxkRC1EQoHVfwiCLOGN09kOy9Q/+00Pnctvaro4tiamiI5BF9GALBmjfzxvO+gJ4+2RLLqA9pHfHqM0/4ohsD+5oPHC+K8oguxhfMUB5bMA9zf98/0s8zitB/IovNAHV1XUwZ+xXjXjLSckNG9eMIFxR5k7SaICf5ZcBya/AWWYxTmsFVEq4jXBIBEn/R9j4FKL7/3hF48c2R6BbjQ6xr+9Fmm4Vpp4Sc38LlYaC3G8fYVyeJg47egkb1ND35xACaGVptd/dLY43IuyXAH/JnCnVUmwAfXuBvjhEZtcH6oulmssoyWQBw9NUF8TYc9m1FajOddZNCsyJThVjSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OjOUjATYzSrZliGqpZ6BsaH5CrDw72EFgXxjBfguKA=;
 b=nDvXZcrcIY8FMpyE20hhmYqYT+D/PdDbBe5THp3ZHebDbjpYB8zqbvbs/UK11KOE1BVzmwtnL+lOpz/rO6ZR/GF7SfM7hX00ILwSmx0cDvc80naZwAZ1p2MEKukvrVgfr+ym36xeEa70CuC816o/SzGWYdtwKBsTRV1jVP3R/cO1a0MlT7v7FoUsOzQ8Rr5ywgkmuT9/VkR3HSdlvbudmMtyignRAN7gYYLdUkKB+tMGF8+KJyyPJGssMYrlHWT2ZVrvpz9ceX8we4IWdOksi18BkmzsqzqZuNu6txzcP9Lo4Q9iU9Zc2nvoahhiqhtMDw5QUc6Jcnj2qcYjfCoI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OjOUjATYzSrZliGqpZ6BsaH5CrDw72EFgXxjBfguKA=;
 b=UgxMte0yXbSgfwkO2P+Vlrw7js4+lkwjk2L0z1hDOV5p9+nzebsJuAHSqYLYC7rKUZM0Bo5NxnRe4C3nxYvkq5cvYiupZS7vImjvzeF+CdbdCG2o0CHalbPr5DeYwpGyBS9sl341A3kkO+VsPXbRPXTmZpvLRfOxmUh3bwBG3rhKOsHO15mQcvLmuKfMrMs24xIqXLqdJBFpSlmJYOp0ibko15SGHHJyxDAY75dOC8XKJt1oXKO3+0h+u3Qd62dOsz8fb640/x9/kW+oGO+DnayxdSVQUe+QBd3zrG9ecXn0v9vD5P4q+DH/Ga5nh/fN8ccKEjYws2gmzbCV3il0iA==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:39:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:39:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 15:39:07 +0900
Message-Id: <DJOQA74PU76T.21U7Q7N1J4XNK@nvidia.com>
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
Subject: Re: [PATCH v5 13/20] rust: io: add projection macro and methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-13-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-13-d0961471ae50@garyguo.net>
X-ClientProxiedBy: OSTPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:604:218::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: b872bf6f-9980-4a5e-7015-08ded8cdca82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10070799003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info:
	exbgZ5v+QSPZnx1GL33j35dNf4ScQ66gxbixSbXkJvgTCe8114R5RhzbVhqXLKqhOgO2Rwn0NuC0q94cIVMFlPYzB2ZiGjKh+aJBrFPiczhOVLy4qXflsynVJerCyAlBw0JJdV6P5O4Fkhlj/O2nO6Q7TgJLbIo7RL9hvysjqkbml5a6vi42w6tALjb4sUAdUGpUJZgh4qo64TJsATr4Ne3Xqu8aWqXRSrX+gk1H4N68DyBuvClRvUeC0hfuupUyfdE8USG9lDX1TK3CVjhnTBcseSTPYFeBa6+fqr/6z0EpDamVStps8VTrrMs8JKykbTxlQoAd9tlfeQcc7HqdS3lKCjr0UbSWZ1e34rmHI6K4GjEatYTPDynX2kB6PiVDHqawF2hzY3fnIUioxFmJDOaSpOEclCIG1KKkG+cW02MlFfmTCvONbjfP4qOSf5xu5mJ3uHL+YT0fpXqWGJzVMXa1CgScSF3BJkR/XFwh0algDbw9/28lXHhlFcijKo+Hzxd9CmYrIk2FgaBNzsq1q4hk3tTynTACvaCUczEKF1s1H8zWBJ0rbHXpnJ1NftmGyVw6nkK40BhKU7VWPEmDTp378u9GnRLlzLTZ69GIjHmpLLfhecgAD5MrRF1J/CdhWRMq8KpxQzsrZ+Jae8OC4ltBpFu5RCelOVHwUZy1URw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10070799003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk93SkYrcGg3YTl1STdiM3FvTldPOXczNzNKR3RzQXJ0eTVoQ3FLeGJETUlU?=
 =?utf-8?B?RVZPNDg3MnJUdnA0cnVQYllhRzg1OVk4cjVCREJTUmtzYmc0U1lGZ1pwZGQ1?=
 =?utf-8?B?NUZiNnhhdjVNVXc1OWtTamsySXVZeHA2YlVaMnRxN2xiOU9CNDUwRVVzYUdV?=
 =?utf-8?B?QmY3MU1tazIzSmFtdGNaTWFJZVYramxqRHF2Rk9wRTRSaFR2dTV6Vm1nSmIy?=
 =?utf-8?B?THQrcWZmTnRaY01TbW8rdHJORHZrY3pqSWt1c0pHRFJDdS9TMytiREJ2eDd4?=
 =?utf-8?B?TThsTkxKRUVpa2tQeXBKSkJzZTVMaktMOEdwMm1jY0xabnpLaHhVZS94TC9L?=
 =?utf-8?B?RWFGalJDa3BWeXY4elZQY2hvVGU1cVZUREgvWlRkRDZlM1F6WExGNkVSTThC?=
 =?utf-8?B?SjFFTGdSM25SODBaTFZaNDNwZ3ZRcm53VSthUDNOclhsWkF1Uk12MnVabHQ0?=
 =?utf-8?B?eWNOVFhsMjl4bEZmWmxlRWFiWXpId2VrTzJ1NkRmVFFtcytLcnFTbDlLc24w?=
 =?utf-8?B?SkwwL3B5Uk9hZnRIMTRSYXkyd1JtSWlmVXhwcGxJQTBpNW9ERGpJQStHL3o4?=
 =?utf-8?B?Zmxud2FydDA0NHdTUTVSMDBJazAva3VMN2NoTnVhUytWcUVReW00aERrMlB1?=
 =?utf-8?B?NUptMjMyUC8vQ2lwSlBKSjVROFNSd2VDUldnRnhmNWQ5am91UkNJUTRCK2sx?=
 =?utf-8?B?RHV2a1lxMW1MaHhSWUthbjM4WktJTEM2S2pZYVJpMCtBUE1lamhqTjQwT2JE?=
 =?utf-8?B?M0hPdEFjSHl3WjFKMDlmS2RPR2trSnJwQ2NEQ3BtSi9OSkRlaml2L0ltQWtQ?=
 =?utf-8?B?VFZ0RjNCUW0zZnh4NmJjMXRLMmc1bFhQZUpuZW56dUxZQkVLU01SVFdUR2pQ?=
 =?utf-8?B?ZmZ4a3Z5elJOK3VNeTdud0JXcnB5WmlKT3JpcGRCS1hrcEY0M2dqU1dnQUVR?=
 =?utf-8?B?blRiT3owdU5qNVE2ZTdJZGNjYjJFTVZ0ckdUaVZqaGdIV09ESGhLSGtqaDM3?=
 =?utf-8?B?eU1Pck1mVmFwTzd0UEFmenF0ZjdDQ01lYXlEY2NPVDhYU3p2NFRJMTdxdDYr?=
 =?utf-8?B?RzdxQzZ0dGNaM2pIZzc2MnJpdjQwQWRyUjZKenN3QUhZUGlibU1TVlc3czZP?=
 =?utf-8?B?cVFjVjNia1B2amdJU3pOZG8wbitWZ0ZsVFdqcktLcEdyejZRMnVJR0J1UWJr?=
 =?utf-8?B?TnZEVDhueWZnRUIzbDlGazlMaFNQOVhrNUEzM1JlWDdxd3BrV3ZqWnZySWU3?=
 =?utf-8?B?WlBUSys4TmtGSTlaaDYwUXVZZzlEVjFZMkF5N2pqSnFQNmNNVXFGUVFxSmhL?=
 =?utf-8?B?WTlyOXZNLzNNZUpkNUg2T1Y4THlYVUcyTmMvQ0FYVXhWYlViZmpmRXhhQjlX?=
 =?utf-8?B?Z1hIWFpvMUc4NTVhVlRROGs5ekdHWWh0bG0xTC9mejI4SkhMcHQ0cmZxVjJa?=
 =?utf-8?B?UUxFbmlFVEpMeVBma3p3Zzd3cmJnUzNNa01wUXdrU0c3WnR0NThoS0xTQ3Nq?=
 =?utf-8?B?emtKazF2L2tlWG1tRXNwZUl2ZG5tK0VXRGlCVFFwaSs5elVVVWpMUXFVc0Fu?=
 =?utf-8?B?bFc1bHZUN25mUjlNdHd6UXlRTkJmV3RGT2YrQjRzV3dadTBodzBZNHVKOHJ6?=
 =?utf-8?B?Q05pYjVhQWR2a0FLZy9SUnViQ0VYb3VkNlR1alVaQjgxRTF2QzVYKzFVQWdt?=
 =?utf-8?B?Y2xVeTJNZU9FbGNwUlFJRWxhcFYwdjlNUmtiTXllY0pUUVd2OE8rTU1DNXdr?=
 =?utf-8?B?MHRnTjhCRXJZblNBdm1MVVBOY0FqM0xQc0ZOSXRLQVh5NXdGMXhnbFZMSDl6?=
 =?utf-8?B?a2tHT0xsUEphOEgrL25sVS9jc3FZSE1Xb3lJZ0xwMll6ODIreW10bVlVS2NV?=
 =?utf-8?B?N3hkZXoybzFXcks3VGVmMk9hQzRUcDhJZXh4SytrMHhIQUF1ZUh6Vk50UmN4?=
 =?utf-8?B?a0IyR3YzNncwdGdZNEZtWjVJQndKUlFtMTB4bE5lZFhkUEQrdEx3dGdhTzdn?=
 =?utf-8?B?aUtJK1RTSE42S0RJb0NDOEFDUE9VZnNXdnRpZUZ1VVUwRTYzMDFqNjYxeEdr?=
 =?utf-8?B?SG9sUHhrajFkdHMzblpzZFd6dGRDaTM3RmlldExRaVFBeUsxSzRQMk1wQVdi?=
 =?utf-8?B?ZTF5RFNwWDdIZldRcXRseEg2cXJnSEdqVEhPVzR4Q01xYjNLbGRiRjYxWHc4?=
 =?utf-8?B?YkZ5dktLQlZpMjlXbW9IRkpFazNiZFFJKzI5TlM1QmFveUEzVmp2SXhoZ3ZG?=
 =?utf-8?B?MlJ6VzB3aHFQOGJIb1NTTUtuY0RoRHIyNlE5Mml0MlordkxsYmZBajNVczd1?=
 =?utf-8?B?OGhXd3BQYkkrSGxiUnV6eGxYYTJGclFwM1VSRDg3K3UvcHg0WFhGMGNIUHFi?=
 =?utf-8?Q?2vc0h1M2aMiFJhuDWNEk7uAhsHV0Cu7WgjzEgskF2o4M1?=
X-MS-Exchange-AntiSpam-MessageData-1: 8IFbjJUt/gzLKg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b872bf6f-9980-4a5e-7015-08ded8cdca82
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:39:11.5349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEioprEn9Q8fS6N6oxVisK2+125leK4rdl4cbavG6FgHXzekZu1VG0R1NVZM+In7UuYlfirLZvrNySz4fBrCtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9517-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,garyguo.net:email,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E10A36FF232

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> Add an `io_project!()` macro allows projection from `Io` to a subview of

nit: "to allow projection"?

> it, using the pointer projection mechanism to perform compile-time checks=
.
>
> For cases where type-casting is required, the `try_cast()` function may b=
e
> used where the size and alignment checks are performed at runtime.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 124 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 124 insertions(+)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 0746b0d209ef..96962498af77 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -49,6 +49,7 @@
>  /// - Size of the region is at least as large as the `SIZE` generic para=
meter.
>  /// - Size of the region is multiple of 4.
>  #[repr(C, align(4))]
> +#[derive(FromBytes)]
>  pub struct Region<const SIZE: usize =3D 0> {
>      inner: [u8],
>  }
> @@ -90,6 +91,16 @@ fn size(p: *const Self) -> usize {
>      }
>  }
> =20
> +// SAFETY: Values read from I/O are always treated as initialized.
> +//
> +// This cannot be derived as `derive(IntoBytes)` does not know that this=
 type is padding free (given
> +// `repr(align(4))`).

In that case the `SAFETY` comment should probably also justify that
there is no padding by citing the invariant of `Region` (which will also
allow us to remove the second paragraph).

> +unsafe impl<const SIZE: usize> IntoBytes for Region<SIZE> {
> +    #[inline]
> +    #[allow(unused)] // Rust 1.87+ stops requiring this and will emit un=
used warnings.
> +    fn only_derive_is_allowed_to_implement_this_trait() {}
> +}
> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
> @@ -339,6 +350,49 @@ fn size(self) -> usize {
>          KnownSize::size(Self::Backend::as_ptr(self.as_view()))
>      }
> =20
> +    /// Try to convert into a different typed I/O view.
> +    ///
> +    /// The target type must be of same or smaller size to current type,=
 and the current view must
> +    /// be properly aligned for the target type.

Maybe "Returns `EINVAL` if the target type..." to make it clear this is
runtime-checked and not a static requirement.

> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// use kernel::io::{
> +    ///     io_project,
> +    ///     Mmio,
> +    ///     Io,
> +    ///     Region,
> +    /// };
> +    /// #[derive(FromBytes, IntoBytes)]
> +    /// struct MyStruct { field: u32, }

Do we want to make this `#[repr(C)]` to give the right example to
driver authors looking for inspiration here?

> +    ///
> +    /// # fn test(mmio: &Mmio<'_, Region>) -> Result {
> +    /// // let mmio: Mmio<'_, Region>;
> +    /// let whole: Mmio<'_, MyStruct> =3D mmio.try_cast()?;
> +    /// # Ok::<(), Error>(()) }
> +    /// ```
> +    #[inline]
> +    fn try_cast<U>(self) -> Result<<Self::Backend as IoBackend>::View<'a=
, U>>
> +    where
> +        Self::Target: FromBytes + IntoBytes,
> +        U: FromBytes + IntoBytes,
> +    {
> +        let view =3D self.as_view();
> +        let ptr =3D Self::Backend::as_ptr(view);
> +
> +        if size_of::<U>() > KnownSize::size(ptr) {
> +            return Err(EINVAL);
> +        }
> +
> +        if ptr.addr() % align_of::<U>() !=3D 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: We have checked bounds and alignment, so this is a va=
lid projection.
> +        Ok(unsafe { Self::Backend::project_view(view, ptr.cast()) })
> +    }
> +
>      /// Fallible 8-bit read with runtime bounds check.
>      #[inline(always)]
>      fn try_read8(self, offset: usize) -> Result<u8>
> @@ -979,3 +1033,73 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
>  // MMIO regions on 64-bit systems also support 64-bit accesses.
>  #[cfg(CONFIG_64BIT)]
>  impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_rel=
axed);
> +
> +// This helper turns associated functions to methods so it can be invoke=
d in macro.
> +// Used by `io_project!()` only.
> +#[doc(hidden)]
> +#[derive(Clone, Copy)]
> +pub struct ProjectHelper<T>(pub T);
> +
> +impl<'a, T> ProjectHelper<T>
> +where
> +    T: Io<'a, Backend: IoBackend<View<'a, T::Target> =3D T>>,
> +{
> +    // These helper methods must not have symbols present in binary to a=
void confusion.

nit: "in the binary", lest the reader thinks we are talking about
symbols spelled with 0s and 1s. :)

> +    #[inline(always)]
> +    pub fn as_ptr(self) -> *mut T::Target {
> +        T::Backend::as_ptr(self.0)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Same as `IoBackend::project_view`
> +    #[inline(always)]
> +    pub unsafe fn project_view<U: ?Sized + KnownSize>(
> +        self,
> +        ptr: *mut U,
> +    ) -> <T::Backend as IoBackend>::View<'a, U> {
> +        // SAFETY: Per safety requirement.
> +        unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
> +    }
> +}
> +
> +/// Project an I/O type to a subview of it.
> +///
> +/// The syntax is of form `io_project!(io, proj)` where `io` is an expre=
ssion to a type that
> +/// implements [`Io`] and `proj` is a [projection specification](kernel:=
:ptr::project!).
> +///
> +/// In addition to projecting from [`Io`], you may also project from a [=
`View`] of an [`Io`].
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::io::{
> +///     io_project,
> +///     Mmio,
> +/// };
> +/// struct MyStruct { field: u32, }

Same remark about `#[repr(C)]`.

With these considered,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

