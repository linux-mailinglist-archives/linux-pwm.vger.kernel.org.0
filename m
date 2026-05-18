Return-Path: <linux-pwm+bounces-8959-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG4yDhQqC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8959-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:02:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9383F56F7BB
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F8EA313A83D
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405C8264A86;
	Mon, 18 May 2026 14:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ym2u9cUD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE71F4C96;
	Mon, 18 May 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115586; cv=fail; b=ifD69Wkg9vvrgoNLXgyab3B20S+RdYNsyTn65aqFr6h8DHkwu4z2lHf6PpOwPw2AIVT5SLJC3f2riFJ14D2FSrRZmcACZGc6bKnK+LaJfY2Rs8JiXZP0qO4/kGHQCmeP9cJ6JyApVNIKVsF/9/+erJmQzLsssgATOBVuUiIVWSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115586; c=relaxed/simple;
	bh=hZui+cIoK0CQd5/6VosXB2d+a+67lOfvPgGfrXt4Gms=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=NbDiShI0zBTZkwYxeKRFYSk64Zk5GGHiuwsDQ33YONNM8EtVRF+i7ANqCug5P9KF21HLgyAyLySOb2NM+ofrhXdY5BOkSi+bvACW0FEMUXuUOKmC210kqm6j0HVqnbV78wu5EsweNlt1zaWPGNjRb/3VE259ebLTz5FkKTn30yY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ym2u9cUD; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JAHBpeNxz78OJplC7WT6ZLKAmk518nMkKznqEjvnVBUyFUJLaPQg2TPFCQ9BqWUXqD4aHaO1YVt8rfLJ6spQ+dFyIC+oxlwTEk+/EpmSULT719nWJgEhEO3jZ8SUdDQhCdMN0GvDHa+YRR5VhattSOsEanh/LjOahF6u1eA700Cu5W3Wz4OJhDLhYg6hPVR29R+S9BxRdjdhEGIem1+T6/Pk7rFirgoLtyLXjEkOwaAbaXCzO116JHKX7unA6EH7bFVZi8O6yUBcTLPaOfrtBXZBkDsBDFuJnh6oZbP+SrnT9Ii3IW66jE1Kz4sORq2C06LyZpdHgZSj6pkV+hpW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZui+cIoK0CQd5/6VosXB2d+a+67lOfvPgGfrXt4Gms=;
 b=isRH3A+ZNw4RdOhiQ55QzGY7kR+NCWUjOVyoqt4Evd/TOZtXWHm+7vJmjplN2iS7txptt6Qrt1RuPivMT6uY7NMr7XXFgYfvxWgO1HqtSQaaQG4ItkpFaMAyenbrVS+JRHhLwsFtKFvwrnCQznto+Tc24+TJzvjP7cjWE6KUDZB0Fk6LN3bVCgjNWZnrjpAHQAanQPTrQ2NMlZ9yhkRhZORxP68YXfmKGA/99zT9rzFmioHd2N2IWgkLRZ2sHk7CICia5QSoP81+6Qx9FOt0dWwWa6ps5vISvTDWIRKcT/tCbGB/4K+dzitBMtiXxk3B44KwiSlt2GHjgbyExiX4LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZui+cIoK0CQd5/6VosXB2d+a+67lOfvPgGfrXt4Gms=;
 b=Ym2u9cUDwqDESny5At7418yxMC/KdQj5AY1ZRCvvPfT2f9lxL3Hkp2rnN5kCJwn1q2gDP/Xh6d4e1rAhehz1r0dUqgJj1lEAujSqV7PO9ChggOIzetHtP1xXeFzhNciAat/s5Ud59RbAKnEztm3nF6ErENzXPEFy2dacaT3GnVJLzk5sFzFdsDfh08IMzc7PdUbUcr4TrtwGYIdPMwa8SWdR0BKy1OpZgawjOKrljgcrDdnU/7oVncX8ODleLjElw/qDLowbzqQ3xtwHWtbGTcQ1wsoY1wScZF3H2+jqF9fwPaWUDV5iLpz2Kh+QicnrZhGBnc0jjFjQ56whr2iy/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:46:20 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:46:20 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:46:16 +0900
