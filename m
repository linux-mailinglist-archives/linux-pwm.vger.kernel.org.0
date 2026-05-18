Return-Path: <linux-pwm+bounces-8958-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IE2XFO0pC2rqEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8958-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:02:05 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE256F760
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3EBA30488EC
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7441F4C96;
	Mon, 18 May 2026 14:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sqRG4p19"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013050.outbound.protection.outlook.com [40.93.196.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954622CBE6;
	Mon, 18 May 2026 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115553; cv=fail; b=lO4fCEgkFPhwMlOPoW71mVUyZsSs0Kfdfpl2rjQ7rCigvaJfSD6EwWlQmV2eyOWowFDj2RBd6PkXOIUFrN6M3F6RWWYvjISEC4rcObbqOe51Eer7yjXaGGoGbhLPiUSFtoVlvunfID7jg5Je0p1t0KSRMrUjHNYQFlyqeR2LdV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115553; c=relaxed/simple;
	bh=DIEnuyJJAbtvnOyD3vp0EC1viG1VEtdbLxttZxbj5cM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mxy/Ca65aNQhHBFurhDiYFmO59k+Lp2peM6RcUcOotd/vYDMzLfNESy01UoczLeKZtd4477gJ/v7pxz4j8KFnnXuwpIwf54Ad3sUKgjkii1LkorRXNU14voT73yKczhOPkJCoI374o1PBXxJwWmVKIEq1zRqgVvvTUxr/PXoOog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sqRG4p19; arc=fail smtp.client-ip=40.93.196.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVuEVZ24JS4+36PQgfbhB7wraG4hrkhfmv5yvt/5Ltvz5k2rfOq6Vyk3Ngd+MMDc07KL9J0UvL3bGvX5dVahGOPmpHKgJ7bESLXRZkk9v1B2TTFLuuHc98pRaGp7VKuIlYP+kkEREK+0GtMPGDdk8sntE1WBpRjtvzsb1VUipoyvUmLV9TyE67mFbBuNFrMcwQD0C34MSr+cTe8EuHnm+3tW9TZWokSOExfIz+bWJkLwb0xQuN3MX74t4o9tAmFj5RT+wF3mfbIyEEm2XqxfNMQpwvd18IAZM66QqaovBc+bu5XoTRjlIX2cX6khR+TCA1FIz2egqedMPI8pDc89zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIEnuyJJAbtvnOyD3vp0EC1viG1VEtdbLxttZxbj5cM=;
 b=KNha9sumJLkNgU4ar0NWFO2TnpDYIcUBlao4kSrUMvqBd9ylpu85+KrgWYMwWI/4NAtRXHjhAeX3dzSbUd7ZBrSSt9u9MDliVMYFbbF8BEYt1zvXGkz942gnSa3YsUF8gubA3cQ/Iz6VIeoWJMQtbOl1XIOPQi2vHbc6PmOwPJBNsmTktOuJJj9ZImXEm1jSaGPQK7QPJJ33dKdthQKp0/bTLhCrLN4vEFNPNBhKu+U2Q1Wpe0C08sLb06ZqEpCNcyrVVtdG/wMeLfQvd1TtqOQ5qYwnq1j3R2aYDV9iZ8eGOHVFzYyss8oAX5NWSNcRqCKzfL/s1EiR9353KHST4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIEnuyJJAbtvnOyD3vp0EC1viG1VEtdbLxttZxbj5cM=;
 b=sqRG4p191X6N/G1aRvGS1XUTD928nEX84B/c5d8i2yyAljvONLlyLI/Tr6fZ0Zp4KjryRWhGS17i3qcHmA2a7Ja6mRe1zgdJUC9c9JCjoFcKqBKAzaqRvxY/qVsbmINInAu/qEbOoeuaStAN02U8FAcOlGE5h+wkrv9itKoSZCw/DJKRCmDsx3Vk/MoJwxk7pj1hmwhJkXoSzZiwC/2Y//5xh1SSCaq8h5UHr4557rImq12DsJzewEAMZopw4Ld8r8UpFLIbHvJ5RB/c0Q5cEHHb2shLZzXNfvEFyj8v7IYn7y+ny1t0M7kwgXBjPBSLvMgUMvRRAYhvEzP3tuEjIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:45:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:45:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:45:43 +0900
