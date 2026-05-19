Return-Path: <linux-pwm+bounces-9002-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Na5+H+tMDGqWeAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9002-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:43:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CB57DE2E
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EF2C303D572
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEE54963C2;
	Tue, 19 May 2026 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="vhXGq64S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021106.outbound.protection.outlook.com [52.101.100.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387549551E;
	Tue, 19 May 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189842; cv=fail; b=NtQ3YcVf9LozO0XfAAfqDVXIQhFhnLQPgwQte5MlFN24QBMvqGeDHMjmeKGixabEe2AKD4UdGInSXcx089YwrMrZtPbXxXo5SNeoVAMonUo9PZ9tWZ4YyC/W8ZfzOm06fa5EG19gVJXBzWvPf+NsPd7w9n+CF78Jho7Pb/S31zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189842; c=relaxed/simple;
	bh=NAXiSn9G4QRWfI9ZHnb0Qj9zyYl55PmmjmBnn0w/e8E=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=GXp5JAuJBeP5jLWQXjpShjucVrhUT2ywpGWqNtaMfxN7W+ABgCq7yH3dxmHWY/NHzvQ5lleCWD9mtk+qb/lQIboyh+zZeTvLId0sHnp2xZCC35hMcSIJ+cQSCcp7pkXEcVLwjnabfu2Jw5fFc1kGXl52Zocs4ZNa1OI1IRrwMZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vhXGq64S; arc=fail smtp.client-ip=52.101.100.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikX7xW1zp8BzTrwM6AQIvgvUXsZimRAk32KDLXafpPg94Ruvczg8Os1ZereWbL1oGN7uF6kC1PR6OIfWSXNd3a/LQfTk82GPtzOab3MN7QkBTDU9jli8/Urxbydh20FsLrUf/CfdWGmxzTbcYRHh8uQivKdmju7eITvva/jNwrlSctkSi8rZJzmTAcgJifVkQmgjD5b4ZZcmgepqmHg5ga9NZVXEKaoGhkkUDyoZEifMdzp5RWTwo1Dhky07uq2VEDy2UE68Lm/0cBCQDTJ0fAmMY/r9GhW9CHPJgQJ4KP+48NdbZIWQa0t8gSdKkOmJklsoq/5ktCzDQhonn9QyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0ClQbf4EhqKfAyf5q+MFVDd0yVSuqfJWtrgeB1aDLw=;
 b=UbcmCrWRjaXnngqd94mY4mukZ/Lw+WCWqIWccOCydtJbFsNvG9Sk1H7rjX2PTeUSPmmYHGXMk35YiXyxEXEW1Qsy5MbfTGaOG2R/0gm9Zb3sCPJxdtrcQ1EqLKXJfDvBZTPWLm9ZeDi3zKfrDV211BDYsdFBlOj9Y5Kr/0e2h7089iBLCWEB0TeNwWJqL4sK3Zo8tgX5cAR+rpelX7E7np+dKJiG5wKrIC7awkOcVNi46k9OPOqwOmwQiZeV5b6sKRdt2x9oqUJecf9IvdWLz/ZGtpO+cXoqTEwbnvsyJz8YprMJOuuga5PJq1lKAgecSpcU1ewcfLECfW39VZbJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0ClQbf4EhqKfAyf5q+MFVDd0yVSuqfJWtrgeB1aDLw=;
 b=vhXGq64SAdShFGjq3/7aDeDzk5sOZLBDZNpj1MdCDjRjXH8jV/68H6YZdPhPwZ25pT0w47I5ObTFffIdOUXXnh9Raw7ZgnHVWcH3NcjRUp6HvIOX3GyWezdzAZmH+WBQT7jAOVv4GMkux5OfKkzHM9xcmZJ/B144uvn8Qr+mVCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB6402.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 11:23:47 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:23:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:23:46 +0100
Message-Id: <DIMM5MOLDRKQ.2N90XJ1U3US6U@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 16/27] rust: types: add `ForLt` trait for
 higher-ranked lifetime support
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-17-dakr@kernel.org>
 <DIMFBTLBNISD.W92F9DWEFSX@nvidia.com>
