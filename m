Return-Path: <linux-pwm+bounces-9570-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id od+8Ez5jSmrNCAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9570-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:59:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7CE70A2F4
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=sI9nfUxC;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9570-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9570-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B491B300E264
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 13:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC737F8CB;
	Sun,  5 Jul 2026 13:59:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4B3375AB2;
	Sun,  5 Jul 2026 13:59:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259964; cv=fail; b=Rz/CU1Rb1URyuuVBUFE039RpElbmXvhFlByR0NEkzGw7Lu5epQEtkcXMhC0SUI9bgw/Zi5jiqay7WWJu/AGQ4aM2hbueJ0DiH2REyzvy/mDr4ED6jk3LZibSfYrRenVEVLUcUOCd5W3RY4qlN/MC/9mVS5bLy6Ax0ljefvXilEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259964; c=relaxed/simple;
	bh=+B4Yxt1XKBNiE9Vqdo8tTOIp56QhldSX9LgL8rSXl8s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=mGDKl0fx/hYLnHoPRmVzlcF0lrdLu0lx3hyTJyjA4KHLBXodlYIQxV1l7ghmCCl8jVPH5QJt0ajmGorhsgGr5894pm4mK/G8dvPWkqg5WhhsE6ZkPQSFxsd5qriJK3y562SnmSyHszzkFEzMQodDcG76LJPi3o70H88A/cnBeko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sI9nfUxC; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCD2v0vvHeH60KiPBRshfHrYT3ENmiuup6BS0SPCTr5i6j9ZAYMzxhLOWQ5gZIDQU96NXKwimfpsRul06oABBVnFl2vc7/YvMmYGgenTOEmvUePp/IOqmf4hcIEHZ7FPTeOs54sRU8qDkSrBBoxUbyKezITOEWsiIHCdi8kOHSZV2NJ1U2J/de9QrWF94ZFXaRp3bNrrmB7wd5b5bCm41wvnXGs1Ga0pZk+hjF/EbVHLFjhOqNyxN5+mhJDL9b4xhiE7ni/aUayEMj5xjXNqZSx/mO9ixKqfp2GwRR5/uTIB7+iCG6mUUgt3a/6m1xp9RHa/uMCaL7hnM1lzBcYlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R75HnMxaOA1lrDliGKCY8mnUFqWmArxNthpWWwJ3avY=;
 b=Ffcep36ftkIxqW4ReS9yy7Wafg+6lbaj+Xqo9JD58YpWh4Wpo/NEkZTcyfMljc630n0i4oRU/Df9Ii1ifq+CKtdTi2xSuWJCNyWuK3V+8klbRN8PTBvcfWLaOSRNVBbbeo7E540sBMCEpArdlkr5Pd1SaRjWiPnxg5/961eT911TP78Yxx3iSEz9/RG3OUg74ad+/xv3lTAWsfBOmVnRXUVqsb6s2j5Qzg6KB4GIrS4YjWlJZRkgMaSANP52ioP1DTKhugRqXyUFaB114FMYgcQgwxSq3UlcT1SXghz8wcOtaUd6HZbmaX7Eef4B6Whud1UCHDccwTZOGJuylmIkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R75HnMxaOA1lrDliGKCY8mnUFqWmArxNthpWWwJ3avY=;
 b=sI9nfUxCK+ZNzyqxSNdkMJvZ22bq76kKRw97cmRL7Lxxccthu6jpsu1tdimwBPgPc5PMjvMbSpaNRKiGfU/KKYoJBhrpQ1vaPyiMF8CVJc08h+6HxxOZMQ3nCyhJtb0AN7C0w5XClRIQ0EWWaqZtcdxGnoJMLY+v/DFuIwm1fcqlCYBthyTl5/buckwvTb4lt2ur7X0ZADFXv0wJhN4gVCAqhXknAgaJZgiRGUOcqBJrmeK3GrVDtqcd8RO7UZyiB0Y9t5QMHTkVR+J2jkML92JEpmoz6k+kF81uCikbf/i3NKrkYZfRIooQMGqi5vBUvMFCz6y/ofQ/m0LUfH+Jog==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 13:59:18 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Sun, 5 Jul 2026
 13:59:18 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 22:59:15 +0900
