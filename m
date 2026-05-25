Return-Path: <linux-pwm+bounces-9111-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFBTBGc1FGpuKwcAu9opvQ
	(envelope-from <linux-pwm+bounces-9111-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:41:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BD5CA109
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4399430067A5
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C7837FF53;
	Mon, 25 May 2026 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="u2YRkimN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020096.outbound.protection.outlook.com [52.101.195.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0419316189;
	Mon, 25 May 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779709265; cv=fail; b=OL9i/A2Zhrt4clxZqv3ZlLdmp9s9l//sl0PS4DRiX5WQUWaaB622qYPagHYlZUFz6+urGXjiKiCy4DJYlcs/w1VGIz79ParZx/IwUEAL1vTYRwQq4bjT5lW/3WT7t0Y3HxEPl0UAHz8X79KyuKFc+p0ugeCAfGOXjAfgc9rEa/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779709265; c=relaxed/simple;
	bh=IZmNysEIzUlUoxzCxVfOprvtvT9nWrU1YcnQ+IK/Mwo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bgsGMDClCVkB+oSBNnd7GbT8HsJJen4NoVFBzau6vx/vM2rjHq/rKs6IGAz5VHw/7uNqJiQY396aHqNcQ2ujAdTwZGIkJgazL1KACXrJT6Qm1nJSlAZQwmG64grj1aUEwpSmWJZIciVKCBBTOX/EriAnjWEqMyjVY0EXeCpyGsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=u2YRkimN; arc=fail smtp.client-ip=52.101.195.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bTp0nky0BdXG7XXnHgly6tgxN/x34E7IVfVpzkFnFpQfUFujaniuJD/yMoBxP2UrPQw61OW6aCkyoSLcZ+ryrY1iuZ9jlisSJNu2Oza1hrPx4ch/Sfslm2dfAnwlMZLlKsuqfnQ7dZny7FkhX6lsHVwrZtq5MAzbf9XDppi4OF6MeHS3WVVqUBpQDWvXh4ENjYdv5ahAnsCrGkpVIpwRvN4tO4m94FqKhmzXE/hK7EAdmxyTdvGFXN9AdFnrIfTtPtkmerxo4hz5iS/eCR6PCJUO+0/txpjCxzp8bzW5QwhVXWN1aMYrH3riQZ33bEMFTyDhpOPtDfz8cWIdBvaDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niH42kPo8V+ZKSKgXcEXO9NdlI/ejaxZzubP/k3ZbmA=;
 b=EXBr/kGwguDHfXVjYL3vmgs9ds4V2ki0Gewd5WOqE5msaH/VkAzFD3uRFu3GTvH2iCe471ojETK6NyO0keZbSLCl+AhbCdIv0wdzPGWZ7TWgnPylasrUcUfTeImphXvcCrtEd48+gZzhZX1266r7cb4YmJ2MJLmcn3+oFpRj9Hzy8Bfw9op7HaDF41EDtvIQq5wfvX87vnwbu8KjG9OL9gsX33cEaMco/sefI8j9kZQCQThWzHjKqjw/qkIFIwkC9X1b5sy1dEnYr5UCmNfFKrXdggnHvyRgzYmrzuc1LmZTpdpvI0xkDGivyDJLE1hzirFmj0RGLukCUxBLqPrjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niH42kPo8V+ZKSKgXcEXO9NdlI/ejaxZzubP/k3ZbmA=;
 b=u2YRkimNrZlfcHS0hxFrXZKXDYyHbAqxps5YDCI9HvHczMaJXV4u548JiDzUb+8quZdHlfyY93jHyzNpvNLsXtDJ8UD49jggjGub2P5z1kWzLD/IEriR1VBTjcxFGIqP0wB1ngMoEKonjjg8A2llql5uuvDLPqGa3S9ixVmcJnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO6P265MB7083.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 11:40:59 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 11:40:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 12:40:58 +0100
Message-Id: <DIRQA2JNXAHY.2TVOL7GYSHM3V@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 17/27] rust: pci: make Bar lifetime-parameterized
From: "Gary Guo" <gary@garyguo.net>
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
X-Mailer: aerc 0.21.0
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-18-dakr@kernel.org>
 <DIRHA02BRA92.32YSMYYL2QBIG@nvidia.com>
