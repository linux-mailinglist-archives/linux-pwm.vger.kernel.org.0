Return-Path: <linux-pwm+bounces-9364-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MUa4BZD1O2olgggAu9opvQ
	(envelope-from <linux-pwm+bounces-9364-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:19:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E99E6BF921
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 17:19:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=oFjVYAUq;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9364-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9364-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D4B93042433
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Jun 2026 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF203D9DDB;
	Wed, 24 Jun 2026 15:09:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4383BED75;
	Wed, 24 Jun 2026 15:09:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313759; cv=fail; b=pOlcMkBHxaf4CvYz4UK6s6LYbdL6UzCb+4jXX9VNhFjFrMRynlQ0mkeot3eNzB2A4P737TxLvfmjUcuxuqhg0UInN2fjxUIUAGANsIR8T/0uwSIkSQIL97FQWujpZJXRiuTmQ1FyR1Aj5F3rF1Uj2mYjKhrhsZks/4Y8+UA/ypg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313759; c=relaxed/simple;
	bh=FZ5JMC7OXTI0+HvM+xQ48JPjp3ncy9pv7Pm02JlhR40=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=MPTUyWcEbwZ/JiqH8Yi02zD2V3yOzXUAYkI9QpiTjmv3KMyGpeJijIwV2l3xSZwhMQhOKJsVzQygS9sVMDy0u0aEXprDYkb14eTiHEomx+NR2bpwCFOrbAC2Sic4evHpxRzlze6m2V2Gc9EptGxgi78Cisea6qaNUlgHvgI2zEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oFjVYAUq; arc=fail smtp.client-ip=52.101.48.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=an3pASijZW9Fj2TzY1MI8Y18z7PXfAVfwy1ugzMprX98eKAPaVfMQo/S33I3HzcgpQKHIyQQyXyPCDzKf3hmXFGXoppgdtLgKaF1U39rHLOoROjzVmE3NcKErH12Jc+OwerkM3OaAKm6gS4mrNuE3RWiOSSdJzNs4olzU88V7RCt34GeejbIuZW/Cj4QASZmZOmUFJUmnDEj4PA6a0KGilf9K1BGh925pms1168wo3vsqgAhKpSJdfTt2pc3mPW/0Ui1BLLrn5MR4y64WW3rauRSrNZt8cuJokpy2LP5Mc9fJo5j8bUJaoGas/kGdJH+5yYZPf7xH1g22/pgmdOWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZ5JMC7OXTI0+HvM+xQ48JPjp3ncy9pv7Pm02JlhR40=;
 b=R7O/SSYHmRETS8ve4KfcxYNz5xfusNOvgiT4u0VUX9inEqB+AzkFPrZaRaGdkSKtAlWfWYlpPxm0rVocvyTdnk/DKtq4JjbLLjg9Yr1BKUJYO6K5p8TLUCmo3MfechmKw3Dr6FQcS0qn65k1sJ76XZOYmchPr06VO60MXYyvPnw/2xkHxv2io9qS25wOV+CO9UZi8Exs5SnvIqsLLBb1fECK2VEIoTYS6SQTI3nkh1Nf7DfK41hQTfGvRt/RqX1WdgO4F/ZQFQgL5Ayx4MAK9gVSGHrRE0FeCv/EpAGZk7ApRTm4JuPnBP8Jeb2AsNJV1eLuA7M4oSEt6RHapDRVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZ5JMC7OXTI0+HvM+xQ48JPjp3ncy9pv7Pm02JlhR40=;
 b=oFjVYAUqDIVgZUJbyjOk8Q1bKhYowYV3M0e5NDpDwwrofd8ofVdXLRjxC1nkNkIBIHtVqMedC06bc1uRWDO+UdJYCDsZJhAr+bAUB1/iNHmyfcHJ7ITbJgCd3u4XitWfxicchHl9Ws5OSjjcXwB/IBtL6ckC6uLllAJI7ehdnXpb8WpZSawiDaY4PLe7AXbR+EoHh9K62ayI7uZcGqFcx91xpZ5I1v/2QNAXXcOOmKO8j+O1IAasGLzIOOUQzQbenRdEOFahKFiNciiNf1UOuBJi+5v4//nBPCXAdTHApsYZcW7a6MnbgRrgS42788NgkkvsNxKQIXu6ZXulUeWlsA==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 15:09:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.013; Wed, 24 Jun 2026
 15:09:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 00:09:06 +0900
Message-Id: <DJHDHRHG5D74.398ECXKGWS140@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <ecourtney@nvidia.com>, <m.wilczynski@samsung.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] rust: io: mem: return DevresLt from
 IoMem/ExclusiveIoMem::into_devres()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260618230834.812007-1-dakr@kernel.org>
 <20260618230834.812007-8-dakr@kernel.org>
