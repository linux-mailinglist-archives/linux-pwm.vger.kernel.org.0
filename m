Return-Path: <linux-pwm+bounces-8989-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IYFJAYIDGodUAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8989-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:49:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F30315785A8
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 08:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8441303583E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 06:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144C039657D;
	Tue, 19 May 2026 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgjWhySI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339326CE32;
	Tue, 19 May 2026 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779172937; cv=fail; b=UBev2zVS76Kq2NQpOrCGWxVH9g8V8XG77+AwOeOtQmPOZiUPBOS0UA1RYd3XAWLES26Bw1VPAFEv0qKo/xDUF1ZNmocEKq2VNWGfRaPqjVfQisJkB6t9ZriF6koK1sjrMz3F7jDkXboca3RV0GMincnPAbILZ0X9PXc+o/ZjT/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779172937; c=relaxed/simple;
	bh=ln06HGfXmxIOKSJ+ga10peEVjRJfgEJ06Ah5dMnscKg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=r+VKdCABoSdE4XdLlc6vAarv8ELNlb9B5jmfdYpLC40WCcX7HK9ATYPoJbUuBsfOLp4DEOI3DsjWckN+wVIHgPxR5pyt3JI2Cqp6KZuwanAMkVCs0zMWl3TYAteK4uHBbVSaS8MbG5lcnv/swxaOGW8ZbcSyPo/xhoog1c3zdOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgjWhySI; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3odXSA+gD6s/99e5IpZEd6BYR2gqCtXfnuVRyLqXnH7zOdOprskNgEaJlee3CuB+5ZOPMiAQB5qE2/j0MKiYj+YNkyt9dhWxfypvuHnMikdwQGAv2skooWhW74+qrn0OgZ8mq18a4kWhQrDmKD5+5SlPKWtphAER4vk+DwXpQ1KVAuS1Q78qj97oVwN45jVP6mhZOJ0CwCs7JLTrE3oKBiASAsSHFtkq8kAgDtAruULX2MCmjCGmaPmMs1pjQQIFG80+cwaiDi2toup1sgwRTxGkP9fnUjquo4IZZ/wyJCdHKwPmIVoZZy5Lh8ZyQhEDrp3K7yp/hlSTePAHZYyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln06HGfXmxIOKSJ+ga10peEVjRJfgEJ06Ah5dMnscKg=;
 b=Yb/paW35z9N6QUdkczfKvWUXpkEjRekb46quhUDhzRaUq1DWqau93ZCvMUUfacOata0cyRt2U2o5S8xAJlL69ADTwFUf7doQu2jf93bkpI8ZZ760HzarNJEDKrhNS4HgNo5nwgGBqlR3VtiuX9+DEMPGyW5kqe94EiBD2rbOjeV44jnfMoN2ygi0mvQ1BKoyAa7R/zcu5/XsroqUMbMnq01TInD6AqNyUM5Td/19qHrWJviUo+8BAtK7EmcznzHElxzlHMPs94N/aNdILginp6gSjn7NRyw4iHO++D5t9T9TBXwoFkc0kC34UTdn53pxOxwFbpaBBhkNDDPd4L8/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln06HGfXmxIOKSJ+ga10peEVjRJfgEJ06Ah5dMnscKg=;
 b=kgjWhySIicmlgX+BKd2qbF6AsT6WHh8Tuw5AayPrgHmlCiXR7QTwjtb1bQYKxiutMOIGwDXblm5Q1cZThDJPR45Q2tUluI+f6kn2zxEFDP08ERl98Azf+4J9H22PBab/EJYnKl4dv/ZO09FRRxIhVWpu40L3amRUdSg81w9ofwoNhwmYJCv42pVvNeVeSoP+wRoKCBg7GqiKeJhKM4veGUhqpvmKTrFZJcS9GvQZb6tvDgOb3bf1/L9Srmh7I9XIsd+aUrTDGYrR4kX3S1Tv/RmY6uGgQjYJNZ79HJBVFMWpFNuTlY0Ii6542/+AwWh9wxEyI9Rk1KSv8/bS5unYoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 06:42:07 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 06:42:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 15:42:03 +0900
