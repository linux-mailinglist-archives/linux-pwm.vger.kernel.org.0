Return-Path: <linux-pwm+bounces-9516-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2YSpGmlUR2ouWQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9516-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 08:19:21 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 071E46FF064
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 08:19:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=AIdKiHBe;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9516-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9516-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1458C30285D5
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 06:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643F2372EF4;
	Fri,  3 Jul 2026 06:19:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08312363C45;
	Fri,  3 Jul 2026 06:19:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059557; cv=fail; b=kYWaZ3u/PNrDUaOKvjq8S2E01eQa+aq5/2BtCPDo6n7Qew+w0ck10ptG5hQVfCbqcp7Qfst2ZKsAeRZmnfAdaOKs6UPTz87uN6977jLDFw0ex4DYBYBIseNrgU3xgYIAHshRkci5FeZ42C+f23AvblkcROMi9OYbPQEt72UkTQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059557; c=relaxed/simple;
	bh=okjagNjhsogoKt3zPvC+un0eYqoNn3f/KlsIzfKu4Q0=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=HFwxK+r85ahSMnEdZAU02TW3BVkB5f7H/9fRZCehv0zqoEgOS9FEmVPvtzbO8E5EIwciN+0KYhs0mJU5QU1Jif04Ffl2lBDL07iogyLVdDd/ZYvyWlmHGAtAN5LTnOycQttFqSygCGO9b+ph9JTwyHQL4kwVrvSP2ozLKcR2GXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AIdKiHBe; arc=fail smtp.client-ip=40.93.198.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/R+W7Bh7br24KyzzxyC+LxveYgTFqcfCw5tduN3cYqwcW3v+gdeCWgzBkvfvUjYiPjC3ULejBoR3nsV+VQgc14N8Gp0+fcZ68XvPbYG0teEmiwefy0z8+O3lDqE31/HxDyQepG4yOBjOQwxIlmx0Pr63DogjdReDmSLKRjhZB8bUJBSuaDa8aCOxjvnDu8Vk7iHOTOd/7jNrG0lnggsP3E6GZCgiT6utnBObfbN/JQUZl1IuCAUhlOW7JdUpRrT3MUIf0tox1CailbB2Ig+p3/19CPqvZaeeS5UP1Uu2qLSTOji4aMVJfLbE/GRb30umdBNHXZsIpykSi0/PVJIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDFfVohsPRWmWh8GnF2jTQrhecY/sBa50eVtx1j3Vg8=;
 b=xmwhis0i8vIRaazwtog4hlGUyjeivYEOsDIMUUrpVlUROjrzcSqQIGgzO/+dUQkKzp6ZQIjJR9vBgn4w02ykRmxWrlZRuNKRQ5eKGQkNsP6QFc38PLvfM6TsFq5EnvVknaX6KXA2WD01rwIOodi0FrhMqyywifbRZh4tzF/Mo+b9J7zF0FuD6WmGchV96ttVhZbT85PiMTac08Pve7XejentqjQNvECcUBOdLSgVTKcJpXhnSH1mIU6wB8mD/9saX+9RsNui1q3cRF4QiNkBySOFSUdGzf7HkjwVyEx4m8FhsZrr2OIK582fdr1sW4MohBCjmPtvqxDZc8UnJQdF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDFfVohsPRWmWh8GnF2jTQrhecY/sBa50eVtx1j3Vg8=;
 b=AIdKiHBew1gffpQo3lwxiOVClD6r0cZ2fbivkwBxBJvKuUuYi6Nzq2jqp4X30Z5tXpiEC9/lN/19rH7HS+s8Bsxb7ZP2uQN8xAz2ljMZ9Wwywu+V5EePph9fR6xwo6z4UZVtE0gAi7/unAM7JR52Qy4TajQS74r9+/gCQvDdzFyQ27F8nnWxnsfHXNK1sUtjmhz3fmKhOYsAF3RVWxq8stsFpHudJ110LbdrG85PDfcQyJ04nfrCW7e2wLbESVnMB5aFJ6cPw049Y3+C3xK2LCSKLjPBmK5fRB/rvAZNvWhVWNZnNn9oHnIPxI+2XolMMiWriUtZi7l1sL3aL1nCLQ==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 06:19:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 06:19:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 15:19:08 +0900