In-Reply-To: <DIMFBTLBNISD.W92F9DWEFSX@nvidia.com>
X-ClientProxiedBy: LO4P302CA0011.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: ad7767c7-ebd5-44e3-2bdf-08deb5991812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|22082099003|18002099003|56012099003|921020|4143699003|3023799003;
X-Microsoft-Antispam-Message-Info:
	aJTeiSVH9odlAV89SU2/Twm6X/b/fwUW9obMZLkZxLSdAl2GuCSvZzP8WDWB3WSGloNefbIKYf4zM4YTjd6ATbo1H9giKJ6CeNf0AuaDoiUaFtWnNz/ELeq0gkfEcKIWTXUSfjGDJHPlXrtsW6iKwCMsqZJH1UE9U6BXYGngwiM4TLsEMyj8+2Izcu5hNw+Via7tJKRHwK2+9McoKhtSkshTqufZRakXpMUKre8CYe+QC05dIYcNQBTqrmHV49hHqU8RDRDIt+O7g6ZA1Nt2e3dKaZRCqwEVib4hKrBo2+GgIBtZP3GmP5LToGcD3HgEmuWKqu6icNV3PU5RZi4sGBYY2iiuxtaiQOX8MINBWlv8Ju8UIScPbELlKKqiMj2wqyx8vhHdAX+HtjfO9zVvmXOm0Y97vp2e6Eb2VvLyBYkAWklkgEkLx6c7UUPAmP943n/chshdXm06SxcxGRtZJSjXecx0Qtmiw332S4/6y6H7Q1c+PMs35D7Xk93c6Ci6M4tdvjfkDAkjE9hNm17Wg8Y7Nu3WenujDVR26kO1Q58C1m3znj4cRxwj5e82xubBYnTU4QxLJ/nrvE9La7OEE+XkNZYk6URgLj6WbrqhRa7MPd4a7AORGThdtt5xgzzpgdCdkI0ywRi26uyE1XXtY2FUZFp5q1kO9wjr5NIjokDoM+qR+YeRzjUGX67o2vBJcIvbq3HN37LMnMuy8OZ3KNsoH16jgNqCkM6GO9fXr+s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003)(921020)(4143699003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay92QzRuTmtDMHBKL0RDZTFhUUdtWXlLb051dzNIRzBKYjNPT3hvTzRVUkF1?=
 =?utf-8?B?V3g4SnFCYUs0TGp3d0dMblhnbW1TenErRE9rdWpCMXBtY0RieXBua3pHZUJ6?=
 =?utf-8?B?cWF5dVYrd3VQSkhZSzl6ay9qQUNmQWFxU2EvMktaSXdHd1RNdVhyRTNxUzU5?=
 =?utf-8?B?UzdEdythTGorWDUzb21yc2U4NGp6UnZCS0NnZXg0RUhGalFCTUo3QzVOZ0dX?=
 =?utf-8?B?OCtqaVR0OHdFOHplbEhhd1NkalNVTm9HNHlJNHY2eEdOYnNJa242Tnk1VU9v?=
 =?utf-8?B?Mnh3RmNuZVJjZmIzTzZKYjZrdk16QUFBTVZYL2R2SW5CMnJyYlVXazljTHJi?=
 =?utf-8?B?disxOFIzWWN5czZnUDFDblpoYzNYSFI2Um0xSWY0blZpM1g3SUR1amI1VmRo?=
 =?utf-8?B?bTE0V2V2bGVPOXJ5ZkIzaE5jZnZLN1Nkc0g2Y2oxYmJGUDRrUkVXRmtnUElP?=
 =?utf-8?B?UFlGRXFXZjRPYW0xckhGVUR1U0YyVWlPS2xRY1E5ZU9MY0dCMXhHcE9ybVBX?=
 =?utf-8?B?RXlhYk1OaEtXcWdHd2JiTnBnR1ZHeTdKMzJENjI4R1paNDVNL3lXY0E2bEZH?=
 =?utf-8?B?N29YZlYxb3JINENkNzQ0R0k3emFFbm9rOFYxcjVudHNJQVRRcU1UTGdzOFE2?=
 =?utf-8?B?OFBWWHNHejJrNXprMmo3QldNaFIvZ1ZZVmNnV2pjYkx2QmV0clVZM0tWNTYr?=
 =?utf-8?B?UGMyV2xtUVNTTS80enZkWWs3NkptMXJZZWxZOHJiV0IyVm4xNE5nd0JmV2xl?=
 =?utf-8?B?cUh3dElqNVpuSFFtTjdBTkNpbnBEL2JUYW9PTEt6YUtsSWNHRjJVVE5lZnlv?=
 =?utf-8?B?VjhQOUpURmxXTDI2VnNhQWUxV0dmOXR6aENnUDNEd1J6UWhoazhYeDhVMXdR?=
 =?utf-8?B?SnNha0FOZ0pDTmlxOXUzVnFhSjh3MWk1OUdUcUNFUzgvWW9mZVA2WUJUd09L?=
 =?utf-8?B?RC8xSzlrYkdlTGUrem9qU3VFTzFsQjRVLy8xV0lvNGh1d3hVN0ZiS3BRZjdw?=
 =?utf-8?B?eWFNV3BwMDZlVlBzNkN6aUwvalNkYUo4WkNsWGt5eTlHL3FQL1NuQytKcWgr?=
 =?utf-8?B?dEtUMTgvMG1WVkRweWU0NFJOSWlpZUxTd2pDTHdPSUh6a05Wb2ttVFNKWHZD?=
 =?utf-8?B?Q21UQzBVUmdQNi9IbFpuRFJKRlhyVlZJcDVuTGJDTlNpR3NHZm9XckdIQnpD?=
 =?utf-8?B?RFNmTTRoeUdjVmhZTHlIRkVvb0x0cFJsQlRzcDMzRFhIRDdxdXprQkVYUHNi?=
 =?utf-8?B?N1FGZUs1eWIzdjhxcjlUTUhFTUYxT0E1cDhQQnU4WXUrU3h3ZU1RY2RENlVw?=
 =?utf-8?B?Y0phckFNT0N1N09Zb0djYm1LeFBkWmd3MlBiZzVyOGdkUS9rVTQyWVgyRTUr?=
 =?utf-8?B?dnBubnZGWjdkN2lJdWkxK2tRQzVtRkJsSDBKQ3ZyTzBaa1crRHZpZXc2amFl?=
 =?utf-8?B?cmtXby9wTnliY0lKYUw0akZpMjEwRXBPQnJ2WlAxQW92Um9samxEWlZiM1Ro?=
 =?utf-8?B?RUZRdDlzZk1YcXZIWU0wVG9YYUVTN0g4R0VrTlpzNkZKOXQ5cmxBK3J3bWVk?=
 =?utf-8?B?dTl5WlI5aVl2VmQ3cVZ5cW94U0t5clA0eXBOUWtBV21MU3pSenBJNUFuZDZD?=
 =?utf-8?B?SklRMkZBN2RyZjB3QXZuS1JuSXFnekYybjFvendoQ0hGcGRSM3c2bEptTXhM?=
 =?utf-8?B?NVpacHZURUZOWjlYZ0dtUXBhZEV0aDdnU0NPMUJVZjJnZGMrU2RUSTV1ekhQ?=
 =?utf-8?B?OHE1M0pGME4xTG9FT1EvZDhsbmQzbmp3UDBOcldZTVlldmxiRFR0REE2WkJy?=
 =?utf-8?B?L0hjNEwyYjMrZjJ4Y3BHdmQyYWtGK3FMeE5scnZtdWU5b3VoZ2JtZmgwOTF1?=
 =?utf-8?B?U0QydzFsVWErdUc3ekxiVnVFV3VTM0x6ZnZva0dnclZWRytRNWI3aG5Na2RS?=
 =?utf-8?B?UEFUNXdjV29Mck9iK3FrYkYwOXI0VjRVMDNzdCswY2FoWVJVQ1VhWlFZU0Ri?=
 =?utf-8?B?aDd5NHA1SkNLRnV6aWJYN3VHTzh6K1k4cll4Rmk5dlRUMHNVS0k3QStTaEFv?=
 =?utf-8?B?dHREek1oVVpMU1AreitqU0FUZy9GbnpSV2lYMU5MRktnZE5wbWQ5U1BrY2k4?=
 =?utf-8?B?cUNOMzU0S2JxZzFDOUZqd09xa2lydmxiWUROQ1ZQam0zL0o0TURQREpYWjl0?=
 =?utf-8?B?aFRKcGJ4aDcvOUxoaCszNlp6UGVUUHFYTE1Ja1AzVGhHN0Rqbk11cUtXaVBB?=
 =?utf-8?B?MjVGNHNyMStzM0VJMHN1NnJwZTdHbHg0RVR1SndGaUcyaFVjYVV4dFlzYkp0?=
 =?utf-8?B?R0tOeGk0S2thbTNDZ3AwUVZjZ3YxK0ZqSFNzT0I5TFRmQjdLRnc2Zz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7767c7-ebd5-44e3-2bdf-08deb5991812
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:23:47.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YD+gPXS7nmqVqnCJxqifjwTFynG4pHoj3/nkJJV/lK370ht/pZWzGap2fCjmXaDZAG2zJoa20sLDedBI6kh94A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6402
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9002-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,linuxfoundation.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,docs.rs:url]
X-Rspamd-Queue-Id: 060CB57DE2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 7:02 AM BST, Eliot Courtney wrote:
> On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
>> From: Gary Guo <gary@garyguo.net>
>>
>> There are a few cases, e.g. when dealing with data referencing each othe=
r,
>> one might want to write code that are generic over lifetimes. For exampl=
e,
>> if you want take a function that takes `&'a Foo` and gives `Bar<'a>`, yo=
u
>> can write:
>>
>>     f: impl for<'a> FnOnce(&'a Foo) -> Bar<'a>,
>>
>> However, it becomes tricky when you want that function to not have a fix=
ed
>> `Bar`, but have it be generic again. In this case, one needs something t=
hat
>> is generic over types that are themselves generic over lifetimes.
>>
>> `ForLt` provides such support. It provides a trait `ForLt` which describ=
es
>> a type generic over lifetime. One may use `ForLt::Of<'a>` to get an
>> instance of a type for a specific lifetime.
>>
>> For the case of cross referencing, one would almost always want the
>> lifetime to be covariant. Therefore this is also made a requirement for =
the
>> `ForLt` trait, so functions with `ForLt` trait bound can assume covarian=
ce.
>>
>> A macro `ForLt!()` is provided to be able to obtain a type that implemen=
ts
>> `ForLt`. For example, `ForLt!(for<'a> Bar<'a>)` would yield a type that
>> `<TheType as ForLt>::Of<'a>` is `Bar<'a>`. This also works with lifetime
>> elision, e.g. `ForLt!(Bar<'_>)` or for types without lifetime at all, e.=
g.
>> `ForLt!(u32)`.
>>
>> The API design draws inspiration from the higher-kinded-types [1] crate,
>> however different design decision has been taken (e.g. covariance
>> requirement) and the implementation is independent.
>>
>> License headers use "Apache-2.0 OR MIT" because I anticipate this to be
>> used in pin-init crate too which is licensed as such.
>>
>> Link: https://docs.rs/higher-kinded-types/ [1]
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>
>> +trait TypeExt {
>> +    fn expand_elided_lifetime(&self, explicit_lt: &Lifetime) -> Type;
>> +    fn replace_lifetime(&self, src: &Lifetime, dst: &Lifetime) -> Type;
>> +    fn has_lifetime(&self, lt: &Lifetime) -> bool;
>> +}
>> +
>> +impl TypeExt for Type {
>> +    fn expand_elided_lifetime(&self, explicit_lt: &Lifetime) -> Type {
>> +        struct ElidedLifetimeExpander<'a>(&'a Lifetime);
>> +
>> +        impl VisitMut for ElidedLifetimeExpander<'_> {
>> +            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
>> +                // Expand explicit `'_`
>> +                if lifetime.ident =3D=3D "_" {
>> +                    *lifetime =3D self.0.clone();
>> +                }
>> +            }
>> +
>> +            fn visit_type_reference_mut(&mut self, reference: &mut syn:=
:TypeReference) {
>> +                syn::visit_mut::visit_type_reference_mut(self, referenc=
e);
>> +
>> +                if reference.lifetime.is_none() {
>> +                    reference.lifetime =3D Some(self.0.clone());
>> +                }
>> +            }
>> +        }
>> +
>> +        let mut ret =3D self.clone();
>> +        ElidedLifetimeExpander(explicit_lt).visit_type_mut(&mut ret);
>> +        ret
>> +    }
>> +
>> +    fn replace_lifetime(&self, src: &Lifetime, dst: &Lifetime) -> Type =
{
>> +        struct LifetimeReplacer<'a>(&'a Lifetime, &'a Lifetime);
>> +
>> +        impl VisitMut for LifetimeReplacer<'_> {
>> +            fn visit_lifetime_mut(&mut self, lifetime: &mut Lifetime) {
>> +                if lifetime.ident =3D=3D self.0.ident {
>> +                    *lifetime =3D self.1.clone();
>> +                }
>> +            }
>> +        }
>> +
>> +        let mut ret =3D self.clone();
>> +        LifetimeReplacer(src, dst).visit_type_mut(&mut ret);
>> +        ret
>> +    }
>> +
>> +    fn has_lifetime(&self, lt: &Lifetime) -> bool {
>> +        struct HasLifetime<'a>(&'a Lifetime, bool);
>> +
>> +        impl Visit<'_> for HasLifetime<'_> {
>> +            fn visit_lifetime(&mut self, lifetime: &Lifetime) {
>> +                if lifetime.ident =3D=3D self.0.ident {
>> +                    self.1 =3D true;
>> +                }
>> +            }
>> +        }
>> +
>> +        let mut visitor =3D HasLifetime(lt, false);
>> +        visitor.visit_type(self);
>> +        visitor.1
>> +    }
>> +}
>> +
>> +struct Prover<'a>(&'a Lifetime, Vec<&'a Type>);
>> +
>> +impl<'a> Prover<'a> {
>> +    /// Prove that `ty` is covariant over `'lt`.
>> +    ///
>> +    /// This also needs to prove that it'll be wellformed for any insta=
nce of `'lt`.
>> +    /// It can be assumed that `ty` will be wellformed if `'lt` is subs=
tituted to `'static`.
>> +    fn prove(&mut self, ty: &'a Type) {
>> +        match ty {
>> +            Type::Paren(ty) =3D> self.prove(&ty.elem),
>> +            Type::Group(ty) =3D> self.prove(&ty.elem),
>> +
>> +            // No lifetime involved
>> +            Type::Never(_) =3D> {}
>> +
>> +            // `[T; N]` and `[T]` is covariant over `T`.
>> +            Type::Array(ty) =3D> self.prove(&ty.elem),
>> +            Type::Slice(ty) =3D> self.prove(&ty.elem),
>> +
>> +            Type::Tuple(ty) =3D> {
>> +                for elem in &ty.elems {
>> +                    self.prove(elem);
>> +                }
>> +            }
>> +
>> +            // `*const T` is covariant over `T`
>> +            Type::Ptr(ty) if ty.const_token.is_some() =3D> self.prove(&=
ty.elem),
>> +
>> +            // `&T` is covariant over `T` and lifetime.
>> +            //
>> +            // Note that if we encounter `&'other_lt T`, then we still =
need to make sure the type
>> +            // is wellformed if `T` involves `&'lt`, so we defer to the=
 compiler.
>> +            //
>> +            // This is to block cases like `ForLt!(for<'a> &'static &'a=
 u32)`, as the presence of
>> +            // the type implies `'a: 'static` but this is unsound.
>> +            Type::Reference(ty)
>> +                if ty.mutability.is_none() && ty.lifetime.as_ref() =3D=
=3D Some(self.0) =3D>
>> +            {
>> +                self.prove(&ty.elem)
>> +            }
>> +
>> +            // `&[mut] T` is covariant over lifetime.
>> +            // In case we have `&[mut] NoLifetime`, we don't need to do=
 additional checks.
>> +            Type::Reference(ty) if !ty.elem.has_lifetime(self.0) =3D> (=
),
>> +
>> +            // No mention of lifetime at all, no need to perform compil=
er check.
>> +            ty if !ty.has_lifetime(self.0) =3D> (),
>
> This treats macros as not having a lifetime, but it allows this which is
> not covariant for 'a IIUC:

Good catch. I shall require treat macro as having lifetimes. I thought abou=
t
this case when implementing self-referential lifetime in pin-init but didn'=
t
remember to retrospectively apply it here.

>
> ```
> trait Trait {}
>
> macro_rules! asdf {
>   () =3D> { dyn Trait };
> }
>
> type NotCovariant =3D ForLt!(for<'a> &'a mut asdf!());
> ```
>
> And you can get rid of the macro too:
>
> ```
> type NotCovariant =3D ForLt!(for<'a> &'a mut dyn Trait);
> ```
>
> These are not covariant because dyn Trait has an elided +'a lifetime.
>
> I feel that the syntactic checking is kinda difficult to get right since
> it would need to handle all ways lifetimes can be elided now and in the
> future.
>
> Would it be that bad to always emit the proofs?

The proofs are items inside a constant block, and thus they cannot refer to
generic parameters at all. Therefore, omitting proofs are important to make=
 the
macro work for obvious cases inside generic context. One use case is

impl<T> Foo<T> {
    /* use ForLt!(T) here */
}

Best,
Gary


