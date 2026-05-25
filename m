Return-Path: <linux-pwm+bounces-9095-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hgzKBVbOE2qyGAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9095-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:21:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8435C5A5F
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 06:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC00A300822A
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 04:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1562820C6;
	Mon, 25 May 2026 04:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cboA7WdP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3582772D;
	Mon, 25 May 2026 04:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779682899; cv=fail; b=N7aVIzA3XUP8YlOtPa28I9nXNFjPHhq1c+AZmK/HW0xS1MklhY71bAysmiURLkS6/AfYR17fCf2ooYaivjZ3laRnU63eF11lgHI8FF+Ds0a1RD2HFMoMqwgAjGAQw9F+rY7kJIxNh0xWu5Y/xWZtbKFPagyM1B3VQTDPknSZBQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779682899; c=relaxed/simple;
	bh=CJ4QiI1EHXk99SipMcoKmbuR9hWoefjcoMwZujpaaHc=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=qGoz/9GVkKeHYP8/0xGOWHn1X9MsML+aGczuZUgZKXqVL+MpszK+4ChQrcVJ1osqF8kAW/qgHS2EiLqvNguxHQSE44Br2Uy65FpSEQS6qI9GGLxqrtRSFN3W1/3kFBLpS/a9JbkIj8NyTKTGgk7tk+kJ3ZDTjGtRLJ2g7sBg0bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cboA7WdP; arc=fail smtp.client-ip=40.107.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6ngj/p26BUlyrpQVrla0+RqkK2vG0/F2Mtgdn0MJcw1rEoPxnsFmjr6NoPdQ0pId6QCjVv9jdIu3lLYJwZBKM4bwf7ZlaJ2DZq4c1V8lSZgST7rpc+uGFUKHRSysYPA3qNa6oG+CspKKq5YS+f+Qrq9rwz6pVo16nEoI7BLDAKvbzgY6Bi5uzQ3/ltPPYSG23pheXvr+FrbmqZmSG4/CRNuTuOmAXFYi2XywCY1sTXM7GLbPO7yENAoH6tPsRgXVgqpHxKYmS+Zvap8a6Co2Nso+mraC3Cl7+tB05Dion0Q/F/VrW2Cm40rbDeuUQQ2MwDun6ZN1FHk57FxxLgNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ4QiI1EHXk99SipMcoKmbuR9hWoefjcoMwZujpaaHc=;
 b=hD2S9rhqCb6ilL/5nwldq3IpJKxsSkOmMbM74qMYLEz5OLlQjIRfGLXlw0AcI8YDH3+Bj23N+giA3mAhhHQSt0a10OPr7Aotw+PQa6UNrLxOycFMIbc5+apU0o8ZdagTgnm89dygTmjMDqm+Ob5S0qPtGjp0sg/Phbqf8+xTBK5KBXj6r5GmEcHeu5IGrHluznf96VmsY6baDTZGwXOuemKYVlMMOq0EzMXv+56E1MtgHt0l2Rd/I32fSxpcPObWXno/yBOA1W11/UIctoTv4SZDfuJscT31canM4Xq9JAcFdZYBTRh4m5Z1QGCj89elTP+EWu18S7AVVxSe5fxucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ4QiI1EHXk99SipMcoKmbuR9hWoefjcoMwZujpaaHc=;
 b=cboA7WdP1mzkB5qRBnnJt6kKsLoTddx5copCbNRruyqUFcp5Y8pogNYgyQSo41Eikh3vI8ZDoBJQ8qox1Mb2NrtKpuvrrm2V3cOLG7qqYjwxGoj+KTPA6j4P5+cvG5ng9xXbqtU8O9mujdMx7mO6sajugSBb9w6KycJzgP+UPPMnTikNkAJUcV4Z5mkj56FvC6+xbnKfXGfyPNJ6ygAx8tBsMTQSysv6Nt40QRS0rr7Nxi+DOwU1huSNmZ3fiAtWa5lilzKrFNm8Jo/0zf/9MEFezqH+Skdto81i77ze2vclomB1OcraWmGUmOGquOYdj+03JIB89M3tuEzWFM37yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Mon, 25 May
 2026 04:21:32 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:21:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 13:21:27 +0900
