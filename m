Return-Path: <linux-pwm+bounces-9530-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ChwUApTKR2qHfQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9530-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:43:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9562D70389D
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:43:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=N2j3EMEs;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9530-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9530-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B2E6230058E6
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6552D3DDDCB;
	Fri,  3 Jul 2026 14:39:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61AB2D1907;
	Fri,  3 Jul 2026 14:39:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783089584; cv=fail; b=MofSCrAhb/245v9no+B7VoHP6PiHHPrzobMI1H9kjGP2rMLTZ8Ov+bUrQQQY7NDJoY89DtltOMFHiYLUzexLH9n6pOHxxWir5h32jRxxQhELsZ6ZHiOeYJvz+Mn7np9yw7c6KseyFPIsxIUCZmR7GrHSE3+CPGPIg+a7Fcs+tp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783089584; c=relaxed/simple;
	bh=lq+PuF1E2eYUNqK7lRisc1rPR3B7TOM7IRb5YFLy1B0=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=H3NOLGZSINLh85xOcJHgCeSqUqkykJ8wpe4oXAzZzObYZrumbU3M02Od+emG15+XD0vSprLcQT0OMLN7pGdZ1apfgQhxTiNHkGpyoojPJmJq2m2AZocq+tTqvoV8lPLYLGdRMS+/3SYTnEnko+yrLDqdL+3QP5SlGqAQPnCUU80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N2j3EMEs; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fOSaJ6trkqcLJqpkadSYgyg4X/LHm28nCVkNt+KP2UfIdw0RSy8eZhKBFV5nM5WUWmnpAEphD1t0Uf2k34JNJqLfZZmoVUCLX8g/r1bmtI5vN9LcIvzHC8eucQg0fss4ENqutD9qJLamebv163gqa72BFzFd7GIbOYhB1Sj2dtji1X/U6gP3Fk2Go8BTQcUh9KQVe6bythskJWcd4oTaPJ9lexBSC2RkpwzDsYX1OtrP1TBk8Z9zidqT4fFLg1WZpP6O++k7J1JJLyxZucAxtxGDpmSzjczWdOuvCoUYkHTOzi/bVgVPZ4cLMVSCxVJdcHbTKS4Kff80B69eUJ3iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq+PuF1E2eYUNqK7lRisc1rPR3B7TOM7IRb5YFLy1B0=;
 b=oT8FtZXJb9NSH2Ks74JEfw2wl4PtFgsphahJFtbM4cg5wOVJLveZMsg4YFk56y/UlYqwY5PyV1jFg5UE6k/70MleLz4JzuIWvkLbcBIwBikWjgCdgihT11UGEqUTCoq5iLO2UgpWlxam2XRQmEqeO0N99/hNhrpyP3bM/MAAYZ0wSepZMMDA5NVq/vAGFvPYETppl9zRS/isrjYlkQ6JqWwcmM1N/V3XcbP/yIS7cP3g9ZQzdZRo0OoiG9NfJhagJtmxNuqt8jfAU1wB6l1yj3mAdXy52NsMEV6uJeYFnpa69dPX9AN5Zwq8t9InJv1zkUIZN/AycvSm8WIJ+fGKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq+PuF1E2eYUNqK7lRisc1rPR3B7TOM7IRb5YFLy1B0=;
 b=N2j3EMEs7ZUmgfR4zBCMEgGR9tYv5ewZLaHOgBrNF6sVrGhJA77KlmCApYCeGKy63be4WE4Wr39/5m2/P0Glurvqin29w72eCn7RINqWuaeA/7qp3BDG9l5DspHDJbY3+ceUFOp5tDm6LDdD4ZpIaFOeesLvkkA64e8gAD/UW9e2FZfZ507+EeCGf+9A5olU+eJ6yFH2F8en/Y/VQPo7jAMVM430mtj/PCsxLgVBpsWOg+WgAMLla7lKG+oHvptbs3h3PeKxvWEdNLPtNg/ywcsrnZDuIQSXA5WDxYS8K9284NwUyY1gzlwwdckzG0aptE75YIMp/HiqZWHnhsKIhQ==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 14:39:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 14:39:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 23:39:28 +0900
Message-Id: <DJP0HZL8L40B.31WVDKAEC4G38@nvidia.com>
Subject: Re: [PATCH v5 15/20] rust: io: implement a view type for `Coherent`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
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
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
 <DJOYP821KAZF.IZZ0ZOF10AG1@nvidia.com>
 <DJOZGKUDZ3GT.1FU4BOO0NII2E@garyguo.net>