Message-Id: <DILVU4J2C0FI.2LJSPULSZ4MKW@nvidia.com>
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
Subject: Re: [PATCH v3 05/27] rust: pci: implement Sync for Device<Bound>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-6-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-6-dakr@kernel.org>
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: c4145773-021a-450c-75a2-08deb4ec3928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	rO57ZWt/lm9u6B8/5I+CRhRne/fZuiRogtILiKjcW19gP1UF8cF2s5p0s6+pO3i3+ULObHiwZWbrMyNhu2BeyMe2E3Ou4pQ6um07VxrPldyC2VH1WfFyaMhWZQdeE+jCBMQmCX0xvLw+7c5wbaJRf4CJ8wOUC6Jp27os1BwrDLlRoWV5tc6dTS4ubZnjYW9qBnxBpjsjO15shVqEv3D7p4iyv4cmruSIARWzl5bFVyeTDyqjxd/XD1t+9WsJm97qcIa2AcqN7bDuXg8k1pzrSurOeKa0iArfA1rHcoxnjDtVdIcnaM4MNn5Mxy9OnJnPiiQCXvYP/2eZCJtJrqrMDVpKNoHzUIqr26QHjL2boT1U991oxXTjJKpBOxjjl4a0hm6uGhjAYrpY9OTbxBYmqrYtn/ldhNaLkQ06hAOZVNFu0uCXEwrqUBjBcWsTveSlSwsYRJD3l54yUMqFha7UpjrDAJTkF4riMKyP6wesa1L+DgoF23ai4rbmPaQv0JIgUw2LYS3eh1lSQ89dpVXyoFcoUDgqzrtSM7W03bXTwG6rLA8WTYsgqLCwQRmY7TrSF8hPaQb+LuygRcwWr0roqbvuxuEy+sev68JNwEnnp3ndIMMwEZjfYJ0HT0XesH/JNEobqz+vz1U04u4g9bNONcZIaH2+3WCIb5eYSObFWcRiKpsBORm1c1yn36vvpIiF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzRQWXBSUGw3NU1FZ0FGckd5ZEQ5dkJRZVc5aTNUYmVraERIQkowaTdSS2Qz?=
 =?utf-8?B?Y0ptYlFaN0hFdVdaUEptVEtrYlJsY3hrLzVIKzEvTm9HNXg0a3MzL3Jweklt?=
 =?utf-8?B?dy93Zy9UVk8vRG55bjhERHZrU25NeXRTUGhvOWFnT2NhVjRPY3F3UzBZOTRT?=
 =?utf-8?B?c0NGYUZtUnptTUFHTmQ0dWE1UmRXY1dKQnJoVVppRUl6ZnJwZnlJdTZuUktt?=
 =?utf-8?B?Tmx1NFNtNFZ1bUUrYTk3VHlhVVY2ajNaRnl5QWFLM3BwelZ2NXR4M0ZGUTBq?=
 =?utf-8?B?WEdJUjY2aTVObGxqS0dNSzFGQXJ5NWE4THJNcGhMRnFHRWhpZWFodUFvd0dX?=
 =?utf-8?B?K0tEN1NHWGpxVGVYMU5pN3EwOHM2YVlKSDV6dSszMXlld2Fza0pNZkQ2blA5?=
 =?utf-8?B?bGNHS0V3aEZiSEdNQjhLQ1d0cTZBcHlwUUpUQWZxb3JpMkxIdXNZcG1lYXRE?=
 =?utf-8?B?V210ODlGMGRkMGE3R0xDOHlXNTA1VEV4RUFaQU1rMjlwdlhNV2hEZ1NMcDNu?=
 =?utf-8?B?Um9ZSWw1YVZUc2xZN3Vuam83MjBJQzhNRVZVWlJjRnhkeTdNWTR6QllYazNV?=
 =?utf-8?B?Y1dpdG56SGwyNHJPVi9mUmw2UlhVenRvakZQWVJ3M2xUVEZ4Z1ZPMW9CSldo?=
 =?utf-8?B?WlNZeFU2TlNzQTQwVk1NdGpWbEVYbTdzc1dtVEN0YXJuVVNETmtDNGVrS3Vq?=
 =?utf-8?B?TWRydkdEN2FHcFFPQk5aUHJRU3o3cXZXbUt4dHM1alB5emRjRFplM3J3TG1M?=
 =?utf-8?B?TER4aFprUlRGL0dzaXJmUUJIdHNkbVJCUVI2UUhMMVZkVFMwaERaQnBzNWs2?=
 =?utf-8?B?Nm9PcmZpYmxRai83aXVJblpGVWVzYnlvK25DSC9SM09OVHZHbloxelpGRDhv?=
 =?utf-8?B?bndreEVKVU04TEppakg3QkdrU2JQVkJSQlNQQkl4NFI1bEYxYnJZc1BtR0pq?=
 =?utf-8?B?cWlnZjZjUHFQUmllT0lBdk1Nc003cmpYNXdLUkk2M0xid0UzTUtJR21ldC9W?=
 =?utf-8?B?cWtBQVpSVTBocjdJM2Z3QlpGSDA1WnZuMUJQa3FLTW1DVzF6R3BkVXFXalpl?=
 =?utf-8?B?VUxpT3c4SUJtaXdvclQ4MlQ2Q3ZzMlBLL2h2aEZKWVN0SnVhYld6bS9RRnRH?=
 =?utf-8?B?RW41UVBjcEZqa0VYam9SVEgrWnhPMndWaXNGaG5kOVJ0M2Vxc2hiMWVRYVlN?=
 =?utf-8?B?MlVBSTR1a1BlanBJcWZwSzZ0RDNaVGw2Z2E5dG14TjV5ajhpaWVyeTB0WU1P?=
 =?utf-8?B?K1NuWHJNT1V1QlMyVTRWMkh0TWxPZEdlZUhWUU55U0FBa3Bmcml2ZEo0R0Uy?=
 =?utf-8?B?TGtjZEp0Ny96RkVKTUFVVUJQNk1sTm1teDRtVjhSMUpnUllCMzhQQ1g1cEFT?=
 =?utf-8?B?VC9RR0pYcjd4ZVFiTkJxVjF6a1c3YUpERjBkaWxvYStjMnZSRlpuRExuY2w4?=
 =?utf-8?B?aUVaKzJZd2J4T3NrMk5DSFN1VHFTb3E5cEdPYTY2RERBRGppM29MZUNMejE1?=
 =?utf-8?B?K2pDVVRrMkl6ellwS25rQXJHdFdDMUVVWVZNazVubXZ3eEtIZDdiVE5nUmkw?=
 =?utf-8?B?ZHdETXoyS0h0UHlUcEN3b2dFM2hhekVtVUFiaVQ5anFUb2NIbFJHQzNPdWxz?=
 =?utf-8?B?YzVDUWFKNWIwbHVvdFZtc29nd0J5ZVBFeERyMkZ1cVJtMGMxWDQ2bWxUWkF2?=
 =?utf-8?B?YnlBYTB1UmJpT09tRTdhVmZpMHBqbG5RcjQvcGtnUlpHWFhVaU5OcGhzUCsw?=
 =?utf-8?B?aXo5VFFDOWc0NkRORHZBclpya3ZyT0YybzNETkNCelpkMFQ3bUJIeXpiZjZl?=
 =?utf-8?B?RU9ZbFFkWW9WYTdLdTJVeXlFa1Q0VUt1TEl6aEdFK1FuUzEwOHBlaTFhR2NJ?=
 =?utf-8?B?MGNHWElpUnRrT3BuN2dTNjl5dXFsK2t3NFRtY1YxMjBsaG5NQUFOblhXYnd6?=
 =?utf-8?B?eE13ZmRoSDlWeDJjNDFDbWtLSFhjYnBDdkNCNFZGc3Bxc0k0Y21nWGFoT1ZF?=
 =?utf-8?B?eStpeWJpaU5QQTU1TEJXQnBpOVduVFQ2VHVHZVdFN0RRanNTMmpJWkJHbXlr?=
 =?utf-8?B?aTg5ays1NFJBc0pwRG1ObmUvVG5OMVNma0VHRjMzd2VLRWlYTUxyMUlhNXMv?=
 =?utf-8?B?dE1NT2djWm9BQW5lY0F0VFUxYjhmb2p1eUNuM1ZJeUJ1d05OelVOQkhObUw1?=
 =?utf-8?B?Zi9WN2NxMWVzLy9KdmlEU1ZPNHhuRDE2WDIyWG5xVmtUWFptU1hQUFovQWto?=
 =?utf-8?B?RERwTXhZY1VFZk00d1FJMEdSUUQ3djlMUmp2eWg4VEhKV251eFdGWGFMbUtw?=
 =?utf-8?B?RmdPT0hCMlhFT0I4SnhpdEZEY0tGRHpzSytVUG0waGdHdTNFOGFYNzFNaEd1?=
 =?utf-8?Q?+Dl+rgAPy7mAyoccPkEHT1bXzA+DzDwu6GikSbANL4du9?=
X-MS-Exchange-AntiSpam-MessageData-1: gk2ZAhbOc0hb8A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4145773-021a-450c-75a2-08deb4ec3928
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:46:20.0346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BT5b8Fp6uqy7qMq3XS6EoK92NRGkB/ci5MsS4fgRNINLupQ+DXy3wGwjfTYbKK1Fl0ajvh9cepLeYiFjOSrRA==
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
	TAGGED_FROM(0.00)[bounces-8959-lists,linux-pwm=lfdr.de];
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
X-Rspamd-Queue-Id: 9383F56F7BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>
> Device<Bound> uses the same underlying struct pci_dev as Device<Normal>;
> Bound is a zero-sized type-state marker that does not affect thread
> safety.
>
> This is needed for drivers to store &'bound pci::Device<Bound> in their
> private data while remaining Send.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