Message-Id: <DIRGXJY8H9P3.3RJ7DQ85N8FND@nvidia.com>
Subject: Re: [PATCH v4 10/27] rust: device: make Core and CoreInternal
 lifetime-parameterized
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-11-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-11-dakr@kernel.org>
X-ClientProxiedBy: TY6PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4ba763-36a6-48f5-544e-08deba15197f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|921020|11063799006|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	N70D2OsC2CVzDIId4IqMbHetUhlBrLGE7wbGIx+EZoYkovtlvrzEvy/tsXZJb3Y2zHzbPcV42onNkTNJ1D2ifRbLFb/5tv4pkDAQbC78hZiQOac7+AvY+kWsRh107KUr0wSimXAcsgZsZHWP+4fzODwIySc8Aiwbi0wstY8AIRSGtVDa6/coFnm9q2+e8TT2SeENlZTXZ6JWvD+xmJoRrBseCJ5uYeW4zgqQaD16l2Xhh/N1wrR98kc0T7b/nzGth70iicS3CJmI5DXLXe+WiL28rpq3paT4b+YZyEym70Ss8HWPpborNXTMiX3609cVM/42trv69xEoBmRoMSw0Of+MvAEb3zVySD4QfkU/GWmRAZaJVSNKAK8Tfff5qrLsjKjx6hj6ZD379dRBOTzf806Ufg/3u7wfdazcl9rHjQSmxdivpi4NvG22/7uzMfDiGQkN4LWUe82w0aTqaN0KcxvIzXbQSm5HrWmlRQomWsVThuBEtiaz1GVz80v8qw9fsLbXFxgZgsotLlMGbPXLnP1biZZnE0enDWTOGiruxybtZrNDb/PjD2+1V15MEitpi4uORN4aMdkXtxjvKWmP/i8yAhCmcH1uiYHDuktraaXXebj0q9pStAUCVyr+ZPrCA32KTUcjt5awrOMcKoq8U/tuIOxnZY8eNwmZN61wzl5buF8V6qCg/s1f3Czax6XJAotXsP+9XO2zfwUCXccllSosPbuj2zbk49eVNcVK3fQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(921020)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXlIcmY2Rno2djU0UGF3b3ljK3h6NDB1citZWmxkVVpmdytFd0hQZ0lDZ3NN?=
 =?utf-8?B?L3JBYkp4QWs3Q2p3RmsyWW8zY3NkRnVwdFBtNVB4S1NncUlSLzY0VnhyUkJw?=
 =?utf-8?B?TGJjYWVQVkZ3M3l3U2grUmVIYkZmTGN5bWNNWjQvdHk3TnRpWEl1NDVFVU83?=
 =?utf-8?B?dHhId1lWVFV2REJMM1FqZkxqei8wMTBvR3lyVU9KRTZ0OWhPZ3hrbXlqNDJw?=
 =?utf-8?B?TVZwdUpjOHk0UE14anlqb3FkcjA5VXZYNGNDVXprR3lUWnlQWGViN1NWOTU3?=
 =?utf-8?B?Ni9hQ3N0cmNONFZ3d0VnYzdZMDlTWjJmZzMzR3ZtWEcrcW9DalJmNUY5VXJV?=
 =?utf-8?B?MS9NNk9idXAwZlVjU0N5b3ZUZTNzd1lpMHMxS1lKRnA5cDFTZTVYTjRpVFE4?=
 =?utf-8?B?Mnl4M2JOZkpuT0pVdGdUOXQwc09NaHR5bEZ5b00rTmtLUWF2aHBiN2xWNlRO?=
 =?utf-8?B?UjJaK1EzcjFkcTdpUEZxUFlNeHcxMml5UEdaZWhHeGR6ZWQrR3BWeG9Da0JQ?=
 =?utf-8?B?TlhQWDRmR0JqUlpYRFkwT3NSbWh1clg1NjlWQXNXbkpKeUFpT3E0TXNHOTNU?=
 =?utf-8?B?cGRNVVpBOEI3WXkvalNqZUNqTXg5YXZVQ2llMVpYUmtYb1NXOWUrd0JTdU1S?=
 =?utf-8?B?UWh1OXkxaWlacWxRV1c3cWROMmNBTXhCYlcyUnpKN1dZZ3JEaEtiUGkzL2Nx?=
 =?utf-8?B?WnlOMC9LV1VJQkpseFZUN0VnTjZjUDlodnNOSXZBNjNEcFBzWXY4UDNSdVk0?=
 =?utf-8?B?ZiszQW1ZZlJ4M0QvbFpMdHpWMFJlemtDeGk2SWhKVDlXdnZEYlBoUWVkVjlR?=
 =?utf-8?B?b2pxQTR5d0IrU0hXZlVxVmFjRU1TbzZ2bkZMNmpoYi9LUjdqVWxyTFFuSzhV?=
 =?utf-8?B?bWVQU3l6V0lZbXBITzBid1BhbWp2TWhKWkpSS3VocytZL2pTK09kU09FVjJt?=
 =?utf-8?B?SlBZQXcrUk1FQVFtbnNUY2xGRDY3ejRSNDU3VlVRRUxRSzY4ZXg4Ti81ZUFn?=
 =?utf-8?B?aThpa1FWbDVqSFhDamZUclhpRkNCYkJhaHhKbWZEUlRQei94L1NaTGJid0Iv?=
 =?utf-8?B?T2JxenR0QlpaUS95ZDZXc0l6MU1oRmZabjEzT2hzWlh6WFpydXQxQUlGTEg5?=
 =?utf-8?B?S05BWXp4NUJsb2dwYk9EeEd1VDdjaWY0UjAzV2JzazZtNTBrZlNKamFjbDAr?=
 =?utf-8?B?R1o4QjBmVVlaVVdFMVhrWXUvMEJjUkxjTU85YnZDZy9zSENJNUExczFha3JQ?=
 =?utf-8?B?KytCQndnMm9UbkFGNlVTQnlFU0hUbXdHSFpubXp3bnVxbVhSREw4SUp3RFZk?=
 =?utf-8?B?amdSbjNmMjBvMlFDaHZTZVdValRhRzg1TXNYRDBuZEhwQ1ZldGtiMWdCTE5C?=
 =?utf-8?B?eVVLeCtnUVF0d2J3ek9oa2ltZGo2WUh5b3VrK0VQZ1dwNXprcnhxRnVYZ3Uw?=
 =?utf-8?B?Z0l0YW1QaDMvWlJ4UTJDNEIvTGtYNUFjeGtRWUhXcDJqZVJyQzYyK3hxc25s?=
 =?utf-8?B?VmhaT0lHYWVKaXZsWk0rN1dETW9ZSXhoa3Fvc2xESDRsc01xam01ZDErUTdG?=
 =?utf-8?B?K0VKNHV3SWw0ZzBISW8rb2hlenJ0UDRyWGNmZGZ4UjlpREk2Z1ljR1M4MmRX?=
 =?utf-8?B?NHRqMDd5a0hjTXV3ZVl3b2JQQUNod3JOUE42OEV4VC9SbXZrRFUzZDFpOEFr?=
 =?utf-8?B?d2pJVEc1Mk5nVkhWb1dmM2NjSHBmYmlIam5JOU42SnpONGRENkNqREtrTjR3?=
 =?utf-8?B?Tk5kdGh4TFFGNThWYjZtakQwV0FCWjlrUmtxejgrUFJkMjFUMktaUGtnbjRm?=
 =?utf-8?B?VDdzTEFzVmdVRTU1MUJGS2tSS0RIdkFRRmFscDhIRWphdDZFYjNIOXhtMG5N?=
 =?utf-8?B?U2lUNy9sczNBWDNvRjFFbGdSQytoNkIySGxCRXQ1cGNrM05BS2c3WEIzeTRC?=
 =?utf-8?B?NW1SMmZQSkU3S0J6SUo2eXVpQTd5SnFTQjNuNmtLb2xzb3ozazFtTmNkYTFs?=
 =?utf-8?B?eUo2TVBya3BvaWFtUnkwSGdHUEhCajV4NWErdGVaK0dPSTFEcmJWWHg5RVFi?=
 =?utf-8?B?dE5ucHdWdStBQmtVM1hWdVdxa1Y4ZW1VVUl4S0R6dXVUOEpNMmxTcTJZR0oy?=
 =?utf-8?B?clpGUUE3Nk5hbitRNlpsNzkxMTF5V3VRaTFLVHlBdWc4elQvZmpzMnRNV2V2?=
 =?utf-8?B?MGNMbkJHdXlPRGVFeG1vNngyMjNMRjRGdGp1QzhTK0g0NHFvY1AyRXpUZEEv?=
 =?utf-8?B?b1ZZdjRiS2dpUkRqbG9rbWJRcjVZUGlQVUJORXFwd3p0amJVbmpxNGpDSnBq?=
 =?utf-8?B?eXVBRzI2S2czVlc4WEFlVFBudFJmMHVaNTZFMjlQa0I3VmVNMFMzYVV4TFhj?=
 =?utf-8?Q?fGt1kVeWKrWCl50gxwpcXpjrECo2nVtn1HUKJ2YKHJzoY?=
X-MS-Exchange-AntiSpam-MessageData-1: nMURDZx0Ddx/PQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4ba763-36a6-48f5-544e-08deba15197f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 04:21:32.1651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k53tiKL2SMCCAMFmDhXW8BtMuGhtBTR2Fq+Vn/36kCzD2x6iN4RxkKBOVM7rCbdqquSG3PuEne/1fnt2+6e/qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9095-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4D8435C5A5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Device<Core> references in probe callbacks are scoped to the callback,
> not the full binding duration. Add a lifetime parameter to Core and
> CoreInternal to accurately represent this in the type system.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

