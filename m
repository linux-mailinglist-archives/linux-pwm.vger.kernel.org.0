Return-Path: <linux-pwm+bounces-8964-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJBbBokpC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8964-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:00:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBF756F6FD
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE078307C4E4
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF92282F3C;
	Mon, 18 May 2026 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BbvbeQ2P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010038.outbound.protection.outlook.com [40.93.198.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36C2765F5;
	Mon, 18 May 2026 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116004; cv=fail; b=FyPKVPv83F6AgJ17aNfuB2RLkwz3IbzJR+OYa7Z+nM7l5wg3Y0DUd+bDSW4Hcd4pvLdicQPv6iXeIfGmNM+lQ7a79IQeI006bL7FEb6DK0D5l+WFCEtopUeV+akwvXrQfwVgIGr3VOcaLUHwiQ+9aLG9m3Zh4x/k7L1Erlbs6k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116004; c=relaxed/simple;
	bh=B35RqipkNxOcSMOjW13eXQn+/e00NZgRouRifmzPWRM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kMg3bRlTUEWap0z+4FuAtFHaOEOLoXWZrpHYyzK2UbsPxE/edwHGZX7mCLpGmI0oj0cXbIxrVO58a3+JY9Aho95jMfTdiUniuQePzj9F55mrPo43YjiU6zb6O7hkoQonWMzJYoJwSV2xS2rSRAj4GsVfXlrsOfJ7Qy7Ah8wAyCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BbvbeQ2P; arc=fail smtp.client-ip=40.93.198.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niP+Sj0kaRpe33XN6UsGNY2/5oGmCH4loiMuMHGx4YyPbsCJm7oBx6WzV2qOFhEV1/YMADQZiQ0ioR0nzuiNilNXfP4mUG39EioyAnP+K18MIykSq7tK1t1esrgbMg+8P70fMQiM4/lNLwJNq0YuWLUKDFd9kLzL0XZQzcEyv6nZUu1Q6/CfT91owklbE3M1XidUNQlh6HkeSNPT+P7KuQYVISljTvA/yKU2JV/PVVpUSr/U9xlxdHCXoSlYF8INRv/p6r2bD9S6iIkIGecdnA9VK3OvbaElwO5S5KgFf5VilYdSxbhXy7E7gawzHnRv9Yvqwbd6FxiULA1nZCR4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B35RqipkNxOcSMOjW13eXQn+/e00NZgRouRifmzPWRM=;
 b=KCMi7H8vE7n3uRfTmdvwL68+5ztB927oeifmucrFIuUsOKtPElp91PM4lsFoGmg1m8E6ey7JjeulvJZxuAlzEeolkTuc9C34qkLGFHmsmiLWnAo9muZpnZRqoGkgULPuhLX0GXnbYwgO/6J0LahtuZ1b0lAZiaseIDbfVBeYNW+5Wul6mXoBgoBfUP36X9P3FgCl7Zhhmhu9DMMpCupGDntdeFmYrtkWTobgX88c2ozBUXbUNHCSrADHCxEL6c+xExp8NkY5OBETOMHy/KHBW0ZbR9HmGBsmTz0SzFu/O3dv3jIkDo2PgFskWzbeLgn9ApkuGZZ4feRFgsna4BDNnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B35RqipkNxOcSMOjW13eXQn+/e00NZgRouRifmzPWRM=;
 b=BbvbeQ2PTYdf70zKN8TyOHOWg7TdJmIzEp+q6Avp0esv5Ln76mCl3M+3PSseaOITOxzEODe48FwV/DjEUfm3bo0xJd81B95JOBWZ8RkC0dR4QVzNhZOrUSxMU1bufkQGBy8waY8xN9Y6SdPhLTg9vaFC/C6B4FW8SmYr5fNC2/RRD94gkwhagVTAwGtvTrx55BvWvY3BdxN3s+TcumtSrS0SaDzVSuj99/Q0vXlK7fTpN43hNcNUCPzLpWkA+W1si6V58vVDItwxJss451P37RhminJFNWrk/Icv47AFrnV45x+mZDB49HaE68qvjJr6C9Wz1fPWQ8AqSDJT3afm5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LV8PR12MB9666.namprd12.prod.outlook.com (2603:10b6:408:296::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Mon, 18 May
 2026 14:53:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:53:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:53:08 +0900
Message-Id: <DILVZDQYPRI5.7R2EI8IV2DJL@nvidia.com>
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
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-11-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0328.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LV8PR12MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: a003a369-5291-46c9-fb7a-08deb4ed2eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	dqFJvmGBMau4zhMJbfYQj8stS9jkUnmBXJrNZVmPp8b/lxarmU40LAW4XDUo4IanTTayQuEc9nOHa1BnEaTKfZi5oWIIDRcn3GEC3pBPADhDXiZJscVR2VBSFS3RzkzWqW7pwqFhdLL2HcgVxRRwDMrsK8u1SczQn0UjRuKkZERhNCWvbmrlfHD9J5DHYHrNJRugGudVgH6+z5O7A/zh+CtEyyyDHA6g8mmLD4GsbDYCc0xgfeTpbohTbN2l0VQfdPm4qg3A4oaOgjHoZ02SUOXK44sT+rwIdNVJgx5HTzilvGRwtUHTM6Lwfmya8cgSfvnxYO+EzTXivp6rW8zGLkGAxe9cDfipgmvrwzrezLTfIc5H6Gx2ujhsSH3wLgRvRcvojEhC1LR/+yXC31JnbvFjfyL5N0u470l8vP9Ds6ozysACuZhEq+T3bkiYj8qGDR3NpAYcEJa8PaoBiyBYHqui1SCm/cIzQK0vIzMRy/d3ww1RZYolBJnH3+cPjvkIPSeS10jkuemwXxNu8uL7vQSxYhUsjsw/40rqZ81vC6eF4xJvHqc1dYualvy5BJbGyJb92VcurX/3bTpt7bTiPlURRUqlZ3U+74tGNhKCxe0/MTj2ghYAdmIt/6bDAtRz0Dq0hlyubYzmuNSyij4/DgHNRdwJ7nKkL2nCQXCRa2Quh+xlWbdbSOyg7+/x6eLC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTV6a1RXakxsb1JCbnpjRU42Ym9lU3c5TlRZYzdZOGpnbTN4L2pkelptUGp1?=
 =?utf-8?B?N0dYRFRvNFh3cGR5UVYxU1hibHJxTDZoRXdSYXMzMUxqV0RXMzR5TGVsS3ow?=
 =?utf-8?B?SHNyT3kzN3RBckFpeVN3dFlETWlQWWREdGE4eDJKbUJmZmlXa1ppUmJmQmJM?=
 =?utf-8?B?QlZSTStYV0RSSThkTitHM1pVRUJ3V0kyWEF0YVF0dElQNGhMc01XYWprclA2?=
 =?utf-8?B?WGJjYjBhdGNiT2F3emRXS3QvWFFVVEw5NWFBMlBmL0gxb3YzL2YrUGlPcEVJ?=
 =?utf-8?B?ak5xRlRzZFUzcS9pK2ZqbHcwMmZ2QUdaOTE3U1Q1b0NmTTFOcCsrckJ6N1pu?=
 =?utf-8?B?SFZ1cEdoS0cwbEo1emlJYXd0ZVJydndJeDJJSVdHUmFkKzZIRm9xM1RtTVN1?=
 =?utf-8?B?M1FJbld0WSthZGZwWjZqOEY2M0NnajRuaTU3SW1YT1gxVjB0MmgxYklVWm43?=
 =?utf-8?B?M2gxSE9KdTF6OUVDYitvSFI2VDlmVW1qcnFXNW5QTHkwR2lrcUdNSE40d0lS?=
 =?utf-8?B?UHV6eGwzeEJ2TmllZTBFeGlXczdnendFUWd5YjBjaE5VZXBnSXptV3d1OWhK?=
 =?utf-8?B?Z252YnhQWUtYY3hGQTF2dXNaZExXOGpCRVZrSXlPRjhUWmRWSHZUbFo3TnhR?=
 =?utf-8?B?ZGc4Vk9jUk1tYWl0bE8vaVFDL0pVRUVKVVMwTktwaUd5MXFjRi94aWVVMnA1?=
 =?utf-8?B?YVRPSG44OXFLZTRxYjNXUUY2M0hzS29kQisxcll1QmYrMzVSd1dCOFV2Mit4?=
 =?utf-8?B?Z0d0SnBkM2c3MysyQ3kyZ2Y5SDFXYllmYkZuNFZPNzVxeTJoOEVKNllPcS9k?=
 =?utf-8?B?ajlPd0FUNnpEWFh3bGtVOXZna3BUTzIyV3I0Y2RUVytINFRNQUdPZisyT05G?=
 =?utf-8?B?c3YvRUVMQ1FSRDhnWWJ6eWZsWk1VMFFodnhVQzFVekxjQnRoZlR4K3p4dExv?=
 =?utf-8?B?blhCdEhEQ3J4cW5JazUydWQrQTFQSXBlWGs4SzQ1NVpHVnlWUGg2RWFqTVMz?=
 =?utf-8?B?Qkw3KzRuVGxNcG0rUTlXM0NQK3cyS1ZqYTdmUkcrQkFUTTlvcTF6Vm1ya2Mz?=
 =?utf-8?B?ZjlCSWg5VWk5UjdFZXdIRGl1OGFEaEpIK2ZvRTJwVm1NRk1xTWsyS2E4WC8w?=
 =?utf-8?B?MG1QYk43Y1dtaXdubncwcC9kSzBzSFZndlpRU0kzOWJSdlB2YkUzdG5YeWNY?=
 =?utf-8?B?bkRDWk15NkhTYzhMOTN5TnllL1FEZTE0bW00L2xRWldNdnE3dnJ5VnY5YXdO?=
 =?utf-8?B?VlJvRWN0Q1BralNuWTJDNHhmejR5cU1kdS9EbU1vUGJTSjhhc2g5ZzhvdkFh?=
 =?utf-8?B?YlFnOFdZKytrUmtZYjVEQ2RSRlVqc05URnBycUFoMEM0eFVDSC9sQUhjNDFF?=
 =?utf-8?B?RjJrU0UvMXFhbTdvVXhtdWZBZ3MrN1RTMFViTndrOVhLMWcyR28xWmpXcEQz?=
 =?utf-8?B?WDVhZUNzS2ZLV2JLOVFlWEpmL1oxMUE3ME1nQ3dheUx5MWZ4Y0gxQlY4Vk1X?=
 =?utf-8?B?RWVraGdiZ2tqdUM3alBueUVjOGppeWdwZ2g0RWxWa0pJVW50YjE3RkVsQVV0?=
 =?utf-8?B?Q1cyL3hlVGpzdVhiNGJOcm5DeEJLME9KODVGbmt4OTVkSlIrSFlwL29EQ0ti?=
 =?utf-8?B?SXNTRzhDaTFmREhleHNraFVKanYxRW9QYk81RXlTQ3l4RWM3aXVMZ0xnS3RD?=
 =?utf-8?B?dWVoUTZyTE5ETnVzME5tTUx3VkRjd1hpRnJ3enNPbHBoRzVXdks2NitaOElz?=
 =?utf-8?B?eC9tdURhTkkxcXFWV2szRHdNWUdGNFdpUnpLYnB3RyttWWdDZWxZSVVOZTZa?=
 =?utf-8?B?blVwcmVCVTFxd1gwMXdOSy9xa3VnRGc3RGd6VWt1WDJYaFVQLyt6QmFabzZa?=
 =?utf-8?B?WUI5YmJ2a3pGUUNxMlJiRk9UbVVUUFhBdW1ON09aNzR4NG52OGtpbTJrT0F1?=
 =?utf-8?B?T1FyWjVueXJuUUpJTXJ0Lzd3YW9rUSs5RjdWMzE2TENRSFFZNzQ1Uk1jS1FG?=
 =?utf-8?B?NlRhNGgzazZXZUJzeFZjdnJnTEVpWlRscUlaQkpGa3hoenY4L1IzU3c4Qmpq?=
 =?utf-8?B?TmFHdmdLZjlQU2pQbmZNaWxNR1pUQzQ2QTcyNW5rWS9hV1BualJ4UkFoRVhK?=
 =?utf-8?B?TE1UUHY0NHl4NUR6aFV0YzF1d2lsRlR2Yk05TXVRT1VRYVBlOTI4VFlGWHZS?=
 =?utf-8?B?anB0eWFQTTl1OXZVR2pNTVlxQkZuZmUyQmRXYkx6a2V2azg4OStXYXNEemNt?=
 =?utf-8?B?Qkpyc1ZBZHJuSDNjUjViZjJUVnN2TVNQTGxlSUNwUyt0TTdZeFdkRXhrR0Zp?=
 =?utf-8?B?T0tnS2ZlemNrNnQ2YTlZRWw5TTExZlcwaTRJTVVHWjhPaTIzekg2YW9QRzZT?=
 =?utf-8?Q?1wFuMtpDkOeIEks51a5Ps8dql6zf6P3MxYlGUAebDf0oh?=
X-MS-Exchange-AntiSpam-MessageData-1: h4f3lCmQoP6CYg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a003a369-5291-46c9-fb7a-08deb4ed2eff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:53:12.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JR1FWSORmYcRHVlV6jl8KzNKW6l9AiI25uhBi8bqdw292NaMHv2HaPN9y37ZGkEs0bqmSyRxEJhPX/0K8t5PxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9666
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8964-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7BBF756F6FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Add a 'bound lifetime to the associated Data, changing type Data to type
> Data<'bound>.
>
> This allows the driver's bus device private data to capture the device /
> driver bound lifetime; device resources can be stored directly by
> reference rather than requiring Devres.
>
> The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
> on the methods themselves; avoiding a global lifetime on the trait impl.
>
> Existing drivers set type Data<'bound> =3D Self, preserving the current
> behavior.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