In-Reply-To: <20260618230834.812007-8-dakr@kernel.org>
X-ClientProxiedBy: OS3PR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:604:db::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 48114afe-c3a4-44f2-6858-08ded2028b4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|10070799003|366016|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	0ApyNlWT3uF4Kt7a0/EOB0kaYInjMMbRgmFd1qcRrlxvAaaMK6WdCmFbu6Lwx4btkYshkfGk1aR3snhX3TNCdBOUOgDno7jIiqwoMB6MGebvigCkdyjqaU2vVk9qsLcbbIJZ2ei2OUCBpI2VTX3TrVj1g2ME9XlCQ9r9NYyUq2Ho8M6lhEvhYfI+23CsS3OBxPLmUJIOhqkV0Ypn7G1KTOFkZEDqU2wfUvghd9dq8es/jUOSUOGHPV1347vPja7xHFiq/sXJb580xbFR21GKANkZAEaImBplbp56SVJuFJtL3mmDVB2StltaDQmTuAV+V4ldFIFDWBqrOQj56X6RgutmUKf117Bofs2KnFZzpi6NPeWXtOuAdBE+77IFRJxXwBWycVCPAKMLTGKq3NoC++TCnF4QhHPkgo0UsunoCb53Ata/abyVO6IWj7j/y4NFyqWY1K+JUf3B8eSewNdV5GgQox3ldwhc6jVIWRERYls2rf8Ig1NvQdEf2GnS+oL63qXtL+Z/aZfw6fuA3ywHVnYAn5HP1JnqfVRUWyrzBqYMSbMCIkzu6qAw+O0beRetkKf+wTGJPMXA9d2jitrLpdRkqafIEu2gSSh2Mbj9SAzmP+Nod213qmPTAarqmhDAnJ35lNN6hgHdtVoCtmr+lEiTRwTzcygfMv4o54e/Nc0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(10070799003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGpsck56cDlUSkJ0Mm5GWVNHY2xSNVdpQS9TYnhHTUtlR09TdmZJQVk0K2ZL?=
 =?utf-8?B?UElLakZ5QzdCeUw5SFJWYkpXRXp0UjFueGhyNk1FU1hYblNDdnVwTWJ5c29E?=
 =?utf-8?B?alNTdlVDQmYyNU4vMGhZQllJRzR0eGszbFdDRjI2by85ZGNqcFV5emFrSks3?=
 =?utf-8?B?Z0VFQS91V3Z0NmFXc0lxYjVPbzFUZWF5MkcrdENZdG5UaHZoclNGdkVYcFJH?=
 =?utf-8?B?SkErbEZGa0IvcnFKR0pZYUdlYWNwRHRvUS9Ma21UblZORVVwUHZVY3hFdUZM?=
 =?utf-8?B?cGFpNzVlWGJRbTc0aExHdGcrRVhsd0NiQi9pbjVJRnl3YStsL1dLa0Nta0cr?=
 =?utf-8?B?M2xIbkN1cE1VU1pYb1BlcXFreDRoZjJtNUhjdThLRnJHNzF0TURXS1lZTFhp?=
 =?utf-8?B?bXNDbjZiTEtBR2R1V2pxbTRLcllweHRDelF6amp5Lzh2SjNrbGtvUldyV0Vm?=
 =?utf-8?B?eXN3YzVtYXBKMC9kc3ZXZDNuRWtMNTBhSnVjL2VydUZxUVl2aHVYV0hJU05B?=
 =?utf-8?B?QzNpcnJqRGp1bythM3czYU5yRE5wQmJzUjIvZzlMZlZoWTAzVER0czdrMThl?=
 =?utf-8?B?YXZrVTd4Mlo5MnVZbkVWa0h2Ynd0S0ZyOUoxKzZPNGx6T2pFZUJ5WEZKYmZt?=
 =?utf-8?B?NkRRRjluTTdrREJFcU1NMUg1SVJYTGprV3A0bUpKbURnVjJzUTRvUWduTXly?=
 =?utf-8?B?VnJnbEpqSXQxd2w5OWFsRDhVbVJnM0ZEV0RkeGFZVzQrVnBqRnVLNDZhN1I1?=
 =?utf-8?B?dXJEeGtTSUR4RU1lSDVhdnhNMEdYYnppaFZOL1RsbTBRb2xGVEFUSkZTeFpO?=
 =?utf-8?B?cXRCaW1BUHVYMjE2OVQ2bEtLTWpocGRGSmYxWnIvR1JIbDgzSTFsQVZyQmZR?=
 =?utf-8?B?Z2xNazhzYnR2eHp3VlpOVGlJTXdHck54SmhEdE1lVFhhbllvSDBXcmJMTzc3?=
 =?utf-8?B?emVzdzFGNUtZYzAwdVYzTzRsUkZON0tZdE1wNzRjRWtwWDNHeHoxc1V4SXd0?=
 =?utf-8?B?WW5RWE9TTC9NUExHU1gxaUJSamZVbGhBdm9LUG9YMDE2RTAwRkh6Qk5QL0k5?=
 =?utf-8?B?T2hMd1hoTnpvNkd1ZHVCUWRvdlYwUDNNTjFXZWhPUFBBeGx6MGFQaGJjbXAy?=
 =?utf-8?B?cDBDUWh0VlI4OStxNWp1cndrTVVyQjg2QkNJQVEyRmdSTXZWUVhnWDBwV0Vi?=
 =?utf-8?B?VnhIc0hnZjZCdGwwYkRzT1dLelpIZWRjWG5KWjlNVUVhT2wybkJ1MlJWazA2?=
 =?utf-8?B?NUI1dytlVjVES1FvNnJ4OElPUFZlQkpzZkdVYzNONURzMkdYWi9zZWJPVkFW?=
 =?utf-8?B?WnlVOVRhVUtBVnZkcEg4UUZjT1dJcnlTUmQ0WXZ5UzdzWFUrQzUxeGVrSXVM?=
 =?utf-8?B?cVdHQ3llY0t0ZkxwOFVqa2wvcFFQL0RUV2lOcEpNa0dpaEhxZUdJZm9qSnV1?=
 =?utf-8?B?Tmd2RDNWV1lBbUlzemdvTjMwNXdyT1l5dVo4TEU4RFA4ZWNETDE2NCtEdkZT?=
 =?utf-8?B?bVRSQlBZS1RhdmszMldERHFXdFN2OUVtSVhYY05GbXErUUg2OUpMaythR0Ez?=
 =?utf-8?B?U1VoTW5QcDM0bEIwUlRmckl6NTB0c1RVQVg0VGlhUWNjNWxvWitHMU9hRDk5?=
 =?utf-8?B?RThlMXpvTlkzUWVwUmYrWFBXaytLSGs4TnVJTG9Mam1qVk44ZFFaWVFhRk5o?=
 =?utf-8?B?ZkNJSjJqeXo1U2JJaWw0RUdGNHdYV3ZrRC80VWt3eU9tOHdOS2xZM1MxWldW?=
 =?utf-8?B?M3lGZk9wdXN6QzBPTjJLL3lManp0WXdzdDI5Y2lVQ2FnQ3BpZ0Z3Z1NIczJp?=
 =?utf-8?B?U1pIcWdYVWRUNWFFbDVPcXNrNUVySTJiU3BWbStBL255emY3ODNjaVBxQnFu?=
 =?utf-8?B?R3lDaFF4alk4V1FtZVltY0o2bnJaQ1ZXSStEZ1NUTmhKaUp2N3lkUDM5bTF3?=
 =?utf-8?B?ZUF4RVNaaHAvdDlkUWN1VmdJam5ROVc5TlUrblhLNkFHa2lSb1c3K1pVVWQy?=
 =?utf-8?B?WjV5R3kzVDVKTWZRY1Z6WkQvRnIyVk0xQ2VsaUoyVnltSkljNnNTMzdodVdx?=
 =?utf-8?B?ZXJvd0VkTkN4UVFrTkpOMlcrdmtESlpHeUN2ZXpvdUd4bDZsSVR1MmR1c1pL?=
 =?utf-8?B?eS9mM0tZeURvNzZQUU5tdURJdmlGOFZHQTE5MTA2UHJlcGl4aDZJT0Y0eWlk?=
 =?utf-8?B?dEhQU0dHU0h1d2hLT1FmL0RKM3lTc1d5aER0aU9DKzNFYUtJeG9peW5oeXdS?=
 =?utf-8?B?MGJWZm8yNnpJWlpMa3NVYk94UnlNdmVBYXJLNlFabzM5d2cvMFVhcHkzUEta?=
 =?utf-8?B?YkFYdE8vUTdTbER5dlNYZHFwS0gzbkRDeFR1UENKbFJDTnNTRUh3eC9TZEdy?=
 =?utf-8?Q?ykexRbRAwIb+6cdVa9YKurF33+r7R+qDfrvcFglkrOfCd?=
X-MS-Exchange-AntiSpam-MessageData-1: jWvVSBhnk6CMfg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48114afe-c3a4-44f2-6858-08ded2028b4e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:09:10.4269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94WYs1ZBR0Td/HTTF6kpCvNcJD510OBMVPh+OSraHekyL1p8Ad22nraGT1apAu7Dx/WwdGzzoUt+0bXsa5BDKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9364-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:ecourtney@nvidia.com,m:m.wilczynski@samsung.com,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:daniel.almeida@collabora.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:dakr@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,samsung.com,intel.com,collabora.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
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
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E99E6BF921

On Fri Jun 19, 2026 at 8:08 AM JST, Danilo Krummrich wrote:
> Implement ForLt and CovariantForLt for IoMem<'static, SIZE> and
> ExclusiveIoMem<'static, SIZE> so that DevresLt can shorten the stored
> 'static lifetime back to the caller's borrow lifetime.
>
> CovariantForLt is sound because both types only hold &'a Device<Bound>,
> which is covariant over 'a.
>
> Since DevresLt::new() handles the lifetime transmutation internally,
> into_devres() no longer needs an explicit transmute to 'static.
>
> Add DevresIoMem<SIZE> and DevresExclusiveIoMem<SIZE> type aliases.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