Message-Id: <DJQOWA2VOJ3G.2YGSYJGK7HPBJ@nvidia.com>
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
Subject: Re: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
 <DJOLKP1V1IDU.1GWHOHBG9CS7@nvidia.com>
 <DJOXUW6ODKCI.1GLNDU00TDJWU@garyguo.net>
 <DJOYL5QPEM76.1N99BVDVHB8VS@nvidia.com>
 <DJOZFG9XDNYV.1Z0BXKIODDTAF@garyguo.net>
In-Reply-To: <DJOZFG9XDNYV.1Z0BXKIODDTAF@garyguo.net>
X-ClientProxiedBy: TYCP286CA0368.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f708be-5e08-4dfd-c4dd-08deda9d9b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|11063799006|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Paz136p57J8BgruUm2h0yu/lOD4DzsrpvCsiMoo4478Im5gBHCHD+W3nAf1GkEOZNljDHKL4HtRdVuhwKNgnxouPHHPDsnwGNrQm1bUo0qvO71AeV1ugkPFayM3zoO6b9fM7kTPKA3TnmA9yKZiZvfVRZdXIV/cWg6SxIunDkT57Sasc1TCUIzqlbSJzS7OBs8XKy75Xr+GEhCE95MNBpyvaKNeaVluHLTx7tiHpkrN1eguChHXRGGqHNPhHlDM9WfPdvU0DMvUI2U1O2nrj903096u4Cy3B/iOAh4Ab9mKKe/m3Kat/WFK0HVG8bvdvTsx7GyJq1KiL/eKT1+RZrRuLDHEX3hdsugxhDLCJxEwUvK9fT0kf19jy9KVQ9A3ftRqddJY5Cs8qSnPXGnCW5VTACSQRVc9I1R4LoTXyBC00QJmPy8N1bcnn/M3PCN5BDkQ7QhKTjtHC+uUq6wBQdLGaUTr877XeEY9/DZ0lt2cxPBjSgru8l/AVKUBrq45TOZ3q1lAPfsm2cIC4i6BqZI/4bekajA9f0nGYwiGUhCVxLvliZqctjiIXD4evD7pwuuKkvmqidgiPMWkiOydNJNLwXbSTKCzvAddnUo8rJ+jfbF2OllXdBOMjff/vcFcR30cjAn07f540yC41F14ENLHW3iVvG5RChJRPxjkdhro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0JZNXRNbHk3VU01YWZTbHpnT04vL0Z0QjNBaSt3QUJOS00wWm11MkN0OFdj?=
 =?utf-8?B?RXdPdFhGem9oU3hLRzFLeGpwNnQ4cWZheE84Uzg4V3dyVWFLTWlIbHZYZ0h5?=
 =?utf-8?B?eHEzc3VEMmU5QjMvd0R5aVNuZktBbHdpMHVCOWNVWW1qbkV5dVB3Q0hXK1BZ?=
 =?utf-8?B?UnR5U3h0OFZWc2FIb2hrV3N0NUI1WVJDZWNjTEVsbkFoa0xHTUVpUjU5RThU?=
 =?utf-8?B?U3ZrdXZuWHpXWjQxZG5QZTRZTmVuelRKc0kyOUc4SUo1Tm5oc0pQaFUrT293?=
 =?utf-8?B?Uk5NMjZhNjB1eHdTakJQWkxobHhEbVY1SDZIY3B4WlZnaDh0cXppaHZvYWlO?=
 =?utf-8?B?VTJobHRDV09wcjBndFNwNWF6elFBN3IxTzE5OEJaMSttWlVpL1JFeDMzYlox?=
 =?utf-8?B?dVJ0UFlrK25jekFXaEZpZ0xhVkZVK0syaHh2MGZmTTBWWllCVm8wRnZxcDRX?=
 =?utf-8?B?TmF2dEFWK0lWNjRPRElhQzJKMElPR25SeTFyS0FLRXRGZTR3QnRIRmpEV1RQ?=
 =?utf-8?B?d205ODI5OU90ajQvWHJhbEJpYXI2engySVY3WmNvRDc5YlVWRVVaUCtVbGRM?=
 =?utf-8?B?TGdnUGgvU3RLUFVpaHVuZTNnaUdvdWw5OE9sTjZPZG9zNVZOVFg4cjlnUmM3?=
 =?utf-8?B?aGRvWjhTb2liL0w4U3VCdG9qMlBhdXRaYlhHYU1BSFlxcUhTRFpzelRCeW5Y?=
 =?utf-8?B?VVBJRGxIcjVFZ2RPaXpMbWFyTU9HRW82WWY2OWY5eHRQRWpuNThWaFA0aERs?=
 =?utf-8?B?NHRmbGNDV3lzVUNGbVA4UVFJUWNKeXFEQ0xnVUR1QjdwengyZHNoallJc2VZ?=
 =?utf-8?B?ZUlOZjhYQm1UYm12Njhnd2xKaTJpMnBDdDR4Z09ZSC9oc2VTcTZndE5RYUF5?=
 =?utf-8?B?QUZrS3pOR09WcEYyQ0pqdDMwcFNxMzJKZmJTSkVaZ2k3K0kxMmdkbjlvMFJw?=
 =?utf-8?B?SnBUY3FrbUFySW5EbWJsZUx2K202eiszaXpaa3FYWG1QS25XTE1ld2FKYWQ1?=
 =?utf-8?B?ZklHdTgySTVnM2Z1Y2VHVlRKeWdWWnl1V1lmdzk1L01Dcy9xYkhlVlA3VDU2?=
 =?utf-8?B?QVRVSHRqSHVpTmdXOWFEZHY3VVJTNml3WU10Q2oxY1Qvck1YU3U4V2M3eTBG?=
 =?utf-8?B?d1l0bU0vUnl1S3NjaVU4aWpWdU9adE03QVdWbTArZHdwL3hTeDVqWDY2VDIv?=
 =?utf-8?B?WkdrT2VmQzhYbkpiUUk1NThIQU4xVVdiK1VRQXhTWjUrVVVmNmloZmZ1clVZ?=
 =?utf-8?B?V1MvTW9ZNTFVdGVBSzJjUVVVQlNRYTYxLzU3dXNUeUM1dUdLOVI4VTVzd2sw?=
 =?utf-8?B?ZDVsb1ZkV2gxb3dOK2ZYenRPdHJvMEJoRFNrRVRVVXVoMXA1bUFXaE5GWUVx?=
 =?utf-8?B?YTVheFlBelBqK2dQdFE1aEdScDFaWFMzSlphdE5ZT0FMTmFhRjM1N0RNYU5j?=
 =?utf-8?B?VHFEejc1ZzhORklwT2E5djdLdXVZZUJzeUZ0TFV4R2JhQzVzQkQvdmlQYjVB?=
 =?utf-8?B?TFlsaWR0VjRrcnpaRXVNVk9mSmVLNmpvK3NlL2JuUzc2aTV4QVlwdnNBc0hi?=
 =?utf-8?B?WGpWTEU1WDNlc1RQb2M2cUsvcG1jT1ZBc3lqWXRDSG0zNWxheFkrekNpR3Zs?=
 =?utf-8?B?OUtaVFNPYy9qdURiNnllZ08wK2cxekVCaTFJWjc0enREUE5DSW5TbmR0dWg3?=
 =?utf-8?B?NEdMemVmWVJXMkFyQWp5K2cvWXBRSjZTWktWZW5Ia0RNSmoxREgzOFVTYjYr?=
 =?utf-8?B?ci9NbHA3OFZCV1JkOVpiOGNFb1NUeCs3ZU5wRjh1aVk5S3p4Szh6aWVJQWww?=
 =?utf-8?B?UVBNUmV4WkNpcXlWSmVUUG9KZG5nQkp5V0ZUc0dvVjFjdnRlT3ZLd1VDVW1s?=
 =?utf-8?B?YjRLTFhhVWkzbDhYb2lzbEo1SE15SUoxOTJ2bStsYlBneWVucUwxcHI0SVlS?=
 =?utf-8?B?Y05POHkwZ0hVem1sWnFLYmtmaWdBZGhNaG44OEwxYXU0bFJWRkV1NlllTC9N?=
 =?utf-8?B?T0hkRDlsUVIxSzVtZ1dsOFJEaEVramExUGlId1FMcFZWMC9KUjhuU2tOMTRV?=
 =?utf-8?B?aWN2RWF4TnZjWWJJc1RyNHdrZm9qaWtzRzV6V0dSZTdrb0VhRGVlYlp6MXVF?=
 =?utf-8?B?QzhCQjhsNWhFVGVMd1RzVjNuelY3UnlBMXlkMkQ5UkZQYTZjUHBMSDhncWJW?=
 =?utf-8?B?azhCYmZSQUU5b2NyZ2huVDdXUW9xdjc5Mk1rcjJOL0ZWbVZMcVVyYVlyVGtR?=
 =?utf-8?B?RmNiTnpwejB5VmRIN3hhblc1MG5vRHoybXduR3pWc2w2VUZjL0wvdm5xdWpm?=
 =?utf-8?B?K1ZBV2tydUJueCs0cWh3NWlFUDRwSThLTUxzNGl0cG81eHg3Y2RxNVAzUFY5?=
 =?utf-8?Q?BrDTQKitSu/hBMtTvACCoXCfh0vcwkb4neqesHERpHQcz?=