Message-Id: <DJOPUWC8C7GU.29L05GZVLOLO8@nvidia.com>
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
Subject: Re: [PATCH v5 12/20] rust: io: move `Io` methods to extension trait
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa36823-b485-4973-c4ef-08ded8caff57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|7416014|366016|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	QEtpnEmNaLODU3NolKxLIxonoceT4WlUznIRHqwLI/Bt1eQ3NWpWIJcn4aIAwq4UKvevkSxrlRFHLNpNXU7d1s4dNLocwPICgki2SGearP6gSn7MQvp0N5VxjA++7AyZt81YdZBQdA/jqJhd+q0ol8YzpmCNPuqge4p8KKCO3OrCoPglSNjc53lb55/cLO3j6lZmWemI36hF6Eo+Lm8LIyD5kwHnSairWokYltwK5CQMuy75+6hNuloxjxMTVl5VaWidAQHgP5cILyswvZZdWXjpJ7xxVbiGiBdVYZ/80vpSlwRPnUpigcGUAQQ8uWQphFOjr4IJ1VsAT8V05mjH45YZ103PJeSQAwWV40V72EqiSF6VcJxPd8buLj+1HSGPTjpFodIl+AdDTyGEWB4hbKpa1rFwPFlxGleBNHWVm2WXvanN3zWmx/39Tx7Ozk0qH0+DRbWQbbV/Afua0cYD9DCrIJ/UrDxk6SN2i4GS8J9jZmOG997ds22o7ljeKVCacJuwN095qc+HXrsYgnOMRNXB670xroZZl4VQsykGiAqLh4FZ+iFpUAI5e0oMjK5HBddaz1DcZhp8JBVldbYdAJJNsuMwO7w1v+nidK61kgXKFQBIOpDEjjBgj7kbvI3//SFKvwSLs7KuiYGUeVNSW7krGPB0vn2XVSiNeVLzWkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUF2clZORVB1M3d5UTVlaTNpTnBRdXB5d0RVbTgzZHhBcStZcXB1cEtGS0ZK?=
 =?utf-8?B?cjcvQ1FoNllUUXJjRHhMS3FJOGZNUVNPYTVMMVFXaWRKUlBwM0krUVRFS0hZ?=
 =?utf-8?B?VVZEUGZrTHN3UzlGSHVNcVNiUGxMVzlzbGhCNkVJOVl6ckwzNFYwK3o0S0pO?=
 =?utf-8?B?cG91bXJ4R3Q5TE9OQTF5cTMyb3ZGRERRYWtFOXNvMHNINFh1QW10Zyt1NW9j?=
 =?utf-8?B?Y3pxOFZvRXdncEFWRC9ubndDNHg5MndTM0pSNi9zMGphb0pUbTZXQjFqeTN0?=
 =?utf-8?B?TUJUR2sxbk1wbGdlK2x5T3c5eFZwOWc4UUhYWVkvWWFxcG5MaWdraUVubXMv?=
 =?utf-8?B?bmJGZVM0TXE2WUhOSmRCa1c3QW1VeEhFTkVzYmFFVmUxUTR1MXp0YXdUaFFO?=
 =?utf-8?B?SVBwWXRmZVFUaGFIeEJ2dWkzbXNFdzRYU3hCTnNGYjMvcGRqREJLQ3NmY1VG?=
 =?utf-8?B?S0RvNzFEWDhZVFZjK0pWSHNsNVNmdytzZmF6d0c0c0NpRnpWNFl1NkN5V2Rk?=
 =?utf-8?B?V05oOEsrTWNVaXZBUGlTL0ZZaHdyMFdPVlpsQmRLeE1WZDRLQ25jbXNsRWxl?=
 =?utf-8?B?Q1MwSHFvRGhvNFp4ZldTTG5oZStQRzFXcXJDaWtkMm9GOFIxT0I1WUttekh4?=
 =?utf-8?B?aVJmTm5ZQjVvU2hBVUNFcy9OOGg1Qm5rZmFzaXlma1hJa2VkbmNGQm1Ea3FI?=
 =?utf-8?B?SHZSdmswbTZGbE5kbzg4MmJKM1JYMUlUanZsOFU4Ui84OGdnd056WG9MR09H?=
 =?utf-8?B?YW1xbVlacVZnRmVUZDNlTWJJdENaR0k3ZmtQczIwQ1dyOUZ0Qnd6cGVzWnBN?=
 =?utf-8?B?dUpaZWZRUWxMZ1N5NnZoVGZLVlZ5RmQ5cDNLOUZwSC9IWkdMbGl2TTRQSWlN?=
 =?utf-8?B?ano4RGwxVzhlV2YxdkZLWVBzK1p3MWtUb0xZUzZwZjRNdkJjK1N5RlZNUVpP?=
 =?utf-8?B?dERlckxuN3FBRjMzbFlDRDh3NFEvQ3E5SnhmZHRBd3JGbURkc2xtWnJKbXB2?=
 =?utf-8?B?Q0hOdy9uOHdMNkZRWGtyTmwvY2xwNmlXdDRxZHpkU3c0RVBwbVgvNGZyKzNx?=
 =?utf-8?B?enJiNCsrSkVFeTl2WUx1M2d4Qk1xc1ZXTldDZ241TmpCUUpBZnIrVXgrelVs?=
 =?utf-8?B?bGcxM3pDbi9YcHNoaXN5VkxsVnZkTGxtMWhqb2IxODJkbllpeXRnZnBuaWo0?=
 =?utf-8?B?aXRXTU1HTUorQ3lUa3huZWxxUEkrNVhHZEV0L1NEOEZwRFJwUXV4bDVITnh5?=
 =?utf-8?B?c3I2c0dXQmtPeGF3bW5jR2JMR2pxZElJMklNY2dLODVjQVo1bHlXamFXN25k?=
 =?utf-8?B?MWh3LytWdjVFaWlJQTZoUTJLNHRkU3NBQ0pSeXl4S3NoQkNyem0wSUdFKzFt?=
 =?utf-8?B?UDJwdkdPeXd6a0JlRUJjb041dFdpUlViMTZHYVRNbVVPS1RPSTQ2VWJIVEVF?=
 =?utf-8?B?WXowQS90cU1XZndyZ0k1TmdveDcwRFB0UE55cmtnZGtvQzRHVGsyVnBMZXB3?=
 =?utf-8?B?SE1jeGJwUldSOERVUkEwQVNoTlJYQmdXRjkyMnozY0pwMVZkcXl1K01pOTgv?=
 =?utf-8?B?WlNOSGk4MDFPb2JxSGZZSmhYczl3VTA0bFFHcnJmaHl0TUxjckF5emNjbFJS?=
 =?utf-8?B?dDA4Z1JvUGswTGgva0lkb0ZFMGl1Qi85S2V0Nnhua1NUT0Mrdzlua21jdUxK?=
 =?utf-8?B?ZWtQa3NWdFRvU05kMFd3cmt6VGFWSjdVZGdRRkZYT3MxZDF5a1phMElHMlNZ?=
 =?utf-8?B?NSs4bTliVitGWkVYZHJUSUpvWFZDOThBWTB3akMwUXJWRkx6TE12YzJGTDN1?=
 =?utf-8?B?L2xHYTJad2I1cytlZ0RHQWdEN3hmRjBlZDdXWS9BdXJETlQwdDlvOGVEajBo?=
 =?utf-8?B?NytsdzBVZlVUQ2xpc2tkZEpNMStyMGJjVFpHU0ZKTnI0WUY0TWRCU1VFd3g4?=
 =?utf-8?B?eVlIYjYrZUpjRlVLYThpdm4yN0RNUThRb252RFJqR2tHNWs3UldacWlqYXN6?=
 =?utf-8?B?VCtFZVBSb2tlR1dDTjhKbTltSnh5QlVUbDJVbTR6cGdGbVZoTDAvV2lrYlcy?=
 =?utf-8?B?S3RVZkFyWWJkUFFtMlpEMEk4UzZ5eFNMVFgydlFpSFhuS0FWRjdVVWRwMEd1?=
 =?utf-8?B?RXd4dElXTUh3eGRoeXV6WjZOZDZOMWxGNXY3azc0WDJ6YWF1cDhNOXNIRTQ4?=
 =?utf-8?B?V0VrSktZVEczNFVJL3luM2hQMDVldmxWRXJpRmxZVUI3UDNPUHVNY1B0b3ln?=
 =?utf-8?B?WlRnNk9wK3lGU0l1Tzc0b2UvTHBwZmVkMU1kSFVibWFoQzZSQzFLVU1KUVg3?=
 =?utf-8?B?U1d1cHo4RzRtcHZ3SVArekx5WEs1clBobnFrZ25kTkZQbjM4SnY2ZHhTZ0k0?=
 =?utf-8?Q?5Od7fOX/GMkMLii/bTY+Y1OD8uR84ir3wVQapQj3grvbP?=