In-Reply-To: <DJOZGKUDZ3GT.1FU4BOO0NII2E@garyguo.net>
X-ClientProxiedBy: TY4P301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: 85fead15-deb6-4489-7e7c-08ded910e59d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|23010399003|366016|11063799006|4143699003|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	nBJ8nN/SF59xGNf6F8eiCwQQokpR6zhqIvrSU23rwSpTbayTi61i9HrQIW4DUQFkZuphoaG7iozaLKri3rSRA6e/+3dNSdxfcSUwgHYQ0b7ggdxcFaaYtU2pQ7zHAHVHR+FjV36dVjLhdrINOzTsuJ/gEMCviMDHENhAKNiiUzdUfFlaGejAaafMPAjvycBKDV4mEIHxXfPqkjyrt+XNrXqYar09X//dnpjJ8wtjfwlucJyZwzPQaMHzP3teFRzmLzkeLgOegmjAYou+iE+/SJ8TyOovWHYXfnd5968sefkLf1NEYJLfOIQ1hBYcd5nPFYDep9sYprS/azCAGy9ve8n2uH+CGvcOFcRwcvKleGlUBI1TN+m0LSRRs32prf4vAU+bzqN44upNph+oQeHGpkUmRk5C7F7O6YrZO/Gv+YqLiscY2oUI345nccuYBDonxlg4PDsyTQtOuo3EC/Y8a8IyrcjErcv71/ZpzQy/cauW1+La4Iuwg6Js2yBRKnxghjt67ASldY3pfrChCLDgdXiLHhhQUD6L5WyS8cl26VwEP2eMSKITsqB+iAXqoPzLdJ8ergiNqQFXA6W6ezyFbS2L9e47NL89fguG4jjNSVOdMfEVilzbwaydx6gbuoXe0zedKqJQG5/F70+bNAGoz0odQ4hhhNtFz4tXoIyoL0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(23010399003)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QytxcE5LRGdqeWdOeTVsVU83WCtsQ0I2WE9HWElWZmtURENLcWpVV1JBYkhU?=
 =?utf-8?B?RXF3b0JKWjhSTUpocjFXZ29OT2E1VFZuSFVYcmdWMUZLbUgxdjRUQUlkZkIy?=
 =?utf-8?B?QXFEd1RWK1FFS294OWlxS3pZRExwOHNpMkJmc1NBRnpxNUJTRytuOG52UW9J?=
 =?utf-8?B?empDZWt6Q3RybGRGUlpRaFpCUjZlb3hPcThKcjRtRFRsdStuYWRjUHR5bHgw?=
 =?utf-8?B?TElxOWprWjU5ZmE1VU5FejNaQzBlVlgrUnVTMzJ5Qk1ZNHNreXEyUE9vUGN6?=
 =?utf-8?B?bjBuMDA5cnU0NXRUVkpmay9YYnRqK2wyY3JTblptS2oxS00yRkt5QUZZMU81?=
 =?utf-8?B?YjVaTStPbXNPMmFwRnUxSWJDZ0FUODh0Ylh5aEhQTml1bkNPQmR6czRGbisz?=
 =?utf-8?B?RHFJSnJsUjVrTXY0a2syYVl4VTgwR1VlZkVpVjdtQkhwUURzT0NGQ1dvMkdw?=
 =?utf-8?B?enJ5czZGYlJqelBjdGQ4N2VPUVlheC9hSWdGS1A2a2FlcEF4bDRZUU1ocGJ4?=
 =?utf-8?B?Z2JBTTVocmVxakwvT0lnOStHdWdqb1hNU3dNWkhMbks3K01UM2tJQi9kWGJJ?=
 =?utf-8?B?eFl2dkkyc2VkU3FURnY3eDlTdmRCWFNNTHUyR0xKelBiME9OY0QzeE9SRWQz?=
 =?utf-8?B?TUdyRFdTdDlLWnE3T3ZDSHVjWlFYZCtobHhsMlZWYkNRb0dyYk50VmZXYkRk?=
 =?utf-8?B?STF0cEpjZ3BHM29TRnZJekRhMTBwc0pyeTkxWk9VakZFYXRFTmVkeEpnWmt2?=
 =?utf-8?B?TTV2VzFqVUNjM3BaWkpqZUswSDQwa1U5YlFNRC8zVHVIN01JMVBocFhkeTYx?=
 =?utf-8?B?ZEp2UXo2RmFwTnQ3aGZaZUZaMlNyYWExVlZqVFBDelA1aEQyelM3WlpTOHJl?=
 =?utf-8?B?TFpwY1pibDZSbkJ3QXJUNmxGWmY0WlF2b2ovQzNtUmdvUHVsbExybDh3d3ZQ?=
 =?utf-8?B?Ni9wZ0RlUUNiYmNkTHRjb2gzRk8xMDlSUndWdERTTWtGcmFRV2V2RjNNOWxa?=
 =?utf-8?B?TjNjZTVsN3oxRjMxcXZSREdMWHVyc3c5VWtjaldKY3BQRkRxbDhtTkRzY0RJ?=
 =?utf-8?B?TFpoSEhML2JlQ0VRbVBGdkR6S29hSjFiU2VpUGJCNG92OUtzUzEyNlM5UEQ4?=
 =?utf-8?B?MW9CMzBKMG5NdXVuaDBtRHJ4cXdhSVhXTFRoQmwxVGx6cFV6SFBwL3NESGU5?=
 =?utf-8?B?MHFUdFMwd2JNa1VIc2ZMbk54V3hEblllZ3lmdE80R2pBYmpwREhaNlZvSThU?=
 =?utf-8?B?UmlEenVPOGdpSGRLQlA0MzVVcDRCdjlEUVNXdk1XbXorZitXU1F0VmxUbUtp?=
 =?utf-8?B?bUJiQ0p1KzNkQ3lYenRjMGNjR1RCTjE0dk1xUUdDRU1uY0xUWDZNRytqdGtn?=
 =?utf-8?B?U1BSc0NPbGxqRTF0SHJ2Q3c4ME51MVJWb1FWdk5kQm5wSXM5ZWRqYnZSTWcx?=
 =?utf-8?B?L0dRWVdjMklYVXVjWnBGZlVha2xiOElxN09RbUtjZVlUa3dkczdXU3dqcEdk?=
 =?utf-8?B?VHlEalcvdzdRWlFVS3RuaGRLd2xDdWJhdVFBc1FYbURYUGtwbWpHR1BSN3Fr?=
 =?utf-8?B?WUpQNVRFTkNFM29LNXJvZ0pWelNocm5yZ2g1Nmg1SE1SR2gvMnNKeE11Y1Ax?=
 =?utf-8?B?YUVBcUJ2WWhuRzRSYTFrZ1R0ODIxZEJBV2dlKy9QbDNoUWdSQm5hd2hXV2Nl?=
 =?utf-8?B?Vi9wRTVIVDVqRWNFSm8yOXJGRlNrSVpYSXczOTBQV1RwOTFMZWdSK0tZcmxV?=
 =?utf-8?B?bFh5cEpBWHBjbjI2Vm9MOHdEVTRXamhERE9ldXc3YnpvTlpGVjhSL0JzRmdi?=
 =?utf-8?B?K3FqOXR1MllMUmhlTnhOZnJlTmUySmNIZEM4bUhqbFVJclljYnNpRU5aQ1pv?=
 =?utf-8?B?RWtRWWQxc0wyTU9FVlZheFBLT0RxMFdORVVDVW5XcGFKTEJ1Z25QNGxxS1Vx?=
 =?utf-8?B?MlZaSUh2Y0FyZm5iUCtSWTZGa2tPc3FqemMwd0krYk9GT0FSaDJHNFdXWnVL?=
 =?utf-8?B?YThtV1lnamZpd1RPUlhBL0N4eHZiWDNmSzY1UnUzWXVIcnlRSWVIaFlZeGYy?=
 =?utf-8?B?dHJqTmpSWUdPNHJMZjdGU1EwMTVMM1ZFQXdUWE8wWDJldCtkd1ZPbkhiUzg3?=
 =?utf-8?B?aFhmSjVva2k4K1Jqc3VDU2JPQmQrUUJBQUZBKzBBVXdYdk1SQzhjdTY0KzJv?=
 =?utf-8?B?NVIxeE5idDkzbys1UFBZbFhvSG5weGZsTnlUREFvNjkwRk9CQ01DbjhiWDkr?=
 =?utf-8?B?RlZ3enRnWkRQY21jMUNVZ3FUMEtzOVdaN0MyRTZzaXdaMDlzQzFSVDVuV1VI?=
 =?utf-8?B?Y2pZWFJVSy9BSVpZSHZPSTUxVFJrU2lnWjJFelY1T1YxZXNpN3E0aU9KNW9M?=
 =?utf-8?Q?0/TH1TuspQ0ycSIPymySMWWOG4bDqSoLnghLYZ7aQhv7Q?=