X-MS-Exchange-AntiSpam-MessageData-1: nKxDfUh1nPJoBA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f708be-5e08-4dfd-c4dd-08deda9d9b62
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 13:59:18.7536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ra6qhwu8clS+/Q6k2QxZOCGlsJRAiERb12UHY9tCoE5id3eJtYSbdIXPRznVHVWxZwVeVNr8RnZj0zQJWhQRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9570-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE7CE70A2F4

On Fri Jul 3, 2026 at 10:49 PM JST, Gary Guo wrote:
> On Fri Jul 3, 2026 at 2:09 PM BST, Alexandre Courbot wrote:
>> On Fri Jul 3, 2026 at 9:35 PM JST, Gary Guo wrote:
>>> On Fri Jul 3, 2026 at 3:57 AM BST, Alexandre Courbot wrote:
>>>> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>>>> <...>
>>>>> @@ -309,7 +312,11 @@ pub trait Io {
>>>>>      // Always inline to optimize out error path of `build_assert`.
>>>>>      #[inline(always)]
>>>>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>>>>> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SI=
ZE));
>>>>> +        // We cannot check alignment with `offset_valid` using `self=
.addr()`. So set 0 for it and
>>>>> +        // ensure alignment by checking that the alignment of `U` is=
 smaller or equal to the
>>>>> +        // alignment of `Self::Target`.
>>>>> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Tar=
get::MIN_ALIGN.as_usize());
>>>>
>>>> With `Region::MIN_ALIGN` being `4`, my understanding is that this will
>>>> make `read64` and other infallible 64-bit accessors unusable on untype=
d
>>>> I/O regions?
>>>
>>> That's correct.
>>
>> Isn't that a limitation we may want to eventually address? The fallible
>> accessors are still usable, but it seems arbitrary that the non-fallible
>> ones stop at 32 bits...
>
> It'd probably be solved by having typed regions. 32-bit is the most commo=
n
> alignment for I/O memory, so that's chosen.
>
> None of the existing Rust drivers require 64-bit accessors yet.

Mmm I'd like to see whether we can't make it work for untyped regions as
well, but since we don't have many users (nor do we expect many to come
I guess) this can be a follow-up.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