Message-Id: <DILVTPMEGZW9.2GOF9WJIZDZRE@nvidia.com>
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
Subject: Re: [PATCH v3 04/27] rust: driver core: drop drvdata before devres
 release
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-5-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-5-dakr@kernel.org>
X-ClientProxiedBy: TY4PR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 7110f779-baa7-4c08-7ce0-08deb4ec2595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	GAO3pp+Z1KEt4BSn8VLXLT5klh5+2lO3IcViZbb2Vt/CQhR2SvdLg7Umg/YezanctveXlgRfJ/7bMpCeMiwDz0U79cDWBqvt3MqUGoIhex776eDJLg4dCu5MFnttB3em+UHy/xkqMy1ys7xqn0/SCyUzgWLn8RkHhku9uWMY4yY7ZblGuAItoFH0UircOGtTH6nFZlK8siIihdHOo0k4WEO/WQEsHVrzkl6pnGaBfhD0WbNJqGwMGS+xsF0qn6m0zHKkpSf/xe/C5g1Ilu3H6+io3aJRdjPT4O5h+KAxFXE9n3r78mFuTBXW3gVdgXv6M2XYmrHHvX94lYpPgd1KepU+PnW4p6MxFY+sM2j9d5t2Xfn5Avf0CSVN3U2kSrEjOOMTtdyveORy7wjqdYL0l69tqXh0sEMifLVrc0SC2S5vJPuCxN6dKDRT673WX1wSWoDVCjY1xA+PiNi3CYq8TBezD7/roUvl54fN/CClyjXu6/4/yqbu+JfjwHoZRe/MJ21gU4pEfw3MODWW2WJNg4GTdhJsvYRHsFGG5Wa2XAcfeKv5qZmG4eyuqvOX/evST5SLTbWVAyyLLZrLfetRSX52zrzz7BWKDE7feTGTBW6/TzvEz4VxOR5IcloLz/QQ5vEJ11LQA2OquOCeWW5f2wWBa+hENT5w8pTykg9luikI1bln4hJOim0RXAs7t69j
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1NCSUk2dWRWdUJkQlp2a3UwZVV5QzgzcnlNYlBwYTJnbU5lRjlMZmdzM053?=
 =?utf-8?B?cVFZZTZPQjlFWWErRXdhNmRwaHhnYXpiTy9odkl6azZEY1Q0VVJnVk5WTjhH?=
 =?utf-8?B?SnE1aEVZWHBvUDZDOC9kc0lLN0xaYkxxeSsvMFFEaEtqSjEyM1FZaG9oSjFQ?=
 =?utf-8?B?R1Z2R3BsZ1RLQ2JvUHdjSGlmYTNoTzBMWGJSWHR2VFpMaGZyalBNUkIwN0tu?=
 =?utf-8?B?blpEY3VWbEZJWmpPMW1md0hiRU96R0l3TmNHZXJydi9ycGNoeElWN3JHQ1F0?=
 =?utf-8?B?dzJVeHJWZEJWY0NPUEhDc2xIMkhSNjRGNlZYZndZdTJLdGVtVytjRXZGWlg0?=
 =?utf-8?B?L2V6S3ErZy8vVHphNE8xcUc1eW5DaWRKVFA2RVV0dm5ZWU1waFEyREdQNEZF?=
 =?utf-8?B?Skh4QmllUElDWk9BU1p6RHBlR3BRN1lnQWRCU1d5OE0wTE1uenNiR0gzS1J3?=
 =?utf-8?B?Y05ibFJkaEVuTU5PM3IwSFZzdU4vU3BRZWh0ZDlFNWU3c2VtQmpIR2pack1l?=
 =?utf-8?B?M1I2RXowaGdlYTN1d0lxQ1BNOG1PZkdmSC8xNGxmMHBBMnVTTk5QV21UV2Mw?=
 =?utf-8?B?eUNsZG1aQndDR1h5ZXNkUjBZd2pvSUFLdXJrd0FZYThRTnd4MTI2WDNCSnZj?=
 =?utf-8?B?Ymd0a00xaFdFN3BiUnhNdUFveFRnc2lqc25vZTUxend6ejg5R1E0cE44Wm5u?=
 =?utf-8?B?LzdPSU5TL2ZoQUtnWU85dWVDS0Jyc0NHSnpIQVJoL0RLMy9BQmlORDJ4bFQ2?=
 =?utf-8?B?L1V5WGNmZzQ5ZktaWUxVd05WSmdLMjJiREhqMFFwbjZETUdvdXd5ZmhlMGhF?=
 =?utf-8?B?QUJvOENLTXh6L3V4QUpJcVFMUG02RS9wdlBwRG9QczN1aElQTVN4VTdRcUJL?=
 =?utf-8?B?aXF2OVNEUEYxRSsrNU9ZU09VNHNnMEo4YnFOTmNDbHBzaVpxZ0sza292bVBy?=
 =?utf-8?B?QjZZT2R5RjlzSWhRTXJQbjVVOXgvUjB2ODY1a2l1MjNRalV6eWN3YXYrbmFn?=
 =?utf-8?B?aU1QaDROQVNGT2RRdzlHM3hPMnJnUXZLcWlySk5iMXlyeE9VdlEzaVAwdUJo?=
 =?utf-8?B?MHNSNW9aOEhxd2dLUDJGbHk3Wm9HQ0dNUGNOSjY3M3lyK0ZsOUxjYlV5SC9l?=
 =?utf-8?B?Ny9pcWxGMXp6Ly8vUVpkeERQYWw4d1R6TmZsWWlDQ2QrUzdyZGZZUFJEWHA0?=
 =?utf-8?B?d2NEUHN6alRuVk9KMGZpRHlWdWpQTFhJVnpZaHZnU2poamwzYXF4cWRJZ05O?=
 =?utf-8?B?NVZZTC9BcVhCeWMxaHJLRlVvaXI4ZXNWY3Nzbm9tQklpekxjenluM3htN0FG?=
 =?utf-8?B?SGZtckpKVy9kQmlYdlAzQThhMldENm5OKzB4dEphTzBucFJkNkVGNng5VWU4?=
 =?utf-8?B?SmRqdXhaazFjQkNZMXVDa3YvNDAzMCttWC9RQzBxRVhxL3cvVk9XOEE5QzJw?=
 =?utf-8?B?UFlrcVdBcG96WFBsMXE4c24yNFRtblVTSytjM1BraHdhVFlta0tHZ0EwR3B0?=
 =?utf-8?B?L1hFWkRWczZzWUtQVkZBNGxmY2VZRG9Odk4raE41dzlwYlRMNjJpNUplazY1?=
 =?utf-8?B?UjJiL2s5aDlOdlc5ck9NTVNvWW9nME5sZTFoSS9pME1HVlE3Qlp5bzUrVnVK?=
 =?utf-8?B?S1RRTGpkcms5d3o5RGRQVU5Qbi9HSzJCbmFYYWJXajRrWkJSQ0dMWDJGcFBt?=
 =?utf-8?B?eW12Z1E3V3M0bGFVRVZlczBmdVlOYWdPSmNUYWZhbWd0TU9IS2ZydWJFdElp?=
 =?utf-8?B?U2daWkpjRXlYenkyRzFwTzVnTHBza0NLK2pMdngxZVlGNUhUUGd5SG0rdTBC?=
 =?utf-8?B?dnNxazhuaWJhQmpwYzk4azJ3c0RleGs4YkMwc0srelIyU29zSXVPbkI5TDNX?=
 =?utf-8?B?elBaS0Y2L28wQkFNeTNYMHFxdG42eXltMmkyd3hYaEpDZXZJSDV0blVVekMw?=
 =?utf-8?B?MFFucTQwVjFIRWRKQ3lVcCtBT3FpVVdNR0JTcTRlMVp6VVlSdnQ5QWZBVXMz?=
 =?utf-8?B?TVpFRGIybTAxUVpxRU55MFR2UStiQ2NWVWwxSktQbnRqdU5qblNDV3NTeDRB?=
 =?utf-8?B?dEFoL21KY0svQWZHUWpyRXU4MndJaHJsRi9nUnZoWGZoaEZEdHNwUlRXTFZw?=
 =?utf-8?B?YXBHNUJ1d01EM1l5TDZQU1I1QXN0MzJOSVdDOFFmRDVWMUFNREMzZVJNNVU0?=
 =?utf-8?B?emxrRWwyenpoSUJLZDhWSTdmNGlXcm8zRTMyU1NZYUsxVjdPRng2MzlQZ085?=
 =?utf-8?B?WkpLTjMvYXVSTm0yOW8yRGNQOVVLZGRxNHN5ODdNeTI2VG5iajdUSVdTT1pR?=
 =?utf-8?B?ZHdCM1VHM093c2Q0ZmFrcGQzT2tyaFl4K3lESWtPODRwTTZ5ZW83UUl1SkN5?=
 =?utf-8?Q?bBEpiHnkMrqwFwASzarNIfthTnv2J2p45XRH7s+3nsS0K?=
X-MS-Exchange-AntiSpam-MessageData-1: CHUHiLFM4wSNQg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7110f779-baa7-4c08-7ce0-08deb4ec2595
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:45:47.2453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zRr/b0/pkC0IbMfG8dFa3vXf2ixRtMlGcgZKM64B90+EZeHitIbTIuE+sz0G+x0hM6fY2/L0jUkKrUQTKs5oIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8958-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A2DE256F760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Move the post_unbind_rust callback before devres_release_all() in
> device_unbind_cleanup().
>
> With drvdata() removed, the driver's bus device private data is only
> accessible by the owning driver itself. It is hence safe to drop the
> driver's bus device private data before devres actions are released.
>
> This reordering is the key enabler for Higher-Ranked Lifetime Types
> (HRT) in Rust device drivers -- it allows driver structs to hold direct
> references to devres-managed resources, because the bus device private
> data (and with it all such references) is guaranteed to be dropped while
> the underlying devres resources are still alive.
>
> Without this change, devres resources would be freed first, leaving the
> driver's bus device private data with dangling references during its
> destructor.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