X-MS-Exchange-AntiSpam-MessageData-1: 76if3aCcGcxZoQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa36823-b485-4973-c4ef-08ded8caff57
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 06:19:11.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGwdNhVj1CnJQt4Xjr7Lsr1YwC3XTS000WRfNq4QQ9laTtREOTak6eGDlurgPJLkNPJ9bj3XqUIJecyqdHSpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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
	TAGGED_FROM(0.00)[bounces-9516-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 071E46FF064

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> `Io` trait now has a single required methods with many more provided

nit: s/methods/method

> methods. Provided methods may want to rely on their implementations to no=
t
> be arbitrarily overridden by implementers for correctness or soundness.
>
> Thus, extract these methods to a new trait and provide a blanket
> implementation. This pattern is used extensively in userspace Rust
> libraries e.g. `tokio` where `AsyncRead` has minimum methods and
> `AsyncReadExt` is what users mostly interact with.
>
> To avoid changing all user imports, the base trait is renamed to `IoBase`
> and the newly added trait takes the existing `Io` name.
>
> A `size` method is added as an example of methods that users should not
> override.

WDYM by "an example"? There are already all the I/O accessors that we
wish not to override; this looks more like a new method is just added.

Besides, it is not used until patch 19, so how about introducing it
there?

<...>
> @@ -326,6 +323,21 @@ pub trait Io<'a>: Copy {
> =20
>      /// Return a view that covers the full region.
>      fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Tar=
get>;
> +}
> +
> +/// Extension trait to provide I/O operation methods to types that imple=
ment [`IoBase`].
> +///
> +/// This trait provides:
> +/// - Helper methods for offset validation and address calculation
> +/// - Fallible (runtime checked) accessors for different data widths
> +///
> +/// Which I/O methods are available depends on the associated [`IoBacken=
d`] implementation.
> +pub trait Io<'a>: IoBase<'a> {
> +    /// Returns the size of this I/O region.
> +    #[inline]
> +    fn size(self) -> usize {
> +        KnownSize::size(Self::Backend::as_ptr(self.as_view()))

nit: the documentation for `as_ptr` says that the pointer "should be
used for projection only". Technically we are not projecting here; maybe
the documentation should be updated to say the pointer must not be
dereferenced instead.

In any case,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