Message-Id: <DIMG5XHK23XR.3H6LJ2MU0DSZF@nvidia.com>
Subject: Re: [PATCH v3 22/27] rust: driver-core: rename 'a lifetime to
 'bound
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-23-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-23-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0119.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: a9334f55-33eb-4485-766c-08deb571bef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020|22082099003|18002099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	iGDqxFxv2WCWpLfZQbp4+0HkZt9ZDCT5lj+6Z7frgLqe0rreh0SflRKkGVMNVu4VXIC2n1jGHW/vETRsaRm/70Zyz13wU66gxDfPSWy0he4Ms7Y3k9DMlqfewXuh3y+686lUeu3Y2Nh7pwDW6JQPholbBR32iXMqMtaaIHrkEYADkqoxyBtHOgno3pYEnDUu5FZ+ekIHTDsqwc5LwPO43oQ5jVUTGp5egDlJzWK7SiMWkmInLc/3wNiSdc+1m+4MYf3Cgoglyvi5sTUZc0nM4Pd8LTBEyCKrbIkUyWxuPL9TGSaGWNxa1a3eCyYWJU7dD2Mte/ai03s0jh6EvcGqlQ2OL2smEr2hw8Tq05dagekHllsuTouw8g4uNKZXuPaZU5sPGMPl8zxX9gvnwRkJyxoT96Oa/c4IP+i8pItv0xlqlkEpUjezVPpoVbjd3QdbcwykhIXcdKag5Tc36OX52tKSatiCdINLL+OVNJ9tXHotikph3jEaA6fV9UQp12oIKC1gaVmGIU5HxcwQ94ovESC+s/wdrDB4fzNeq7R+FBPo0mG7pHPjG9SKLVQVc73Q1dpkdypkPrOnVaLDbo2XeDF0wKFHI0nawpqj13ahu8WwT3bdWcAkVrM1HifmjTf8vE7Rih0pdf7+CINOPUWNppyvMKvqihf7aMJ9tfrbkInnoNKAL8rvDPxzSHxLlJT/PJGgSPeDCCEYWJG8+43J14mkPYj8DLSKhMcMoA8YYjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020)(22082099003)(18002099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXFXazRGdk9IdUk0bVZvOVJDNzlCeWNrVFpZeFpCZy9vMWJUckxmL2s2V1pO?=
 =?utf-8?B?L0wvUjFlRG5QNWFvME1NcStZKzgwbjNyMDI4R3F0Q3duVHl3QmIvVFhoWmJF?=
 =?utf-8?B?S3ZNa1FEWUlBejdEYWE0a3lqOVpEV01qc2Q2YXJKQjM4SE1kVEtXUzg1WnN0?=
 =?utf-8?B?N2ZCNFAxNjUyYk9IQVM2ZWkrYi8xL0h0UGloYnpKYS9aWEVmSEJRc0FYaCth?=
 =?utf-8?B?bVMxc2pzeGo0eENpTndDS0ZwTUtESE5pVjloWEtzeXhmOUMxcnIrZ3N2Vjl5?=
 =?utf-8?B?YXBkT1VTbXBrRkRsWmNMTG51WHNwaG5ObU9FMFdwNmFQdEJ5cmxBcmdyZE1j?=
 =?utf-8?B?bVBkMW9OUGpkOEE1VURrdFFVT05SVUNuaFFpUmo5K1lLZktOTEl2SXJlMkM5?=
 =?utf-8?B?d3VkQmZoSkZqYUdEbmFDRU1qODVkWDZRVG9uZ0l5ZXk4ekJrb3dKVjIzRHNT?=
 =?utf-8?B?T2NobXE2NkdkNFhELy92SGNjWDNTd2Rtd3V3b25jSE4wQXVHemJJSHEyNjg3?=
 =?utf-8?B?TDR1Sm9TRVg5L0tjV1FycTV5YnJhOFFmcFBiK3FEQzZ6VHc1NjNycWVXc2Jx?=
 =?utf-8?B?ZlpoU3ppZDdtUnliRzVDbjFuc2NBNjl4U2tkd25DekNNVTBoZ3FleWdPdGZy?=
 =?utf-8?B?UGRmU0Radm5EMm40Y05qSkJFTkwwd2sxd080cG9MZEpvaDg2WkJGL3ZURkhS?=
 =?utf-8?B?b0hGS2JzenBvMHIxNWdTQ0hoZ1drczBTelF0bHpGYmR5TzdVcFJVeEtIZGM0?=
 =?utf-8?B?a1RpK1lTK0RodGFCQjlHNVJsT05mbUxBY3hMQkxGa3FXSkZDenJWY0lvSWlv?=
 =?utf-8?B?VzhWZVRMcyt5dkpUbWlSSjZibnlBcVV5dTBocHo3c1dUMTI4QVhsN3lIN1Ft?=
 =?utf-8?B?NGdrT0dHaGxjM2ZIajlmZ2RkYTYvdFA4aThUOHlORmsrVXFUREhlUDFmTCsz?=
 =?utf-8?B?VW1DVVdoYzc4cXFMUlYzTW9BT05XU0tXTHJFNksraEc5aEFOQ292TXdtM1Bx?=
 =?utf-8?B?Tkt0SDd6YW1nUjJpd0ZTV01xS3dVdjRtbDQ3S3M2LytzWXBVMVdGbGhNYTJw?=
 =?utf-8?B?UmgwNS9mYVBocms5SkhuSUxENlE4ZURlbVQ4UmRmVXAyOG92S21UYTkyajFK?=
 =?utf-8?B?QlJvNkhpTGtQMlBtZ2NxWnlyYndUb0h0WVoyWERGbk9STEpRQXRtYWdyQjNT?=
 =?utf-8?B?TjFDZDZCb2NLcFRGeVlNVDBkSDB0Sy9TVVFkeHYvUmJTcXhwUDFpaERBL2dp?=
 =?utf-8?B?OVRXc3V3aURoOVQyUHZsaHBXQS9WM1pFNGtMZnU1cWQxQ1JPVFJnM1dXR0Rz?=
 =?utf-8?B?R3BxYWZieTVEbVJoQkREZ0V1di93K1J2bjNWK3Nad05hdFlJS0RUbThVdFVx?=
 =?utf-8?B?L0RlVVNXUm9xNjlDSTBwMWZxK1RRWW5sUk9MdWhRTEJMZ1JqdGtUQXg0Wnow?=
 =?utf-8?B?c2ROeWxUa1pKcU94OWZyYU0wNmZ5VWdSVk9zc0pDaTI3RFVOSVp6UVNZZFNJ?=
 =?utf-8?B?WFJvNXp5dVRraUc1S1FHOXRaMWJjbGlSL1B4S0RlYVk2citlNUVscTVsUzcv?=
 =?utf-8?B?eTV3K2oxMnNKdzE1OFJOanRnUTRzNU1GaGs0Y0tjYkJlOFZzSzJGRnEyemF0?=
 =?utf-8?B?SklidHpEWUREVFhkd3R6bGNtZDlOVU00NmJvMktBV1VscTVmQTlqbkxnUnNh?=
 =?utf-8?B?Nm5lT2hyZEk1VUxML0t1dXlkQ0gwdHpWNStJUFRkN25OV1RaQVZLbkdOeGs2?=
 =?utf-8?B?NEhVdmxTaEhqV1gvRjZiTjVNVlY1K2ptZ1l1Um9jSGtnOEp6R1RyNDBuc0Jk?=
 =?utf-8?B?YTY2dmxQSDJXZHRKV0dVQUhWbWJSSEc0alo4eTEwQ3VNWE9lNndaSCtTZU9l?=
 =?utf-8?B?c2Nya280SmJDekhnN3BkSmplb2w1aFdLVEViQ3VoZmhHcWRCU2lGdng2NEdK?=
 =?utf-8?B?VUhxVU0rT08rNHpHR2I2VGkyamN5ZEdsRXQ1WEhuTXFaS3phdDhhM1UxdTBr?=
 =?utf-8?B?R0hKTHBOZ1Nyc0pWUElQYkZvUnloZUx1UTBIeWJmeFU2V2gyd3VmalcyMnBu?=
 =?utf-8?B?TnhqOEpzaysrZVc2K1NVaFNmckIyUTNMMkIzb25xSzhCZG5XbE9rWm5wb1Bu?=
 =?utf-8?B?TXZuY2RvSTQvUFJzT1dMMlBlUCtlVytvS1ZyUWJ1RjdzaXY3NG0wQmxpRk1B?=
 =?utf-8?B?LzJXcTJmdGd2WkU4OFFRbHBpeS94ak1iZ0JzeWtFcDkycmQ3YkNYNjlMWUZU?=
 =?utf-8?B?cmx2MHJwM1dYeUt0UlFXenRFZDFWS3d2MnltMHg0dEtZVGgwZEl3OWxZNi9v?=
 =?utf-8?B?bTFkSmxVYVEzeUlkRTZWRHhnbW9SWGV3OTArNmxSUmhYbk4vTzF2Wk1qQWFD?=
 =?utf-8?Q?GriAb2nr/0brWLxgbOgk5FaezfZDGEXu1cgIh4FomrPUk?=
X-MS-Exchange-AntiSpam-MessageData-1: ayGpJPM/EYjFYA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9334f55-33eb-4485-766c-08deb571bef7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 06:42:07.4142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dE0g8vFGvUb6Kk3bbAF+1rXSa587RiCaSjbDRjdRqOsq6i3YWNgvvsF+DznK0VBsxDdyYvj3gxZvQ3KS2hn1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8989-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: F30315785A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Rename the generic lifetime parameter from 'a to 'bound in pci,
> platform, i2c and devres. This makes it explicit that the lifetime
> represents the device binding scope, consistent with the convention
> established by the HRT series.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