X-MS-Exchange-AntiSpam-MessageData-1: zc8IAWls9WGtEw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85fead15-deb6-4489-7e7c-08ded910e59d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 14:39:33.2779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVCu6ESRzOEl4bh5QrvbdMcUqZI/7tKzU/wOFa4yB58hG+dN+Y1Qc8ddoBj5f22dAbGNZXkritbGRBb0LzZrIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9530-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9562D70389D

On Fri Jul 3, 2026 at 10:50 PM JST, Gary Guo wrote:
> On Fri Jul 3, 2026 at 2:14 PM BST, Alexandre Courbot wrote:
>> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>>> Implement a `CoherentView` type which is a view of `Coherent`. To be ab=
le
>>> to give out DMA handles, the view type contains both CPU and DMA pointe=
rs,
>>> and the projection method projects both at once.
>>>
>>> Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
>>> method to erase the DMA handle and give out a `SysMem` view, if the use=
r
>>> does not need the `dma_handle`.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>
>> Of the Sashiko comments, the second one (adding exclusivity requirement
>> to the safety comment) looks actionable; with that:
>
> Most of the text is taken from existing `as_mut` method on the full `Cohe=
rent`.
> I think these can be addressed, but I'd prefer to leave it to a further p=
atch
> (perhaps as a good first issue).

For this an acceptable fix would be to add a sentence to the safety
comment of `as_mut` saying that the caller is responsible for ensuring
there is no concurrent access - I suspect you are talking about
something different for a good first issue.