In-Reply-To: <DIRHA02BRA92.32YSMYYL2QBIG@nvidia.com>
X-ClientProxiedBy: LO4P123CA0045.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO6P265MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aad0b3d-38d4-4114-5c1d-08deba527dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020|4143699003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xzXe5SQxPYo8OgfrIPIEiKj/9Myg34LnunvXoPHxYyUCnWXYSMB4j1fxzZiGScsZTa/xunPpcnDYBNZHzhQCYUr5Ae9K3zgGbbHuYcPSsqXoXadqfrH+0wKBAAFOtuaN9g5hzuzCx6bkeEtyXhOEyR/JEGT40SFPAONRf6lKUj3MxhZFZULrcCSZb+O/Yv0F/T7Tl3wguSK9HBhFszxXxx7gqwuUuww1a/RwwwD6fmz/hACi/sA5PZD+LzEsrFxempbq8kzhWrXci48CQmh5dOGf7hUUGhJrIWiUJ+wbfa1YSF9P/79FSiV4spYIP8zFMGT+zH/xm8jNacfT/NY/fDvHMvvAhGUjk3VkRkfMGPi1uahPrcn70gSTkXVOok3UzaAKqWeoCKdK6859cd4D12fWuXo47z8NC+VycMIZ5voHIsiSrb/Ivgjniapqj3MrmeSgrlqctJuWBYSjRxEPRqaEh9zrKkCRO6X4u5Qq4wIfHHQyVI+og7AVFxnFoqNnWyb+Gmuo5ARBzzRmRcYvtvjbv5LkAEuZzFDhRsarXSLB8LXXIVln6nHCGwc5y15z25QWeniEzFEgStrXyoHmtPE7Nrf1IumerJmqFzRoSA2KXgnSI1wGXBvHSU1LDz6bje3duEQFdrngTog25ThK8DKSBqBZ1wIjSASmELY2y8ow1bp0CKccS+xjTf496a4ZsrkEHFL+04pR426EmYKpuJUVDSVD9FUu0rTjIB45NO0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020)(4143699003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWhDZHM1WnpWTDJWTEFPb3ZYeHdDTENTZ2hMQVJ6ZnRQMUdxZjJpK294M1Jx?=
 =?utf-8?B?bGoxTEtvMnNxZ1R5bVIrQVZWdFlwSkdxQkxwK2F5ZEF4WHVRUGdlb1ZFZy8y?=
 =?utf-8?B?VUtEcDhFQWxhdXRuRlJZdGcrc1huUFBzS2Z6Y1kzOXBSRTFrSmNTdVRVVWt6?=
 =?utf-8?B?eXl4Z0w4QmhDU2JnVm5MWk93clRmcHB5VEFZVHFMYW9zZlV2M3FxdFcveS81?=
 =?utf-8?B?c1hqbGlwbFcrVXkxcFpnTWJBQWdiQzNidTdOcnVVajI3ODlGT3VLN1R1T2xi?=
 =?utf-8?B?VlRKRWFiTUhLcGdOSGpNTUtCckhNVEtaMVNhWmNkdVdpVnZoYUs3OWtBMU4y?=
 =?utf-8?B?WWFrenhNSW54Z240SmlHMlNUY0ZpRkFZQkUwS1dXNXdyeXhnTyt1QVo2MW5N?=
 =?utf-8?B?QXNCTjdQQURWSEQ1SnBCcXR1Z3QvZUFFTEhpQko3Q3JkUWFQSmJGTGNJMDF1?=
 =?utf-8?B?M3pTaFlLUkJrVUJ6MnZyVmhFbGtNL0hLbHEyWk0xTEFIYmhOaWNtUUF0R1FX?=
 =?utf-8?B?aU0yTnlOekdseUxwaEQ4S24ycmJOMHRGMFA4UUVQbEliYkFlYWpJeVNxSEc3?=
 =?utf-8?B?dW5NRWN6WHZiNkJxMUNYWHA0aTE4UDRSTnpodjlTTjVMVTVkRDZGOWxET1BU?=
 =?utf-8?B?dHFzK2JvcUw5eTBjdE1nM2RwSmYycmU4ajIvUzg1d1dYSHhjSm15N3V0d1Rv?=
 =?utf-8?B?WDlBMmV0bXhqbVo2M3pHRldVWGxFNUJyMjVPcFFpOUlHY1kxU2ZtVlJ6eE81?=
 =?utf-8?B?L2RSV3doSzRDWHdkZ25nVGlhalVYWnJnUDdnZ2ZhZnUrTEpmU3hUaU15MUNp?=
 =?utf-8?B?cy9FSFJkT3cxOFgvL0NETUQrT0ZrSC9Ha2Y0V0hINEs4SmhRY3orL1RpM0xz?=
 =?utf-8?B?a2w2Nis3TzBSRDhFTHMvZWViWnBOWE16ZnZxR1IxWHMybm5EVU91akViTkNs?=
 =?utf-8?B?VXlvckRzbjFaUVI1NExFbkt5TWFVUkh2ZjZJZ0p1bXhtQ0M5Z0xJL0dWRThx?=
 =?utf-8?B?aTQwbURiWmVYZGtzOTF1YUVuU3d6YkZPM3FOQ1NEOUMveStjcmtnRlBlZ3E0?=
 =?utf-8?B?YytkZUo0aFkvU0hrclNLcjVOSDd6Q3E3K1I0U3V4VVY2dUExNkpMQTQyVU1w?=
 =?utf-8?B?cnMzalo0dUkvZ3R0L3g1MkhvUlhxWnFCZ1VqR3M4dDljRDJJV0ZtSGg5SXpw?=
 =?utf-8?B?RFI0QmM4ZGNqYkhXSTJYaFJxQjY3a0thUFdKb2pBRE00Rk1haC9qUk02VkM5?=
 =?utf-8?B?Tmcrc0IvS1N3ZStqNkNldjFzOWRyb3ZMc1dwdDlyRTZxQnpaWklobEpPTlhi?=
 =?utf-8?B?N1V0WVI4bDREVnZ3aStkcFNlY1RTbG5kSUNDTHlqR2NVQTBMbGNmdU5jdDAw?=
 =?utf-8?B?NHhKSm16WWkrS1FXcEFINE1MSzdLeVpvSzRoQVAvU2lrVzVWL2xKZkVnRWhw?=
 =?utf-8?B?eHRZQXFxQnF6N1loM0lkR2hTTnBXS1k4Rmo5eFpnN2ZOazEwOG8yd0dycUQ0?=
 =?utf-8?B?ci9yRnFRbXpIVFdkbEZ3VlVsN0l5Rjk3M1VnbVFGN3pyZmhML1ZDU29oaFRk?=
 =?utf-8?B?SWh1Ym84eitacWo4SmNFZzNzOWZtYk5oaVNXYnNHZVZWTkh1R3ZJcXNaYjA2?=
 =?utf-8?B?Rjhqam03VDZyR0xROG9JR0RuenV2anhXUWFuVDUwU2VSQmd2bDA0aTZyR0R2?=
 =?utf-8?B?K2x6Rkk0RExGTEdhYTJKYUt2R1lINWg2K09Va3lJS2Q5N2pkZE5UVXVjSitM?=
 =?utf-8?B?elBBUGlUMUQrK1VPSlBWRmcvVHZXeEFoUnEydGt0ZW1RamxMYzFaSGpja050?=
 =?utf-8?B?YkxwdDlGNmVldFI4OUNXMzRnYmcvQ2xPS3FuYmVXdUVKVEp3dHcvT1JoQ2N2?=
 =?utf-8?B?WGZ4dW9BNjAvVVd3K09YV013WStwQnM1ZG5lK0lTZVVrNm1SbTZ6enZjWHZi?=
 =?utf-8?B?Y0NWQjdwQnhjMUdGNVRXbDhwYTJKNEl3OHBETWdMV3YySXNPME44ampUTkty?=
 =?utf-8?B?c0hvNFRHWVdvZzNvS2JKRmg0R1pxZ1hlZlYyVDNtalhwYUN0VU9saUVIQkcy?=
 =?utf-8?B?ZitSNWdzWUN6RWFpdW1Zei9xeldLQ2pUekFIdkhXYk83dk82RngzcElxa2dj?=
 =?utf-8?B?S1lyNHJMQmtYNVhHNUwva2QxSXNNVWo5YkpzN211c2UzRHRneSttcWhXWVk0?=
 =?utf-8?B?OTdJQjdKbjk4VTRvZ1pnSC9aNkFoRFBrZC93VmVOcTJqVVVDMWhWTHZLNEph?=
 =?utf-8?B?czNFTTlna0dsQnBzVngzMzRpbVp5YUlsSTFxTm42Vjg0dElIeVFaUmlIaTRP?=
 =?utf-8?B?NnNRZ0dnMjA3MUlHM0c3S0dwK2M1eDFkdnVrTzNtSnc2TGRiMkxkQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aad0b3d-38d4-4114-5c1d-08deba527dc1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:40:59.3986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wWCjXEolfar1Tr2tkJq3+ndMZAOnKimYv4iMq/+jKeZZCdLuJUT9nV7Tq+nAHN7pTXwg67xLF5r47Toun7oNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7083
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9111-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,kernel.org,linuxfoundation.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A36BD5CA109
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 5:37 AM BST, Eliot Courtney wrote:
> On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
>> Convert pci::Bar<SIZE> to pci::Bar<'a, SIZE>, storing &'a Device<Bound>
>> to tie the BAR mapping lifetime to the device.
>>
>> iomap_region_sized() now returns Result<Bar<'a, SIZE>> directly instead
>> of impl PinInit<Devres<Bar<SIZE>>, Error>.
>>
>> Add Bar::into_devres() to consume the bar and register it as a
>> device-managed resource, returning Devres<Bar<'static, SIZE>>. The
>> lifetime is erased to 'static because Devres guarantees the bar does not
>> actually outlive the device -- access is revoked on unbind.
>>
>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> ---
>>  drivers/gpu/nova-core/driver.rs |  7 +++--
>>  rust/kernel/devres.rs           |  2 +-
>>  rust/kernel/pci/io.rs           | 50 ++++++++++++++++++---------------
>>  samples/rust/rust_driver_pci.rs |  5 ++--
>>  4 files changed, 35 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/dri=
ver.rs
>> index 6ad1a856694c..7dbec0470c26 100644
>> --- a/drivers/gpu/nova-core/driver.rs
>> +++ b/drivers/gpu/nova-core/driver.rs
>> @@ -45,7 +45,7 @@ pub(crate) struct NovaCore {
>>  // DMA addresses. These systems should be quite rare.
>>  const GPU_DMA_BITS: u32 =3D 47;
>> =20
>> -pub(crate) type Bar0 =3D pci::Bar<BAR0_SIZE>;
>> +pub(crate) type Bar0 =3D pci::Bar<'static, BAR0_SIZE>;
>> =20
>>  kernel::pci_device_table!(
>>      PCI_TABLE,
>> @@ -92,8 +92,9 @@ fn probe<'bound>(
>>              // other threads of execution.
>>              unsafe { pdev.dma_set_mask_and_coherent(DmaMask::new::<GPU_=
DMA_BITS>())? };
>> =20
>> -            let bar =3D Arc::pin_init(
>> -                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar=
0"),
>> +            let bar =3D Arc::new(
>> +                pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar=
0")?
>> +                    .into_devres()?,
>>                  GFP_KERNEL,
>>              )?;
>> =20
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index fd4633f977f6..82cbd8b969fb 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -304,7 +304,7 @@ pub fn device(&self) -> &Device {
>>      ///     pci, //
>>      /// };
>>      ///
>> -    /// fn from_core(dev: &pci::Device<Core<'_>>, devres: Devres<pci::B=
ar<0x4>>) -> Result {
>> +    /// fn from_core(dev: &pci::Device<Core<'_>>, devres: Devres<pci::B=
ar<'_, 0x4>>) -> Result {
>>      ///     let bar =3D devres.access(dev.as_ref())?;
>>      ///
>>      ///     let _ =3D bar.read32(0x0);
>> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
>> index ae78676c927f..6116c55412bc 100644
>> --- a/rust/kernel/pci/io.rs
>> +++ b/rust/kernel/pci/io.rs
>> @@ -14,8 +14,7 @@
>>          Mmio,
>>          MmioRaw, //
>>      },
>> -    prelude::*,
>> -    sync::aref::ARef, //
>> +    prelude::*, //
>>  };
>>  use core::{
>>      marker::PhantomData,
>> @@ -146,14 +145,14 @@ impl<'a, S: ConfigSpaceKind> IoKnownSize for Confi=
gSpace<'a, S> {
>>  ///
>>  /// `Bar` always holds an `IoRaw` instance that holds a valid pointer t=
o the start of the I/O
>>  /// memory mapped PCI BAR and its size.
>> -pub struct Bar<const SIZE: usize =3D 0> {
>> -    pdev: ARef<Device>,
>> +pub struct Bar<'a, const SIZE: usize =3D 0> {
>> +    pdev: &'a Device<device::Bound>,
>>      io: MmioRaw<SIZE>,
>>      num: i32,
>>  }
>> =20
>> -impl<const SIZE: usize> Bar<SIZE> {
>> -    pub(super) fn new(pdev: &Device, num: u32, name: &CStr) -> Result<S=
elf> {
>> +impl<'a, const SIZE: usize> Bar<'a, SIZE> {
>> +    pub(super) fn new(pdev: &'a Device<device::Bound>, num: u32, name: =
&CStr) -> Result<Self> {
>
> I think Sashiko's comment w.r.t. &CStrs in this patch looks accurate
> and they should be 'static or at least 'a ish.

It needs to be `'static` to be leak-safe.

Best,
Gary

